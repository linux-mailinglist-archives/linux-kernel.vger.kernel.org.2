Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A665430367
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 17:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238034AbhJPPhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 11:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbhJPPhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 11:37:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0134AC061570
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 08:35:03 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e12so31891786wra.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 08:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bEDEZvAmdvWI96ksUh1vPO5+Cce7AMzdfq8gX4cXeB0=;
        b=Hq6Ke+cYGQ7Vn7UrIUFvSLrrJjdTMhBoKwCHr+SWMz6DJQBFc0cpN8ulCOPAz98+Uw
         GCOJWmV7FD5Nk8UoWaBlITRZcLkn8Wdr9uOjhTS0235QeSm1i5O0OJ5p6EjMq6/Exfxw
         +z8Dl54DQZP0a7InF/FnOYFR/OXI6gFVnKQOLReGOwkzaBy/x6HhVE5uSw1JdHJb7gHi
         OXlQFEgfc1Lt0Gp2F4YblO8+PyfW2j88sQxKtIebocpxnrecREl/7cP4RR366mFtU1YF
         bgNis9w9NJljDB6X8sIe4Ht5eib17GmbnKDIu0YJZEjRDmMdMpLZygu+kaLHP7EWibuv
         nuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bEDEZvAmdvWI96ksUh1vPO5+Cce7AMzdfq8gX4cXeB0=;
        b=rvYmCUXSkXNJASFfpIYdzJk9xzojOULcG+N1SL4gNxgipqNMuw6r9idlh785wjuobZ
         aOU5UQ4ngjuZ1HA8m2yyW3j+haL5DhIci+LM6edHnrtH1WwE9Cokd8V5wHcMHSLd7sJb
         71c9TrFQVpGWg0ZACjCf4pUigcihvT3WCerS2Hgy0Sc0TQawt0vu8dq7PUzeo9zdhCs3
         2JzMyGySwbaZMDAczuzZjZ7Qm0dTL94UwzRD+PeMLQG3orhhbJj9opPuF3emGw4H85Eo
         +MwTnZ49S6IaCurFxea+qZ98Di9lK4VIPxfn598yBlEYmxg3x1s+Q8M1AHMOrIXsh1dy
         DOgw==
X-Gm-Message-State: AOAM5323ZR1rB+bmDJ0y+KWV+Ph3ViS1gYfWj9L/XAkNBqCMJm3Qkmyn
        y2N6Dw73F3bakdO79yLgIBPR2g==
X-Google-Smtp-Source: ABdhPJx1KZZ0aSRkB7VxIK+/Q0mee6012xL1e5KGoSoN2i8Q8t4Lj1xS2ptbyZ6iwEWSk42XpbF3tg==
X-Received: by 2002:adf:e706:: with SMTP id c6mr22879136wrm.377.1634398500950;
        Sat, 16 Oct 2021 08:35:00 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id b19sm13813559wmb.1.2021.10.16.08.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 08:35:00 -0700 (PDT)
Date:   Sat, 16 Oct 2021 16:34:58 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/8] staging: r8188eu: another round of removals
Message-ID: <YWrxIllg1fMkV1/5@equinox>
References: <20211016113008.27549-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211016113008.27549-1-martin@kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2021 at 01:30:00PM +0200, Martin Kaiser wrote:
> Remove some more dead code and unused definitions.
> 
> Martin Kaiser (8):
>   staging: r8188eu: remove empty trigger gpio code
>   staging: r8188eu: interface type is always usb
>   staging: r8188eu: remove two checks that are always false
>   staging: r8188eu: remove unused function prototypes
>   staging: r8188eu: PHY_SetRFPathSwitch_8188E is not used
>   staging: r8188eu: clean up Hal8188EPhyCfg.h
>   staging: r8188eu: remove procfs functions
>   staging: r8188eu: CurrentWirelessMode is not used
> 
>  drivers/staging/r8188eu/Makefile              |   1 -
>  drivers/staging/r8188eu/core/rtw_debug.c      | 886 ------------------
>  .../staging/r8188eu/hal/HalHWImg8188E_BB.c    |  14 +-
>  .../staging/r8188eu/hal/HalHWImg8188E_MAC.c   |   3 +-
>  .../staging/r8188eu/hal/HalHWImg8188E_RF.c    |   8 +-
>  drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  |  38 -
>  drivers/staging/r8188eu/hal/odm.c             |   3 -
>  drivers/staging/r8188eu/hal/rtl8188e_dm.c     |   2 -
>  drivers/staging/r8188eu/hal/usb_halinit.c     |   8 -
>  .../staging/r8188eu/include/Hal8188EPhyCfg.h  |  78 --
>  drivers/staging/r8188eu/include/hal_intf.h    |   1 -
>  drivers/staging/r8188eu/include/odm.h         |  11 +-
>  .../staging/r8188eu/include/rtl8188e_hal.h    |   1 -
>  drivers/staging/r8188eu/include/rtw_debug.h   | 148 ---
>  14 files changed, 6 insertions(+), 1196 deletions(-)
>  delete mode 100644 drivers/staging/r8188eu/core/rtw_debug.c
> 
> -- 
> 2.20.1
> 

Dear Martin,

Looks good from what I can see, many thanks. Built and tested on my
USB-N10 Nano.

For whole series:
Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
