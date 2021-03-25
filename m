Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908C6348A8D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbhCYHve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:51:34 -0400
Received: from st43p00im-zteg10063401.me.com ([17.58.63.175]:43400 "EHLO
        st43p00im-zteg10063401.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229576AbhCYHvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1616658675; bh=6f9Q0yFOd9GJCa/VvqoWPq3YcCZQ9pxcEKh9Th8QBbA=;
        h=From:To:Subject:Date:Message-Id;
        b=Xz0tVmMvym10uJ0rGAdIW0bw78z9UeICMGQQ9irY4S/6CQQtprbgWy0GgxNupgRVa
         /pev3c2UTxL4Kus+94E6csDTXXKFm3uA9GnlEmmsdDlAkZL7srw5PrdZQUyWi7os1r
         S9YbvCmKyv1XnN2qvTsOT2PWa1F+Yc+1o6RcGdxnLr+srsm0dxunUs6oCcCiT0nBvw
         skunUb6cywWdfA9G+rPobPKk3FQYH352SYKAFbB0T5gnN8MvKGRxaT37yFh23PGBdi
         j3ApfzkhpRLGAMHgGzmFX5SSlajEH3VsqHApqiABRSUk4oPD8Wx1ew1uzxu3jX6lQ4
         YmluvfYL08E4w==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-zteg10063401.me.com (Postfix) with ESMTPSA id C8AD04A061A;
        Thu, 25 Mar 2021 07:51:13 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
Subject: [PATCH v2 03/16] dt-bindings: clock: st: flexgen: add new introduced compatible
Date:   Thu, 25 Mar 2021 08:50:05 +0100
Message-Id: <20210325075018.6598-4-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210325075018.6598-1-avolmat@me.com>
References: <20210325075018.6598-1-avolmat@me.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-25_01:2021-03-24,2021-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2103250059
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

