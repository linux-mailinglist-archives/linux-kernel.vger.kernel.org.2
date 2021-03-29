Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5113434D7BD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 21:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhC2TEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 15:04:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231459AbhC2TEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 15:04:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6843761935;
        Mon, 29 Mar 2021 19:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617044687;
        bh=eOjic/hIQUT/8NYo2bz3ptRUuJ0fa7y6ickmvy1IDiE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=TitPMaYXrkRBznDTY/iG69LU1dYlsEW/w7vHA1EFdVd+hVhunYGJgcIsVXXR6LKWx
         7bU+7MqHlYSJsZSaCJefxfa//N+/1q2hbjBRUmtMb8EaKsk1CfYOC/8fjoEo7e1e/z
         Duw1xiON+DB3jmARa2WySvTxAyB1avK3iO2HDxoSy+5+Td6ahg4E6D6ePCLjIvNAFT
         cMP1CHDWtvX0jswHIJ+c5vRfcKTt0MfsH4wTY8EYr6xq+PaeMaXu5wz7qf1v4PXZ0e
         NBlNiVw5albYtsS30AduluYlBc/IUyoRT+WzWH1JJRi21mVc607vwW+z/+BxRm7vFP
         92+7DEDuR7KIA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210314110709.32599-1-krzysztof.kozlowski@canonical.com>
References: <20210314110709.32599-1-krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v2] clk: socfpga: fix iomem pointer cast on 64-bit
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Mar 2021 12:04:45 -0700
Message-ID: <161704468593.3012082.13780036588312732592@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2021-03-14 04:07:09)
> Pointers should be cast with uintptr_t instead of integer.  This fixes
> warning when compile testing on ARM64:
>=20
>   drivers/clk/socfpga/clk-gate.c: In function =E2=80=98socfpga_clk_recalc=
_rate=E2=80=99:
>   drivers/clk/socfpga/clk-gate.c:102:7: warning: cast from pointer to int=
eger of different size [-Wpointer-to-int-cast]
>=20
> Fixes: b7cec13f082f ("clk: socfpga: Look for the GPIO_DB_CLK by its offse=
t")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Acked-by: Dinh Nguyen <dinguyen@kernel.org>
>=20
> ---

Applied to clk-fixes
