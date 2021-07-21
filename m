Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70413D0CC7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 13:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238805AbhGUJuE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Jul 2021 05:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239082AbhGUJlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 05:41:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218A0C0613DF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 03:21:39 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1m69M7-0004JC-JX; Wed, 21 Jul 2021 12:21:35 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1m69M6-0005Ex-Bx; Wed, 21 Jul 2021 12:21:34 +0200
Message-ID: <018b22ec61046708441c0bc0f6af6bf23967dc03.camel@pengutronix.de>
Subject: Re: [PATCH] reset: RESET_MCHP_SPARX5 should depend on ARCH_SPARX5
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Date:   Wed, 21 Jul 2021 12:21:34 +0200
In-Reply-To: <6e08f6f46123d0712397e901716b48f13fa5dc48.1624627657.git.geert@linux-m68k.org>
References: <6e08f6f46123d0712397e901716b48f13fa5dc48.1624627657.git.geert@linux-m68k.org>
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

Hi Geert,

On Fri, 2021-06-25 at 15:36 +0200, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> The Microchip Sparx5 switch reset block is only present on Microchip
> Sparx5 SoCs.  Hence add a dependency on ARCH_SPARX5, to prevent asking
> the user about this driver when configuring a kernel without Sparx5
> support.
> 
> Fixes: 453ed4283bebd077 ("reset: mchp: sparx5: add switch reset driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thank you, applied to reset/fixes.

regards
Philipp
