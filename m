Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4083F608D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237875AbhHXOjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:39:04 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:41943 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237582AbhHXOjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:39:03 -0400
Received: by mail-ot1-f50.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso31785875ota.8;
        Tue, 24 Aug 2021 07:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r/EQ+33QCNP27vxk3z7IuZwnDM0ktRD73sVhv+r8KKA=;
        b=GmGjY9kc5KI7vdVpStheQ8/8O0zjDavcq9nW0XYx6C26Ow6BbVsEyXBIWABPThZ6Nn
         m/pzAqBCBbnEogoyDVrX+kyVJNvraBCQbb939PnYCdII5ranlSQIjnASZLv5S/D2aZ3M
         7r/imndpHtIFZAOUqWzuLDtsdoj+3I1mDc7Xw1wOMzQDXfAABmBb3+/ZgaorDqcm7oVa
         ioO9gYGWhzWypXtrTsc8nHt6n2Q1VlcWV7uacQci67qjs8ICVCniIfPIPisIYt3HomBY
         IcUzxGhgPtpC626pVb9CIUUJ5t4sl3GpKuckRPbDK2+UfmLrRqqeFu4U+fmZldJYXyzu
         VFLw==
X-Gm-Message-State: AOAM530Kab0DL/9NOMk7Kjo0lQGGVvlTupyE7iG5DAjA6oweBROL7/RM
        6pmmm6GWZkMTn2484AlFIA==
X-Google-Smtp-Source: ABdhPJyBv7ulV8m4IWRFGnNbURhqNpk+030KVbBzFfDV1mDfV27xpm8z0/4P1Us+hzwqHj4crV0EVQ==
X-Received: by 2002:a05:6808:188f:: with SMTP id bi15mr3208144oib.53.1629815898105;
        Tue, 24 Aug 2021 07:38:18 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x12sm4448658oie.56.2021.08.24.07.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 07:38:17 -0700 (PDT)
Received: (nullmailer pid 405979 invoked by uid 1000);
        Tue, 24 Aug 2021 14:38:16 -0000
Date:   Tue, 24 Aug 2021 09:38:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, Li Yang <leoyang.li@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 7/9] dt-bindings: arm: fsl: clean-up all toradex
 boards/modules
Message-ID: <YSUEWO++4FrLS8LL@robh.at.kernel.org>
References: <20210819220910.586819-1-marcel@ziswiler.com>
 <20210819220910.586819-8-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819220910.586819-8-marcel@ziswiler.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2021 00:09:08 +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Simplify and unify the distinction between modules and carrier boards.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v2:
> - New patch cleaning-up dt-bindings documentation.
> 
>  .../devicetree/bindings/arm/fsl.yaml          | 79 ++++++++++---------
>  1 file changed, 41 insertions(+), 38 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
