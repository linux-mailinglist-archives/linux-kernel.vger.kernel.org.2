Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B26319368
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 20:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhBKTw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 14:52:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:36078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229961AbhBKTuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:50:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5CF864E45;
        Thu, 11 Feb 2021 19:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613072994;
        bh=4c3MKlXhsOtiG9Oj6Oqk8T6TzpYMlcq+a7LsNrbH0Ro=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=h6qXPGVlXr+t+Pmw+UxH/mlIK9CkiJAu0o3KASyo6QZy63rMfPD4Ubh5zO8n67zrz
         23hC0BSTqHNUvG0k0CBpiZV05ApuKpjR1jZhWpya2++2Ugb8rY+6XKrqzLoLtKsZMb
         rprfhEN+p9Wo/vZG+bVY5p2pCyBCmS1aE/cXHvfPsoyxZS+ULnUE3DzlWU66U9z9an
         HrqYS2s6yaO9CD3l2mD4+W+XMGXCPHIFcHVwNdYzWka2OWa2LOxMC8EjkbK5Wro3Kz
         z0pclVCGOK+k6X6ytZ1lE08ZKHbppZzeSoUHSbTJtjB+0GwnimZCVrCtpEQ4InJ1nN
         fwxHhOBGwUtjg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210120093040.1719407-7-lee.jones@linaro.org>
References: <20210120093040.1719407-1-lee.jones@linaro.org> <20210120093040.1719407-7-lee.jones@linaro.org>
Subject: Re: [PATCH 06/20] clk: sifive: fu540-prci: Declare static const variable 'prci_clk_fu540' where it's used
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Pragnesh Patel <Pragnesh.patel@sifive.com>,
        Zong Li <zong.li@sifive.com>, linux-clk@vger.kernel.org,
        linux-riscv@lists.infradead.org
To:     lee.jones@linaro.org
Date:   Thu, 11 Feb 2021 11:49:52 -0800
Message-ID: <161307299270.1254594.13908235432213477383@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lee Jones (2021-01-20 01:30:26)
> Fixes the following W=3D1 kernel build warning(s):
>=20
>  drivers/clk/sifive/fu540-prci.h:16:35: warning: =E2=80=98prci_clk_fu540=
=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>  drivers/clk/sifive/fu540-prci.h:16:35: warning: =E2=80=98prci_clk_fu540=
=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Pragnesh Patel <Pragnesh.patel@sifive.com>
> Cc: Zong Li <zong.li@sifive.com>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---

Applied to clk-next
