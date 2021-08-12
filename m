Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74EE3E9B74
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 02:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbhHLAAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 20:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbhHLAAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 20:00:46 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F92C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 17:00:22 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so7852072pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 17:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gUpeHPEzA4pBxrfsOggRhHArCWTMfpMZNkNsV5I7XGs=;
        b=bAvmuRCH+OIl1a+Ou7qFRzm7Q1aP9NKvTsdRZauqcEggnz1W9CwpNVZnKvD+Uzh/In
         rGa95SglpyLP7ZVaxgKwDE+XlL9fU7aXuiihwqq3KLg0EeHrw4eMrJ4FZc+Ck+1HMz4n
         K0l4ZIN+q6wbk4u5n/0SoOgSB+upENePE48xk+QXiTGUuplyGN2VInyvMVWD07DupygA
         b4hGfE4gLPmW76VvIBolgcMtSUY4fgWMmXBbs32NKsP6wADiaXs97enS4HPr0uCUNnsD
         S9U9OfcMVq5VCcjRxED27cVrndqRbyF90kOJSuPc8PcYCyoFrGqT4t1kPadvyUe6RLRS
         lvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gUpeHPEzA4pBxrfsOggRhHArCWTMfpMZNkNsV5I7XGs=;
        b=mam0UB01t8QHP83G6N/nNHmceMSDvx0TyaKWj5FjmkFAXUGw9IVLXTgmLqaRkZ0Sdh
         XHZe+5plC+gp9Y8pf6Qx8/tj3XIZJTJxaUAImyC8ikYs9+41CfYg0PUp3yiMISZYhv6z
         0Ox4PTp4VD9tGL6Fs2aJ1+wKv0yC24nk43GjRvR0dB90ha4vD7G7BSRurL1HLnAQc6g1
         csbT4PTbZxclhzD9SM8KtoGFoVto6ZbkEFsfsnVVNUcK6NTKZ49rclcDjdpu8yrkj4XS
         QxL7NOLXjHf40etO7Kdm/Vr7Qd5xdFxGbteXSKNxrXBhuOscodO/l9WbC25ZKpNGeprD
         Qwuw==
X-Gm-Message-State: AOAM532V6PHEwTuCbiApgL2s+w/R1hVFZuiahnXg9trbvBZLbAaKyh0y
        FSiCSHUfMs4Sp/cv1o5rZRuKgRNfaAaYPsJgfoOHVQ==
X-Google-Smtp-Source: ABdhPJz2f5hRZahEqgImorzB+UZdzmDwQcFB6qkz299J1hbye+wfh+1OPQAxyQv6a3dAJYeDinLY5u7bvUHMXOlg7oE=
X-Received: by 2002:a65:6a0a:: with SMTP id m10mr1221345pgu.82.1628726421743;
 Wed, 11 Aug 2021 17:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210811215806.20426-1-Larry.Finger@lwfinger.net>
In-Reply-To: <20210811215806.20426-1-Larry.Finger@lwfinger.net>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Thu, 12 Aug 2021 01:00:11 +0100
Message-ID: <CAA=Fs0=WeawmsS=Y+iEL7AMvkhyN3wuXRaxD2eC271zvdeBwUg@mail.gmail.com>
Subject: Re: [PATCH 0/3] staging: r8188eu: Clean up some smatch warnings and errors
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2021 at 22:58, Larry Finger <Larry.Finger@lwfinger.net> wrote:
>
> Smatch reports a number of warnings ans a few errors. Most are places where
> the indentation is messed up, but a few are unitialized variables or
> dereferencing a pointer before checking it.
>
> Smatch does output a false message concerning a potential memory leak.
> The pointer is saved, and the memory freed in another routine.
>
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
>
> Larry Finger (3):
>   staging: r8188eu: Fix Smatch warnings for core/*.c
>   staging: r8188eu: Fix smatch problems in hal/*.c
>   staging: r8188eu: Fix smatch warnings in os_dep/*.c
>
>  drivers/staging/r8188eu/core/rtw_br_ext.c     |   2 +-
>  drivers/staging/r8188eu/core/rtw_cmd.c        |   6 -
>  drivers/staging/r8188eu/core/rtw_ieee80211.c  |   2 +-
>  drivers/staging/r8188eu/core/rtw_io.c         |   2 +-
>  drivers/staging/r8188eu/core/rtw_led.c        |  20 +--
>  drivers/staging/r8188eu/core/rtw_mlme.c       |  16 ++-
>  drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  16 +--
>  drivers/staging/r8188eu/core/rtw_mp.c         |   6 +-
>  drivers/staging/r8188eu/core/rtw_p2p.c        |   4 +-
>  drivers/staging/r8188eu/core/rtw_recv.c       |  18 +--
>  drivers/staging/r8188eu/core/rtw_security.c   |   6 +-
>  drivers/staging/r8188eu/core/rtw_sta_mgt.c    |   6 +-
>  drivers/staging/r8188eu/core/rtw_wlan_util.c  |  14 +--
>  drivers/staging/r8188eu/core/rtw_xmit.c       |   4 +-
>  .../r8188eu/hal/Hal8188ERateAdaptive.c        |  16 +--
>  .../staging/r8188eu/hal/HalHWImg8188E_RF.c    |   2 +-
>  drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    |   2 +-
>  drivers/staging/r8188eu/hal/odm.c             |  18 +--
>  drivers/staging/r8188eu/hal/odm_HWConfig.c    |   2 +-
>  .../staging/r8188eu/hal/rtl8188e_hal_init.c   |   2 +-
>  drivers/staging/r8188eu/hal/rtl8188e_mp.c     |   8 +-
>  drivers/staging/r8188eu/hal/usb_halinit.c     |  18 +--
>  drivers/staging/r8188eu/hal/usb_ops_linux.c   |  87 +++++++------
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  58 ++++-----
>  drivers/staging/r8188eu/os_dep/mlme_linux.c   |   3 +-
>  drivers/staging/r8188eu/os_dep/os_intfs.c     |   2 +-
>  .../staging/r8188eu/os_dep/osdep_service.c    |   2 +-
>  drivers/staging/r8188eu/os_dep/recv_linux.c   |   8 +-
>  drivers/staging/r8188eu/os_dep/usb_intf.c     | 117 +++++++++---------
>  29 files changed, 227 insertions(+), 240 deletions(-)
>
> --
> 2.32.0
>

Dear Larry,

Sorry, but the third patch doesn't apply to my copy of the staging
tree with staging-testing tip as of now. Thanks.

Regards,
Phil
