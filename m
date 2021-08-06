Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D091D3E200D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 02:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241050AbhHFAeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 20:34:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229587AbhHFAeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 20:34:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2129461184;
        Fri,  6 Aug 2021 00:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628210046;
        bh=KWGKxT0s2vEJJ4Bf65qKXqIKH5Jwt+0N/UWrxrHOKKs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bh41k+qH9JL5hJPQZn9T0FlcpkB256RLMPQZ9ROcdjcIxzlsVPLRU7Z/25VIwQ2J3
         xAUzGQWettX3V9PSb8rs/VM7Up6XmZC4PZCaxLKmsRi5dF/j+HLJ/BDkN4udu3ZsSZ
         SLQI+O4oH1qfurYLRTKkiIP9IdwaYd7eQ3M/notx/No8iifkycljfUTF24TLBk+ngO
         ApL77F+xXmBMwEy8dPFuzS/JX9Rmpqp4gAkHsG1PMLIpJy4P1tsFZM/3jvoXPFJ2/A
         shHRefcDTjeiGvVSdXoB/hTARe0G5ocGTHa5KFpuXmy4sUFD4T13t0j0Ut1lZBDflk
         wmwFhkRVJh3nA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210731132226.424853-1-wangborong@cdjrlc.com>
References: <20210731132226.424853-1-wangborong@cdjrlc.com>
Subject: Re: [PATCH] clk: palmas: Add a missing SPDX license header
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
To:     Jason Wang <wangborong@cdjrlc.com>
Date:   Thu, 05 Aug 2021 17:34:04 -0700
Message-ID: <162821004487.19113.11370841376423221944@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jason Wang (2021-07-31 06:22:26)
> Add the missing SPDX license header to drivers/clk/clk-palmas.c.
>=20
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/clk/clk-palmas.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/clk/clk-palmas.c b/drivers/clk/clk-palmas.c
> index e41a3a9f7528..84dcb1aca4a5 100644
> --- a/drivers/clk/clk-palmas.c
> +++ b/drivers/clk/clk-palmas.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Clock driver for Palmas device.
>   *

Shouldn't we remove the license text in the comment at the same time?
