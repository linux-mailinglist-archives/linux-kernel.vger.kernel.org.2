Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3633260C0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 11:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhBZKAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 05:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbhBZJ6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:58:01 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9767CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 01:57:20 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id v123so257464vsv.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 01:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JmtBSQqZOYTSBeHH6jP+55CjNPwiDsMYQqrcvNRMl1I=;
        b=mrCnsWudw8oi2sfgtnZBoyv5tqrp8tYYVEV4aqm1s1RzMizNCiWYB+FfDc6f11VRAI
         HNGmEXZm/axD6e3N4Bm9qhGerR8dR9BtPPu20l5asJtBFjqWzeMZerp+CvDiAlE8svBM
         HGmYreVQLUHiyUlz+Z2zSJvSJvyBmnHRVbXIMLbpFdkYS3xeWLkVyBKQ/4fAtx1U8I2+
         bw/rmbJHijL0+C+1czdmAa0Zdm1wSMDT2OQN4EGy0UdvlAJZbRT5fCWi1W0uwrfaPLNm
         GvBU7pe2r1O/3Kx/Yh4ihq8rupLCMuxbmSlLaQhCeuYwNBlFoVzE6AmfWGcbUGJrzksB
         /QTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JmtBSQqZOYTSBeHH6jP+55CjNPwiDsMYQqrcvNRMl1I=;
        b=g0uCGrjsle5jWidRZ9VJlfWrpI2SF+Xmjdd3WJkJDoJ0PJJlt2cw5gbQzCETFlp4km
         ofv2H/U+tW+2g2rOjVS5V3JGyZ4adA4jgXLOozMHkKBRTOZrwMCTGheZm4SHB1qKWCnX
         rGfdVTzzdHkjLS02ukT2mgtiPUWSGwudKfNGve0CncTTL9xF2bEDT4woPyEcp5/XpBFU
         gZAiHeoFMoGQyZ++uCIiS+drirVuCC/Vqs4I4yGiUKVFsDQKxe6F28FMP9gAK9GMH9GV
         JDxkc5ACgXKALrOVqx9iJUeyjNP5yMIVc7GvGPAU+bRgqFdgzX/FN3bR5zja+IIiLcUZ
         A7Ig==
X-Gm-Message-State: AOAM531MtcGJWzhlzyVUKvTib4EMcLnamp9WduXXYrewcm776j2Ncflm
        F4M2M512SMMBPgQ8TLr9eLrMwnSFmcHp7UdKDzthcWnrRGk=
X-Google-Smtp-Source: ABdhPJwt9W6H2pZC+YCrdKAfwdtvZj/wNKIzVrQ3RaSsX4ooXRb9yR7875TokaWSgQ/+vlddn8YjThHPz3gAxNSPUiw=
X-Received: by 2002:a67:c787:: with SMTP id t7mr975233vsk.48.1614333439722;
 Fri, 26 Feb 2021 01:57:19 -0800 (PST)
MIME-Version: 1.0
References: <2024466.aZ6alR0V7q@kreacher>
In-Reply-To: <2024466.aZ6alR0V7q@kreacher>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 26 Feb 2021 10:56:43 +0100
Message-ID: <CAPDyKFq6P8-TbzqeTxfANbz4L0ezBy58O5NOQOL+qsSC=tS6oQ@mail.gmail.com>
Subject: Re: [PATCH v2] PM: runtime: Update device status before letting
 suppliers suspend
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "elaine.zhang" <zhangqing@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Feb 2021 at 19:23, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Because the PM-runtime status of the device is not updated in
> __rpm_callback(), attempts to suspend the suppliers of the given
> device triggered by rpm_put_suppliers() called by it may fail.
>
> Fix this by making __rpm_callback() update the device's status to
> RPM_SUSPENDED before calling rpm_put_suppliers() if the current
> status of the device is RPM_SUSPENDING and the callback just invoked
> by it has returned 0 (success).
>
> While at it, modify the code in __rpm_callback() to always check
> the device's PM-runtime status under its PM lock.
>
> Link: https://lore.kernel.org/linux-pm/CAPDyKFqm06KDw_p8WXsM4dijDbho4bb6T4k50UqqvR1_COsp8g@mail.gmail.com/
> Fixes: 21d5c57b3726 ("PM / runtime: Use device links")
> Reported-by: elaine.zhang <zhangqing@rock-chips.com>
> Diagnosed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>
> v1 -> v2:
>    * Initialize the "get" variable to avoid a false-positive warning from
>      the compiler.
>
> ---
>  drivers/base/power/runtime.c |   62 +++++++++++++++++++++++++------------------
>  1 file changed, 37 insertions(+), 25 deletions(-)
>
> Index: linux-pm/drivers/base/power/runtime.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/runtime.c
> +++ linux-pm/drivers/base/power/runtime.c
> @@ -325,22 +325,22 @@ static void rpm_put_suppliers(struct dev
>  static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
>         __releases(&dev->power.lock) __acquires(&dev->power.lock)
>  {
> -       int retval, idx;
>         bool use_links = dev->power.links_count > 0;
> +       bool get = false;
> +       int retval, idx;
> +       bool put;
>
>         if (dev->power.irq_safe) {
>                 spin_unlock(&dev->power.lock);
> +       } else if (!use_links) {
> +               spin_unlock_irq(&dev->power.lock);
>         } else {
> +               get = dev->power.runtime_status == RPM_RESUMING;
> +
>                 spin_unlock_irq(&dev->power.lock);
>
> -               /*
> -                * Resume suppliers if necessary.
> -                *
> -                * The device's runtime PM status cannot change until this
> -                * routine returns, so it is safe to read the status outside of
> -                * the lock.
> -                */
> -               if (use_links && dev->power.runtime_status == RPM_RESUMING) {
> +               /* Resume suppliers if necessary. */
> +               if (get) {
>                         idx = device_links_read_lock();
>
>                         retval = rpm_get_suppliers(dev);
> @@ -355,24 +355,36 @@ static int __rpm_callback(int (*cb)(stru
>
>         if (dev->power.irq_safe) {
>                 spin_lock(&dev->power.lock);
> -       } else {
> -               /*
> -                * If the device is suspending and the callback has returned
> -                * success, drop the usage counters of the suppliers that have
> -                * been reference counted on its resume.
> -                *
> -                * Do that if resume fails too.
> -                */
> -               if (use_links
> -                   && ((dev->power.runtime_status == RPM_SUSPENDING && !retval)
> -                   || (dev->power.runtime_status == RPM_RESUMING && retval))) {
> -                       idx = device_links_read_lock();
> +               return retval;
> +       }
>
> - fail:
> -                       rpm_put_suppliers(dev);
> +       spin_lock_irq(&dev->power.lock);
>
> -                       device_links_read_unlock(idx);
> -               }
> +       if (!use_links)
> +               return retval;
> +
> +       /*
> +        * If the device is suspending and the callback has returned success,
> +        * drop the usage counters of the suppliers that have been reference
> +        * counted on its resume.
> +        *
> +        * Do that if the resume fails too.
> +        */
> +       put = dev->power.runtime_status == RPM_SUSPENDING && !retval;
> +       if (put)
> +               __update_runtime_status(dev, RPM_SUSPENDED);
> +       else
> +               put = get && retval;
> +
> +       if (put) {
> +               spin_unlock_irq(&dev->power.lock);
> +
> +               idx = device_links_read_lock();
> +
> +fail:
> +               rpm_put_suppliers(dev);
> +
> +               device_links_read_unlock(idx);
>
>                 spin_lock_irq(&dev->power.lock);
>         }
>
>
>
