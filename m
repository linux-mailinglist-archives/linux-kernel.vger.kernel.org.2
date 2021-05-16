Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D690381E25
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 12:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhEPKrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 06:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhEPKrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 06:47:42 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20643C061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 03:46:28 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id lj11-20020a17090b344bb029015bc3073608so2184440pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 03:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition;
        bh=/T4n5rSEU/7mfpShmPGChAkh2YJ26bRxCBPR7qULp4o=;
        b=lGKfYkfhJM4KuOs/emhPUV/GvJf/CRid2qQ6wKrW8NJ3GNPEGteZxGYHQOWy3hze9f
         8F3ol6yimlN4A1OrHPKjOzkdlBNeEEkDYUJVrwKY+CY5tvQdVqo0+WPWf8bW3GjghBiH
         gVOktO5Vqp81iL9oTMtRbnz9ldI7VwSRQ0XNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mime-version:content-disposition;
        bh=/T4n5rSEU/7mfpShmPGChAkh2YJ26bRxCBPR7qULp4o=;
        b=D7FsxU8qxDYIXX3Xkqhh5IAATMw2kwLhBVaqzT0kwrrv6tZbUqkpf2I5MTFiEWxGG3
         DmSDqFhipnVdcVVxci2ohgsYAE7HtmSuBsJmV0i8iU6R+3UJDYr1nfoPuzOFduPMhZEI
         vvX7oy8HeCxd1XQp9/ZKWkdZ2Y9ylNKDsB6c80dbankpM6qG32X+K4NRNfjvJKw936uZ
         k/viWfwRWSrBCKfb4y/+f1deIPPxQu6CRVyoxRZ32fwJ8lJjImxAJFdkMIEKlcbq0vMg
         0WpTlgAFgxDtUJGV6t6CoIcW5YTC6MkXRB5R/ELdiwSpYVt0F/jNwjDl1HagFoYoG+z+
         VJ1A==
X-Gm-Message-State: AOAM532VHyTTQVGqofn36oh3+WE9d+0XdVVJ1IPPlJm7dc+kpCPIE4x7
        i/1O9JoZT/y6g4GSReQ67brH+0RMmqK6Nw==
X-Google-Smtp-Source: ABdhPJxRUbsQAsfBqJ7/JM3WtlzTlKDIH0qd5MxPSbalxIuE60HZnXQQTOTvG4YqGJuVB7b+aadMyA==
X-Received: by 2002:a17:90a:ad44:: with SMTP id w4mr12649064pjv.71.1621161986206;
        Sun, 16 May 2021 03:46:26 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:4596:acad:c782:2f52])
        by smtp.gmail.com with ESMTPSA id d12sm7444551pfv.190.2021.05.16.03.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 03:46:25 -0700 (PDT)
Date:   Sun, 16 May 2021 19:46:21 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] watchdog: Cleanup handling of false positives
Message-ID: <YKD3/RuL/2qUcRhL@google.com>
Reply-To: 20210311122130.6788-7-pmladek@suse.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

// This was never in my inbox, so sorry if I mess up the "Reply-to"
// Original message:  https://lore.kernel.org/lkml/20210311122130.6788-7-pmladek@suse.com/


>@@ -375,7 +375,14 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
> 	/* .. and repeat */
> 	hrtimer_forward_now(hrtimer, ns_to_ktime(sample_period));
>
> -	/* Reset the interval when touched externally by a known slow code. */
> +	/*
> +	 * If a virtual machine is stopped by the host it can look to
> +	 * the watchdog like a soft lockup. Check to see if the host
> +	 * stopped the vm before we process the timestamps.
> +	 */
> +	kvm_check_and_clear_guest_paused();
> +
[..]
>@@ -401,14 +405,6 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
> 	 */
> 	duration = is_softlockup(touch_ts, period_ts);
> 	if (unlikely(duration)) {
> -		/*
> -		 * If a virtual machine is stopped by the host it can look to
> -		 * the watchdog like a soft lockup, check to see if the host
> -		 * stopped the vm before we issue the warning
> -		 */
> -		if (kvm_check_and_clear_guest_paused())
> -			return HRTIMER_RESTART;

This looks racy to me. I believe kvm_check_and_clear_guest_paused()
was in the right place.

VCPU can be scheduled out/preepmpted any time at any point; and then
guest VM (or even the entire system) can be suspended. When we resume
the VM we continue from where we were preempted (from VCPU POW).

So what the old code did

watchdog_timer_fn()
{
	...
	<<!!>>

	// Suppose we are suspended here. When we are getting resumed
	// jiffies jump forward, which may look like a soft lockup.
	duration = is_softlockup(touch_ts, period_ts);
	if (unlikely(duration)) {
		// And this is where kvm_check_and_clear_guest_paused()
		// jumps in. We know already that jiffies have jumped,
		// we don't know if jiffies jumped because the VM was
		// suspended. And this is what we figure out here and
		// bail out
		if (kvm_check_and_clear_guest_paused())
			return HRTIMER_RESTART;
	}
}

The new code does the following

watchdog_timer_fn()
{
	...
	kvm_check_and_clear_guest_paused(); // PVCLOCK_GUEST_STOPPED is not set

	<<!!>>

	// Suppose the VM got suspended at this point. PVCLOCK_GUEST_STOPPED
	// is set, but we don't check it. jiffies will jump and this will look
	// like a lockup, but we don't check if jiffies jumped because the VM
	// was suspended
	duration = is_softlockup(touch_ts, period_ts);
	if (unlikely(duration)) {
		// report the lockup and perhaps panic the system,
		// depending on the configuration
	}
}

What am I missing?
