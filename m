Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A1B334734
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 19:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbhCJSyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 13:54:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58788 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233480AbhCJSyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 13:54:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615402444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pzZMGqMZc5zPC1EGzN2nTjjo+4+DdAetFkEenwTjWtA=;
        b=b5YK0CgWLRNuzX9fQhMkMR8VVvxlpnnjdmY1wudX7B6L3pbND0lGjakauqRcrXKKn+eeoc
        +OOqPT5Xb963Int/rgPiiaKECFpjxsa2VzR8x/YHUy4SQaIFkVdtqk70KRFgJ7BgR+hzsE
        PZ/7LQcTbaEoa68q3N5M0jZg3Sa7XUw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-OI_5eu_iP9q2JmTDUuS0oQ-1; Wed, 10 Mar 2021 13:54:02 -0500
X-MC-Unique: OI_5eu_iP9q2JmTDUuS0oQ-1
Received: by mail-qk1-f199.google.com with SMTP id h126so13514203qkd.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 10:54:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pzZMGqMZc5zPC1EGzN2nTjjo+4+DdAetFkEenwTjWtA=;
        b=TF00KoME7qAAfAl2d5ZeoDUWCVkc498HKcWDJeopB2DTUPqnB9tt9QhfkvuXilex5h
         xL92d7RbVy/yeXOwj0CJeIG6YWc3qLUHhv59DluuQqNGuzD70KFf1l7v3xJrEPsDf0UK
         HdCkztui0lO8FMbYyBtG6nsrODL4DyVpScEqUU7+d1BR5nch4a9rb0Jthmf3CEkpxOLA
         mbttBHV/0oiiJO5UvigsfNANfnPJGpsr2FImLYZNRfJe0KgptYZ1zWVaLja/phNchWua
         fPe2yJTtlMBIwgme/pGn9M91ethF/NKMZFAyRgktHNkCCsnHhLIXivgxAeFn1tTCjZe/
         rk5A==
X-Gm-Message-State: AOAM530Qbsjv5rD0bC+lpy5a/lUhq5XerOHU5MC6zL7YSg9LLRoYocPy
        BuqEVydRInk5qWj7FyOb47vJQn3pAfinv7qHda+y32YIXpGg24P1Bj8dFt16Zb/7nldIv5d5/ul
        If7Qezy1DeIS/nsU7LU0irYheFY6Tb4B76jknIL6HNUIIZmG7W2aNW76Ib2dUi0/KCczV5k/xfA
        ==
X-Received: by 2002:a0c:9cc2:: with SMTP id j2mr757157qvf.2.1615402442053;
        Wed, 10 Mar 2021 10:54:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzjMCDHSbDkzp7mfaySFzMCURsVRYA7nqf9LW48wmg8OE27/TnP4Tqly23M2PBZk9jZ8OL6A==
X-Received: by 2002:a0c:9cc2:: with SMTP id j2mr757127qvf.2.1615402441776;
        Wed, 10 Mar 2021 10:54:01 -0800 (PST)
Received: from localhost.localdomain ([142.126.89.138])
        by smtp.gmail.com with ESMTPSA id d14sm140519qkg.33.2021.03.10.10.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 10:54:01 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH] mm/hugetlb: Fix build with !ARCH_WANT_HUGE_PMD_SHARE
Date:   Wed, 10 Mar 2021 13:53:59 -0500
Message-Id: <20210310185359.88297-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

want_pmd_share() is undefined with !ARCH_WANT_HUGE_PMD_SHARE since it's put
by accident into a "#ifdef ARCH_WANT_HUGE_PMD_SHARE" block.  Moving it out
won't work either since vma_shareable() is only defined within the block.
Define it for !ARCH_WANT_HUGE_PMD_SHARE instead.

Fixes: 5b109cc1cdcc ("hugetlb/userfaultfd: forbid huge pmd sharing when uffd enabled")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d58f1456fe27..8dda7e034477 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5469,9 +5469,6 @@ static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
 
 bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
 {
-#ifndef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
-	return false;
-#endif
 #ifdef CONFIG_USERFAULTFD
 	if (uffd_disable_huge_pmd_share(vma))
 		return false;
@@ -5616,6 +5613,11 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 				unsigned long *start, unsigned long *end)
 {
 }
+
+bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
+{
+	return false;
+}
 #endif /* CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
 
 #ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
-- 
2.26.2

