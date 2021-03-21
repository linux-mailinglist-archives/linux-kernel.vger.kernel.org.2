Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5363434A9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 21:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhCUUmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 16:42:10 -0400
Received: from st43p00im-ztdg10061801.me.com ([17.58.63.170]:44845 "EHLO
        st43p00im-ztdg10061801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230241AbhCUUlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 16:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1616359291; bh=6f9Q0yFOd9GJCa/VvqoWPq3YcCZQ9pxcEKh9Th8QBbA=;
        h=From:To:Subject:Date:Message-Id;
        b=tbBS3fk3mrXFP1hceBSLkowVW4SljwBqFXaXOqKQk+yc8LB4LVZXKXaq7K0j4dbQx
         etAawr+uDPZC8+/vVINX9Icvb9EZLzkrrYCqW+l4GW0oQuGoZ3Q1ybYVbwGtSLp8JF
         slc+NmWKex+T7ijh6QM02kWCexyWJfzzzTclhE+EF6si+NBsTKXuRbb4Py3DNawZLO
         rMWL0AekJFfZ5w5ng6M3ztl9rT4GK12/K53sJdd+386k8JMKrjHFvv6fCQjPyXBvuE
         Lx8MWKZr+u1w7S50c1YSXNzVUddylSap4zAmd50cl/tn8jFbIndiRxBtBdAaNJS24m
         73ztm5SqDN8XA==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztdg10061801.me.com (Postfix) with ESMTPSA id D35598C02FD;
        Sun, 21 Mar 2021 20:41:29 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
Subject: [PATCH 03/16] dt-bindings: clock: st: flexgen: add new introduced compatible
Date:   Sun, 21 Mar 2021 21:40:25 +0100
Message-Id: <20210321204038.14417-4-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210321204038.14417-1-avolmat@me.com>
References: <20210321204038.14417-1-avolmat@me.com>
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.369,18.0.761,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-03-21=5F02:2021-03-19=5F02,2021-03-21=5F02,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=977 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103210166
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New compatible are added, supporting various kind of flexgen in
STiH407, STiH410 and STiH418

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 .../devicetree/bindings/clock/st/st,flexgen.txt        | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/st/st,flexgen.txt b/Documentation/devicetree/bindings/clock/st/st,flexgen.txt
index 7ff77fc57dff..55a18939bddd 100644
--- a/Documentation/devicetree/bindings/clock/st/st,flexgen.txt
+++ b/Documentation/devicetree/bindings/clock/st/st,flexgen.txt
@@ -64,6 +64,16 @@ Required properties:
   audio use case)
   "st,flexgen-video", "st,flexgen" (enable clock propagation on parent
 					and activate synchronous mode)
+  "st,flexgen-stih407-a0"
+  "st,flexgen-stih410-a0"
+  "st,flexgen-stih407-c0"
+  "st,flexgen-stih410-c0"
+  "st,flexgen-stih418-c0"
+  "st,flexgen-stih407-d0"
+  "st,flexgen-stih410-d0"
+  "st,flexgen-stih407-d2"
+  "st,flexgen-stih418-d2"
+  "st,flexgen-stih407-d3"
 
 - #clock-cells : from common clock binding; shall be set to 1 (multiple clock
   outputs).
-- 
2.17.1

