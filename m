Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C62331A8D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 23:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhCHW6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 17:58:51 -0500
Received: from mail-il1-f171.google.com ([209.85.166.171]:44208 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbhCHW6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 17:58:42 -0500
Received: by mail-il1-f171.google.com with SMTP id v14so10402848ilj.11;
        Mon, 08 Mar 2021 14:58:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U0R44Nvmz+okSqV0XvPBJProqeOj+lTKatp6IXg8Mjc=;
        b=tSAm9cUBNB+uNFxM2yBiF6tL/5GO+AysdtmnU5QMyhAt60zpNit8kaChlde22q5uNt
         CP/p7IWhzkfOd1/jFDn96hczDQ/TOvtq/s5Z4gx0NaWrrB6WuqfgOGdvyvGwOhjV5I5L
         z0ajAgaN/27naTP2vtyE7xUMO57I1T/qcxX8RA5A1t4WcpS6h+trd0l/txV2d53SugOF
         7fS/wto+H31pJQ6/iPlmFroCvxK1OEKg2cU5rZrRdTsE3mlZlUyHt0O7MeKucBvEKE7m
         1ckcm+kzjCKbllw7ZKVmjWlUaotPCNg2ARhcYmGoW2/l/b2UTI7ChRM5BWXhEPRTN1D1
         NXFw==
X-Gm-Message-State: AOAM5305w5v/Tgmdtdai/GTmLiZaXHARWgWiX4yMEEq+VERyrQZLj+df
        elhv5I/Jw5LrW5lGgBVJhA==
X-Google-Smtp-Source: ABdhPJzNkfejuj25UUX75V+BVnlKrgLT02+WUgErvHz+3si8mrrV6pN6ExXJOwuameAPaP/2DJCS0Q==
X-Received: by 2002:a92:d2c6:: with SMTP id w6mr22182161ilg.273.1615244321782;
        Mon, 08 Mar 2021 14:58:41 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id u5sm6831288iob.8.2021.03.08.14.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 14:58:41 -0800 (PST)
Received: (nullmailer pid 3106576 invoked by uid 1000);
        Mon, 08 Mar 2021 22:58:39 -0000
Date:   Mon, 8 Mar 2021 15:58:39 -0700
From:   Rob Herring <robh@kernel.org>
To:     kostap@marvell.com
Cc:     nadavh@marvell.com, jaz@semihalf.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, mw@semihalf.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org, andrew@lunn.ch,
        kishon@ti.com, vkoul@kernel.org, bpeled@marvell.com,
        sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, stefanc@marvell.com, lkundrak@v3.sk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] dt-bindings: phy: convert phy-mvebu-utmi to YAML
 schema
Message-ID: <20210308225839.GA3106519@robh.at.kernel.org>
References: <20210307163343.25684-1-kostap@marvell.com>
 <20210307163343.25684-3-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210307163343.25684-3-kostap@marvell.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Mar 2021 18:33:39 +0200, kostap@marvell.com wrote:
> From: Konstantin Porotchkin <kostap@marvell.com>
> 
> The new file name is marvell,armada-3700-utmi-phy.yaml
> 
> Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
> ---
>  Documentation/devicetree/bindings/phy/marvell,armada-3700-utmi-phy.yaml | 57 ++++++++++++++++++++
>  Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt                | 38 -------------
>  2 files changed, 57 insertions(+), 38 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/marvell,armada-3700-utmi-phy.yaml
>  delete mode 100644 Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
