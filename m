Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43E23B56F1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 03:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhF1Btj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 21:49:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231678AbhF1Bti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 21:49:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDC7461A1D;
        Mon, 28 Jun 2021 01:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624844833;
        bh=JoHbRaWN7yO4eVX+9Kbl23wQ66XUTTqvqMYKLX8Qfd4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=V8rlvp4jKEawRt+D0tAZhZoZOySwrVGxdtMa8lVFxM2uUrMCFoAfPsibOTfFh1avd
         tpdvlKM3N2Y+73E1tj31jhQ/fM2vQgVYyp7bt5iJfTDAS5ZEQjX1Dy+hifMFQoYnKC
         d/yHmSMUkz6jf9LzeiQAN3Sd9F4w2o0Gqba4Hsj2QKSs1PkEYx5RLUlx79oHoAJZx3
         WVutgFVbzN7hcO+BOsWIyXT9g83wIhAa18hV8PJ4cipJqVgWcquDkUOR0NLOyMjiFA
         aAnqbleEn/ioy0ymXc1g8fUvXOLG6KajrnY2a9/bs3DG4GNSQytMXvucrLFfhNuFQ5
         YID1zj+WOYmYg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <21c1abd19a7089b65a34852ac6513961be88cbe1.1623354574.git.cristian.ciocaltea@gmail.com>
References: <cover.1623354574.git.cristian.ciocaltea@gmail.com> <21c1abd19a7089b65a34852ac6513961be88cbe1.1623354574.git.cristian.ciocaltea@gmail.com>
Subject: Re: [PATCH v3 4/6] clk: actions: Fix AHPPREDIV-H-AHB clock chain on Owl S500 SoC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
To:     Andreas =?utf-8?q?F=C3=A4rber?= <afaerber@suse.de>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Sun, 27 Jun 2021 18:47:12 -0700
Message-ID: <162484483270.3259633.2045566523093940377@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Cristian Ciocaltea (2021-06-10 13:05:24)
> There are a few issues with the setup of the Actions Semi Owl S500 SoC's
> clock chain involving AHPPREDIV, H and AHB clocks:
>=20
> * AHBPREDIV clock is defined as a muxer only, although it also acts as
>   a divider.
> * H clock is using a wrong divider register offset
> * AHB is defined as a multi-rate factor clock, but it is actually just
>   a fixed pass clock.
>=20
> Let's provide the following fixes:
>=20
> * Change AHBPREDIV clock to an ungated OWL_COMP_DIV definition.
> * Use the correct register shift value in the OWL_DIVIDER definition
>   for H clock
> * Drop the unneeded 'ahb_factor_table[]' and change AHB clock to an
>   ungated OWL_COMP_FIXED_FACTOR definition.
>=20
> Fixes: ed6b4795ece4 ("clk: actions: Add clock driver for S500 SoC")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---

Applied to clk-next
