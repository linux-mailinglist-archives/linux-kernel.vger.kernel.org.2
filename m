Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540024039B2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 14:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348262AbhIHM0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 08:26:13 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:60818 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229842AbhIHM0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=jtbdpnmVevfPgurqOrfhXmQsKYNGJqNI1A1aV8izcjA=; b=0gWIBWSYNwCfNfMQ4NVRDrhSmu
        Th0sGlbav1qz7rBnJeDFyTQnVIgAZU4By3Ycao+LGFrkMIPn9kOJA1dWftDcAlptOwN86yXwz2iDJ
        1hVwPoJrTk6OXUjmIWJLuG+HSJ+XKdSRecpD7j//3ppEdT9Mq10XTqeMNOTWvlZ9LDJI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1mNwdM-005ld6-NN; Wed, 08 Sep 2021 14:24:56 +0200
Date:   Wed, 8 Sep 2021 14:24:56 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip/irq-mvebu-pic: Make use of the helper function
 devm_platform_ioremap_resource()
Message-ID: <YTirmIG6/57T6JTv@lunn.ch>
References: <20210908105701.1678-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908105701.1678-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 06:57:00PM +0800, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
