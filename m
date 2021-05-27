Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F6D39370D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbhE0UYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:24:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22886 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236206AbhE0UYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622146986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VwFrdF3JNaZBFM+3FwQbg8GtNhiuS7dByxCQ/uoQV90=;
        b=dm2LOdeultijlEdexIhDmrgB6yDP0ppzJ1wwVv8RkDm6PTkFLPO1Gl97IKzAhfMEf2JkUi
        ZeNu69QKxrl/ryMilAjTgAknJmIjMNXvmqJFLXiD0YpkLsVy7E9pkBVthVB/cXy60wiapU
        p6kfP3TG2zUwWqmV9mJ37tNDotim2pU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-YoUdZxeOMN-ItX36S2WbLQ-1; Thu, 27 May 2021 16:23:05 -0400
X-MC-Unique: YoUdZxeOMN-ItX36S2WbLQ-1
Received: by mail-qk1-f200.google.com with SMTP id s4-20020a3790040000b02902fa7aa987e8so1325465qkd.14
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 13:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VwFrdF3JNaZBFM+3FwQbg8GtNhiuS7dByxCQ/uoQV90=;
        b=c3J97Pe1muoCjxmbWKNaCWaaH7yxGI2VTp5Eox6D4ma+P9jl53yIaF6rxXLShE4T6Y
         Pxea9kIbpCWqlU/iiM2Hfoi5v8+7MGWshmgmvVsRDg7ggSuAXvp1Ct+Wnjijh/eZMpoT
         lulr51nG+/F61KIZJnBLKCKArlZq+hRtpT05W6ofif0vOu6DrxKj2SGkvWZbdTYvUm/t
         qqLkXBxn7oX2LDwazIQY5PzpQa0fQeoh6NmJxFHceK3Rr4pSnM1Ei/UC+6nk3N+S2wxS
         x9oddUZz7ziwTJpwxaZyuZNP+M7IVQvtb67JFNIXJLdMM5Lw2ZjkzrmABF654n84C+wF
         W/Jw==
X-Gm-Message-State: AOAM532+mJfDn8UB6aA39fLnXY5x3CPFgI8UMVHkxlL8R2EWpeUiHhc9
        +xiQ/ESMbREFNgeWsyxe3dTMWRXf7nZYb+5cVoJaSh7WAOoSFx5UtM4YXrQhvr4e97HIKfZoOcz
        SHIftaaYYQLxmkY53iggoFXE1zd5K30/vS89C1l1NmKFmgltHW7yyKxmzcDNXYZx/TXGWCknA0g
        ==
X-Received: by 2002:a37:aa4c:: with SMTP id t73mr330215qke.79.1622146983382;
        Thu, 27 May 2021 13:23:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzsk606Pw4SsfXcguARe8KrXTgefcf4445STrLT/TYxczzrKEpV25kmsn40HUYN5w/RJZYAQ==
X-Received: by 2002:a37:aa4c:: with SMTP id t73mr330178qke.79.1622146983093;
        Thu, 27 May 2021 13:23:03 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id g85sm2024356qke.123.2021.05.27.13.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:23:02 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH v3 15/27] shmem/userfaultfd: Pass over uffd-wp special swap pte when fork()
Date:   Thu, 27 May 2021 16:22:59 -0400
Message-Id: <20210527202259.31767-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527201927.29586-1-peterx@redhat.com>
References: <20210527201927.29586-1-peterx@redhat.com>
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
index 3453b8ae5f4f..8372b212993a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -777,8 +777,21 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
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
 			return -EAGAIN;
-- 
2.31.1

