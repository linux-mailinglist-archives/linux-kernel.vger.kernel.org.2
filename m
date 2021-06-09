Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361983A0B50
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 06:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbhFIEcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 00:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbhFIEcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 00:32:12 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC95C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 21:30:04 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id w4so4720428qvr.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 21:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=+ThT1ycF8YLamnlD2Lza4I95kCWi6MvYxYZGgNS2X9s=;
        b=M4FcLOpy9iMQviGUShyo5Ubyn4BAdjZbD/36Spa6wZwN1yu5XkVBovKgUgOOm4MHYN
         +9rbHmJQ/QlxN5lmNPNE3ZqD9ob3o4BQUbbZqH27OMI+hmD7E7dxL0cQtcs4kpFSoLoI
         P7PiaxSFx4nK0py9c5yw5WAE/sM5FhuO2JorxLDfrkcnT5+c/jqm/mkAuZHeQkuoAD1X
         L6J1LLhknct1mGv8LxU8JU1rzDXQxbTSoCSRb64AvCvf5inp1NLFrttpIrJGlASZGgMZ
         OFZ9xGwdHrxIhM+v2MnAMcpfe1yTuJbdi09tFELDTC1bju9G9LfX0cO16l28YT3aqrnI
         wZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=+ThT1ycF8YLamnlD2Lza4I95kCWi6MvYxYZGgNS2X9s=;
        b=aYwpgtpw+PA86Jk8tV3O3lDle8kXNs9HJne5eAXYUpLXTf7vJ83V3OIzh3RD5TTmRR
         NnRrouFYOWfnD68vKbZ9PTdSMyrGv2vLHU//QSXi/+UauqCb171BX3PbbZ3i9vFaQGI1
         jedYa5WuR1RV3k2t2Ukdys5xHAB7/ZdTAvZ3+9Ow/2dwRJ4R/IEIA6uYVQT+7ZhlfQef
         2ktyHa7ZmfiYC9hE7Mjoo3Dymz/DmGEpw+CZLvMhfbpnEKoJv3bMPA1Ds4lNlBouy/o0
         7oa45kOcOrpNibjRatC7KwPkd5IMN4/WQZc/pfcqEJmv0P21XugkDy7q2wLBlDKmvyfw
         A2kQ==
X-Gm-Message-State: AOAM532KJ+5ECIwj8qSOVPaF161GHtGzvvs6O17meT8IXBrH4zY7Obsq
        0Dbk/QDZtag+i7r0u5Z/Vf4+ww==
X-Google-Smtp-Source: ABdhPJzQmPE98FZfl1GR4aklzUHZDiAU5rCGYrSbno/A3T1De47msweq94P8b3ysrWw+Si6IILLoOg==
X-Received: by 2002:a0c:eda5:: with SMTP id h5mr3924907qvr.26.1623213003254;
        Tue, 08 Jun 2021 21:30:03 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k124sm13126699qkc.132.2021.06.08.21.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 21:30:02 -0700 (PDT)
Date:   Tue, 8 Jun 2021 21:30:00 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/10] mm: hwpoison_user_mappings() try_to_unmap() with
 TTU_SYNC
In-Reply-To: <af88612-1473-2eaa-903-8d1a448b26@google.com>
Message-ID: <329c28ed-95df-9a2c-8893-b444d8a6d340@google.com>
References: <af88612-1473-2eaa-903-8d1a448b26@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TTU_SYNC prevents an unlikely race, when try_to_unmap() returns shortly
before the page is accounted as unmapped.  It is unlikely to coincide
with hwpoisoning, but now that we have the flag, hwpoison_user_mappings()
would do well to use it.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
Patch added since the v1 series was posted.

 mm/memory-failure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index b6806e446567..e16edefca523 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1060,7 +1060,7 @@ static int get_hwpoison_page(struct page *p, unsigned long flags,
 static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 				  int flags, struct page **hpagep)
 {
-	enum ttu_flags ttu = TTU_IGNORE_MLOCK;
+	enum ttu_flags ttu = TTU_IGNORE_MLOCK | TTU_SYNC;
 	struct address_space *mapping;
 	LIST_HEAD(tokill);
 	bool unmap_success;
-- 
2.26.2

