Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB8E3975D8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 16:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbhFAO52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 10:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbhFAO51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 10:57:27 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF45C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 07:55:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id c5so3489326wrq.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 07:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fLxy2iSD/5MnaT4nIO5iGSkQ6bLVBOzjqCDmtpnS/jo=;
        b=YKbTWsWSSDFVBeYgEii7BPOB2yvfS/i1MPHuLpCZABdFyDQXZ2cAaT/ox7cjTG7Xx1
         9mhYyWJPLE2lg0bnI+/O5GtZ4IpYMKIuzPphRc2/R24lXkObnkDNWE1ySjHap1I/OfEM
         odCJLh+EtmREg+fKvTCwsML+Ldqh+nFx0TwYdYlboQIid/5f8DId/o5eRUDz4cqelE1g
         I4aj4IGGo02CzdPeQZnx846WAvO1nlZUzYjEz7pNWbGXpepuEL2umJN5PEqSBArMRhMp
         qZl/qxOcWxB2ulxPHgon81lrOzHCmnDBevxAbE5yeaQ3xG2Rol/V6PME5qH9uVbNPWFb
         Ys9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fLxy2iSD/5MnaT4nIO5iGSkQ6bLVBOzjqCDmtpnS/jo=;
        b=frV+ykG/Gyx22lmYE2Yx5MZ/02Gvyf5B7ad83Sb4zuD492VfJ0GXW8l04psavB55uC
         zD1UUuQlIVU65/PcVIM61H+6ixRpw6Zj3LpJUqS9GqFVXDxvqv9oaYjwTrmH8HZMzSnC
         VxbmK4xkrXvfQlYBvZFs04i67I8TgclV9n7gKwRMozB4pZf6OP3jE7tHzD61X4qx+zXL
         HXEnxS6v1MphhXXGGNllazffaSBwkUmaYnMWXtWP0kHLspwrRBQqI33YjFJ2Kz/pzszA
         H9zZsg97Nez/46XsaK6QUqVtymI5FKU32Bm+Ld1mHyqayzG3dXIeO2t1hgneIGld1ffF
         Kcgw==
X-Gm-Message-State: AOAM531DnhSq2Go6vCPbCEkGzXuAuQP9W3XW8efKURlyj6Yz1qM8+hiN
        evPyPXzMZ/4xm/cClHzAE9ugfA==
X-Google-Smtp-Source: ABdhPJwlNUaz71BiaAIgsLuvmQ6I5YX1jsdRxW7f7MC8W0Nu84kyL2c6LCsUWdrALoOE3RfoSm4z3w==
X-Received: by 2002:a5d:6405:: with SMTP id z5mr16962858wru.39.1622559343225;
        Tue, 01 Jun 2021 07:55:43 -0700 (PDT)
Received: from dell ([91.110.221.249])
        by smtp.gmail.com with ESMTPSA id 31sm4007364wrc.96.2021.06.01.07.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 07:55:42 -0700 (PDT)
Date:   Tue, 1 Jun 2021 15:55:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Ivan Jelincic <parazyd@dyne.org>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        "Sicelo A . Mhlongo" <absicsz@gmail.com>
Subject: Re: [PATCH] mfd: cpcap: Fix cpcap dmamask not set warnings
Message-ID: <20210601145540.GM543307@dell>
References: <20210522051001.53060-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210522051001.53060-1-tony@atomide.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 May 2021, Tony Lindgren wrote:

> We have started to get a bunch of pointless dmamask not set warnings
> that makes the output of dmesg -l err,warn hard to read with many
> extra warnings:
> 
> cpcap-regulator cpcap-regulator.0: DMA mask not set
> cpcap_adc cpcap_adc.0: DMA mask not set
> cpcap_battery cpcap_battery.0: DMA mask not set
> cpcap-charger cpcap-charger.0: DMA mask not set
> cpcap-pwrbutton cpcap-pwrbutton.0: DMA mask not set
> cpcap-led cpcap-led.0: DMA mask not set
> cpcap-led cpcap-led.1: DMA mask not set
> cpcap-led cpcap-led.2: DMA mask not set
> cpcap-led cpcap-led.3: DMA mask not set
> cpcap-led cpcap-led.4: DMA mask not set
> cpcap-rtc cpcap-rtc.0: DMA mask not set
> cpcap-usb-phy cpcap-usb-phy.0: DMA mask not set
> 
> This seems to have started with commit 4d8bde883bfb ("OF: Don't set
> default coherent DMA mask"). We have the parent SPI controller use
> DMA, while CPCAP driver and it's children do not. For audio, the
> DMA is handled over I2S bus with the McBSP driver.
> 
> Cc: Carl Philipp Klemm <philipp@uvos.xyz>
> Cc: Ivan Jelincic <parazyd@dyne.org>
> Cc: Merlijn Wajer <merlijn@wizzup.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Sicelo A. Mhlongo <absicsz@gmail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/mfd/motorola-cpcap.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
