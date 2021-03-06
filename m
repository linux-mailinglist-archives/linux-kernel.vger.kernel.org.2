Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B917132F7BB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 03:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhCFCAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 21:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhCFB7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 20:59:51 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D236C06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 17:59:51 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id y9so3314853qki.14
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 17:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=RGBGjRYcLpzZKmmikFQwZLPbNnCzmLhMB1ZnNSdMI9Q=;
        b=B2slHV0TDG3kCxdpO6MqS6MEA29EPE00hM4j4eEMMirvy2nvf7tYOlXFK4t7AKTH61
         nMDnUJOW7I1l8Vktzb0QZJu3TyjCcXTPS5+FI/IciWJiQKIUtzK6jYZvQUL1DmegzDqp
         +vhGN2JmcZQhDvROioiZ/J4XABwioYcsMJdMNXC3/0kGW0EQWkY7se41i+AYVxOGfpvY
         dYa/j2sfIWGAm4yaAIOXGN+DOtXzBMbi1QmKGymC5+IdFHQtq99lMKP+GfKE53N1Gnp2
         RSDvByxJoeXjiLlLKqv4CUQS6shOb5RyQsnCZPgsgqwdgSLgy2KL5veo0QwI2SMUitD4
         cGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=RGBGjRYcLpzZKmmikFQwZLPbNnCzmLhMB1ZnNSdMI9Q=;
        b=DdbXdPgBtC1r5v6eNVyXjbaxeZU3vp3E2JK/FuMBADIMGMJnYI+ocxSfD1KxtMJgAh
         3AUY1GpEBdtJRVatSlxcnCW4R7TCUXmcLJrX2JqXPGIxUH6vl5CLBzQXVjJghaGmXS6F
         Azk43666RjNCElfB/woy/JcDiva6D9ZPFqcAuwg0LU4R6uuqq1ckb9fk8wG+tj0RA/VC
         2U63doyNYT0Tj1ysC9qDtP7M3S29ibi0+Bc/NflE5YVVlfnvqNXBn0dxvQicFrzBtRVP
         oA5qfERUR0SlN+ivDoipIv79laWupCbXYdTdfZXgGEXhGQEhk7shJ6MKbs/ux4gP4Wnl
         NiGw==
X-Gm-Message-State: AOAM5338lBrMNVVxygClh5B+b1QL//OvJ801/t9zSwh745EGGmFArlDB
        22enCJvsiEjnBCs4plQY2tVZTOxLNz4=
X-Google-Smtp-Source: ABdhPJwSoKByoD4fhMYtVv7nTAckUzrERAauGnDMgwYEfWPsbSLGyNIuvE+yfkt8C2ng8lyhOS/O+n+WuEA=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:fc04:f9df:1efb:bf0c])
 (user=seanjc job=sendgmr) by 2002:a05:6214:1085:: with SMTP id
 o5mr11740761qvr.5.1614995990308; Fri, 05 Mar 2021 17:59:50 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  5 Mar 2021 17:59:05 -0800
In-Reply-To: <20210306015905.186698-1-seanjc@google.com>
Message-Id: <20210306015905.186698-15-seanjc@google.com>
Mime-Version: 1.0
References: <20210306015905.186698-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v4 14/14] KVM: SVM: Skip SEV cache flush if no ASIDs have been used
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip SEV's expensive WBINVD and DF_FLUSH if there are no SEV ASIDs
waiting to be reclaimed, e.g. if SEV was never used.  This "fixes" an
issue where the DF_FLUSH fails during hardware teardown if the original
SEV_INIT failed.  Ideally, SEV wouldn't be marked as enabled in KVM if
SEV_INIT fails, but that's a problem for another day.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 3bf04a697723..f8ebda7c365a 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -57,9 +57,14 @@ struct enc_region {
 	unsigned long size;
 };
 
-static int sev_flush_asids(void)
+static int sev_flush_asids(int min_asid, int max_asid)
 {
-	int ret, error = 0;
+	int ret, pos, error = 0;
+
+	/* Check if there are any ASIDs to reclaim before performing a flush */
+	pos = find_next_bit(sev_reclaim_asid_bitmap, max_sev_asid, min_asid);
+	if (pos >= max_asid)
+		return -EBUSY;
 
 	/*
 	 * DEACTIVATE will clear the WBINVD indicator causing DF_FLUSH to fail,
@@ -81,14 +86,7 @@ static int sev_flush_asids(void)
 /* Must be called with the sev_bitmap_lock held */
 static bool __sev_recycle_asids(int min_asid, int max_asid)
 {
-	int pos;
-
-	/* Check if there are any ASIDs to reclaim before performing a flush */
-	pos = find_next_bit(sev_reclaim_asid_bitmap, max_sev_asid, min_asid);
-	if (pos >= max_asid)
-		return false;
-
-	if (sev_flush_asids())
+	if (sev_flush_asids(min_asid, max_asid))
 		return false;
 
 	/* The flush process will flush all reclaimable SEV and SEV-ES ASIDs */
@@ -1399,10 +1397,11 @@ void sev_hardware_teardown(void)
 	if (!sev_enabled)
 		return;
 
+	/* No need to take sev_bitmap_lock, all VMs have been destroyed. */
+	sev_flush_asids(0, max_sev_asid);
+
 	bitmap_free(sev_asid_bitmap);
 	bitmap_free(sev_reclaim_asid_bitmap);
-
-	sev_flush_asids();
 }
 
 int sev_cpu_init(struct svm_cpu_data *sd)
-- 
2.30.1.766.gb4fecdf3b7-goog

