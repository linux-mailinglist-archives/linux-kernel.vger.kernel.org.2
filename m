Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890083F427D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 02:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbhHWANk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 20:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbhHWANj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 20:13:39 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A7CC061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 17:12:57 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id u15so9099979plg.13
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 17:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lWeK0f3YYSWotGGoYvRH6iLvyN7X0nngXeEnfy+6Thc=;
        b=S+nwAhyepz6VbGztjBn46pfFV4L8nod4zjGcDPgtMBdJUvHFGB9iUFZpVa5E64tuDQ
         lQDV5PZzK7pyf2En+sqlUxPI38CEiOth7gtxlcFgT6F/14GLYxxnPKZa5ralieCrn5RK
         hKxV/sEnf9a1KXLB2N2STiW31lUb9yaMcU/avF5uAQPDdB1zvxoTKKDOyg67PA1+ZhKZ
         zxEFhjig+rHKeUzVpHaW40EmfuT88uUsmDsjBoGU6gUzJ8ObtjXjV4s1rco/s3lTL9MM
         48EN4zIQUMXWgd/uRK2qKeS4k75zZetjEegCMh8XREgQ3U/RIRjfEzNIv+nQsUKSVYsT
         7AjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lWeK0f3YYSWotGGoYvRH6iLvyN7X0nngXeEnfy+6Thc=;
        b=HpcSfqTlfCIPAyTktaNWNgCiOcMpjqnIikukSFKPp19coKRifziDnY496Pl0khgQAS
         byDzFQNmBpz5CPqqAheFbLUFY3O1ohoJWYl0biE/pJdc9dhLI/eBPKZSi/75NyFA764L
         Y1RpUcG/0D+s+wZsOAp2Bx9Nthq6eUfZFhIRyYJwXYVrUSLqL9G4B5QAAzOHwf9cNdv3
         EuVWKvhw2RE7jDgyQ5ICfSWPLJDOQlxSyPXp6OjJHpmGma10avx5i7Yg7tW8iIQMbf54
         Vr7B6W7rqfTS1q4HK1IRA9+2P3HTI5huyqtJ174yMIBPOcnITxFPNj2/Ic0A0pkJBZZu
         9jaQ==
X-Gm-Message-State: AOAM532/u1PyTbD5+TOvkMt0WaYYJ5F8aY3IdvvNcwwBBqquhSkGutcH
        mQjHJBlcCJ+fzMylpopiJ7vPtYAFNN8jC5FkCouj5bdBI9XDD+iu
X-Google-Smtp-Source: ABdhPJymuo0M2IWuY+3l4z5bUKsBL7FBWBvOVV0iNQob5CcosG2qKrPYF6sWZfXDj9xGI8y1Vhwko3A0cvTFtpZDRiI=
X-Received: by 2002:a17:902:6ac6:b0:133:230b:e8bc with SMTP id
 i6-20020a1709026ac600b00133230be8bcmr5519689plt.22.1629677576512; Sun, 22 Aug
 2021 17:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <6182ed46-d79d-7f66-c7c0-096486410b4d@gmail.com> <cover.1629642658.git.paskripkin@gmail.com>
