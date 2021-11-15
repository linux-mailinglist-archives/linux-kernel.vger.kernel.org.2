Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBBB45076B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 15:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhKOOsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 09:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbhKOOs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 09:48:28 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4479BC061570
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 06:45:29 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id bk22so17056748qkb.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 06:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tdu5IEt0CrhTdO1umI7D6SnTK3BhqQhwxPqQfGD8ylY=;
        b=jClH9vTJfZUwAvEmZtsU3aLIbQdlYSYhpSIj7J0ttcprasUktxW+Ytt5qmC9jmT3f2
         7pSry9zpjI8Hp9ExolPqUhaerOOJde8goOR4/TMWsngrOh0CjZN3aceuf1mr6aOWlLwg
         IGJbeg4Z6oRiusgI2GcWKJvr7SeF/b/EIK0L8jEj3Mb31s1XwHTMWalxBKWCvzwEqBi2
         NrPzCY4mKg9f6tHAZFsjHW515pmpv83uYUH6Ab3cqbfHKp08QFBSZw2kgjIwnRdPe6S6
         1eRYLTS+qzwpDkVXbkSPux//7VPn0ghekFu0vOfX7zkl+vu/VbtcYKX4dbJ5r08wttsU
         SOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=Tdu5IEt0CrhTdO1umI7D6SnTK3BhqQhwxPqQfGD8ylY=;
        b=3AbWt6e9lxPuAsfd5VaEYgLRk5DNazI97a3vHN4/LQ8GxYptcxvaoKn6PKLhX2MAI4
         rXjUSKKTzlhl7OcJhDlDP5Bbhf0FoWFQTYAHVpjqvsQ2hWCdNA4IpKDPZZgYKLr+SY2c
         svV40QnsPhg1WkB6bhzWl+LhrVd16WIjk2/mT52S6o3PzeBuQhYDQ5B8Nct0d+iLANlQ
         PnagEHPXlktUE08/si/NZaChODWMcB2o3csnIB2i1Pg2k26lutlKpIuS02WS3I2Vouu2
         T+UYJ5wURQezaXywshPng+rkpE2QD0ceLyejdYuS0NsqFXINki8fcuAlYN3u9lw88qRd
         QJBw==
X-Gm-Message-State: AOAM532zDQQqIWO3k1/UzpgvWd+43pjKJUF7BFB4hOZhVT+EExecb/tH
        F6FNYQMAJR4Ic4tJNX2+SVp8fg3YKg==
X-Google-Smtp-Source: ABdhPJyTXb4p5BXWAB1nFwm1mn+F0jqK/MmISSrSrGLz9gjablF/j+oH35pDTn7Qsklf63QkDHq77w==
X-Received: by 2002:a37:2706:: with SMTP id n6mr31067877qkn.216.1636987528171;
        Mon, 15 Nov 2021 06:45:28 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id s10sm6639946qke.132.2021.11.15.06.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 06:45:27 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:f4b6:aaf6:5a5e:d0a2])
        by serve.minyard.net (Postfix) with ESMTPSA id B339D1800BA;
        Mon, 15 Nov 2021 14:45:26 +0000 (UTC)
Date:   Mon, 15 Nov 2021 08:45:25 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>
Cc:     linux-kernel@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net
Subject: Re: [PATCH v2] ipmi: Move remove_work to dedicated workqueue
Message-ID: <20211115144525.GA15676@minyard.net>
Reply-To: minyard@acm.org
References: <20211115131645.25116-1-ioanna-maria.alifieraki@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115131645.25116-1-ioanna-maria.alifieraki@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 03:16:45PM +0200, Ioanna Alifieraki wrote:
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
> drained when destroyed to avoid the race.

Thanks, this is in my for-next queue.  If nobody complains after a week
or so I'll send it on.

-corey

> 
> [1] https://bugs.launchpad.net/bugs/1950666
> 
> Cc: stable@vger.kernel.org
> Fixes: 3b9a907223d7 (ipmi: fix sleep-in-atomic in free_user at cleanup SRCU user->release_barrier)
> Signed-off-by: Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index deed355422f4..1ade72bfae0f 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -191,6 +191,8 @@ struct ipmi_user {
>  	struct work_struct remove_work;
>  };
>  
> +struct workqueue_struct *remove_work_wq;
> +
>  static struct ipmi_user *acquire_ipmi_user(struct ipmi_user *user, int *index)
>  	__acquires(user->release_barrier)
>  {
> @@ -1297,7 +1299,7 @@ static void free_user(struct kref *ref)
>  	struct ipmi_user *user = container_of(ref, struct ipmi_user, refcount);
>  
>  	/* SRCU cleanup must happen in task context. */
> -	schedule_work(&user->remove_work);
> +	queue_work(remove_work_wq, &user->remove_work);
>  }
>  
>  static void _ipmi_destroy_user(struct ipmi_user *user)
> @@ -5383,6 +5385,13 @@ static int ipmi_init_msghandler(void)
>  
>  	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
>  
> +	remove_work_wq = create_singlethread_workqueue("ipmi-msghandler-remove-wq");
> +	if (!remove_work_wq) {
> +		pr_err("unable to create ipmi-msghandler-remove-wq workqueue");
> +		rv = -ENOMEM;
> +		goto out;
> +	}
> +
>  	initialized = true;
>  
>  out:
> @@ -5408,6 +5417,8 @@ static void __exit cleanup_ipmi(void)
>  	int count;
>  
>  	if (initialized) {
> +		destroy_workqueue(remove_work_wq);
> +
>  		atomic_notifier_chain_unregister(&panic_notifier_list,
>  						 &panic_block);
>  
> -- 
> 2.17.1
> 
