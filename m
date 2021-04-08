Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBB3358846
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhDHPZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:25:50 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:33467 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbhDHPZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:25:43 -0400
X-Originating-IP: 90.65.108.55
Received: from localhost (lfbn-lyo-1-1676-55.w90-65.abo.wanadoo.fr [90.65.108.55])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 164BD2000F;
        Thu,  8 Apr 2021 15:25:28 +0000 (UTC)
Date:   Thu, 8 Apr 2021 17:25:28 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        SoC Team <soc@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: New 'make dtbs_check W=1' warnings
Message-ID: <YG8gaHqlJ+oCfkTt@piout.net>
References: <CAK8P3a1L8rWpR5b66v6Su8-m7-scA0wZQr_g_4KnV4dnrky6ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1L8rWpR5b66v6Su8-m7-scA0wZQr_g_4KnV4dnrky6ZA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/04/2021 17:08:26+0200, Arnd Bergmann wrote:
> arch/arm/boot/dts/at91-sama5d2_ptc_ek.dt.yaml: /: 'etm@73C000' does
> not match any of the regexes: '@(0|[1-9a-f][0-9a-f]*)$', '^[^@]+$',
> 'pinctrl-[0-9]+'
> arch/arm/boot/dts/at91-kizbox3-hs.dt.yaml: /: 'etm@73C000' does not
> match any of the regexes: '@(0|[1-9a-f][0-9a-f]*)$', '^[^@]+$',
> 'pinctrl-[0-9]+'
> 

This was introduced by 4d930c421e3b ("ARM: dts: at91: sama5d2: add ETB
and ETM unit name"), trying to fix another warning.

I guess this is because
Documentation/devicetree/bindings/arm/coresight.txt is not yaml yet.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
