Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD1744B4F3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 22:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244470AbhKIV4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 16:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244274AbhKIV4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 16:56:02 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F04AC0613F5
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 13:53:16 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id k9-20020a170902c40900b001421e921ccaso449841plk.22
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 13:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=qROBDxPlYd/6/V/Do1yz3feMVcywFIzjmtV6/Bnhy1k=;
        b=erF7rNk4Bc6/zQRRsk73xZaWMcPuayoIYMIWzwYyReQmr2jNcSjHI92Ja4fyGYsabW
         GhYJwgywGdW1PgvMmVINtcKgdLe0eJ6ppzf8N10GrTElTjY6kitXJCge1eDHFjvTH7yI
         Ihm+OGa//Yrf60rCnNHSVnJbqDPOFxsKUrgq9XTLZ6R+XKULqwfekRkkd8dCOpkdF83V
         HXc/XKKxT50Yh39n70/Lp/yOfPXmcvdZwH4OwBiZD0q51wZGiL2n/zzoZ+dQT0UE5McA
         hIsBEuy+1h+LI8kzSw9CKr60Mkmir8egVhZAchg8UYhU5TcN7nviZmndSXtatt9d+2o6
         6/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=qROBDxPlYd/6/V/Do1yz3feMVcywFIzjmtV6/Bnhy1k=;
        b=nemtaJwfkjhCs6crKZsZjoNag5Lu5jSgFMpgllhGp+shr77G+RIatJfwQDkUBFe7Ko
         62fJ+Glh+jz7whtml2ncST6g0hh1iZO2hg4JJ8BeMwnwgjVuKdiHUqltCrvOA04G98RX
         afafk7n7n2tpe6Q2yhNohQgnG5XpUWde4pk9RIc3ESbSb+Dli43+nkb17gu1e9T3mQXA
         EWCX8ivHt5At+IOfloFvmArMQIE/y1KGrqd0ub++kYDsU3Oq9wwPk0dhybokxjINBOel
         RhY7CdqIt//fyzuKuyl8xlNsZc6p8viHyeqHtXeaeWmjUy+Ufvyn7OAw3e/y8iTSNysU
         SUJw==
X-Gm-Message-State: AOAM532MQR9jzGCXN2FhzPY7QWnPDVTr/iUOi3NfrdH4DUa3YP5R8map
        sSqG79LSO1cnRgSKC4Unqpg6CUgborM=
X-Google-Smtp-Source: ABdhPJyCxB24opmbJ7O+ptkYuGC7tkYsRasUC+r7J2bm/N6yoQPuIiaEOoRV36SngVtChNoMTYXCv9oRjb4=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:ce8c:b0:141:d218:954 with SMTP id
 f12-20020a170902ce8c00b00141d2180954mr10553330plg.1.1636494795732; Tue, 09
 Nov 2021 13:53:15 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  9 Nov 2021 21:50:57 +0000
In-Reply-To: <20211109215101.2211373-1-seanjc@google.com>
Message-Id: <20211109215101.2211373-3-seanjc@google.com>
Mime-Version: 1.0
References: <20211109215101.2211373-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH 2/6] KVM: SEV: Explicitly document that there are no TOCTOU
 races in copy ASID
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Gonda <pgonda@google.com>,
        Marc Orr <marcorr@google.com>,
        Nathan Tempelman <natet@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deliberately grab the source's SEV info for COPY_ENC_CONTEXT_FROM outside
of kvm->lock and document that doing so is safe due to SEV/SEV-ES info,
e.g. ASID, active, etc... being "write-once" and set atomically with
respect to kvm->lock.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index eeec499e4372..6d14e2595c96 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1737,9 +1737,9 @@ int svm_unregister_enc_region(struct kvm *kvm,
 
 int svm_vm_copy_asid_from(struct kvm *kvm, unsigned int source_fd)
 {
+	struct kvm_sev_info *mirror_sev, *source_sev;
 	struct file *source_kvm_file;
 	struct kvm *source_kvm;
-	struct kvm_sev_info source_sev, *mirror_sev;
 	int ret;
 
 	source_kvm_file = fget(source_fd);
@@ -1762,9 +1762,6 @@ int svm_vm_copy_asid_from(struct kvm *kvm, unsigned int source_fd)
 		goto e_source_unlock;
 	}
 
-	memcpy(&source_sev, &to_kvm_svm(source_kvm)->sev_info,
-	       sizeof(source_sev));
-
 	/*
 	 * The mirror kvm holds an enc_context_owner ref so its asid can't
 	 * disappear until we're done with it
@@ -1785,14 +1782,25 @@ int svm_vm_copy_asid_from(struct kvm *kvm, unsigned int source_fd)
 		goto e_mirror_unlock;
 	}
 
+	/*
+	 * Referencing the source's sev_info without holding the source's lock
+	 * is safe as SEV/SEV-ES activation is a one-way, "atomic" operation.
+	 * SEV state, e.g. the ASID, is modified under kvm->lock, and cannot be
+	 * changed after SEV is marked active (here or in normal activation).
+	 * That same atomicity also prevents TOC-TOU issues with respect to
+	 * related sanity checks on source_kvm.
+	 */
+	source_sev = &to_kvm_svm(source_kvm)->sev_info;
+
 	/* Set enc_context_owner and copy its encryption context over */
 	mirror_sev = &to_kvm_svm(kvm)->sev_info;
 	mirror_sev->enc_context_owner = source_kvm;
+	mirror_sev->asid = source_sev->asid;
 	mirror_sev->active = true;
-	mirror_sev->asid = source_sev.asid;
-	mirror_sev->fd = source_sev.fd;
-	mirror_sev->es_active = source_sev.es_active;
-	mirror_sev->handle = source_sev.handle;
+	mirror_sev->asid = source_sev->asid;
+	mirror_sev->fd = source_sev->fd;
+	mirror_sev->es_active = source_sev->es_active;
+	mirror_sev->handle = source_sev->handle;
 	/*
 	 * Do not copy ap_jump_table. Since the mirror does not share the same
 	 * KVM contexts as the original, and they may have different
-- 
2.34.0.rc0.344.g81b53c2807-goog

