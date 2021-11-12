Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8532D44EBCE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 18:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbhKLRMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 12:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhKLRMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 12:12:00 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3ADCC061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 09:09:09 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 7so8914846oip.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 09:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=5xTzgAtGHLv1HF4i4r4EWvrRW3cWwxS5mJylm7DOgNE=;
        b=HhysRBrDiitmrXEjurKGFnxzLvgwsfit2tEJZkqfMG7WZG3E0M2cqYBgtReSawVlrp
         ZTD7jzRPqI5wAXWKkn9xNcpdCOc3ZcK4B0ZiSt0V1wxIBUnIumnCfVU0fFwIw60EnGCG
         lRHpx9wx0RwK7XwbmlWuxBo13sQL//W03GvtgGJoO29ERwiexXZXnG0PS7IzBQknOAhn
         rtA8bS0GP/Hd0eGSfM/wR5U2omY2jFJCuiTA/z0OWV4/TLs/exbN0LXMwsBIG9enkOZj
         boSlB94I/jaAg5kc+jpya9ysG8Kr2czHU8TpA7gSeMtXcByql+gEBl2z2xjaJPNcP5MU
         p3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=5xTzgAtGHLv1HF4i4r4EWvrRW3cWwxS5mJylm7DOgNE=;
        b=fyw0Ou3YCwF3jFAelphmFo83lOFOy9EE3gSugZlRiESwLw8TR+sQdgCBbcRWi/F0Si
         gTKvJGwtli3rWCxWT8bKKgt0Q0jhRT75tFYslQwQOTVXJTzaaIEm86WmEkzOMuzQFFsY
         sjk+i/suFmLM9A4lR6GFMxGZM0q/vGAjg3a0Ya0JIHEixzk1A+wuzuhC5/FwjD/ZW1Xa
         498SSxgSuAM/P7gU1plYjnb99T79XCPrqjsali0z6AlgMFAdHpDTCowbQWAe0yQy/f5d
         INDH1SAsRsmS9sFd0hyviEa4UnyhY9YATB7IDFIaQiztiMKKBqkE0gsKe4yhKjpBvSwy
         Izrw==
X-Gm-Message-State: AOAM532+oLCP5qSUjd8uxvydAOtEKh417SrvrlbnrwafSsrflSB+Jl/3
        qjOaastPD3RuoGQRb/CcBn5tyDYNOg==
X-Google-Smtp-Source: ABdhPJwvaxKTFfVdqKMt2DADswH2+Ddhe3ZHBj/hlvSPz+beUA0I/BnypnaWUm13Q9jP4KTEKqqvtg==
X-Received: by 2002:aca:230b:: with SMTP id e11mr17639326oie.22.1636736948949;
        Fri, 12 Nov 2021 09:09:08 -0800 (PST)
Received: from serve.minyard.net ([47.184.156.158])
        by smtp.gmail.com with ESMTPSA id h14sm1364502ots.22.2021.11.12.09.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 09:09:08 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:3da4:ae9:63f5:5ac8])
        by serve.minyard.net (Postfix) with ESMTPSA id 11D461800B9;
        Fri, 12 Nov 2021 17:09:07 +0000 (UTC)
Date:   Fri, 12 Nov 2021 11:09:05 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>
Cc:     linux-kernel@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        ioanna.alifieraki@gmail.com
Subject: Re: [PATCH] ipmi: Move remove_work to dedicated workqueue
Message-ID: <20211112170905.GI4667@minyard.net>
Reply-To: minyard@acm.org
References: <20211112165413.7747-1-ioanna-maria.alifieraki@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112165413.7747-1-ioanna-maria.alifieraki@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 06:54:13PM +0200, Ioanna Alifieraki wrote:
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

Yeah, this is an issue.  One comment below...

> 
> [1] https://bugs.launchpad.net/bugs/1950666
> 
> Cc: stable@vger.kernel.org
> Fixes: 3b9a907223d7 (ipmi: fix sleep-in-atomic in free_user at cleanup SRCU user->release_barrier)
> Signed-off-by: Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index deed355422f4..9e0ad2ccd3e0 100644
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
> @@ -5383,6 +5385,8 @@ static int ipmi_init_msghandler(void)
>  
>  	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
>  
> +	remove_work_wq = create_singlethread_workqueue("ipmi-msghandler-remove-wq");
> +

Shouldn't you check the return value here?

-corey

>  	initialized = true;
>  
>  out:
> @@ -5408,6 +5412,9 @@ static void __exit cleanup_ipmi(void)
>  	int count;
>  
>  	if (initialized) {
> +		flush_workqueue(remove_work_wq);
> +		destroy_workqueue(remove_work_wq);
> +
>  		atomic_notifier_chain_unregister(&panic_notifier_list,
>  						 &panic_block);
>  
> -- 
> 2.17.1
> 
