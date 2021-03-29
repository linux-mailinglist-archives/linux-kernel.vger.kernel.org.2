Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2919034D027
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 14:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhC2Me6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 08:34:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14184 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbhC2Mej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 08:34:39 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F8Bm03b8tzmYhw;
        Mon, 29 Mar 2021 20:32:00 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Mon, 29 Mar 2021 20:34:29 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <john.garry@huawei.com>, <zhangshaokun@hisilicon.com>,
        <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] docs: perf: Address some html build warnings
Date:   Mon, 29 Mar 2021 20:32:01 +0800
Message-ID: <1617021121-31450-1-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following html build warnings:
Documentation/admin-guide/perf/hisi-pmu.rst:61: WARNING: Unexpected indentation.
Documentation/admin-guide/perf/hisi-pmu.rst:62: WARNING: Block quote ends without a blank line; unexpected unindent.
Documentation/admin-guide/perf/hisi-pmu.rst:69: WARNING: Unexpected indentation.
Documentation/admin-guide/perf/hisi-pmu.rst:70: WARNING: Block quote ends without a blank line; unexpected unindent.
Documentation/admin-guide/perf/hisi-pmu.rst:83: WARNING: Unexpected indentation.

Fixes: 9b86b1b41e0f ("docs: perf: Add new description on HiSilicon uncore PMU v2")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 Documentation/admin-guide/perf/hisi-pmu.rst | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/perf/hisi-pmu.rst b/Documentation/admin-guide/perf/hisi-pmu.rst
index 3b3120e..5469793 100644
--- a/Documentation/admin-guide/perf/hisi-pmu.rst
+++ b/Documentation/admin-guide/perf/hisi-pmu.rst
@@ -57,16 +57,20 @@ For HiSilicon uncore PMU v2 whose identifier is 0x30, the topology is the same
 as PMU v1, but some new functions are added to the hardware.
 
 (a) L3C PMU supports filtering by core/thread within the cluster which can be
-specified as a bitmap.
+specified as a bitmap::
+
   $# perf stat -a -e hisi_sccl3_l3c0/config=0x02,tt_core=0x3/ sleep 5
+
 This will only count the operations from core/thread 0 and 1 in this cluster.
 
 (b) Tracetag allow the user to chose to count only read, write or atomic
 operations via the tt_req parameeter in perf. The default value counts all
 operations. tt_req is 3bits, 3'b100 represents read operations, 3'b101
 represents write operations, 3'b110 represents atomic store operations and
-3'b111 represents atomic non-store operations, other values are reserved.
+3'b111 represents atomic non-store operations, other values are reserved::
+
   $# perf stat -a -e hisi_sccl3_l3c0/config=0x02,tt_req=0x4/ sleep 5
+
 This will only count the read operations in this cluster.
 
 (c) Datasrc allows the user to check where the data comes from. It is 5 bits.
@@ -79,7 +83,8 @@ Some important codes are as follows:
 5'b10000: comes from cross-socket DDR;
 etc, it is mainly helpful to find that the data source is nearest from the CPU
 cores. If datasrc_cfg is used in the multi-chips, the datasrc_skt shall be
-configured in perf command.
+configured in perf command::
+
   $# perf stat -a -e hisi_sccl3_l3c0/config=0xb9,datasrc_cfg=0xE/,
   hisi_sccl3_l3c0/config=0xb9,datasrc_cfg=0xF/ sleep 5
 
-- 
2.8.1

