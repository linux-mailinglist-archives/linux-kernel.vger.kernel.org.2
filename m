Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CC33A968D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 11:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhFPJyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 05:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbhFPJym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 05:54:42 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5406C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 02:52:36 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id a127so1747413pfa.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 02:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cStPclh9XG3RxOFyVxsu9zTH21TiQql+7187dLUWbK8=;
        b=sYSNoTU43Ix6OsZTUORxb3rzT9NRRaz/6B8uMNVYNKewRmZY4telOmLIZdah47riHS
         yJFl3hoXYNc+zEC6lOIiqW2vZHa8BpPJE5qOZ5feQC9BG0wk/Xwuh7wNmb/hb/Bn8r60
         yx8xA+AXdOMesVqkl7E36Gm8pR/crs3X34YHNf6lRIt7+HRPJikEtXVR4yZRz9T6KgTT
         Q4XXbhkOKzYxQr8eKzkigqTxzChomgUAdakUWNxMt8y1Oh8+9+ljdJ+iZ3RDy9MXaWWq
         v8PglxPX9txjmUQ5woJm7ZPdOgU6m3/kJ8CfJBF4y/W1tLgxPjKDgmOQfXKy5rBEKVao
         pHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cStPclh9XG3RxOFyVxsu9zTH21TiQql+7187dLUWbK8=;
        b=Idb1oBfgi1uxm+B3FLvPeFumLDIaNWbpfN7grAP3dRZHMDIr9cFA2aSvNh2IT0sIlg
         TIZq3r58FBI/subgb9NdaZgWle61hlVJYtPVai8DZq3oIGwBxYh1xmNP4wTrm65jG8fl
         nlRViSn2AvHwDL5dmgdl7Gmg93kIzV44s8GVybi+9wyr7HrgBevgrUc7cPdoQ4ZPNrlM
         /HvZNz4NaTN04dHC6cnGbuILa9bbhZC1Y0xfaZupdjZWYGwVGEx1STZafP2uti6X5mEM
         juip9GJNtdLhchcYolJa7I46AjexfJIlxCGkYGTy/gZwwKY2F2qSyuzHs9qulePUk7L7
         9/WQ==
X-Gm-Message-State: AOAM533CrnQqq0e60WUTWuExlWzrz/f85JTXeXHkeHkYGH9as8QYYE0k
        uKzuEiyTln4HmRvvZ+UeepCrqw==
X-Google-Smtp-Source: ABdhPJzGmh1DPcZnjuy13NT9spKbX8eIhbJOKLSzvyG8u3OumKYilIfOiIwI+2Bl5SHqqQiGtiHlSw==
X-Received: by 2002:a62:9290:0:b029:2f7:64c4:b5f4 with SMTP id o138-20020a6292900000b02902f764c4b5f4mr8714444pfd.47.1623837156316;
        Wed, 16 Jun 2021 02:52:36 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id a20sm1744222pfk.145.2021.06.16.02.52.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jun 2021 02:52:36 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 3/3] mm: hugetlb: introduce CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON
Date:   Wed, 16 Jun 2021 17:49:15 +0800
Message-Id: <20210616094915.34432-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210616094915.34432-1-songmuchun@bytedance.com>
References: <20210616094915.34432-1-songmuchun@bytedance.com>
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

