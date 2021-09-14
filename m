Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF3C40A940
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 10:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhINIdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 04:33:49 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:34129 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhINIds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 04:33:48 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id CFDCE22236;
        Tue, 14 Sep 2021 10:32:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1631608350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mK45DPjPDOebyImyvNPsaRVqJdm0sKCXoLx5bi3Ug+M=;
        b=hsUJ3wCHNDgvmQrAd2HiH3nwcRVBTnpR3kGFjUApcaz7O0ArrbYQ64aZHgIDHmYYIOJdks
        jq8lNkT+pvwYqEjopTOwTi5bZrKimp//N6CzvEVaxDfhP0cQ7wvH1af/IztKiceGgmH75n
        RBBpBFJcf9V47sI7kYBjCH0p8QRXojQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 14 Sep 2021 10:32:26 +0200
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
In-Reply-To: <449f718706fd5af03190bdda986de37aa8fa14e3.camel@pengutronix.de>
References: <20210914072627.24173-1-heiko.thiery@gmail.com>
 <449f718706fd5af03190bdda986de37aa8fa14e3.camel@pengutronix.de>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <79fb60ea9a002ea553a92ea08b28b866@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,

Am 2021-09-14 10:20, schrieb Lucas Stach:
> Am Dienstag, dem 14.09.2021 um 09:26 +0200 schrieb Heiko Thiery:
>> The sw4 output (V_1V8_S0 voltage) from the PMIC is the main supply for
>> the 1V8 power domain. It is not only used as supply for the eMMC.
>> So this voltage can not be changed and is not allowed to switched off.
>> Therefore we do not want to provide this regulator to the SDHC driver 
>> to
>> control this voltage.
>> 
> This specific requirement should not be solved by removing the
> regulator connection from the SDHCI node, but instead by constraining
> the regulator voltage range to a fixed 3.3V and marking the regulator
> as always-on to reflect the hardware requirements in the DT.
> 
> Also if your eMMC vqmmc is a fixed 3.3V, I don't think you need the
> faster pinctrl states, as you can't use the faster pin states anyways,
> as they require a 1.8V signaling voltage.

Are you speaking of the 1.8V signalling modes? As far as I know the
IMX SDHC controller will switch the voltage by its own function pin.
That is, its not a GPIO.

-michael
