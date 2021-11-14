Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E3E44F70D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 07:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbhKNGoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 01:44:18 -0500
Received: from smtpbg127.qq.com ([109.244.180.96]:17001 "EHLO smtpbg.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229469AbhKNGoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 01:44:16 -0500
X-QQ-mid: bizesmtp31t1636872029td6k2uq2
Received: from localhost.localdomain (unknown [125.69.41.88])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 14 Nov 2021 14:40:27 +0800 (CST)
X-QQ-SSF: 01000000002000C0F000C00A0000000
X-QQ-FEAT: XwMLFaztUQgg4HPywJhWjL3+jGKnrZMzxf7F0clzzs3LgAJk9jOR+hP3XdaCX
        lafjBJI5ykQrQz5McRCtxOw9jeCi2MBm0CyME6iZ6CfaH9Tqrx3X6h09EpeTzGHrTrKTjFK
        p/28iD0qmT71IB5vuCAK1Yoaw00rg9NIWkkT/NDLIqJXtQD6ohqfliEFKsFXJCrkvRwUHGD
        CvxwDHgHuwmvVmSW9O0/smk7KPYlvmKfGqxqEgNzqaVkBGyInr9WW24FRSr8rI7e9xh1wLY
        nEycAMD903Tj6f6M1uUtJeO58ur60ZAn6c6T+Fy1Thnh0jvibJlE4SLg7M0W598xSCXhQnP
        ImvmUtQu9ud/s5vBP2rvVcveiYL+WiABEl9LRIn
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     catalin.marinas@arm.com
Cc:     maz@kernel.org, will@kernel.org, james.morse@arm.com,
        alexandru.elisei@arm.com, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] KVM: arm64: remove unneeded comparison
Date:   Sun, 14 Nov 2021 14:40:26 +0800
Message-Id: <20211114064026.277024-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unsigned expression compared with zero `target < 0' is
unneeded and its result is always false. we can also check the
target's value returned from `kvm_target_cpu' is one of the
KVM_* macros, and these macros are defined greater than or equal
to 0.
Therefore, the comparison code block:
    if (target < 0)
        return -ENODEV;
is unneeded. We can safely remove it.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/arm64/kvm/guest.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 5ce26bedf23c..1605cb71dd52 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -873,9 +873,6 @@ int kvm_vcpu_preferred_target(struct kvm_vcpu_init *init)
 {
 	u32 target = kvm_target_cpu();
 
-	if (target < 0)
-		return -ENODEV;
-
 	memset(init, 0, sizeof(*init));
 
 	/*
-- 
2.33.0

