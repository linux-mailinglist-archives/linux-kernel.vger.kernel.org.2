Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675753F4A78
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 14:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbhHWMTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 08:19:30 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:47535 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbhHWMT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 08:19:29 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 17CEEC000E;
        Mon, 23 Aug 2021 12:18:44 +0000 (UTC)
Date:   Mon, 23 Aug 2021 14:18:44 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ARM: dts: at91: enable ips for sama7g5
Message-ID: <YSOSJK0FmbgNynRc@piout.net>
References: <20210823100356.22206-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823100356.22206-1-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2021 13:03:53+0300, Claudiu Beznea wrote:
> Hi,
> 
> The following patches enable UDDRC, DDR3 PHY, SECURAM and SHDWC IPs
> on SAMA7G5.
> 
> Thank you,
> Claudiu Beznea
> 
> Claudiu Beznea (3):
>   ARM: dts: at91: add ram bindings
>   ARM: dts: at91: add bindins for securam
>   ARM: dts: at91: add bindings for shdwc

I think you meant node instead of bindings.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
