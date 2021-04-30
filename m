Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929E436F483
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 05:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhD3DWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 23:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhD3DWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 23:22:30 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC3EC06138C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 20:21:43 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id h14-20020a17090aea8eb02901553e1cc649so1004699pjz.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 20:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5NQIABLEewgKDhqj4Cu1k3a4cKl/gjUQHTrPXMY+Vi4=;
        b=oI+JMHt8GhkGp/Bg+hcLr/8b49e7kKuWTMHFtZXTezSJndfevpwXe9Uxgww0dOeFip
         k0qjAUQFt7WZ3/7udpB19UlZn3Cmg7iiafQ4D0o3ujfOqEfX6h7ncfLU14q5bJLktirf
         4tPFCpDLVX/vDzeM4slu3MPjK+Z5Q51Ijcgzzx5ygN6XLVSXYGFAdnxu1v6Jfg+eZ0Y6
         u002e7dRLwGxRLVOvakcPJFxgCti15MZcVsdAesy4ID9KHWHUzOtIf8HIlrdOijsuzMy
         q7nGVFU28lqGslt+41xGPQQnh8n8ht3yRBBk7mg4Z8+pJK/swfU9flELnm9cLFJYwPZa
         njtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5NQIABLEewgKDhqj4Cu1k3a4cKl/gjUQHTrPXMY+Vi4=;
        b=scC6+uMHcmN11ooF8aLo32t941qa3F7tnXgsB3y1EO3tab4fZIaSohMsyhN1MmBGgq
         cVb0Qu1veTgdutM0sY8sccqPgFRlc7xbpMQ0H0PvUzFgzdaDSVUjIwVvV2HgvwwNqzK7
         4R+9Ltm2F1bOVlsLoa/ohWbQZ0mqWTbt0m1KALVcpQUbnQcpxoBbALP7ln1HrIlvrJyQ
         24dIGYoTtMBu1u/xHImTjXK0aPL42LNFPpj/kGS0gxYpTwuix0ycy5tHEWytJGg/BRc/
         jBj0rXfYf9hjT1uw5y6sMKG/norHs5fNG0qU/GnxVHYM4007W108tGy5x+K+/BSyq0oK
         hU2A==
X-Gm-Message-State: AOAM530PbxLukHVijd6XdIKL+ahcBB8OBfbikhRrrcMW4kTAkniJDDvs
        VIgvIYRFWYRs65N4bAJwBUxcwA==
X-Google-Smtp-Source: ABdhPJwQu2nxjgbH6sUPQaZws9N7oEAeAXlhyRuWo4je6dcrhRIGlmtkbjInrrokpj4X2o/jRNaNBA==
X-Received: by 2002:a17:90b:f82:: with SMTP id ft2mr12705488pjb.0.1619752902709;
        Thu, 29 Apr 2021 20:21:42 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id t6sm405317pjl.57.2021.04.29.20.21.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Apr 2021 20:21:42 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org, osalvador@suse.de, mhocko@suse.com,
        song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com, joao.m.martins@oracle.com
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        zhengqi.arch@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v22 8/9] mm: memory_hotplug: disable memmap_on_memory when hugetlb_free_vmemmap enabled
Date:   Fri, 30 Apr 2021 11:13:51 +0800
Message-Id: <20210430031352.45379-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210430031352.45379-1-songmuchun@bytedance.com>
References: <20210430031352.45379-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameter of memory_hotplug.memmap_on_memory is not compatible with
hugetlb_free_vmemmap. So disable it when hugetlb_free_vmemmap is
enabled.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 8 ++++++++
 drivers/acpi/acpi_memhotplug.c                  | 1 +
 mm/memory_hotplug.c                             | 1 +
 3 files changed, 10 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3cc19cb78b85..8181345e996a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1638,6 +1638,10 @@
 			on:  enable the feature
 			off: disable the feature
 
+			This is not compatible with memory_hotplug.memmap_on_memory.
+			If both parameters are enabled, hugetlb_free_vmemmap takes
+			precedence over memory_hotplug.memmap_on_memory.
+
 	hung_task_panic=
 			[KNL] Should the hung task detector generate panics.
 			Format: 0 | 1
@@ -2904,6 +2908,10 @@
 			Note that even when enabled, there are a few cases where
 			the feature is not effective.
 
+			This is not compatible with hugetlb_free_vmemmap. If
+			both parameters are enabled, hugetlb_free_vmemmap takes
+			precedence over memory_hotplug.memmap_on_memory.
+
 	memtest=	[KNL,X86,ARM,PPC,RISCV] Enable memtest
 			Format: <integer>
 			default : 0 <disable>
diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index 8cc195c4c861..0d7f595ee441 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -15,6 +15,7 @@
 #include <linux/acpi.h>
 #include <linux/memory.h>
 #include <linux/memory_hotplug.h>
+#include <linux/hugetlb.h>
 
 #include "internal.h"
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 16b3a7a1db8c..6512e6f641bb 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1052,6 +1052,7 @@ bool mhp_supports_memmap_on_memory(unsigned long size)
 	 *       populate a single PMD.
 	 */
 	return memmap_on_memory &&
+	       !is_hugetlb_free_vmemmap_enabled() &&
 	       IS_ENABLED(CONFIG_MHP_MEMMAP_ON_MEMORY) &&
 	       size == memory_block_size_bytes() &&
 	       IS_ALIGNED(vmemmap_size, PMD_SIZE) &&
-- 
2.11.0

