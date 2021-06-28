Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25ACE3B5657
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 02:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbhF1AgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 20:36:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231689AbhF1AgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 20:36:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2816861584;
        Mon, 28 Jun 2021 00:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624840426;
        bh=FBi2YLCW92c1uFuvx3VBsGFRMiVxfq+fdBLeG/U6Sfc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=AslJ2GeG+2XcKcZkpoXp87WsSdOOsDFWO9/bm//hR1MRlUduXYSc2JSuP4wkoSzSz
         PLczeFKO/bK7uxlcN6rx/witGaTZo0nC+iUZhkT8y5Ok02C1csretsiIvJjdfdVP4q
         hEMV3Ms9JwqR78TadtE3RcZv8/bbYs9y7axnzZ/lREVgNHWXNP+jIfqNoDE8UccjfP
         Qy53jJhHWJkaQoKAlQVgNYWjsf3P6A+lH2q7K/ZM4+LtDAe88EyAAMVLbAHcTTxwxo
         Y0P5uPwD7DRDgpcQDw6kIyZEkq4jY52T/VwKXSsGRsDxvWGu+ub8tQWclIaww++FXI
         RNgZs9gvNrzMw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210609073742.722911-1-xinjian34324@163.com>
References: <20210609073742.722911-1-xinjian34324@163.com>
Subject: Re: [PATCH] clk: socfpga: clk-pll: Remove unused variable 'rc'
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jian Xin <xinjian@yulong.com>
To:     Jian Xin <xinjian34324@163.com>, dinguyen@kernel.org,
        mturquette@baylibre.com
Date:   Sun, 27 Jun 2021 17:33:44 -0700
Message-ID: <162484042495.3259633.4035444135672420533@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jian Xin (2021-06-09 00:37:42)
> From: Jian Xin <xinjian@yulong.com>
>=20
> Fix the following build warning:
>   drivers/clk/socfpga/clk-pll.c: In function =E2=80=98__socfpga_pll_init=
=E2=80=99:
>   drivers/clk/socfpga/clk-pll.c:83:6: warning: variable =E2=80=98rc=E2=80=
=99 set but not used [-Wunused-but-set-variable]
>=20
> Signed-off-by: Jian Xin <xinjian@yulong.com>
> ---

Applied to clk-next but it would be better to check the return value and
fail properly.
