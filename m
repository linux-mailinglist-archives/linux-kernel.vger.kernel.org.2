Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C753DD2D5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 11:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbhHBJVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 05:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbhHBJVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:21:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432EFC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 02:21:13 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mAU86-0001ek-K3; Mon, 02 Aug 2021 11:21:02 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1mAU84-0000Rl-GO; Mon, 02 Aug 2021 11:21:00 +0200
Date:   Mon, 2 Aug 2021 11:21:00 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, soc@kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        =?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>,
        Juergen Borleis <jbe@pengutronix.de>,
        Ulrich =?utf-8?Q?=C3=96lmann?= <u.oelmann@pengutronix.de>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 4/4] ARM: dts: add SKOV imx6q and imx6dl based boards
Message-ID: <20210802092100.ctkncu6g4ka4rvtt@pengutronix.de>
References: <20210714045349.10963-1-o.rempel@pengutronix.de>
 <20210714045349.10963-5-o.rempel@pengutronix.de>
 <20210726012043.GC5901@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210726012043.GC5901@dragon>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:19:00 up 242 days, 23:25, 24 users,  load average: 0.01, 0.06,
 0.07
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
> > +	reg_vcc_mmc_io: regulator-vcc-mmc-io {
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_vcc_mmc_io>;
> > +		compatible = "regulator-gpio";
> > +		vin-supply = <&reg_5v0>;
> > +		regulator-name = "mmc_io_supply";
> > +		regulator-type = "voltage";
> > +		regulator-min-microvolt = <1800000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		gpios = <&gpio7 13 GPIO_ACTIVE_HIGH>;
> 
> enable-active-high?

right, thx!

> > +		states = <1800000 0x1>, <3300000 0x0>;
> 
> Hmm, I do not see this 'states' in fixed-regulator.yaml.

It is in gpio-regulator.yaml

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
