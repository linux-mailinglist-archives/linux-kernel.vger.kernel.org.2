Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A71F419904
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 18:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbhI0Qjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 12:39:47 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:34144 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235467AbhI0Qjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=BSzJ9MI1HCyI2LroQSjlIvcFGj03FSNKkHW9ACsfq4A=; b=vY/AlZB163CljHQKnWy4WTj309
        NiKmGJaH+/JwqRQMsi09XP6i8ZyBaLtOH/qGayYpAEX0VKugsZtBW6h0hnBpnW0ihTvjDW4t1mxkH
        rYUuMct2J9IOAETw6vYCqByWYRSit6kuuaNpJPHFFwsUFvk4NY0sSCFNFC7R3hvortmE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1mUtdk-008T1l-2s; Mon, 27 Sep 2021 18:38:04 +0200
Date:   Mon, 27 Sep 2021 18:38:04 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: marvell: espressobin-ultra: add PHY and
 switch reset pins
Message-ID: <YVHzbLJTFgOdVWQx@lunn.ch>
References: <20210927154159.2168500-1-robert.marko@sartura.hr>
 <20210927154159.2168500-3-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927154159.2168500-3-robert.marko@sartura.hr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 05:41:58PM +0200, Robert Marko wrote:
> Both the Topaz switch and 88E1512 PHY have their reset and interrupts
> connected to the SoC.
> 
> So, define the Topaz and 88E1512 reset pins in the DTS.
> 
> Defining the interrupt pins wont work as both the 88E1512 and the
> Topaz switch uses active LOW IRQ signals but the A37xx GPIO controller
> only supports edge triggers.
> 88E1512 would require special setup anyway as its INT pin is shared with
> the LED2 and you first need to configure it as INT.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
