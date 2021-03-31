Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6938350816
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 22:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbhCaURn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 16:17:43 -0400
Received: from st43p00im-zteg10071901.me.com ([17.58.63.169]:41697 "EHLO
        st43p00im-zteg10071901.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236464AbhCaURP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1617221833; bh=xxba6mHR2dCb2XUZvdfSUyuVZbTapNyVZRz8gGMq7p8=;
        h=From:To:Subject:Date:Message-Id;
        b=Jj7TeMQkIj7kjkh20MtlvUxDWvoJvZA5l4XofxOgAqJNECB7ToUgo+1BwY/9h36Pb
         kieueaj87jLkL04X/wIkFJbDzBQyAM4xq21D5ucpvss1x8zCm9rYF8nNxfl/Dzr8Zb
         cY+eoXmzynZgyUKGZmEBMdKViu86kUmHQk+IR71jVqS8Q/i83B7yGd30rByNACSenY
         ilgeEZOzzi7lbwzI/lBQcl9GyOaa0Ft6Kq8K7EMyPwjaSUGvVooaA0cuFSTY1E2K6Q
         tE+b+kiL8vSEML9EVYMc23ulHiUAmtzYf/KJYcrFaWsGIx2irGoTGPftqnbo8HeQMU
         rVvGvY0qKMfXA==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-zteg10071901.me.com (Postfix) with ESMTPSA id 76D3DD80EF1;
        Wed, 31 Mar 2021 20:17:12 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
Subject: [PATCH v4 5/7] dt-bindings: clock: st: clkgen-pll: add new introduced compatible
Date:   Wed, 31 Mar 2021 22:16:30 +0200
Message-Id: <20210331201632.24530-6-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210331201632.24530-1-avolmat@me.com>
References: <20210331201632.24530-1-avolmat@me.com>
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.369,18.0.761,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-03-31=5F10:2021-03-31=5F02,2021-03-31=5F10,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103310140
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New compatible are added, supporting various kind of clkgen-pll
used for STiH407, STiH410 and STiH418

Signed-off-by: Alain Volmat <avolmat@me.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt b/Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt
index f207053e0550..d0fa1e02d06d 100644
--- a/Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt
+++ b/Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt
@@ -10,7 +10,10 @@ Required properties:
 
 - compatible : shall be:
 	"st,clkgen-pll0"
+	"st,clkgen-pll0-a0"
+	"st,clkgen-pll0-c0"
 	"st,clkgen-pll1"
+	"st,clkgen-pll1-c0"
 	"st,stih407-clkgen-plla9"
 	"st,stih418-clkgen-plla9"
 
-- 
2.17.1

