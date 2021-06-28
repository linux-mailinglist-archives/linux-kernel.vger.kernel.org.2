Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927373B56D2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 03:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhF1Bio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 21:38:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232020AbhF1Bin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 21:38:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7804361A1D;
        Mon, 28 Jun 2021 01:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624844178;
        bh=MCMV5T4CiHNIHgNwFS6RX6GLtK+F9KsNNlH0RjBQbUc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Rk6aW9fcleOWVfvDbtrkJ2m6ozYkqD9bJKn7a2Cj0rPWv4DdT4/gl8Ms8q5S/UAnI
         IdXm4nX0CPYiYmZIdLAmne5EGnwmvkJ+tvfHGuYJ7GIHFDdpF66SbcSRMwfRsaZ7EX
         uy/4DCOqlxiYu7KQkK/BAzRE9t/JgLG61RU9d/hnwLZjtx79qZ1b2TO3/kr2+SQPKD
         9mZ7zm0dfnufRiLeOV3WfJZckeFbTr0QIRBqD7HfsaUEIh5VyImS/v8YsFdh19eOjb
         K+Hhjlr/AsypBWLbCcLlz+tIqeqzBKs1KrRFMtqzees+KacMx+IFyljozDJBIkJIbL
         u8Eu55Q1GFL4g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210617051814.12018-12-gabriel.fernandez@foss.st.com>
References: <20210617051814.12018-1-gabriel.fernandez@foss.st.com> <20210617051814.12018-12-gabriel.fernandez@foss.st.com>
Subject: Re: [RESEND PATCH v3 11/11] clk: stm32mp1: new compatible for secure RCC support
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
Date:   Sun, 27 Jun 2021 18:36:17 -0700
Message-ID: <162484417735.3259633.16206197575374461808@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting gabriel.fernandez@foss.st.com (2021-06-16 22:18:14)
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>=20
> Platform STM32MP1 can be used in configuration where some clock
> resources cannot be accessed by Linux kernel when executing in non-secure
> state of the CPU(s).
> In such configuration, the RCC clock driver must not register clocks
> it cannot access.
> They are expected to be registered from another clock driver such
> as the SCMI clock driver.
> This change uses specific compatible string "st,stm32mp1-rcc-secure"
> to specify RCC clock driver configuration where RCC is secure.
>=20
> Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---

Applied to clk-next
