Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A6D3D96DF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 22:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhG1UiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 16:38:01 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50656 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231571AbhG1Uh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 16:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=R7bNU8BZCOB5iHa54MHFRtshuOZCZQe5szk1h/9GSv4=; b=J3gS7vLVbdobYkuyQnS/5NIZXG
        LM0+y/ogncES/luhSa1aiof9fn2vigm1e0bj6MkI7gkilPMaCrc89un0I56HZ6f6UEBkvBSvGDbo/
        CXREAGn3PQPnFRYRnNDDhBsDf9GKxjETl0hHhOkDzzVIfEy1XHZJptJ7qwL74WvfnaN4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1m8qJK-00FEMI-Rg; Wed, 28 Jul 2021 22:37:50 +0200
Date:   Wed, 28 Jul 2021 22:37:50 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>, Simon Xue <xxm@rock-chips.com>
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: rk3568-evb1-v10: add ethernet
 support
Message-ID: <YQHAHmMmysBVpF+m@lunn.ch>
References: <20210728161020.3905-1-michael.riesch@wolfvision.net>
 <20210728161020.3905-3-michael.riesch@wolfvision.net>
 <YQGaAFvqqc7wXrWD@lunn.ch>
 <CAMdYzYo8zf0wjtAxTuYQnZQsBtw38prNuAA0j0sBEamcbzZbfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMdYzYo8zf0wjtAxTuYQnZQsBtw38prNuAA0j0sBEamcbzZbfA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Generally all rockchip boards use this value instead of the rgmii_id,
> I imagine because it's more consistent to tune here than the hit or
> miss support of the phy drivers.

Most PHY drivers actually implement it correctly, since by default,
most systems get the PHY to do the delays.

But if most Rockchip boards do it this way, there is a lot to be said
for consistence, so this is fine by me.

    Andrew
