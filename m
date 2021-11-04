Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39925444CF4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 02:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhKDBXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 21:23:13 -0400
Received: from mail-mw2nam08on2064.outbound.protection.outlook.com ([40.107.101.64]:38977
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231206AbhKDBXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 21:23:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKetLhE/WxM9VNEORbTzepiXCz2OpJy2Jn4HnpCJBLuF2Qn4xduN7vwn+xc4XeNOotEsiyTcsdSWnFT1Uve46C+c7XMi5xiSlF34uISeMfuheAxuuPBVuY9lMe0Jmy8MD7YKw4ivv/Wqk9OZLyzLeM+raZ21MUT7qwEHTZiqPez02Uv5RjdVti9uDsNKpqeT/1bVuQ5ZoRnUTCVMDTW6kSRuBW5Z7OuS8lNT7Dgq2aYSW1v+iCz7B0R1oGn6iR3LqgqnGXVqop8ibBiK9Cf3cOaSg7zmtotm1cMHAr943oncU4Fzr5EXLcQZCe1EHlQvW8ZSRxo46551aoJDkn/x4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRhAevVag+0PrltmPGIcJKq3bLpbcgQX8O1AmPGaEzg=;
 b=n/wOPhk1VBDrwS/QlnBmhSZ73J2F8S3fISqxegpV0hqUJ86WorvtlI89qdMMfsm3+n1vst/+cPaBOFJpXRA+EokYQImEBf0U1tmnEsOmyl7TYXOXuzOsdH4G537l87ielMXN8cWf0KO6YU7i2wkpwRX1IrMWjpLBxjKT5GZM6ZyETWhR8rWH457vVm7B6d9FocuIPXrcw36Mh9LrjIC5k75+vgxjmfLn0R52lwXwGeUM3x6OjQv/1cIuRFiMsBPV4JL5SVqnRolDDi9VrsdfFCgHw8zACEiY0A08RVzB+0XKKN6X+me1I9ytOyo/EUP8wAHb2EsNxy9ejuK5yL41UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kvack.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRhAevVag+0PrltmPGIcJKq3bLpbcgQX8O1AmPGaEzg=;
 b=dzIhfzFOfduSNgO6jnXmLXbFVDF5oLpRC1D9gmFeowRj8fM4TClaTxwsCRkKYs51X0TeXaTIqq87WJv4GnOXROsBRNqolLqjHhi/1PZKcCi6XaKGXyfmT7e9X5EpmwH8bFUjN13nXjomc6HBRVC9TUlVuJUosFy1jsvGT7T3wd2/p0DmpzY0hZZ59exWj2gHm0Ni97DYKUp7mzyhbG1UqmfBnVjsk5V87X9gooszSEjlmLNBYUdtoRiE+cQLvFACzMCyi+j0f7pOvidweRLmwtoBtCBXlBQeKIHvvdCkhJG/eNE45AE0QBZtbUbmlvhrTGVJMTfOlpoC9ht5WAM2jw==
Received: from MWHPR11CA0016.namprd11.prod.outlook.com (2603:10b6:301:1::26)
 by MWHPR1201MB0046.namprd12.prod.outlook.com (2603:10b6:301:5b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 4 Nov
 2021 01:20:29 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:1:cafe::8e) by MWHPR11CA0016.outlook.office365.com
 (2603:10b6:301:1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Thu, 4 Nov 2021 01:20:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 01:20:29 +0000
Received: from localhost (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 4 Nov
 2021 01:20:27 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     <akpm@linux-foundation.org>
CC:     <jglisse@redhat.com>, <jhubbard@nvidia.com>, <ziy@nvidia.com>,
        <rcampbell@nvidia.com>, <Felix.Kuehling@amd.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <jgg@nvidia.com>, Alistair Popple <apopple@nvidia.com>
Subject: [PATCH] mm/hmm.c: Allow VM_MIXEDMAP to work with hmm_range_fault
Date:   Thu, 4 Nov 2021 12:20:01 +1100
Message-ID: <20211104012001.2555676-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e9504b3-e912-416e-33c3-08d99f3149eb
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0046:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0046735D0D8FAED6A54539F0DF8D9@MWHPR1201MB0046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dEbrLOqu+ItTt9gGWNxSV6uedA+A9JqFM8HdvNoBWuEOqdF/ixQlkCh85uMZegkaBeRg4xyk2iwbI1oVz9lMveL65wYutcBwUT7g0082SoqXiTyFPKcIGEKY4YYPDhQNHJOhG0friWuA7zpNB96icH9hiy0OJNWSTxD/6wp4vkAoq3zLhhzRdDCxunYYyoGC8OGyuMtUD2ULNbhIN+o13O6527LGkenuKW7y1CiQgr4A4dmeZN8NVeoHArSw/v+CqgRrXTKaYt/kjR/yKouPAE/2D628HFhxJ12Ad6VRT8fadYwOg6robX0j2LfyDfSOGRmpCZWJRV6HWKxNhg0V5XRy3oWQoeWhjumJ/BeYxrJYLTma7N78W2+qlALsDLZJlkFuPM9hBdhNWz1c4oF/A5zrdmH/In4LrCovMcrQZ1zzKmEZlF+nVejgdO6LTVdJuCKuZjtmnwFMd+2TEFqqYrxPA0v1ks0Hb5yK94uwCSdr+pVdHkHOpSRBM7a7CBdWoo7pPaquzwnWbSfpyjZ3STtbeO5r7/BwtqoiaY5W4+wxMN06MAxL7uIHRG1VpQp3zCRAFAvyrERJzxqOSsOc78YjUf4yvvfgmOLBAvnbM811uPb8V1AWFAMRMin+g9sAu1qDCc10qILwzJ6yUQ5tcZLwlEHED99fjzHpM5g4e3VN0XkbsxErb/FT8KxxXg79zrp2WW6iAVvOMgDjW1062w==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(83380400001)(5660300002)(8936002)(70206006)(4326008)(107886003)(356005)(2616005)(47076005)(16526019)(36860700001)(2906002)(26005)(8676002)(86362001)(36756003)(1076003)(70586007)(54906003)(7636003)(186003)(508600001)(6666004)(336012)(82310400003)(426003)(6916009)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 01:20:29.0911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9504b3-e912-416e-33c3-08d99f3149eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0046
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hmm_range_fault() can be used instead of get_user_pages() for devices
which allow faulting however unlike get_user_pages() it will return an
error when used on a VM_MIXEDMAP range.

To make hmm_range_fault() more closely match get_user_pages() remove
this restriction. This requires dealing with the !ARCH_HAS_PTE_SPECIAL
case in hmm_vma_handle_pte(). Rather than replicating the logic of
vm_normal_page() call it directly and do a check for the zero pfn
similar to what get_user_pages() currently does.

Also add a test to hmm selftest to verify functionality.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 lib/test_hmm.c                         | 24 +++++++++++++++
 mm/hmm.c                               |  5 +--
 tools/testing/selftests/vm/hmm-tests.c | 42 ++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index c259842f6d44..ac794e354069 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -1087,9 +1087,33 @@ static long dmirror_fops_unlocked_ioctl(struct file *filp,
 	return 0;
 }
 
+static int dmirror_fops_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	unsigned long addr;
+
+	for (addr = vma->vm_start; addr < vma->vm_end; addr += PAGE_SIZE) {
+		struct page *page;
+		int ret;
+
+		page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+		if (!page)
+			return -ENOMEM;
+
+		ret = vm_insert_page(vma, addr, page);
+		if (ret) {
+			__free_page(page);
+			return ret;
+		}
+		put_page(page);
+	}
+
+	return 0;
+}
+
 static const struct file_operations dmirror_fops = {
 	.open		= dmirror_fops_open,
 	.release	= dmirror_fops_release,
+	.mmap		= dmirror_fops_mmap,
 	.unlocked_ioctl = dmirror_fops_unlocked_ioctl,
 	.llseek		= default_llseek,
 	.owner		= THIS_MODULE,
diff --git a/mm/hmm.c b/mm/hmm.c
index fad6be2bf072..70fa81a3b629 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -298,7 +298,8 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	 * Since each architecture defines a struct page for the zero page, just
 	 * fall through and treat it like a normal page.
 	 */
-	if (pte_special(pte) && !is_zero_pfn(pte_pfn(pte))) {
+	if (!vm_normal_page(walk->vma, addr, pte) &&
+		!is_zero_pfn(pte_pfn(pte))) {
 		if (hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0)) {
 			pte_unmap(ptep);
 			return -EFAULT;
@@ -515,7 +516,7 @@ static int hmm_vma_walk_test(unsigned long start, unsigned long end,
 	struct hmm_range *range = hmm_vma_walk->range;
 	struct vm_area_struct *vma = walk->vma;
 
-	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP | VM_MIXEDMAP)) &&
+	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)) &&
 	    vma->vm_flags & VM_READ)
 		return 0;
 
diff --git a/tools/testing/selftests/vm/hmm-tests.c b/tools/testing/selftests/vm/hmm-tests.c
index 864f126ffd78..203323967b50 100644
--- a/tools/testing/selftests/vm/hmm-tests.c
+++ b/tools/testing/selftests/vm/hmm-tests.c
@@ -1248,6 +1248,48 @@ TEST_F(hmm, anon_teardown)
 	}
 }
 
