Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F266240EAD1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 21:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhIPTbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 15:31:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53562 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231220AbhIPTbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 15:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631820619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5D5yhincqgbc1iu/FJNR6o/naKwsnQ2+Q1T7O43eoLs=;
        b=QS+4yrLA/FfLz1HwuovM07Dbb5uscNuZf4k96XKZ2sajrje0b1L51KzjAMwNvmoNhDqrqS
        mF14+Vinnn5J1exVTCAir9uuEmLin7mqAf/lIqXdoQ1/Iae1FS2QPDVxmg29UUAVrIHqh7
        6morrVi3/9vgSFsIGR5okdM2A6YrEEE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-osJFb6evMxi80noo0saNYg-1; Thu, 16 Sep 2021 15:30:18 -0400
X-MC-Unique: osJFb6evMxi80noo0saNYg-1
Received: by mail-qk1-f199.google.com with SMTP id w2-20020a3794020000b02903b54f40b442so46690518qkd.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 12:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5D5yhincqgbc1iu/FJNR6o/naKwsnQ2+Q1T7O43eoLs=;
        b=ZmMLGZ095fPm/3BZZs5rb8syyI6a9mrWeJpG5NCQ337nQXNKlVY1A09s6qZVu9TCX4
         5LE69PmxWSvqVGXgFLaTLqVhXzZLOrlMiCvdYeSt+z0Ab8RHhoF5G7FarMcs23ucCErW
         aPX2w/XsmHNkbLZSeWp1yfplPexiPJi9Lj3FEKnAZnjliaja0G6LCpdJThqIM0UFfrXj
         4o9K8WmzCtvbIBTpVUdyaCnvnoHoDAkLFN98oJBBrWo6zngCO+Hl+cvSYCaXdmGh+MRF
         dJjYTMYQ0A2HtzzKGQ69/YS9NGAoHYrPFEz6yKCifFIjVGMaKKFmR6SgwLERT7xJBg8B
         UMbw==
X-Gm-Message-State: AOAM533XBaaI3PGClDPoLQ9vStb/JNuNHOXukcG17Ajv6A/yTm4drndn
        w6j6zIwMBNY4YEUHxPl/zVcgDYNqxvEHuP5dvNuq3Nw6A9yp2ruhij7jkimlSc2nKBUWoN7fFwu
        uAyEOxk0nutGKRSJA2Zr96BYAuctmiVc3IXOfoEk8hYbXK04rUw9glUrKrThhX3cQoIWXEmIAtQ
        ==
X-Received: by 2002:a0c:b293:: with SMTP id r19mr6970246qve.19.1631820617017;
        Thu, 16 Sep 2021 12:30:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqeLKuf5ivkxMjhQDe53fj1yQG4lPZk//lUhSnJ6TsUY8EFOsN6hwpooVF5qeMEMdERo/8Ew==
X-Received: by 2002:a0c:b293:: with SMTP id r19mr6970214qve.19.1631820616746;
        Thu, 16 Sep 2021 12:30:16 -0700 (PDT)
Received: from t490s.redhat.com ([2607:fea8:56a2:9100::d35a])
        by smtp.gmail.com with ESMTPSA id 90sm2731123qte.89.2021.09.16.12.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 12:30:16 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] mm/memcg: Drop swp_entry_t* in mc_handle_file_pte()
Date:   Thu, 16 Sep 2021 15:30:14 -0400
Message-Id: <20210916193014.80129-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the rework of f5df8635c5a3 ("mm: use find_get_incore_page in memcontrol",
2020-10-13) it's unused.

Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memcontrol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b762215d73eb..12fa08e216a6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5555,7 +5555,7 @@ static struct page *mc_handle_swap_pte(struct vm_area_struct *vma,
 #endif
 
 static struct page *mc_handle_file_pte(struct vm_area_struct *vma,
-			unsigned long addr, pte_t ptent, swp_entry_t *entry)
+			unsigned long addr, pte_t ptent)
 {
 	if (!vma->vm_file) /* anonymous vma */
 		return NULL;
@@ -5728,7 +5728,7 @@ static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
 	else if (is_swap_pte(ptent))
 		page = mc_handle_swap_pte(vma, ptent, &ent);
 	else if (pte_none(ptent))
-		page = mc_handle_file_pte(vma, addr, ptent, &ent);
+		page = mc_handle_file_pte(vma, addr, ptent);
 
 	if (!page && !ent.val)
 		return ret;
-- 
2.31.1

