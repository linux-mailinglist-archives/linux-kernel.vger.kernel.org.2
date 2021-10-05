Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93ADC421CF8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 05:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhJED3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 23:29:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229659AbhJED3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 23:29:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2A3161373;
        Tue,  5 Oct 2021 03:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633404480;
        bh=Ohsq9znQmWhENvkW5HsqhWxCxHfB0ae6f2IlpQnKDWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qW4tiyRwclCNFwfucqWYu2TCLHQx7oUvNr8wnaE2Q8s2PfDumnKMgo/ypJGqntEq4
         GMYl22gUkC2VOZxbODGI6VuaDtjnMROR7CWzI+JxEA9UyVPgRvSYxl1cNEaDGusdmn
         wwfp9zQo1UmizS34RViK5Cx3USSZMFp8VY9siKBB7fZIGLLCIzMM5q2mx61qiYc58R
         VyxXYJLnRjxDUuc6pepe5qniTi0IR4o7CFhtbCsM6rlrsndcs1L6on9Trv0jO1RjRe
         AEFykrtOYpsFZoerNqunI50oAc0K1SCzWv8GQbN6O6ahbUPahAwto5qVYhC0zdW6eG
         4YP1ri8leegiw==
Date:   Tue, 5 Oct 2021 11:27:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Rob Herring <robh@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/9] dt-bindings: arm: fsl: clean-up all toradex
 boards/modules
Message-ID: <20211005032752.GF20743@dragon>
References: <20210920144938.314588-1-marcel@ziswiler.com>
 <20210920144938.314588-8-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920144938.314588-8-marcel@ziswiler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 04:49:36PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Simplify and unify the distinction between modules and carrier boards.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks!
