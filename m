Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B40A34F275
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 22:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhC3Uwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 16:52:36 -0400
Received: from st43p00im-ztbu10063701.me.com ([17.58.63.178]:53966 "EHLO
        st43p00im-ztbu10063701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232571AbhC3UwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 16:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1617137520; bh=ZKLWSMdxWfNs8QN6JF4XTqugfEbF2VXoXeQPmxKIWZc=;
        h=From:To:Subject:Date:Message-Id;
        b=YNkxX5LnpNCyuQuh0foeEdQrDo/+gSjUYQJzTrpg0bL6zlMxEvVf+1QhhATm5uxBU
         ikW733Q0arc6QPbx95lZfp96F39VIAcqKhTBXZZ+Z2ZTD5bmSlsCVwYS15ddE+jrcV
         VDCdrx528l3zo5vfFFCYhKZGVpM6ILRs4pcQTlP75rxt68cs5A39MnMHyvt/fn+hzc
         QvPzu692n6+7IAvyj1dpffa050wguycG7gPCTHwPjRhmYV0Y633qqg2cNnRHesPWAH
         jcg2O4h2JIrTUYc23R/pdy40nRRQKit6ynf9iZlIAVWdSiSOpahzAPu79yaFeL3lMr
         bQBJjRPwPsWzQ==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztbu10063701.me.com (Postfix) with ESMTPSA id 719E29A06A8;
        Tue, 30 Mar 2021 20:51:59 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
Subject: [PATCH v3 0/7] clk: st: embed clock outputs within drivers
Date:   Tue, 30 Mar 2021 22:51:18 +0200
Message-Id: <20210330205125.25708-1-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.369,18.0.761,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-03-30=5F09:2021-03-30=5F01,2021-03-30=5F09,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=903 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103300153
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

Alain Volmat (7):
  clk: st: clkgen-pll: remove used variable of struct clkgen_pll
  clk: st: flexgen: embed soc clock outputs within compatible data
  dt-bindings: clock: st: flexgen: add new introduced compatible
  clk: st: clkgen-pll: embed soc clock outputs within compatible data
  dt-bindings: clock: st: clkgen-pll: add new introduced compatible
  clk: st: clkgen-fsyn: embed soc clock outputs within compatible data
  dt-bindings: clock: st: clkgen-fsyn: add new introduced compatible

 .../bindings/clock/st/st,clkgen-pll.txt       |   3 +
 .../bindings/clock/st/st,flexgen.txt          |  10 +
 .../bindings/clock/st/st,quadfs.txt           |   3 +
 drivers/clk/st/clk-flexgen.c                  | 366 +++++++++++++++++-
 drivers/clk/st/clkgen-fsyn.c                  | 113 +++++-
 drivers/clk/st/clkgen-pll.c                   | 121 +++++-
 6 files changed, 575 insertions(+), 41 deletions(-)

---
v3: - removal some useless CLK_IS_CRITICAL and add some comments
    - only keep clk drivers/binding patches within the serie
v2: fix drivers to update some clocks as CLK_IS_CRITICAL

-- 
2.17.1

