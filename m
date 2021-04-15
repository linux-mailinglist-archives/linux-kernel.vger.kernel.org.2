Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C7E3604B1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 10:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhDOIoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 04:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbhDOIoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:44:14 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0763C061756
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 01:43:50 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id j32so1655085pgm.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 01:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x/SRS23vpbVfBLs/lG9SN0UAIXnw7CTzwH43G93PLHw=;
        b=f6OOfdVMog22KSTujExSY8hMPhka8V31/RlO6bivNiwdYGSLF9MaIJjOnDAilUTf4+
         Kf2dZGdhKeeHHQOkOClaeWJt98bNIy7lcHrY6lFVEFAzMGy+dafwVH7lHjT6g4GOkSik
         iGmqdLT3QKaqZ6jCDhcO3Eg8nEdnD7mQcrvLNXbWDh4MJpTvWiDPm+kKwWOA8llvLyPc
         +nU4bQz37CmoDyQlAfULJcrKCsUVmcdYGToVJHfOssQLvy2fYPD0imnIsVn5GFWrniH8
         xU9smLwN4vOEu4WhHs0ZfQvmxh5ZBEUCReK7w3ZKusEmdafzofFrHbNSj49UXrwIh4sS
         ByaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x/SRS23vpbVfBLs/lG9SN0UAIXnw7CTzwH43G93PLHw=;
        b=FgVH5SBOUEdknT+ugEvZRakCGcwVBXX9tZfhzdDIHJNHA3PpFaGbyvUw+SIgkoyVu4
         n6s2yuS0jpLq5z+fJcmc8XDpI4TLaC4X49kSyGVtGK88q7+ULy41YH7DRwdRy+9GNTNy
         kAe5Vx2RrByhcST3Gyw4bnWtn6SqtedRHXioFdQgAUHKP4TJsR4L69SodwtR9bJAflJZ
         Z4Xzdp1wAXHosKvLRsMBbZhU8dnyv2qugUCQsPOA26oNcapCT+SELabJ1Jfhhf9t+vPQ
         6bYlrqgfa0o4jSaTLwGT42gz0LJJY7sDye1L6kHz9C/Agbm5m6B3qWSYRDDudwLYJjpk
         LbLQ==
X-Gm-Message-State: AOAM531aEffaYap1QtYRROdAQnAIUdDyiVqY3pj3DPBQ1scZ4/VOOgfN
        Ng475PDgKB4tyXaEcE61hbaYfg==
X-Google-Smtp-Source: ABdhPJyV31W3NPW5cka6JErz4uX4p2+48ao/MXX/4spK2UbJVujp6YAdcy5vJgNDADqmFhU8NVMZmQ==
X-Received: by 2002:a65:4082:: with SMTP id t2mr2515072pgp.396.1618476230299;
        Thu, 15 Apr 2021 01:43:50 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id e13sm1392365pgt.91.2021.04.15.01.43.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 01:43:50 -0700 (PDT)
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v20 8/9] mm: memory_hotplug: disable memmap_on_memory when hugetlb_free_vmemmap enabled
Date:   Thu, 15 Apr 2021 16:40:04 +0800
Message-Id: <20210415084005.25049-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210415084005.25049-1-songmuchun@bytedance.com>
References: <20210415084005.25049-1-songmuchun@bytedance.com>
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
 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 drivers/acpi/acpi_memhotplug.c                  |  1 +
 mm/memory_hotplug.c                             | 18 +++++++++++++-----
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9e655f5206ac..1f648b3e6120 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2893,6 +2893,10 @@
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
index 68923c19bdea..c45ed6c0cd9f 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -981,6 +981,7 @@ static int online_memory_block(struct memory_block *mem, void *arg)
 
 bool mhp_supports_memmap_on_memory(unsigned long size)
 {
+	bool supported;
 	unsigned long nr_vmemmap_pages = size / PAGE_SIZE;
 	unsigned long vmemmap_size = nr_vmemmap_pages * sizeof(struct page);
 	unsigned long remaining_size = size - vmemmap_size;
@@ -1011,11 +1012,18 @@ bool mhp_supports_memmap_on_memory(unsigned long size)
 	 *	 altmap as an alternative source of memory, and we do not exactly
 	 *	 populate a single PMD.
 	 */
-	return memmap_on_memory &&
-	       IS_ENABLED(CONFIG_MHP_MEMMAP_ON_MEMORY) &&
-	       size == memory_block_size_bytes() &&
-	       IS_ALIGNED(vmemmap_size, PMD_SIZE) &&
-	       IS_ALIGNED(remaining_size, pageblock_nr_pages << PAGE_SHIFT);
+	supported = memmap_on_memory &&
+		    IS_ENABLED(CONFIG_MHP_MEMMAP_ON_MEMORY) &&
+		    size == memory_block_size_bytes() &&
+		    IS_ALIGNED(vmemmap_size, PMD_SIZE) &&
+		    IS_ALIGNED(remaining_size, pageblock_nr_pages << PAGE_SHIFT);
+
+	if (supported && is_hugetlb_free_vmemmap_enabled()) {
+		pr_info("Cannot enable memory_hotplug.memmap_on_memory, it is not compatible with hugetlb_free_vmemmap\n");
+		supported = false;
+	}
+
+	return supported;
 }
 
 /*
-- 
2.11.0

