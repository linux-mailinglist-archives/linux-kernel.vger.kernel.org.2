Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C0635F25E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 13:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350532AbhDNL05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 07:26:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16913 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349021AbhDNLZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:25:52 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FL0Tj4nTczkjyc;
        Wed, 14 Apr 2021 19:23:37 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.47.82.32) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Wed, 14 Apr 2021 19:25:20 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <will@kernel.org>, <catalin.marinas@arm.com>,
        <james.morse@arm.com>, <julien.thierry.kdev@gmail.com>,
        <suzuki.poulose@arm.com>, <jean-philippe@linaro.org>,
        <julien@xen.org>, <linuxarm@huawei.com>
Subject: [PATCH v4 14/16] arm64/lib: Add an helper to free memory allocated by the ASID allocator
Date:   Wed, 14 Apr 2021 12:23:10 +0100
Message-ID: <20210414112312.13704-15-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210414112312.13704-1-shameerali.kolothum.thodi@huawei.com>
References: <20210414112312.13704-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.82.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Grall <julien.grall@arm.com>

Some users of the ASID allocator (e.g VMID) may need to free any
resources if the initialization fail. So introduce a function that
allows freeing of any memory allocated by the ASID allocator.

Signed-off-by: Julien Grall <julien.grall@arm.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 arch/arm64/include/asm/lib_asid.h | 2 ++
 arch/arm64/lib/asid.c             | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/include/asm/lib_asid.h b/arch/arm64/include/asm/lib_asid.h
index acae8d243d17..4dbc0a3f19a6 100644
--- a/arch/arm64/include/asm/lib_asid.h
+++ b/arch/arm64/include/asm/lib_asid.h
@@ -82,4 +82,6 @@ void asid_context_pinned_put(struct asid_info *info, atomic64_t *pasid,
 			     refcount_t *pinned);
 int asid_allocator_init(struct asid_info *info, u32 bits, bool pinned);
 
+void asid_allocator_free(struct asid_info *info);
+
 #endif
diff --git a/arch/arm64/lib/asid.c b/arch/arm64/lib/asid.c
index 286285616f65..7bd031f9516a 100644
--- a/arch/arm64/lib/asid.c
+++ b/arch/arm64/lib/asid.c
@@ -256,3 +256,9 @@ int asid_allocator_init(struct asid_info *info, u32 bits, bool pinned)
 
 	return 0;
 }
+
+void asid_allocator_free(struct asid_info *info)
+{
+	kfree(info->map);
+	kfree(info->pinned_map);
+}
-- 
2.17.1

