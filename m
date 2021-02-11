Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1405C319371
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 20:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhBKTxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 14:53:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:36322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229965AbhBKTvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:51:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8283064E56;
        Thu, 11 Feb 2021 19:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613073038;
        bh=r98rlhlNllzYS5AQmFIf3vfuW4NYXJSh8AGBu9H+O5M=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=e1q3lgQdx8gWd3NXPCAkPM+HVm/z2QguVxP019vEf4tM7bN5XIRdX536thrGZr159
         hWgM1oIDUTJHXb1RNib69dZWFSIWS/Dk/ViXlcgKDwQZsNfsLb+YQBmMorhkpYSGmj
         1nMBpwlLe0o65sGdYxr4I2sL+LmEpnq6s3G4sKLdH3zwyDKNdRkxuadtM0abDTPtUp
         gINpYIC4UNJmFcgCpmqjbiBny7tELjgeB3Amy4zdycuF9qx/Ye63fK4fgns2PW2DbL
         C3dzjdDVxZETMT0qWFKWRjYDB/qPUvZ9wynuQe6MRbxvyb14h9WnN4b2D4vxHuxhKI
         xo4frIKePKuSg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210120093040.1719407-9-lee.jones@linaro.org>
References: <20210120093040.1719407-1-lee.jones@linaro.org> <20210120093040.1719407-9-lee.jones@linaro.org>
Subject: Re: [PATCH 08/20] clk: socfpga: clk-pll-a10: Remove set but unused variable 'rc'
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
To:     lee.jones@linaro.org
Date:   Thu, 11 Feb 2021 11:50:37 -0800
Message-ID: <161307303729.1254594.3402191254635293308@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lee Jones (2021-01-20 01:30:28)
> Fixes the following W=3D1 kernel build warning(s):
>=20
>  drivers/clk/socfpga/clk-pll-a10.c: In function =E2=80=98__socfpga_pll_in=
it=E2=80=99:
>  drivers/clk/socfpga/clk-pll-a10.c:76:6: warning: variable =E2=80=98rc=E2=
=80=99 set but not used [-Wunused-but-set-variable]
>=20
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---

Applied to clk-next
