Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900BF357CFC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 09:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhDHHGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 03:06:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230124AbhDHHGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 03:06:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F3E961154;
        Thu,  8 Apr 2021 07:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617865590;
        bh=UsUSzyuuKnCBntpnhQyJp6l/hjWiwPTKlZU0rkV173c=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=M/wpDZPC7q++gHED65M/xzRvcHG7Yvu1sXdsFEeKT+u/O5jiKIwPJ1XN+x8CyWHEk
         UjwE4zUQqt9yVH8+Jkm2YaONMLO2RP+fx/A2p+cXibGeXdSXSI8PtI/j05gkW9gi9g
         UhpE+y4CmoyucEd4PaSvcyI0PrvhEqwrkquoMVjjlgBMuV2zJFCuwjoO4hLLcbIt+P
         UwnpEIgz0V+RsoboncpXj7QTXRY8o74h3s53Q0R3GfZyTMCLoSL4f17fgDynJAhyva
         7jarYK2T6Ue8/Lx/32jNsX27UzbW9Udo99IpP3uCVbOKH4tyA6+NLI5P8Hbb4sInaO
         rlEbSA3PvuLvg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1617568824-2311-1-git-send-email-abel.vesa@nxp.com>
References: <1617568824-2311-1-git-send-email-abel.vesa@nxp.com>
Subject: Re: [GIT PULL] clk: imx: Updates for v5.13
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>
Date:   Thu, 08 Apr 2021 00:06:29 -0700
Message-ID: <161786558917.3790633.14467115349480488916@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2021-04-04 13:40:24)
> The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab=
15:
>=20
>   Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git clk/imx
>=20
> for you to fetch changes up to 054ef44ea3ef2883e0f63c9a54c91c07f321a0b4:
>=20
>   clk: imx: Reference preceded by free (2021-04-04 22:39:05 +0300)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-next. Next time can you send a signed tag with a
small blurb about what is included?
