Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBED33B56B2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 03:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbhF1Bhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 21:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231944AbhF1Bhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 21:37:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4828061A0F;
        Mon, 28 Jun 2021 01:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624844106;
        bh=jb1XMrhEG19AbPQTUHuWETcCQGxcfxIPzG7Tw3ZcsSw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=m46AXvGfxvbfRqpJ2DBJu1X8q3bAUWDFDEcBOqklJWqFsTafjDTVsjVNLq6wdeQe+
         ru2iPAvfjtNQv4/ZB2HI9bMZp0c1sQdC6/N824tOswaFuUd8OSRwpHVpj2HEs/BeHR
         IUKt219T+6f012lTfrLnd1pm0p5y66CEgdAJ3K6vTsxQ9c1EZsS6visGdVUxNUyJg+
         nLgfquigyv915NnMTK1zL656HI88LhtSoFCCcipb4qNeOw+klyhPsRuUPmYiBfPkOK
         y8zeSnWV8ILZe0r6ZrRSqrkKkiviYp+vG7tNWT9RgaZLo5SdXRkKLO4AxA0NL74OSk
         w1n8X38EUhpvg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210617051814.12018-4-gabriel.fernandez@foss.st.com>
References: <20210617051814.12018-1-gabriel.fernandez@foss.st.com> <20210617051814.12018-4-gabriel.fernandez@foss.st.com>
Subject: Re: [RESEND PATCH v3 03/11] clk: stm32mp1: remove intermediate pll clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Etienne Carriere <etienne.carriere@foss.st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, marex@denx.de
Date:   Sun, 27 Jun 2021 18:35:05 -0700
Message-ID: <162484410515.3259633.1559491465596857173@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting gabriel.fernandez@foss.st.com (2021-06-16 22:18:06)
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>=20
> This patch is to prepare STM32MP1 clocks in trusted mode.
> Integrate the mux clock into pll clock will facilitate to have a more
> coherent clock tree in no trusted / trusted mode.
>=20
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---

Applied to clk-next
