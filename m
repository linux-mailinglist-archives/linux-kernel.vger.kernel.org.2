Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAEDE447334
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 15:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbhKGOMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 09:12:09 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:26294 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbhKGOMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 09:12:08 -0500
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HnGFt69HRzQj7k;
        Sun,  7 Nov 2021 22:04:34 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Sun, 7 Nov 2021 22:09:22 +0800
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Sun, 7 Nov 2021 22:09:21 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <andraprs@amazon.com>, <lexnv@amazon.com>, <alcioa@amazon.com>
CC:     <arei.gonglei@huawei.com>, <gregkh@linuxfoundation.org>,
        <kamal@canonical.com>, <pbonzini@redhat.com>,
        <sgarzare@redhat.com>, <stefanha@redhat.com>,
        <vkuznets@redhat.com>, <linux-kernel@vger.kernel.org>,
        <ne-devel-upstream@amazon.com>, Longpeng <longpeng2@huawei.com>
Subject: [PATCH v5 0/4] Merge contiguous physical memory regions
Date:   Sun, 7 Nov 2021 22:09:13 +0800
Message-ID: <20211107140918.2106-1-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml100016.china.huawei.com (7.185.36.216)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Longpeng <longpeng2@huawei.com>

Hi guys,

This patchset try to merge the contiguous physical memory regions when
set user memory regions, you can see message in PATCH 1 for details.
Please review when you free, thank!

Changes v4 -> v5:
  Patch 1:
    - "Physical contiguous memory regions" -> "Contiguous physical memory 
      regions."  [Andra]
    - fix the warning of aligment that reported by the checkpath.pl  [Andra]
  Patch 4:
    - fix the warning of aligment that reported by the checkpath.pl  [Andra]
    - remove unnecessary comparison of NULL.  [Andra]

Changes v3 -> v4:
  Patch 1:
    - move "#include <linux/range.h>" according to the alphabetical order. [Andra]
    - rename several variables, parameters, structures and functions.  [Andra]
    - add missing "Context" in the comments.  [Andra]
    - some other changes to makes the code much neater.  [Andra]
  Patch 2:
    - add missing "Context" in the comments.  [Andra]
    - move the comment in ne_merge_phys_contig_memory_regions() before
      the "if (...)". [Andra]
  Patch 3:
    - Nitro enclaves -> Nitro Enclaves   [Andra]
    - check the return code of "ne_misc_dev_test_init()"  [Andra]
    - GPL-2.0-or-later -> GPL-2.0  [Andra]
  Patch 4:
    - "int expect_num" -> "unsigned long  expect_num"  [Andra]
    - rename several variables and structures  [Andra]
    - invoke "kunit_kfree" to free the "regions"  [Andra]

Changes v2 -> v3:
  Patch 1:
    - update the commit title and commit message.  [Andra]
    - use 'struct range' to instead of 'struct phys_mem_region'.  [Andra, Greg KH]
    - add comments before the function definition.  [Andra]
    - rename several variables, parameters and function.  [Andra]
  Patch 2:
    - update the commit title and commit message.  [Andra]
    - add comments before the function definition.  [Andra]
    - remove 'inline' attribute of ne_sanity_check_phys_mem_region. [Andra]
    - leave a blank line before return.  [Andra]
    - move sanity check in ne_merge_phys_contig_memory_regions to
      the beginning of the function.  [Andra]
    - double sanity checking after the merge of physical contiguous
      memory regions has been completed.  [Andra]
  Patch 3:
    - update the commit title and commit message.  [Andra]
    - use "misc_dev"/"misc device"/"MISC_DEV" to be more specific.  [Andra]
  Patch 4:
    - update the commit title and commit message.  [Andra]
    - align the fileds in 'struct phys_regions_test'.  [Andra]
    - rename 'phys_regions_testcases' to 'phys_regions_test_cases'.  [Andra]
    - add comments before each test cases.  [Andra]
    - initialize the variables in ne_misc_dev_test_merge_phys_contig_memory_regions.  [Andra]

Changes v1 -> v2:
  - update the commit message as Andra's suggestion  [Andra]
  - remove TODO completely in ne_set_user_memory_region_ioctl  [Andra]
  - extract the physical memory regions setup into individual
    function
  - add kunit tests  [Andra]

Longpeng (4):
  nitro_enclaves: Merge contiguous physical memory regions
  nitro_enclaves: Sanity check physical memory regions during merging
  nitro_enclaves: Add KUnit tests setup for the misc device
    functionality
  nitro_enclaves: Add KUnit tests for contiguous physical memory regions
    merging

 drivers/virt/nitro_enclaves/Kconfig            |   9 ++
 drivers/virt/nitro_enclaves/ne_misc_dev.c      | 174 ++++++++++++++++++-------
 drivers/virt/nitro_enclaves/ne_misc_dev_test.c | 157 ++++++++++++++++++++++
 3 files changed, 296 insertions(+), 44 deletions(-)
 create mode 100644 drivers/virt/nitro_enclaves/ne_misc_dev_test.c

-- 
1.8.3.1

