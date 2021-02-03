Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6184C30E4B6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 22:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhBCVK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 16:10:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38503 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232287AbhBCVKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 16:10:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612386521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=anQ4NxVMrC5prvoBF/9r6AhuqrJJE/i32bJ7Mv18iJk=;
        b=VX76uYnqTVZewH0APGN8SZPa0lgTnacobBhMoDrrGkq4B4FBAu/WcBLwK5QmscEWIk9dFP
        TF/bZwkPHr2yPc0KGoLZ6tqyCOYp8fneiQqTGZ97hrct/I+nAycfu4zql2Jm4Wu9weIMKf
        UzlB/goQsj1IOYgm8a49o/MGKB+eeAo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558--d1VYdAUPlGTq8MkGPVFow-1; Wed, 03 Feb 2021 16:08:39 -0500
X-MC-Unique: -d1VYdAUPlGTq8MkGPVFow-1
Received: by mail-qk1-f199.google.com with SMTP id f16so655581qkk.20
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 13:08:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=anQ4NxVMrC5prvoBF/9r6AhuqrJJE/i32bJ7Mv18iJk=;
        b=dTY3TPkXclVbC+nh9vMUK44ijJsj5CddT6nok9WMVfo0Ux9QuweyZW7VaINiXI3UeQ
         /mH2WJx0JiOeLhkCUPODuC1zYAXRW8iAPzvRBj1phYpaOgGd4vCYJeELnL2Pe8nUphri
         ia+U39YDaYTJCWCTKxK921bkAVvj479Lh+gJkuPs8thXpPnPn1hLP5zLpgabikoCbWrG
         CKB0cl1BX0z6mBmSmjpMOH4VTbrjT/IhfFI7mzUpIsoxdzvj/CksH51c/pEzQk1WdkNA
         ZH4slJQnUWpgCcf1XaqQpNQWAiIPzZ7IHEZYhl5SLTLVLl+JtEzlxPFGcaZ1ohze+O93
         L2MA==
X-Gm-Message-State: AOAM530xnB3/nXCQOSPvtSfCDNK9NQa/EgmtMwE+P2h7mNow67nRIagQ
        Ji4Z4O6Herjk066VDS/BK28ktlQaHgllBjauNhwLUWSMODjatozzn354dsuvwK1WR7MmvegwYpE
        Kl4RBNKQCZYTCDkUWh148Vnq8bt9rrACDEHBecvQ9vk4qS98vQs7fKfqkJNg4Iyu5b9mpkkvvKw
        ==
X-Received: by 2002:a37:2784:: with SMTP id n126mr4598390qkn.328.1612386519258;
        Wed, 03 Feb 2021 13:08:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz9Tlp/gYAwyauborxxPzXq74J5tG7yADTxCpGSxaHSHAC9pDiZhS+5nbNdTuqIMFlTfXHzVg==
X-Received: by 2002:a37:2784:: with SMTP id n126mr4598351qkn.328.1612386518990;
        Wed, 03 Feb 2021 13:08:38 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id t6sm2507659qti.2.2021.02.03.13.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 13:08:38 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Wei Zhang <wzam@amazon.com>, Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Gal Pressman <galpress@amazon.com>, peterx@redhat.com,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>,
        David Gibson <david@gibson.dropbear.id.au>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/4] hugetlg: Break earlier in add_reservation_in_range() when we can
Date:   Wed,  3 Feb 2021 16:08:30 -0500
Message-Id: <20210203210832.113685-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210203210832.113685-1-peterx@redhat.com>
References: <20210203210832.113685-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the regions maintained in hugetlb reserved map is inclusive on "from" but
exclusive on "to".  We can break earlier even if rg->from==t because it already
means no possible intersection.

This does not need a Fixes in all cases because when it happens (rg->from==t)
we'll not break out of the loop while we should, however the next thing we'd do
is still add the last file_region we'd need and quit the loop in the next
round.  So this change is not a bugfix (since the old code should still run
okay iiuc), but we'd better still touch it up to make it logically sane.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d2859c2aecc9..9e6ea96bf33b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -377,7 +377,7 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
 		/* When we find a region that starts beyond our range, we've
 		 * finished.
 		 */
-		if (rg->from > t)
+		if (rg->from >= t)
 			break;
 
 		/* Add an entry for last_accounted_offset -> rg->from, and
-- 
2.26.2