+/*
+ * Test memory snapshot without faulting in pages accessed by the device.
+ */
+TEST_F(hmm, mixedmap)
+{
+	struct hmm_buffer *buffer;
+	unsigned long npages;
+	unsigned long size;
+	unsigned char *m;
+	int ret;
+
+	npages = 1;
+	size = npages << self->page_shift;
+
+	buffer = malloc(sizeof(*buffer));
+	ASSERT_NE(buffer, NULL);
+
+	buffer->fd = -1;
+	buffer->size = size;
+	buffer->mirror = malloc(npages);
+	ASSERT_NE(buffer->mirror, NULL);
+
+
+	/* Reserve a range of addresses. */
+	buffer->ptr = mmap(NULL, size,
+			   PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE,
+			   self->fd, 0);
+	ASSERT_NE(buffer->ptr, MAP_FAILED);
+
+	/* Simulate a device snapshotting CPU pagetables. */
+	ret = hmm_dmirror_cmd(self->fd, HMM_DMIRROR_SNAPSHOT, buffer, npages);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(buffer->cpages, npages);
+
+	/* Check what the device saw. */
+	m = buffer->mirror;
+	ASSERT_EQ(m[0], HMM_DMIRROR_PROT_READ);
+
+	hmm_buffer_free(buffer);
+}
+
 /*
  * Test memory snapshot without faulting in pages accessed by the device.
  */
-- 
2.30.2

