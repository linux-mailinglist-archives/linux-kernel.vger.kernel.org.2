Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D66244CAA0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 21:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbhKJUaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 15:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhKJUaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 15:30:18 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D15C061764;
        Wed, 10 Nov 2021 12:27:30 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id z200so3293233wmc.1;
        Wed, 10 Nov 2021 12:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VCO5uvUOcT27e+DRykZRIen3xP0SFPGTd6Mp1JZTAsY=;
        b=HThajDrDc6kB1OnizIXhqzZNZZvMfdEHMWtMO4M30i37Pl73wkt59s0uAsKI/RdkPF
         1wk6JxgmAhSrbRsPWAIvz6B3dIzTqP1/gcXhrAg3Kw18a7B2hIY3mE0EgiG057B8KZUy
         2r4dyL/l4YIrur+Kn5hq7L8zexNdXLUoevOaZRRL88bHNDHY//iJvBd2HxSsP/+sevHM
         tY78m10uixmloXgSMDKdn29FiasKIn3plMw6EOexg0Mz5o2pMLWAK4GZFdnnyT0Wr1xo
         31pw1Ol0dCl/18DjBGfMtfvKMD+VkFS36tRt/sMqI0UGRF8tV70VpN2eqyLFtlwLzfWL
         U+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VCO5uvUOcT27e+DRykZRIen3xP0SFPGTd6Mp1JZTAsY=;
        b=aWsyzI4Qg7XmGLPdepe4Ej//TNIEU7C0N1HicsmVvKeNpN8NKEh91DZq++kTwJWNa/
         9nLKjOzhAaW3ZDeYkfjGSoUnkDrvZnyQpvDy7m4Zf+7DaJtmkBvHjC51GbEatkuaZEnH
         dd1kuRQDvEl3p4HckgIGqQVfJdIYTKR9dKMPrrDKtLuLhIBr2PNHIENasWcr3uj93haC
         zixb0RNucRntybkqzWI51UqDBjuzydxgt0soSOECgslx341/cGySsfxPZeynTIwKY1ZN
         mRKBwDfljoyrm0zMIdyk/wdXhp65tsyQAOIvp3HhNqEhxK7fsdel+cjAA7U6QObeqfUf
         4ZJg==
X-Gm-Message-State: AOAM532E2i5qpsTHZ5DayuOKgDU79SLAT8q0Kccsmt3MzPs5Sbopuvbj
        hzs56tV7qOeXuzsvtSVlgE0=
X-Google-Smtp-Source: ABdhPJw4KjDz2RofXLwp2G67jkwH49HdpJCT6V9QEt9aux7cGkvEY9V4DGLIjaCPxROLcjclfo3KDw==
X-Received: by 2002:a1c:4d13:: with SMTP id o19mr2192192wmh.164.1636576049474;
        Wed, 10 Nov 2021 12:27:29 -0800 (PST)
Received: from kista.localnet (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id q123sm6506007wma.30.2021.11.10.12.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:27:29 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@lists.linux.dev,
        Roman Stratiienko <r.stratiienko@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, wens@csie.org, mripard@kernel.org,
        b-liu@ti.com, megous@megous.com,
        Roman Stratiienko <r.stratiienko@gmail.com>
Subject: Re: [PATCH] usb: musb: sunxi: Don't print error on MUSB_ULPI_BUSCONTROL access
Date:   Wed, 10 Nov 2021 21:27:23 +0100
Message-ID: <7984413.T7Z3S40VBb@kista>
In-Reply-To: <20211019131244.1568560-1-r.stratiienko@gmail.com>
References: <20211019131244.1568560-1-r.stratiienko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

sorry for late reply.

Dne torek, 19. oktober 2021 ob 15:12:44 CET je Roman Stratiienko napisal(a):
> Error message appears during suspend, where musb driver is storing
> the register state in musb_save_context():
> ```
> musb-sunxi 1c19000.usb: Error unknown readb offset 112
> ```
> 
> Print warning instead to avoid confusion.
> 
> Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> ---
>  drivers/usb/musb/sunxi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
> index f3f76f2ac63f9b..961c858fb349e1 100644
> --- a/drivers/usb/musb/sunxi.c
> +++ b/drivers/usb/musb/sunxi.c
> @@ -440,6 +440,10 @@ static u8 sunxi_musb_readb(void __iomem *addr, u32 
offset)
>  				return 0xde;
>  
>  			return readb(addr + SUNXI_MUSB_CONFIGDATA);
> +		case MUSB_ULPI_BUSCONTROL:
> +			dev_warn(sunxi_musb->controller->parent,
> +				"sunxi-musb does not have ULPI bus 
control register\n");

Since this register doesn't exist, wouldn't be better to print only debug 
message? Warning would imply something that's out of the ordinary, but in this 
case it's benign.

> +			return 0;
>  		/* Offset for these is fixed by sunxi_musb_busctl_offset() 
*/
>  		case SUNXI_MUSB_TXFUNCADDR:
>  		case SUNXI_MUSB_TXHUBADDR:
> @@ -494,6 +498,10 @@ static void sunxi_musb_writeb(void __iomem *addr, 
unsigned offset, u8 data)
>  			return writeb(data, addr + 
SUNXI_MUSB_TXFIFOSZ);
>  		case MUSB_RXFIFOSZ:
>  			return writeb(data, addr + 
SUNXI_MUSB_RXFIFOSZ);
> +		case MUSB_ULPI_BUSCONTROL:
> +			dev_warn(sunxi_musb->controller->parent,
> +				"sunxi-musb does not have ULPI bus 
control register\n");
> +			return;
>  		/* Offset for these is fixed by sunxi_musb_busctl_offset() 
*/

Same here.

Best regards,
Jernej

>  		case SUNXI_MUSB_TXFUNCADDR:
>  		case SUNXI_MUSB_TXHUBADDR:
> -- 
> 2.30.2
> 
> 


