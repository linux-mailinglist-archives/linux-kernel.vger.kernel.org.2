Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E3F3B577B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 04:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhF1C50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 22:57:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232057AbhF1C5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 22:57:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE2E961A2B;
        Mon, 28 Jun 2021 02:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624848901;
        bh=GCUQC2V4bnGeibGu8l6mYA61rPI+amfXLOs6RZf8g+M=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=uuulasrR098Ri80caVU7ljvp1PRzb8BWurp67l2Lu9YyLpwR27Xlwn36vbswEPoeg
         eOGTEcXse9ZipKN5X56NkLI1I4BrCwQAqTSADe6WIWvcgZqcHn/HiOsnx/BfQNl8T1
         GIF2RgcGpf4FhRhxg0evAdxpViGD9untsJ+ajYKujC1fIBYvubMFBBxBQ8kHsEULYN
         ku7qACu2PY7/zl8TfNC1Mz/azJ+FyM05v18UbVOmokDqGCP3uSp49J7PWvCRkVMHqE
         +/LCDjAjNS2CGI0uPj07Aip/Yfx+jMFx5FW2PlZmUaDmOLezKU/fYaOIdOQu0iA5uW
         KzwNFpMVVufvQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210331201632.24530-5-avolmat@me.com>
References: <20210331201632.24530-1-avolmat@me.com> <20210331201632.24530-5-avolmat@me.com>
Subject: Re: [PATCH v4 4/7] clk: st: clkgen-pll: embed soc clock outputs within compatible data
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
To:     Alain Volmat <avolmat@me.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Sun, 27 Jun 2021 19:54:59 -0700
Message-ID: <162484889975.2516444.4926700900032513987@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alain Volmat (2021-03-31 13:16:29)
> In order to avoid relying on the old style description via the DT
> clock-output-names, add compatible data describing the flexgen
> outputs clocks for all STiH407/STiH410 and STiH418 SOCs.
>=20
> In order to ease transition between the two methods, this commit
> introduce the new compatible without removing the old method.
> Once DTs will be fixed, the method relying on DT clock-output-names
> will be removed from this driver as well as old compatibles.
>=20
> Signed-off-by: Alain Volmat <avolmat@me.com>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---

Applied to clk-next
