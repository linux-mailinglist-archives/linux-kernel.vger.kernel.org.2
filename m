Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44703492C2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhCYNKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhCYNKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:10:21 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6632C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 06:10:20 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a7so2819801ejs.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 06:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zxzcvSpuW5BzO5KFJl2Jtm9u8hATZIardWi4yi/tUdw=;
        b=dhpkGEz7F7VPrF8qt11YAdUTNN38LDOuNBbwCKRx2c85T7s4WhMdIbYl94FrwIJ4/4
         xcNrf+3rO8Y2AdkQago6LnTWOk+7BYbz9kXaVU1QUL+3dK19s0KpfORr+a/TcQJz0SQk
         2laK69ap1j96hgTefznUvFGAUInNLKiCdgVVicYTwiyva5nYgqQTJoY3gr+EeqVe1nVw
         FaIvqAqf6+CzlYR5cvkR4Juf9AXHo92HOZhumHRmHVK8tu2VVOP+7CeZdzdAQzj4tkUg
         lj0MxLolDyCuuxH3vOdmAHHChDeUOoDeMrlN6udNiA33yLoq+yc/9lw7OXRTiSPjE111
         LkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zxzcvSpuW5BzO5KFJl2Jtm9u8hATZIardWi4yi/tUdw=;
        b=lGa4Wl4e20sfrdL3aHQV0XB0cNMs7bA40EEvoh4IfUToYaB/yhWFvpm6OmHQ/wYP8l
         CNuZAApQsQ13LFBpt11PX0gUP6ZjFX3i33A3OFsrNaTsU0Z/d+Mf6cVJ7cj47Vc8i3Bh
         5A9XiLSLm1mMN4iEcgoN19fw2wICAuZZdJscUYaiw5Qz9nvpt5ma5gu30Pwegaeqy1hZ
         RCC417j9Fy6dawxiFTUROVniJQJFM8eLsLFFsexWkLMb2UUwcIaZY1CwMWRY4zlNAm3T
         So29b5iHWKns9DkKrplavAv04QvjzIhiGO4/KF2CJDaPA3MOTnI6g40xG3UVtKJ0cZSb
         FIZg==
X-Gm-Message-State: AOAM530/ikk0q9Dm9T5YuvJd42EfvoZyCwAno5Qf2kS/gu1QlyA4zWQU
        6SNF0EK7D/gDf8hPUhVBiRrPV4rDsWPztfSJ8n1u5g==
X-Google-Smtp-Source: ABdhPJxmOrGZbR5jfPwo23eClqK/B4EIJuvV/F2TH8vBmojVqBN7770nnzNKZZa+b3hqNNvrrPmTHy0HqErHFzSFD2w=
X-Received: by 2002:a17:906:3409:: with SMTP id c9mr9284256ejb.314.1616677815208;
 Thu, 25 Mar 2021 06:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210325092203.10251-1-qiang.zhang@windriver.com>
In-Reply-To: <20210325092203.10251-1-qiang.zhang@windriver.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 25 Mar 2021 09:09:39 -0400
Message-ID: <CA+CK2bCS9Ab+F9gzGEJejW6J3R26j1JNBOV3tvcR6+fz2uRfpw@mail.gmail.com>
Subject: Re: [PATCH] loop: Fix use of unsafe lo->lo_mutex locks
To:     qiang.zhang@windriver.com
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qiang,

Thank you for root causing this issue. Did you encounter this issue or
found by inspection?

I would change the title to what actually being changed, something like:

loop: call __loop_clr_fd() with lo_mutex locked to avoid autoclear race


>   ......                                       kfree(lo)
>        UAF
>
> When different tasks on two CPUs perform the above operations on the same
> lo device, UAF may occur.

Please also explain the fix:

Do not drop lo->lo_mutex before calling __loop_clr_fd(), so refcnt and
LO_FLAGS_AUTOCLEAR check in lo_release stay in sync.

>
> Fixes: 6cc8e7430801 ("loop: scale loop device by introducing per device lock")
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> ---
>  drivers/block/loop.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index d58d68f3c7cd..5712f1698a66 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1201,7 +1201,6 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
>         bool partscan = false;
>         int lo_number;
>
> -       mutex_lock(&lo->lo_mutex);
>         if (WARN_ON_ONCE(lo->lo_state != Lo_rundown)) {
>                 err = -ENXIO;
>                 goto out_unlock;
> @@ -1257,7 +1256,6 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
>         lo_number = lo->lo_number;
>         loop_unprepare_queue(lo);
>  out_unlock:
> -       mutex_unlock(&lo->lo_mutex);
>         if (partscan) {
>                 /*
>                  * bd_mutex has been held already in release path, so don't
> @@ -1288,12 +1286,11 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
>          * protects us from all the other places trying to change the 'lo'
>          * device.
>          */
> -       mutex_lock(&lo->lo_mutex);
> +
>         lo->lo_flags = 0;
>         if (!part_shift)
>                 lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
>         lo->lo_state = Lo_unbound;
> -       mutex_unlock(&lo->lo_mutex);
>
>         /*
>          * Need not hold lo_mutex to fput backing file. Calling fput holding
> @@ -1332,9 +1329,10 @@ static int loop_clr_fd(struct loop_device *lo)
>                 return 0;
>         }
>         lo->lo_state = Lo_rundown;
> +       err = __loop_clr_fd(lo, false);
>         mutex_unlock(&lo->lo_mutex);
>
> -       return __loop_clr_fd(lo, false);
> +       return err;
>  }
>
>  static int
> @@ -1916,13 +1914,12 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
>                 if (lo->lo_state != Lo_bound)
>                         goto out_unlock;
>                 lo->lo_state = Lo_rundown;
> -               mutex_unlock(&lo->lo_mutex);
>                 /*
>                  * In autoclear mode, stop the loop thread
>                  * and remove configuration after last close.
>                  */
>                 __loop_clr_fd(lo, true);
> -               return;
> +               goto out_unlock;
>         } else if (lo->lo_state == Lo_bound) {
>                 /*
>                  * Otherwise keep thread (if running) and config,
> --
> 2.17.1
>

LGTM
Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>

Thank you,
Pasha
