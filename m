Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60447450880
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 16:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236641AbhKOPey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 10:34:54 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34354 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbhKOPeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 10:34:46 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6F646212C9;
        Mon, 15 Nov 2021 15:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636990309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a7T9VKofSnMgX8iniVKYTzP8GhhYa4AfPu8Vtjh+O+M=;
        b=CKRTcCXBQ7vOK5sAWYEkMSxkGRk2fxVkUthRFaBm6WtM6ZvgE/S9lvVfgORS39jb3WxUZQ
        7SkDDaNmeYXDCNYLGKA/DEUqoZLeROoMxkbSsTXNSzgwCoFkAqwiDAqu1sacqTrS8yhtf6
        5HFoqd5WA1Ta4qDbghzLaGaTOBKweIQ=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4C9E6A3B81;
        Mon, 15 Nov 2021 15:31:49 +0000 (UTC)
Date:   Mon, 15 Nov 2021 16:31:48 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     akpm@linux-foundation.org, frederic@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: ignore nohz_full cores in new cpumask
Message-ID: <YZJ9ZNusQR/3nh/9@alley>
References: <20211112051434.23642-1-qiang.zhang1211@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112051434.23642-1-qiang.zhang1211@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-11-12 13:14:34, Zqiang wrote:
> If the nohz_full is enabled, when update watchdog_mask, the
> nohz_full cores should be ignored.
> 
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> ---
>  kernel/watchdog.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index ad912511a0c0..3ef11a94783c 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -628,7 +628,9 @@ void lockup_detector_soft_poweroff(void)
>  static void proc_watchdog_update(void)
>  {
>  	/* Remove impossible cpus to keep sysctl output clean. */
> -	cpumask_and(&watchdog_cpumask, &watchdog_cpumask, cpu_possible_mask);
> +	cpumask_and(&watchdog_cpumask, &watchdog_cpumask,
> housekeeping_cpumask(HK_FLAG_TIMER));

I am not familiar with nozh_full code but this looks fine.


> +	if (cpumask_empty(&watchdog_cpumask))
> +		return;

But this looks looks wrong. Is there any reason for this?

We need to stop the watchdog when it was running before.

I mean that lockup_detector_reconfigure() must be called anytime
when the mask has changed even when it became empty.


>  	lockup_detector_reconfigure();
>  }

Best Regards,
Petr
