Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152CC4537D5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 17:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbhKPQm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 11:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbhKPQmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 11:42:50 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13E3C061746
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 08:39:53 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id i9so21169945qki.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 08:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FZDeBwODectLe24qS+nx8i7YyWEsFffW0AzQ4wkbsEU=;
        b=Ub6vd8WvLk13+eu6ncvVRM+QdzEl6l27hu3KQOODL3HJ9Anga47jiC/OwArUD7P2zL
         7M+Ehmuz6S0kq3WsuWiHKGZInOlYmx52EHV0oe9ZBgIzoX/tNB4AJf+puICgCYH/DlUc
         KbYeb2yMa+vEn4YMuw51s2u+gfKBG2ZR98x4TXubj65Ta+AO0+qfgbNnfxOdmCx3SP7P
         MZsmU6/XBQhTUUKrm+Q8HXeM9qrFiyYSA3of/zvILfCC2diNuh8jSxq1jIWNy/bxsTV+
         n2NM0QsDhiohxqtJRsghNOEChDM5DadE9ylOVzrewqBA4pjjKTVp6ha1XsgLtBi3GGEs
         WQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FZDeBwODectLe24qS+nx8i7YyWEsFffW0AzQ4wkbsEU=;
        b=wQiXhe53YbsxKXF1FUGM9AzINXKELtxxqIUQzE5QvO/GF85ZlsrFdeZlbYZjPOAWZe
         vMu/UBkoo9YQsj2x3CsoGuL5rzCsX25Yk0sRpI/L277LCgCBLxxoWxdce7zM/Dtx6x3H
         6fXZneIjVI+1ZyVKOv77+VCtPP2P8YQymcvHKKyHrUK/677NGz0Ed0/IvwJunQO6QXHr
         2JEQZgQbnA0Qv94ScN3ZkE922MOAr/w4c09w5urqzNokT5u/WRAvfm7dbsvWat9n+ROw
         H9CcKY3TC/LZh1r/dLHQYGT8O2f4qxuLqGkUursxvhhI09NxnZv0J1pcAHXs/uVctIlM
         Zsqw==
X-Gm-Message-State: AOAM532KFNwTHs//vGsu+Gam6maZg9iU4ygLrPMtmnhcHmgdUrzSaAH3
        BuPhc3gtND5Yj7464yfE4PM=
X-Google-Smtp-Source: ABdhPJxuHUB/tw87oogapSQiw4DpwFq2TK8RCpK1m2ix6FIXJ83ruh9c2EZ+1prurv68Zej5SqXouQ==
X-Received: by 2002:a05:620a:4481:: with SMTP id x1mr7212824qkp.423.1637080792910;
        Tue, 16 Nov 2021 08:39:52 -0800 (PST)
Received: from shaak (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id m15sm5403176qkp.76.2021.11.16.08.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 08:39:52 -0800 (PST)
Date:   Tue, 16 Nov 2021 11:39:50 -0500
From:   Liam Beguin <liambeguin@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org, Roger Quadros <rogerq@ti.com>,
        Liam Beguin <lvb@xiphos.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] phy: ti: tusb1210: Fix the kernel-doc warn
Message-ID: <YZPe1iq02ZXczDtL@shaak>
References: <20211116103951.34482-1-vkoul@kernel.org>
 <20211116103951.34482-6-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116103951.34482-6-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 04:09:51PM +0530, Vinod Koul wrote:
> The comment is not kernel-doc one and starts with /**, so fix that.
> 
> drivers/phy/ti/phy-tusb1210.c:16: warning: expecting prototype for tusb1210.c(). Prototype was for TUSB1210_VENDOR_SPECIFIC2() instead
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Liam Beguin <liambeguin@gmail.com>

> ---
>  drivers/phy/ti/phy-tusb1210.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/ti/phy-tusb1210.c b/drivers/phy/ti/phy-tusb1210.c
> index a63213f5972a..15c1c79e5c29 100644
> --- a/drivers/phy/ti/phy-tusb1210.c
> +++ b/drivers/phy/ti/phy-tusb1210.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * tusb1210.c - TUSB1210 USB ULPI PHY driver
>   *
>   * Copyright (C) 2015 Intel Corporation
> -- 
> 2.31.1
> 
