Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CEE40C4E8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237619AbhIOMGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:06:47 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:42741 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbhIOMGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:06:46 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7C1FE221E6;
        Wed, 15 Sep 2021 14:05:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1631707526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pFCyStnMLg1CQ4LTGy++Nyi1QegK1V+8EANs+VGCqsQ=;
        b=CqaMeETs/qEV8npZQhbXl9s3c0AHs/nZGqyE+qnN7kIvgasLzxo1gXIKfAceDkjNM1cOC9
        Ky78TTYiHbQgojj5qdr5UhhDUOUmrJdsvWOT4Etlial2FMavbuX8L5XUZ6yfDUdP7RySkx
        SOO5+gNi0GrgRQKUZ/T6mxwF7sTFKkg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 15 Sep 2021 14:05:26 +0200
From:   Michael Walle <michael@walle.cc>
To:     Heiko Thiery <heiko.thiery@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH] arm64: dts: imx8mm-kontron-n801x-som: do not allow to
 switch off buck2
In-Reply-To: <20210915120325.20248-1-heiko.thiery@gmail.com>
References: <20210915120325.20248-1-heiko.thiery@gmail.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <7e7ee4244ababc0a46e0875222c7e37d@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-09-15 14:03, schrieb Heiko Thiery:
> The buck2 output of the PMIC is the VDD core voltage of the cpu.
> Switching off this will poweroff the CPU. Add the 'regulator-always-on'
> property to avoid this.

Mh, have this ever worked? Is there a commit which introduced a 
regression?

-michael

> Fixes: 8668d8b2e67f ("arm64: dts: Add the Kontron i.MX8M Mini SoMs and
> baseboards")
> Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
