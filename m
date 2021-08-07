Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6723E32F4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 05:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhHGD0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 23:26:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42940 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230337AbhHGDZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 23:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628306729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L/1RwXysWQ1sqglJySJDDwULyThf17AJDB9rf0b/YTw=;
        b=H8mT2rM4KxunE/pA1SzaMGRGeVFYZyOj8Ukio/JJPXS8MzzWTrfr/ManxJWgjp1/vPON3N
        nUuiJjKgvGNAKQ5M5XFbN3b+0j1fhzrg5jEwadhzcp6eLMayBjWyHo/YZQa7wr2oV5YkiW
        GxXHG41NjMeHpadhuo31KTYI13TY/Ow=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-kdMD-nKkM36s1vFp-wKEow-1; Fri, 06 Aug 2021 23:25:28 -0400
X-MC-Unique: kdMD-nKkM36s1vFp-wKEow-1
Received: by mail-qk1-f200.google.com with SMTP id x12-20020a05620a14acb02903b8f9d28c19so7688615qkj.23
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 20:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L/1RwXysWQ1sqglJySJDDwULyThf17AJDB9rf0b/YTw=;
        b=ZFFej4KAcZZHB/68XsU5b167saFezMWhoWHdLeKCjjUX56+MccSW8/OiAtHsQwZuHd
         VWzCCr02s7qeevtggxSBiRr6phi3V3ZbXLHI6fZZh+IClzi2yO23E7efuAwG/ZjDmbIl
         g74rSjHBb8x9paz5xJqiz78tGjAyXlW2Iz9nMn7TgUcD/iqvdtu4LrzFQFeZ8ctuPtPg
         p66Z2wlzoDxpDzGNQEOsU8a0XQuTp7Ee/+RHEZwysyjTcsO8S2bRNfBdrw89BahkXwit
         Lf3O+LaD74Pq1OzbngpfjrcwfJARveclLZJlno94bEC/Fhx7166ZsLOHZD4edDDqJGlx
         atww==
X-Gm-Message-State: AOAM532/41Qi8zlp0hN8z0vrScmRfhoy2jq7TquLttqz6TizZFkD2kAR
        IZeXsZJXPr7JG9VQr42vM4njPSZu2hmGL/JR9uZVTEx+Z802u6sAN1gYA9JKD4rrP3eSIpMZBhh
        qmu+5iw9UGCuJscX+I/VVP/Sxw36O7XrFhzbfUKxKzIUpy7AkurVlDZiGTvoPXF+VtIgoXpi0eA
        ==
X-Received: by 2002:ac8:7292:: with SMTP id v18mr11780652qto.301.1628306727561;
        Fri, 06 Aug 2021 20:25:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyV9N7QxwGCkDas76nsjjYHmx//9jTApLA8tn9+Vvt7uhtdjfAKM+aH0uMld3+bwGot4UtMDA==
X-Received: by 2002:ac8:7292:: with SMTP id v18mr11780632qto.301.1628306727286;
        Fri, 06 Aug 2021 20:25:27 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-92-76-70-75-133.dsl.bell.ca. [76.70.75.133])
        by smtp.gmail.com with ESMTPSA id a5sm5514875qkk.92.2021.08.06.20.25.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Aug 2021 20:25:26 -0700 (PDT)
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
Subject: [PATCH RFC 2/4] mm: Check against orig_pte for finish_fault()
Date:   Fri,  6 Aug 2021 23:25:19 -0400
Message-Id: <20210807032521.7591-3-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210807032521.7591-1-peterx@redhat.com>
References: <20210807032521.7591-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to check against none pte and in those cases orig_pte should always be
none pte anyway.

This change prepares us to be able to call do_fault() on !none ptes.  For
example, we should allow that to happen for pte marker that has PAGEOUT set.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 25fc46e87214..7288f585544a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4047,7 +4047,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 				      vmf->address, &vmf->ptl);
 	ret = 0;
 	/* Re-check under ptl */
-	if (likely(pte_none(*vmf->pte)))
+	if (likely(pte_same(*vmf->pte, vmf->orig_pte)))
 		do_set_pte(vmf, page, vmf->address);
 	else
 		ret = VM_FAULT_NOPAGE;
-- 
2.32.0

