Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4414260B1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 01:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbhJGXrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 19:47:31 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:55524 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231513AbhJGXra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 19:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=1Lv9ZYIcpMkYTukp7sKYhQ4VHfRciLDZTLg4KLS8D+I=; b=l4Yov2iOGpsjT6L3Hfr/FK5z+H
        yZkLrjZXvsaxVnOoztqsJRqoxMduDCBRSZYdZ8TLnfbw6dn5pTD3p11SLms/y6XwUtt1l3YHgzaiv
        iMb5vQyrTuEhqFmD1gdUdGy8epmH2zdOL++8z/bbz4bULcHz8ZzTwM/1jSrg5fRlNQFg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1mYd4i-00A0RM-9O; Fri, 08 Oct 2021 01:45:20 +0200
Date:   Fri, 8 Oct 2021 01:45:20 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        robh+dt@kernel.org, kostap@marvell.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm/arm64: dts: Enable 2.5G Ethernet port on
 CN9130-CRB
Message-ID: <YV+GkHONfzvYNS4R@lunn.ch>
References: <20211007230619.957016-1-chris.packham@alliedtelesis.co.nz>
 <20211007230619.957016-2-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007230619.957016-2-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 12:06:18PM +1300, Chris Packham wrote:
> Enable the 2.5G Ethernet port by setting the status to "okay" and the
> phy-mode to "2500base-x" on the cn9130-crb boards. Tested on a
> CN9130-CRB-A.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> The Marvell SDK adds 2500base-t and uses it in the equivalent dtsi but
> looking at the documentation for both the SoC and the PHY I think
> 2500base-x is correct for the system interface (the line side is
> 2500base-t).

2500base-t does not make any sense. It does not even exist in
mainline.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
