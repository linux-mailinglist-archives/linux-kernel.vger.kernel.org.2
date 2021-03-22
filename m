Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47558345092
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 21:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhCVUQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 16:16:56 -0400
Received: from st43p00im-zteg10063501.me.com ([17.58.63.176]:44811 "EHLO
        st43p00im-zteg10063501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230447AbhCVUQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 16:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1616444191; bh=jtDTXY0sBs7RpioSTHC3KmbVgcFGZnI25SJuBpFiXT4=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=WzQdaSG/H1yUc/T+HpKpSaBzwkXECHZKwS4HnqEiO82RUwaYE2XyBtQdbzdzVYTss
         abJ6oVk9mFQR7X9n0rufZlHEGiKVlWWFJaapr94xxxMBbTKs4VkBhSPHSnAt8gE1j6
         2E4zMRgCqkRXi8VpRFt0G28pN0pkBLzB4urTi+BvPwEXzb3fPtGSWqICEn4329/kzh
         P3cvvQmX7gr5A4+HvECEXPvxRKdFcUfKUfCvuzNjz9DfroN7HKvIsLXg0p4pUEiT34
         4291nfZk309oIwZWsHj50Kkb/FZrvD4K9ZJJYfc84hgMsVS1eIMaiE7wfj305TCU63
         6FCNaALLa3rjQ==
Received: from gnbcxl0029.gnb.st.com (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-zteg10063501.me.com (Postfix) with ESMTPSA id 3D022C806BD;
        Mon, 22 Mar 2021 20:16:23 +0000 (UTC)
Date:   Mon, 22 Mar 2021 21:16:20 +0100
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/16] clk: st: embed clock outputs within drivers
Message-ID: <20210322201619.GB26692@gnbcxl0029.gnb.st.com>
Mail-Followup-To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210321204038.14417-1-avolmat@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210321204038.14417-1-avolmat@me.com>
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.369,18.0.761,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-03-22=5F10:2021-03-22=5F03,2021-03-22=5F10,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 clxscore=1015
 spamscore=0 bulkscore=0 mlxlogscore=949 adultscore=0 phishscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103220149
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

it turns out that some CLK_IS_CRITICAL are missing in the patches I sent.
(especially for the stih418).
I will send a v2 soon.

Alain

On Sun, Mar 21, 2021 at 09:40:22PM +0100, Alain Volmat wrote:
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
> 
> This serie also contains modifications within STi DTS in order to use
> the newly introduced compatible and remove clock-output-names
> properties.
> 
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
> 
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
> 
> -- 
> 2.17.1
> 
