Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E836134F687
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 04:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhCaCRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 22:17:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhCaCRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 22:17:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 428FC617C9;
        Wed, 31 Mar 2021 02:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617157042;
        bh=k2ujAaXUGvCFAUPXWDajOOzm00JETNInO+hpR/7b9M0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=pim0g4Scj8GeEfiEdCL9O8yfB7bt1fX3BttmJn3yccNUcaZzFlrN/T40raUvUI2Ys
         muLBKrlLpZkrV0v3ySfE+5Lx9WhXBKbr7/9vRBrh3ANOjVTqb4Es300G/IMj0IveC1
         Iyg9Fr/6eMwbji9oEhfEGE7iJenh0ymjiFY1xVzYaFhjyGDe8HbxhcaXQO0Fjse/1h
         Uvrvg1Zx05ieqNv8b6Fdvq1pG4bu778Byt2aO3PxY5ubW3iL9KYuAZHYR/rohcViSz
         NVVvsQ6uE/bod3OCPUpvphvIdOyTY35ioCyYHBfqhK+J8V/WKsZmH3/Zc0d2xBwfhk
         aK43Vqku4gZeg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1615796268-9011-1-git-send-email-hongxing.zhu@nxp.com>
References: <1615796268-9011-1-git-send-email-hongxing.zhu@nxp.com>
Subject: Re: [PATCH] clk: imx8mp: Remove the none exist pcie clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Richard Zhu <hongxing.zhu@nxp.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>, abel.vesa@nxp.com,
        ping.bai@nxp.com, shawnguo@kernel.org
Date:   Tue, 30 Mar 2021 19:17:20 -0700
Message-ID: <161715704096.2260335.13325173794029732808@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Richard Zhu (2021-03-15 01:17:47)
> In the i.MX8MP PCIe design, the PCIe PHY REF clock comes from external
> OSC or internal system PLL. It is configured in the IOMUX_GPR14 register
> directly, and can't be contolled by CCM at all.
> Remove the PCIE PHY clock from clock driver to clean up codes.
> There is only one PCIe in i.MX8MP, remove the none exist second PCIe
> related clocks.
> Remove the none exsits clocks IDs together.
>=20
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Jason Liu <jason.hui.liu@nxp.com>
> ---

Any Fixes tag?
