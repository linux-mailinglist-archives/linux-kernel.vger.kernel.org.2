Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D24311B31
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbhBFEzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:55:55 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:35189 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbhBFDcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:32:00 -0500
Received: by mail-oi1-f179.google.com with SMTP id w8so9716429oie.2;
        Fri, 05 Feb 2021 19:31:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qlPHn1zu3Nj5a2XbduHCaC0wb+5vaXTES3SjR5xPKC8=;
        b=lAGvZq4spu3xsgrx32UE4dydDMgDwvEB+w5V3tv5n01X5ZYz2Q1A8h/EpWaSwcyF4O
         G1TRoWteILABMQDZ74nXDiCWkO/fCWPXQUw8mZhS7udCuiIHKrnhYB39j4lgjwH4YyHY
         vJK9qoN+QEyUPD4oO/+AQNF3zeHfriN9COSgJAe3wY0hvPNvnJk81cj0tG9a2OFbi3wz
         Z7UT0run9uE0ZsuqbCAYz/CHlXFFCSb+hpP2V/M7RxIpaESLiX2nbA3qeTSTJhjedyPi
         83p6qUFNnNgdFXzF+Xb2hGrl4neozVqEJ+Sjjtnw3XbJ4dMtXmyNmmpK5XlyMgkG3T67
         ax0Q==
X-Gm-Message-State: AOAM531xDMN2rNR5+0YgtOTCoaSFZLUZCCvigUn0vMGekAgyVqetmXh2
        3TTiquzo3IFZOOy496NunpomlnVAVQ==
X-Google-Smtp-Source: ABdhPJxXWV4md4ANTR8X9CzeXHL7V98dRZFkC9Oq7Owm4qiYTcLtMeDnOnJ2opiFFAhiPHkTV+InJQ==
X-Received: by 2002:aca:6141:: with SMTP id v62mr4328091oib.30.1612562301500;
        Fri, 05 Feb 2021 13:58:21 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h133sm444618oib.2.2021.02.05.13.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 13:58:20 -0800 (PST)
Received: (nullmailer pid 3823871 invoked by uid 1000);
        Fri, 05 Feb 2021 21:58:19 -0000
Date:   Fri, 5 Feb 2021 15:58:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>,
        =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <mripard@kernel.org>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 15/20] dt-bindings: net: sun8i-emac: Add H616
 compatible string
Message-ID: <20210205215819.GA3823814@robh.at.kernel.org>
References: <20210127172500.13356-1-andre.przywara@arm.com>
 <20210127172500.13356-16-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127172500.13356-16-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jan 2021 17:24:55 +0000, Andre Przywara wrote:
> Add the obvious compatible name to the existing EMAC binding, and pair
> it with the existing A64 fallback compatible string, as the devices are
> compatible.
> 
> On the way use enums to group the compatible devices together.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml    | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
