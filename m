Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7393F3733
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 01:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbhHTXNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 19:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhHTXNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 19:13:32 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9155EC061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 16:12:53 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so6938747wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 16:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=rvmI5YBR34qN0ROkIaRHGTH6QrA+tMHVJqy89xkEWS4=;
        b=MI+J011fpEKavw1UCz+UVIcioE9BCI91bJ5XBwoj3cQPbvf7bQTo6Z/rLfJ/1ZxowU
         nJUD2L7k7aEcxUCdZIXMQUoUua3DHHGSDzacfY+OigWdcv3XxGTvvrFmZNvgeh41P80R
         nZ4/c0b3gQcWHqco3IvDBLyrCb9dcaiGNqwV2glDfbTDWe4peYe8NpwIbqVpHurb715K
         RaTkfaKIRBDYrdihitEsjMUICYf4i6VzqfT0ZijkZxtcbZYsstm45uXRZ4M9GYKL5wwd
         GLp9HILhkxHcPvs1WD3DvdbQBHcrV3Xc7QFI5vxsNUUllutWGA/JtGE3bKeCgeMo2U66
         T2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=rvmI5YBR34qN0ROkIaRHGTH6QrA+tMHVJqy89xkEWS4=;
        b=AfWLOvgbvzRcDPGvsd505RhNxECUoPURke4D0Dbzujxp7b1eYu4HpnGiez/GOOvys4
         a+83aL4gwGXPIpdJGBgl26HKafspoQmg4YyTFidFOte1WfkTtrnTxjVxINF8JiQcgJgr
         eQr2oz1EiKQTHgbTNQTZruY80MM/XdPcmP2WHTaFoVa5bP5N5kbY0pY9CPbf407X+KWB
         I7krm+oaPSUBEEBrRgYmbt9azIt0fvwivnEtIdYk+e/AV78R2X6aZhfGzKelPwcCuCZc
         fJAc0t++Fd24gy5+WHvpusZfeidlK4O6/cRXJbFcY+FeUaMMEwQEwl9JfM6vUmhbev0O
         PTkg==
X-Gm-Message-State: AOAM531fXY6ocELGwdOUlu2Ew8drRBmtGkLef/CRYBgjURPY37t/SmYh
        gMKJtqfrxlYms1Ae6BM8V0OKzQ==
X-Google-Smtp-Source: ABdhPJxSsq1HoGOpshbJpzHgvLtwSE77CY+IfQFEM9eJG5z+10aZf+SHMi7cAaYOcNIc2pmDO8p8wA==
X-Received: by 2002:a05:600c:21ce:: with SMTP id x14mr6055876wmj.187.1629501172077;
        Fri, 20 Aug 2021 16:12:52 -0700 (PDT)
Received: from ?IPv6:2001:8b0:dfde:e1a0::2? (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id m62sm3426712wmm.48.2021.08.20.16.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 16:12:50 -0700 (PDT)
Message-ID: <df71ec12574f546edc0620dc5624c09e921a8f23.camel@philpotter.co.uk>
Subject: Re: [PATCH RFC 0/3] staging: r8188eu: avoid uninit value bugs
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, fmdefrancesco@gmail.com
Date:   Sat, 21 Aug 2021 00:12:49 +0100
In-Reply-To: <cover.1629479152.git.paskripkin@gmail.com>
References: <cover.1629479152.git.paskripkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-08-20 at 20:07 +0300, Pavel Skripkin wrote:
> Hi, Greg, Larry and Phillip!
> 
> I noticed, that new staging driver was added like 3 weeks ago and I
> decided
> to look at the code, because drivers in staging directory are always
> buggy.
> 
> The first thing I noticed is *no one* was checking read operations
> result, but
> it can fail and driver may start writing random stack values into
> registers. It
> can cause driver misbehavior or device misbehavior.
> 
> To avoid this type of bugs, i've expanded read() API with error
> parametr,
> which will be initialized to error if read fails. It helps callers to
> break/return earlier and don't write random values to registers or to
> rely
> on random values.
> 
> Why is this pacth series RFC?
>   1. I don't have this device and I cannot test these changes.
>   2. I don't know how to handle errors in each particular case. For
> now, function
>      just returns or returns an error. That's all. I hope, driver
> maintainers will
>      help with these bits.
>   3. I guess, I handled not all uninit value bugs here. I hope, I
> fixed
>      at least half of them
> 
> This series was build-tested and made on top of staging-testing
> branch
> 
> 
> With regards,
> Pavel Skripkin
> 
> Pavel Skripkin (3):
>   staging: r8188eu: add proper rtw_read* error handling
>   staging: r8188eu: add error handling to ReadFuse
>   staging: r8188eu: add error argument to read_macreg
> 
>  drivers/staging/r8188eu/core/rtw_debug.c      |  79 +++-
>  drivers/staging/r8188eu/core/rtw_efuse.c      | 119 +++--
>  drivers/staging/r8188eu/core/rtw_io.c         |  18 +-
>  drivers/staging/r8188eu/core/rtw_mp.c         |  38 +-
>  drivers/staging/r8188eu/core/rtw_mp_ioctl.c   |  20 +-
>  drivers/staging/r8188eu/core/rtw_pwrctrl.c    |   6 +-
>  drivers/staging/r8188eu/core/rtw_sreset.c     |   7 +-
>  drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    |   9 +-
>  drivers/staging/r8188eu/hal/hal_com.c         |  22 +-
>  drivers/staging/r8188eu/hal/hal_intf.c        |   6 +-
>  drivers/staging/r8188eu/hal/odm_interface.c   |  12 +-
>  drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  37 +-
>  drivers/staging/r8188eu/hal/rtl8188e_dm.c     |   6 +-
>  .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 260 ++++++++---
>  drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |  26 +-
>  drivers/staging/r8188eu/hal/rtl8188e_sreset.c |  20 +-
>  drivers/staging/r8188eu/hal/rtl8188eu_led.c   |  17 +-
>  drivers/staging/r8188eu/hal/usb_halinit.c     | 412 ++++++++++++++--
> --
>  drivers/staging/r8188eu/hal/usb_ops_linux.c   |  55 ++-
>  drivers/staging/r8188eu/include/hal_intf.h    |   6 +-
>  .../staging/r8188eu/include/rtl8188e_hal.h    |   2 +-
>  drivers/staging/r8188eu/include/rtw_efuse.h   |   4 +-
>  drivers/staging/r8188eu/include/rtw_io.h      |  18 +-
>  drivers/staging/r8188eu/include/rtw_mp.h      |   2 +-
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 168 +++++--
>  drivers/staging/r8188eu/os_dep/usb_intf.c     |   4 +-
>  26 files changed, 1072 insertions(+), 301 deletions(-)
> 

Dear Pavel,

Firstly, thank you for this contribution, it is much appreciated.
Whilst I'm still learning myself when it comes to this driver and to
kernel code in general, I can certainly say the code looks pretty good
in general so far. I will try and offer individual comments on each
patch.

Regards,
Phil

