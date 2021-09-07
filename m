Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA1F40230A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 07:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbhIGFXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 01:23:16 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9007 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhIGFXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 01:23:14 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H3YXD2vq7zVgTM;
        Tue,  7 Sep 2021 13:21:16 +0800 (CST)
Received: from dggema764-chm.china.huawei.com (10.1.198.206) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Tue, 7 Sep 2021 13:21:58 +0800
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.179) by
 dggema764-chm.china.huawei.com (10.1.198.206) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Tue, 7 Sep 2021 13:21:57 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <james.morse@arm.com>,
        <alexandru.elisei@arm.com>, <suzuki.poulose@arm.com>,
        <wanghaibin.wang@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>,
        David Brazdil <dbrazdil@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] KVM: arm64: nvhe: Fix missing FORCE for hyp-reloc.S build rule
Date:   Tue, 7 Sep 2021 13:21:37 +0800
Message-ID: <20210907052137.1059-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema764-chm.china.huawei.com (10.1.198.206)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add FORCE so that if_changed can detect the command line change.

We'll otherwise see a compilation warning since commit e1f86d7b4b2a
("kbuild: warn if FORCE is missing for if_changed(_dep,_rule) and
filechk").

arch/arm64/kvm/hyp/nvhe/Makefile:58: FORCE prerequisite is missing

Cc: David Brazdil <dbrazdil@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 arch/arm64/kvm/hyp/nvhe/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 5df6193fc430..8d741f71377f 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -54,7 +54,7 @@ $(obj)/kvm_nvhe.tmp.o: $(obj)/hyp.lds $(addprefix $(obj)/,$(hyp-obj)) FORCE
 #    runtime. Because the hypervisor is part of the kernel binary, relocations
 #    produce a kernel VA. We enumerate relocations targeting hyp at build time
 #    and convert the kernel VAs at those positions to hyp VAs.
-$(obj)/hyp-reloc.S: $(obj)/kvm_nvhe.tmp.o $(obj)/gen-hyprel
+$(obj)/hyp-reloc.S: $(obj)/kvm_nvhe.tmp.o $(obj)/gen-hyprel FORCE
 	$(call if_changed,hyprel)
 
 # 5) Compile hyp-reloc.S and link it into the existing partially linked object.
-- 
2.19.1

