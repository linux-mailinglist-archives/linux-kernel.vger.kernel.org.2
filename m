Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE06B3ABD95
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 22:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbhFQUkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 16:40:07 -0400
Received: from st43p00im-ztdg10073201.me.com ([17.58.63.177]:40662 "EHLO
        st43p00im-ztdg10073201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231656AbhFQUkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 16:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1623961714; bh=WzHqbhruriJHXJn315Aj0/FTYYvgpr9/wzdxCiEiD4o=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=hiV/hzP2DQnxBM14AyeLP+pryXAkpeaYZdkwJlVsxqDtnIe3CEMCOZWf0uRMJAg46
         Twy8IWpEGwWns1Urthp+NAmjqwovDJueVrQI2i+LcXcMOgKCOexhLRjJr1MrsZPncs
         a8lCIEpiC+pcNh5geGGlIhdTYkrWKxMrmFETaePh1CBFTKSCNzaR1TC2qVU4CyMV+9
         U0hWcrUk6ljgY9aHBLaMiz55I97nACW5sYXBJRDChEx8iejKJuwDlP2RINbR78ZAkB
         fH0SB1bmHsVf3lI1R7DCj1bvNC1nxQj6HKml/ceuQL0Sc6A6geWsGLVYh7Wif7ZYZz
         ifUa8WmIMOugw==
Received: from gnbcxl0029.gnb.st.com (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztdg10073201.me.com (Postfix) with ESMTPSA id 647AC22185D;
        Thu, 17 Jun 2021 20:28:32 +0000 (UTC)
Date:   Thu, 17 Jun 2021 22:28:28 +0200
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/7] clk: st: embed clock outputs within drivers
Message-ID: <20210617202827.GA3089@gnbcxl0029.gnb.st.com>
Mail-Followup-To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210331201632.24530-1-avolmat@me.com>
 <20210430164830.GA6248@gnbcxl0029.gnb.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430164830.GA6248@gnbcxl0029.gnb.st.com>
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.391,18.0.790,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-06-17=5F15:2021-06-15=5F02,2021-06-17=5F15,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2106170123
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

gentle reminder about this serie. Patrick and Rob have given their
Reviewed-by already. Could you have a look at it ?

Thanks.
Alain

On Fri, Apr 30, 2021 at 06:48:30PM +0200, Alain Volmat wrote:
> Hi,
> 
> Gentle reminder about this serie concerning STi platform clock drivers.
> Could you have a look at them ?
> 
> Thanks.
> Alain
> 
> On Wed, Mar 31, 2021 at 10:16:25PM +0200, Alain Volmat wrote:
> > Most of ST clock drivers used by STi platform are updated in
> > order to introduce clock outputs informations within each drivers
> > and thus allow to avoid having to rely on clock-output-names properties
> > within DT clock nodes.
> > For that purpose, drivers are updated to allow handling both modes
> > (with or without clock-output-names).
> > Once all DT will have been updated, the legacy mode could be removed
> > from the drivers.
> > This will also allow, once all STi DT will be corrected, to remove the
> > of_clk_detect_critical API from clk core code since STi clock drivers
> > are the only drivers using this API.
> > 
> > Alain Volmat (7):
> >   clk: st: clkgen-pll: remove unused variable of struct clkgen_pll
> >   clk: st: flexgen: embed soc clock outputs within compatible data
> >   dt-bindings: clock: st: flexgen: add new introduced compatible
> >   clk: st: clkgen-pll: embed soc clock outputs within compatible data
> >   dt-bindings: clock: st: clkgen-pll: add new introduced compatible
> >   clk: st: clkgen-fsyn: embed soc clock outputs within compatible data
> >   dt-bindings: clock: st: clkgen-fsyn: add new introduced compatible
> > 
> >  .../bindings/clock/st/st,clkgen-pll.txt       |   3 +
> >  .../bindings/clock/st/st,flexgen.txt          |  10 +
> >  .../bindings/clock/st/st,quadfs.txt           |   3 +
> >  drivers/clk/st/clk-flexgen.c                  | 367 +++++++++++++++++-
> >  drivers/clk/st/clkgen-fsyn.c                  | 113 +++++-
> >  drivers/clk/st/clkgen-pll.c                   | 121 +++++-
> >  6 files changed, 576 insertions(+), 41 deletions(-)
> > 
> > ---
> > v4: - add an additional CLK_IS_CRITICAL within flexgen driver
> > v3: - removal some useless CLK_IS_CRITICAL and add some comments
> >     - only keep clk drivers/binding patches within the serie
> > 
> > -- 
> > 2.17.1
> > 
> 
