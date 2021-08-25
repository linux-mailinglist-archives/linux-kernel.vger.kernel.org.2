Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8423F72BD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238820AbhHYKO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238223AbhHYKO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:14:27 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2F8C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:13:41 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u14so25568269ejf.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oMOBAU5Aqf+srhoQMa3UF9S3XS6vs0xPjtEJmaLFg38=;
        b=IobV79fISDITsST1Dk0Qfpsog6iZkLwYj0kytrRFB7F57Qoi6/X3AtYMIy6cLLtS+v
         vbVNbA7fuTIbz1a2kX/MN80UVzMf66bre6lIiplLDV7oJFmBWbwRtBEE6yi6z4DAMrSk
         YzOcDwC/0A6bV7yCckezFd+WF1agRyS3DHWeqgsAANgX8FAtmtGVrjO+a7ruX+w5NApV
         tUJmH6kC0xrKo0nAuamKt3lzdoKde5yBVPU17ykHrO5Es6iDeqfRMwbgxuD0OCBYFtYM
         OSF7bL8QJB+MkI47na09URCwro8fyUCxNVJIH4Cecr13ChWkrcJ1mMkjnuAjiKLCcrR4
         AUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oMOBAU5Aqf+srhoQMa3UF9S3XS6vs0xPjtEJmaLFg38=;
        b=M3qP3DYZvzbTfNCoR17YdN+qZ1E/6xvNAWTTsyWf1jNejcAZrWyk7tB49pxDGxmNna
         C0twBqZO1wY0hKBlxG+kzSzkg8eU3ICeudUEh2JmLggNyKNT6ODrKBE5j7W2p9nasNYC
         Pte31bTx1GY/8aCTLDVpZ0b7wGW6Ldw9SCVqLPJlE01aFkbNJWFqLdk8Y4tiC3cM/zp5
         cYwURW3Hs7Eka2p4Oqf/zWFq9nXTAieb9DX8lF2u3VQKDZHGO+LLwyHG1WATKPAPhRZ1
         gkpBHtZJE4hqf5D07LlWos7n9zFOfV8xoQoJpusMfaHOweky4upzQ43GwZsVxTpz1kPU
         CFSg==
X-Gm-Message-State: AOAM533hhpe5vknDJ66nS4VHwtsfw74oOZSrRZc74OErODZWJuLbVxlQ
        TxpW4pIzCMvt5QgUS8JsmoM=
X-Google-Smtp-Source: ABdhPJzIf4R9jkI8ZHR40V3lmcwMkayvsgFy1iyREwfy9pvMR0Q9xUsNIXN+zg9x7hCdnPX9ldAWDQ==
X-Received: by 2002:a17:906:c1d0:: with SMTP id bw16mr45777717ejb.146.1629886420377;
        Wed, 25 Aug 2021 03:13:40 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id c19sm7892625ejs.116.2021.08.25.03.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 03:13:39 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH v3 0/6] staging: r8188eu: avoid uninit value bugs
Date:   Wed, 25 Aug 2021 12:13:38 +0200
Message-ID: <1640255.mRBsJQyRh4@localhost.localdomain>
In-Reply-To: <cover.1629789580.git.paskripkin@gmail.com>
References: <CAA=Fs0=gX66TW3qoHYWcoSsvai6YZn=U81a34V45oij7NrMJrQ@mail.gmail.com> <cover.1629789580.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 24, 2021 9:25:45 AM CEST Pavel Skripkin wrote:
> Hi, Greg, Larry and Phillip!
> 
> I noticed, that new staging driver was added like 3 weeks ago and I decided
> to look at the code, because drivers in staging directory are always buggy.
> 
> The first thing I noticed is *no one* was checking read operations result, but
> it can fail and driver may start writing random stack values into registers. It
> can cause driver misbehavior or device misbehavior.
> 
> To avoid this type of bugs, I've changed rtw_read* API. Now all rtw_read
> funtions return an error, when something went wrong with usb transfer.
> 
> It helps callers to break/return earlier and don't write random values to
> registers or to rely on random values.
> 
> 
> v2 -> v3:
>   1. Fixed OOPS in usb_read32(), caused by writing to u32 **
>   2. Fixed style in rtw_read32, rtw_read16 and rtw_read8 (Suggested by Dan)
>   3. Added error hanling when usb_control_msg() returns ret != len
>      NOTE: Dan suggested to add this to usbctrl_vendorreq(), but there is
>      pending series, which will get rid of usb_control_msg(), so (res != len)
>      check can be removed, when Fabio's series will go in
>   4. Removed RFC tag
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
> 
> Phillip has tested fixed v2 version, AFAIU

I had already acked your series when it was an RFC but I guess
the tag gets lost now that you have submitted the "real" patches.

As said, I like the purpose and the overall design. Furthermore,
I have compiled and linked the whole series (make C=2 -j8 
drivers/staging/r8188eu W=1) and I can confirm it does not
introduce any errors and/or warnings.

Anyway I couldn't test the module, so (for all six patches)...

Acked-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Thanks,

Fabio

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
>  drivers/staging/r8188eu/hal/usb_ops_linux.c   |  62 ++-
>  drivers/staging/r8188eu/include/hal_intf.h    |   6 +-
>  .../staging/r8188eu/include/odm_interface.h   |   6 +-
>  .../staging/r8188eu/include/rtl8188e_hal.h    |   2 +-
>  drivers/staging/r8188eu/include/rtw_debug.h   |  13 +
>  drivers/staging/r8188eu/include/rtw_efuse.h   |   4 +-
>  drivers/staging/r8188eu/include/rtw_io.h      |  18 +-
>  drivers/staging/r8188eu/include/rtw_mp.h      |   2 -
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 179 +++++--
>  drivers/staging/r8188eu/os_dep/usb_intf.c     |   3 +-
>  30 files changed, 1143 insertions(+), 389 deletions(-)
> 
> -- 
> 2.32.0
> 
> 




