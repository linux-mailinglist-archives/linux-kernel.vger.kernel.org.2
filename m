Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE47331840
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 21:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhCHUMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 15:12:40 -0500
Received: from mail-il1-f169.google.com ([209.85.166.169]:44236 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbhCHUMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 15:12:08 -0500
Received: by mail-il1-f169.google.com with SMTP id v14so10005881ilj.11;
        Mon, 08 Mar 2021 12:12:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yasEJeQju9ruKqeT1SfdbZhdyQswUTW4B4aCP+GfWzQ=;
        b=dry5EGmy6wZVgXTmyvyScznUXtheGOM7mAGH7+sIaokNyMzWDtP6KjOZFWLb9eRSXB
         bDxQQ1NuOtSMPlFghBuKBL9vUENMw+D5uQS+z14o/3e1/Auvb2CHZ0C6UAfoTqIE8uEZ
         73/FW+zVCUAJE3bMbOZN1E9YVu7Dh7zXu4OnUUzYlRvX/d3y0+sc61eioQcPOiodCiv/
         gZtslXLYRdzqDZKFf8Z7+gx5jBijFGLiKYw4eTXv6/uZlqiHP65aA6dxz0CS2MeeadM/
         JYcUCldyiRnpBh7on8Vg3xboGoMlCdJH6khX4NXCFks76MZEBPNX+UlXtHjpaVNIIQtc
         fxwg==
X-Gm-Message-State: AOAM533/Sr3lPwWYavDOPD5fXi5yIy0ImWp1D6UvlFwDvsDnKaHdw/OB
        3hQpimdeLs/48htXHvx4IeqcsoJCww==
X-Google-Smtp-Source: ABdhPJwxTFj7BqCTNCv+JmT2D+VrEmzqJ3x7eTHxx0+X1cS0mW1M8V+p1GoWZEbcZVLdlUmGoonNwg==
X-Received: by 2002:a92:d6c8:: with SMTP id z8mr21366145ilp.162.1615234327469;
        Mon, 08 Mar 2021 12:12:07 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id z28sm1873102iow.12.2021.03.08.12.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 12:12:05 -0800 (PST)
Received: (nullmailer pid 2884518 invoked by uid 1000);
        Mon, 08 Mar 2021 20:12:03 -0000
Date:   Mon, 8 Mar 2021 13:12:03 -0700
From:   Rob Herring <robh@kernel.org>
To:     Heiko Thiery <heiko.thiery@gmail.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
        Michael Walle <michael@walle.cc>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: fsl: add Kontron pITX-imx8m
 board
Message-ID: <20210308201203.GA2884463@robh.at.kernel.org>
References: <20210303211002.17650-1-heiko.thiery@gmail.com>
 <20210303211002.17650-2-heiko.thiery@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303211002.17650-2-heiko.thiery@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Mar 2021 22:10:03 +0100, Heiko Thiery wrote:
> Add the Kontron pITX-imx8m board.
> 
> Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
> v2:
>  - bring in correct alphabetical order
> 
> v3:
>  - no change
> 
> v4:
>  - no change
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
