Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B936F350803
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 22:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbhCaURD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 16:17:03 -0400
Received: from st43p00im-ztdg10061801.me.com ([17.58.63.170]:34228 "EHLO
        st43p00im-ztdg10061801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236479AbhCaUQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1617221803; bh=+MVvLf7aCANyLDwQXl9EuUsXWmRo0TFhWjNfyW1qnEE=;
        h=From:To:Subject:Date:Message-Id;
        b=aBdOcToPoP8TxIHtizOAYVmPjWI0CClODiKDnyNUsxxqozyw30zf1SE3Y7FDVMEhs
         Qb3wx7WBrSYBqDyeBbHqWNodUJ4dtYIjbODxT/YXtGywllkVpodi1+6WfQxYXbKU88
         zuQ21yxudus1nih8L0ckzEI9GYGt2E+nYY3GmcmhCf6SvTNpfaG6GRVCJ3480zjktN
         EuncrHSBfewN+cxowAnhUEVDUPYZbpzWgAVO25wqftC8NtessGpShXQ/kFax9MsNXf
         uP3LoXAAY85nX3b9MrPVsimQmodU4OvYzzCDGMo3am3MpIKn716jxF6NKXokr4qLnU
         4Qn2jeOLlSVTQ==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztdg10061801.me.com (Postfix) with ESMTPSA id 8233E8C0876;
        Wed, 31 Mar 2021 20:16:42 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
Subject: [PATCH v4 0/7] clk: st: embed clock outputs within drivers
Date:   Wed, 31 Mar 2021 22:16:25 +0200
Message-Id: <20210331201632.24530-1-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.369,18.0.761,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-03-31=5F10:2021-03-30=5F02,2021-03-31=5F10,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=816 bulkscore=0 mlxscore=0
 clxscore=1015 adultscore=0 spamscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103310140
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

Alain Volmat (7):
  clk: st: clkgen-pll: remove unused variable of struct clkgen_pll
  clk: st: flexgen: embed soc clock outputs within compatible data
  dt-bindings: clock: st: flexgen: add new introduced compatible
  clk: st: clkgen-pll: embed soc clock outputs within compatible data
  dt-bindings: clock: st: clkgen-pll: add new introduced compatible
  clk: st: clkgen-fsyn: embed soc clock outputs within compatible data
  dt-bindings: clock: st: clkgen-fsyn: add new introduced compatible

 .../bindings/clock/st/st,clkgen-pll.txt       |   3 +
 .../bindings/clock/st/st,flexgen.txt          |  10 +
 .../bindings/clock/st/st,quadfs.txt           |   3 +
 drivers/clk/st/clk-flexgen.c                  | 367 +++++++++++++++++-
 drivers/clk/st/clkgen-fsyn.c                  | 113 +++++-
 drivers/clk/st/clkgen-pll.c                   | 121 +++++-
 6 files changed, 576 insertions(+), 41 deletions(-)

---
v4: - add an additional CLK_IS_CRITICAL within flexgen driver
v3: - removal some useless CLK_IS_CRITICAL and add some comments
    - only keep clk drivers/binding patches within the serie

-- 
2.17.1

