Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36A73DC0C2
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 00:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbhG3WFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 18:05:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59836 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232796AbhG3WFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 18:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627682703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FfXjy58FasEdIFi4ZWT72LgLttnZ5Iij0BOop3iMW7A=;
        b=HP3UC0P5LFqQAccVzSJKwe+lggWCjHQrT4kuug+KlsoxmSF1FF6kT10hhUkESmGvtGdV3t
        b8qq5iE8YwjePg807/d5NcBpVmEx3CnP2GoeYDjLLUO2RTgVdJrL0NhWR5PIhKQZUTIxFi
        7LURc1cI5bX+NvIMs1QIb7uhkREdw3Y=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-t30YctL4OSe9ig9HY9f1jw-1; Fri, 30 Jul 2021 18:05:02 -0400
X-MC-Unique: t30YctL4OSe9ig9HY9f1jw-1
Received: by mail-qt1-f200.google.com with SMTP id f9-20020a05622a1a09b02902615523e725so5110737qtb.21
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 15:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FfXjy58FasEdIFi4ZWT72LgLttnZ5Iij0BOop3iMW7A=;
        b=UemscdFeW+yXcx865TXgrgow4jcLD6OZwil7GiLY/tqsrLJ5D3vOQa7N/99ssTS4ee
         2+Ai3hbHEob6iXjas8FZZV8X2pCnm0KsCMdfai3dJlqOfLv1sSZxzJOFK3Yw9pIXCY8K
         qVpJDuu30s/FhY8UDNRnGPJd4mMAl2WrmW71RdR/h6eKVKBk7DLQ5Haq5oaxLXDL6ctr
         KfteX7zOR7oQibDuH9DKMD3H5e/euXKCQqyIHthloqba6VySEmcfpjID5+4ihhl1f3aj
         iPF1giRf24CH32ZTAA8YJOBHvMyj5vmMR+w2glG3ms/VDBDxcxpnQoBhM96kPOGwt19o
         bMMQ==
X-Gm-Message-State: AOAM533An7Z+CHotMmarJ8WqXBP8bUtq1Mox2KIm4vwVADaX6KP79jOG
        MpdPynno6rOwumIo2GIDd7oGW0JNPnnKnOcbJaANqPZLXI4ZvEwkyXVwkLqM0CZtN514WpJ2bmW
        /9YmSrd9DSAtWbXDAvNYBlwPI
X-Received: by 2002:ad4:59c6:: with SMTP id el6mr5069435qvb.61.1627682701993;
        Fri, 30 Jul 2021 15:05:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyH4DMk7eOeaMahyezhFuknnvxsQN34SBZyghGosNbzTWVGxLOwL+A9XhXocD3T6vS3E8BoDA==
X-Received: by 2002:ad4:59c6:: with SMTP id el6mr5069414qvb.61.1627682701786;
        Fri, 30 Jul 2021 15:05:01 -0700 (PDT)
Received: from t490s.. (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id l12sm1199651qtx.45.2021.07.30.15.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 15:05:00 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>, peterx@redhat.com,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 3/7] KVM: X86: Introduce kvm_mmu_slot_lpages() helpers
Date:   Fri, 30 Jul 2021 18:04:51 -0400
Message-Id: <20210730220455.26054-4-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210730220455.26054-1-peterx@redhat.com>
References: <20210730220455.26054-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce kvm_mmu_slot_lpages() to calculcate lpage_info and rmap array size.
The other __kvm_mmu_slot_lpages() can take an extra parameter of npages rather
than fetching from the memslot pointer.  Start to use the latter one in
kvm_alloc_memslot_metadata().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/x86.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 916c976e99ab..e44d8f7781b6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -299,6 +299,20 @@ static struct kmem_cache *x86_fpu_cache;
 
 static struct kmem_cache *x86_emulator_cache;
 
+static inline unsigned long
+__kvm_mmu_slot_lpages(struct kvm_memory_slot *slot, unsigned long npages,
+		      int level)
+{
+	return gfn_to_index(slot->base_gfn + npages - 1,
+			    slot->base_gfn, level) + 1;
+}
+
+static inline unsigned long
+kvm_mmu_slot_lpages(struct kvm_memory_slot *slot, int level)
+{
+	return __kvm_mmu_slot_lpages(slot, slot->npages, level);
+}
+
 /*
  * When called, it means the previous get/set msr reached an invalid msr.
  * Return true if we want to ignore/silent this failed msr access.
@@ -11443,8 +11457,7 @@ static int kvm_alloc_memslot_metadata(struct kvm *kvm,
 		int lpages;
 		int level = i + 1;
 
-		lpages = gfn_to_index(slot->base_gfn + npages - 1,
-				      slot->base_gfn, level) + 1;
+		lpages = __kvm_mmu_slot_lpages(slot, npages, level);
 
 		linfo = kvcalloc(lpages, sizeof(*linfo), GFP_KERNEL_ACCOUNT);
 		if (!linfo)
-- 
2.31.1

