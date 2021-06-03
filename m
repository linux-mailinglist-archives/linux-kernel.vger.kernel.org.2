Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C1039A3AA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 16:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhFCOvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 10:51:10 -0400
Received: from mx01.ayax.eu ([188.137.98.110]:41138 "EHLO mx01.ayax.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230138AbhFCOvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 10:51:09 -0400
Received: from [192.168.192.146] (port=48238 helo=nx64de-df6d00)
        by mx01.ayax.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gszymaszek@short.pl>)
        id 1looeo-0005Ut-DI; Thu, 03 Jun 2021 16:49:14 +0200
Date:   Thu, 3 Jun 2021 16:49:13 +0200
From:   Grzegorz Szymaszek <gszymaszek@short.pl>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Grzegorz Szymaszek <gszymaszek@short.pl>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] ARM: dts: stm32: set stm32mp157c-odyssey DCMI pins
Message-ID: <YLjr6XaK7q3r8dmi@nx64de-df6d00>
Mail-Followup-To: Grzegorz Szymaszek <gszymaszek@short.pl>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <YLjl6lE+uZ5ZCdiS@nx64de-df6d00>
 <fcee4f30-446e-f4da-6d95-c9223cf82981@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fcee4f30-446e-f4da-6d95-c9223cf82981@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ahmad,

On Thu, Jun 03, 2021 at 04:26:59PM +0200, Ahmad Fatoum wrote:
> On 03.06.21 16:23, Grzegorz Szymaszek wrote:
> > The Seeed Odyssey-STM32MP157C board has a 20-pin DVP camera output.
> > stm32mp15-pinctrl.dtsi contains one pin state definition for the DCMI
> > interface, dcmi-0, AKA phandle dcmi_pins_a. This definition is
> > incompatible with the pins used on the Odyssey board, where:
> > - there are 8 data pins instead of 12,
> > - […]
> > 
> > Override the dcmi_pins_a definition (as well as dcmi_sleep_pins_a) in
> > the Odyssey device tree.
> 
> Rather define a new pinctrl group (e.g. &dcmi_pins_b) and use that
> instead of overriding an existing one.

Can I simply use dcmi_pins_b (as the first unused identifier) or is
there some way to match specific pin groups to an identifier (b, c, d,
and so on)?

> Current convention is also to place all STM32MP1 pinctrl nodes into
> a central file, not in the individual board device trees.

Sure, I will update the patch.

Thanks for your comments!

-- 
Grzegorz
