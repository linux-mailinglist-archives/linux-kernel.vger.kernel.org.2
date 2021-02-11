Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223CC31939E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 20:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhBKT43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 14:56:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:38006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231289AbhBKTzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:55:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 562FB64E45;
        Thu, 11 Feb 2021 19:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613073267;
        bh=plow/Nl5sp9Qbeaz3RuFOPCFMn6bO2c6VClH6R59zz4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Ca7DW4sLXSieMVfSFut4k56gQwBe1Q5uq9J9KDM3XKf5JG1mZ8cceSnDRHw16lBJt
         9xp5AHGaIn7ztuqI/pz9XHWGo2DIRC41qtONn0xIWEwU6mfx+Ro3nFwdcub0zRJvUe
         CRG5mWPQSpY+8K9izAqiz+3EV0OzipTRmUVb4EETwsuBBV03xtKketM/YYJRu+T29N
         DcUHy/Lhfo8pKntyiqB5speVd/pXovprwuSPXUNy6cyK6kdRnGrYXqUvptDePO10q9
         duinsTH4GqImQItKRENaW73J3DNKMniSrc6eHDsYZhDd6/H2+glIynbkI670cXAezg
         NCn8B6wNsIfeQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210126124540.3320214-2-lee.jones@linaro.org>
References: <20210126124540.3320214-1-lee.jones@linaro.org> <20210126124540.3320214-2-lee.jones@linaro.org>
Subject: Re: [PATCH 01/21] clk: zynq: pll: Fix kernel-doc formatting in 'clk_register_zynq_pll's header
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>,
        =?utf-8?q?S=C3=B6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To:     lee.jones@linaro.org
Date:   Thu, 11 Feb 2021 11:54:25 -0800
Message-ID: <161307326594.1254594.18156729685110988578@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lee Jones (2021-01-26 04:45:20)
> Fixes the following W=3D1 kernel build warning(s):
>=20
>  drivers/clk/zynq/pll.c:187: warning: Function parameter or member 'name'=
 not described in 'clk_register_zynq_pll'
>  drivers/clk/zynq/pll.c:187: warning: Function parameter or member 'paren=
t' not described in 'clk_register_zynq_pll'
>  drivers/clk/zynq/pll.c:187: warning: Function parameter or member 'pll_c=
trl' not described in 'clk_register_zynq_pll'
>  drivers/clk/zynq/pll.c:187: warning: Function parameter or member 'pll_s=
tatus' not described in 'clk_register_zynq_pll'
>  drivers/clk/zynq/pll.c:187: warning: Function parameter or member 'lock_=
index' not described in 'clk_register_zynq_pll'
>  drivers/clk/zynq/pll.c:187: warning: Function parameter or member 'lock'=
 not described in 'clk_register_zynq_pll'
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: "S=C3=B6ren Brinkmann" <soren.brinkmann@xilinx.com>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---

Applied to clk-next
