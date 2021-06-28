Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85CD3B5785
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 04:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbhF1C5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 22:57:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231984AbhF1C5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 22:57:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 081A061A1D;
        Mon, 28 Jun 2021 02:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624848919;
        bh=cx7qh3lkj8FpUVeQl1lHhT+q04JbXWm9rzjjdfTRFBs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=QkZHX99fahdBv9ZojAuvaIPwkQUl65cCpKUvcVmPqut+xtFPh1VTz9zZRxRlCSiZc
         +E/4ojPJmgHfbsHrif++eifIhXviEz89BgGfQrLYHwxDX165GRVBe5Vn7BzHKkcDl3
         NxMqR5MtXaHhjI6DIvlU9gfcwuXiMIEnHn/FNx8vw5QB/LnqSv23Rci3FPOBke9k/h
         CT9GXPEbZTxOCmIGDKkfkHdwhvV7/0q1N9U2sCzY+6KbwCr6F6M/c2x8hnwmyO4gYS
         1FZEimSti1s8W/nS+GqBCqF1xBfH6B10hHfYvp1DKgrSurhF4JwvKUNNx8qB1+lWi5
         vKzSjys6BUaDQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210331201632.24530-8-avolmat@me.com>
References: <20210331201632.24530-1-avolmat@me.com> <20210331201632.24530-8-avolmat@me.com>
Subject: Re: [PATCH v4 7/7] dt-bindings: clock: st: clkgen-fsyn: add new introduced compatible
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
To:     Alain Volmat <avolmat@me.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Sun, 27 Jun 2021 19:55:17 -0700
Message-ID: <162484891788.2516444.15034205531719797793@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alain Volmat (2021-03-31 13:16:32)
> New compatible are added, supporting various kind of clkgen-fsyn
> used for STiH407, STiH410 and STiH418
>=20
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---

Applied to clk-next
