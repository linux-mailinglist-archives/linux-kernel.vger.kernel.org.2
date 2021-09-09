Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0992C4042E8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 03:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349754AbhIIBjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 21:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349513AbhIIBjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 21:39:46 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C79C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 18:38:37 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id l6-20020a170902ec0600b0013882202041so16062pld.15
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 18:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gnXKJQdV0c3R/PtxS6JEuqPswo+mI03RfMS+GJY9V2c=;
        b=qovCNdObk9hAYj5TRIstPpudmx6SP1gE3xKWc2RIyrpnrPqHTaRlABxqgUjn2zw7rT
         vEidP+eM7AUJIEqMeJgU88+wfjlSHF19U/ZiK9c6aesOhSvvkl4oRIUjCOTHPGyEZWay
         I37gnbfuZr2v8I5I5mxm2EC0V8EZ6yK+qOAnp+jtr324k5m51nzdTq56dzoHMs10+7zn
         8u22Sqvehn7ThNOUO7HAFN5kRqbI2jP4+7K40fB+qnINSr4lmHmlxbbzeV/WnIy1E+x6
         R3gWMpaynW+uiMBXTZa/08/31Czfo6HEvQtCL8VmjI/Mf0dUE+Al2Qvm46MSYSaI3WGq
         IYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gnXKJQdV0c3R/PtxS6JEuqPswo+mI03RfMS+GJY9V2c=;
        b=10NWpaQa6w7czPctC4xSiRqAru/zfivZtg/g/RE51Uex1r6jEg/TdkgZXk4hJz3o6I
         3zE6fv1yXagSquz2feQb81SiKZ1Isnq5IEGr2Jb0usKX6wT1x8pc9sulEFMimgM4lQrn
         6nfi6appYmKXbXSjLAc9BUexvIRbY4i04A5Pw2XKllRAT5Ovb27DhNRdcWuGjelRjOia
         b7H8LIm7pIVY17vvl/t4N0wopUjNiPYZOPaBDJXkHnCf2zcjhZGax6fuG993X06WRwcu
         z7cpyOrrvzaFFWuyGU3xxrzNMn+6RV9zM5i/Kp0K1kidbLdspoCVfj6HXvyaVtmmdgsj
         dL9Q==
X-Gm-Message-State: AOAM530QXRsznlhd29ABtPjYYk8xSnkv/2JcdxSAdYsvQBeY9FKTowFw
        A5+C/bCluOG485KQeWRfyaD7RjqlYXCF
X-Google-Smtp-Source: ABdhPJzYobbwdhjyH3noMxa1HCPANLozf7zYs5UxTopZ642KuVhxcHxiSRq8EQ2ySUHCdPtjJlAquY0U4s3l
X-Received: from rananta-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:aa7:9693:0:b0:412:448c:89c6 with SMTP id
 f19-20020aa79693000000b00412448c89c6mr616147pfk.82.1631151516895; Wed, 08 Sep
 2021 18:38:36 -0700 (PDT)
Date:   Thu,  9 Sep 2021 01:38:05 +0000
In-Reply-To: <20210909013818.1191270-1-rananta@google.com>
Message-Id: <20210909013818.1191270-6-rananta@google.com>
Mime-Version: 1.0
References: <20210909013818.1191270-1-rananta@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v4 05/18] KVM: arm64: selftests: Add support for cpu_relax
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Raghavendra Rao Anata <rananta@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the guest helper routine, cpu_relax(), to yield
the processor to other tasks.

The function was derived from
arch/arm64/include/asm/vdso/processor.h.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
Reviewed-by: Oliver Upton <oupton@google.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
---
 tools/testing/selftests/kvm/include/aarch64/processor.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/aarch64/processor.h b/tools/testing/selftests/kvm/include/aarch64/processor.h
index ac8b63f8aab7..166d273ad715 100644
--- a/tools/testing/selftests/kvm/include/aarch64/processor.h
+++ b/tools/testing/selftests/kvm/include/aarch64/processor.h
@@ -134,6 +134,11 @@ void vm_install_exception_handler(struct kvm_vm *vm,
 void vm_install_sync_handler(struct kvm_vm *vm,
 		int vector, int ec, handler_fn handler);
 
+static inline void cpu_relax(void)
+{
+	asm volatile("yield" ::: "memory");
+}
+
 #define isb()		asm volatile("isb" : : : "memory")
 #define dsb(opt)	asm volatile("dsb " #opt : : : "memory")
 #define dmb(opt)	asm volatile("dmb " #opt : : : "memory")
-- 
2.33.0.153.gba50c8fa24-goog

