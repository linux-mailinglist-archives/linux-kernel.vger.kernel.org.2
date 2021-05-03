Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5ED13723B1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 01:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhECXo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 19:44:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27456 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229928AbhECXo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 19:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620085444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ABt25pzgCO1gaqcFMnixhdZW8Kc2SCW/u3hnQ6DkL1o=;
        b=Ldu6//WPEoJdrO7Ox4DTsFy6xCFhqB7vgCAthUGtiKPIAAEE5ZuNkEqBXUmxwMnjC9b+Jj
        74FNyIWS7/70YqaBELKRMJjcJAkK2PhBj2Wczw78okOWewCbmciMLaCrpTPkLeQFBZCdg/
        CpNT1gHITiOZXGBaFiO4Y50xzhkoog4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-0wbBq4tWMUSg6DetY5TbEQ-1; Mon, 03 May 2021 19:44:03 -0400
X-MC-Unique: 0wbBq4tWMUSg6DetY5TbEQ-1
Received: by mail-qv1-f70.google.com with SMTP id v3-20020a0ca3830000b02901c56555f64bso2048196qvv.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 16:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ABt25pzgCO1gaqcFMnixhdZW8Kc2SCW/u3hnQ6DkL1o=;
        b=UvlZib3cXskV23umpSQ2Po4pq5x8Ve5BkCiDe7+QZKWD8k5S7t37EvzKZKtAXGzAvC
         DdImQY0fK3ZAgNLuXqSysqQQfh78fdaa9gh102gboo19lTSVZsORFAqAK1M/hxAs4KbH
         8/TvDy7T5W3OyIC66MQ8jJl3X0nhjkNldBpsV/WoNMc0WyLPe/Wm+mF3BonWGmUXe1NX
         IqcAd8RLC+ov90sYiBNIOzwS7JGJ2atwNujc4fl9ka+Ynp6zEP0jxJmte5OZIEB+lmg2
         a8oj986w+Be7n0m4NrRcndcZUPyikV0+15l96/tx9zqx2EiuMVYVDB85Uv4mtjaAWu0W
         oPdA==
X-Gm-Message-State: AOAM531JcJPykfAi95HC6JOxU9IG4T2LFYTwY9EP9055ScOMX6UQDG+j
        ++2aY8+qs4baXd4jQC07+eE4XQ1El/FrGu1Di3E7HNArmWuJwY3D1zc30GNV6KUJq39+UYTj6Wi
        S2BiKEGv8f+Po1B2InazzuUWE
X-Received: by 2002:a05:620a:799:: with SMTP id 25mr12553401qka.188.1620085442710;
        Mon, 03 May 2021 16:44:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvHpI4ndR9mV1KvzNSVtc1wN86uhUFbQX4EF4jyJbcv4dd7JFS0AMYcw+HYYlme5jwSVS1Rg==
X-Received: by 2002:a05:620a:799:: with SMTP id 25mr12553383qka.188.1620085442514;
        Mon, 03 May 2021 16:44:02 -0700 (PDT)
Received: from t490s.redhat.com (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id 189sm7126903qkh.99.2021.05.03.16.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 16:44:01 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>, stable@vger.kernel.org
Subject: [PATCH v2 2/2] mm/hugetlb: Fix cow where page writtable in child
Date:   Mon,  3 May 2021 19:43:56 -0400
Message-Id: <20210503234356.9097-3-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503234356.9097-1-peterx@redhat.com>
References: <20210503234356.9097-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When rework early cow of pinned hugetlb pages, we moved huge_ptep_get() upper
but overlooked a side effect that the huge_ptep_get() will fetch the pte after
wr-protection.  After moving it upwards, we need explicit wr-protect of child
pte or we will keep the write bit set in the child process, which could cause
data corrution where the child can write to the original page directly.

This issue can also be exposed by "memfd_test hugetlbfs" kselftest.

Cc: stable@vger.kernel.org
Fixes: 4eae4efa2c299 ("hugetlb: do early cow when page pinned on src mm")
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index aab3a33214d10..72544ebb24f0e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4076,6 +4076,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				 * See Documentation/vm/mmu_notifier.rst
 				 */
 				huge_ptep_set_wrprotect(src, addr, src_pte);
+				entry = huge_pte_wrprotect(entry);
 			}
 
 			page_dup_rmap(ptepage, true);
-- 
2.31.1

