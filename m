Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0215444CB7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 01:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhKDAwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 20:52:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230030AbhKDAwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 20:52:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 677BE60174;
        Thu,  4 Nov 2021 00:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635987004;
        bh=3dlUjRG3KNU0eMuf/I6y01AapcaRXgOoFOERLyaNZjQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=OdKj1OvGozbJxuOhP+jR705rgCjLLh/8ePihr5k/sqFz5pcKRt8g4T/hd3Jrom+G2
         N24cA2WiKUDC1isrPDdz/ocXOunvMzRcUTQJRRWU2+Km/CR5TmHm6UxiSDtrrzku75
         sVXIo3nbzK/SIulABqbkDh5QYoaKx6R2sorhReBiZ0/PRBofs9WOi+NYSqEExE7cAx
         wJnoIYiHDyfiwb+ZssXUA9c697nA++lBsLl8dBHvy5maq0hud6DS7eeB76hmoQwQGI
         NkyFd5WWxk6Wv8G+5y13U5MOFboJjfBkTXs9o9oJlnna0DmckD9v6/eCiRxtV/Fdmn
         K0fYlpP6/jQyQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211103122441.3208576-1-alexander.stein@ew.tq-group.com>
References: <20211103122441.3208576-1-alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH 1/1] clk: composite: Fix 'switching' to same clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Wed, 03 Nov 2021 17:50:02 -0700
Message-ID: <163598700289.2993099.1140453821965698575@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexander Stein (2021-11-03 05:24:41)
> During commit 6594988fd625 ("clk: composite: Use rate_ops.determine_rate
> when also a mux is available") setting req->best_parent_hw got lost,
> so best_parent_hw stays NULL during switch to the same parent. This
> results in the (debug) message:
>   clk_calc_new_rates: lcdif_pixel not gated but wants to reparent
> and the following rate change is dropped.
>=20
> Fixes: 6594988fd625 ("clk: composite: Use rate_ops.determine_rate when al=
so a mux is available")
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---

Applied to clk-next
