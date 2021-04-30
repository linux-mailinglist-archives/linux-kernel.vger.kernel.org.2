Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7172236F470
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 05:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhD3DVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 23:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhD3DVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 23:21:42 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE4FC061343
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 20:20:36 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id h11so7904489pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 20:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SoZb++zfv4yAwjnBuF75FK8ZgZmHYksA4MNIPLiTWic=;
        b=mlyV38kwzZqnfRIFSmO3Lzu/ptALUHfqbXSA1aV0ptvicemXcM1txUuxdvQLqZdf5l
         HLS765hW/rWEKW9ecF/6BtofGKaA+n6Bs2Q7DJrotWxBFrvb3JPN5oY/J6+uF8Ugu5Ns
         TSCmNCq1dr2/V/9bBDmHqlKirDqMgOIcfVnHBz6yqZGJdbpGkPUc89ttao4Sdg8wCZyi
         OZUnh72X5HlgC2/WNdIhQUrWrquMx1eeaAl9D6JbADRcEnCP9x7wvWNogDYd3LcnhZ/2
         zh5ezjT+4USCuscbPhNqVcfS0nLviUGV+q9S7Q242eE37aWxeaNq+RDt+CHQP8ddxHrF
         dtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SoZb++zfv4yAwjnBuF75FK8ZgZmHYksA4MNIPLiTWic=;
        b=Ps4vqW7IkKobfqmzXFqFyINRhacLQ1ZnyiLPr62nSdniqgxgI4Q3fleyETKzGaBpmh
         EBhcVW4krwH9IiyhkXQ578XiK/RDmuzVLx7DIIytIaDuO4VO+Fg+X7vL/BdObmtdepNP
         WTDJVfJcHgT5yKnsve3njQljbmGhC2NTqiHJNT4ZwU3aY+C0hlRNhx7aEzE/FO7XZSNu
         Wt94XXrIQ2qeQKFZGSqyiQ5f/TvzeBxl6KoCIUS6IpMhDgtMY80J1W9wQfv/RgqbM0wj
         zUiXvvR35ThnqbsNtqMqp5P2jcpFnN+E4AB5iRIPpLBnnnP7ELWvgwsRh4ehuKJyWwb5
         JSMQ==
X-Gm-Message-State: AOAM531qMbDEEOxfeMyOjK0Og7IEy/wwgioUHgkcZdGNLw0Ragn1MtP3
        FjBj9Vd7xw8tN8Atiy5cWeAp2w==
X-Google-Smtp-Source: ABdhPJxmzeuvpPgk9GmyFCzB6g3eCpDFvfRsjXYrtKKIR7iA2IIslOyy4I+cKXCJ69KydA6HMKNjOQ==
X-Received: by 2002:a63:575b:: with SMTP id h27mr2823285pgm.180.1619752836465;
        Thu, 29 Apr 2021 20:20:36 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id t6sm405317pjl.57.2021.04.29.20.20.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Apr 2021 20:20:36 -0700 (PDT)
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
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>,
        Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v22 2/9] mm: hugetlb: introduce a new config HUGETLB_PAGE_FREE_VMEMMAP
Date:   Fri, 30 Apr 2021 11:13:45 +0800
Message-Id: <20210430031352.45379-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210430031352.45379-1-songmuchun@bytedance.com>
References: <20210430031352.45379-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The option HUGETLB_PAGE_FREE_VMEMMAP allows for the freeing of
some vmemmap pages associated with pre-allocated HugeTLB pages.
For example, on X86_64 6 vmemmap pages of size 4KB each can be
saved for each 2MB HugeTLB page. 4094 vmemmap pages of size 4KB
each can be saved for each 1GB HugeTLB page.

When a HugeTLB page is allocated or freed, the vmemmap array
representing the range associated with the page will need to be
remapped. When a page is allocated, vmemmap pages are freed
after remapping. When a page is freed, previously discarded
vmemmap pages must be allocated before remapping.

The config option is introduced early so that supporting code
can be written to depend on the option. The initial version of
the code only provides support for x86-64.

If config HAVE_BOOTMEM_INFO_NODE is enabled, the freeing vmemmap
page code denpend on it to free vmemmap pages. Otherwise, just
use free_reserved_page() to free vmemmmap pages. The routine
register_page_bootmem_info() is used to register bootmem info.
Therefore, make sure register_page_bootmem_info is enabled if
HUGETLB_PAGE_FREE_VMEMMAP is defined.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Tested-by: Chen Huang <chenhuang5@huawei.com>
Tested-by: Bodeddula Balasubramaniam <bodeddub@amazon.com>
Reviewed-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/x86/mm/init_64.c | 2 +-
 fs/Kconfig            | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 3aaf1d30c777..65ea58527176 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1270,7 +1270,7 @@ static struct kcore_list kcore_vsyscall;
 
 static void __init register_page_bootmem_info(void)
 {
-#ifdef CONFIG_NUMA
+#if defined(CONFIG_NUMA) || defined(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP)
 	int i;
 
 	for_each_online_node(i)
diff --git a/fs/Kconfig b/fs/Kconfig
index dcd9161fbeba..6ce6fdac00a3 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -240,6 +240,11 @@ config HUGETLBFS
 config HUGETLB_PAGE
 	def_bool HUGETLBFS
 
+config HUGETLB_PAGE_FREE_VMEMMAP
+	def_bool HUGETLB_PAGE
+	depends on X86_64
+	depends on SPARSEMEM_VMEMMAP
+
 config MEMFD_CREATE
 	def_bool TMPFS || HUGETLBFS
 
-- 
2.11.0

