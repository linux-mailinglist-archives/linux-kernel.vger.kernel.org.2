Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D80038BBCB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 03:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237541AbhEUBoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 21:44:21 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50340 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237311AbhEUBoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 21:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=c+XCuLEAL9tyzjer230+dzuUWAppVl3JEe2dMavLJEc=; b=GR
        e4C4SUPoVgjD1y/T6PfFPFpKX7ifxo3EtyHuyheN88JkYx5vUZqVC8acWMU8OqfULpKpVLd9+3L/v
        qXbpkyXbupL0X/dlb03YwP0BRuJwKz/+k88h/GYLCZQSZ0URU35zkvzjIrSkuI082rIg+oIcXCNR8
        1NpDm10jDV1kmLA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1ljuBj-005CPk-9y; Fri, 21 May 2021 03:42:55 +0200
Date:   Fri, 21 May 2021 03:42:55 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 mvebu + mvebu/dt64 2/2] arm64: dts: marvell:
 armada-37xx: move firmware node to generic dtsi file
Message-ID: <YKcQH9ApRwL6SnWI@lunn.ch>
References: <20210308153703.23097-1-kabel@kernel.org>
 <20210520113844.32319-1-pali@kernel.org>
 <20210520113844.32319-3-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210520113844.32319-3-pali@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 01:38:44PM +0200, Pali Rohár wrote:
> Move the turris-mox-rwtm firmware node from Turris MOX' device tree into
> the generic armada-37xx.dtsi file and use the generic compatible string
> 'marvell,armada-3700-rwtm-firmware' instead of the current one.
> 
> Turris MOX DTS file contains also old compatible string for backward
> compatibility.
> 
> The Turris MOX rWTM firmware can be used on any Armada 37xx device,
> giving them access to the rWTM hardware random number generator, which
> is otherwise unavailable.
> 
> This change allows Linux to load the turris-mox-rwtm.ko module on these
> boards.
> 
> Tested on ESPRESSObin v5 with both default Marvell WTMI firmware and
> CZ.NIC's firmware. With default WTMI firmware the turris-mox-rwtm fails
> to probe, while with CZ.NIC's firmware it registers the HW random number
> generator.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Marek Behún <kabel@kernel.org>
> Cc: <stable@vger.kernel.org> # 5.4+: 46d2f6d0c99f ("arm64: dts: armada-3720-turris-mox: add firmware node")

Please drop stable. It is a new feature, not a fix.

Otherwise

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
