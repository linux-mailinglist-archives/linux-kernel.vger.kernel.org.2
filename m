Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEDD30EB3B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 04:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhBDDzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 22:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbhBDDzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 22:55:12 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44DCC06178C
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 19:54:17 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id nm1so932342pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 19:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rbaYTNYcnNCF5suT1Rnzl4fKBboUgz5smm7iB2s2QLo=;
        b=BZ9xMp3YtuJbJlv/cWJQps/Tpdxkv3meqtQufoGBj7IPb11hqwXzbvaTSBp0UqKg6T
         k8PmO7u00wNYkFfNARE+khYCQBrgi9HeU4C40Vbd+k32LaDwwZzikdIIG/JMfQzN62Nr
         zbCTYPTS8JL3WQZq711tY1VUMY+jriby99Ae6nDbubzItBcSfHUNHogoAY6b+VlW7qBe
         thr/geWt1x6v7paRRP8bU2CvSpyC4Bg4FrOjTlJ7aGZBZvWv3Tjfbn5BNyHVlW9qCxdI
         nBKpLmddjx3rW4/khv0BFx8cTDiBZcikuDSB+O64S71OFfgJwCl8ISRrjWStLnYLlM6i
         tevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rbaYTNYcnNCF5suT1Rnzl4fKBboUgz5smm7iB2s2QLo=;
        b=ECLSgMc6NHdsYTMv8vmj0jFvpzas91CV55X64Asz1FFGxMoDQsB4aGvkWwjPI1iVBM
         TMLXjTYltQydigXM+0ISjmnyteollMTB4ynHXMEROimrR5pDwY0jJ24q/1reOmrzmCHg
         1Jxlvl1MQS3rblmgKgfsCAJP0iakpVZJ1q7Gjdp3emVkXPxdzU60ynR4eCWTSkmVx94p
         2G2j3pDpPdfowctvkZ+lgQwUoP1dNBhQ63qVT//oBlVT+g/WcA8zGsdgd5M5TrzFytUV
         demNPOoZHHfTd5xaYgMFt4/ceVHCE815dNeSHa/IX/P+JiGU2axPkUj2sPmwXxguntd5
         Tp/Q==
X-Gm-Message-State: AOAM533/bySH07EbbKpEUwGkXNqTrZXHC0cA6K3+3BenpoGs8qMgXy1F
        D61dDRu6MWeAbkWiPp+Upd0LFg==
X-Google-Smtp-Source: ABdhPJwYg71Pe1QhU5oYCWBRke57VHrFd8GAEfIocOsjtaS43HRiEMVdR+bZjyHFtv6psvkU3njfNA==
X-Received: by 2002:a17:90b:3886:: with SMTP id mu6mr6231566pjb.153.1612410857508;
        Wed, 03 Feb 2021 19:54:17 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id 9sm3747466pfy.110.2021.02.03.19.54.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 19:54:16 -0800 (PST)
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
        david@redhat.com, naoya.horiguchi@nec.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v14 2/8] mm: hugetlb: introduce a new config HUGETLB_PAGE_FREE_VMEMMAP
Date:   Thu,  4 Feb 2021 11:50:37 +0800
Message-Id: <20210204035043.36609-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210204035043.36609-1-songmuchun@bytedance.com>
References: <20210204035043.36609-1-songmuchun@bytedance.com>
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

Like other code which frees vmemmap, this config option depends on
HAVE_BOOTMEM_INFO_NODE. The routine register_page_bootmem_info() is
used to register bootmem info. Therefore, make sure
register_page_bootmem_info is enabled if HUGETLB_PAGE_FREE_VMEMMAP
is defined.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 arch/x86/mm/init_64.c | 2 +-
 fs/Kconfig            | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 0a45f062826e..0435bee2e172 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1225,7 +1225,7 @@ static struct kcore_list kcore_vsyscall;
 
 static void __init register_page_bootmem_info(void)
 {
-#ifdef CONFIG_NUMA
+#if defined(CONFIG_NUMA) || defined(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP)
 	int i;
 
 	for_each_online_node(i)
diff --git a/fs/Kconfig b/fs/Kconfig
index 97e7b77c9309..de87f234f1e9 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -237,6 +237,12 @@ config HUGETLBFS
 config HUGETLB_PAGE
 	def_bool HUGETLBFS
 
+config HUGETLB_PAGE_FREE_VMEMMAP
+	def_bool HUGETLB_PAGE
+	depends on X86_64
+	depends on SPARSEMEM_VMEMMAP
+	depends on HAVE_BOOTMEM_INFO_NODE
+
 config MEMFD_CREATE
 	def_bool TMPFS || HUGETLBFS
 
-- 
2.11.0

