Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A95341E4D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 14:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhCSNaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 09:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhCSNaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 09:30:18 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51884C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 06:30:17 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a198so10008856lfd.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 06:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FEYhFs8kH152qcYM2dnhJV6B7hCRTEkQlCwB7B41PvE=;
        b=bM4WPa+3kHkwASMyPrIKCpD2sgguhruuYo9C6a3hCVtzQPgg7w7hXTlf6YAuzP+TAF
         dN7N9ILjctdw0SJVczwOjL903D/LwOCnB8Q3dur4SBEyRGSBBNZI+Ky01woP2CSAfaub
         0aQquTSJbmajAhfD+GadWGYXE5LWnhC02wrP5taCnZac5YK/2b0anDJ8KkRqSuetQL5b
         eloNOLO4mjJncNzoOnFsLrmu3mC2koYkUDo82nHoNy6kIG6OeEXAj6yxNYBb+V0+HJKL
         iYnoi0RhXlpvbACDlsbW6vAEdYjtr/DKu1VIsyfnSss4PiQrS0XsfHRyWGmdIdI3cvJk
         v5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FEYhFs8kH152qcYM2dnhJV6B7hCRTEkQlCwB7B41PvE=;
        b=W+vb7rtoJo0++CQwauwrVjwgHvwNLnHQn4ptaclpSTwq74Hl3B2BKod+8ToYvnkeAW
         XsgY3FVslLEdYCR75TCCZe4n2KnWzWXNFJrgjfL0EIzSdzC/coa6NEPeJ79Ha3MruD8P
         wgpB0pxYviSU/7BRnWPVQ+qx7elLdA7rbQ9qELtZoCsQulkKiafYFdWJSizsDkCF5Hly
         lAz5HFwYDBuaroKvy3/DxES+KaQ6F3pJ4vNX5/AteHmbiTAzFS1/KYyQOsSXiMV9bOJi
         /mA8DbvT3tjUq31mr2I4GU70MDL4cabWHgu81kL83yU+WITaja1J96E2r5E+qBSvts4t
         W8ig==
X-Gm-Message-State: AOAM533mjTlwyNbJFoj6i8FO8DLtuil2FwXT7XB0FC5TfSdqYsMgMafc
        nJSuAXCMmOjBtjvlkys7JPkiXDlahWC49knFLUrI6Q==
X-Google-Smtp-Source: ABdhPJzu0aKHOD/osom9MM8020hbUUd6uaRn+r/5Xt4cGuv3svwwxidGiwlv3b5+EUqZR50y1XTeFlm6/2sq3cEVQE0=
X-Received: by 2002:ac2:4d95:: with SMTP id g21mr901276lfe.29.1616160615823;
 Fri, 19 Mar 2021 06:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <5448054.DvuYhMxLoT@kreacher> <4304785.LvFx2qVVIh@kreacher>
In-Reply-To: <4304785.LvFx2qVVIh@kreacher>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 19 Mar 2021 14:29:39 +0100
Message-ID: <CAPDyKFpU45vQMB_gdGnodV1=-fORJgtG3VXpeLaKvw4p5vMZhQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Revert "PM: runtime: Update device status before
 letting suppliers suspend"
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "elaine.zhang" <zhangqing@rock-chips.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2021 at 19:15, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> Revert commit 44cc89f76464 ("PM: runtime: Update device status
> before letting suppliers suspend") that introduced a race condition
> into __rpm_callback() which allowed a concurrent rpm_resume() to
> run and resume the device prematurely after its status had been
> changed to RPM_SUSPENDED by __rpm_callback().

Huh, the code path is not entirely easy to follow. :-)

Did you find this by code inspection or did you get an error report?

>
> Fixes: 44cc89f76464 ("PM: runtime: Update device status before letting suppliers suspend")
> Link: https://lore.kernel.org/linux-pm/24dfb6fc-5d54-6ee2-9195-26428b7ecf8a@intel.com/
> Reported by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: 4.10+ <stable@vger.kernel.org> # 4.10+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/base/power/runtime.c | 62 +++++++++++++++---------------------
>  1 file changed, 25 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 18b82427d0cb..a46a7e30881b 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -325,22 +325,22 @@ static void rpm_put_suppliers(struct device *dev)
>  static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
>         __releases(&dev->power.lock) __acquires(&dev->power.lock)
>  {
> -       bool use_links = dev->power.links_count > 0;
> -       bool get = false;
>         int retval, idx;
> -       bool put;
> +       bool use_links = dev->power.links_count > 0;
>
>         if (dev->power.irq_safe) {
>                 spin_unlock(&dev->power.lock);
> -       } else if (!use_links) {
> -               spin_unlock_irq(&dev->power.lock);
>         } else {
> -               get = dev->power.runtime_status == RPM_RESUMING;
> -
>                 spin_unlock_irq(&dev->power.lock);
>
> -               /* Resume suppliers if necessary. */
> -               if (get) {
> +               /*
> +                * Resume suppliers if necessary.
> +                *
> +                * The device's runtime PM status cannot change until this
> +                * routine returns, so it is safe to read the status outside of
> +                * the lock.
> +                */
> +               if (use_links && dev->power.runtime_status == RPM_RESUMING) {
>                         idx = device_links_read_lock();
>
>                         retval = rpm_get_suppliers(dev);
> @@ -355,36 +355,24 @@ static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
>
>         if (dev->power.irq_safe) {
>                 spin_lock(&dev->power.lock);
> -               return retval;
> -       }
> -
> -       spin_lock_irq(&dev->power.lock);
> -
> -       if (!use_links)
> -               return retval;
> -
> -       /*
> -        * If the device is suspending and the callback has returned success,
> -        * drop the usage counters of the suppliers that have been reference
> -        * counted on its resume.
> -        *
> -        * Do that if the resume fails too.
> -        */
> -       put = dev->power.runtime_status == RPM_SUSPENDING && !retval;
> -       if (put)
> -               __update_runtime_status(dev, RPM_SUSPENDED);
> -       else
> -               put = get && retval;
> -
> -       if (put) {
> -               spin_unlock_irq(&dev->power.lock);
> -
> -               idx = device_links_read_lock();
> +       } else {
> +               /*
> +                * If the device is suspending and the callback has returned
> +                * success, drop the usage counters of the suppliers that have
> +                * been reference counted on its resume.
> +                *
> +                * Do that if resume fails too.
> +                */
> +               if (use_links
> +                   && ((dev->power.runtime_status == RPM_SUSPENDING && !retval)
> +                   || (dev->power.runtime_status == RPM_RESUMING && retval))) {
> +                       idx = device_links_read_lock();
>
> -fail:
> -               rpm_put_suppliers(dev);
> + fail:
> +                       rpm_put_suppliers(dev);
>
> -               device_links_read_unlock(idx);
> +                       device_links_read_unlock(idx);
> +               }
>
>                 spin_lock_irq(&dev->power.lock);
>         }
> --
> 2.26.2
>
>
>
>
