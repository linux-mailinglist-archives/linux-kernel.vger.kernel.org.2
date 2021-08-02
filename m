Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35AB63DDEF1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 20:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhHBSJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 14:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhHBSJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 14:09:45 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B78C061760
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 11:09:34 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id h21-20020a17090adb95b029017797967ffbso706611pjv.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 11:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=zTp4k8EQSXsCqyOFWmBzNmeaus4lIgrrLbtUHvM24/g=;
        b=qhcqAy6X0f6Y4aR8jJOiOx4TnSaoAruw6C3jfL3ikjsiEwDF6eTx4VMr0NqBUhj2yn
         ZoR/Ap4h3eLc7gg2h1Ua5DRcmIe4d1IQVxPJnrNsdhUporMIVMu1t8cb3F9sCckTVvRO
         dka5xyl6fGQHdSwKX64hZ8OdZFLJ22L8H+5+ZMQ+vN/OlKfRzobbZTFY7fykAHqgel2K
         SLJ/eOtlOBeWw+PKxO9k9hU/+t9ni/nH/C/i9sYzOSOhdK946e0nSAmCkU+DLEunzt+X
         k56MXpjljwBiZQlq2usN9kQx3sMo3cqBIoYHM5WiLWkk1cg3u1j6QZLdMqsl7TKeYEje
         1frw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=zTp4k8EQSXsCqyOFWmBzNmeaus4lIgrrLbtUHvM24/g=;
        b=OP1aOwPClBggAzzrezZEXSY3BGv6vWWjxX6gyAnZLjCP9TNlqp1iptJlFZ54ws9plm
         OEP+5JTCN6VE0AgzL8DRmwjLUTcG9XhWvhss/c0lwiYwnpL4hivASTS0LfZkYF0oXRdJ
         +5rEMQoenzdyNwXoRNJjnvDnYbpDKoaKGF9XHSyfy3crIJjRxLYkcAmAiHw/8dwazO8Y
         yFpuff/zvvHOjPvNOXcQyJ4aCR8XLnPi5q2N8tPe1yNz+Xq771ywTEObif79xD8pvWdF
         Q2X0i/MjHn9qc8Q7P/dLI+H5gd1cnU8+b1Jn+O9IHvHqEK7Ckb6Wu5i8GKAHK6tPEFOw
         KpBg==
X-Gm-Message-State: AOAM533xQ78tWxey1YwQ55kunezQBuNXQL9H7HIoWsaSOIE5cseRfM5C
        4/BPxc26pCL7GRtj0pXCXI2QMABk7JLX
X-Google-Smtp-Source: ABdhPJypTOGt3dVr7WRDACS04dVkLBGgCfDe22b6WkTs8J473eGM4W+aAkmCJ6G5w3QXiYsAJj/qWalIBpNE
X-Received: from mihenry-linux-desktop.kir.corp.google.com ([2620:15c:29:204:4304:2e3e:d2f5:48c8])
 (user=mizhang job=sendgmr) by 2002:a05:6a00:1245:b029:30f:2098:fcf4 with SMTP
 id u5-20020a056a001245b029030f2098fcf4mr17867197pfi.66.1627927774160; Mon, 02
 Aug 2021 11:09:34 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Mon,  2 Aug 2021 11:09:03 -0700
Message-Id: <20210802180903.159381-1-mizhang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH v2] KVM: SVM: improve the code readability for ASID management
From:   Mingwei Zhang <mizhang@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Marc Orr <marcorr@google.com>,
        David Rientjes <rientjes@google.com>,
        Alper Gun <alpergun@google.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Peter Gonda <pgonda@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM SEV code uses bitmaps to manage ASID states. ASID 0 was always skipped
because it is never used by VM. Thus, in existing code, ASID value and its
bitmap postion always has an 'offset-by-1' relationship.

Both SEV and SEV-ES shares the ASID space, thus KVM uses a dynamic range
[min_asid, max_asid] to handle SEV and SEV-ES ASIDs separately.

Existing code mixes the usage of ASID value and its bitmap position by
using the same variable called 'min_asid'.

Fix the min_asid usage: ensure that its usage is consistent with its name;
allocate extra size for ASID 0 to ensure that each ASID has the same value
with its bitmap position. Add comments on ASID bitmap allocation to clarify
the size change.

v1 -> v2:
 - change ASID bitmap size to incorporate ASID 0 [sean]
 - remove the 'fixes' line in commit message. [sean/joerg]

Signed-off-by: Mingwei Zhang <mizhang@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Marc Orr <marcorr@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Alper Gun <alpergun@google.com>
Cc: Dionna Glaze <dionnaglaze@google.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Vipin Sharma <vipinsh@google.com>
Cc: Peter Gonda <pgonda@google.com>
Cc: Joerg Roedel <joro@8bytes.org>
---
 arch/x86/kvm/svm/sev.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 8d36f0c73071..42d46c30f313 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -63,6 +63,7 @@ static DEFINE_MUTEX(sev_bitmap_lock);
 unsigned int max_sev_asid;
 static unsigned int min_sev_asid;
 static unsigned long sev_me_mask;
