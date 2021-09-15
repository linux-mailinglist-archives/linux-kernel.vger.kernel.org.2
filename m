Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0A940BD25
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 03:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbhIOBZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 21:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232814AbhIOBZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 21:25:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18B0C61164;
        Wed, 15 Sep 2021 01:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631669030;
        bh=64nXdNaboRHGPiOfE18v9wd+99WndHPRdbRxXUIuN+g=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=GmOFHx8nhiSekvsuh0utn7Luy8tL+mdg1YKFxPgmqZBISrPzO5cqGaYU9yNwbPKoM
         JaZjitWwKECn+V/ppfNMZIYtBma/z6T26T6KYEZD+0suX5xo5k/Hy7/2ctUdoC3ycU
         Mt+agjcpT5jBx3SBm6HxmfSwWA8pFo6KyqS4qPn+S36yMxvYUp/cAc4nY2eGevg4dQ
         rvU4nS81FofZm/kH3pt/yyAlN4tjPHSnmK9icVN/qXvvVQ+9urDS4XENhrwtWhXmlY
         M9gh349FQTamm7A7jHeRNQXKA+4Bi94TS/eQX1+tgn4Y2K3rxrhUvR6AZh1tpfg2ni
         Wtcv6wUQjrBhA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210901222526.31065-3-miles.chen@mediatek.com>
References: <20210901222526.31065-1-miles.chen@mediatek.com> <20210901222526.31065-3-miles.chen@mediatek.com>
Subject: Re: [PATCH v3 2/3] clk: mediatek: support COMMON_CLK_MEDIATEK module build
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Wendell Lin <wendell.lin@mediatek.com>,
        Hanks Chen <hanks.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Miles Chen <miles.chen@mediatek.com>,
        Lee Jones <lee.jones@linaro.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>
Date:   Tue, 14 Sep 2021 18:23:48 -0700
Message-ID: <163166902892.763609.977824990105929862@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Miles Chen (2021-09-01 15:25:25)
> To support COMMON_CLK_MEDIATEK module build,
> add MODULE_LICENSE and export necessary symbols.
>=20
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Hanks Chen <hanks.chen@mediatek.com>
> Cc: Wendell Lin <wendell.lin@mediatek.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> ---

Applied to clk-next
