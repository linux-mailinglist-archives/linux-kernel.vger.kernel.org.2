Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B805355383
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 14:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343910AbhDFMVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 08:21:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15918 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239518AbhDFMVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 08:21:05 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FF65S1DsFzkhLv;
        Tue,  6 Apr 2021 20:19:08 +0800 (CST)
Received: from huawei.com (10.175.112.208) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Tue, 6 Apr 2021
 20:20:43 +0800
From:   Wang Wensheng <wangwensheng4@huawei.com>
To:     <maz@kernel.org>, <james.morse@arm.com>,
        <alexandru.elisei@arm.com>, <suzuki.poulose@arm.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <dbrazdil@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <rui.xiang@huawei.com>
Subject: [PATCH -next] KVM: arm64: Fix error return code in init_hyp_mode()
Date:   Tue, 6 Apr 2021 12:17:59 +0000
Message-ID: <20210406121759.5407-1-wangwensheng4@huawei.com>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: eeeee7193df0 ("KVM: arm64: Bootstrap PSCI SMC handler in nVHE EL2")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
---
 arch/arm64/kvm/arm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 76a7de1..41e0b2a 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1877,8 +1877,10 @@ static int init_hyp_mode(void)
 	if (is_protected_kvm_enabled()) {
 		init_cpu_logical_map();
 
-		if (!init_psci_relay())
+		if (!init_psci_relay()) {
+			err = -ENODEV;
 			goto out_err;
+		}
 	}
 
 	if (is_protected_kvm_enabled()) {
-- 
2.9.4

