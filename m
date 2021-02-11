Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9BA3193D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhBKUDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:03:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:39280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231727AbhBKT5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:57:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2688E64E5F;
        Thu, 11 Feb 2021 19:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613073419;
        bh=NYyqM+APAuRJfRRlkyIxgJlHUt2fMaHxusXG+d+xXn0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=doEZvJX0SliViRD0VWtz8IRsGjKRDC5owplAazugK7Ri1uusadscl35cQ/rQqtFh6
         ScnzPoB2iABIy0z7UCTlrtnI9MHm0zQp7wFe3keaifyJMhCGnL2i5qdc5+QP9BnDNe
         u4Wqfvw8xr+T4agPz66NrPcDmzEkgWg7+ms/WuSBamJNGvswCZ7XbawLD9DGSi8zxI
         6TcWXX+MjYBb0Fsw99ubNrdIpvm0j0HhixG7Bv46u1rCdkYav+1SAHd4d97KJLyyOM
         /ZS/AS/qfsf3rfuGjC/VQE1sUBDkqZHw/kzGynP1Y6TJKHQu/Smf11v0AE/2kxpg7Y
         tywAc8ikzZz4g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210126124540.3320214-16-lee.jones@linaro.org>
References: <20210126124540.3320214-1-lee.jones@linaro.org> <20210126124540.3320214-16-lee.jones@linaro.org>
Subject: Re: [PATCH 15/21] clk: clk-npcm7xx: Remove unused static const tables 'npcm7xx_gates' and 'npcm7xx_divs_fx'
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nuvoton Technologies <tali.perry@nuvoton.com>,
        openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org
To:     lee.jones@linaro.org
Date:   Thu, 11 Feb 2021 11:56:57 -0800
Message-ID: <161307341789.1254594.6715719974957898063@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lee Jones (2021-01-26 04:45:34)
> Fixes the following W=3D1 kernel build warning(s):
>=20
>  drivers/clk/clk-npcm7xx.c:438:43: warning: =E2=80=98npcm7xx_gates=E2=80=
=99 defined but not used [-Wunused-const-variable=3D]
>  drivers/clk/clk-npcm7xx.c:365:48: warning: =E2=80=98npcm7xx_divs_fx=E2=
=80=99 defined but not used [-Wunused-const-variable=3D]
>=20
> Cc: Avi Fishman <avifishman70@gmail.com>
> Cc: Tomer Maimon <tmaimon77@gmail.com>
> Cc: Tali Perry <tali.perry1@gmail.com>
> Cc: Patrick Venture <venture@google.com>
> Cc: Nancy Yuen <yuenn@google.com>
> Cc: Benjamin Fair <benjaminfair@google.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Nuvoton Technologies <tali.perry@nuvoton.com>
> Cc: openbmc@lists.ozlabs.org
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---

Applied to clk-next
