Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9283B599F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 09:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhF1HUD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Jun 2021 03:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbhF1HTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 03:19:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81590C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 00:17:26 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lxlW7-0000AE-Gh; Mon, 28 Jun 2021 09:17:15 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lxlW6-0006iW-24; Mon, 28 Jun 2021 09:17:14 +0200
Message-ID: <2eaeace20028aade8b6206c42fcc7123813fd8a2.camel@pengutronix.de>
Subject: Re: [RESEND PATCH v3 06/11] reset: stm32mp1: remove stm32mp1 reset
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Stephen Boyd <sboyd@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Etienne Carriere <etienne.carriere@foss.st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, marex@denx.de
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 28 Jun 2021 09:17:13 +0200
In-Reply-To: <162484414661.3259633.15807994186850314510@swboyd.mtv.corp.google.com>
References: <20210617051814.12018-1-gabriel.fernandez@foss.st.com>
         <20210617051814.12018-7-gabriel.fernandez@foss.st.com>
         <162484414661.3259633.15807994186850314510@swboyd.mtv.corp.google.com>
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

On Sun, 2021-06-27 at 18:35 -0700, Stephen Boyd wrote:
> Quoting gabriel.fernandez@foss.st.com (2021-06-16 22:18:09)
> > From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> > 
> > st32mp1 RCC reset driver was moved into stm32mp1 RCC clock driver.
> > 
> > Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> > ---
> 
> Applied to clk-next although it would be nice to get Philipp's ack

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
