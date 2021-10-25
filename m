Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B250A43986F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbhJYO0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhJYO0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:26:50 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B0EC061746
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:24:27 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id j21so11826519lfe.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lb4sS2uQWkT+vIll85h1xw04h2l9vWeBok/7+RS0cs8=;
        b=moX7bC+Kgu7RPXUrLtfbsfgpYpfzYriEFraPnArLZxqIQufKhhXgsVJuYxQdIKp7iv
         pBuk9EJrhfMjWpmqKVmIuHoXDORTVePgRh5FFeE3II0wl74FdyIaAAGcidRsiJY15V+k
         VJMyPxCc67oyqyZHXWr2KW+BOYwez6M28VrgRy5NYFjvpCUTz0N1q37dEqlR5obyz8E9
         vSlGybcx6a/eBIjavmIRNfGgres83UEKhEZN74TBJTc5Z5Psixkw7Kr+KeuQDWCfn1g6
         bM1iJ1wGDFxCnb4OdRaMofgcv28Aybm7sfJRFnpHalcQONZxggh7iSAEN6hCzyGF065J
         NaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lb4sS2uQWkT+vIll85h1xw04h2l9vWeBok/7+RS0cs8=;
        b=h9yrHluoHwoNxDmOCYtpWIJER7KMlyuLKsdkbjMwhmaWkeeRoY3jU0fp6MENTAAkMD
         YpMJAdBPuRFKUWtQPMaDIeYKPYbXMD08Oysn3VnEBA47uGM1CASkF1nc1wpJgB6aAhxf
         FutLJ++eSyAK0S8F5Xt0Gfxx/+Qgj18CMnMF5/P5cppvaxYW5M+SpX6inI5jaUmyN6ZT
         D3ktxkk7MsYgHaKX+QnRCWdDSHYyWN1p9wOQEeowaEKv3c9EdHSunZgCjRNjFen5L1oM
         8dtymWIfnnIF8fgSURrladhF5TFVrn8KMSqg3i9Y83+QN+soo3Xvf0701MZJa08yfkSv
         65rw==
X-Gm-Message-State: AOAM533GmG9ieqBwisc5HgMUm16P+frYVqVPixqB5b3/S2xxTtOuo8Hr
        mCsSepSJpnBpxD6A6DLXTF4cojxPYvSv6eVAyv477A==
X-Google-Smtp-Source: ABdhPJx0qxqkp0QPdn+PEVjRLW6/ENOp5g+0zan7r6p+7GMymcU1vfpXjEN0xKryzfgQxzy+MTrykf6D40DGWRU6v/Y=
X-Received: by 2002:a05:6512:1515:: with SMTP id bq21mr17465208lfb.71.1635171866059;
 Mon, 25 Oct 2021 07:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <2230995.ElGaqSPkdT@kreacher> <1813297.tdWV9SEqCh@kreacher>
In-Reply-To: <1813297.tdWV9SEqCh@kreacher>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 25 Oct 2021 16:23:49 +0200
Message-ID: <CAPDyKFpGm-f79bmdpipmTB_ug1XGPcQEihVqHHcmSK-EprW5ww@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM: suspend: Do not pause cpuidle in the
 suspend-to-idle path
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2021 at 18:08, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> It is pointless to pause cpuidle in the suspend-to-idle path,
> because it is going to be resumed in the same path later and
> pausing it does not serve any particular purpose in that case.
>
> Rework the code to avoid doing that.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/main.c |   11 ++++++-----
>  kernel/power/suspend.c    |    8 ++++++--
>  2 files changed, 12 insertions(+), 7 deletions(-)
>
> Index: linux-pm/drivers/base/power/main.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/main.c
> +++ linux-pm/drivers/base/power/main.c
> @@ -747,8 +747,6 @@ void dpm_resume_noirq(pm_message_t state
>
>         resume_device_irqs();
>         device_wakeup_disarm_wake_irqs();
> -
> -       cpuidle_resume();
>  }
>
>  /**
> @@ -881,6 +879,7 @@ void dpm_resume_early(pm_message_t state
>  void dpm_resume_start(pm_message_t state)
>  {
>         dpm_resume_noirq(state);
> +       cpuidle_resume();
>         dpm_resume_early(state);
>  }
>  EXPORT_SYMBOL_GPL(dpm_resume_start);
> @@ -1336,8 +1335,6 @@ int dpm_suspend_noirq(pm_message_t state
>  {
>         int ret;
>
> -       cpuidle_pause();
> -
>         device_wakeup_arm_wake_irqs();
>         suspend_device_irqs();
>
> @@ -1521,9 +1518,13 @@ int dpm_suspend_end(pm_message_t state)
>         if (error)
>                 goto out;
>
> +       cpuidle_pause();
> +
>         error = dpm_suspend_noirq(state);
> -       if (error)
> +       if (error) {
> +               cpuidle_resume();
>                 dpm_resume_early(resume_event(state));
> +       }
>
>  out:
>         dpm_show_time(starttime, state, error, "end");
> Index: linux-pm/kernel/power/suspend.c
> ===================================================================
> --- linux-pm.orig/kernel/power/suspend.c
> +++ linux-pm/kernel/power/suspend.c
> @@ -97,7 +97,6 @@ static void s2idle_enter(void)
>         raw_spin_unlock_irq(&s2idle_lock);
>
>         cpus_read_lock();
> -       cpuidle_resume();
>
>         /* Push all the CPUs into the idle loop. */
>         wake_up_all_idle_cpus();
> @@ -105,7 +104,6 @@ static void s2idle_enter(void)
>         swait_event_exclusive(s2idle_wait_head,
>                     s2idle_state == S2IDLE_STATE_WAKE);
>
> -       cpuidle_pause();
>         cpus_read_unlock();
>
>         raw_spin_lock_irq(&s2idle_lock);
> @@ -405,6 +403,9 @@ static int suspend_enter(suspend_state_t
>         if (error)
>                 goto Devices_early_resume;
>
> +       if (state != PM_SUSPEND_TO_IDLE)
> +               cpuidle_pause();
> +
>         error = dpm_suspend_noirq(PMSG_SUSPEND);
>         if (error) {
>                 pr_err("noirq suspend of devices failed\n");
> @@ -459,6 +460,9 @@ static int suspend_enter(suspend_state_t
>         dpm_resume_noirq(PMSG_RESUME);
>
>   Platform_early_resume:
> +       if (state != PM_SUSPEND_TO_IDLE)
> +               cpuidle_resume();
> +
>         platform_resume_early(state);
>
>   Devices_early_resume:
>
>
>
>
>
>
>
