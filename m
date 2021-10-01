Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A348241EEF8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 15:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbhJAN67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 09:58:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:61582 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230408AbhJAN67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 09:58:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="222238877"
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="222238877"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 06:57:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,339,1624345200"; 
   d="scan'208";a="565017598"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 01 Oct 2021 06:57:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E76941AD; Fri,  1 Oct 2021 16:57:17 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuo Liu <shuo.a.liu@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Fei Li <fei1.li@intel.com>
Subject: [PATCH v1 1/1] virt: acrn: Drop internal kernel type from ABI
Date:   Fri,  1 Oct 2021 16:56:44 +0300
Message-Id: <20211001135644.1884-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

guid_t is internal type of the kernel which is mistakenly had been exposed
to the user space. Replace it with raw buffers.

Besides that it's obvious from the link in the sample code, that the real
use is of uuid_t type, but because uuid_t hasn't exposed, so should guid_t,
the code includes and uses wrong type.

Fixes: 5b06931d7f8b ("sample/acrn: Introduce a sample of HSM ioctl interface usage")
Fixes: 9c5137aedd11 ("virt: acrn: Introduce VM management interfaces")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/uapi/linux/acrn.h | 3 +--
 samples/acrn/vm-sample.c  | 5 ++++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/acrn.h b/include/uapi/linux/acrn.h
index 353b2a2e4536..4312af1b8013 100644
--- a/include/uapi/linux/acrn.h
+++ b/include/uapi/linux/acrn.h
@@ -12,7 +12,6 @@
 #define _UAPI_ACRN_H
 
 #include <linux/types.h>
-#include <linux/uuid.h>
 
 #define ACRN_IO_REQUEST_MAX		16
 
@@ -198,7 +197,7 @@ struct acrn_vm_creation {
 	__u16	reserved0;
 	__u16	vcpu_num;
 	__u16	reserved1;
-	guid_t	uuid;
+	__u8	uuid[16];
 	__u64	vm_flag;
 	__u64	ioreq_buf;
 	__u64	cpu_affinity;
diff --git a/samples/acrn/vm-sample.c b/samples/acrn/vm-sample.c
index b2dad47a77a0..1639fcadc766 100644
--- a/samples/acrn/vm-sample.c
+++ b/samples/acrn/vm-sample.c
@@ -30,7 +30,10 @@ static struct acrn_io_request *io_req_buf = (struct acrn_io_request *)io_request
 __u16 vcpu_num;
 __u16 vmid;
 /* POST_STANDARD_VM_UUID1, refer to https://github.com/projectacrn/acrn-hypervisor/blob/master/hypervisor/include/common/vm_uuids.h */
-guid_t vm_uuid = GUID_INIT(0x385479d2, 0xd625, 0xe811, 0x86, 0x4e, 0xcb, 0x7a, 0x18, 0xb3, 0x46, 0x43);
+__u8 vm_uuid[16] = {
+	0xd2, 0x79, 0x54, 0x38, 0x25, 0xd6, 0x11, 0xe8,
+	0x86, 0x4e, 0xcb, 0x7a, 0x18, 0xb3, 0x46, 0x43,
+};
 
 int hsm_fd;
 int is_running = 1;
-- 
2.33.0

