Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E993B56BD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 03:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhF1BiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 21:38:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231678AbhF1BiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 21:38:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDA7661A0F;
        Mon, 28 Jun 2021 01:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624844147;
        bh=rZ+5WwkZx5O4yRYvr3i8zKSijKaHQfsSfeu1ljgWxRE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=UhnT8e9Am9Pb4KMupWyr8am8q/hM9gl/itgDX6MhHNmjh3W/tFBIVXe1j0885NDYy
         F009R8UAh7oXnk75Iv1p8KV2WnwTyxgWWQa0rX7V4LiiGBAFcWppHH2IF0eVZVzpjk
         kAgdC8Ey1qKy/qxv+g+q3uiRLz/0iB4OfiP4arnRpmCKCFVAZNixE72Q9EeFq5gERz
         vW7fZX2OZiPei4Ac0O5bOKSOoXGDddPpXTrJb79/jKQxvwYL1rRdXHF0k/dtPm0znE
         RkW2G2v5/v7mcLAjIKNy7+eOpBlIJzjTMCnBfdlDsAezKiwZHqR/3rj56SJiWjCBTH
         YTjO3fonkOaNg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210617051814.12018-7-gabriel.fernandez@foss.st.com>
References: <20210617051814.12018-1-gabriel.fernandez@foss.st.com> <20210617051814.12018-7-gabriel.fernandez@foss.st.com>
Subject: Re: [RESEND PATCH v3 06/11] reset: stm32mp1: remove stm32mp1 reset
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
Date:   Sun, 27 Jun 2021 18:35:46 -0700
Message-ID: <162484414661.3259633.15807994186850314510@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting gabriel.fernandez@foss.st.com (2021-06-16 22:18:09)
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>=20
> st32mp1 RCC reset driver was moved into stm32mp1 RCC clock driver.
>=20
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---

Applied to clk-next although it would be nice to get Philipp's ack
