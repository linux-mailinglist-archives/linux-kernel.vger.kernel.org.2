Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74E731F7C7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 11:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhBSK6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 05:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhBSKyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:54:31 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363DBC0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 02:53:43 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id d2so3925823pjs.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 02:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yUS9qNpkZbJSnIup5wcCJPaYw6pSjle5WwxW0514c70=;
        b=lwq4w0mNryxcojF1AHwzPzs/dz5mdKgGkbf7trkVA1vm92+chl3bthuADEito25Ba3
         y6A3UHQmXzxnCiLm4Dms8CVG1fD4zTmnVnTFkMsV0Ibon8eCOz+WrM5bdJg++DygMUv2
         WIuEl4P59gqZ5+K/Lyw80O9nhHivuU14jAec6CTD480EPu/muFtYKuZ2yXSFDf1N0hE7
         Hum2QFGypeRwjrcnvPe6fsu3EI8e3/D9k4cle1OfWr3wrJx+iISqtj/RdAbeao7eZD+v
         tIB5iU3v/K1FoNAWfKzPx5EPZYVxzhoi0oFXJTw/xO7VcBDn9r2wgeqrqDACsluSwoTc
         V2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yUS9qNpkZbJSnIup5wcCJPaYw6pSjle5WwxW0514c70=;
        b=Mf9ltCbcDxMURRqbHGs6NG93sL7+SN1dMCok6zyJX1KLRY6JTXb02w/WokrG/ENqxs
         gGJCSrPO3/JH0h/q9Z1uK7WaRq3/0h11UmNiUI0mSCFKuAn1wUC7DQkDUlmcip7bsTuK
         PfFgayz9stfW6QnNZ68F1X2zeFyCXPK8oZfdP4BkLYHw8ryUsqZxfXxEiaWWqDzNmIm5
         eIWWDA55hcsJkeog4q0/5Pp4fNJpWqghReQADIHvHkzXKCIISFtfVp070ZbmG8gWR5ha
         BAIkv5oBuyBwhhmKIxp4J0IWzTq45HhNdkC68APzOv+OOVRL/r7sQZo1t5p5jU0kqeEU
         hS5g==
X-Gm-Message-State: AOAM5333Bx0dlBOwf9Ih8P1t8PLhHEdjzAMzPhZJZjFAf1YMaE/uxsxH
        LkaDk/QJKN/+CJUpE+ggY9qIWQ==
X-Google-Smtp-Source: ABdhPJyB5WZMeDWoyUkjPOMlachVxvvFod144fxl8bbB0lmthUAShtFzj3K5VoXcb0cR5XGI9WC6WQ==
X-Received: by 2002:a17:902:e989:b029:e2:8c9d:78ba with SMTP id f9-20020a170902e989b02900e28c9d78bamr1281160plb.81.1613732022712;
        Fri, 19 Feb 2021 02:53:42 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id x1sm9662193pgj.37.2021.02.19.02.53.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Feb 2021 02:53:42 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, naoya.horiguchi@nec.com,
        joao.m.martins@oracle.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: [PATCH v16 9/9] mm: hugetlb: optimize the code with the help of the compiler
Date:   Fri, 19 Feb 2021 18:49:54 +0800
Message-Id: <20210219104954.67390-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210219104954.67390-1-songmuchun@bytedance.com>
References: <20210219104954.67390-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the "struct page size" crosses page boundaries we cannot
make use of this feature. Let free_vmemmap_pages_per_hpage()
return zero if that is the case, most of the functions can be
optimized away.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/hugetlb.h | 3 ++-
 mm/hugetlb_vmemmap.c    | 7 +++++++
 mm/hugetlb_vmemmap.h    | 6 ++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index caeef778526a..8d684edc3bf9 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -882,7 +882,8 @@ extern bool hugetlb_free_vmemmap_enabled;
 
 static inline bool is_hugetlb_free_vmemmap_enabled(void)
 {
-	return hugetlb_free_vmemmap_enabled;
+	return hugetlb_free_vmemmap_enabled &&
+	       is_power_of_2(sizeof(struct page));
 }
 #else
 static inline bool is_hugetlb_free_vmemmap_enabled(void)
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 33e42678abe3..1ba1ef45c48c 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -265,6 +265,13 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	BUILD_BUG_ON(__NR_USED_SUBPAGE >=
 		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
 
+	/*
+	 * The compiler can help us to optimize this function to null
+	 * when the size of the struct page is not power of 2.
+	 */
+	if (!is_power_of_2(sizeof(struct page)))
+		return;
+
 	if (!hugetlb_free_vmemmap_enabled)
 		return;
 
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index cb2bef8f9e73..29aaaf7b741e 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -21,6 +21,12 @@ void hugetlb_vmemmap_init(struct hstate *h);
  */
 static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
 {
+	/*
+	 * This check aims to let the compiler help us optimize the code as
+	 * much as possible.
+	 */
+	if (!is_power_of_2(sizeof(struct page)))
+		return 0;
 	return h->nr_free_vmemmap_pages;
 }
 #else
-- 
2.11.0

