Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6CD3D1C22
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 04:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhGVCNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 22:13:30 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:37636 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbhGVCN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 22:13:29 -0400
Received: by mail-io1-f44.google.com with SMTP id r18so4717616iot.4;
        Wed, 21 Jul 2021 19:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6jqODs76F2z+ThTv3XQxZcm2LvsH3LDON/fyPSmSUtg=;
        b=D9S+ckg/Us1T6mmla4IAq47W7NhgApriIjlnHw0bm7zAmgdXTyqleSrF41VSUKz7Dm
         eFO1LpEvYyJxRCnjLbwuU+A82JCQk3ownypuAdIRUvuIsdLXd+8JYfJ7HexKgZAPD44d
         3StmzTqJbSj4UI+wU2kGFc4noCDoOaPamrALkNyi99WiRQWuwM+nCYlHgNJPLP5i1VOn
         AI/hI3pRTWZdNYsyOpIW9qSJdVvaZGtuCvV7f3JsX0Xn/n2lEKXZ0OyJtrTdP2gYB/dM
         vAwamk8JD/U/3BggyuNo6dEdKEnVG9u5lQS2oqIhk06gz1XK6Wz5Uc4KV7WWLA/8Okgs
         AIVQ==
X-Gm-Message-State: AOAM533AAffBp9IBDAzDYSJ0JFukC9dO/t/DsQ2Mp4geJk3hnDjlfjNs
        qvb7mubGnYkRIT3heT3FvA==
X-Google-Smtp-Source: ABdhPJyasxgbYXRpKxgQ1GV+cQ2nV0FBlw7vLICuO8TDGev3IifKvA9D5r04JJVI+4C0GGF7HC2SnQ==
X-Received: by 2002:a05:6602:2e11:: with SMTP id o17mr19963592iow.55.1626922443950;
        Wed, 21 Jul 2021 19:54:03 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r6sm15640391ioh.27.2021.07.21.19.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 19:54:03 -0700 (PDT)
Received: (nullmailer pid 3207422 invoked by uid 1000);
        Thu, 22 Jul 2021 02:54:02 -0000
Date:   Wed, 21 Jul 2021 20:54:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: imx: add imx8mm/imx8mn GW7902
 support
Message-ID: <20210722025401.GA3207393@robh.at.kernel.org>
References: <20210715141750.11612-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715141750.11612-1-tharvey@gateworks.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jul 2021 07:17:49 -0700, Tim Harvey wrote:
> The GW7902 is based on the i.MX 8M Mini / Nano SoC featuring:
>  - LPDDR4 DRAM
>  - eMMC FLASH
>  - Gateworks System Controller
>  - LTE CAT M1 modem
>  - USB 2.0 HUB
>  - M.2 Socket with USB2.0, PCIe, and dual-SIM
>  - IMX8M FEC
>  - PCIe based GbE
>  - RS232/RS485/RS422 serial transceiver
>  - GPS
>  - CAN bus
>  - WiFi / Bluetooth
>  - MIPI header (DSI/CSI/GPIO/PWM/I2S)
>  - PMIC
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
