Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3473919CF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbhEZOUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:20:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:4017 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbhEZOUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:20:16 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FqtKd6ry2zmZ6j;
        Wed, 26 May 2021 22:16:21 +0800 (CST)
Received: from dggema764-chm.china.huawei.com (10.1.198.206) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 26 May 2021 22:18:42 +0800
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.179) by
 dggema764-chm.china.huawei.com (10.1.198.206) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 26 May 2021 22:18:42 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <james.morse@arm.com>,
        <alexandru.elisei@arm.com>, <suzuki.poulose@arm.com>,
        <wanghaibin.wang@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] KVM: arm64: Resolve all pending PC updates before immediate exit
Date:   Wed, 26 May 2021 22:18:31 +0800
Message-ID: <20210526141831.1662-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema764-chm.china.huawei.com (10.1.198.206)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 26778aaa134a ("KVM: arm64: Commit pending PC adjustemnts before
returning to userspace") fixed the PC updating issue by forcing an explicit
synchronisation of the exception state on vcpu exit to userspace.

However, we forgot to take into account the case where immediate_exit is
set by userspace and KVM_RUN will exit immediately. Fix it by resolving all
pending PC updates before returning to userspace.

Since __kvm_adjust_pc() relies on a loaded vcpu context, I moved the
immediate_exit checking right after vcpu_load(). We will get some overhead
if immediate_exit is true (which should hopefully be rare).

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---

This patch can be applied on top of kvmarm/fixes and help me to PASS all
kvm-unit-tests cases in the migration group.

 arch/arm64/kvm/arm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 1126eae27400..e720148232a0 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -720,11 +720,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 			return ret;
 	}
 
-	if (run->immediate_exit)
-		return -EINTR;
-
 	vcpu_load(vcpu);
 
+	if (run->immediate_exit) {
+		ret = -EINTR;
+		goto out;
+	}
+
 	kvm_sigset_activate(vcpu);
 
 	ret = 1;
@@ -897,6 +899,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
 	kvm_sigset_deactivate(vcpu);
 
+out:
 	/*
 	 * In the unlikely event that we are returning to userspace
 	 * with pending exceptions or PC adjustment, commit these
-- 
2.19.1

