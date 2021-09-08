Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9EB74039B1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 14:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345595AbhIHM0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 08:26:10 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:60816 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229842AbhIHM0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=/eFel8YelreKRQ6kJq/PzioE24r2MUvx8wlTyS2mwtM=; b=dseTWh8cLXkYJTjmGoU2PRn+ft
        5cOPpkatfRqUBEz8V7U0djr6iRB47ujEvg+HlOTlCirzCd4ov/d/Sm5Nr5FS6j2fGS8u97md5tYNA
        X7gYFLAgfloijAjxsJ0DKAF/IwPuR1I45nZn4R4AxctYia2ka+esITpuUUsW00aKzp1E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1mNwd9-005lcl-Hr; Wed, 08 Sep 2021 14:24:43 +0200
Date:   Wed, 8 Sep 2021 14:24:43 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip/irq-mvebu-icu: Make use of the helper function
 devm_platform_ioremap_resource()
Message-ID: <YTiri0YIrSwKFUV8@lunn.ch>
References: <20210908105653.1627-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908105653.1627-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 06:56:52PM +0800, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
