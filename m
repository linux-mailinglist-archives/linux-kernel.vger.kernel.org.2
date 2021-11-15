Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF73644FFA2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 09:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhKOIEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 03:04:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60561 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236597AbhKOIEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 03:04:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636963266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CT33CO1P4m9z3srlG1n5DsePRxe7FxchG1iBDIBzjEc=;
        b=C54FE1t8/2oxCNnbYNW6aX8lbrmXuY0H7pVAL1C21oP5NaquAkN0g32hv7PB1L9LWIoZd+
        lSlimUI/xDl0ALapM/vBo5E+6OkrPXBckLMzoVqk6CmMNdP5NZABf78rf/kKUoUB1LQv7l
        sJPrwjANHrtxMumWnPi2J+Ma95992nM=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-mTHVQRXxONWDQIEBYFHjww-1; Mon, 15 Nov 2021 03:01:03 -0500
X-MC-Unique: mTHVQRXxONWDQIEBYFHjww-1
Received: by mail-pf1-f198.google.com with SMTP id c21-20020a62e815000000b004a29ebf0aa7so2627506pfi.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 00:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CT33CO1P4m9z3srlG1n5DsePRxe7FxchG1iBDIBzjEc=;
        b=aK1fDP4i7qDV4q0DAx0jel5EMpzVjdf6fWEr8tC9jF7LJd74hYGtdd07h13ViswVRv
         1/uia7vLUftmzdXezK01tKAlJSsc2RsdR21laHe5AsrCEubNFDG+CTCm6SSt7cbpaL/w
         PAFEFLtBrqF7s/ZuYDgBPaTEokyyPbyGOhNEECpXaeGyX/nNksqH5P+IP0aj95v7sqPM
         17g7OG8hwTBePFw38QVLUXxTpoSlDNz+P/H6wI63XUzN2y7pf4XOoUsLMxWvQZq2xZqK
         826n6aWP3CslVA0OH79aAT4Kdp5tN/noLTQ4Q81jwgiQBpFCyWPZ5WN0B3tVEK//7Pxs
         2QVg==
X-Gm-Message-State: AOAM531AnkMOpdgk8YXlo2CtBqXAFbYUtYOOng3hI0+lU+ghCis+Z4uh
        0juf3Tfss82dAEktkCZ8hD7HX9ygP9qVc62ZunISq1s9jm/+aImbHklil3yyp8voSwuKrU//YoA
        68mkuP7MbetEvzK1Dw5zbFlQw
X-Received: by 2002:a17:90a:e60a:: with SMTP id j10mr63679958pjy.169.1636963262738;
        Mon, 15 Nov 2021 00:01:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5fbAzVfzXaTeCmw8VY664lWE42EUqztZ2N89jbHIauCly+ZiaTzVAzB2oLqZABMH3u9HTaw==
X-Received: by 2002:a17:90a:e60a:: with SMTP id j10mr63679926pjy.169.1636963262451;
        Mon, 15 Nov 2021 00:01:02 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.89])
        by smtp.gmail.com with ESMTPSA id rj8sm2841393pjb.0.2021.11.15.00.00.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Nov 2021 00:01:01 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>, peterx@redhat.com,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH v6 09/23] mm/shmem: Allows file-back mem to be uffd wr-protected on thps
Date:   Mon, 15 Nov 2021 16:00:48 +0800
Message-Id: <20211115080048.74584-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211115075522.73795-1-peterx@redhat.com>
References: <20211115075522.73795-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't have "huge" version of pte markers, instead when necessary we split
the thp.

However split the thp is not enough, because file-backed thp is handled totally
differently comparing to anonymous thps: rather than doing a real split, the
thp pmd will simply got cleared in __split_huge_pmd_locked().

That is not enough if e.g. when there is a thp covers range [0, 2M) but we want
to wr-protect small page resides in [4K, 8K) range, because after
__split_huge_pmd() returns, there will be a none pmd, and change_pmd_range()
will just skip it right after the split.

Here we leverage the previously introduced change_pmd_prepare() macro so that
we'll populate the pmd with a pgtable page after the pmd split (in which
process the pmd will be cleared for cases like shmem).  Then change_pte_range()
will do all the rest for us by installing the uffd-wp pte marker at any none
pte that we'd like to wr-protect.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/mprotect.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index be837c4dbc64..0d4bf755cee8 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -319,8 +319,15 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 		}
 
 		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
-			if (next - addr != HPAGE_PMD_SIZE) {
+			if ((next - addr != HPAGE_PMD_SIZE) ||
+			    uffd_wp_protect_file(vma, cp_flags)) {
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
+				/*
+				 * For file-backed, the pmd could have been
+				 * cleared; make sure pmd populated if
+				 * necessary, then fall-through to pte level.
+				 */
+				change_pmd_prepare(vma, pmd, cp_flags);
 			} else {
 				int nr_ptes = change_huge_pmd(vma, pmd, addr,
 							      newprot, cp_flags);
-- 
2.32.0

