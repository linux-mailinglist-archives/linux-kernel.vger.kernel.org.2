Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97423193F0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhBKUGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:06:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:39880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230013AbhBKT7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:59:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9F8764E74;
        Thu, 11 Feb 2021 19:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613073532;
        bh=yqabmSw3ky4+SnSU9gnfBJ4L6nA5dwv7h9Ao3lfzpnw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=WTxgI/dxE8hvLy0kEAhHdK+g1IIpj5QGJhK4BAVQ6uLruQl2IUJEbEUS87iyDSe5u
         j4ArlxgUYMfFGzs08UuiiMj9TXkk9kaX/rIKX5xMLwOw5MsU9rGKFjk87RfX2WVAW/
         8a5No6cGQCn3tRoNF4md4MN7hgpQmXJ0zlhoTIapI7iMfMbCuJysqQJQ4HukWAdX1D
         XjF9WScr9JGi+EZHgLkz+oON5f+h2dzZi+ngOfcTAeimAow+SzVn+XpzZMwohGMm6p
         xxV32x66LnU/xlnPLnMZmraC+q/L4qlyaIPk2WqVN+Ic1mVlf7oUvyPAG1Ne5XGfYU
         kCHtuK20+uKrg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210126124540.3320214-22-lee.jones@linaro.org>
References: <20210126124540.3320214-1-lee.jones@linaro.org> <20210126124540.3320214-22-lee.jones@linaro.org>
Subject: Re: [PATCH 21/21] clk: zynqmp: divider: Add missing description for 'max_div'
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
To:     lee.jones@linaro.org
Date:   Thu, 11 Feb 2021 11:58:51 -0800
Message-ID: <161307353161.1254594.3642417051770254144@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lee Jones (2021-01-26 04:45:40)
> Fixes the following W=3D1 kernel build warning(s):
>=20
>  drivers/clk/zynqmp/divider.c:46: warning: Function parameter or member '=
max_div' not described in 'zynqmp_clk_divider'
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Rajan Vaja <rajan.vaja@xilinx.com>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---

Applied to clk-next
