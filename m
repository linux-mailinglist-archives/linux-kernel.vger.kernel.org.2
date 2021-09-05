Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C56401190
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 22:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238156AbhIEUpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 16:45:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238030AbhIEUpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 16:45:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA1D660F8F;
        Sun,  5 Sep 2021 20:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630874646;
        bh=F+XUZwCUG5ClfawV4L75vtZe4n31lBwXwM1crTuhm6g=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=RxJEwPufOmswEfDVEP86h9qnUCB9NBnY6v8lr5thIB/S3EZYc53E5VfEGJHXrAB5e
         E21X4KIse+x7QHuBnudg5in4NwGsk4ckVAYDLAIwDRVSGrtXFLRhPfQU0kfHF33K8W
         K9qDZ9bHMR3KDgkptbAn7Cnezr4H+isPlNUEUDUZdpCtZORU3TTPUV+OABzdVITlVl
         sEKTVzcf/IlM/vtbfBOhirjU0pFHRrgbn061dWVZqHUnvaQknsv8ttWhu7octT9cDO
         SfYh4TfpTgkJNvn5qXcGoTfQei4I6zY+DtITrOs5yBqMx7UpyBfKaIgnQ7Kgz5qUIM
         8VXRWjUXkeVtA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210904152856.31946-1-miles.chen@mediatek.com>
References: <20210904152856.31946-1-miles.chen@mediatek.com>
Subject: Re: [PATCH v2] clk: rockchip: use module_platform_driver_probe
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Miles Chen <miles.chen@mediatek.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>
Date:   Sun, 05 Sep 2021 13:44:05 -0700
Message-ID: <163087464562.405991.6849585594197172835@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Miles Chen (2021-09-04 08:28:56)
> Replace builtin_platform_driver_probe with module_platform_driver_probe
> because that rk3399 and rk3568 can be built as kernel modules.
>=20
> Fixes: 70d839e2761d ("clk: rockchip: rk3399: Support module build")
> Fixes: cf911d89c4c5 ("clk: rockchip: add clock controller for rk3568")
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
>=20
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
