Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CA33FD2E8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 07:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241969AbhIAFdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 01:33:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241980AbhIAFdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 01:33:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCB346101A;
        Wed,  1 Sep 2021 05:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630474341;
        bh=N2WVEhIn7g2xqwLHjd0/oieAY8b22yKtkcYybi7KwlY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=W+VmqvrMQZfk8rutotH03eYCURAchYuizk2DK9nQxPm+pg+z9Kk5zUR6IzSdMHlv2
         XU5A8i272PxI5WC+5fIYqptS9g43rvC52wgkbzF9mDgvV0Pk/5Cluk0QKs0B0fMjIp
         ACcRIncd9SjSso/34CiWix2MnxjY39LB/VZqHhuabJqpQilH0MiQG+nr4RW9Vm8jrP
         do5V5Su8v9Ch8p50pGDf1CLqzcxRE9Zum/fWoo/8IqmlYN2U0WeYjzX+jwvv157vb/
         0GhNNmFkw9KQDYbxMWXKfkrSlbND4atg8V1DdqAaE7AU3mz3VrY0GGNoW3/1PZ2D3C
         T4j6ToIqvt8WQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1630348984.24981.2.camel@mtkswgap22>
References: <20210813032429.14715-1-miles.chen@mediatek.com> <20210813032429.14715-4-miles.chen@mediatek.com> <163021049667.2676726.10138202396240942833@swboyd.mtv.corp.google.com> <1630348984.24981.2.camel@mtkswgap22>
Subject: Re: [RESEND PATCH 3/4] clk: mediatek: support COMMON_CLK_MT6779 module build
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Wendell Lin <wendell.lin@mediatek.com>,
        Hanks Chen <hanks.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Lee Jones <lee.jones@linaro.org>
To:     Miles Chen <miles.chen@mediatek.com>
Date:   Tue, 31 Aug 2021 22:32:20 -0700
Message-ID: <163047434049.42057.5688419707288938766@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Miles Chen (2021-08-30 11:43:04)
>=20
> sorry for my late response.=20
>=20
> Thanks for pointing this out. I have the same question when I was
> building this patch. That time I found some examples where
> they are using builtin_platform_driver and can be built as=20
> kernel modules:
>=20
> config CLK_IMX8QXP (tristate) && drivers/clk/imx/clk-imx8qxp-lpcg.c
> config CLK_RK3399 (tristate) && drivers/clk/rockchip/clk-rk3399.c

We should fix those drivers. Care to send a patch?
