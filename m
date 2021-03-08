Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9DC331066
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 15:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhCHOIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 09:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhCHOHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 09:07:48 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17616C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 06:07:48 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d15so11607719wrv.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 06:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=67p4kVEdQcLqsqeRNFk9Be2uM7oDzD/JRQWZyk0AvmY=;
        b=kncpZpypUCLKk3aF15ZYEnmqI/KTHACwNEMW6S5FT9TYje5pJ/VXRcHoaA5Rag0KmT
         +II1YZIE1PH12BMWDXGlqKqSclkTnnVehfrO7HSrzSPty+cySja4pzqRwSxM1heE7hQi
         gEdU66nlyTc571ouyggnGeOo4Ztb+puOYZ+OaseXrwMAsUK2nAICNgqPhrhpt2O62LOI
         XuyZPvSJ/i2Y3IpSAVRSPLpZzxb5ZHc1p+/C+uH7wVtPMV3FSDIvIHwsWVAVk4BrNRCz
         2a4Ud4kI4lGjNEDACBvEHnNaKvN4QyIbvUbADhQUWSjgU2+kRBXeiG9fqJijnuCn9yyz
         GVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=67p4kVEdQcLqsqeRNFk9Be2uM7oDzD/JRQWZyk0AvmY=;
        b=Pf+qXLgEh1ArucWdNkkr83Q0hIY1rso8pYtSr215GRa6clQtj+dmWeDbnK72t0Htf7
         BbMtVddOvnTs68Z6zYbPE/LUtKQUlSqpuT+nYURBUa1+/4dFp4ahrnryD3x8HQhwpUiX
         xWVeTrACDj7pKGc35UwI0sACgoGGjurLGYyeyjw5ySWXI55EqlS8qP3fAVCGvpbxIIMg
         j1qIJcR8jk/ppOiJ+aDuUpZGgta0txnoqToevjBDDO8RqDysUyJ5ispcI179XKKPIb1g
         JsBl8cD8QesAEBGSp8QuUiDtkfgNBw689Gjg7gR3LIvDXV2ci2h0rk2GAv2FrG/VpijR
         3E8Q==
X-Gm-Message-State: AOAM533p4R2250C17/99hVwo+jOJzNte9WA/d5Uw+n5zQzrBXi0unc3c
        +GsnFhz9yT1FIArhDI9aS8u/sA==
X-Google-Smtp-Source: ABdhPJyrNSEKao0oh/Ds9oN0i3eOUKR+2NZcXAzKeV9pu6rKMUFDYYkK0htjHP+3MbpphcEVt5pn3A==
X-Received: by 2002:adf:ec46:: with SMTP id w6mr22706119wrn.213.1615212466860;
        Mon, 08 Mar 2021 06:07:46 -0800 (PST)
Received: from dell ([91.110.221.130])
        by smtp.gmail.com with ESMTPSA id b131sm19226315wmb.34.2021.03.08.06.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 06:07:46 -0800 (PST)
Date:   Mon, 8 Mar 2021 14:07:44 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mfd: lp87565: move LP87565_regulator_id to .c file
Message-ID: <20210308140744.GJ4931@dell>
References: <20210219223910.1831-1-luca@lucaceresoli.net>
 <20210219223910.1831-3-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210219223910.1831-3-luca@lucaceresoli.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Feb 2021, Luca Ceresoli wrote:

> This enum is used only internally to the regulator driver for buck indexes.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  drivers/regulator/lp87565-regulator.c | 11 +++++++++++
>  include/linux/mfd/lp87565.h           | 11 -----------
>  2 files changed, 11 insertions(+), 11 deletions(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
