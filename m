Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E663B4AD0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 01:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhFYXJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 19:09:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229844AbhFYXJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 19:09:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B8CC61945;
        Fri, 25 Jun 2021 23:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624662415;
        bh=FVWjfkyip/Ks0O6bAoeaWP3eziSs+2NyyTBM+e9UYn8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cMUBnwsGjNIBcSavj1rE2NiHFWM6N8CHIslzvHJQTOdsEKKMH6LsZqlCIvkvKKE40
         tazNNR7fUgeubbv29rlQUsp/X6XXQ0NagsGph5BEEzhzi3NAr/2Adnaww/QQCM8FOb
         oY1sbVeMOCottt48w6komagQ7xdW6TZ8Frp7J6uAWAJvlqZ5a06szlZwesKvlNzQhO
         XmAFZGES5WKfFPvq6/E7Gwy8RbkpwgRob51OfqpSW/dEXAkYh3v18QbVwyeocokC6P
         xbvlbLph+XtDntYlSDpuBUzH/gCdOaqi1/KEBrPLi+vloM1Oju3CqpfXcs6oI48uMN
         NNj9hJYXkHCYw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f1c4e8c903fe2d5df5413421920a56890a46387a.1624356908.git.michal.simek@xilinx.com>
References: <f1c4e8c903fe2d5df5413421920a56890a46387a.1624356908.git.michal.simek@xilinx.com>
Subject: Re: [PATCH v3] clk: zynqmp: fix compile testing without ZYNQMP_FIRMWARE
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
To:     git@xilinx.com, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, monstr@monstr.eu,
        quanyang.wang@windriver.com
Date:   Fri, 25 Jun 2021 16:06:54 -0700
Message-ID: <162466241428.3259633.9651068291046255073@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Michal Simek (2021-06-22 03:15:11)
> When the firmware code is disabled, the incomplete error handling
> in the clk driver causes compile-time warnings:
>=20
> drivers/clk/zynqmp/pll.c: In function 'zynqmp_pll_recalc_rate':
> drivers/clk/zynqmp/pll.c:147:29: error: 'fbdiv' is used uninitialized [-W=
error=3Duninitialized]
>   147 |         rate =3D  parent_rate * fbdiv;
>       |                 ~~~~~~~~~~~~^~~~~~~
> In function 'zynqmp_pll_get_mode',
>     inlined from 'zynqmp_pll_recalc_rate' at drivers/clk/zynqmp/pll.c:148=
:6:
> drivers/clk/zynqmp/pll.c:61:27: error: 'ret_payload' is used uninitialize=
d [-Werror=3Duninitialized]
>    61 |         return ret_payload[1];
>       |                ~~~~~~~~~~~^~~
> drivers/clk/zynqmp/pll.c: In function 'zynqmp_pll_recalc_rate':
> drivers/clk/zynqmp/pll.c:53:13: note: 'ret_payload' declared here
>    53 |         u32 ret_payload[PAYLOAD_ARG_CNT];
>       |             ^~~~~~~~~~~
> drivers/clk/zynqmp/clk-mux-zynqmp.c: In function 'zynqmp_clk_mux_get_pare=
nt':
> drivers/clk/zynqmp/clk-mux-zynqmp.c:57:16: error: 'val' is used uninitial=
ized [-Werror=3Duninitialized]
>    57 |         return val;
>       |                ^~~
>=20
> As it was apparently intentional to support this for compile testing
> purposes, change the code to have just enough error handling for the
> compiler to not notice the remaining bugs.
>=20
> Fixes: 21f237534661 ("clk: zynqmp: Drop dependency on ARCH_ZYNQMP")
> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---

Applied to clk-next. I see this fixes a bug in this upcoming release but
I'm sure we can pick this back to stable tree in a week or so once the
merge window opens. It's not like this is fixing anything besides
compile testing anyway.
