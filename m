Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F763FA95C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 07:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbhH2F2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 01:28:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233657AbhH2F2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 01:28:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53E0560F3A;
        Sun, 29 Aug 2021 05:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630214838;
        bh=RIBMzmRwll8XYCReqJmjVkP9457awMYlTmM3N/i1+Es=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=XC/LslHREKwza4nUVtqQj1BQX+zdtEWUN9LQwKpvl6K/6xCMIVQ1M/RXGiDOXhRBz
         iz4RVspHJyaLPQw72NOMxySwHAN888NbXfZx7AYKA6QM6wUY3+lIlnJXPNhLqMblaZ
         HiTQ2N0uje/aCGXDtIVWnvaUXiMg6vrFxO7Zlv+fBRC1T4vndHiwlxX4tIXjzuyQf4
         Zs1ln2Xjxsb0geH0xm+BgbESt5kYt7lQngBfzMjvWNYTj0R3gBBEtwgDNzelTB2I+W
         81MVQzjnlbgBOxUsZjlqW6fp3EiyQjuxoWuBq9XMWq0S2d61dYVt1P0KfnbSJzPjRD
         ZUX32IzVot1DQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <545df946044fc1fc05a4217cdf0054be7a79e49e.1619161112.git.christophe.jaillet@wanadoo.fr>
References: <545df946044fc1fc05a4217cdf0054be7a79e49e.1619161112.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] clk: mvebu: ap-cpu-clk: Fix a memory leak in error handling paths
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Julia.Lawall@inria.fr, gregory.clement@bootlin.com,
        lee.jones@linaro.org, mturquette@baylibre.com
Date:   Sat, 28 Aug 2021 22:27:17 -0700
Message-ID: <163021483704.2676726.2051426762011017819@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christophe JAILLET (2021-04-23 00:02:26)
> If we exit the for_each_of_cpu_node loop early, the reference on the
> current node must be decremented, otherwise there is a leak.
>=20
> Fixes: f756e362d938 ("clk: mvebu: add CPU clock driver for Armada 7K/8K")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Also, I wonder if the drivers in drivers/clk/mvebu are used by anyone.
> In order to compile-test the changes, I also had to change the 'bool' in =
Kconfig
> by 'bool "blah"'. Without this change, it was not possible to set
> CONFIG_ARMADA_AP_CPU_CLK required by Makefile.
>=20
> I don't know if I did something wrong, if it is an issue only on my envir=
onment
> or if something got broken at some time in the build chain but it looks
> spurious.
>=20
> If I'm right and that these drivers never compile and no-one noticed it,
> maybe removing them is better than fixing some unlikely issues and style.
> If these drivers should stay, Kconfig may need some love from someone.

Nobody has said anything on this patch. So I'm not really sure what's
going on. Probably we never take the error path, or the whole system
fails to boot?
