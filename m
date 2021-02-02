Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257EC30CA5F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 19:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238698AbhBBSqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 13:46:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:36006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238621AbhBBSmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:42:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 222C564E36;
        Tue,  2 Feb 2021 18:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612291316;
        bh=Cu+meTF3AGaEP0tQPkqfKhwUYjnBM4WOlyLGTaj6Rtk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=11tMj6nPll8tVs3WupKBPVYfIiafB5bQi3q9YPjcLiEMJfx7VMztqsCGF1SVWT+hg
         EVL3GpVJOIx1GQS7Wxhp/r2B+2KipQDL3vtcv8WlsvEG7In7U9UD2KLMzvhTtDziSl
         zzQ2gELVZ0HX/P6XtAqf7AkQMH/jFB/kZ5qYH4C0=
Date:   Tue, 2 Feb 2021 19:41:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Peter Chen <peter.chen@nxp.com>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jun Li <jun.li@nxp.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Marek Behun <marek.behun@nic.cz>
Subject: Re: [PATCH v2] usb: host: xhci: mvebu: make USB 3.0 PHY optional for
 Armada 3720
Message-ID: <YBmc8go9W1qZ8WMe@kroah.com>
References: <20201223162403.10897-1-pali@kernel.org>
 <20210201150803.7305-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210201150803.7305-1-pali@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 04:08:03PM +0100, Pali Rohár wrote:
> Older ATF does not provide SMC call for USB 3.0 phy power on functionality
> and therefore initialization of xhci-hcd is failing when older version of
> ATF is used. In this case phy_power_on() function returns -EOPNOTSUPP.
> 
> [    3.108467] mvebu-a3700-comphy d0018300.phy: unsupported SMC call, try updating your firmware
> [    3.117250] phy phy-d0018300.phy.0: phy poweron failed --> -95
> [    3.123465] xhci-hcd: probe of d0058000.usb failed with error -95
> 
> This patch introduces a new plat_setup callback for xhci platform drivers
> which is called prior calling usb_add_hcd() function. This function at its
> beginning skips PHY init if hcd->skip_phy_initialization is set.
> 
> Current init_quirk callback for xhci platform drivers is called from
> xhci_plat_setup() function which is called after chip reset completes.
> It happens in the middle of the usb_add_hcd() function and therefore this
> callback cannot be used for setting if PHY init should be skipped or not.
> 
> For Armada 3720 this patch introduce a new xhci_mvebu_a3700_plat_setup()
> function configured as a xhci platform plat_setup callback. This new
> function calls phy_power_on() and in case it returns -EOPNOTSUPP then
> XHCI_SKIP_PHY_INIT quirk is set to instruct xhci-plat to skip PHY
> initialization.
> 
> This patch fixes above failure by ignoring 'not supported' error in
> xhci-hcd driver. In this case it is expected that phy is already power on.
> 
> It fixes initialization of xhci-hcd on Espressobin boards where is older
> Marvell's Arm Trusted Firmware without SMC call for USB 3.0 phy power.
> 
> This is regression introduced in commit bd3d25b07342 ("arm64: dts: marvell:
> armada-37xx: link USB hosts with their PHYs") where USB 3.0 phy was defined
> and therefore xhci-hcd on Espressobin with older ATF started failing.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Tested-by: Tomasz Maciej Nowak <tmn505@gmail.com>
> Fixes: bd3d25b07342 ("arm64: dts: marvell: armada-37xx: link USB hosts with their PHYs")
> Cc: <stable@vger.kernel.org> # 5.1+: ea17a0f153af: phy: marvell: comphy: Convert internal SMCC firmware return codes to errno
> Cc: <stable@vger.kernel.org> # 5.1+: f768e718911e: usb: host: xhci-plat: add priv quirk for skip PHY initialization


Mathias, any objection for me taking this now to get into 5.11-final?

thanks,

greg k-h
