Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6D2420AFB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 14:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhJDMlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 08:41:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229486AbhJDMlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 08:41:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E27F61373;
        Mon,  4 Oct 2021 12:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633351164;
        bh=Ur9SkBk9je7Okn5k0c3Z6yj9QWGp3a5zcr3bughsSmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fEG77MXZRr+rZN9X/Pg/OIa4mxK/bU40dtmCVwoz6idUce4uTpqE5l/xZURIfjwVy
         Que54cCg/h55nx4f6z8YdwcBDFIOVh07EmG/jEM4IkFXmLRV44kyNDfXqgVuhqokKU
         qDZzzWUiYcMiEp2nwdl+AWqoezmbcxGUD/OGFDDrTG5JYI914GBlczbAn0v0KVodzg
         cU2SL2Gj2PQyV/NGDPTkUKYi2AURK+2pl3Ljn3GIWuXiSwyiZoS/+r5SRGwqzg8MBi
         3grXo4Vu8DUlXSSNW890iQ/ALlCVOP+83JKP2RqupS4Xia5/Jzn5YVs7IuVOV//YX7
         BYpTPnGDVnyzQ==
Date:   Mon, 4 Oct 2021 20:39:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Heiko Thiery <heiko.thiery@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH] arm64: dts: imx8mm-kontron-n801x-som: do not allow to
 switch off buck2
Message-ID: <20211004123917.GH15650@dragon>
References: <20210915120325.20248-1-heiko.thiery@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915120325.20248-1-heiko.thiery@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 02:03:26PM +0200, Heiko Thiery wrote:
> The buck2 output of the PMIC is the VDD core voltage of the cpu.
> Switching off this will poweroff the CPU. Add the 'regulator-always-on'
> property to avoid this.
> 
> Fixes: 8668d8b2e67f ("arm64: dts: Add the Kontron i.MX8M Mini SoMs and baseboards")
> Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>

Applied, thanks!
