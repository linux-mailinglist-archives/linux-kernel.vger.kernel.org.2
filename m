Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28BEE3BF903
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 13:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhGHLbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 07:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbhGHLbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 07:31:42 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660E4C061574;
        Thu,  8 Jul 2021 04:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XklnTibCIfL0KxRMp3VAV+u5OGxp6nW7GyB3N7FCslM=; b=RnPRykNqoRIciHiBGOioYhzGq
        8pEhFzQ8/PchxJVYlnDI9rIh4nXFHOcomsktEOgUFKX9BOB53McqZAZ+bm9WpMgPH5dQA41MH3RNX
        gdJi1lSmcj6MQOWkgMoXvz68MquR/M7qh5qzC7OzzilVQBc28ybRmQS3Qv8aiyDuUpDcW0QBbn7ue
        eaOmeiFT+LyClPphBUnm6eODSkKdI3BZR99cdznwfGAn6bfdrCQ6WurAVs7xOrOl/+lh6+sZ4vAs1
        08W2uThVSwafeBQ2cBvrOxU9lF3EFerheFf7RGBcYayJMUm+Pw8MQLfsQRDkVK5NV/T4ndm+QgPqG
        5vOgcs9AA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45862)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1m1SD7-0000ZE-JO; Thu, 08 Jul 2021 12:28:53 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1m1SD5-0003qP-1B; Thu, 08 Jul 2021 12:28:51 +0100
Date:   Thu, 8 Jul 2021 12:28:51 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     kostap@marvell.com
Cc:     miquel.raynal@bootlin.com, kishon@ti.com, vkoul@kernel.org,
        robh+dt@kernel.org, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, vladimir.vid@sartura.hr,
        luka.kovacic@sartura.hr, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mw@semihalf.com,
        jaz@semihalf.com, nadavh@marvell.com, stefanc@marvell.com,
        bpeled@marvell.com
Subject: Re: [PATCH v6 4/5] dts: marvell: Enable 10G interfaces on 9130-DB
 and 9131-DB boards
Message-ID: <20210708112850.GU22278@shell.armlinux.org.uk>
References: <20210708112528.3254-1-kostap@marvell.com>
 <20210708112528.3254-5-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708112528.3254-5-kostap@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2021 at 02:25:27PM +0300, kostap@marvell.com wrote:
> From: Stefan Chulski <stefanc@marvell.com>
> 
> This patch enables eth0 10G interface on CN9130-DB paltforms and
> eth0 10G and eth3 10G interfaces on CN9131-DB.
> 
> Signed-off-by: Stefan Chulski <stefanc@marvell.com>
> Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
> ---
>  arch/arm64/boot/dts/marvell/cn9130-db.dtsi | 2 +-
>  arch/arm64/boot/dts/marvell/cn9131-db.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/marvell/cn9130-db.dtsi b/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
> index 34274e061958..39fc90716454 100644
> --- a/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
> +++ b/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
> @@ -125,7 +125,7 @@
>  
>  /* SLM-1521-V2, CON9 */
>  &cp0_eth0 {
> -	status = "disabled";
> +	status = "okay";
>  	phy-mode = "10gbase-kr";

Are these really 10gbase-kr? Or should this be 10gbase-r ?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
