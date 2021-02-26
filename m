Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37EB23262B8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 13:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhBZM3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 07:29:18 -0500
Received: from lucky1.263xmail.com ([211.157.147.132]:45742 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBZM3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 07:29:16 -0500
Received: from localhost (unknown [192.168.167.69])
        by lucky1.263xmail.com (Postfix) with ESMTP id A2E1DF25FE;
        Fri, 26 Feb 2021 20:26:43 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [124.126.19.250])
        by smtp.263.net (postfix) whith ESMTP id P17142T139833041213184S1614342403054911_;
        Fri, 26 Feb 2021 20:26:43 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <e61391619582dd86786afe0f7644a08e>
X-RL-SENDER: zhaoxiao@uniontech.com
X-SENDER: zhaoxiao@uniontech.com
X-LOGIN-NAME: zhaoxiao@uniontech.com
X-FST-TO: tglx@linutronix.de
X-SENDER-IP: 124.126.19.250
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org
Cc:     seanjc@google.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH] KVM: x86: fix the space error for the pointer variables.
Date:   Fri, 26 Feb 2021 20:26:42 +0800
Message-Id: <20210226122642.22174-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following pointer variables don't meet the kernel coding style,
so fix the space error.

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 arch/x86/kvm/x86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3712bb5245eb..98849f3112d4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5368,7 +5368,7 @@ static int kvm_add_msr_filter(struct kvm *kvm, struct kvm_msr_filter_range *user
 	if (!bitmap_size || bitmap_size > KVM_MSR_FILTER_MAX_BITMAP_SIZE)
 		return -EINVAL;
 
-	bitmap = memdup_user((__user u8*)user_range->bitmap, bitmap_size);
+	bitmap = memdup_user((__user u8 *)user_range->bitmap, bitmap_size);
 	if (IS_ERR(bitmap))
 		return PTR_ERR(bitmap);
 
@@ -10554,7 +10554,7 @@ void kvm_arch_sync_events(struct kvm *kvm)
  * address, i.e. its accessibility is not guaranteed, and must be
  * accessed via __copy_{to,from}_user().
  */
-void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
+void __user *__x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 				      u32 size)
 {
 	int i, r;
-- 
2.20.1



