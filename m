Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B633221A4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 22:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbhBVVjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 16:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbhBVViV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 16:38:21 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984EAC06174A;
        Mon, 22 Feb 2021 13:37:41 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0372222205;
        Mon, 22 Feb 2021 22:37:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1614029856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tKJ8KKWVmB8WZEv7UDmR9xfK+q1J1zYJe/n/rc5LD9s=;
        b=DFQmYY54H+oOsOL+6IbaDB435b6RltlYY4kc2vsheFkN9WGcElz0sBSC9FIRTQOWJMwOxF
        Ko4X+55t245Uv0wrKTo5HSbJtGw1+7XSZxLuA1H77tH2hLPZqcerEeny/Oh/6nDlkMPEN8
        QyBmyUCDlwJynUoEBYfno8CBpsmhxxQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 22 Feb 2021 22:37:35 +0100
From:   Michael Walle <michael@walle.cc>
To:     Heiko Thiery <heiko.thiery@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: fsl: add support for Kontron
 pitx-imx8m board
In-Reply-To: <20210222212615.25784-1-heiko.thiery@gmail.com>
References: <20210222212615.25784-1-heiko.thiery@gmail.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <eefe3f7ff9a8ce94acade69e028e3288@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-02-22 22:26, schrieb Heiko Thiery:
> The Kontron pitx-imx8m board is based on an i.MX8MQ soc.
> 
> Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Michael Walle <michael@walle.cc>
