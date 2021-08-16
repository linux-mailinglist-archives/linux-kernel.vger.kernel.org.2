Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA253ED427
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 14:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbhHPMmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 08:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbhHPMkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 08:40:06 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29EAC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 05:39:14 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k29so23380086wrd.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 05:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rzZaQ6s2L8HTP/N+G7lyZXAfcU7PndFNzvU/KdGwi9Y=;
        b=QlNlgUbNjG0m1HA8MWuitLFzXBkPqVYzU+AdZ45Rd3gQXpgaysrPo86WK3Ch/6sbjA
         0Jup9IUiYxa7n3h3p5kWtOlZc50ulFWd4uMRk/T4adIIgemWs1nFyU0k0XvL9NBhs5dp
         8lRqkR7wt65s6amS0/hvZtr2N6joSDuPXh1Zo8gPXdJ79VwEweICP3zbLQ9MuFSD0ERY
         VQl89N0JdOugZbtKNiXniryTiHttwZr5XPWCIiQ/9wuVrZn48LHDIvl2XaCTBM7HkZZ6
         E4gzvEbRQQlv6lnFL/3nx1X9SUCzHbLd7hFLz4N6uKVvZE3RJlQE7gHjsEgpv2NYBv+v
         dQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rzZaQ6s2L8HTP/N+G7lyZXAfcU7PndFNzvU/KdGwi9Y=;
        b=rKEVyjjRXgfG0DO7lYsL7Alc+1i6LX9nz4smJhnGs52MmtCXTPcKnyPFziEB2+weKU
         ey4x4pUBpRbMJ37LQ89opow4MYBLgVEx51YG7ETxHLCjJr3JqgzIfVxhBhuOBmJLjwTr
         SFAvnilmjGxH8oiSBK5K45ZQdlJ9G45gg3+qNFvdVFuHDjOjqmgkWmAIs6kMZuSHliFX
         Fo2h/4d67RwjhFxCzW+2MwNnjQknuAntJwD5WL/5LO4NpotH9cuVU00ixwKB0PBiGfvh
         LnFRDtIkxz90E3+PSb8HDiCDWbbu2KCh321m8DhfWxC/yErRAduUeGQFm/YrMXyQQCt5
         m9/A==
X-Gm-Message-State: AOAM530RMYVI4ubHOw8FfgMeYMhG6QQl4/W+auzOmq9Y/WTfsb2VuApS
        JdbtEAwogzA4vG/ThNrwj5yLmQ==
X-Google-Smtp-Source: ABdhPJweINsp2xPplWcV/+0/jpRqDBMONwmRcfnXbq5OUUxaouSweFzLLHnl0sy+OcrlhnZhe5uGpA==
X-Received: by 2002:a5d:4143:: with SMTP id c3mr6512603wrq.29.1629117553329;
        Mon, 16 Aug 2021 05:39:13 -0700 (PDT)
Received: from google.com ([2.31.167.59])
        by smtp.gmail.com with ESMTPSA id r129sm10460277wmr.7.2021.08.16.05.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 05:39:12 -0700 (PDT)
Date:   Mon, 16 Aug 2021 13:39:10 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 01/11] dt-bindings: mfd: axp20x: Add AXP305 compatible
 (plus optional IRQ)
Message-ID: <YRpcboGSk+WyLLy8@google.com>
References: <20210723153838.6785-1-andre.przywara@arm.com>
 <20210723153838.6785-2-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210723153838.6785-2-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jul 2021, Andre Przywara wrote:

> The AXP305 PMIC used on many boards with the H616 SoC seems to be fully
> compatible to the AXP805 PMIC, so add the proper chain of compatible
> strings.
> 
> Also at least on one board (Orangepi Zero2) there is no interrupt line
> connected to the CPU, so make the "interrupts" property optional.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
