Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1507444F079
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 02:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbhKMBZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 20:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbhKMBZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 20:25:43 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7578FC061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 17:22:52 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id e12-20020aa7980c000000b0049fa3fc29d0so6583931pfl.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 17:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ba+wxobSaiFgmTcgNPo/VsfplrPQ2ANaflUkZ8U4a0Y=;
        b=B2RXTSE+PsDQxq7oyt7onb151ClNd8WGtfxbuo8u0TZgh9aOnDTWAnvdB/5/Dy0rzQ
         W0SVhNnv9T96lHG4/HucXMgaCt2V6L/wjk9GMjXIyF1SLKA3QiUJ1+NyrPEjPNeQCF8L
         L7kGJS/2VpOghFFwbmHpzBKTMy1rH586KW5wzi0d6hgzl5ZT2hHP62qfgOs/PBN1QLR3
         I283eK87ObcpukWe/Tw04Po+bpk1cxT80eJ/Vb3iF3jFtt6VLa1UmfuvwFNryAuWFGf+
         NbsBedNB+i2THjX+c+6HFo+oIyw/Fidj1xiS3ksdMJJhZhV4oinNo3UnIYCJtHJGTh+W
         j+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ba+wxobSaiFgmTcgNPo/VsfplrPQ2ANaflUkZ8U4a0Y=;
        b=iLjzv0gAAvAymOqimkS2t8WfqDSz6ng0cEEY69czWXpHtXFt/imv3lxZOlT50KtypD
         XDC8QFuhr1pOGlpW/QhYFnVTAOYPycXle70JA+fETr3+doEToDBCuemNYK0kTXJCcmHa
         MXhytWfuuj1+pPk/0Q4rFoafN/jfCtBDWCE6d7gzGTkIYT4xm3e61rC/cG7yn1eEgNBP
         ADQJ6QmuiNredTJI+YYi4tbURRNqgTkUyfbYbhPb/O1C8bUyJIc5L86CDwkbOI91HC72
         LQpHM4a8BYvCtZPz4LaEbo4ZaOtubWTFwfT5xeEbiIk1VM6V4jBz6QwdwU/CtXaaHXnV
         viWw==
X-Gm-Message-State: AOAM533xEy5BrvE9YEcbbEKrDziMWq/ZvtyL4XimRgRHlxaYGbSJaJDd
        7ClcXAofyASCCABj3n8ABNu0wRV6B+Hu
X-Google-Smtp-Source: ABdhPJxd9EBwwuIBPspUU4u87Oi0TkCWLlVKjb1nJ8VxwRhr5W5IAS2T2mLzZod60TuVuSRdfolwZ6rvNCJY
X-Received: from rananta-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a17:90a:3905:: with SMTP id
 y5mr141689pjb.0.1636766571415; Fri, 12 Nov 2021 17:22:51 -0800 (PST)
Date:   Sat, 13 Nov 2021 01:22:26 +0000
In-Reply-To: <20211113012234.1443009-1-rananta@google.com>
Message-Id: <20211113012234.1443009-4-rananta@google.com>
Mime-Version: 1.0
References: <20211113012234.1443009-1-rananta@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [RFC PATCH v2 03/11] KVM: Introduce kvm_vm_has_run_once
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Marc Zyngier <maz@kernel.org>, Andrew Jones <drjones@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
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

The upcoming patches need a way to detect if the VM, as
a whole, has started. Hence, unionize kvm_vcpu_has_run_once()
of all the vcpus of the VM and build kvm_vm_has_run_once()
to achieve the functionality.

No functional change intended.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 include/linux/kvm_host.h |  2 ++
 virt/kvm/kvm_main.c      | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index b373929c71eb..102e00c0e21c 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1854,4 +1854,6 @@ static inline bool kvm_vcpu_has_run_once(struct kvm_vcpu *vcpu)
 	return vcpu->has_run_once;
 }
 
+bool kvm_vm_has_run_once(struct kvm *kvm);
+
 #endif
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 1ec8a8e959b2..3d8d96e8f61d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4339,6 +4339,23 @@ static int kvm_vm_ioctl_get_stats_fd(struct kvm *kvm)
 	return fd;
 }
 
+bool kvm_vm_has_run_once(struct kvm *kvm)
+{
+	int i, ret = false;
+	struct kvm_vcpu *vcpu;
+
+	mutex_lock(&kvm->lock);
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		ret = kvm_vcpu_has_run_once(vcpu);
+		if (ret)
+			break;
+	}
+
+	mutex_unlock(&kvm->lock);
+	return ret;
+}
+
 static long kvm_vm_ioctl(struct file *filp,
 			   unsigned int ioctl, unsigned long arg)
 {
-- 
2.34.0.rc1.387.gb447b232ab-goog

