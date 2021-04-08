Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FA1357951
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 03:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhDHBJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 21:09:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229937AbhDHBJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 21:09:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99E6361168;
        Thu,  8 Apr 2021 01:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617844169;
        bh=lA8glmgaGsO4MbyBGlJMT4oTR+BuyM1kHzdhwEeHn6A=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=HUvmZ2abFQ9nuM94bTp0xg6A3UizOD+3PE2UUImBH6kKMnAV5XcK7f85deCBZ0BV5
         hKpi4BSiV1Z2uKxtGxtI/J8mpywmTGIbaAIJ0NGwps2JbkWLdX14sIUoKFu8MhImlu
         cGh3P9yI2lg2VIfWSWm31ODGA0SGXQkThcCxE3AS/ftEye3Sy6sxpga5xlfJ4joHjU
         UZnHH7BeFdPJO8/+CFLW131L7dWg6ipnEaXKU6btx5N/ri2mODQKJ3cplSPPQVnLgZ
         ZsXBFzqyVfhj3NDKFdD4UefY2n1Hsw18Kx/E+nfzHKm0NHp+LFq+4U1nn02yKJtWZS
         f1iQ8ALDd5lmQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210406154015.602779-1-quanyang.wang@windriver.com>
References: <20210406154015.602779-1-quanyang.wang@windriver.com>
Subject: Re: [V2][PATCH] clk: zynqmp: move zynqmp_pll_set_mode out of round_rate callback
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>,
        quanyang.wang@windriver.com
Date:   Wed, 07 Apr 2021 18:09:28 -0700
Message-ID: <161784416839.3790633.9475983970404006080@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting quanyang.wang@windriver.com (2021-04-06 08:40:15)
> From: Quanyang Wang <quanyang.wang@windriver.com>
>=20
> The round_rate callback should only perform rate calculation and not
> involve calling zynqmp_pll_set_mode to change the pll mode. So let's
> move zynqmp_pll_set_mode out of round_rate and to set_rate callback.
>=20
> Fixes: 3fde0e16d016 ("drivers: clk: Add ZynqMP clock driver")
> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> ---

Applied to clk-next
