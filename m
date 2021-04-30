Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24F436FF03
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 18:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhD3Q5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 12:57:48 -0400
Received: from ms11p00im-qufo17291901.me.com ([17.58.38.48]:47118 "EHLO
        ms11p00im-qufo17291901.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230492AbhD3Q5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 12:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1619801323; bh=gKPg4laKAZy+RHF+D3ii19N0LJXtiXVtOwEzgUk8ws8=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=0fMvPTXZl/U10xLNN7Azbfa6h2gCnmFs8IsrXw2Kzg3a8g8MkG7EfFbtpbvfASNGp
         Q3D2O3XLBT3f42D6QQI8/JinbPlES5tAtXr2OL+hT5fh+fMPcg4oO2kfqOwMbpHUjI
         gtnfS00rfXjqUWOLl8/I1BdFuwnloSemHH8qIoAH4vFWUzlJAjRNTA8wkdNSrageYh
         DvOIRJyaYfgdiuZtp6G4I+NlHvw0h4tZ31ZhOtUY2L/YwrJKTGvP/F3GDJFlC5OGKJ
         F/x5z0ezR4GRhovArt2CqpmtlTm5iVy8k2sCcD5P1OurUlUT5p92UBZHRAoUAjfW38
         l4ysE6hag5A8A==
Received: from gnbcxl0029.gnb.st.com (101.220.150.77.rev.sfr.net [77.150.220.101])
        by ms11p00im-qufo17291901.me.com (Postfix) with ESMTPSA id 3E7B3CA0477;
        Fri, 30 Apr 2021 16:48:40 +0000 (UTC)
Date:   Fri, 30 Apr 2021 18:48:31 +0200
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/7] clk: st: embed clock outputs within drivers
Message-ID: <20210430164830.GA6248@gnbcxl0029.gnb.st.com>
Mail-Followup-To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210331201632.24530-1-avolmat@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331201632.24530-1-avolmat@me.com>
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.391,18.0.761,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-04-30=5F08:2021-04-30=5F02,2021-04-30=5F08,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=862 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2104300110
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Gentle reminder about this serie concerning STi platform clock drivers.
Could you have a look at them ?

Thanks.
Alain

On Wed, Mar 31, 2021 at 10:16:25PM +0200, Alain Volmat wrote:
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
> Alain Volmat (7):
>   clk: st: clkgen-pll: remove unused variable of struct clkgen_pll
>   clk: st: flexgen: embed soc clock outputs within compatible data
>   dt-bindings: clock: st: flexgen: add new introduced compatible
>   clk: st: clkgen-pll: embed soc clock outputs within compatible data
>   dt-bindings: clock: st: clkgen-pll: add new introduced compatible
>   clk: st: clkgen-fsyn: embed soc clock outputs within compatible data
>   dt-bindings: clock: st: clkgen-fsyn: add new introduced compatible
> 
>  .../bindings/clock/st/st,clkgen-pll.txt       |   3 +
>  .../bindings/clock/st/st,flexgen.txt          |  10 +
>  .../bindings/clock/st/st,quadfs.txt           |   3 +
>  drivers/clk/st/clk-flexgen.c                  | 367 +++++++++++++++++-
>  drivers/clk/st/clkgen-fsyn.c                  | 113 +++++-
>  drivers/clk/st/clkgen-pll.c                   | 121 +++++-
>  6 files changed, 576 insertions(+), 41 deletions(-)
> 
> ---
> v4: - add an additional CLK_IS_CRITICAL within flexgen driver
> v3: - removal some useless CLK_IS_CRITICAL and add some comments
>     - only keep clk drivers/binding patches within the serie
> 
> -- 
> 2.17.1
> 
