Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1715831936D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 20:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhBKTwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 14:52:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:36198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231659AbhBKTvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:51:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54D3764E4D;
        Thu, 11 Feb 2021 19:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613073018;
        bh=vEj52QrTB3DfttglfRNcoqrt3NXfwulDarICYmUWhlw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=I5VlhfLk2uVBCZSzqWxE6sFbIywpNS6Wm6v09le6m/nDrgk7J6ZdeX76NSzJ/3Ypy
         wa75JaqUV9UdUXkOCbBlkCi4kFV/VGWRhu7NP4Gs6GF9a1XrJyDvG1vrSt7abo/omE
         3Rn94W4Mnbc+mCY3Vd4RwSHzoBGXhwsByE4eeJP7UVsCJ5gq9vW9YnHVqzZERRp5l1
         pWP0s60qlv+Y+QH2IvAx1Q79N8UbskisWygOe8MEH/r9ZD6WG4sCVkBS832xRlQVEJ
         eaeHRZU1cK1dDM17f44ksbg0dVKOMd/IQD+JNQ7tfCf378+RXdmLzTiv+gio5SK10I
         oEDkU3b+ufCfw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210120093040.1719407-8-lee.jones@linaro.org>
References: <20210120093040.1719407-1-lee.jones@linaro.org> <20210120093040.1719407-8-lee.jones@linaro.org>
Subject: Re: [PATCH 07/20] clk: socfpga: clk-pll: Remove unused variable 'rc'
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
To:     lee.jones@linaro.org
Date:   Thu, 11 Feb 2021 11:50:17 -0800
Message-ID: <161307301719.1254594.11691786943581656058@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lee Jones (2021-01-20 01:30:27)
> Fixes the following W=3D1 kernel build warning(s):
>=20
>  drivers/clk/socfpga/clk-pll.c: In function =E2=80=98__socfpga_pll_init=
=E2=80=99:
>  drivers/clk/socfpga/clk-pll.c:83:6: warning: variable =E2=80=98rc=E2=80=
=99 set but not used [-Wunused-but-set-variable]
>=20
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---

Applied to clk-next
