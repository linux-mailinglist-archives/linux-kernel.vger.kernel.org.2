Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15D33D6AFE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 02:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbhGZXmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 19:42:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233770AbhGZXmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 19:42:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D136760F93;
        Tue, 27 Jul 2021 00:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627345370;
        bh=C8NvBNnHDePPtCxCLZrkDH3kttYIfmaVHEhCkBYBFoA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=njRUyAnKO7UJeysaPOvjKMM7JO/XjTt8hrdXpLxKsQcnZIFOwgN2wD2LMKFYYZNV+
         cbM4jFRY2r75KzScYMMS//VQ7AamT4R5X3yDXVxKmC6yue1m3Fwmefz5Fim2ddaRrR
         59aRF7MBgax4nLxXwh39pQ+8M7vtXzJ99Wacx9+T9xBet3CVke7yXdEfYSUMxeHTV9
         EXrm5szL4dORlMiYRak6oX2lYXyXCKrYWwG/4X95eA6WO32JOKs4tp2+Ec98GnC06E
         Cl5baUVj2Fxw73O09tYh4NQ8wdtVJlYINjhuMqrjkC3MchWvogsB4hjecDx9BpESE5
         V26qm4OBxROMA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210725160725.10788-1-dariobin@libero.it>
References: <20210725160725.10788-1-dariobin@libero.it>
Subject: Re: [RESEND PATCH v4] clk: stm32f4: fix post divisor setup for I2S/SAI PLLs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Dario Binacchi <dariobin@libero.it>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Gabriel Fernandez <gabriel.fernandez@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
To:     Dario Binacchi <dariobin@libero.it>, linux-clk@vger.kernel.org
Date:   Mon, 26 Jul 2021 17:22:49 -0700
Message-ID: <162734536950.2368309.11504276867614624593@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dario Binacchi (2021-07-25 09:07:25)
> Enabling the framebuffer leads to a system hang. Running, as a debug
> hack, the store_pan() function in drivers/video/fbdev/core/fbsysfs.c
> without taking the console_lock, allows to see the crash backtrace on
> the serial line.
>=20
> ~ # echo 0 0 > /sys/class/graphics/fb0/pan
>=20
> [    9.719414] Unhandled exception: IPSR =3D 00000005 LR =3D fffffff1
> [    9.726937] CPU: 0 PID: 49 Comm: sh Not tainted 5.13.0-rc5 #9
> [    9.733008] Hardware name: STM32 (Device Tree Support)
> [    9.738296] PC is at clk_gate_is_enabled+0x0/0x28
> [    9.743426] LR is at stm32f4_pll_div_set_rate+0xf/0x38
> [    9.748857] pc : [<0011e4be>]    lr : [<0011f9e3>]    psr: 0100000b
> [    9.755373] sp : 00bc7be0  ip : 00000000  fp : 001f3ac4
> [    9.760812] r10: 002610d0  r9 : 01efe920  r8 : 00540560
> [    9.766269] r7 : 02e7ddb0  r6 : 0173eed8  r5 : 00000000  r4 : 004027c0
> [    9.773081] r3 : 0011e4bf  r2 : 02e7ddb0  r1 : 0173eed8  r0 : 1d3267b8
> [    9.779911] xPSR: 0100000b
> [    9.782719] CPU: 0 PID: 49 Comm: sh Not tainted 5.13.0-rc5 #9
> [    9.788791] Hardware name: STM32 (Device Tree Support)
> [    9.794120] [<0000afa1>] (unwind_backtrace) from [<0000a33f>] (show_st=
ack+0xb/0xc)
> [    9.802421] [<0000a33f>] (show_stack) from [<0000a8df>] (__invalid_ent=
ry+0x4b/0x4c)
>=20
> The `pll_num' field in the post_div_data configuration contained a wrong
> value which also referenced an uninitialized hardware clock when
> clk_register_pll_div() was called.
>=20
> Fixes: 517633ef630e ("clk: stm32f4: Add post divisor for I2S & SAI PLLs")
> Signed-off-by: Dario Binacchi <dariobin@libero.it>
> Reviewed-by: Gabriel Fernandez <gabriel.fernandez@st.com>
>=20
> ---

Applied to clk-fixes
