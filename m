Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D158735A44D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 19:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbhDIRCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 13:02:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233332AbhDIRCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 13:02:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B59E610E5;
        Fri,  9 Apr 2021 17:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617987737;
        bh=H054uauBn55WDEKJX1Dn0ZTS/kaN7tvN8NjbaxWYx0A=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=beVadimSQ/xufCkjGvDfft8+xl8x3iE8QePcpL3rTLKatzaDXf/+fKHFuLhKZy08t
         MBzKC+H4bwJWje/czw6ziBuxPPpac3zKY7LLcfHungu4U3xXDhNo6fbyqwwihOgQSf
         JmJzMa127l8MAiE/KMfIvJ9KHGd3+9h9TdprbgWlVcXkVL2HMb6JRt1/qvcXJjgv8M
         vTaoV1RMYk7O3tV6tCRUMwJXGeYSRPrLxESnQvZ+7IFgnoRAT7hHbcnbbdgdzzKiCU
         NVnjvGkl/jH6pQ26bLWb4XyJ0JWOElOL1iVDd3zxLdkDivjqhy9Uf2+ppNyIBhH9r2
         +qAcwaGtAmZhQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <161795309623.1751103.16552528876108968953.b4-ty@arndb.de>
References: <20210314110709.32599-1-krzysztof.kozlowski@canonical.com> <161795309623.1751103.16552528876108968953.b4-ty@arndb.de>
Subject: Re: [PATCH v2] clk: socfpga: fix iomem pointer cast on 64-bit
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>
To:     Arnd Bergmann <arnd@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 09 Apr 2021 10:02:16 -0700
Message-ID: <161798773615.3790633.4877613255691338405@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2021-04-09 00:26:50)
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> On Sun, 14 Mar 2021 12:07:09 +0100, Krzysztof Kozlowski wrote:
> > Pointers should be cast with uintptr_t instead of integer.  This fixes
> > warning when compile testing on ARM64:
> >=20
> >   drivers/clk/socfpga/clk-gate.c: In function =E2=80=98socfpga_clk_reca=
lc_rate=E2=80=99:
> >   drivers/clk/socfpga/clk-gate.c:102:7: warning: cast from pointer to i=
nteger of different size [-Wpointer-to-int-cast]
>=20
> I decided to pull that into the arm/drivers branch as well, to avoid the
> build regression. Since the same fix is in the clk tree, there will now
> be a duplicated commit in the git history, but I prefer that over introdu=
cing
> warnings.
>=20
> [1/1] clk: socfpga: fix iomem pointer cast on 64-bit
>       commit: 36841008059caec9667459a7e126efac6379676b
>=20

Ok. I'm sending it off to Linus now.
