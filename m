Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91DF43C021
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 04:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238438AbhJ0CpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 22:45:07 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:47289 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbhJ0CpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 22:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635302562; x=1666838562;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L/uG5CU2gMtP7B26JcOoa7vhnzcIoGWSJZKXSNZS4YA=;
  b=q3j0WOL9bCEfnvF0TTJE7+yl5F4V5LpAIUFQmiyF7rKOtX8+c+RPQyl9
   pBGjoFYcwjXEc1AWxK/kdXhaKa7zXnmtrDGSh8eAGOJ4I+aLIQ9FcC691
   PzdT8Jghgmn4tWc6T8mf7ANDNCiX2+WrgLuOA8b+BfeI091A4g0ea4gWX
   o=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 26 Oct 2021 19:42:41 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 19:42:41 -0700
Received: from qian-HP-Z2-SFF-G5-Workstation.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Tue, 26 Oct 2021 19:42:39 -0700
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        Qian Cai <quic_qiancai@quicinc.com>
Subject: [PATCH] KVM: arm64: Avoid shadowing a previous local
Date:   Tue, 26 Oct 2021 22:42:12 -0400
Message-ID: <20211027024212.64842-1-quic_qiancai@quicinc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is less-prone to have a different variable name from the one in a wider
scope. This is also flagged by GCC (W=2):

In file included from ./include/linux/kvm_host.h:39,
                 from arch/arm64/kvm/arm.c:12:
arch/arm64/kvm/arm.c: In function 'kvm_arch_vcpu_ioctl_run':
./arch/arm64/include/asm/kvm_host.h:638:26: warning: declaration of 'ret' shadows a previous local [-Wshadow]
  638 |   typeof(f(__VA_ARGS__)) ret;    \
      |                          ^~~
arch/arm64/kvm/arm.c:852:9: note: in expansion of macro 'kvm_call_hyp_ret'
  852 |   ret = kvm_call_hyp_ret(__kvm_vcpu_run, vcpu);
      |         ^~~~~~~~~~~~~~~~
arch/arm64/kvm/arm.c:773:6: note: shadowed declaration is here
  773 |  int ret;
      |      ^~~

Signed-off-by: Qian Cai <quic_qiancai@quicinc.com>
---
 arch/arm64/include/asm/kvm_host.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 4be8486042a7..4693d84ccd95 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -635,16 +635,16 @@ void kvm_arm_resume_guest(struct kvm *kvm);
 
 #define kvm_call_hyp_ret(f, ...)					\
 	({								\
-		typeof(f(__VA_ARGS__)) ret;				\
+		typeof(f(__VA_ARGS__)) __ret;				\
 									\
 		if (has_vhe()) {					\
-			ret = f(__VA_ARGS__);				\
+			__ret = f(__VA_ARGS__);				\
 			isb();						\
 		} else {						\
-			ret = kvm_call_hyp_nvhe(f, ##__VA_ARGS__);	\
+			__ret = kvm_call_hyp_nvhe(f, ##__VA_ARGS__);	\
 		}							\
 									\
-		ret;							\
+		__ret;							\
 	})
 #else /* __KVM_NVHE_HYPERVISOR__ */
 #define kvm_call_hyp(f, ...) f(__VA_ARGS__)
-- 
2.30.2

