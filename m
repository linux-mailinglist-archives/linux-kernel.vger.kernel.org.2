Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F30F3434AD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 21:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhCUUmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 16:42:20 -0400
Received: from st43p00im-ztdg10063201.me.com ([17.58.63.182]:47507 "EHLO
        st43p00im-ztdg10063201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230299AbhCUUlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 16:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1616359303; bh=D4dih7IDfleZeM1jkz2mIoV9uzt0mlpafIv8IABeh0E=;
        h=From:To:Subject:Date:Message-Id;
        b=S+5a0peA2bZONrUujr5+71Nx/qhlZcR5a3K7cJulBgR2wtiJkEKolnzcCct4ILuxc
         Z3oqaHvZB6IwvuzvmBPwuvAlnjkhQIrR6TeDUSp74zII538NDYBf/ihuGCFl2dHe5+
         hVvoN7C0Q72IksFBd2KnLY9/FPrNIimmWaf8XedsTcaBgL8j1To+uLVS4GvkjVfFhs
         zjiDFqtdsnktemi/Q16xobM65/ODi60zYgxuxKx5WU2eomtd6/DVsrylSfAUjoE9g3
         gviTF+kml1vc1yJHy2vUufMWF63lkN0Ghz1ao7ftzMPGdH5BQXciqRf8pk9tzDGx54
         4vKx8AEpg6jEQ==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztdg10063201.me.com (Postfix) with ESMTPSA id 0602E5403D2;
        Sun, 21 Mar 2021 20:41:42 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
Subject: [PATCH 07/16] dt-bindings: clock: st: clkgen-fsyn: add new introduced compatible
Date:   Sun, 21 Mar 2021 21:40:29 +0100
Message-Id: <20210321204038.14417-8-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210321204038.14417-1-avolmat@me.com>
References: <20210321204038.14417-1-avolmat@me.com>
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.369,18.0.761,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-03-21=5F05:2021-03-19=5F02,2021-03-21=5F05,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103210166
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New compatible are added, supporting various kind of clkgen-fsyn
used for STiH407, STiH410 and STiH418

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 Documentation/devicetree/bindings/clock/st/st,quadfs.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/st/st,quadfs.txt b/Documentation/devicetree/bindings/clock/st/st,quadfs.txt
index d93d49342e60..c4ba2adb0b4f 100644
--- a/Documentation/devicetree/bindings/clock/st/st,quadfs.txt
+++ b/Documentation/devicetree/bindings/clock/st/st,quadfs.txt
@@ -12,6 +12,9 @@ This binding uses the common clock binding[1].
 Required properties:
 - compatible : shall be:
   "st,quadfs"
+  "st,quadfs-d0"
+  "st,quadfs-d2"
+  "st,quadfs-d3"
   "st,quadfs-pll"
 
 
-- 
2.17.1

