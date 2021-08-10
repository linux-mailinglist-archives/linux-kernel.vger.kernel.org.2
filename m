Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54C13E8636
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 00:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbhHJWvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 18:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbhHJWvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 18:51:01 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2412AC061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 15:50:38 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id w21-20020a7bc1150000b02902e69ba66ce6so602673wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 15:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xfyFHHFlfEpnQFC6plmot+LFQsVamLEZ8n6xAQLz3I0=;
        b=sQEFllmDCQb6T586tGCkYXElYhLj6oIP0gskBtlvlf5V65+Xm+JtJApGA7V4vwfHHT
         TcTUSYuoXumJK8oOTGxP3ccerMhqu8PX8zjzM4q8N8KPnZlKVVlz6b0Hy5Xk+9HXW+7d
         33ZviV5FNBPiDXipLiCymxMPm5JRoGNaKPas11h2C2edIWzqClA0uEUWZcpSv77Hwt2L
         Z4aep4FwqYNmY1E0ln22zoSFmDBryD4pPeWRzasDHR4LPChNZv9gMQz8UWDzLM6ylm05
         k9WwTMQKOu64RFm//ssGD3DrXYF+dJPRMIZdDbc0nFi0zm3EjJG50f1A+Q6JE/gqzmKM
         u3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xfyFHHFlfEpnQFC6plmot+LFQsVamLEZ8n6xAQLz3I0=;
        b=Xv1/mmonmdOsVzXMr913Jgo5ETnePvHae3oNbiCAQTUX70rs777cgeltrOZ9aW+ZBG
         VantmZuqNK3wLVj3E4NFQqE5TWTt3oXKatFfqzKHFImwRXwZU3ARUpjGr4sKz5hYHi7e
         53vVp0aJeoASuv6MLag/MkDYnFIwJaVczzUX2sYOBXuXK9EEcX/CmlYkCvTRnzj/uRO/
         9KlMoOUGlVuXn0kAI9kU0Pt356C4+Wt4OvTe5xOCfSPWW7Av2LC6R1iqLvu/0JYJjqTp
         hjikEFb7tCxu87bCfh+eK44oC/BdM1osugwGgOq37Kl1Ha2Y0SuNhJWe4HtZLv2Qd8Qg
         Lsow==
X-Gm-Message-State: AOAM530MRNxNqsw+DO6kNVzrztEZm9cxMT2+AUeriCv+WkXzyBXN150k
        WHSH+ULUwVK/j30/3Hc2xbftFw==
X-Google-Smtp-Source: ABdhPJwKNK0wbQ2CzmeUk4pisA2wARwQSZ3SQSPHKRNT/TuPutCdQEwDkDO3C5V9wmauQER/o+CWyg==
X-Received: by 2002:a7b:c14a:: with SMTP id z10mr6930211wmi.36.1628635836729;
        Tue, 10 Aug 2021 15:50:36 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id z137sm4090938wmc.14.2021.08.10.15.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 15:50:36 -0700 (PDT)
Date:   Tue, 10 Aug 2021 23:50:34 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: Replace BITn with BIT(n)
Message-ID: <YRMCug2ULtA6JoLn@equinox>
References: <20210810180511.8986-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810180511.8986-1-Larry.Finger@lwfinger.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 01:05:11PM -0500, Larry Finger wrote:
> The driver uses BITn instead of BIT(n). All such usage is converted.
> 
> Note that this patch does not address any warnings that checkpatch
> will find. These include missing space around operators and lines
> that are too long. These problems will be addressed in a separate
> patch.
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> 
> ---
> v2 - Removed dependency on incorrect patch
>      Fixed typo n comment noted by Dan Carpenter
> ---
>  drivers/staging/r8188eu/core/rtw_ioctl_set.c  |   2 +-
>  drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  |  40 +-
>  drivers/staging/r8188eu/hal/odm.c             |  68 +--
>  drivers/staging/r8188eu/hal/odm_HWConfig.c    |   4 +-
>  drivers/staging/r8188eu/hal/odm_RTL8188E.c    | 116 ++---
>  drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  14 +-
>  .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  66 +--
>  drivers/staging/r8188eu/hal/rtl8188e_mp.c     |  34 +-
>  drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |   8 +-
>  drivers/staging/r8188eu/hal/rtl8188eu_led.c   |  10 +-
>  drivers/staging/r8188eu/hal/usb_halinit.c     |  48 +-
>  .../staging/r8188eu/include/Hal8188EPhyCfg.h  |  14 +-
>  .../staging/r8188eu/include/Hal8188EPwrSeq.h  |  84 ++--
>  drivers/staging/r8188eu/include/hal_intf.h    |  16 +-
>  drivers/staging/r8188eu/include/odm.h         | 106 ++---
>  drivers/staging/r8188eu/include/odm_reg.h     |   2 +-
>  drivers/staging/r8188eu/include/odm_types.h   |   8 +-
>  .../staging/r8188eu/include/osdep_service.h   |  42 --
>  .../staging/r8188eu/include/rtl8188e_spec.h   | 415 ++++++++----------
>  drivers/staging/r8188eu/include/rtw_sreset.h  |  14 +-
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c  |   4 +-
>  21 files changed, 518 insertions(+), 597 deletions(-)
>

Dear Larry,

Looks good and builds fine for me.

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
