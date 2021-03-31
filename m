Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10D434FD6A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbhCaJrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:47:55 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14977 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbhCaJr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:47:28 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F9Lyn47SwzyNCy;
        Wed, 31 Mar 2021 17:45:21 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Wed, 31 Mar 2021 17:47:15 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <julien.grall@arm.com>, <Dave.Martin@arm.com>,
        <broonie@kernel.org>, <maz@kernel.org>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: [PATCH RFC for-next 1/1] arm64: sve: Fix some compile errors about sve_cond_update_zcr_vq
Date:   Wed, 31 Mar 2021 17:44:39 +0800
Message-ID: <1617183879-48748-1-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some compile errors of ARM64 KVM when ARM64_SVE is not
selected, in the locations of sve_cond_update_zcr_vq used.
One error log is as following:

  CC      arch/arm64/kvm/sys_regs.o
In file included from arch/arm64/kvm/hyp/vhe/switch.c:8:0:
./arch/arm64/kvm/hyp/include/hyp/switch.h: In function ‘__hyp_sve_restore_guest’:
./arch/arm64/kvm/hyp/include/hyp/switch.h:220:2: error: implicit declaration of
function ‘sve_cond_update_zcr_vq’; did you mean
‘kvm_pmu_update_run’? [-Werror=implicit-function-declaration]
  sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1, SYS_ZCR_EL2);
  ^~~~~~~~~~~~~~~~~~~~~~
  kvm_pmu_update_run

The root cause is that sve_cond_update_zcr_vq is not defined when
ARM64_SVE is not selected. Fix it by adding an empty definition
when CONFIG_ARM64_SVE=n.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 arch/arm64/include/asm/fpsimd.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 05c9c55..3f93b63 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -168,6 +168,8 @@ static inline int sve_get_current_vl(void)
 static inline void sve_user_disable(void) { BUILD_BUG(); }
 static inline void sve_user_enable(void) { BUILD_BUG(); }
 
+#define sve_cond_update_zcr_vq(val, reg)
+
 static inline void sve_init_vq_map(void) { }
 static inline void sve_update_vq_map(void) { }
 static inline int sve_verify_vq_map(void) { return 0; }
-- 
2.8.1

