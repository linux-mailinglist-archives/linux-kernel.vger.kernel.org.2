Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9BF437892
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 15:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbhJVOAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 10:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbhJVOAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 10:00:25 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2806EC061767
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 06:58:07 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bq11so2975255lfb.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 06:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kXXjrgFD9GxycZP7psxdDamDNFUN7x5Wjjbi/hjihFg=;
        b=iK8wS2ZKDL+XOVbhiW7h++R+sR2QK02X8jWaX1Xr56UYrdIsKQI7oqjt/rn7Kzy6Vm
         kv5dNMoixvnYRQ56ojAX/RQKDZJi3gbD6WPcm8n7EICq3k22xVHN1Pnl5XHUGwXRf08i
         wynK09w/BRhN5+uW16FVE8Hj2bhLmhtwitMNoKxpMmzS+hEdH55dwQMR8jCKpDPla9wT
         GZkfDR3iXMsWD6vxCo1pZgZUDqierhl2C/e+WYEXJPbCQo924mwY6zOSaPA+gf6vBVpz
         j5rWcb4JJx0QxKh5tj14jXVkb728QMArDpHkwamllIq85la430YGW8K3q/zZX9mIr42I
         5URg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kXXjrgFD9GxycZP7psxdDamDNFUN7x5Wjjbi/hjihFg=;
        b=oGnazDJlcONqds8l1P3Yz8BDiwnrBawWgHnJKcHJM5JuMFFT9AcIcQ6e/jZ27Jg+iY
         zU/9BeA+6x4zP5FWY5CeG5CJMo1MnH2UeXqwVsYBH0HE9OlCRzq733cHbFtzGGQq+/sW
         69ZV9ph3/IFuecvNy1IW6eWBSvMx8T9kyn3wEf4ja2jJ3vZSY43KLCz6x/OX7TNot2Nf
         ACGfB8oFub+4+P0STilMxx27RFtyO9oLv+n6b9WY+X5c5QvxhJGsoe1byHs2X4j9at5P
         8DaswLzNgu3Hz1UmLd3jy2vfmEp0XC+77niqlFJpZAAsyV1OJQDOkT4pp3N5eDKsS9CM
         a6KA==
X-Gm-Message-State: AOAM531qWtGJnZQ2YTjxYAa8e2VX0CdurTvN2YRBix+zVvfVHD5lgJri
        1skQgWHTM7/zImvyJqekOlxC8jmICmLsWxaZx83sdg==
X-Google-Smtp-Source: ABdhPJzDz4PMdhgbqAyGI0Nco6rp1BpNUsAvdub7hQ7KocotcyVYeX5QmW1BGnvEs+UrCtgsC+vmKHvfk7RmSlvTico=
X-Received: by 2002:a05:6512:3254:: with SMTP id c20mr10693589lfr.254.1634911085502;
 Fri, 22 Oct 2021 06:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <5773062.lOV4Wx5bFT@kreacher>
In-Reply-To: <5773062.lOV4Wx5bFT@kreacher>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 22 Oct 2021 15:57:29 +0200
Message-ID: <CAPDyKFpp5MjiD0MPd878HueXkZZH2vj_ddi-g3-ZL5rXODjdcA@mail.gmail.com>
Subject: Re: [PATCH] PM: sleep: Do not let "syscore" devices runtime-suspend
 during system transitions
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Maulik Shah <mkshah@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2021 at 14:58, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> There is no reason to allow "syscore" devices to runtime-suspend
> during system-wide PM transitions, because they are subject to the
> same possible failure modes as any other devices in that respect.
>
> Accordingly, change device_prepare() and device_complete() to call
> pm_runtime_get_noresume() and pm_runtime_put(), respectively, for
> "syscore" devices too.
>
> Fixes: 057d51a1268f ("Merge branch 'pm-sleep'")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: 3.10+ <stable@vger.kernel.org> # 3.10+

This makes perfect sense for me too.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/main.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> Index: linux-pm/drivers/base/power/main.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/main.c
> +++ linux-pm/drivers/base/power/main.c
> @@ -1048,7 +1048,7 @@ static void device_complete(struct devic
>         const char *info = NULL;
>
>         if (dev->power.syscore)
> -               return;
> +               goto out;
>
>         device_lock(dev);
>
> @@ -1078,6 +1078,7 @@ static void device_complete(struct devic
>
>         device_unlock(dev);
>
> +out:
>         pm_runtime_put(dev);
>  }
>
> @@ -1789,9 +1790,6 @@ static int device_prepare(struct device
>         int (*callback)(struct device *) = NULL;
>         int ret = 0;
>
> -       if (dev->power.syscore)
> -               return 0;
> -
>         /*
>          * If a device's parent goes into runtime suspend at the wrong time,
>          * it won't be possible to resume the device.  To prevent this we
> @@ -1800,6 +1798,9 @@ static int device_prepare(struct device
>          */
>         pm_runtime_get_noresume(dev);
>
> +       if (dev->power.syscore)
> +               return 0;
> +
>         device_lock(dev);
>
>         dev->power.wakeup_path = false;
>
>
>
