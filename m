Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A20319372
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 20:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhBKTx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 14:53:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:36374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230326AbhBKTv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:51:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABB9C64E57;
        Thu, 11 Feb 2021 19:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613073047;
        bh=hHfIgU+ORP8c0SY6MizHc7cJddHUCZqr4Fb6R80RFaQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=niIFogI+4nqj0SsDz3Q4/wEBtTT4A/IqPyB6sQE87r9iN9pzcwqk0Zu/TLPtH8Seo
         1e1TRhIzA+VxToO7Qw2FjEDLvVc0thT1Kpa/rNbTZWVfIzq9kNPksKE8e/cxqeTvft
         VZu5x7EkL8IoavEHA3eyZ8s/kT4zG/mbBrj7f9g7PUGmOUJ28uP1uKd0X4sI6YpD9L
         8+lmFml4WeZYsgpo4/TP33zBiiPnax+LnhOxt9oMQVXf9S53KZwnHNFPpdC8rKuIfK
         5W5gH/X93+iAqTRjbYrpJEuafn6wc3bGoLi8xq2tQ24N98FgVsrd6MV076h1OMBKLY
         VljPt9M3FPMDQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210120093040.1719407-10-lee.jones@linaro.org>
References: <20210120093040.1719407-1-lee.jones@linaro.org> <20210120093040.1719407-10-lee.jones@linaro.org>
Subject: Re: [PATCH 09/20] clk: mvebu: ap-cpu-clk: Demote non-conformant kernel-doc header
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Omri Itach <omrii@marvell.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-clk@vger.kernel.org
To:     lee.jones@linaro.org
Date:   Thu, 11 Feb 2021 11:50:46 -0800
Message-ID: <161307304641.1254594.10542737133900305921@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lee Jones (2021-01-20 01:30:29)
> Not much effort has been put into this one.
>=20
> Demote it for the time being at least.
>=20
> Fixes the following W=3D1 kernel build warning(s):
>=20
>  drivers/clk/mvebu/ap-cpu-clk.c:52: warning: Function parameter or member=
 'ratio_state_reg' not described in 'cpu_dfs_regs'
>  drivers/clk/mvebu/ap-cpu-clk.c:52: warning: Function parameter or member=
 'divider_mask' not described in 'cpu_dfs_regs'
>  drivers/clk/mvebu/ap-cpu-clk.c:52: warning: Function parameter or member=
 'cluster_offset' not described in 'cpu_dfs_regs'
>  drivers/clk/mvebu/ap-cpu-clk.c:52: warning: Function parameter or member=
 'force_mask' not described in 'cpu_dfs_regs'
>  drivers/clk/mvebu/ap-cpu-clk.c:52: warning: Function parameter or member=
 'divider_offset' not described in 'cpu_dfs_regs'
>  drivers/clk/mvebu/ap-cpu-clk.c:52: warning: Function parameter or member=
 'divider_ratio' not described in 'cpu_dfs_regs'
>  drivers/clk/mvebu/ap-cpu-clk.c:52: warning: Function parameter or member=
 'ratio_offset' not described in 'cpu_dfs_regs'
>  drivers/clk/mvebu/ap-cpu-clk.c:52: warning: Function parameter or member=
 'ratio_state_offset' not described in 'cpu_dfs_regs'
>  drivers/clk/mvebu/ap-cpu-clk.c:52: warning: Function parameter or member=
 'ratio_state_cluster_offset' not described in 'cpu_dfs_regs'
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Julia Lawall <Julia.Lawall@inria.fr>
> Cc: Omri Itach <omrii@marvell.com>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---

Applied to clk-next
