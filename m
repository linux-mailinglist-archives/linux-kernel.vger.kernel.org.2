Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E513F32D1C3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 12:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238164AbhCDL2k convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 4 Mar 2021 06:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbhCDL2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 06:28:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C27C06175F
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 03:27:44 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lHm8V-0007cd-PG; Thu, 04 Mar 2021 12:27:19 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lHm8P-0002DB-5m; Thu, 04 Mar 2021 12:27:13 +0100
Message-ID: <a9d636b617832f0c0dd86dd63c2a0ef913971d83.camel@pengutronix.de>
Subject: Re: [PATCH v5 2/2] hwrng: bcm2835: add reset support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     =?ISO-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 04 Mar 2021 12:27:13 +0100
In-Reply-To: <20210304073308.25906-3-noltari@gmail.com>
References: <20210304073308.25906-1-noltari@gmail.com>
         <20210304073308.25906-3-noltari@gmail.com>
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

On Thu, 2021-03-04 at 08:33 +0100, Álvaro Fernández Rojas wrote:
> BCM6368 devices need to reset the in order to generate true random numbers.
> This is what BCM6368 produces without a reset:
> root@OpenWrt:/# cat /dev/hwrng | rngtest -c 1000
> rngtest 6.10
> Copyright (c) 2004 by Henrique de Moraes Holschuh
> This is free software; see the source for copying conditions.  There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
> rngtest: starting FIPS tests...
> rngtest: bits received from input: 20000032
> rngtest: FIPS 140-2 successes: 0
> rngtest: FIPS 140-2 failures: 1000
> rngtest: FIPS 140-2(2001-10-10) Monobit: 2
> rngtest: FIPS 140-2(2001-10-10) Poker: 1000
> rngtest: FIPS 140-2(2001-10-10) Runs: 1000
> rngtest: FIPS 140-2(2001-10-10) Long run: 30
> rngtest: FIPS 140-2(2001-10-10) Continuous run: 0
> rngtest: input channel speed: (min=37.253; avg=320.827; max=635.783)Mibits/s
> rngtest: FIPS tests speed: (min=12.141; avg=15.034; max=16.428)Mibits/s
> rngtest: Program run time: 1336176 microseconds
> cat: write error: Broken pipe
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  v5: remove reset_control_rearm().

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
