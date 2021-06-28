Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88C33B576D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 04:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhF1C47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 22:56:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231753AbhF1C44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 22:56:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E9EF616E8;
        Mon, 28 Jun 2021 02:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624848871;
        bh=4xczTrJ0OCNI9I6C7bsdJOZwyo9gcmhvoB7c0kzpcz4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=D+JNDcrHM+3kWbbdxuSr6uXRWJR5jmrX4QIQjgUIxcu8X9dsjn9RIvZoBaToFqH9d
         i5kCJgOFg0sSVT2gn1oQ4qpMa/M1vVl0sfvN6Q39qgyXpYeO4mQu820ZWPfs7a6hu4
         my+YvmOS6msWlWfLp01Ug25pG1VVh99WfX0NDUxZBPEPDAXzCVpY2PfVuOR4LKotrS
         +CeqBRRbwhKvewEbksxy/7N6sZeMINTOqRT+uMQ13TeQxXsuXFEWeO53h1rbWv9EB2
         0JsGAWEHqhorC/yPrjWfuLyZqAPq2iqTeHUE7MqF65hkhbcll+lIbTmUfEQen098om
         Gmu/eFBOVCOVw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210331201632.24530-1-avolmat@me.com>
References: <20210331201632.24530-1-avolmat@me.com>
Subject: Re: [PATCH v4 0/7] clk: st: embed clock outputs within drivers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
To:     Alain Volmat <avolmat@me.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Sun, 27 Jun 2021 19:54:30 -0700
Message-ID: <162484887017.2516444.1565486127246410364@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alain Volmat (2021-03-31 13:16:25)
> Most of ST clock drivers used by STi platform are updated in
> order to introduce clock outputs informations within each drivers
> and thus allow to avoid having to rely on clock-output-names properties
> within DT clock nodes.
> For that purpose, drivers are updated to allow handling both modes
> (with or without clock-output-names).
> Once all DT will have been updated, the legacy mode could be removed
> from the drivers.
> This will also allow, once all STi DT will be corrected, to remove the
> of_clk_detect_critical API from clk core code since STi clock drivers
> are the only drivers using this API.
>=20
> Alain Volmat (7):
>   clk: st: clkgen-pll: remove unused variable of struct clkgen_pll
>   clk: st: flexgen: embed soc clock outputs within compatible data
>   dt-bindings: clock: st: flexgen: add new introduced compatible
>   clk: st: clkgen-pll: embed soc clock outputs within compatible data
>   dt-bindings: clock: st: clkgen-pll: add new introduced compatible
>   clk: st: clkgen-fsyn: embed soc clock outputs within compatible data
>   dt-bindings: clock: st: clkgen-fsyn: add new introduced compatible
>=20
>  .../bindings/clock/st/st,clkgen-pll.txt       |   3 +
>  .../bindings/clock/st/st,flexgen.txt          |  10 +
>  .../bindings/clock/st/st,quadfs.txt           |   3 +
>  drivers/clk/st/clk-flexgen.c                  | 367 +++++++++++++++++-
>  drivers/clk/st/clkgen-fsyn.c                  | 113 +++++-
>  drivers/clk/st/clkgen-pll.c                   | 121 +++++-
>  6 files changed, 576 insertions(+), 41 deletions(-)
>=20
> ---

Please don't do this triple dash. It made me have to run git am --skip
on this mbox because git thought this was a patch.

> v4: - add an additional CLK_IS_CRITICAL within flexgen driver
> v3: - removal some useless CLK_IS_CRITICAL and add some comments
>     - only keep clk drivers/binding patches within the serie
>
