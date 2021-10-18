Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5634432199
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 17:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbhJRPFI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Oct 2021 11:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbhJRPEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:04:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CE7C061745
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 08:01:48 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mcU8x-0005ns-AK; Mon, 18 Oct 2021 17:01:39 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mcU8w-0001pe-LB; Mon, 18 Oct 2021 17:01:38 +0200
Message-ID: <2eb89942760fc56fc1b4fe59377fa36d499134ee.camel@pengutronix.de>
Subject: Re: [PATCH v4 0/2] Extend Sparx5 switch reset driver for lan966x
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>, robh+dt@kernel.org,
        lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
        UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Mon, 18 Oct 2021 17:01:38 +0200
In-Reply-To: <20211018091522.1113510-1-horatiu.vultur@microchip.com>
References: <20211018091522.1113510-1-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-10-18 at 11:15 +0200, Horatiu Vultur wrote:
> This patch serie extends the Microchip Sparx5 reset driver to support
> lan966x
> 
> v3->v4:
>   - drop all the changes regarding the phy reset.
>   - use enum instead oneOf in dt-bindings
> 
> v2->v3:
>   - rename variable reset_gpio to phy_reset_gpio
>   - rename gpios property in documentation to phy-reset-gpios
> 
> v1->v2:
>   - add reviewed-by tag
>   - extend driver to be able to release the reset also for external PHYs
> 
> Horatiu Vultur (2):
>   dt-bindings: reset: Add lan966x support
>   reset: mchp: sparx5: Extend support for lan966x
> 
>  .../bindings/reset/microchip,rst.yaml         |  4 +-
>  drivers/reset/Kconfig                         |  2 +-
>  drivers/reset/reset-microchip-sparx5.c        | 40 +++++++++++++++----
>  3 files changed, 36 insertions(+), 10 deletions(-)

Thank you, both applied to reset/next.

regards
Philipp
