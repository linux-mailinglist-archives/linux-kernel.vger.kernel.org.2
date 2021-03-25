Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936A9348A83
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhCYHvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:51:03 -0400
Received: from st43p00im-ztdg10061801.me.com ([17.58.63.170]:55939 "EHLO
        st43p00im-ztdg10061801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229622AbhCYHus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1616658645; bh=4W2/WmU9+mKLVBD82gYcRjsNMnXk4ZFJUWlVJxBIPW0=;
        h=From:To:Subject:Date:Message-Id;
        b=XSJIO/Ib+7po656hE2TOmmImhunGUAfwFjAkq+bTCoYidft9yMaG9hB89+tQuLUOO
         IFrTfWozLleuinQO7zCXqnDDkoDqVZ0B3N/2I6yyMn19n9ewFudMXo7vOhedMeJP2J
         l1Z1f+dXQ0DEDMivzRBDe5Lf3Ue/SJ81nzhQyd0u0NatNugZxyyaVmy4IGaA6PMS9I
         NwlYJnBqCzuhjSvFzhTIK0jIOHo3a29mv8fqgNP/xftT4VmOvK0v0P5oEsxr6P2JPU
         kr4srE/ZtUfRqZrHdMHY7eOOpOLJg1lnZxzkwoZ/tBilzvqfzmKLUIl9L43cr0lS82
         1bxjoOHC4xYxg==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztdg10061801.me.com (Postfix) with ESMTPSA id 18EA28C03F9;
        Thu, 25 Mar 2021 07:50:40 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
Subject: [PATCH v2 00/16] clk: st: embed clock outputs within drivers
Date:   Thu, 25 Mar 2021 08:50:02 +0100
Message-Id: <20210325075018.6598-1-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.369,18.0.761,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-03-25=5F01:2021-03-24=5F02,2021-03-25=5F01,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=981 bulkscore=0
 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103250059
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of ST clock drivers used by STi platform are updated in
order to introduce clock outputs informations within each drivers
and thus allow to avoid having to rely on clock-output-names properties
within DT clock nodes.
For that purpose, drivers are updated to allow handling both modes
(with or without clock-output-names).
Once all DT will have been updated, the legacy mode could be removed
from the drivers.
This will also allow, once all STi DT will be corrected, to remove the
of_clk_detect_critical API from clk core code since STi clock drivers
are the only drivers using this API.

This serie also contains modifications within STi DTS in order to use
the newly introduced compatible and remove clock-output-names
properties.

Alain Volmat (16):
  clk: st: clkgen-pll: remove used variable of struct clkgen_pll
  clk: st: flexgen: embed soc clock outputs within compatible data
  dt-bindings: clock: st: flexgen: add new introduced compatible
  clk: st: clkgen-pll: embed soc clock outputs within compatible data
  dt-bindings: clock: st: clkgen-pll: add new introduced compatible
  clk: st: clkgen-fsyn: embed soc clock outputs within compatible data
  dt-bindings: clock: st: clkgen-fsyn: add new introduced compatible
  ARM: dts: sti: update flexgen compatible within stih418-clock
  ARM: dts: sti: update flexgen compatible within stih407-clock
  ARM: dts: sti: update flexgen compatible within stih410-clock
  ARM: dts: sti: update clkgen-pll entries in stih407-clock
  ARM: dts: sti: update clkgen-pll entries in stih410-clock
  ARM: dts: sti: update clkgen-pll entries in stih418-clock
  ARM: dts: sti: update clkgen-fsyn entries in stih407-clock
  ARM: dts: sti: update clkgen-fsyn entries in stih410-clock
  ARM: dts: sti: update clkgen-fsyn entries in stih418-clock

 .../bindings/clock/st/st,clkgen-pll.txt       |   3 +
 .../bindings/clock/st/st,flexgen.txt          |  10 +
 .../bindings/clock/st/st,quadfs.txt           |   3 +
 arch/arm/boot/dts/stih407-clock.dtsi          | 128 +------
 arch/arm/boot/dts/stih410-clock.dtsi          | 138 +------
 arch/arm/boot/dts/stih418-clock.dtsi          | 136 +------
 drivers/clk/st/clk-flexgen.c                  | 344 +++++++++++++++++-
 drivers/clk/st/clkgen-fsyn.c                  | 113 +++++-
 drivers/clk/st/clkgen-pll.c                   | 121 +++++-
 9 files changed, 588 insertions(+), 408 deletions(-)

---
v2: fix drivers to update some clocks as CLK_IS_CRITICAL

-- 
2.17.1

