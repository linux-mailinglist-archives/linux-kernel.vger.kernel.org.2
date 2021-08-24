Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF39C3F6092
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237879AbhHXOjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:39:21 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:36428 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237582AbhHXOjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:39:20 -0400
Received: by mail-ot1-f41.google.com with SMTP id a20-20020a0568300b9400b0051b8ca82dfcso25695647otv.3;
        Tue, 24 Aug 2021 07:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MNI9+l2qfeXu+JYLOWGEplhGEmiWaU2bLMFD2Oq3CvY=;
        b=NV+sFbrBMP0XTaSevG7dAMJIDzWwEMS6kcyO1rXhXC/AcD3R6JfSmc/kUf1uEwnLAC
         bl5oem1mHkzmh1EmL2A2Buq4huIw8bzgBcmZdhNfZ7P6iZG+qNrkBz03wx3FTbbrzoT7
         FofzfuR5dKGaQtB+7NXm96PlW0DbWvvxu0jA3nDbX4veazxbHrLeSM3hQsb6EBoTGJpl
         7c6tTCTeMGjMHYSdjTYD3z17OR4hYdcU9WK4aYDa9OZ9LtaaEusfIy6LbZGqI+ddsqL9
         JJ0YeeGDy/unEVqoLeWGGvnmAhvdaHYF4HqAZrIo7fJnR1UitVPmD9EUGV2Map4WMFCv
         kI1A==
X-Gm-Message-State: AOAM533Tf3VCa299nfQInQwVfLNsBcJ5ipXxRQD/OYafNl/Tk2n5AyyF
        rBy1jbpcY6FkIfVFqo1Rfw==
X-Google-Smtp-Source: ABdhPJzJ90zPnJF3juBTU2DpZSBraqMFcC+aeN/nH4SCYmWp5Rb/Lzc9lN9Xv85eo+C7Ta7aQtzlnQ==
X-Received: by 2002:a05:6808:20aa:: with SMTP id s42mr3113813oiw.37.1629815915627;
        Tue, 24 Aug 2021 07:38:35 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l3sm3987637ooo.7.2021.08.24.07.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 07:38:35 -0700 (PDT)
Received: (nullmailer pid 406532 invoked by uid 1000);
        Tue, 24 Aug 2021 14:38:34 -0000
Date:   Tue, 24 Aug 2021 09:38:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-kernel@vger.kernel.org,
        Oleksij Rempel <linux@rempel-privat.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 9/9] dt-bindings: arm: fsl: add
 toradex,colibri-imx6ull-emmc
Message-ID: <YSUEajJuiF5zQDBd@robh.at.kernel.org>
References: <20210819220910.586819-1-marcel@ziswiler.com>
 <20210819220910.586819-10-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819220910.586819-10-marcel@ziswiler.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2021 00:09:10 +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Add toradex,colibri-imx6ull-emmc for our new Colibri iMX6ULL 1GB (eMMC)
> Module and the carrier boards (so far only Colibri Evaluation Board) it
> may be mated in.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v2:
> - New patch documenting dt-bindings.
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
