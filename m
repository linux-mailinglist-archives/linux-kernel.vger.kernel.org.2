Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664BB427457
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 01:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243820AbhJHXrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 19:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbhJHXrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 19:47:10 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B7BC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 16:45:14 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u18so45172847lfd.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 16:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pP1WoEAAJ+vCb8OBFKknF0fFWhXHfTf1dyCM1yg832g=;
        b=FJX0/9d+9/kpnygHrvLnZLoEUcFi9QeR+n8y7ETuFGcSeUX/GfSwAWiZYJt+KrK+16
         o7aNcNa5SFwi07Bj8egMGz6yvecVTkbfebnSBL89tQA+uct6+oGUcGWaZDkl0NKm8CYl
         jtOIwUAhQdluZknXm/0gWssbx948AUYIvrgh9S0rhFhVvixrH3dtGqpFtAc++Q96dlI2
         xOhUTUGcvHUZ0bH1WCb14U5zszyNsgGrGSyXT9eUSr/a0ge/TJ5d0MbKyLrQsJidpmd/
         nJtVdHZbnHrsTAIrBdRYf0eCt0Oxacv5SmhtJ5sswq9FweyGGnPPfRzGzVBUcSOf5898
         jwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pP1WoEAAJ+vCb8OBFKknF0fFWhXHfTf1dyCM1yg832g=;
        b=x6MHrDH83LzfJY83U+ybOuc1sFwctZLr1QmRC77SaFdzJV7IUuqVsNClrN8IYJ57M2
         27cOYL3LqOlKpCx0L9hcENamggT4czjjdjkV65eE+QNgxTJLZXu146xlcy2q97GUVUgb
         XwjZS1kdr2lHyyIZi0D1Dh1GWUEvCVkZIrtO4pKfgx2LKo4I2r6XTj1VXDkhyz97M2ev
         ZDiV3uNaAvRuQbKOV24IYj+yFCMdPxqismhuFGr4OXhZiNPBcx+wHY3GjEOEAmAC0Xnx
         9aVe8bhBwCkhEpNu4RWDKUaNBwPYJqSNz7Kn3dINFOH0nFQa/EBnp7knlVkY8+GYOKHy
         OZkA==
X-Gm-Message-State: AOAM530yBIfVZ7cmjgQjuGPNHdCXNy7aG/mqViom4CK6UW5Qf0ZfPPLp
        gBIqb0Np40qxGCa7Cf/VYWqkwnhjrBJDbKqq+B8e/g==
X-Google-Smtp-Source: ABdhPJyKF71ntPduAPRrBUY2yf7ct8XpanrtaUF5zaJfcoC1pog8O+nh+aJgVBiglc1CaFbP5NncEhF7YjewQ3AED+U=
X-Received: by 2002:a19:711d:: with SMTP id m29mr12215247lfc.36.1633736712722;
 Fri, 08 Oct 2021 16:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211008080305.13401-1-yanghui.def@bytedance.com>
In-Reply-To: <20211008080305.13401-1-yanghui.def@bytedance.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 8 Oct 2021 16:45:01 -0700
Message-ID: <CALAqxLWUNFozhfhuVFAPo9xGgO+xsXPQ=i5w1Y0E9-w-PdHXgw@mail.gmail.com>
Subject: Re: [PATCH] Clocksource: Avoid misjudgment of clocksource
To:     yanghui <yanghui.def@bytedance.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 1:03 AM yanghui <yanghui.def@bytedance.com> wrote:
>
> clocksource_watchdog is executed every WATCHDOG_INTERVAL(0.5s) by
> Timer. But sometimes system is very busy and the Timer cannot be
> executed in 0.5sec. For example,if clocksource_watchdog be executed
> after 10sec, the calculated value of abs(cs_nsec - wd_nsec) will
> be enlarged. Then the current clocksource will be misjudged as
> unstable. So we add conditions to prevent the clocksource from
> being misjudged.
>
> Signed-off-by: yanghui <yanghui.def@bytedance.com>
> ---
>  kernel/time/clocksource.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index b8a14d2fb5ba..d535beadcbc8 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -136,8 +136,10 @@ static void __clocksource_change_rating(struct clocksource *cs, int rating);
>
>  /*
>   * Interval: 0.5sec.
> + * MaxInterval: 1s.
>   */
>  #define WATCHDOG_INTERVAL (HZ >> 1)
> +#define WATCHDOG_MAX_INTERVAL_NS (NSEC_PER_SEC)
>
>  static void clocksource_watchdog_work(struct work_struct *work)
>  {
> @@ -404,7 +406,9 @@ static void clocksource_watchdog(struct timer_list *unused)
>
>                 /* Check the deviation from the watchdog clocksource. */
>                 md = cs->uncertainty_margin + watchdog->uncertainty_margin;
> -               if (abs(cs_nsec - wd_nsec) > md) {
> +               if ((abs(cs_nsec - wd_nsec) > md) &&
> +                       cs_nsec < WATCHDOG_MAX_INTERVAL_NS &&

Sorry, it's been awhile since I looked at this code, but why are you
bounding the clocksource delta here?
It seems like if the clocksource being watched was very wrong (with a
delta larger than the MAX_INTERVAL_NS), we'd want to throw it out.

> +                       wd_nsec < WATCHDOG_MAX_INTERVAL_NS) {

Bounding the watchdog interval on the check does seem reasonable.
Though one may want to keep track that if we are seeing too many of
these delayed watchdog checks we provide some feedback via dmesg.

thanks
-john
