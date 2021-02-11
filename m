Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6221A3193CA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhBKUBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:01:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:38946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231263AbhBKT5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:57:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 072CA64E4D;
        Thu, 11 Feb 2021 19:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613073380;
        bh=7k0/TQK6kAErjL/y2GOzo/miWITmMhEzwhBNqzm7tWw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=tqL/+dFBywSGtObLxKruc1YdnCOVLvlt0fDhpwpzkxNmf6oNsF4rO7W9Es58fx2Cb
         vxVjLcQ7GSsGtnFi66T9HQvY2wg7ADKnIBZDr6dTtVIukPTWPnlkbZQ9OkmW8RqZud
         wPgATiB/D8BOKg5Vefs2ISsfzz9vM6l+JYq2eAX8WRGbNRtxCjP+YbXPxqgL5vLctg
         spgwa3PUyM+c44qqAxZ0xdzmNrLBVSBw82XfMyp6pOoItW4rXRNEGAplftc9thx1vW
         dKV+1s4nLdcjZMTm2z78FvtBQ/9f27cPrSonXwC7LUmJpjo9i9N0Wx5BCj6DP0UIdf
         fyUi/q28aGQsQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210126124540.3320214-10-lee.jones@linaro.org>
References: <20210126124540.3320214-1-lee.jones@linaro.org> <20210126124540.3320214-10-lee.jones@linaro.org>
Subject: Re: [PATCH 09/21] clk: tegra: cvb: Provide missing description for 'tegra_cvb_add_opp_table()'s align param
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org
To:     lee.jones@linaro.org
Date:   Thu, 11 Feb 2021 11:56:18 -0800
Message-ID: <161307337874.1254594.6281685477358324834@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lee Jones (2021-01-26 04:45:28)
> Fixes the following W=3D1 kernel build warning(s):
>=20
>  drivers/clk/tegra/cvb.c:106: warning: Function parameter or member 'alig=
n' not described in 'tegra_cvb_add_opp_table'
>=20
> Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
> Cc: Prashant Gaikwad <pgaikwad@nvidia.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---

Applied to clk-next