In-Reply-To: <cover.1629642658.git.paskripkin@gmail.com>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Mon, 23 Aug 2021 01:12:45 +0100
Message-ID: <CAA=Fs0=LACN5VqZ1AMkGBVma0W37bQDUeY1DLZ5S5EwV66AyOA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/6] staging: r8188eu: avoid uninit value bugs
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Aug 2021 at 15:35, Pavel Skripkin <paskripkin@gmail.com> wrote:
>
> Hi, Greg, Larry and Phillip!
>
> I noticed, that new staging driver was added like 3 weeks ago and I decided
> to look at the code, because drivers in staging directory are always buggy.
>
> The first thing I noticed is *no one* was checking read operations result, but
> it can fail and driver may start writing random stack values into registers. It
> can cause driver misbehavior or device misbehavior.
>
> To avoid this type of bugs, i've changed rtw_read* API. Now all rtw_read
> funtions return an error, when something went wrong with usb transfer.
>
> It helps callers to break/return earlier and don't write random values to
> registers or to rely on random values.
>
> Why is this pacth series RFC?
>   1. I don't have this device and I cannot test these changes.
>   2. I don't know how to handle errors in each particular case. For now, function
>      just returns or returns an error. That's all. I hope, driver maintainers will
>      help with these bits.
>   3. I guess, I handled not all uninit value bugs here. I hope, I fixed
>      at least half of them
>
>
> v1 -> v2:
>   1. Make rtw_read*() return an error instead of initializing pointer to error
>   2. Split one huge patch to smaller ones for each rtw_read{8,16,32} function
>      changes
>   3. Add new macro for printing register values (It helps to not copy-paste error
>      handling)
>   4. Removed {read,write}_macreg (Suggested by Phillip)
>   5. Rebased on top of staging-next
>   6. Cleaned checkpatch errors and warnings
>
> Only build-tested, since I don't have device with r8118eu chip
>
> Pavel Skripkin (6):
>   staging: r8188eu: remove {read,write}_macreg
>   staging: r8188eu: add helper macro for printing registers
>   staging: r8188eu: add error handling of rtw_read8
>   staging: r8188eu: add error handling of rtw_read16
>   staging: r8188eu: add error handling of rtw_read32
>   staging: r8188eu: make ReadEFuse return an int
>
>  drivers/staging/r8188eu/core/rtw_debug.c      |  79 +++-
>  drivers/staging/r8188eu/core/rtw_efuse.c      | 125 +++--
>  drivers/staging/r8188eu/core/rtw_io.c         |  27 +-
>  drivers/staging/r8188eu/core/rtw_mp.c         |  70 ++-
>  drivers/staging/r8188eu/core/rtw_mp_ioctl.c   |  13 +-
>  drivers/staging/r8188eu/core/rtw_pwrctrl.c    |   5 +-
>  drivers/staging/r8188eu/core/rtw_sreset.c     |   9 +-
>  .../r8188eu/hal/Hal8188ERateAdaptive.c        |   8 +-
>  drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  |  21 +-
>  drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    |   9 +-
>  drivers/staging/r8188eu/hal/hal_com.c         |  23 +-
>  drivers/staging/r8188eu/hal/hal_intf.c        |   6 +-
>  drivers/staging/r8188eu/hal/odm_interface.c   |  12 +-
>  drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  33 +-
>  drivers/staging/r8188eu/hal/rtl8188e_dm.c     |   6 +-
>  .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 285 +++++++++---
>  drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |  27 +-
>  drivers/staging/r8188eu/hal/rtl8188e_sreset.c |  22 +-
>  drivers/staging/r8188eu/hal/rtl8188eu_led.c   |  18 +-
>  drivers/staging/r8188eu/hal/usb_halinit.c     | 439 +++++++++++++++---
>  drivers/staging/r8188eu/hal/usb_ops_linux.c   |  57 ++-
>  drivers/staging/r8188eu/include/hal_intf.h    |   6 +-
>  .../staging/r8188eu/include/odm_interface.h   |   6 +-
>  .../staging/r8188eu/include/rtl8188e_hal.h    |   2 +-
>  drivers/staging/r8188eu/include/rtw_debug.h   |  13 +
>  drivers/staging/r8188eu/include/rtw_efuse.h   |   4 +-
>  drivers/staging/r8188eu/include/rtw_io.h      |  18 +-
>  drivers/staging/r8188eu/include/rtw_mp.h      |   2 -
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 179 +++++--
>  drivers/staging/r8188eu/os_dep/usb_intf.c     |   3 +-
>  30 files changed, 1138 insertions(+), 389 deletions(-)
>
> --
> 2.32.0
>

Dear Pavel,

Thanks for this. I like the code a lot. One thing I am conflicted on
is the helper macro for the printing of register values though. Whilst
I'm not necessarily opposed to the concept of the macro itself, I
don't think it should rely on GlobalDebugLevel for one thing - if we
are going to control printing of messages at runtime then in my mind
this should be done via debugfs and pr_debug or similar - an in-kernel
mechanism rather than something driver-provided. Also, the example you
give of:

        u32 tmp;
        if (!rtw_read(&tmp))
                DBG("reg = %d\n", tmp);

Doesn't seem overly unclear to me if DBG was a pr_debug or similar,
but I get what you're saying about repetition. This is just a small
thing though, would be interested to see what others think. Many
thanks.

Regards,
Phil
