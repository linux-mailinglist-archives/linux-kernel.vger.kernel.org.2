Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAE53E32F6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 05:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhHGD0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 23:26:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53185 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230371AbhHGDZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 23:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628306730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bjEVjVuqoZmR4E24RTtF6/Pc/e6BiHg9xZTg6exvfsA=;
        b=Zyp5Hu1FVxtI/uTdXVj5RB68VzgxS7pScdrznzjlcNUoo9n3v8hk93JHpmS/DqvorYrOQk
        fF6YiCUIf6UQ9hqP1shrSk9UvDc6KhwHBy2LtmgpYZEAAnOvdrA6PkYtS4rPlJc8QHzGGU
        4uEY5DBvTj/LGfsvtZiLgwRtX/yVgB0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-HFLPfhEePW2MGXbMUscv7Q-1; Fri, 06 Aug 2021 23:25:29 -0400
X-MC-Unique: HFLPfhEePW2MGXbMUscv7Q-1
Received: by mail-qk1-f199.google.com with SMTP id q9-20020a05620a0c89b02903ba3e0f08d7so7751983qki.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 20:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bjEVjVuqoZmR4E24RTtF6/Pc/e6BiHg9xZTg6exvfsA=;
        b=rrVWr2IPbejW6L5J5BPBHo5gmMu124vPef+4R580yr8VMF9jQ9F3MJeTVFYCX9+wH6
         /RvKdFC5ny4MFWpTxKzPTmLwqvDxws6jTUXBdQt4UCJ1HtESZWTiA9ND/Uqcfh0ZmvtJ
         jeGksFuXR3Cv9khUaTQk3AltuKEhH6gGtoESmukp73gHmoZUyT9Lfd99oaLyRa0OppyP
         eSe8DU12+NBjxjlrQ7bUwR9kWse1WEgR6N8GdzUX26byiVPZgNmzE0DClx2xOICuBFNp
         vfGv7J7VEjajjXyvNfObP6vvc5MLzVf6TMsVXqngIVD8adRX331VSsk/mQdVMfk5W2Gm
         R2sw==
X-Gm-Message-State: AOAM531A3lhyl2i2nwmCPL+VeUehZArJe415GSS50iNTIoDdVoqn+BX8
        fT6Zf2SApRVOeZ2ag7X9Rst5I0RSUKSSKwF5BrBWdOxh0GWZ7y/8IhTKpXwYGqWZXak+VBk02ka
        oxlytyqRJR1XibIiP153IAfYz1E25ycQXRPCQMmNQvA/Qk/5kQC9zZofcVxTDTQZ49i8ig1/4sg
        ==
X-Received: by 2002:a05:620a:205e:: with SMTP id d30mr13550319qka.365.1628306728953;
        Fri, 06 Aug 2021 20:25:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpGYk7qN5OVUrrQMIOkOmPcFH65ctEbWhaV9MLhg4CSFYW2Fa7e9x20fuo0S2Px9Hm+mTA0w==
X-Received: by 2002:a05:620a:205e:: with SMTP id d30mr13550297qka.365.1628306728688;
        Fri, 06 Aug 2021 20:25:28 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-92-76-70-75-133.dsl.bell.ca. [76.70.75.133])
        by smtp.gmail.com with ESMTPSA id a5sm5514875qkk.92.2021.08.06.20.25.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Aug 2021 20:25:28 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Alistair Popple <apopple@nvidia.com>,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>,
        ivan.teterevkov@nutanix.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH RFC 3/4] mm: Handle PTE_MARKER page faults
Date:   Fri,  6 Aug 2021 23:25:20 -0400
Message-Id: <20210807032521.7591-4-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210807032521.7591-1-peterx@redhat.com>
References: <20210807032521.7591-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

handle_pte_marker() is the function that will parse and handle all the pte
marker faults.  For PAGEOUT marker, it's as simple as dropping the pte and do
the fault just like a none pte.

The other solution should be that we clear the pte to none pte and retry the
fault, however that'll be slower than handling it right now.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 7288f585544a..47f8ca064459 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -98,6 +98,8 @@ struct page *mem_map;
 EXPORT_SYMBOL(mem_map);
 #endif
 
+static vm_fault_t do_fault(struct vm_fault *vmf);
+
 /*
  * A number of key systems in x86 including ioremap() rely on the assumption
  * that high_memory defines the upper bound on direct map memory, then end
@@ -1394,6 +1396,10 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 
 			put_page(page);
 			continue;
+		} else if (is_pte_marker_entry(entry)) {
+			/* Drop PTE_MARKER_PAGEOUT when zapped */
+			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
+			continue;
 		}
 
 		/* If details->check_mapping, we leave swap entries. */
@@ -3467,6 +3473,39 @@ static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
 	return 0;
 }
 
+/*
+ * This function parses PTE markers and handle the faults.  Returns true if we
+ * finished the fault, and we should have put the return value into "*ret".
+ * Otherwise it means we want to continue the swap path, and "*ret" untouched.
+ */
+static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
+{
+	swp_entry_t entry = pte_to_swp_entry(vmf->orig_pte);
+	unsigned long marker;
+
+	marker = pte_marker_get(entry);
+
+	/*
+	 * PTE markers should always be with file-backed memories, and the
+	 * marker should never be empty.  If anything weird happened, the best
+	 * thing to do is to kill the process along with its mm.
+	 */
+	if (WARN_ON_ONCE(vma_is_anonymous(vmf->vma) || !marker))
+		return VM_FAULT_SIGBUS;
+
+#ifdef CONFIG_PTE_MARKER_PAGEOUT
+	if (marker == PTE_MARKER_PAGEOUT)
+		/*
+		 * This pte is previously zapped for swap, the PAGEOUT is only
+		 * a flag before it's accessed again.  Safe to drop it now.
+		 */
+		return do_fault(vmf);
+#endif
+
+	/* We see some marker that we can't handle */
+	return VM_FAULT_SIGBUS;
+}
+
 /*
  * We enter with non-exclusive mmap_lock (to exclude vma changes,
  * but allow concurrent faults), and pte mapped but not yet locked.
@@ -3503,6 +3542,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			ret = vmf->page->pgmap->ops->migrate_to_ram(vmf);
 		} else if (is_hwpoison_entry(entry)) {
 			ret = VM_FAULT_HWPOISON;
+		} else if (is_pte_marker_entry(entry)) {
+			ret = handle_pte_marker(vmf);
 		} else {
 			print_bad_pte(vma, vmf->address, vmf->orig_pte, NULL);
 			ret = VM_FAULT_SIGBUS;
-- 
2.32.0

