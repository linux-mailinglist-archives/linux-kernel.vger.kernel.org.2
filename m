Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD6B38C439
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 11:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbhEUKAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 06:00:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3647 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhEUJ6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 05:58:47 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FmhmT6WrlzmWxX;
        Fri, 21 May 2021 17:55:05 +0800 (CST)
Received: from dggpemm500023.china.huawei.com (7.185.36.83) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 17:57:23 +0800
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 17:57:22 +0800
From:   Yanan Wang <wangyanan55@huawei.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <wanghaibin.wang@huawei.com>,
        Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH] Documentation: dt-bindings: Fix incorrect statement
Date:   Fri, 21 May 2021 17:57:20 +0800
Message-ID: <20210521095720.5592-1-wangyanan55@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.128]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500023.china.huawei.com (7.185.36.83)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's found when reading the Doc.

In a SMP system, the hierarchy of CPUs now can be defined through
four not three entities (socket/cluster/core/thread), so correct
the statement to avoid possible confusion.

Since we are already there, also drop an extra space and tweak
the title alignment. No real context change at all.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
---
 Documentation/devicetree/bindings/cpu/cpu-topology.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpu/cpu-topology.txt b/Documentation/devicetree/bindings/cpu/cpu-topology.txt
index 9bd530a35d14..8b23a98c283c 100644
--- a/Documentation/devicetree/bindings/cpu/cpu-topology.txt
+++ b/Documentation/devicetree/bindings/cpu/cpu-topology.txt
@@ -6,7 +6,7 @@ CPU topology binding description
 1 - Introduction
 ===========================================
 
-In a SMP system, the hierarchy of CPUs is defined through three entities that
+In a SMP system, the hierarchy of CPUs is defined through four entities that
 are used to describe the layout of physical CPUs in the system:
 
 - socket
@@ -75,7 +75,7 @@ whose bindings are described in paragraph 3.
 
 The nodes describing the CPU topology (socket/cluster/core/thread) can
 only be defined within the cpu-map node and every core/thread in the
-system must be defined within the topology.  Any other configuration is
+system must be defined within the topology. Any other configuration is
 invalid and therefore must be ignored.
 
 ===========================================
@@ -91,9 +91,9 @@ cpu-map child nodes which do not share a common parent node can have the same
 name (ie same number N as other cpu-map child nodes at different device tree
 levels) since name uniqueness will be guaranteed by the device tree hierarchy.
 
-===========================================
+============================================
 3 - socket/cluster/core/thread node bindings
-===========================================
+============================================
 
 Bindings for socket/cluster/cpu/thread nodes are defined as follows:
 
-- 
2.19.1

