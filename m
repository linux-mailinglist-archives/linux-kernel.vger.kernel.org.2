Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC38344DC0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 18:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCVRvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 13:51:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47328 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230071AbhCVRvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616435497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3sv2VL5jzl43MssQXHzJqdRATLzbsdNryCBU0FqXXE4=;
        b=Zf4QmhhzWWp4/+b/ljUxT+DbqQQVD1os0rUTmCnsJpSuDyFTSaICwZrZ12CZFE9IVVWEqH
        AP/OIp6kwsvU8rg5Lus2HAiqiLi4aZs6M8EuHkk923TqDPeNiqYVrrN+roUM3oXaAUEmyU
        T+L/9gzbufv/JpoBM0HYxRGUw6Y+O2g=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-qhBfNzZ5MdGvUOFh21cAqg-1; Mon, 22 Mar 2021 13:51:35 -0400
X-MC-Unique: qhBfNzZ5MdGvUOFh21cAqg-1
Received: by mail-qt1-f200.google.com with SMTP id 11so13052865qtz.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 10:51:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3sv2VL5jzl43MssQXHzJqdRATLzbsdNryCBU0FqXXE4=;
        b=fHWMVo5hOqKfS6QpA9fA/k0VJPjFApEcf3JvEPEXz2lMw1Dowo9MvTcKx9i1uWMfWD
         KSlvn5Z8x5vM5epypRGoRCneAb8m+fauVwuBt2lNFYskGSUPuhrvfxoz6K/BIX8KClc5
         CWUvwHiNBChAWsn53faJGjRkmv+F2T9J4EXXOQlN0ywvUeyvgpqbDFHwL2M1BWi88DEI
         IXNmZPbl+1eoTi68NmfsQ47RasuLK0uSWQv7FNpLY6C3G4848QiUn+LgPVrsWrsLQELr
         u75WNmAWupqMG0q+O1NDf+yWJ5Wg+YBNFg3t8oxe8g6vcpnHj5FWlGiTKCaIL+2IUckg
         O6VA==
X-Gm-Message-State: AOAM532ZOAQNM850TmOIY9SvfyooalqW9jlNcXKDIkogDFPF7Qy+ZL/j
        TiQzNdFnHZYF1Fffke/IUmqHNHeo00xU+LJDRoENlLkgEF/fbzkkWw6y8BiqSV0F6MYqtw15AL6
        uFqnfQDFZ8FBhEC5ev7TLxkMp
X-Received: by 2002:a05:620a:1292:: with SMTP id w18mr1184697qki.400.1616435495384;
        Mon, 22 Mar 2021 10:51:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuB+/kei1bAz1c4Jk2mymH+0CIIyij9CrmBXu26SxRX4WsPXOOt7e4pDsLHAq0e7+JMC9sPw==
X-Received: by 2002:a05:620a:1292:: with SMTP id w18mr1184675qki.400.1616435495103;
        Mon, 22 Mar 2021 10:51:35 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id e14sm11272584qka.56.2021.03.22.10.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 10:51:34 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH] userfaultfd/hugetlbfs: Fix minor fault page leak
Date:   Mon, 22 Mar 2021 13:51:32 -0400
Message-Id: <20210322175132.36659-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When uffd-minor enabled, we need to put the page cache before handling the
userfault in hugetlb_no_page(), otherwise the page refcount got leaked.

This can be reproduced by running userfaultfd selftest with hugetlb_shared
mode, then cat /proc/meminfo.

Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: f2bf15fb0969 ("userfaultfd: add minor fault registration mode")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 408dbc08298a..56b78a206913 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4449,6 +4449,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		/* Check for page in userfault range. */
 		if (userfaultfd_minor(vma)) {
 			unlock_page(page);
+			put_page(page);
 			ret = hugetlb_handle_userfault(vma, mapping, idx,
 						       flags, haddr,
 						       VM_UFFD_MINOR);
-- 
2.26.2

