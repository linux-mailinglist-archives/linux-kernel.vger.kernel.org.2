Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5167B39A9C1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhFCSHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:07:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56607 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230446AbhFCSHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622743549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tXbIN/K5Sz2sSiy4b9DqsJhGb0vXqIJSZXhXMYqqraU=;
        b=hZxVJN9pBXBtQiEQUCOMPI0f7zZjMFFGb176A8o7vqz+AWCh6bp3mvnbnfcdHKxtEGjK5z
        cMrf1mRwkLeBwRngOUNym3Ivg5zPc2ABkJUwpxis+iQhPNpwaEOeknf9W/4IZAQpCRSnvi
        sbouwykpFvWnAGhmo+X6sNf0ZWY+0Ps=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-4Y8sJe0lNbmf8LLGWiYsvA-1; Thu, 03 Jun 2021 14:05:48 -0400
X-MC-Unique: 4Y8sJe0lNbmf8LLGWiYsvA-1
Received: by mail-qt1-f199.google.com with SMTP id z9-20020a05622a0609b02901f30a4fcf9bso3576948qta.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 11:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tXbIN/K5Sz2sSiy4b9DqsJhGb0vXqIJSZXhXMYqqraU=;
        b=bqDoTphTRcxSxx+0VzDpwENY1Foh92dAkv5hu5Srl6eWVab1uKUUoilkrl3URg1spJ
         AhyWlSPWUgXoIOgtN9WpEDvO2i4g25t/nxcOlJwVxdUkKH56vczBOB4LKy+CXG6WWGPb
         kX/wkoOfnDK+Z4Njp3dVUHjmjsXMAjc/WiRb5bous5NhlKJZQFTyI0ei3H8cEN/BvN5T
         eMbt6wJ1uq/3tfHwQBxRx6/uYO3b4I5UERs1bYthTfYPediy9e48sAG6nKirNrc7rhlM
         8jWsH6ytBjOd9sQukXKXJirQKTlKPKR8prCcvT8QeGwHLblYt856QOq6/nCtkI3yST5b
         RtmQ==
X-Gm-Message-State: AOAM530lB4cecxd0dov8+eoauDMLwlpceEkmVPtDNVuviKRpr6DvhTYe
        QxzNeYtu65oZHx/x0yy8C8Ca+XR1iQu/LKrzSfPaVsufyiHN2YjYyiYi2T3+lFK8tuIli4gzxgb
        BRYfpwEbfsUch1tkvZ51dhV3h
X-Received: by 2002:a05:620a:20da:: with SMTP id f26mr450086qka.203.1622743547976;
        Thu, 03 Jun 2021 11:05:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTyMQdXaZyjeReLDaxeCEsxV+Vpnor7t0rrbG3rdi1GTkkBklWCSv83UBY+w3pX9a5VlaRYA==
X-Received: by 2002:a05:620a:20da:: with SMTP id f26mr450069qka.203.1622743547758;
        Thu, 03 Jun 2021 11:05:47 -0700 (PDT)
Received: from t490s.redhat.com (bras-base-toroon474qw-grc-61-184-147-118-108.dsl.bell.ca. [184.147.118.108])
        by smtp.gmail.com with ESMTPSA id d2sm2344846qkn.95.2021.06.03.11.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 11:05:47 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH] mm/swap: Fix pte_same_as_swp() not removing uffd-wp bit when compare
Date:   Thu,  3 Jun 2021 14:05:46 -0400
Message-Id: <20210603180546.9083-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found it by pure code review, that pte_same_as_swp() of unuse_vma() didn't
take uffd-wp bit into account when comparing ptes.  pte_same_as_swp() returning
false negative could cause failure to swapoff swap ptes that was wr-protected
by userfaultfd.

Cc: Hugh Dickins <hughd@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/swapops.h | 15 +++++++++++----
 mm/swapfile.c           |  2 +-
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index af3d2661e41e..d356ab4047f7 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -23,6 +23,16 @@
 #define SWP_TYPE_SHIFT	(BITS_PER_XA_VALUE - MAX_SWAPFILES_SHIFT)
 #define SWP_OFFSET_MASK	((1UL << SWP_TYPE_SHIFT) - 1)
 
+/* Clear all flags but only keep swp_entry_t related information */
+static inline pte_t pte_swp_clear_flags(pte_t pte)
+{
+	if (pte_swp_soft_dirty(pte))
+		pte = pte_swp_clear_soft_dirty(pte);
+	if (pte_swp_uffd_wp(pte))
+		pte = pte_swp_clear_uffd_wp(pte);
+	return pte;
+}
+
 /*
  * Store a type+offset into a swp_entry_t in an arch-independent format
  */
@@ -66,10 +76,7 @@ static inline swp_entry_t pte_to_swp_entry(pte_t pte)
 {
 	swp_entry_t arch_entry;
 
-	if (pte_swp_soft_dirty(pte))
-		pte = pte_swp_clear_soft_dirty(pte);
-	if (pte_swp_uffd_wp(pte))
-		pte = pte_swp_clear_uffd_wp(pte);
+	pte = pte_swp_clear_flags(pte);
 	arch_entry = __pte_to_swp_entry(pte);
 	return swp_entry(__swp_type(arch_entry), __swp_offset(arch_entry));
 }
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 6212bc033602..1e07d1c776f2 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1887,7 +1887,7 @@ unsigned int count_swap_pages(int type, int free)
 
 static inline int pte_same_as_swp(pte_t pte, pte_t swp_pte)
 {
-	return pte_same(pte_swp_clear_soft_dirty(pte), swp_pte);
+	return pte_same(pte_swp_clear_flags(pte), swp_pte);
 }
 
 /*
-- 
2.31.1

