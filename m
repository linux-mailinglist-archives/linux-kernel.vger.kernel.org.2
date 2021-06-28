Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D753B56B9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 03:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbhF1Bho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 21:37:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:39458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231986AbhF1Bhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 21:37:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA8546144B;
        Mon, 28 Jun 2021 01:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624844117;
        bh=lXKI3Tc7F9js0VIjjh3xPOSfMOxCjjva2xk10rU5otw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=qVve3izKSA0wRvMCJo0u6AvDPMWr8rRqaJXAFL9t8QQbEOB8bJTOYD+D/cTy6Fgze
         qR6Q8iwGdka3FtFikoS2Ehnqa26A/ucPVQZbe3Jvz8iJ8LTfDh3OFaZowRuGhnmb1/
         P00xOeY3YjEVUDMZY8Kla5P19L7sclvOurtmLihEvh2OVyIHu4k/UXvOXzkgKDqUfF
         +5eZzng1z2IBqKQV3W0UePlJgGbCcJubXdP6TJgYiMq9DsThYKSL76oxDELm3RmYh4
         YgdiLrI3LXfgn30YBXkjfGzmGgqJdKog+UE4d+ZamA9h6P60FADZ1tr5GHHQWPcopl
         HqZCqvvGSnXcw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210617051814.12018-6-gabriel.fernandez@foss.st.com>
References: <20210617051814.12018-1-gabriel.fernandez@foss.st.com> <20210617051814.12018-6-gabriel.fernandez@foss.st.com>
Subject: Re: [RESEND PATCH v3 05/11] clk: stm32mp1: move RCC reset controller into RCC clock driver
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
Date:   Sun, 27 Jun 2021 18:35:16 -0700
Message-ID: <162484411661.3259633.16032716391656538380@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting gabriel.fernandez@foss.st.com (2021-06-16 22:18:08)
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>=20
> RCC clock and reset controller shared same memory mapping.
> As RCC clock driver is now a module, the best way to register clock
> and reset controller is to do it in same driver.
>=20
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---

Applied to clk-next
