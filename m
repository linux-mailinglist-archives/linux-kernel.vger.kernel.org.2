Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B4D421DD8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 07:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhJEFRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 01:17:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229979AbhJEFRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 01:17:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DE806126A;
        Tue,  5 Oct 2021 05:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633410962;
        bh=eU19dax//0ARGyclUGvOP2GXyLlBh9R1Ptu/E1Dag1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ElKn+tGZk/6j37Muf57nAGcu5o+RU4Y78eoBNwf+mTv0M9jJ8M7rCcVnU+yDYlOwf
         isBVVl+1Y2hCMNFmOPnC6h9HZdSrv/GJ6b4yhp89VUhSuew/gQygXlLRydu9ObZese
         eDmCGL1CPQmRlAzP0YhwoX+BQE42PVvYKB4Doryw7eP8N4xbXLoR6Qt9GfBOUx6YkT
         zlXMmwmDGe2X4/pn6hcuRyNK0v1JsgmdnNWVZaUHszdtz9edY+XMelc85katubUpcl
         xeaGbq9civfPF1vixcoTk6PohYnXDjdiiHXObn0rwnO16JvRtAyhv8ORUQ14EoiV6A
         iGxyS3BzGLFUw==
Date:   Tue, 5 Oct 2021 13:15:56 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH] ARM: dts: imx6dl-b1x5v2: drop unsupported vcc-supply for
 MPL3115A2
Message-ID: <20211005051555.GI20743@dragon>
References: <20210920182227.339577-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920182227.339577-1-krzysztof.kozlowski@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 08:22:27PM +0200, Krzysztof Kozlowski wrote:
> The MPL3115A2 I2C pressure sensor driver does not take a VCC regulator.
> The bindings are so far trivial, but the datasheet does not have a VCC
> pin.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Applied, thanks!
