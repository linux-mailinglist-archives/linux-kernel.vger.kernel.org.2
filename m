Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B443FADE8
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 20:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbhH2SjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 14:39:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231919AbhH2SjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 14:39:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EBEB60E73;
        Sun, 29 Aug 2021 18:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630262306;
        bh=a+fDHlf5S7w5I7Kq1LzJ90Pr9i1mEOucSlmKNIBkhxY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=JIMF6VCnq8UV9SR2Pg41OJPBQxtTTac5Ka0SMvW1qcRh3VKJICcbarbmSJ5gcDArI
         gfuQ8/+E1hWfWJFzAO/xe15I7Dz/4JihMzuxJw9VSdvevjoEt2JFHs6rx4pP2Di/ta
         K18YlJ/ySpHTrGh1b1ZF1dz22WzUq0ZVdfgCU4VLu312sxpMeGFZ4zLcUM0fVw/t9b
         u0DqqNtt2L5HDrvSkA+X+33/2frpvZenzMx/U4H6plU1GpMQq5PbKpNVYKPu6rupdQ
         IxdLGer687yFOd9EBEaelEqADZb/ozu3/xqqdg+SFMgtKUEqEOQ3I08omBpDofRM8w
         tiNQlLcRlAkfw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210322215047.1062540-1-arnd@kernel.org>
References: <20210322215047.1062540-1-arnd@kernel.org>
Subject: Re: [PATCH] clk: tegra: fix old-style declaration
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Arnd Bergmann <arnd@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Date:   Sun, 29 Aug 2021 11:38:25 -0700
Message-ID: <163026230526.2676726.10182158463483641713@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2021-03-22 14:50:41)
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> With extra warnings enabled, gcc complains about a slightly odd
> prototype:
>=20
> drivers/clk/tegra/clk-dfll.c:1380:1: error: 'inline' is not at beginning =
of declaration [-Werror=3Dold-style-declaration]
>  1380 | static void inline dfll_debug_init(struct tegra_dfll *td) { }
>=20
> Move the 'inline' keyword to the start of the line.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Applied to clk-next
