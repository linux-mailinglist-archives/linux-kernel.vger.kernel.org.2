Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90E5333644
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 08:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhCJHSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 02:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhCJHSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 02:18:44 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71FEC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 23:18:44 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id mz6-20020a17090b3786b02900c16cb41d63so6985999pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 23:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xw02Fd5jGslyp8wecok2dmw5uLswm///UDbdZiwlo7s=;
        b=LrLpUQyTo0H82ehHAEU6j3y40joBErwOje4Q85Yka8u+jfNdKNJYtj9cRiu8kebTgT
         +Zm1JbSJasAufPxNLuAil8WE1yLolVkj7Kpra4qK+2Hoz5xu3GyjtE1eNsZwU6Z+V2qi
         Q9eiLUyq2e3xYJx6O04usv2M8UZaFcR3JER4w+mXbujj/EKFlyIRvNBzGhnxzdNQKsjM
         UkT91FGT91iwWIbkyTvkSuCtjGhT5w5llniInBqhmfDr13c+5brdvarglN5TWIsy74xH
         Oe57BQmf3BBgXSVspNpd5Ho+b1/FKd92HfLLmesvQGulrB82wdTpGheF9WnII4Tnq4B8
         jYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xw02Fd5jGslyp8wecok2dmw5uLswm///UDbdZiwlo7s=;
        b=tsQNgvv/fYBXRQoLaqm+SHaDdQVgZInDIrfRcBqUdUJ2p94juA2LYcYJxrA+NkIxjg
         rAFZZp4w1LSWhlwFyjVxSttQgnO0AIj3TZslVq0vXJKjsnwGDH8LMoqG+SoxSCiXN0Vf
         iXVkZv2LO8KOBSFFp8FDeHcX/BGR0U6Bqq+sCtJePDvbjk9xnaFvyvnHkR9ZUZQqWR00
         gNW9cq77gAJVkjBupQjg1IkTfO1JVuYTgQzg1O34YxvLfIORJh1medIiynwMpstw4DRm
         0NFfNcfQG5NUIuHh3uRQCgl+asfS4KwGls9fIaNYskmJkDGuK5IN9FvBTC/4CB50C2oD
         ynkQ==
X-Gm-Message-State: AOAM533ZoTga09I4VziKspdu+ftLE0LakQnave6d8m7t7LgmVWq2qpJN
        3vnpmc84cA28USiDh00y2olPAQ==
X-Google-Smtp-Source: ABdhPJx8yv56LOceP2OaEE0AVt0+YHszv5GN1MKsYzSi39Lovj89hxAlhCMKHBmd6niFYcXybxIzIw==
X-Received: by 2002:a17:90a:e642:: with SMTP id ep2mr2178320pjb.62.1615360724393;
        Tue, 09 Mar 2021 23:18:44 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id h15sm2828868pfo.20.2021.03.09.23.18.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Mar 2021 23:18:44 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     will@kernel.org, akpm@linux-foundation.org, david@redhat.com,
        bodeddub@amazon.com, osalvador@suse.de, mike.kravetz@oracle.com,
        rientjes@google.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 1/3] mm: bootmem_info: mark register_page_bootmem_info_section __init
Date:   Wed, 10 Mar 2021 15:15:33 +0800
Message-Id: <20210310071535.35245-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210310071535.35245-1-songmuchun@bytedance.com>
References: <20210310071535.35245-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register_page_bootmem_info_section() is only called from __init
functions, so mark it __init as well.

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