+static unsigned int nr_asids;
 static unsigned long *sev_asid_bitmap;
 static unsigned long *sev_reclaim_asid_bitmap;
 
@@ -77,11 +78,11 @@ struct enc_region {
 /* Called with the sev_bitmap_lock held, or on shutdown  */
 static int sev_flush_asids(int min_asid, int max_asid)
 {
-	int ret, pos, error = 0;
+	int ret, asid, error = 0;
 
 	/* Check if there are any ASIDs to reclaim before performing a flush */
-	pos = find_next_bit(sev_reclaim_asid_bitmap, max_asid, min_asid);
-	if (pos >= max_asid)
+	asid = find_next_bit(sev_reclaim_asid_bitmap, nr_asids, min_asid);
+	if (asid > max_asid)
 		return -EBUSY;
 
 	/*
@@ -114,15 +115,15 @@ static bool __sev_recycle_asids(int min_asid, int max_asid)
 
 	/* The flush process will flush all reclaimable SEV and SEV-ES ASIDs */
 	bitmap_xor(sev_asid_bitmap, sev_asid_bitmap, sev_reclaim_asid_bitmap,
-		   max_sev_asid);
-	bitmap_zero(sev_reclaim_asid_bitmap, max_sev_asid);
+		   nr_asids);
+	bitmap_zero(sev_reclaim_asid_bitmap, nr_asids);
 
 	return true;
 }
 
 static int sev_asid_new(struct kvm_sev_info *sev)
 {
-	int pos, min_asid, max_asid, ret;
+	int asid, min_asid, max_asid, ret;
 	bool retry = true;
 	enum misc_res_type type;
 
@@ -142,11 +143,11 @@ static int sev_asid_new(struct kvm_sev_info *sev)
 	 * SEV-enabled guests must use asid from min_sev_asid to max_sev_asid.
 	 * SEV-ES-enabled guest can use from 1 to min_sev_asid - 1.
 	 */
-	min_asid = sev->es_active ? 0 : min_sev_asid - 1;
+	min_asid = sev->es_active ? 1 : min_sev_asid;
 	max_asid = sev->es_active ? min_sev_asid - 1 : max_sev_asid;
 again:
-	pos = find_next_zero_bit(sev_asid_bitmap, max_sev_asid, min_asid);
-	if (pos >= max_asid) {
+	asid = find_next_zero_bit(sev_asid_bitmap, max_sev_asid, min_asid);
+	if (asid > max_asid) {
 		if (retry && __sev_recycle_asids(min_asid, max_asid)) {
 			retry = false;
 			goto again;
@@ -156,11 +157,11 @@ static int sev_asid_new(struct kvm_sev_info *sev)
 		goto e_uncharge;
 	}
 
-	__set_bit(pos, sev_asid_bitmap);
+	__set_bit(asid, sev_asid_bitmap);
 
 	mutex_unlock(&sev_bitmap_lock);
 
-	return pos + 1;
+	return asid;
 e_uncharge:
 	misc_cg_uncharge(type, sev->misc_cg, 1);
 	put_misc_cg(sev->misc_cg);
@@ -1854,12 +1855,17 @@ void __init sev_hardware_setup(void)
 	min_sev_asid = edx;
 	sev_me_mask = 1UL << (ebx & 0x3f);
 
-	/* Initialize SEV ASID bitmaps */
-	sev_asid_bitmap = bitmap_zalloc(max_sev_asid, GFP_KERNEL);
+	/*
+	 * Initialize SEV ASID bitmaps. Allocate space for ASID 0 in the bitmap,
+	 * even though it's never used, so that the bitmap is indexed by the
+	 * actual ASID.
+	 */
+	nr_asids = max_sev_asid + 1;
+	sev_asid_bitmap = bitmap_zalloc(nr_asids, GFP_KERNEL);
 	if (!sev_asid_bitmap)
 		goto out;
 
-	sev_reclaim_asid_bitmap = bitmap_zalloc(max_sev_asid, GFP_KERNEL);
+	sev_reclaim_asid_bitmap = bitmap_zalloc(nr_asids, GFP_KERNEL);
 	if (!sev_reclaim_asid_bitmap) {
 		bitmap_free(sev_asid_bitmap);
 		sev_asid_bitmap = NULL;
@@ -1904,7 +1910,7 @@ void sev_hardware_teardown(void)
 		return;
 
 	/* No need to take sev_bitmap_lock, all VMs have been destroyed. */
-	sev_flush_asids(0, max_sev_asid);
+	sev_flush_asids(1, max_sev_asid);
 
 	bitmap_free(sev_asid_bitmap);
 	bitmap_free(sev_reclaim_asid_bitmap);
-- 
2.32.0.554.ge1b32706d8-goog

