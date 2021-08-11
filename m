Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FC43E9874
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 21:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhHKTPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 15:15:23 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:45700 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230224AbhHKTPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 15:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=f25HuEc/QbShUmIYwQa9iVXfyZLGhvb2J0+2abeuUgE=; b=oyLXgPa9hgVfIyL/ITMwiGoHY2
        EXHaPu73lW+foPifJ2TqGEWD4qA+c2LImxIV5ykyIpZQep8tvcWbnqbUAILcSE9bHZ8uuXuYRiNNH
        eZuIqoq+Vhr+UsBdEKsAYUT8PP+dOq3Qwzxhyn9DlZxA9b0mTHAkGFZpHDiQEI9hKWIc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1mDtge-00HAau-Oz; Wed, 11 Aug 2021 21:14:48 +0200
Date:   Wed, 11 Aug 2021 21:14:48 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Lokesh Vutla <lokeshvutla@ti.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Cory Tusar <cory.tusar@pid1solutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: vf610-zii-dev-rev-b: Remove #address-cells and
 #size-cells property from at93c46d dt node
Message-ID: <YRQhqHEl8wu2KZz+@lunn.ch>
References: <20210810064420.9489-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810064420.9489-1-a-govindraju@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 12:14:20PM +0530, Aswath Govindraju wrote:
Hi Aswath

You did not put a To: in the email, so it is unclear which maintainer
you expect to pickup this patch.

> Remove #address-cells and #size-cells property from at93c46d device tree
> node as it does not have child nodes.
> 
> Fixes: 1556063fde42 ("ARM: dts: vf610-zii-dev: Add ZII development board.")
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
