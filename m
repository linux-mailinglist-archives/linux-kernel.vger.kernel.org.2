Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEBE416482
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 19:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242622AbhIWReX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 13:34:23 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:57130 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242402AbhIWReW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=fLbWQGZ0ZFZbah0fwNhnccDlem7A8vW8BXBdw45XA5s=; b=iWliOkzX5o9u5EfiX4LVSU5lrW
        UG0Qj49GPzoPsQLVUy6z43/2V9R1Dz3cDmPbHwOcpGxPHld/6GkU24rfGOnfCclhaOH1cgALMgCe6
        1ZKqp0oDWuEd8pSXEwoRb++40ZOIYMjseqJ2Pg/YpQ4gUXXNtar0hfhOwXsnomv+TbQE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1mTSaS-007xHv-2T; Thu, 23 Sep 2021 19:32:44 +0200
Date:   Thu, 23 Sep 2021 19:32:44 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     robh+dt@kernel.org, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: add Globalscale MOCHAbin
Message-ID: <YUy6PBMG25Ipr/vO@lunn.ch>
References: <20210923135454.2967198-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923135454.2967198-1-robert.marko@sartura.hr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	/* 88E6141 Topaz switch */
> +	switch: switch@3 {
> +		compatible = "marvell,mv88e6085";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <3>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&cp0_switch_pins>;
> +		reset-gpios = <&cp0_gpio1 0 GPIO_ACTIVE_LOW>;
> +
> +		interrupt-parent = <&cp0_gpio1>;
> +		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;

The switch interrupt is a level interrupt, not an edge interrupt.

    Andrew
