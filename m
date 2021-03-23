Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50206345431
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhCWAuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:50:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39306 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231326AbhCWAti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616460578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bmYAjaH54F633I35l9apxE4WoJ10q7xNHsvAC/VJ+ZA=;
        b=aR0ZyIzl/+DvbKcAC1AIIzZxAMJeHUHlms/AZQKYrcLJKmSnWDc53fuardhMZE6BYmUtFn
        Azlv86yDLDxo3lvgY9Bh8Wh1tT07+krZzHIwJgEOSeZDa+W4A/mrCrJMIqfTVH7c02XNN4
        gffQEQLPgSIgVsgTSVtIOU4s8685WrQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-YyNbxLuCNbS9g1b_tVHbtA-1; Mon, 22 Mar 2021 20:49:36 -0400
X-MC-Unique: YyNbxLuCNbS9g1b_tVHbtA-1
Received: by mail-qv1-f71.google.com with SMTP id da16so572635qvb.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bmYAjaH54F633I35l9apxE4WoJ10q7xNHsvAC/VJ+ZA=;
        b=GIhLbUMESwlSw/Y/38b/oRzQQrIiGVQSArjZW4BvOQHo/Uh1XDdmilcJZwYKzVGbOf
         TG58G5k2PjseNUr8KbKlJ+fHzRclrw9l4esKn+ITW9+luh9Ew8ZsXYSF71F1ZbUTXf/F
         f3eVfYrAI3zf3N54qUJ8W5Sp4/X2+e4iAGqO07E93SfkdSg+uC3tf+ElqEBfOb5CKfx2
         mmsYDt8hcvYyvTIs7koSEcCaV3LgoCGhrRrpCBtOlKOUnn+MTZJ/5bq4tDCS7vvsgCqp
         Y4XShXQUyrbTo+hhH2QUAOatN4DbtuqmHj7qG8N6tfcr3NDCMgO0vhNJTFRYkjl/tQxu
         NfGA==
X-Gm-Message-State: AOAM531kflcI2n17t02mWzkfKPaAwazYcIwjZZj7aMoLUMUL+e3FdNmS
        Qm0gBONF4qG01+1yas3V/w3kXVTMeE382cGWMaCgGaXJzKEkyzn+0s4CBedpVMYL26MIpH+O7va
        ZDDNTjr1eUHmpFgCDCikkuP205faloGGQ9q/4c2UOWfBBPJX3xnrPdLJAoBeUsqYBB29s4PhLGg
        ==
X-Received: by 2002:a05:620a:819:: with SMTP id s25mr3093176qks.485.1616460575353;
        Mon, 22 Mar 2021 17:49:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwndVaIK/rU/VfjU2g3FSUD8i9gf3stvyGR9MZB2GR8CImkA5nMNn5+tsv84lL9aYUj/HBNgQ==
X-Received: by 2002:a05:620a:819:: with SMTP id s25mr3093145qks.485.1616460575052;
        Mon, 22 Mar 2021 17:49:35 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id n6sm5031793qtx.22.2021.03.22.17.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 17:49:33 -0700 (PDT)
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
Subject: [PATCH 12/23] shmem/userfaultfd: Allows file-back mem to be uffd wr-protected on thps
Date:   Mon, 22 Mar 2021 20:49:01 -0400
Message-Id: <20210323004912.35132-13-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210323004912.35132-1-peterx@redhat.com>
References: <20210323004912.35132-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't have "huge" version of PTE_SWP_UFFD_WP_SPECIAL, instead when necessary
we split the thp if the huge page is uffd wr-protected previously.

However split the thp is not enough, because file-backed thp is handled totally
differently comparing to anonymous thps - rather than doing a real split, the
thp pmd will simply got dropped in __split_huge_pmd_locked().

That is definitely not enough if e.g. when there is a thp covers range [0, 2M)
but we want to wr-protect small page resides in [4K, 8K) range, because after
__split_huge_pmd() returns, there will be a none pmd.

Here we leverage the previously introduced change_protection_prepare() macro so
that we'll populate the pmd with a pgtable page.  Then change_pte_range() will
do all the rest for us, e.g., install the uffd-wp swap special pte marker at
any pte that we'd like to wr-protect, under the protection of pgtable lock.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/mprotect.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 6b63e3544b47..51c954afa406 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -296,8 +296,16 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 		}
 
 		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
-			if (next - addr != HPAGE_PMD_SIZE) {
+			if (next - addr != HPAGE_PMD_SIZE ||
+			    /* Uffd wr-protecting a file-backed memory range */
+			    unlikely(!vma_is_anonymous(vma) &&
+				     (cp_flags & MM_CP_UFFD_WP))) {
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
+				/*
+				 * For file-backed, the pmd could have been
+				 * gone; still provide a pte pgtable if needed.
+				 */
+				change_protection_prepare(vma, pmd, addr, cp_flags);
 			} else {
 				int nr_ptes = change_huge_pmd(vma, pmd, addr,
 							      newprot, cp_flags);
-- 
2.26.2

