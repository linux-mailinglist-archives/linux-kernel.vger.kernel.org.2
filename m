Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB2340118E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 22:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238125AbhIEUnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 16:43:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238113AbhIEUnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 16:43:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FB1C61056;
        Sun,  5 Sep 2021 20:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630874552;
        bh=3RhW5zQAPc9DSXeyV3jspga968FiWVdlv+nl633JKww=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=l5p5VpM4b0zgKohLXah+4+4etd7+vYtfWBu9UhaIcgZB/VlxZTrrUbLcGSD46s77I
         InXynCL2bUWUV1scqBcMfoToywDYPxWaowQkNtC1CReZcVxNZvyKZ5mgA4Bg71jx1W
         csWJSQhvtB50GqSLv7oGeJJNzOTe4bBFwDDVjYhcGDKvbjSvOuXQMZqlvP4nhkhQca
         Vd5gfBnsU94m8wnLgKEyGITSaDaDYCjSY/HRS3N3CLk8MaH9fHBWe2hEH+xJ1C0wlw
         kvtqZ4c0G96MhkJNEDAE3WNkcJQGSvorXdGFnNrzoOnSRYB1jLOoYhERXBzgS7HY+B
         cxV3m5FoNAhwg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210904235418.2442-1-miles.chen@mediatek.com>
References: <20210904235418.2442-1-miles.chen@mediatek.com>
Subject: Re: [PATCH v3] clk: imx: use module_platform_driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        wsd_upstream@mediatek.com, Miles Chen <miles.chen@mediatek.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Date:   Sun, 05 Sep 2021 13:42:30 -0700
Message-ID: <163087455086.405991.14496690646389782129@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Miles Chen (2021-09-04 16:54:18)
> Replace builtin_platform_driver_probe with module_platform_driver_probe
> because CONFIG_CLK_IMX8QXP can be set to =3Dm (kernel module).
>=20
> Fixes: e0d0d4d86c766 ("clk: imx8qxp: Support building i.MX8QXP clock driv=
er as module")
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
>=20
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
