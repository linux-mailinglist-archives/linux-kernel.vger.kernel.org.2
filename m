Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0E6315D45
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbhBJC2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:28:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:53578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235184AbhBJB66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 20:58:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DA3A64E56;
        Wed, 10 Feb 2021 01:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612922297;
        bh=zn3FmLbVCB5XRXGLwh2fxizts24GOMcfbHQsOIScuCY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=TekWbgH+GXdz3GxuFaHo4EdcUoQfTOTKzbpuOvaMMAehaeeyU52ff9lwWTv7rd/F2
         8r/K+ez5adInmwH8uj4J3yZUSIvGK7IQiNaeqDMQJoSGlZjrLYJ6SP8rRti0AKGboo
         LOq/MuHIkqcIMA+k5OkArb734hO2R62amJVoAwmmz+h1/4gjoyamLLcFNqnKti+zxE
         8mB9Mi3FuAKcuYen0omJuDcHu/VesVcvujzFYtBY5SvCO+DfaGgnjoGJBNmV/keB42
         Oh3zCgN4/TsL+jiLuKihpt53BD8lfc84E6ZuGW1C84j4Ge6qOeIZvtI7tNQ4FtfRyW
         Fc1+3ddI2Ar4A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210114124032.12765-4-pali@kernel.org>
References: <20210114124032.12765-1-pali@kernel.org> <20210114124032.12765-4-pali@kernel.org>
Subject: Re: [PATCH mvebu v2 03/10] clk: mvebu: armada-37xx-periph: remove .set_parent method for CPU PM clock
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
Date:   Tue, 09 Feb 2021 17:58:16 -0800
Message-ID: <161292229602.418021.3135925555617646144@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Pali Roh=C3=A1r (2021-01-14 04:40:25)
> From: Marek Beh=C3=BAn <kabel@kernel.org>
>=20
> Remove the .set_parent method in clk_pm_cpu_ops.
>=20
> This method was supposed to be needed by the armada-37xx-cpufreq driver,
> but was never actually called due to wrong assumptions in the cpufreq
> driver. After this was fixed in the cpufreq driver, this method is not
> needed anymore.
>=20
> Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
> Fixes: 2089dc33ea0e ("clk: mvebu: armada-37xx-periph: add DVFS support fo=
r cpu clocks")
> Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
