Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6F13D94AE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 19:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhG1Rz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 13:55:27 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50376 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229581AbhG1RzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 13:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=hpRbk0yCaD06IT2pljlpFDQ+YXKte4gavVlH1cev1Rw=; b=3TqZYHyMWBYfoFw895VTj5AHTx
        L059GjKxNd/svHThIWsqVNnhCK/2FDLfwgFKZaKuQNISIwNCjPS6Ftix2BEc8yjgXM481q5PCRqcj
        2AA+3o6sB3Bs8P8H/Bygb8bfir6xaHyHsIAdrm0hWP9oTDx5f58F31Pa9Ne6mwWuAuic=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1m8nlw-00FDLz-HE; Wed, 28 Jul 2021 19:55:12 +0200
Date:   Wed, 28 Jul 2021 19:55:12 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Simon Xue <xxm@rock-chips.com>
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: rk3568-evb1-v10: add ethernet
 support
Message-ID: <YQGaAFvqqc7wXrWD@lunn.ch>
References: <20210728161020.3905-1-michael.riesch@wolfvision.net>
 <20210728161020.3905-3-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728161020.3905-3-michael.riesch@wolfvision.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 06:10:20PM +0200, Michael Riesch wrote:
> +&gmac0 {
> +	phy-mode = "rgmii";

...
> +
> +	tx_delay = <0x3c>;
> +	rx_delay = <0x2f>;

Hi Michael

In general, we try to have the PHY introduce the RGMII delays, not the
MAC. Did you try

phy-mode = "rgmii-id";

and remove these delay values? It is hard for me to say if that will
work because i've no idea what 0x3c and 0x2f means? Are they
equivalent to 2ns?

     Andrew
