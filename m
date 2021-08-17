Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9376E3EE580
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 06:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhHQEXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 00:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhHQEXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 00:23:03 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2D8C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 21:22:31 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id f3so23336104plg.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 21:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bzoVjzOawBk1F/zYmCYxdvVOuCjAhiYRvp0jl0y4Tgo=;
        b=fIHeA+rRJ5SSvxd3g8oZwgxkZQZdVOd03C+D2S2uKOx54FsPEkyhQzqNXpM9tTR8Ni
         QI1Bla1Wb1TS8rkK9Fb5uCIZNXR1KtgqB5OsJMf8WvjumIBux2yHzExwpXfCJFquhBKw
         rIBuoH6h/jInuko+SXY8lRsGVpw8CutrGj82zcnXEbX1kYsnR9l8u7micqIyo2e3Qzhg
         ToAfrkLPPD46oKXjXMA3EUgXE4VFYcgJarRNcAoCiNISGrHm334NscFAQDntr/3zvX2i
         AuucSSLyiGYAA/bIoTaLJRAUDh58x/cOvXMFpMHbG4d0p+6K1AnLHYwKW7x8LVVEjD81
         c2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bzoVjzOawBk1F/zYmCYxdvVOuCjAhiYRvp0jl0y4Tgo=;
        b=YrW1TnnBX6QuGNOZNoZaWWzSjx46W3MhDkFo37qHaAWfy61MFrIHRC9ra7u/nF4CmN
         bdrm2fUwH0iW2cV/4E7LdiuN5x+vUF9b7pkO3EBR1NKn1oDjQMQddgC8NOXEn2alDuzm
         W4MgpSLnvkCNvEfpT8b7qQrQPjI7gxCi8+xSmD7eryyZZf7dldOu04cjEXu0p87MMJJj
         2wc74BWxhWyXTDj6e8YphDKqmuN0VMiqHILCoTLnR05bVqvFHfSno61MBgVlcTpSRfrg
         p4Xyxm2n1eNRJsFHNW6In6KHZvd9WHI9ijUyQln+CsQ+X+ELI41ef2clrmndTMegw5Tt
         FqFA==
X-Gm-Message-State: AOAM530NtmNwEpFAmzgiQZG0xEi3osBcNp3FghZc8G++i/H7a3haZgGC
        AK0qseZQiWEmRpoBlTNVIemdbBDHCNqCjw==
X-Google-Smtp-Source: ABdhPJwlNoPNNBpmfplYC+rsV3fV9s6i9DjK5tCgRoy4qlAGsj31yRDXWcuFTUGj898lGj/YqTIpjg==
X-Received: by 2002:a17:90a:c20d:: with SMTP id e13mr1558322pjt.200.1629174150788;
        Mon, 16 Aug 2021 21:22:30 -0700 (PDT)
Received: from Smcdef-MBP.lan.org ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id z13sm600097pjd.44.2021.08.16.21.22.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Aug 2021 21:22:30 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, osalvador@suse.de, david@redhat.com,
        mhocko@suse.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: bootmem_info: mark __init on register_page_bootmem_info_section
Date:   Tue, 17 Aug 2021 12:22:21 +0800
Message-Id: <20210817042221.77172-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register_page_bootmem_info_section() is only called from __init
functions, so mark __init on it as well.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/bootmem_info.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
index 5b152dba7344..f03f42f426f6 100644
--- a/mm/bootmem_info.c
+++ b/mm/bootmem_info.c
@@ -39,7 +39,7 @@ void put_page_bootmem(struct page *page)
 }
 
 #ifndef CONFIG_SPARSEMEM_VMEMMAP
-static void register_page_bootmem_info_section(unsigned long start_pfn)
+static void __init register_page_bootmem_info_section(unsigned long start_pfn)
 {
 	unsigned long mapsize, section_nr, i;
 	struct mem_section *ms;
@@ -74,7 +74,7 @@ static void register_page_bootmem_info_section(unsigned long start_pfn)
 
 }
 #else /* CONFIG_SPARSEMEM_VMEMMAP */
-static void register_page_bootmem_info_section(unsigned long start_pfn)
+static void __init register_page_bootmem_info_section(unsigned long start_pfn)
 {
 	unsigned long mapsize, section_nr, i;
 	struct mem_section *ms;
-- 
2.11.0

