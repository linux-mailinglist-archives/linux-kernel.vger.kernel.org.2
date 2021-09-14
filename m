Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE4540AB0A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhINJlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhINJlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:41:09 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE32CC061574;
        Tue, 14 Sep 2021 02:39:52 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 18BD822236;
        Tue, 14 Sep 2021 11:39:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1631612391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z6Mv7Yd2Rs+noRI7tvkJjhObNXbkREoufLm5c9rZxBE=;
        b=Lu5Wwd/6hGrxKxmtOC5tSHcoTRCF4pVt00VJvSOsgnhOyKpKCFTUbF7YcReCBnyVuo2tu6
        rEDAIsAU6ct2ilQqsFWPHeLfAy82reU0NdQ4wyUsj9xK37eURBef/LCI6SN4EDuj/w6pXk
        zOIHkizNrgnCzvHO7BohAgMfcCJKFkM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 14 Sep 2021 11:39:51 +0200
From:   Michael Walle <michael@walle.cc>
To:     Lucas Stach <l.stach@pengutronix.de>
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
Subject: Re: [PATCH v2] arm64: dts: imx8mq-kontron-pitx-imx8m: remove
 vqmmc-supply node
In-Reply-To: <2dc72116ec935a5a5d7a1a176868b7af7ff3227c.camel@pengutronix.de>
References: <20210914072627.24173-1-heiko.thiery@gmail.com>
 <449f718706fd5af03190bdda986de37aa8fa14e3.camel@pengutronix.de>
 <79fb60ea9a002ea553a92ea08b28b866@walle.cc>
 <2dc72116ec935a5a5d7a1a176868b7af7ff3227c.camel@pengutronix.de>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <9c4ada4b9ca1e806ea1916f195598b40@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-09-14 10:52, schrieb Lucas Stach:
> Am Dienstag, dem 14.09.2021 um 10:32 +0200 schrieb Michael Walle:
>> Hi Lucas,
>> 
>> Am 2021-09-14 10:20, schrieb Lucas Stach:
>> > Am Dienstag, dem 14.09.2021 um 09:26 +0200 schrieb Heiko Thiery:
>> > > The sw4 output (V_1V8_S0 voltage) from the PMIC is the main supply for
>> > > the 1V8 power domain. It is not only used as supply for the eMMC.
>> > > So this voltage can not be changed and is not allowed to switched off.
>> > > Therefore we do not want to provide this regulator to the SDHC driver
>> > > to
>> > > control this voltage.
>> > >
>> > This specific requirement should not be solved by removing the
>> > regulator connection from the SDHCI node, but instead by constraining
>> > the regulator voltage range to a fixed 3.3V and marking the regulator
>> > as always-on to reflect the hardware requirements in the DT.
>> >
>> > Also if your eMMC vqmmc is a fixed 3.3V, I don't think you need the
>> > faster pinctrl states, as you can't use the faster pin states anyways,
>> > as they require a 1.8V signaling voltage.
>> 
>> Are you speaking of the 1.8V signalling modes? As far as I know the
>> IMX SDHC controller will switch the voltage by its own function pin.
>> That is, its not a GPIO.
> 
> Ah, I mixed things up here. This is a fixed 1.8V supply, which is valid
> for eMMC, so the high-speed modes are available. My comment still
> applies that this should be fixed by constraining the regulator, not by
> removing the DT connection.
> 
> vqmmc is the MMC IO voltage, which can be switched either by the
> function pin, which gets toggled automatically when software does the
> voltage switch, or by explicitly switching the regulator voltage. eMMCs
> are a bit special as they can work with a fixed 1.8V IO supply and
> don't need to start with 3.3V.

Mh, I have some kind of general question though.

Lets take the SDHC controller for the SD card, which needs to change
the voltage if you want to use the high speed mode of the cards. Ie.
from 3.3V to 1.8V. The controller does this autonomously with the help
of a pin which is controlled by the controller itself. Will it have a
vqmmc-supply property? And if so what whould the supply be?

-michael
