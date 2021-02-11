Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A4D3193E9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhBKUFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:05:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:39744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230360AbhBKT7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:59:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F053964E15;
        Thu, 11 Feb 2021 19:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613073520;
        bh=qsKgKPSnrMDO1rr3mK65Nx07+4Dk/6RCWs6VZTXmdL8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=B6qvFmhTCke7rBOV5+4PV5eNU7dB7Fp75liOmlLcNFFNv9r30J5b+sC7rRNvjo8vZ
         UQra7G9JJMgPBhcnrwyl9QkIE6c5FEm1LEP0eJsFvg5s/ftGAJHTNRbCl/dKQt0sVH
         4gqh2znSJEQMb73yVaiEGBZPuHXKcCJAxB0W04eTL6woNQK1coBcstLd/Lx48hj+Cr
         KYJAat/zJLhUYiAoQsKiLrmPX3h9fhFYeZHNB2uofIFFcegHhLUBPiDAr9ouNUZS9z
         rvNwhBzHNn1XI8/FTT5MXnuoK3fbGtAzlps2j/8R9g52FtAkQmRjavfv0DUJeDt/UW
         pyXDXva34xHNg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210126124540.3320214-20-lee.jones@linaro.org>
References: <20210126124540.3320214-1-lee.jones@linaro.org> <20210126124540.3320214-20-lee.jones@linaro.org>
Subject: Re: [PATCH 19/21] clk: spear: Move prototype to accessible header
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Rajeev Kumar <rajeev-dlh.kumar@st.com>,
        linux-arm-kernel@lists.infradead.org
To:     lee.jones@linaro.org
Date:   Thu, 11 Feb 2021 11:58:38 -0800
Message-ID: <161307351871.1254594.17263867048131553655@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lee Jones (2021-01-26 04:45:38)
> Fixes the following W=3D1 kernel build warning(s):
>=20
>  drivers/clk/spear/spear1310_clock.c:385:13: warning: no previous prototy=
pe for =E2=80=98spear1310_clk_init=E2=80=99 [-Wmissing-prototypes]
>  drivers/clk/spear/spear1340_clock.c:442:13: warning: no previous prototy=
pe for =E2=80=98spear1340_clk_init=E2=80=99 [-Wmissing-prototypes]
>=20
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Rajeev Kumar <rajeev-dlh.kumar@st.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---

Applied to clk-next
