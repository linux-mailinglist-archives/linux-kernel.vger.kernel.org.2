Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6BB305C37
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 13:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbhA0M4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 07:56:42 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:49985 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S313911AbhAZWuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 17:50:14 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 1CA82FF802;
        Tue, 26 Jan 2021 22:48:35 +0000 (UTC)
Date:   Tue, 26 Jan 2021 23:48:35 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: rtc: pcf2127: update bindings
Message-ID: <20210126224835.GE1196852@piout.net>
References: <20201219013418.3474461-1-alexandre.belloni@bootlin.com>
 <c5290432-a6b0-2b96-585f-3abc2dcc56f6@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5290432-a6b0-2b96-585f-3abc2dcc56f6@prevas.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2020 22:17:54+0100, Rasmus Villemoes wrote:
> On 19/12/2020 02.34, Alexandre Belloni wrote:
> > pcf2127, pcf2129 and pca2129 support start-year and reset-source.
> > 
> 
> No, the 2129 variant doesn't even have a reset output pin. Not sure if
> there's any way to reflect that, and it probably doesn't matter, since
> nobody's going to add the reset-source property to a 2129 node. But the
> commit message is a bit misleading.
> 

Actually no, the INT pin can be used as a reset, the pcf/pca2129
can be used as a watchdog and so it may need the reset-source property.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
