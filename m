Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34CB372963
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 13:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhEDLCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 07:02:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18000 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhEDLCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 07:02:07 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FZGyp5TtYzPxFH;
        Tue,  4 May 2021 18:57:54 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.189) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Tue, 4 May 2021 19:00:59 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <peterz@infradead.org>, <valentin.schneider@arm.com>,
        <corbet@lwn.net>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH] Documentation: scheduler: sched_debug_verbose cmdline should be sched_verbose
Date:   Tue, 4 May 2021 22:53:43 +1200
Message-ID: <20210504105344.31344-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.200.189]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cmdline should include sched_verbose but not sched_debug_verbose
as sched_debug_verbose is only the variant name in code.

Fixes: 9406415f46 ("sched/debug: Rename the sched_debug parameter to sched_verbose")
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 Documentation/scheduler/sched-domains.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/scheduler/sched-domains.rst b/Documentation/scheduler/sched-domains.rst
index 14ea2f2..84dcdcd 100644
--- a/Documentation/scheduler/sched-domains.rst
+++ b/Documentation/scheduler/sched-domains.rst
@@ -74,7 +74,7 @@ for a given topology level by creating a sched_domain_topology_level array and
 calling set_sched_topology() with this array as the parameter.
 
 The sched-domains debugging infrastructure can be enabled by enabling
-CONFIG_SCHED_DEBUG and adding 'sched_debug_verbose' to your cmdline. If you
+CONFIG_SCHED_DEBUG and adding 'sched_verbose' to your cmdline. If you
 forgot to tweak your cmdline, you can also flip the
 /sys/kernel/debug/sched/verbose knob. This enables an error checking parse of
 the sched domains which should catch most possible errors (described above). It
-- 
1.8.3.1

