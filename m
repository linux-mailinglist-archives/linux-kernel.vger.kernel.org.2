Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA6B3FD2E2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 07:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241995AbhIAFaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 01:30:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241855AbhIAFaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 01:30:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43AC46101A;
        Wed,  1 Sep 2021 05:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630474152;
        bh=vFRoMnI5E+T7ANwFPqrpfWz6ZduToH4v9Fpy76sOXh8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=DQ7+z0gNZSAym9NhdpMsP0Dkg8zmBa1RYsiKh1YWlnWidxbVE6pFVdReF+C6WGXqg
         vDyttXJ85q+kDa60FNUSRSWFmIFjB2kkwklL7NdUSMsLGoiZNqBIj3SyDY3EsKBiE2
         qszPhn88cvMdraAQJXKgIxL3UFhguEm04EiV7jD/Re0kfnffb6VKC8hUv/pHmEcsCU
         oZe/L1korV9GLClR9wP12bmwZxvLIY47LQyOIaqpeyUjax8qVj8pWsWFiFjD9Tf/sh
         lBjE96uY9ieAhGb0ongAb5Xclo98+i0wHWI4ARLEBmim0p7c0Qnw2fZu5LMWtHwEJL
         voQoXaMi4HVVw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210830115931.GH12231@kadam>
References: <545df946044fc1fc05a4217cdf0054be7a79e49e.1619161112.git.christophe.jaillet@wanadoo.fr> <163021483704.2676726.2051426762011017819@swboyd.mtv.corp.google.com> <20210830115931.GH12231@kadam>
Subject: Re: [PATCH] clk: mvebu: ap-cpu-clk: Fix a memory leak in error handling paths
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Julia.Lawall@inria.fr, gregory.clement@bootlin.com,
        lee.jones@linaro.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
To:     Dan Carpenter <dan.carpenter@oracle.com>
Date:   Tue, 31 Aug 2021 22:29:10 -0700
Message-ID: <163047415097.42057.17295321906417094458@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dan Carpenter (2021-08-30 04:59:31)
> On Sat, Aug 28, 2021 at 10:27:17PM -0700, Stephen Boyd wrote:
> > Quoting Christophe JAILLET (2021-04-23 00:02:26)
> > > If we exit the for_each_of_cpu_node loop early, the reference on the
> > > current node must be decremented, otherwise there is a leak.
> > >=20
> > > Fixes: f756e362d938 ("clk: mvebu: add CPU clock driver for Armada 7K/=
8K")
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > ---
> > > Also, I wonder if the drivers in drivers/clk/mvebu are used by anyone.
> > > In order to compile-test the changes, I also had to change the 'bool'=
 in Kconfig
> > > by 'bool "blah"'. Without this change, it was not possible to set
> > > CONFIG_ARMADA_AP_CPU_CLK required by Makefile.
> > >=20
> > > I don't know if I did something wrong, if it is an issue only on my e=
nvironment
> > > or if something got broken at some time in the build chain but it loo=
ks
> > > spurious.
> > >=20
> > > If I'm right and that these drivers never compile and no-one noticed =
it,
> > > maybe removing them is better than fixing some unlikely issues and st=
yle.
> > > If these drivers should stay, Kconfig may need some love from someone.
> >=20
> > Nobody has said anything on this patch. So I'm not really sure what's
> > going on. Probably we never take the error path, or the whole system
> > fails to boot?
>=20
> You probably take this one.
>=20
>    106                  /* If cpu2 or cpu3 is enabled */
>    107                  if (cpu & APN806_CLUSTER_NUM_MASK) {
>    108                          nclusters =3D 2;
>    109  +                       of_node_put(dn);
>    110                          break;
>    111                  }
>=20
> But, yeah, probably on one carse of "dn" can't be freed in real life.
>=20
> Still probably worth fixing though just for correctness.  Otherwise it
> makes static analysis less effective if people deliberately leave bugs
> in the code.

Thanks. Can we turn that into a Reviewed-by?
