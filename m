Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E587C345432
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbhCWAuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:50:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49668 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231331AbhCWAtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616460581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cKuTAK/coeu/o9lPtGRIHWod3LERVBmK315ziMrYcLI=;
        b=caZfgVI/XElK5v424AIPqLtOl3HEqagLk5owxkqoYgwof+bkhqX8rJsHiIiqCWcVmumaIt
        GEGnwoNdcbCaJsf8kqJUWrsId0QMcB5Xhy82l6g7W7jjPRlYd4BMpwdiZpl1sRToTHuB6t
        2cOTgmGWLIYQwAnk6/yhNwxtaoosFx8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-oG5k3HzpPGOihQ5Qc6HVEg-1; Mon, 22 Mar 2021 20:49:39 -0400
X-MC-Unique: oG5k3HzpPGOihQ5Qc6HVEg-1
Received: by mail-qt1-f199.google.com with SMTP id r32so388416qtd.16
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cKuTAK/coeu/o9lPtGRIHWod3LERVBmK315ziMrYcLI=;
        b=tW7HBs6EcQObibiX0tWOcHGm2FSZ5A3PIsZ+8HWJnwOmcd+MuUXqs+m++oeA0iPchJ
         xt0i38SCSi8mcVZoD6sXY0iD293ptbEtml7zHkI9RkrwW2enj+XvLJd1PFnGB1h5jF+b
         dPn6qxYOH2GIpAh9nbz+F8oaxrxLlQFBR40C/Ovcv00p2qUteQISOW+mOGITth0/m6wd
         3w/hiokuyTOMtZYhbE7K4Y0JcYsJQC4uBhEQTysKd60HfXKx6PRfZWiEQIZCbbJX6GJd
         kqfhW0EbvXQmaldiAoqAjsfQURauJ+rWaEm42zXlo89IAesieh0N9T1yRRI3CBxMts8a
         ByEg==
X-Gm-Message-State: AOAM5330Z0vBvBXn0k3mlbF2g4UYcrBJ3d7Jq0fWEzgvYmMmyC/ZNsX6
        qX7sHSNeLm4X4NisK2XyMp4uQJiQBEtLEI0OFYTARZDZ/1j/1+Zy6CWwfAsRckH6Ilj5gVwsb7M
        CwA1o6m2hUt3QBEfbYWOSkiSnRBRl8g7DR/LmnUfEgVmSX7iriXmaIn9vgJ1q2Lb8BYxBs+qlaQ
        ==
X-Received: by 2002:a05:620a:1388:: with SMTP id k8mr2975005qki.224.1616460578872;
        Mon, 22 Mar 2021 17:49:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+wBwPeNPOsPise+7lL7dkN21Mn6lkzdRj7CMeozDPNGfvtHmM2/ikJDtiTyBJ8cbrfkFN1A==
X-Received: by 2002:a05:620a:1388:: with SMTP id k8mr2974981qki.224.1616460578591;
        Mon, 22 Mar 2021 17:49:38 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id n6sm5031793qtx.22.2021.03.22.17.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 17:49:38 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 14/23] shmem/userfaultfd: Pass over uffd-wp special swap pte when fork()
Date:   Mon, 22 Mar 2021 20:49:03 -0400
Message-Id: <20210323004912.35132-15-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210323004912.35132-1-peterx@redhat.com>
References: <20210323004912.35132-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should be handled similarly like other uffd-wp wr-protected ptes: we should
pass it over when the dst_vma has VM_UFFD_WP armed, otherwise drop it.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 8be28bcaa044..766946d3eab0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -715,8 +715,21 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	unsigned long vm_flags = dst_vma->vm_flags;
 	pte_t pte = *src_pte;
 	struct page *page;
-	swp_entry_t entry = pte_to_swp_entry(pte);
+	swp_entry_t entry;
+
+	if (unlikely(is_swap_special_pte(pte))) {
+		/*
+		 * uffd-wp special swap pte is the only possibility for now.
+		 * If dst vma is registered with uffd-wp, copy it over.
+		 * Otherwise, ignore this pte as if it's a none pte would work.
+		 */
+		WARN_ON_ONCE(!pte_swp_uffd_wp_special(pte));
+		if (userfaultfd_wp(dst_vma))
+			set_pte_at(dst_mm, addr, dst_pte, pte);
+		return 0;
+	}
 
+	entry = pte_to_swp_entry(pte);
 	if (likely(!non_swap_entry(entry))) {
 		if (swap_duplicate(entry) < 0)
 			return entry.val;
-- 
2.26.2

