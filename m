Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8CC334F287
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 22:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbhC3Uwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 16:52:49 -0400
Received: from st43p00im-ztbu10063701.me.com ([17.58.63.178]:56490 "EHLO
        st43p00im-ztbu10063701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232658AbhC3Uwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 16:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1617137549; bh=D4dih7IDfleZeM1jkz2mIoV9uzt0mlpafIv8IABeh0E=;
        h=From:To:Subject:Date:Message-Id;
        b=ovzsUzFw534t7A4Noz29IwkdjyUQTn2qpX36nXkA3UlTZBAqYfcBQXpUb16qj802A
         BuY62HOe0s5UkhIgfaeB+jGzN6l8dsi91CnaNF6zdJ6BLTkDASA0TGu3fj1C7CkJ8I
         O8BaQNBsSrv4fwZ+J3nRIUtYtd4FxQn2HuAdeN9pFfIU1rqlSa7CcbFX5wZaOypsLr
         psnRoWdyZ+32jYbPHjMHH1fsODvebL9YF06jKN39Im1EbvC4PCh6C2b32ckh0KrRPS
         fmrzFJuE1BzulHbHmnKiPP4AmRYC0xykG+QBZRE/S3szohx3/0nupMbNdJRjOmGnOe
         iNaPCHK7mp0LA==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztbu10063701.me.com (Postfix) with ESMTPSA id 2C2D99A0182;
        Tue, 30 Mar 2021 20:52:27 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
Subject: [PATCH v3 7/7] dt-bindings: clock: st: clkgen-fsyn: add new introduced compatible
Date:   Tue, 30 Mar 2021 22:51:25 +0200
Message-Id: <20210330205125.25708-8-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210330205125.25708-1-avolmat@me.com>
References: <20210330205125.25708-1-avolmat@me.com>
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.369,18.0.761,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-03-30=5F12:2021-03-30=5F01,2021-03-30=5F12,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103300152
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

