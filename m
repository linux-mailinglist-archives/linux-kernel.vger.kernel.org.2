Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4CD23B56E8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 03:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhF1BtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 21:49:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231678AbhF1BtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 21:49:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 070986197F;
        Mon, 28 Jun 2021 01:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624844816;
        bh=vTQIs1kfZfitP/aHJkjYEq0+KvikkvaSy5odLIYpSNI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=WJZVJbHa+Zfdpr9Qgl4g7aRYJ0izP28YuI8CmGhVpY5h9lCpxFjWDYKR95IjMn+Xj
         tQFVZQ4rnu1/Iz8/LBN2kuwfeBko6oZbEqOSVmPNpRGj3p9NsK2wdPDz/v6dzMLP/f
         EHtDeTRjCu6HUYnbA9Jr448VE8h97fdUse3rYQCqB+vFpOvFa0s8yIGJ9Xic0M48Os
         WnqeBMmVudoXjtBsMEI4XtpvuXx0GNfnBhsYSM/tPq6aw5zLEj92c7QyRwEglf1FHY
         4vfWnJ3butIxLMWTwyZFT3JNxM12PB7EVIvdEs0uK4tTs+Rs7k/KdYM5BoczRYpRUS
         5ff9oF9hNxbLg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4714d05982b19ac5fec2ed74f54be42d8238e392.1623354574.git.cristian.ciocaltea@gmail.com>
References: <cover.1623354574.git.cristian.ciocaltea@gmail.com> <4714d05982b19ac5fec2ed74f54be42d8238e392.1623354574.git.cristian.ciocaltea@gmail.com>
Subject: Re: [PATCH v3 1/6] clk: actions: Fix UART clock dividers on Owl S500 SoC
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
Date:   Sun, 27 Jun 2021 18:46:54 -0700
Message-ID: <162484481471.3259633.18331628827385445710@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Cristian Ciocaltea (2021-06-10 13:05:21)
> Use correct divider registers for the Actions Semi Owl S500 SoC's UART
> clocks.
>=20
> Fixes: ed6b4795ece4 ("clk: actions: Add clock driver for S500 SoC")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Applied to clk-next
