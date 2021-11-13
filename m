Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3358844F405
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 16:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbhKMPrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 10:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbhKMPrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 10:47:36 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCBBC061766
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 07:44:44 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id n85so11045974pfd.10
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 07:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CiFvkxkml/E3hXlk6viC87ZsHB//A7EeJApdZ7JR+24=;
        b=AhBqsrkR6Fp1PCg8xJzMWdHyQh6BMpzd1VQXjD7eq24JgAEh/aQLmilgvbgj9Lvtl7
         1a4y44tdB/zCNR9YJU0t+Y6UiTsUqrn/lZGt+Jl5Xa5JtsB+ExkAPaYJxaPPpz2V35yG
         uZwtUM7QRU7apJtAZIRfNBpAWt7Oj2kjBnFjLMTRP2IDipBUh7IAQsWZz447GOckgsxp
         ybzBFRKIRXvJS5FC87J8VL1kCiLk4l8q78MS0GDqFDaJDfK7cVPG3INWdmG+8uXwt/fd
         mBVcB2mOfhgYKoY+RnlQGPA7MqcfgLypx6gdjK+L5wnHmVJbvvVgPLwtHTfdbUssqi3L
         oo7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CiFvkxkml/E3hXlk6viC87ZsHB//A7EeJApdZ7JR+24=;
        b=i8bI3Bqg1Y2B9jXuZmC9vTqO45ewi7xEdHsFs1Y4FbWC2JQnKU+CxvzrXnnOUQsyug
         zAXby2lr0NrMSGD4FrWqoTHD9SmGyV3yj1cJxLsvAIkj/sgywIEKqOkn4Gy1I7oflobk
         uAootRAaSxz70+WXsNiBfeJcqMAxdbmJ1a+flbWaxHJ/eresMYHE2kqfR8oMT2N/JvYu
         +cYnT1CnZpAaNo+e5w2Tg9E4CKeh6uxL49taieL8+lRkftPdlrboMPVqwcTdEFoCANlv
         XbEHPl0rFPMCciFsv+FE2gEuUhYz/6aUZNf8hPYFHP+0WlV06ENu00NS04fGb/oaImuZ
         C3ow==
X-Gm-Message-State: AOAM531bl4YQj1Wfqr2lBNdMHpIn4Sx0BhQE/6vQnZKfRUYc1KhobWHR
        CXoGFinwPDyABJOb9Or6qLE=
X-Google-Smtp-Source: ABdhPJx1VOktTq/wTyazaQKuTgGuBrVRN5rl7mqgaWSQ9s7vhuM2ASOEpckNlz+ko7kRKquhceum/w==
X-Received: by 2002:a62:6184:0:b0:4a2:a063:fe8e with SMTP id v126-20020a626184000000b004a2a063fe8emr2105905pfb.69.1636818283847;
        Sat, 13 Nov 2021 07:44:43 -0800 (PST)
Received: from localhost.localdomain ([113.172.190.100])
        by smtp.googlemail.com with ESMTPSA id q13sm10847651pfk.22.2021.11.13.07.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 07:44:43 -0800 (PST)
From:   Bui Quang Minh <minhquangbui99@gmail.com>
Cc:     Bui Quang Minh <minhquangbui99@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mina Almasry <almasrymina@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] hugetlb: fix hugetlb cgroup refcounting during mremap
Date:   Sat, 13 Nov 2021 22:44:10 +0700
Message-Id: <20211113154412.91134-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When hugetlb_vm_op_open() is called during copy_vma(), we may take the
reference to resv_map->css. Later, when clearing the reservation pointer
of old_vma after transferring it to new_vma, we forget to drop the
reference to resv_map->css. This leads to a reference leak of css.

Fixes this by adding a check to drop reservation css  reference in
clear_vma_resv_huge_pages()

Fixes: 550a7d6 (mm, hugepages: add mremap() support for hugepage backed vma)
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 include/linux/hugetlb_cgroup.h | 12 ++++++++++++
 mm/hugetlb.c                   |  4 +++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index c137396129db..ba025ae27882 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -128,6 +128,13 @@ static inline void resv_map_dup_hugetlb_cgroup_uncharge_info(
 		css_get(resv_map->css);
 }
 
+static inline void resv_map_put_hugetlb_cgroup_uncharge_info(
+						struct resv_map *resv_map)
+{
+	if (resv_map->css)
+		css_put(resv_map->css);
+}
+
 extern int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
 					struct hugetlb_cgroup **ptr);
 extern int hugetlb_cgroup_charge_cgroup_rsvd(int idx, unsigned long nr_pages,
@@ -211,6 +218,11 @@ static inline void resv_map_dup_hugetlb_cgroup_uncharge_info(
 {
 }
 
+static inline void resv_map_put_hugetlb_cgroup_uncharge_info(
+						struct resv_map *resv_map)
+{
+}
+
 static inline int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
 					       struct hugetlb_cgroup **ptr)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e09159c957e3..3a2479003ddf 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1037,8 +1037,10 @@ void clear_vma_resv_huge_pages(struct vm_area_struct *vma)
 	 */
 	struct resv_map *reservations = vma_resv_map(vma);
 
-	if (reservations && is_vma_resv_set(vma, HPAGE_RESV_OWNER))
+	if (reservations && is_vma_resv_set(vma, HPAGE_RESV_OWNER)) {
+		resv_map_put_hugetlb_cgroup_uncharge_info(reservations);
 		kref_put(&reservations->refs, resv_map_release);
+	}
 
 	reset_vma_resv_huge_pages(vma);
 }
-- 
2.25.1

