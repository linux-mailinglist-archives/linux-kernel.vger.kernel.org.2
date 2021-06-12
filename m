Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E26B3A4DFD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 11:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhFLJs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 05:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhFLJsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 05:48:25 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A70C061767
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 02:46:26 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id v11so4048375ply.6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 02:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cStPclh9XG3RxOFyVxsu9zTH21TiQql+7187dLUWbK8=;
        b=eUO6qTRKBADJwUvuErZZeJR8S4O44jHtqy+r5h1kUNyB7U5lcux3/vJZGSz4EC02lO
         7caZ1sMLwKh29iHmshLFiGfBTWgBDKKEjZjL3O5ByeTACbVC8GH2GUgoeg67eDlDasSR
         N0FiROzzDYmjEZB+5zshhVw9hSa+qmCcD233m++NOqgB+idXbQVGZwjP6bMNUaEkpb2W
         XRg1Nby+1RCfoKMTpIigJGUcKHGMaWhMd1hYUjUJaFdxBNuznmYHQ3/+Cqav/8LnsyOj
         DILszkKbXV/29+eg5CZ27W9r79KzqlhDBmcwEgL3FhTrZPAeNxW7QzuxWimHV8kAOXCe
         cRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cStPclh9XG3RxOFyVxsu9zTH21TiQql+7187dLUWbK8=;
        b=pcz2r/kU6tYdr52Wt4VWzwbjJL5ySMbpVmttPLsXsvBkuoYVqXScAhTRwF6LWL8us4
         Wy9uFYEl28LmOv+ge83azO+3ahqMkcte7UFoIs6j6VaRwm2ZpqzxZKVT8/YbTNeFRoT+
         Yus1daJrcB+JPkAm61VyU6UyqiOZ/WKCZkOogLnmQ/fczevaBBdUJWoCH5ML3iltIukL
         TWSESptUHcX9R65Y+Nl5DLrM1dDThXtax3HAYLwKt03hgWm4qLveCV7KgUhDhWglto46
         yKu7ga7acwfZHpkGlQ07H7d92KCEDduKQ3ACAKLW508VN3SBXf3UnkukEgmJw3GJA9XK
         6ULA==
X-Gm-Message-State: AOAM531Fgy7SSLkVZUAkUzZvaUrzWtH/H7gJJLL4jXQQgu9mNUDmj498
        +J98sqXrt26QcEso9U5aL+zVKA==
X-Google-Smtp-Source: ABdhPJxri4vZdp0HhrlywijdZcCZtQiBBCNKpg4WIBbifMFNu/V4m/2DPd2uuq3Hp+FCgOe5CZEYOw==
X-Received: by 2002:a17:903:3112:b029:103:6340:3195 with SMTP id w18-20020a1709033112b029010363403195mr7899387plc.29.1623491184271;
        Sat, 12 Jun 2021 02:46:24 -0700 (PDT)
Received: from localhost.tiktokd.org ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id t39sm6929557pfg.147.2021.06.12.02.46.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jun 2021 02:46:23 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 3/3] mm: hugetlb: introduce CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON
Date:   Sat, 12 Jun 2021 17:45:55 +0800
Message-Id: <20210612094555.71344-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210612094555.71344-1-songmuchun@bytedance.com>
References: <20210612094555.71344-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using HUGETLB_PAGE_FREE_VMEMMAP, the freeing unused vmemmap pages
associated with each HugeTLB page is default off. Now the vmemmap is PMD
mapped. So there is no side effect when this feature is enabled with no
HugeTLB pages in the system. Someone may want to enable this feature in
the compiler time instead of using boot command line. So add a config to
make it default on when someone do not want to enable it via command line.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 fs/Kconfig                                      | 10 ++++++++++
 mm/hugetlb_vmemmap.c                            |  6 ++++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a01aadafee38..8eee439d943c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1604,6 +1604,9 @@
 			on:  enable the feature
 			off: disable the feature
 
+			Built with CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON=y,
+			the default is on.
+
 			This is not compatible with memory_hotplug.memmap_on_memory.
 			If both parameters are enabled, hugetlb_free_vmemmap takes
 			precedence over memory_hotplug.memmap_on_memory.
diff --git a/fs/Kconfig b/fs/Kconfig
index f40b5b98f7ba..e78bc5daf7b0 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -245,6 +245,16 @@ config HUGETLB_PAGE_FREE_VMEMMAP
 	depends on X86_64
 	depends on SPARSEMEM_VMEMMAP
 
+config HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON
+	bool "Default freeing vmemmap pages of HugeTLB to on"
+	default n
+	depends on HUGETLB_PAGE_FREE_VMEMMAP
+	help
+	  When using HUGETLB_PAGE_FREE_VMEMMAP, the freeing unused vmemmap
+	  pages associated with each HugeTLB page is default off. Say Y here
+	  to enable freeing vmemmap pages of HugeTLB by default. It can then
+	  be disabled on the command line via hugetlb_free_vmemmap=off.
+
 config MEMFD_CREATE
 	def_bool TMPFS || HUGETLBFS
 
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 06802056f296..c540c21e26f5 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -182,7 +182,7 @@
 #define RESERVE_VMEMMAP_NR		2U
 #define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
 
-bool hugetlb_free_vmemmap_enabled;
+bool hugetlb_free_vmemmap_enabled = IS_ENABLED(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON);
 
 static int __init early_hugetlb_free_vmemmap_param(char *buf)
 {
@@ -197,7 +197,9 @@ static int __init early_hugetlb_free_vmemmap_param(char *buf)
 
 	if (!strcmp(buf, "on"))
 		hugetlb_free_vmemmap_enabled = true;
-	else if (strcmp(buf, "off"))
+	else if (!strcmp(buf, "off"))
+		hugetlb_free_vmemmap_enabled = false;
+	else
 		return -EINVAL;
 
 	return 0;
-- 
2.11.0

