Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC4A44EBC4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 18:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbhKLRIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 12:08:05 -0500
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:59089 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235331AbhKLRH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 12:07:59 -0500
Received: from [192.168.1.18] ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id lZz8mTvmc1UGBlZz8mGLcE; Fri, 12 Nov 2021 18:05:07 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 12 Nov 2021 18:05:07 +0100
X-ME-IP: 86.243.171.122
Subject: Re: [PATCH] ipmi: Move remove_work to dedicated workqueue
To:     Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>,
        linux-kernel@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net, minyard@acm.org,
        ioanna.alifieraki@gmail.com
References: <20211112165413.7747-1-ioanna-maria.alifieraki@canonical.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <0bfd847b-c70e-8299-8e75-d9d1491c91fa@wanadoo.fr>
Date:   Fri, 12 Nov 2021 18:05:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211112165413.7747-1-ioanna-maria.alifieraki@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 12/11/2021 à 17:54, Ioanna Alifieraki a écrit :
> Currently when removing an ipmi_user the removal is deferred as a work on
> the system's workqueue. Although this guarantees the free operation will
> occur in non atomic context, it can race with the ipmi_msghandler module
> removal (see [1]) . In case a remove_user work is scheduled for removal
> and shortly after ipmi_msghandler module is removed we can end up in a
> situation where the module is removed fist and when the work is executed
> the system crashes with :
> BUG: unable to handle page fault for address: ffffffffc05c3450
> PF: supervisor instruction fetch in kernel mode
> PF: error_code(0x0010) - not-present page
> because the pages of the module are gone. In cleanup_ipmi() there is no
> easy way to detect if there are any pending works to flush them before
> removing the module. This patch creates a separate workqueue and schedules
> the remove_work works on it. When removing the module the workqueue is
> flushed to avoid the race.
> 
> [1] https://bugs.launchpad.net/bugs/1950666
> 
> Cc: stable@vger.kernel.org
> Fixes: 3b9a907223d7 (ipmi: fix sleep-in-atomic in free_user at cleanup SRCU user->release_barrier)
> Signed-off-by: Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>
> ---
>   drivers/char/ipmi/ipmi_msghandler.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index deed355422f4..9e0ad2ccd3e0 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -191,6 +191,8 @@ struct ipmi_user {
>   	struct work_struct remove_work;
>   };
>   
> +struct workqueue_struct *remove_work_wq;
> +
>   static struct ipmi_user *acquire_ipmi_user(struct ipmi_user *user, int *index)
>   	__acquires(user->release_barrier)
>   {
> @@ -1297,7 +1299,7 @@ static void free_user(struct kref *ref)
>   	struct ipmi_user *user = container_of(ref, struct ipmi_user, refcount);
>   
>   	/* SRCU cleanup must happen in task context. */
> -	schedule_work(&user->remove_work);
> +	queue_work(remove_work_wq, &user->remove_work);
>   }
>   
>   static void _ipmi_destroy_user(struct ipmi_user *user)
> @@ -5383,6 +5385,8 @@ static int ipmi_init_msghandler(void)
>   
>   	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
>   
> +	remove_work_wq = create_singlethread_workqueue("ipmi-msghandler-remove-wq");
> +
>   	initialized = true;
>   
>   out:
> @@ -5408,6 +5412,9 @@ static void __exit cleanup_ipmi(void)
>   	int count;
>   
>   	if (initialized) {
> +		flush_workqueue(remove_work_wq);
> +		destroy_workqueue(remove_work_wq);
> +

Hi,

there is no need to call 'flush_workqueue()' before 'destroy_workqueue()'.
'destroy_workqueue()' already drains the queue before destroying it, so
there is no need to flush it explicitly.

Just my 2c.

CJ

>   		atomic_notifier_chain_unregister(&panic_notifier_list,
>   						 &panic_block);
>   
> 

