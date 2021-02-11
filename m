Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64017319379
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 20:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhBKTyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 14:54:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:36574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230073AbhBKTwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:52:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C54A664E44;
        Thu, 11 Feb 2021 19:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613073113;
        bh=K/hY5wVeIwYX5AlxTPUqycqd1GGGOBH+wQu7HORNDRc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=QAxVqIHq0W3ZVr86OmizDDxR6jBdjsimnX1OH4Q1grGhozCVFTupqsjcu43vLCaar
         yCzj2IpcK2MQFaSiBPbqx2K1pogGKd55F/XSRbBcvDJcynADu5AYUJar5M9brfxlFS
         6wRIz+shzyIjdPnAQc15Vio8Iu39HjmOMz/Y+BfuyyoG4aw2FfH+WV5ZENL+4jWvgR
         DnA8z2xxpLCihp2T0KWvpYX1dO7Dd45759yZ6jZjCjZd68MU0QmKept8BiiWUZ1t/l
         H6weIpikhwy4BjnI4FT6LWyFWINO8sI4vmsN9lOHg7Dkp1VINF8ySp1Dk2DpofbWpr
         RYzBaM7IOgOZw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210120093040.1719407-13-lee.jones@linaro.org>
References: <20210120093040.1719407-1-lee.jones@linaro.org> <20210120093040.1719407-13-lee.jones@linaro.org>
Subject: Re: [PATCH 12/20] clk: st: clkgen-fsyn: Fix worthy struct documentation demote partially filled one
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Kees Cook <keescook@chromium.org>,
        Stephen Gallimore <stephen.gallimore@st.com>,
        Pankaj Dev <pankaj.dev@st.com>, linux-clk@vger.kernel.org
To:     lee.jones@linaro.org
Date:   Thu, 11 Feb 2021 11:51:52 -0800
Message-ID: <161307311268.1254594.6065734191013956676@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lee Jones (2021-01-20 01:30:32)
> Fixes the following W=3D1 kernel build warning(s):
>=20
>  drivers/clk/st/clkgen-fsyn.c:186: warning: Function parameter or member =
'data' not described in 'st_clk_quadfs_pll'
>  drivers/clk/st/clkgen-fsyn.c:466: warning: Function parameter or member =
'regs_base' not described in 'st_clk_quadfs_fsynth'
>  drivers/clk/st/clkgen-fsyn.c:466: warning: Function parameter or member =
'lock' not described in 'st_clk_quadfs_fsynth'
>  drivers/clk/st/clkgen-fsyn.c:466: warning: Function parameter or member =
'data' not described in 'st_clk_quadfs_fsynth'
>  drivers/clk/st/clkgen-fsyn.c:466: warning: Function parameter or member =
'chan' not described in 'st_clk_quadfs_fsynth'
>  drivers/clk/st/clkgen-fsyn.c:466: warning: Function parameter or member =
'md' not described in 'st_clk_quadfs_fsynth'
>  drivers/clk/st/clkgen-fsyn.c:466: warning: Function parameter or member =
'pe' not described in 'st_clk_quadfs_fsynth'
>  drivers/clk/st/clkgen-fsyn.c:466: warning: Function parameter or member =
'sdiv' not described in 'st_clk_quadfs_fsynth'
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Stephen Gallimore <stephen.gallimore@st.com>
> Cc: Pankaj Dev <pankaj.dev@st.com>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---

Applied to clk-next
