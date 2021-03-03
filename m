Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA3532BE27
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376512AbhCCRIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:08:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:34124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234377AbhCCMsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 07:48:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1396364ED4;
        Wed,  3 Mar 2021 12:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614775651;
        bh=nPhaVQlWGiOqRGSZBMc6cCnJ6Xmgmr0T0g4FiSqYVOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tHXZnWwYrnXPKcd0bqnAPH+IaD4ICiamWSwHWTyJX5g0G0PMaVm35cWNrSsLw7UrI
         H3sezHk9zAfc6BRNKGi8vrB7e+IrR0LurHXDNDX2MIyu5kFBifUU7raxel95aCVXM+
         mN1VCZbKJSr2fmiy8DwHq9YeUl2+lz2Cf5i+oeedPlSO2NWMCGMHmPt32/FAm2XWcL
         IXbpdfRdc9cUBcvKEgm44543hoZux9+DZH8e/uCeGiZTlOgr+kn1xgjtq580GzSri0
         k1NmFXcHtet9nz32zyZss14XbWO2+XqgZbyUb+iQBjatlCE2Q8Giul/TnS5O83cufX
         LrLu0fe15glEg==
Date:   Wed, 3 Mar 2021 20:47:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Dima Azarkin <azdmg@outlook.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6qdl-wandboard: add scl/sda gpios
 definitions for i2c bus recovery
Message-ID: <20210303124722.GF15865@dragon>
References: <AM5PR0802MB2498F95537E1FF0E5DEB36BEA9B79@AM5PR0802MB2498.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM5PR0802MB2498F95537E1FF0E5DEB36BEA9B79@AM5PR0802MB2498.eurprd08.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 06:54:46PM +0300, Dima Azarkin wrote:
> The i2c bus on imx6qdl-wandboard has intermittent issues where SDA can freeze
> on low level at the end of transaction so the bus can no longer work. This
> impacts reading of EDID data leading to incorrect TV resolution and no audio.
> 
> This scenario is improved by adding scl/sda gpios definitions to implement the
> i2c bus recovery mechanism.
> 
> Signed-off-by: Dima Azarkin <azdmg@outlook.com>

Applied, thanks.
