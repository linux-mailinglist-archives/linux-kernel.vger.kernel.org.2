Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788A140FE21
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 18:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243713AbhIQQt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 12:49:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23041 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240357AbhIQQt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 12:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631897284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4hCdvDjRviIL22W5JADBBQycRMaHOvY6mSdPWhIlWZU=;
        b=POn1ZdrGPG7Z8Vpz0lCZHtQk9hucAStjJ20CBEqYJvtQDIDcPjp9iRr4y3C7goQ7+F+8dT
        MMHcQkh1owa48E9NNYRMqDefEH5tAv3gza0N3TxbUGoeVnrUnn4CMAZhBku2NNjiVggjj2
        gXyRH92TQlvocUuZkBHUZTXRvc9OKL0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-NBh4q3ElP-2s1D3fuCa7CA-1; Fri, 17 Sep 2021 12:48:03 -0400
X-MC-Unique: NBh4q3ElP-2s1D3fuCa7CA-1
Received: by mail-qv1-f69.google.com with SMTP id d2-20020a0caa02000000b003784ba308f1so92319639qvb.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 09:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4hCdvDjRviIL22W5JADBBQycRMaHOvY6mSdPWhIlWZU=;
        b=5bUJ+oZgDYb9RIpIepZZoItZEJoE0ZlPjcTvgrhCq9bf+xs+j+RZEiwphuxN+gkP4U
         T0ZuLEbtOfHk85XgZI8EuboinzrnV1MpJuItfFcpmzTZyY2PBCOCxKRuC5AJJ9HkVGr0
         oKghfhzDHG2T57dHy1YMkt2o4M/E0YRDSl3cvSPzbaoP2Pi31T+sb/XHEI7Gm6of7/s7
         MDy5TDEUlGso5JUV4+kp4M1j6i+yJq9Bek38qBdpkpx5eVpVdrG2tsZKHNKEh2KXtvLh
         KIxc2Ni/FeYNVpkh6BlSj99W9PWjsTLlRyA/kOh9N+Uv2eM+bu5gfbfakwrVoCM5rBDt
         egQQ==
X-Gm-Message-State: AOAM530hwmwTXkk2vrKC92hC2mqmlcM8VtzzTTcoyFWiVM+ZZQw4sp+o
        +vBTTiu4lvvj5nGBSNqcnkOTCUvJCaCFpWx5jz1DWVvMiYn1A0pNljfG7/aITUJmd7SFjdAWBvt
        U+cFd+IYp6TAdW8ih7QD1Ydsf
X-Received: by 2002:aed:3004:: with SMTP id 4mr11017155qte.407.1631897282482;
        Fri, 17 Sep 2021 09:48:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZWVxwXPHBVDYEfR49AslQcsKewHkeBvsRTypxwBGT/QQhAZPTJ0bzyrPxFClD91GIRnLm8A==
X-Received: by 2002:aed:3004:: with SMTP id 4mr11017137qte.407.1631897282257;
        Fri, 17 Sep 2021 09:48:02 -0700 (PDT)
Received: from t490s.phub.net.cable.rogers.com ([2607:fea8:56a2:9100::d35a])
        by smtp.gmail.com with ESMTPSA id t26sm4898057qkm.0.2021.09.17.09.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 09:48:01 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 2/3] mm/smaps: Use vma->vm_pgoff directly when counting partial swap
Date:   Fri, 17 Sep 2021 12:47:55 -0400
Message-Id: <20210917164756.8586-3-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210917164756.8586-1-peterx@redhat.com>
References: <20210917164756.8586-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it's trying to cover the whole vma anyways, use direct vm_pgoff value and
vma_pages() rather than linear_page_index.

Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Hugh Dickins <hughd@google.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/shmem.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 96ccf6e941aa..d2620db8c938 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -856,9 +856,8 @@ unsigned long shmem_swap_usage(struct vm_area_struct *vma)
 		return swapped << PAGE_SHIFT;
 
 	/* Here comes the more involved part */
-	return shmem_partial_swap_usage(mapping,
-			linear_page_index(vma, vma->vm_start),
-			linear_page_index(vma, vma->vm_end));
+	return shmem_partial_swap_usage(mapping, vma->vm_pgoff,
+					vma->vm_pgoff + vma_pages(vma));
 }
 
 /*
-- 
2.31.1

