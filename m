Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88404417EF3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 02:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345556AbhIYA60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 20:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347582AbhIYA5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 20:57:44 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B505AC0617B0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 17:55:55 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id c27-20020a05620a165b00b003d3817c7c23so43920420qko.16
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 17:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=6T7U4FXDkZ4wSGR8PtdmKZv58jArlrzHMsBoVgMor+w=;
        b=KgOQHaJyXdK+GWQ+2KMuSUf8InFqvhIUK/RxDy04xLvESXB6G2X9Jrj1x+kNBAkBne
         PhOPZCYyVTUtZk6I8w8hOOLbiyX3n5M/2piepUvMuIeJBbfMZODdPBqWRJwDQLPaSQaV
         ewfzmZaiB/oD/jH9DEY0fO4j1eb1EJD3/BuOYOmy3Z3p8tliNWZ3jgZE0pCoLAqL2Vps
         m5RIhb9I1VErm10gqjjLk+L9EXIdeOdjyBhSzqXoCpxEKT+r+HDGPmZylA5xz8VPnVSN
         xkjZ3BURokP4QeF2PBXLrqVKvIiL/oQGDt7iU9yMu62sr1RqEYFvj68QISSAxPBFN6sX
         XnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=6T7U4FXDkZ4wSGR8PtdmKZv58jArlrzHMsBoVgMor+w=;
        b=CknZgVaMo5VgjSf06IMFY5WYV2loZg4suNgXWi809Ve+uEPcABDlDRFGNGk+puxuw5
         jtrJAnsowE/Li4f8X3/qOvD12fXJpM7yUUHjabVwpDqhhWfF037/HfKlYPitvQqBmSfU
         nG2g2kFLyDwXWJSaiUqGoCU0ihuSKhFPQE0DzMuDJk5+fHGA7Ot80BXklAnXIMJxT6x9
         r9+eFU2oPfZdscKCphCSBKoElg0Xa0xPZelWGdSL2IgOTlELwnIUgLOHM6QHtM/K+aql
         ia0P9mInsFP6sYCjnPuMOUh+x74Od0P5ZM8GgS7XwrL1RXMXCYRdrbjs4TUzdRv3PKVi
         Vx8g==
X-Gm-Message-State: AOAM533adzJfAvteorf0qtW5eF/m4Vhy1bK5QelzrUnu9asi4gezVdrT
        9uuM9W15qDMNhXo+WOH5qdDFK6CNGwA=
X-Google-Smtp-Source: ABdhPJxLb+obVS+gVpjC5G0ly7yv0fDwQXsQOvFcbn5XQYMMnEu8TwQl4KzgaC2kLIcfTeYpbPGVyglE2HA=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:4c72:89be:dba3:2bcb])
 (user=seanjc job=sendgmr) by 2002:ad4:446f:: with SMTP id s15mr13334020qvt.3.1632531354888;
 Fri, 24 Sep 2021 17:55:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 24 Sep 2021 17:55:25 -0700
In-Reply-To: <20210925005528.1145584-1-seanjc@google.com>
Message-Id: <20210925005528.1145584-12-seanjc@google.com>
Mime-Version: 1.0
References: <20210925005528.1145584-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH 11/14] KVM: stats: Add stat to detect if vcpu is currently blocking
From:   Sean Christopherson <seanjc@google.com>
To:     Marc Zyngier <maz@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Matlack <dmatlack@google.com>,
        Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jing Zhang <jingzhangos@google.com>

Add a "blocking" stat that userspace can use to detect the case where a
vCPU is not being run because of a vCPU/guest action, e.g. HLT or WFS on
x86, WFI on arm64, etc...  Current guest/host/halt stats don't show this
well, e.g. if a guest halts for a long period of time then the vCPU could
appear pathologically blocked due to a host condition, when in reality the
vCPU has been put into a not-runnable state by the guest.

Originally-by: Cannon Matthews <cannonmatthews@google.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Jing Zhang <jingzhangos@google.com>
[sean: renamed stat to "blocking", massaged changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h  | 3 ++-
 include/linux/kvm_types.h | 1 +
 virt/kvm/kvm_main.c       | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 655c2b24db2d..9bb1972e396a 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1453,7 +1453,8 @@ struct _kvm_stats_desc {
 	STATS_DESC_LOGHIST_TIME_NSEC(VCPU_GENERIC, halt_poll_fail_hist,	       \
 			HALT_POLL_HIST_COUNT),				       \
 	STATS_DESC_LOGHIST_TIME_NSEC(VCPU_GENERIC, halt_wait_hist,	       \
-			HALT_POLL_HIST_COUNT)
+			HALT_POLL_HIST_COUNT),				       \
+	STATS_DESC_ICOUNTER(VCPU_GENERIC, blocking)
 
 extern struct dentry *kvm_debugfs_dir;
 
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index 2237abb93ccd..c4f9257bf32d 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -94,6 +94,7 @@ struct kvm_vcpu_stat_generic {
 	u64 halt_poll_success_hist[HALT_POLL_HIST_COUNT];
 	u64 halt_poll_fail_hist[HALT_POLL_HIST_COUNT];
 	u64 halt_wait_hist[HALT_POLL_HIST_COUNT];
+	u64 blocking;
 };
 
 #define KVM_STATS_NAME_SIZE	48
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index fe34457530c2..2980d2b88559 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3208,6 +3208,7 @@ bool kvm_vcpu_block(struct kvm_vcpu *vcpu)
 {
 	bool waited = false;
 
+	vcpu->stat.generic.blocking = 1;
 	kvm_arch_vcpu_blocking(vcpu);
 
 	prepare_to_rcuwait(&vcpu->wait);
@@ -3223,6 +3224,7 @@ bool kvm_vcpu_block(struct kvm_vcpu *vcpu)
 	finish_rcuwait(&vcpu->wait);
 
 	kvm_arch_vcpu_unblocking(vcpu);
+	vcpu->stat.generic.blocking = 0;
 
 	return waited;
 }
-- 
2.33.0.685.g46640cef36-goog

