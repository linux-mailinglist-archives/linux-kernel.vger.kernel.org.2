Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C80034DDEA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 04:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhC3CBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 22:01:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230467AbhC3CBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 22:01:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 578726193A;
        Tue, 30 Mar 2021 02:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617069661;
        bh=tPB7I98WMiY4qUDzrZwfnJOg5RGmk1XF+lQBzxV+12M=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=HLJ/CrQx+D1nZMt8Mo7t4MP4iaRDIKYME6Emjyu7efBoa9rA7riDU8sDf9p5HztY6
         CGST2pfmufMD6sAF/jcTnSibKKmAmi9RIVStio33IqczDSj5HCGab62M/oAy//BHpj
         /j+fYx5aDMpQbjYu5s83L/0I5ujXX0OUCE0qtLf+Z+9k9vPp0DnRX6jUHVhNWsTdzD
         A21CWGkFVL7wdZs7CKFDpiHePeE974XvF6QjfAGMppP1BuVq2xUKRZxutcrFBRSpLg
         lX4yBAzfcVSlwU1CT3eNWG6y0jvDbjZuxr7mD6+TKuDyp74fo5wgzrNgBy0uqpcjhC
         i5UJRed8vtauA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210325075018.6598-1-avolmat@me.com>
References: <20210325075018.6598-1-avolmat@me.com>
Subject: Re: [PATCH v2 00/16] clk: st: embed clock outputs within drivers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
To:     Alain Volmat <avolmat@me.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Mon, 29 Mar 2021 19:01:00 -0700
Message-ID: <161706966003.3012082.13602640109563561014@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alain Volmat (2021-03-25 00:50:02)
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
> This serie also contains modifications within STi DTS in order to use
> the newly introduced compatible and remove clock-output-names
> properties.

Can you split the dts changes from the driver changes and only send the
clk driver changes to clk maintainers? I don't intend to apply dts file
changes to the clk tree. Those can go via arm-soc based on some
immutable branch that lives in clk tree until next merge window closes.

>=20
> Alain Volmat (16):
>   clk: st: clkgen-pll: remove used variable of struct clkgen_pll
>   clk: st: flexgen: embed soc clock outputs within compatible data
>   dt-bindings: clock: st: flexgen: add new introduced compatible
>   clk: st: clkgen-pll: embed soc clock outputs within compatible data
>   dt-bindings: clock: st: clkgen-pll: add new introduced compatible
>   clk: st: clkgen-fsyn: embed soc clock outputs within compatible data
>   dt-bindings: clock: st: clkgen-fsyn: add new introduced compatible
>   ARM: dts: sti: update flexgen compatible within stih418-clock
>   ARM: dts: sti: update flexgen compatible within stih407-clock
>   ARM: dts: sti: update flexgen compatible within stih410-clock
>   ARM: dts: sti: update clkgen-pll entries in stih407-clock
>   ARM: dts: sti: update clkgen-pll entries in stih410-clock
>   ARM: dts: sti: update clkgen-pll entries in stih418-clock
>   ARM: dts: sti: update clkgen-fsyn entries in stih407-clock
>   ARM: dts: sti: update clkgen-fsyn entries in stih410-clock
>   ARM: dts: sti: update clkgen-fsyn entries in stih418-clock
>=20
>  .../bindings/clock/st/st,clkgen-pll.txt       |   3 +
>  .../bindings/clock/st/st,flexgen.txt          |  10 +
>  .../bindings/clock/st/st,quadfs.txt           |   3 +
>  arch/arm/boot/dts/stih407-clock.dtsi          | 128 +------
>  arch/arm/boot/dts/stih410-clock.dtsi          | 138 +------
>  arch/arm/boot/dts/stih418-clock.dtsi          | 136 +------
>  drivers/clk/st/clk-flexgen.c                  | 344 +++++++++++++++++-
>  drivers/clk/st/clkgen-fsyn.c                  | 113 +++++-
>  drivers/clk/st/clkgen-pll.c                   | 121 +++++-
>  9 files changed, 588 insertions(+), 408 deletions(-)
>=20
> ---
> v2: fix drivers to update some clocks as CLK_IS_CRITICAL
>=20

Please document in the code why CLK_IS_CRITICAL is used. For example,
"This clk needs to be on so the CPU can keep fetching instructions from
memory" or something like that.
