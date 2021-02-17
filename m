Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D006D31DD3F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbhBQQXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:23:23 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:46040 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234195AbhBQQXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:23:06 -0500
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1lCPaj-006vOY-Bk; Wed, 17 Feb 2021 17:22:17 +0100
Date:   Wed, 17 Feb 2021 17:22:17 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     gregory.clement@bootlin.com, kabel@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: turris-omnia: fix hardware buffer management
Message-ID: <YC1CuWnLQju7wMl2@lunn.ch>
References: <20210217153038.1068170-1-rsalvaterra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217153038.1068170-1-rsalvaterra@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 03:30:38PM +0000, Rui Salvaterra wrote:
> Hardware buffer management has never worked on the Turris Omnia, as the
> required MBus window hadn't been reserved. Fix thusly.

Hi Rui

I don't know all the details for the MBus Windows...

Can this be set once in armada-385.dtsi ?

Did you check the other dts files. Do any others have the same
problem?

    Andrew
