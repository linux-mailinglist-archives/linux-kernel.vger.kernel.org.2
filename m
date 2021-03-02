Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E1E32A834
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579984AbhCBRV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 12:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448599AbhCBPGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:06:09 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44046C0698CC
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:01:02 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id o20so13297868qtx.22
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ul+o/tKmUBDOvYf9j24b0RRB4JIOz9FDoTsxVSxSXxM=;
        b=pW+u784h5cAco+WjZOeMEiOygQj1G34XbUjvs4ZXhx71GX9qwAHjt8XzF6oHZuDXwa
         wgH83z4PpOrQySx6tyjngu/mMG9opxnaGjMuW8fPgRw9ksCt32BlXarMT6Il7ZiaqZpn
         7mUiXkToZK1hphH6grtrtlOBQCywTGirf+rTHNtbVoZP+um/QY9vdrNEQNwSj0MNJiS+
         MIfwIQ4+QJGxoFsu7TAUOUcWNUeh+1aslU2OU1gnPefp+jW4YYjwrcvgJL0BBeFgLTJt
         L9uyxaiydQT4m4S48zXW72AmDfQx9xnJu2HB5JldL4/g248HlHOYz2ya1frny7PUEufs
         S6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ul+o/tKmUBDOvYf9j24b0RRB4JIOz9FDoTsxVSxSXxM=;
        b=E+HAC6EA11h4QGTRRS1EL/vmt7Sw/NSYp8KG/Szz3/bpFgov04Mo3z9V9ejF+tCxrM
         C655GDuJmSqdoanS30aohYUq8XyJMmS+Jx87hL5G/Pi2Sa4jG6vhvDQb8vnxD1O2PuZ7
         06Foqa83OsyQ03pEil/9HtHgMFiBDhJcFcKn7OSCav6i37IxlXspBYBJOCLKIATJsEgL
         Sud7ujbVnr7UL9WHJvBVQJr6/buCflWgIx2wpFIBUs/ClwAgVdufZEQjklHdysP/NwL+
         t9uV8aUzaZb8IFojFfSaoe6nY1JQ80mNL/VsnAstLdbpJFvUrnMOw7SoCv7cLNSSnOHl
         4JTQ==
X-Gm-Message-State: AOAM532r8h5QPW5xZ/XETXUGpxE+QFtZTOJtSDrPCS5KJMAkImsKOquE
        WHtEL0TDtQtvQ/zMVeIBgGhuRXuOqUKK
X-Google-Smtp-Source: ABdhPJximV251/TA30yUjyxYuWzjKdxc4ib1kbnL5JjOJcV3XkuAkOyM4ZeRll9baZr9V40/GNB29ZHFcFmT
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a0c:b59f:: with SMTP id
 g31mr19967030qve.28.1614697260716; Tue, 02 Mar 2021 07:01:00 -0800 (PST)
Date:   Tue,  2 Mar 2021 14:59:54 +0000
In-Reply-To: <20210302150002.3685113-1-qperret@google.com>
Message-Id: <20210302150002.3685113-25-qperret@google.com>
Mime-Version: 1.0
References: <20210302150002.3685113-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3 24/32] KVM: arm64: Reserve memory for host stage 2
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, qperret@google.com, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the memory pool allocated for the hypervisor to include enough
pages to map all of memory at page granularity for the host stage 2.
While at it, also reserve some memory for device mappings.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mm.h | 23 ++++++++++++++++++++++-
 arch/arm64/kvm/hyp/nvhe/setup.c      | 12 ++++++++++++
 arch/arm64/kvm/hyp/reserved_mem.c    |  2 ++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mm.h b/arch/arm64/kvm/hyp/include/nvhe/mm.h
index ac0f7fcffd08..411a35db949c 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mm.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mm.h
@@ -53,7 +53,7 @@ static inline unsigned long __hyp_pgtable_max_pages(unsigned long nr_pages)
 	return total;
 }
 
-static inline unsigned long hyp_s1_pgtable_pages(void)
+static inline unsigned long __hyp_pgtable_total_pages(void)
 {
 	unsigned long res = 0, i;
 
@@ -63,9 +63,30 @@ static inline unsigned long hyp_s1_pgtable_pages(void)
 		res += __hyp_pgtable_max_pages(reg->size >> PAGE_SHIFT);
 	}
 
+	return res;
+}
+
+static inline unsigned long hyp_s1_pgtable_pages(void)
+{
+	unsigned long res;
+
+	res = __hyp_pgtable_total_pages();
+
 	/* Allow 1 GiB for private mappings */
 	res += __hyp_pgtable_max_pages(SZ_1G >> PAGE_SHIFT);
 
 	return res;
 }
+
+static inline unsigned long host_s2_mem_pgtable_pages(void)
+{
+	return __hyp_pgtable_total_pages() + 16;
+}
+
+static inline unsigned long host_s2_dev_pgtable_pages(void)
+{
+	/* Allow 1 GiB for private mappings */
+	return __hyp_pgtable_max_pages(SZ_1G >> PAGE_SHIFT);
+}
+
 #endif /* __KVM_HYP_MM_H */
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 178ec06f2b49..7e923b25271c 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -24,6 +24,8 @@ unsigned long hyp_nr_cpus;
 
 static void *vmemmap_base;
 static void *hyp_pgt_base;
+static void *host_s2_mem_pgt_base;
+static void *host_s2_dev_pgt_base;
 
 static int divide_memory_pool(void *virt, unsigned long size)
 {
@@ -42,6 +44,16 @@ static int divide_memory_pool(void *virt, unsigned long size)
 	if (!hyp_pgt_base)
 		return -ENOMEM;
 
+	nr_pages = host_s2_mem_pgtable_pages();
+	host_s2_mem_pgt_base = hyp_early_alloc_contig(nr_pages);
+	if (!host_s2_mem_pgt_base)
+		return -ENOMEM;
+
+	nr_pages = host_s2_dev_pgtable_pages();
+	host_s2_dev_pgt_base = hyp_early_alloc_contig(nr_pages);
+	if (!host_s2_dev_pgt_base)
+		return -ENOMEM;
+
 	return 0;
 }
 
diff --git a/arch/arm64/kvm/hyp/reserved_mem.c b/arch/arm64/kvm/hyp/reserved_mem.c
index 9bc6a6d27904..fd42705a3c26 100644
--- a/arch/arm64/kvm/hyp/reserved_mem.c
+++ b/arch/arm64/kvm/hyp/reserved_mem.c
@@ -52,6 +52,8 @@ void __init kvm_hyp_reserve(void)
 	}
 
 	hyp_mem_pages += hyp_s1_pgtable_pages();
+	hyp_mem_pages += host_s2_mem_pgtable_pages();
+	hyp_mem_pages += host_s2_dev_pgtable_pages();
 
 	/*
 	 * The hyp_vmemmap needs to be backed by pages, but these pages
-- 
2.30.1.766.gb4fecdf3b7-goog

