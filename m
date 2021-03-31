Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65AB334F688
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 04:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbhCaCRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 22:17:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233258AbhCaCRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 22:17:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC12F617C9;
        Wed, 31 Mar 2021 02:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617157060;
        bh=zkICwrrTeBiiLJ9V0FzAwANVNmAM7UQ4w7wCc5b4x/o=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=qCr432Um8dBOw+48bQSTDx2e90LrdqooiQyo34yEl6DfxvjvXg4IuKo0NhlUNvStI
         fx5D/f1mh9E+aTFmSjxLp6FJMQ+Nuo3aKMdTZZKd+9Yizb0bNeLAefTUMLf2PKbcUP
         N6BphAPpfUMYlUzonG3LkOcMAT38NTOXuwhdyWs6UryWQabAcDJsWwU3mbjQFIlhp4
         Dwt8Ji1MUMCTi3qaP4jMBj/cjH39gzUDMfxU47McXwUB9C9kYLr6/CTBWXgj89b4VF
         BTI6v4HYHnM6SP67NbgMlaNJzPcljzZqNqu7zyCvTMHjAxWBAJpeOUCdCHm24iKIhw
         hR+EgDgrRAsLw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1615796268-9011-2-git-send-email-hongxing.zhu@nxp.com>
References: <1615796268-9011-1-git-send-email-hongxing.zhu@nxp.com> <1615796268-9011-2-git-send-email-hongxing.zhu@nxp.com>
Subject: Re: [PATCH] clk: imx8mq: Correct the pcie1 sels
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Richard Zhu <hongxing.zhu@nxp.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>, abel.vesa@nxp.com,
        ping.bai@nxp.com, shawnguo@kernel.org
Date:   Tue, 30 Mar 2021 19:17:39 -0700
Message-ID: <161715705952.2260335.14485382500737180840@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Richard Zhu (2021-03-15 01:17:48)
> - The sys2_pll_50m should be one of the clock sels of PCIE_AUX clock.
> Change the sys2_pll_500m to sys2_pll_50m.
> - Correct one mis-spell of the imx8mq_pcie1_ctrl_sels definition, from
> "sys2_pll_250m" to "sys2_pll_333m".
>=20
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---

Any Fixes tag?
