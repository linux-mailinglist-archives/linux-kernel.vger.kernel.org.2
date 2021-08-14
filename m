Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6DC3EC0C4
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 07:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236976AbhHNFo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 01:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232615AbhHNFo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 01:44:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CAEA6101E;
        Sat, 14 Aug 2021 05:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628919839;
        bh=dqvOProiQbSRB6ppypaHutBkVq7XAV9lfM9E3uru7Xo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WqIzNv906UsHSL/zPNP1gUzDRbMGei8hFZSYVYJ1txn2f5j3cu+Iij/cTc9AAVEmg
         rsxSI/5q4rg3ClZV1L0jWvq1d3DXZZHOOma5XeFqiXCgr1m1UqWeC7E6DTrx3WXGiI
         wdf0zuxJsHmmgS6ZpcXS758wdPjA/bYElemSEymudhFuyBQtupgCvy26FdRhIaMfPF
         RAYoe7ewbLJKFn+iVEZQPr3kYCriEc+eH+Fqe5e7BaIvgRQlpRAkvjPyG8Wy/HQNbO
         GEO4A6GaLZyxFQLPNR8L+3EgFth8lTHcgD1cDiounyPWI7Kq7o9UGVgXMNdWiUSZ2j
         XsCv0YYjgW4cw==
Date:   Sat, 14 Aug 2021 13:43:54 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Lokesh Vutla <lokeshvutla@ti.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Cory Tusar <cory.tusar@pid1solutions.com>,
        Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: vf610-zii-dev-rev-b: Remove #address-cells and
 #size-cells property from at93c46d dt node
Message-ID: <20210814054353.GY30984@dragon>
References: <20210810064420.9489-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810064420.9489-1-a-govindraju@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 12:14:20PM +0530, Aswath Govindraju wrote:
> Remove #address-cells and #size-cells property from at93c46d device tree
> node as it does not have child nodes.
> 
> Fixes: 1556063fde42 ("ARM: dts: vf610-zii-dev: Add ZII development board.")
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>

Applied, thanks!
