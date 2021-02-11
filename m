Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87D53193C5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhBKUAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:00:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:38502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231584AbhBKT4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:56:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9C7A64E56;
        Thu, 11 Feb 2021 19:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613073331;
        bh=YK/ei7wLW51NsPt77rVFJERz+G0b7Ph3HfSV4MR8U8g=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=XHeYbVcWMMuhuTkpb89lEIC2UufVKXLNRNm5lBvQd+XH29dzGKxowvwjQARD8qB4B
         h3rhBFLGOOVwDlU98tRnSVOXxX2W/aVQX1DwxGQ4iDtqRWm1Mb0SjarZWDHr+WtkmC
         Se6+8fsf6lQDSu+LsJ9ssoj3qu21owZrPn8qWji/4g7CCh92229nrY7xsPwLBsgg2T
         6BDGh0XEYwImtXIepUv+zbqt3taL/dE5vu2bcJdfkqvVy3otW2vK+z+5nx1vXvRO/X
         2+JjtgYE0G+hR7YXFNAn3BPqqO0V0FGSVgtE2L53PbWA91cBCxLbu13L2dWdSJOUHR
         lzTDX7j4O6UmQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210126124540.3320214-8-lee.jones@linaro.org>
References: <20210126124540.3320214-1-lee.jones@linaro.org> <20210126124540.3320214-8-lee.jones@linaro.org>
Subject: Re: [PATCH 07/21] clk: tegra: clk-tegra30: Remove unused variable 'reg'
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org
To:     lee.jones@linaro.org
Date:   Thu, 11 Feb 2021 11:55:29 -0800
Message-ID: <161307332953.1254594.10666357608133365469@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lee Jones (2021-01-26 04:45:26)
> Fixes the following W=3D1 kernel build warning(s):
>=20
>  drivers/clk/tegra/clk-tegra30.c: In function =E2=80=98tegra30_enable_cpu=
_clock=E2=80=99:
>  drivers/clk/tegra/clk-tegra30.c:1107:15: warning: variable =E2=80=98reg=
=E2=80=99 set but not used [-Wunused-but-set-variable]
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
