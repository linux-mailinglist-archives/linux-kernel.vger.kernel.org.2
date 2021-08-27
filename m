Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A92F3F956B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 09:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244502AbhH0Hu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 03:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244460AbhH0HuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 03:50:24 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301F5C061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 00:49:36 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id h1so9889161ljl.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 00:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CYvNOmqrDSmsEs3+omMTIz4LajG+tNAJHaqXOFzdB/g=;
        b=XyMIuYVmuqHE7l0fWj8jp2F83zqdWXvk3BykMHzuuThjZjBemgEaur4700CXc+rByV
         t1CfF0u0L/5lV01tt/yauHLQr28M7qQ7osdOQJqlQBjTI2xM9FnvPADxFtFXOSxWIJ83
         iOiFBtrINsuWm2owlrEODfcdFuqvmZNPszsLyeyOjE9QB3K5FlU3Du5dvh1phqGR60+j
         QPiCRzt9m3IoL0qNv0k1quQJzNs6It683ps1eFJuPuSaOCPI0oabp5LuPQD+AJiN1EjR
         cXGxRISuaq8th9v31+A/5CnSokcOJ/XRO8hw3Iu9JY+zA79C9Pi8RpzDGaFp9ho65kK5
         FobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CYvNOmqrDSmsEs3+omMTIz4LajG+tNAJHaqXOFzdB/g=;
        b=Ks30tWyHY8+JfFxXYJJBHX5vN8k3pe6BfuHyazW9l2W/AbGEHnErSh6wedjE5Ggnlt
         kYQ9qzKGBfQ4aUIDrcWbEzpHuzgzWIxxn4CXJYXbex4Czs93HqNvJIg35IfXDWVJKseg
         sAOQhsnEpIRJWj/ho2Iua9YVVJ/ZISSi1QIH5kaprQj17Z2MM0sGNDOpGr0ZLc9z2odW
         9Asfm+/ee2JMGit6Yje9rSth3MV0bjiY9TlVrSqMQrZjJPmhW9zTVsjqw2qrLhD+bwts
         t3aypS/MxeXAQiL2g1cK0t/+1TUjxE+TN1Sw4VLATrkJP8/0fx0Ac9Rog/PU2P+k+aEI
         YXMg==
X-Gm-Message-State: AOAM533iEwyZkvX2lntXV6VPrx0F5bIt9xUovl9mVF/rs9CSdnON/nZO
        YN7atgbS6NkeaJw0cM8+DDpe4NkkaG6/Xg==
X-Google-Smtp-Source: ABdhPJzbSTdpuC5WF6lhLKbpMbcjnqKt4Vpa+qGDS3A4KE5jyy4/Ike83//BTGHrsZiLMJiEUp3vSw==
X-Received: by 2002:a2e:9e4c:: with SMTP id g12mr6479655ljk.433.1630050574522;
        Fri, 27 Aug 2021 00:49:34 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id g18sm523875lfb.23.2021.08.27.00.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 00:49:34 -0700 (PDT)
Date:   Fri, 27 Aug 2021 10:49:32 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] staging: r8188eu: avoid uninit value bugs
Message-ID: <20210827074932.2qkpvmakwqqxo6hc@kari-VirtualBox>
References: <CAA=Fs0=gX66TW3qoHYWcoSsvai6YZn=U81a34V45oij7NrMJrQ@mail.gmail.com>
 <cover.1629789580.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1629789580.git.paskripkin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 10:25:45AM +0300, Pavel Skripkin wrote:
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
> 
> v2 -> v3:

Hi Pavel.

If v4 is needed can you please send it without replying to old message.
This thread is so hard to follow because always new version is answer to
old subject. This depens a little bit how you setup your email, but some
of us is grouping all emails in same thread and this thread is out of
control :D

Thanks
Kari Argillander

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
