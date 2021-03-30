Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4246034F283
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 22:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbhC3Uwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 16:52:43 -0400
Received: from st43p00im-zteg10062001.me.com ([17.58.63.166]:48715 "EHLO
        st43p00im-zteg10062001.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232614AbhC3UwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 16:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1617137531; bh=qyZanw9bvq4XzKEGum+SixXhJ4fFKKUpQPcyblgNRAY=;
        h=From:To:Subject:Date:Message-Id;
        b=JoWAUjR9kEdARUFtq6LnTvieTtG7WcgSG+/z2MjHSwdj6eOetpoiO+zsYIqAAYdn8
         Duo/l+cs9lw+DucOb9mnbc9yAqt+yXPDwsPHlVkaR23D4tS8vx/jrY44ALpoOj5Ue2
         iASbFKoJrQrFvAz5dZa4TqsJu2lXBdlKQHpNLCjzcck+zXwBWrBpOvZkK/a3MsvHVf
         zNU0MUXmL6j2oq4ENUvR1JpNXdhMRCHoxyIrdLQDaQnLKm9w8DmdBYyfa+k9iKzkwN
         x2xjZ444xCrhgEyaVUv1l5eConpOhWnoq4lt1wagHY65mqArdmyKHaRC7NUcaEo6dq
         vB2SaBVRkfjXQ==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-zteg10062001.me.com (Postfix) with ESMTPSA id 1B2536C0434;
        Tue, 30 Mar 2021 20:52:09 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
Subject: [PATCH v3 3/7] dt-bindings: clock: st: flexgen: add new introduced compatible
Date:   Tue, 30 Mar 2021 22:51:21 +0200
Message-Id: <20210330205125.25708-4-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210330205125.25708-1-avolmat@me.com>
References: <20210330205125.25708-1-avolmat@me.com>
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.369,18.0.761,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-03-30=5F12:2021-03-30=5F02,2021-03-30=5F12,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103300152
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New compatible are added, supporting various kind of flexgen in
STiH407, STiH410 and STiH418

Signed-off-by: Alain Volmat <avolmat@me.com>
Acked-by: Rob Herring <robh@kernel.org>
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

