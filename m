Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82FB40BCD9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 03:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbhIOBDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 21:03:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233152AbhIOBDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 21:03:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B57961184;
        Wed, 15 Sep 2021 01:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631667742;
        bh=udVh1TAsgPmwNjVn3KUni1r595k3eNrnxx1BzjJPfNg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=I9/4lsCy5YTCOIxVVE1awPH5K7iDvPLUCXfoJuNOvq6UdgMfWT+8qx9ffMHRFWMyp
         BLYHPjhBvDBZHqq1v2eYAH7PmI7SmE9C5T9vELkEMB5WDXdI3nFmtsd8rG2BCT6c6a
         g7nuHkk4odx6yoq7oAM50BZeOyLQl8+jeRvYCKguRsHBV7q+0xX6feucTeY6h01WgN
         nBc2A8gO6glBjSKOfWf7feZ9o4wkj5Ap1DOh/roAlETLtUgeexdRHZPY9lkXyzvlbC
         VoVMjqRS48anC59msCPMPmk+yYA6vmJgP1DmTTH4nLaxppzJKOKpkVOSpuKgFU9S5a
         Esv/qYmjjueyg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1631521490-17171-4-git-send-email-abel.vesa@nxp.com>
References: <1631521490-17171-1-git-send-email-abel.vesa@nxp.com> <1631521490-17171-4-git-send-email-abel.vesa@nxp.com>
Subject: Re: [PATCH 3/8] clk: imx: Rework all clk_hw_register_gate wrappers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>
Date:   Tue, 14 Sep 2021 18:02:21 -0700
Message-ID: <163166774126.763609.5220932254449450325@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2021-09-13 01:24:45)
> Instead of having multiple inline functions that were calling
> clk_hw_register_gate, implement a generic low-level __imx_clk_hw_gate
> and implement the rest as macros that pass on as arguments whatever
> is needed in each case.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
