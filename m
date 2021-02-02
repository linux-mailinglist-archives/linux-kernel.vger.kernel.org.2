Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCB130B94A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhBBINS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhBBINO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:13:14 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BC0C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 00:12:33 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id f16so1484333wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 00:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UtGszIkdg9WNOOknjAzF5cpVs9oSS/XOJFgkzx2VHUg=;
        b=DWN6+ht8i7YxICH5WPY4Cq+8/qwpbhSgZPyufefIPTt+K/e7HDwyILEXei5zzE6utZ
         J89zy4PAL1yr44hqZv6NRlr67CEhTVlVYQWW1nIY0PR3b5rCVKnv9Z7mA3c/X9R7X9Hm
         ISaA5oEgnfyy8WU0F5NhUg1wJeHn3T1uPCgk5b9Lb3qkoVF2lIqa7aBomkVS9mtx+eVG
         LbkeOZkbyHSEK9Ra5XLCwj2j6klrFM8QUd24Rp0vATaS+YgVj3hOLbiXow8d6Gc3uZ0Y
         XVm8ScrYKlctL2Tv5UhKpL2Cbw8/5owsxjLcUqG7NejUjryL0QjCYxbDqp45SlYrJiIp
         O+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UtGszIkdg9WNOOknjAzF5cpVs9oSS/XOJFgkzx2VHUg=;
        b=iw1neGDDS6lG8bERhZ5jKh+ZbBkahenqqRj6/ggeXV67k1NEKY0BYFpyt6r80XCvtE
         PAVTZQmjBYUbMnTYkWgiTYWNR7Onf1QiVQtzWFGP4RsdmumJvwOr0mnLhBpJjkyVpwbH
         deKSXUxZy11pkZfpjyQGP032ufq5VDLlOc2AQ48h03yZ7T2QtMD1OvDPC3CHBJFUhjG6
         FBhEzzOPfBOB4vhEvEvK3vsfsqnz55QWCpyqj7pu/LBvR8U0oMO9xGqXAeSfbwghyiI6
         CJPRb4kloV557qEBabGfufHI92mJViSE+edlRUqSt3/tWH9EoKaUQLu1gbMJZnXVrxq9
         GniQ==
X-Gm-Message-State: AOAM531k8SzVgb2lfF992zPMOfvQvjhaI3/TYAO424lQit2RWvww+3xG
        WiJCMjJiKcTa8MDIHlmyHtPcDA==
X-Google-Smtp-Source: ABdhPJycdGMBdOipEvQ0lbsak6nLz9SLAIGAtx0Aw0BMXZG7S1vXOQWcRZbcRBY0aehf8GYKghvX6w==
X-Received: by 2002:a1c:68d4:: with SMTP id d203mr97951wmc.153.1612253552331;
        Tue, 02 Feb 2021 00:12:32 -0800 (PST)
Received: from dell ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id y18sm29352427wrt.19.2021.02.02.00.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 00:12:31 -0800 (PST)
Date:   Tue, 2 Feb 2021 08:12:29 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh@kernel.org>,
        =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v5 06/20] mfd: axp20x: Allow AXP chips without interrupt
 lines
Message-ID: <20210202081229.GW4774@dell>
References: <20210127172500.13356-1-andre.przywara@arm.com>
 <20210127172500.13356-7-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210127172500.13356-7-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jan 2021, Andre Przywara wrote:

> Currently the AXP chip requires to have its IRQ line connected to some
> interrupt controller, and will fail probing when this is not the case.
> 
> On a new Allwinner SoC (H616) there is no NMI pin anymore, and at
> least one board does not connect the AXP's IRQ pin to anything else,
> so the interrupt functionality of the AXP chip is simply not available.
> 
> Check whether the interrupt line number returned by the platform code is
> valid, before trying to register the irqchip. If not, we skip this
> registration, to avoid the driver to bail out completely.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/mfd/axp20x.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
