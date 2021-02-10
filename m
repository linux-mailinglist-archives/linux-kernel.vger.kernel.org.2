Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B27315D4A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbhBJC3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:29:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:53680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235261AbhBJB7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 20:59:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7B7D64D87;
        Wed, 10 Feb 2021 01:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612922305;
        bh=HrXwsVL8bHLZqMYLe2+HNguxBdslpuPKO7GJDYyRIAg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=B0rwmWEJPZs5D2LXwnB7pIbiLozVp3Hg2nYjV44+VQnSuXyNgeTfuiESuSitcmUz+
         6bmdlZC/pNPftqTPL8KY6FeQHUCVp93E4bWk2HYSdIKy0S4+zliGz5Dq9DwqwSlsLp
         0Ey7gFNZQ3vSAN7euI2bdRF+urQaYiq+3z0vbweL+nOy1JPb9njdEahkQf9j8ZHmGx
         XulC/yEGFy8WNy7sD+9jRca+HuzDs2bmzo4UyHuJSODUy2+s286eMQa9SF1E07Ca9P
         CEP7Cvq66iwxp0Z8YGiUb92DmAo95MiPrbMcB7AXnJX0tu5aEpj0rmry32Fwzi3tvf
         dPlyYwt7Wdsmw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210114124032.12765-6-pali@kernel.org>
References: <20210114124032.12765-1-pali@kernel.org> <20210114124032.12765-6-pali@kernel.org>
Subject: Re: [PATCH mvebu v2 05/10] clk: mvebu: armada-37xx-periph: Fix switching CPU freq from 250 Mhz to 1 GHz
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Marek =?utf-8?q?Beh=C3=BAn?= <kabel@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Andre Heider <a.heider@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        =?utf-8?q?G=C3=A9rald?= Kerma <gerald@gk2.net>,
        Konstantin Porotchkin <kostap@marvell.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 09 Feb 2021 17:58:24 -0800
Message-ID: <161292230417.418021.9609462768507058743@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Pali Roh=C3=A1r (2021-01-14 04:40:27)
> It was observed that the workaround introduced by commit 61c40f35f5cd
> ("clk: mvebu: armada-37xx-periph: Fix switching CPU rate from 300Mhz to
> 1.2GHz") when base CPU frequency is 1.2 GHz is also required when base
> CPU frequency is 1 GHz. Otherwise switching CPU frequency directly from
> L2 (250 MHz) to L0 (1 GHz) causes a crash.
>=20
> When base CPU frequency is just 800 MHz no crashed were observed during
> switch from L2 to L0.
>=20
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> Fixes: 2089dc33ea0e ("clk: mvebu: armada-37xx-periph: add DVFS support fo=
r cpu clocks")
> Cc: stable@vger.kernel.org # 61c40f35f5cd ("clk: mvebu: armada-37xx-perip=
h: Fix switching CPU rate from 300Mhz to 1.2GHz")
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
