Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DDA36C947
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238890AbhD0QYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:24:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56594 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237553AbhD0QO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619540025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bJUKYR7hr17ohgPo/T1v5XQHyXxi59fVxEqscfG7/f8=;
        b=DLXVizTZozmah99fu4ED6VOqtBkdEgZvSjFN4KzGY8vx69EZMyJVgbdvP9XlZ7EQrUFQ9a
        WW0b2rrgPtIeizlk5uQpHD7gS/Lf02sOMapOqj2qhsrrxCJUMtgnKvxBb3wESDQJHdB54G
        noGmEkmxe/x2BL1xMDZI+LKNwVyuEns=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-agnSG7eNPqq4iLAQnkkM5A-1; Tue, 27 Apr 2021 12:13:42 -0400
X-MC-Unique: agnSG7eNPqq4iLAQnkkM5A-1
Received: by mail-qk1-f200.google.com with SMTP id e4-20020a37b5040000b02902df9a0070efso23374232qkf.18
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bJUKYR7hr17ohgPo/T1v5XQHyXxi59fVxEqscfG7/f8=;
        b=GAXzIKPN4Q+x5h1m+kdPpG4YhnQodJYlhed8ChtoBIqYlFF+KeH1pmIf/P6jMo/rxp
         x7+WUZwvV4TmewTwR79QckHPOciv+6vRlIibBKV9cryHD79SsVAk2TYzSGfmfLZFdt7b
         t/oCR4Utc/O2rV3QjjZu3PCe3+a4Ru3B7Ia9BS1BJgP+J4UygjV7Ll5oV/lknBls2kZs
         lkvBfLgIrZimvEOEM+F+KY/spKbC0K0CFFEBt00LOXNVd8Bmpb7cEK2IWEhFBo3gP969
         3Oc1NqRrvmJaAYJbEtTUY++cTaPdOzAKJLP+vuapQiSZOljIwy5LA7Pzxd5UuM7ZqR3f
         148Q==
X-Gm-Message-State: AOAM533Dq3csgMZSHVF79gqyyKrTdIKA86gJC8Ys3v/2dx200xbC18kR
        5zO2Ki+2WWWGsm2IEgWwd+1MFYM9frZN68DWwyIVvfFsfo4WdCBKQDzJDx3lOjv2RVIUPpNdnSF
        +ubxbHc1bNHwelpeo738CnPb5
X-Received: by 2002:a37:a510:: with SMTP id o16mr5597688qke.306.1619540021700;
        Tue, 27 Apr 2021 09:13:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyK0i3RBqZsx2OzwuTxGkQwSJmhVwmVOV/gMvcyErmc0haHIIYmda75zIZFKivMWbj/kuK6pA==
X-Received: by 2002:a37:a510:: with SMTP id o16mr5597661qke.306.1619540021451;
        Tue, 27 Apr 2021 09:13:41 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id v66sm3103621qkd.113.2021.04.27.09.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 09:13:40 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v2 12/24] shmem/userfaultfd: Allows file-back mem to be uffd wr-protected on thps
Date:   Tue, 27 Apr 2021 12:13:05 -0400
Message-Id: <20210427161317.50682-13-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210427161317.50682-1-peterx@redhat.com>
References: <20210427161317.50682-1-peterx@redhat.com>
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
index 6b63e3544b470..51c954afa4069 100644
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

