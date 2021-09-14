Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4FB40A9BE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 10:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhINIxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 04:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhINIxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 04:53:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A96AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 01:52:13 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mQ4Ai-00077S-RI; Tue, 14 Sep 2021 10:52:08 +0200
Message-ID: <2dc72116ec935a5a5d7a1a176868b7af7ff3227c.camel@pengutronix.de>
Subject: Re: [PATCH v2] arm64: dts: imx8mq-kontron-pitx-imx8m: remove
 vqmmc-supply node
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Michael Walle <michael@walle.cc>
Cc:     Heiko Thiery <heiko.thiery@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Date:   Tue, 14 Sep 2021 10:52:07 +0200
In-Reply-To: <79fb60ea9a002ea553a92ea08b28b866@walle.cc>
References: <20210914072627.24173-1-heiko.thiery@gmail.com>
         <449f718706fd5af03190bdda986de37aa8fa14e3.camel@pengutronix.de>
         <79fb60ea9a002ea553a92ea08b28b866@walle.cc>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, dem 14.09.2021 um 10:32 +0200 schrieb Michael Walle:
> Hi Lucas,
> 
> Am 2021-09-14 10:20, schrieb Lucas Stach:
> > Am Dienstag, dem 14.09.2021 um 09:26 +0200 schrieb Heiko Thiery:
> > > The sw4 output (V_1V8_S0 voltage) from the PMIC is the main supply for
> > > the 1V8 power domain. It is not only used as supply for the eMMC.
> > > So this voltage can not be changed and is not allowed to switched off.
> > > Therefore we do not want to provide this regulator to the SDHC driver 
> > > to
> > > control this voltage.
> > > 
> > This specific requirement should not be solved by removing the
> > regulator connection from the SDHCI node, but instead by constraining
> > the regulator voltage range to a fixed 3.3V and marking the regulator
> > as always-on to reflect the hardware requirements in the DT.
> > 
> > Also if your eMMC vqmmc is a fixed 3.3V, I don't think you need the
> > faster pinctrl states, as you can't use the faster pin states anyways,
> > as they require a 1.8V signaling voltage.
> 
> Are you speaking of the 1.8V signalling modes? As far as I know the
> IMX SDHC controller will switch the voltage by its own function pin.
> That is, its not a GPIO.

Ah, I mixed things up here. This is a fixed 1.8V supply, which is valid
for eMMC, so the high-speed modes are available. My comment still
applies that this should be fixed by constraining the regulator, not by
removing the DT connection.

vqmmc is the MMC IO voltage, which can be switched either by the
function pin, which gets toggled automatically when software does the
voltage switch, or by explicitly switching the regulator voltage. eMMCs
are a bit special as they can work with a fixed 1.8V IO supply and
don't need to start with 3.3V.

Regards,
Lucas

