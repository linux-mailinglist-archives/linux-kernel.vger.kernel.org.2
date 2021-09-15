Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D607A40BF93
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 08:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbhIOGQY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Sep 2021 02:16:24 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:40719 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbhIOGQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 02:16:23 -0400
Received: (Authenticated sender: clement.leger@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 465492000B;
        Wed, 15 Sep 2021 06:15:03 +0000 (UTC)
Date:   Wed, 15 Sep 2021 08:15:02 +0200
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: at91: check pmc node status before registering
 syscore ops
Message-ID: <20210915081502.29f158df@fixe.home>
In-Reply-To: <163165698139.763609.11633047159530535523@swboyd.mtv.corp.google.com>
References: <20210913082633.110168-1-clement.leger@bootlin.com>
        <163165698139.763609.11633047159530535523@swboyd.mtv.corp.google.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, 14 Sep 2021 15:03:01 -0700,
Stephen Boyd <sboyd@kernel.org> a écrit :

> Quoting Clement Leger (2021-09-13 01:26:33)
> > Currently, at91 pmc driver always register the syscore_ops whatever
> > the status of the pmc node that has been found. When set as secure
> > and disabled, the pmc should not be accessed or this will generate
> > abort exceptions.
> > To avoid this, add a check on node availability before registering
> > the syscore operations.
> > 
> > Signed-off-by: Clement Leger <clement.leger@bootlin.com>  
> 
> Any Fixes tag?

Since this was present from the start of the implementation, I think it
should be the following:

Fixes: b3b02eac33ed ("clk: at91: Add sama5d2 suspend/resume")
