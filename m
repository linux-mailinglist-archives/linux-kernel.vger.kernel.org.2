Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A202644FF8F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 08:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236415AbhKOH7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 02:59:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:49014 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229963AbhKOH7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 02:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636962963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oiRP6M0XDz2JYaGWMJAJYTL9K9of+5C/YsBL0nPA2ZA=;
        b=IhguAwvMbts4pFhE3gPLygpTS7tqs32m4tAPIlxj2mIpKCmcwXFElAKkl24T2KZamG3SYq
        mZeJKmvWhk05+mP8cBgE5MvtKuAM9LUrjrKf3+9XHKMK544A96aMkN6NphZCLFsniFGItA
        v28CTFmm+e7i7QZpZd86VozorpduB5s=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-rmSb7d_RNKuUboenfHlumw-1; Mon, 15 Nov 2021 02:56:01 -0500
X-MC-Unique: rmSb7d_RNKuUboenfHlumw-1
Received: by mail-pg1-f197.google.com with SMTP id f7-20020a63f107000000b002db96febb74so8783895pgi.7
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 23:56:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oiRP6M0XDz2JYaGWMJAJYTL9K9of+5C/YsBL0nPA2ZA=;
        b=MBNJdHXkPb1vWGiL1A8QBX8126k48AlrSg+KRJM4ezm4AQRoyNz2QKxfStcqHQmcCx
         PtTLbsGbeOPgQ8m6NwXHc24MiT6/+sGuZVTnYyjBrFlrgvG7b21fOXLFYHJdtdIxxqhY
         rfCS1DqT/KvzRxi/fnPRdCUs4U1SevXgF9pWUZFVIblIAxNWbJq/ZaMN7A/gZPghUX/o
         H6H2HeIjbBkNMccufovIAfPGsr/LQut6WfoX70atSUbQN4MdpPtbj9G+5pqgmnaFZkCl
         HJFHmo9kXYyE2CAtoc5r0nvlZXVHHuX3ieuYkFWGM2SdW9spqXQyXITfzOt/aDCT92Yi
         6uzw==
X-Gm-Message-State: AOAM5308rzEt+Jl03uJUINOm6cUtHMmdSfzKBsbEGrVxNsAsutkDzZjU
        pOY6G+10Rmqigktvp9UQeTJes0uOMIzYE9BmSOUsSitl45hZVm3J0OGTEL3oMr3qpMn/ASWcOww
        /WPFEevJHHQU/X3bfHxjEOhfg
X-Received: by 2002:a17:90a:df97:: with SMTP id p23mr44899741pjv.3.1636962960895;
        Sun, 14 Nov 2021 23:56:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw80QtT18dNY1cg9toIlmKOYG28dAqiAY105pUOfD9FUEbM6Y8GthQX1coYmOY4ZZLz+1zQRg==
X-Received: by 2002:a17:90a:df97:: with SMTP id p23mr44899715pjv.3.1636962960688;
        Sun, 14 Nov 2021 23:56:00 -0800 (PST)
Received: from localhost.localdomain ([191.101.132.223])
        by smtp.gmail.com with ESMTPSA id e10sm15792796pfv.140.2021.11.14.23.55.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Nov 2021 23:56:00 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Alistair Popple <apopple@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v6 03/23] mm: Check against orig_pte for finish_fault()
Date:   Mon, 15 Nov 2021 15:55:02 +0800
Message-Id: <20211115075522.73795-4-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211115075522.73795-1-peterx@redhat.com>
References: <20211115075522.73795-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to check against none pte and in those cases orig_pte should always be
none pte anyway.

This change prepares us to be able to call do_fault() on !none ptes.  For
example, we should allow that to happen for pte marker so that we can restore
information out of the pte markers.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 04662b010005..d5966d9e24c3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4052,7 +4052,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
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

