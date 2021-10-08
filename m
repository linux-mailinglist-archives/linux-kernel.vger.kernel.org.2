Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DD44271F4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 22:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhJHUU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 16:20:29 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:57166 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230091AbhJHUU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 16:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=nbEL2f9U72GlI7AKCPstfB4LethwKKgejTASqHX6Tho=; b=R2JejGfzJNcn6v52uEmXg2gfLX
        mB6DxBI2GX2cRa4vGah0xsv1g7h9Idl2UFT5nm/elBx8linAyOkMotppfYEGSZE8R1PaB+Us/txTd
        Gzoxk0fCVfI3YYx8qpiWV8Jd/+flg46sYi4q0XtAeXKwhLsePCB4jXSabHNvXVnKLCKE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1mYwK0-00A5dN-Pr; Fri, 08 Oct 2021 22:18:24 +0200
Date:   Fri, 8 Oct 2021 22:18:24 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
        UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] reset: mchp: sparx5: Extend support for lan966x
Message-ID: <YWCnkPjgqCKTTI/S@lunn.ch>
References: <20211008114330.1328713-1-horatiu.vultur@microchip.com>
 <20211008114330.1328713-3-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008114330.1328713-3-horatiu.vultur@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 01:43:30PM +0200, Horatiu Vultur wrote:
> This patch extends sparx5 driver to support also the lan966x. The
> process to reset the switch is the same only it has different offsets.
> Therefore make the driver more generic and add support for lan966x.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Thanks for making it generic.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
