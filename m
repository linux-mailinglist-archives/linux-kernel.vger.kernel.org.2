Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97AB036CEDC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 00:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239432AbhD0Wxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 18:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239226AbhD0Wxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 18:53:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B332C06138D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 15:52:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n11-20020a25808b0000b02904d9818b80e8so39136535ybk.14
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 15:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wFUvBfNruVY/JK0fwX3Z7n+fESghDcTsAmw7H5v/Rlk=;
        b=nOiV623+t5nS1ah8N8F1uzmCoAfC6GZ6qc7Jztk4Fk56z8UpGeIe9vPp09OYRmEGQg
         TA1dVYTBQIR2gH3YZy5xXWggNbxZdkFpKrLfWyNBWsYkn//6BKGMffqboivatZIco53t
         5dm0J6wamDlEDi96YRPpBrFFDMw+/hI56gwBMjQxUWeAGvcdK4X3Y70jzPE1+iqjfUzy
         NqzM8NsJqh5dsfhGiZB+BB3hTR4YCLE+rHd42Xbx8MX5wiuNTIRZN/hBhan1+Us3gB6P
         ODM2QqC8QLDggovQUkYNFtzGfXwk+RPa93NRQReZwaFQdpKHMCI/S6XNuHpSi9x7AaVd
         Hghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wFUvBfNruVY/JK0fwX3Z7n+fESghDcTsAmw7H5v/Rlk=;
        b=k6Mgfzux8Ao8NpfQ1XI1hVnZwdn4wrLAGuMZDxB8+AP+qS4G4ZIbLr2JNCb+iu76ZE
         COaHhFfbjsOJYFSfqzBLr8MtCDEy8m1mT3PP9PwJ7IiB9hR55dWr0o7EPxEmX11rAqb6
         id8L093ve6h+dSjQh6j8T5y03UVbGBwKDpyZD4PCGblA0ZIo58eKFIA4tpYk0Gg5DYe9
         2GbkfXlm4djXvG6LO2dxIUiVNEiZhqka0DWyfjvBhCN0ogot5MCjRtu/DaNCNQLKh28T
         oIBNYwMXo+zRuOsql8mEuub08rWw6mcsFWyTpY3q4VNDGbHYJBDHEtXT2cGnR0HMSuRK
         /ljQ==
X-Gm-Message-State: AOAM531qtcSW6r3HlHAODdbfJs+JsHcuJhPMY4F4fhdBc2ol9S2HcK7F
        fVNazSSwNCkuyvA6T1rtpakHXru+OHqmCmHolKy6
X-Google-Smtp-Source: ABdhPJw0Z6rdMOFVV+uJjPzkzLZQg0A7SkPaxmx3dkE4AQa30WJVlWyXic5Q6gGuFLFw/TjXas52aRI3Vo+601rH4IDL
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:c423:570b:b823:c33e])
 (user=axelrasmussen job=sendgmr) by 2002:a25:7109:: with SMTP id
 m9mr36314230ybc.274.1619563973817; Tue, 27 Apr 2021 15:52:53 -0700 (PDT)
Date:   Tue, 27 Apr 2021 15:52:37 -0700
In-Reply-To: <20210427225244.4326-1-axelrasmussen@google.com>
Message-Id: <20210427225244.4326-4-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210427225244.4326-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v5 03/10] userfaultfd/shmem: support minor fault registration
 for shmem
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Axel Rasmussen <axelrasmussen@google.com>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows shmem-backed VMAs to be registered for minor faults.
Minor faults are appropriately relayed to userspace in the fault path,
for VMAs with the relevant flag.

This commit doesn't hook up the UFFDIO_CONTINUE ioctl for shmem-backed
minor faults, though, so userspace doesn't yet have a way to resolve
such faults.

Because of this, we also don't yet advertise this as a supported
feature. That will be done in a separate commit when the feature is
fully implemented.

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c |  3 +--
 mm/memory.c      |  8 +++++---
 mm/shmem.c       | 12 +++++++++++-
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 14f92285d04f..468556fb04a9 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1267,8 +1267,7 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
 	}
 
 	if (vm_flags & VM_UFFD_MINOR) {
-		/* FIXME: Add minor fault interception for shmem. */
-		if (!is_vm_hugetlb_page(vma))
+		if (!(is_vm_hugetlb_page(vma) || vma_is_shmem(vma)))
 			return false;
 	}
 
diff --git a/mm/memory.c b/mm/memory.c
index 4e358601c5d6..cc71a445c76c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3972,9 +3972,11 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
 	 * something).
 	 */
 	if (vma->vm_ops->map_pages && fault_around_bytes >> PAGE_SHIFT > 1) {
-		ret = do_fault_around(vmf);
-		if (ret)
-			return ret;
+		if (likely(!userfaultfd_minor(vmf->vma))) {
+			ret = do_fault_around(vmf);
+			if (ret)
+				return ret;
+		}
 	}
 
 	ret = __do_fault(vmf);
diff --git a/mm/shmem.c b/mm/shmem.c
index b72c55aa07fc..30c0bb501dc9 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1785,7 +1785,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
  * vm. If we swap it in we mark it dirty since we also free the swap
  * entry since a page cannot live in both the swap and page cache.
  *
- * vmf and fault_type are only supplied by shmem_fault:
+ * vma, vmf, and fault_type are only supplied by shmem_fault:
  * otherwise they are NULL.
  */
 static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
@@ -1820,6 +1820,16 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 
 	page = pagecache_get_page(mapping, index,
 					FGP_ENTRY | FGP_HEAD | FGP_LOCK, 0);
+
+	if (page && vma && userfaultfd_minor(vma)) {
+		if (!xa_is_value(page)) {
+			unlock_page(page);
+			put_page(page);
+		}
+		*fault_type = handle_userfault(vmf, VM_UFFD_MINOR);
+		return 0;
+	}
+
 	if (xa_is_value(page)) {
 		error = shmem_swapin_page(inode, index, &page,
 					  sgp, gfp, vma, fault_type);
-- 
2.31.1.498.g6c1eba8ee3d-goog

