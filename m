Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E66E396D6D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 08:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbhFAGgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 02:36:22 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2810 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbhFAGgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 02:36:17 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FvMhc667ZzWq3w;
        Tue,  1 Jun 2021 14:29:52 +0800 (CST)
Received: from dggpemm500012.china.huawei.com (7.185.36.89) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 14:34:34 +0800
Received: from DESKTOP-EFRLNPK.china.huawei.com (10.174.176.189) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 14:34:33 +0800
From:   Qiheng Lin <linqiheng@huawei.com>
To:     <mike.travis@hpe.com>, <dimitri.sivanich@hpe.com>,
        <russ.anderson@hpe.com>, <dvhart@infradead.org>,
        <andy@infradead.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <x86@kernel.org>, <hpa@zytor.com>
CC:     <steve.wahl@hpe.com>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Qiheng Lin <linqiheng@huawei.com>
Subject: [PATCH v2 -next] x86/platform/uv: Remove the unneeded extern keyword
Date:   Tue, 1 Jun 2021 14:30:34 +0800
Message-ID: <20210601063034.27433-1-linqiheng@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.174.176.189]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500012.china.huawei.com (7.185.36.89)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function declarations in bios.h are already marked extern, so remove
them in the definition.

This problem was caught by the sparse tool:
 function 'uv_bios_get_master_nasid' with external linkage has definition
 function 'uv_bios_get_heapsize' with external linkage has definition
 function 'uv_bios_install_heap' with external linkage has definition
 function 'uv_bios_obj_count' with external linkage has definition
 function 'uv_bios_enum_objs' with external linkage has definition
 function 'uv_bios_enum_ports' with external linkage has definition
 function 'uv_bios_get_geoinfo' with external linkage has definition
 function 'uv_bios_get_pci_topology' with external linkage has definition

Signed-off-by: Qiheng Lin <linqiheng@huawei.com>
---
Changes in v2:
 - adjust the subject and commit message

 arch/x86/platform/uv/bios_uv.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
index bf31af3d32d6..7e7634c8be62 100644
--- a/arch/x86/platform/uv/bios_uv.c
+++ b/arch/x86/platform/uv/bios_uv.c
@@ -172,55 +172,55 @@ int uv_bios_set_legacy_vga_target(bool decode, int domain, int bus)
 				(u64)decode, (u64)domain, (u64)bus, 0, 0);
 }
 
-extern s64 uv_bios_get_master_nasid(u64 size, u64 *master_nasid)
+s64 uv_bios_get_master_nasid(u64 size, u64 *master_nasid)
 {
 	return uv_bios_call(UV_BIOS_EXTRA, 0, UV_BIOS_EXTRA_MASTER_NASID, 0,
 				size, (u64)master_nasid);
 }
 EXPORT_SYMBOL_GPL(uv_bios_get_master_nasid);
 
-extern s64 uv_bios_get_heapsize(u64 nasid, u64 size, u64 *heap_size)
+s64 uv_bios_get_heapsize(u64 nasid, u64 size, u64 *heap_size)
 {
 	return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_GET_HEAPSIZE,
 				0, size, (u64)heap_size);
 }
 EXPORT_SYMBOL_GPL(uv_bios_get_heapsize);
 
-extern s64 uv_bios_install_heap(u64 nasid, u64 heap_size, u64 *bios_heap)
+s64 uv_bios_install_heap(u64 nasid, u64 heap_size, u64 *bios_heap)
 {
 	return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_INSTALL_HEAP,
 				0, heap_size, (u64)bios_heap);
 }
 EXPORT_SYMBOL_GPL(uv_bios_install_heap);
 
-extern s64 uv_bios_obj_count(u64 nasid, u64 size, u64 *objcnt)
+s64 uv_bios_obj_count(u64 nasid, u64 size, u64 *objcnt)
 {
 	return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_OBJECT_COUNT,
 				0, size, (u64)objcnt);
 }
 EXPORT_SYMBOL_GPL(uv_bios_obj_count);
 
-extern s64 uv_bios_enum_objs(u64 nasid, u64 size, u64 *objbuf)
+s64 uv_bios_enum_objs(u64 nasid, u64 size, u64 *objbuf)
 {
 	return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_ENUM_OBJECTS,
 				0, size, (u64)objbuf);
 }
 EXPORT_SYMBOL_GPL(uv_bios_enum_objs);
 
-extern s64 uv_bios_enum_ports(u64 nasid, u64 obj_id, u64 size, u64 *portbuf)
+s64 uv_bios_enum_ports(u64 nasid, u64 obj_id, u64 size, u64 *portbuf)
 {
 	return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_ENUM_PORTS,
 				obj_id, size, (u64)portbuf);
 }
 EXPORT_SYMBOL_GPL(uv_bios_enum_ports);
 
-extern s64 uv_bios_get_geoinfo(u64 nasid, u64 size, u64 *buf)
+s64 uv_bios_get_geoinfo(u64 nasid, u64 size, u64 *buf)
 {
 	return uv_bios_call(UV_BIOS_GET_GEOINFO, nasid, (u64)buf, size, 0, 0);
 }
 EXPORT_SYMBOL_GPL(uv_bios_get_geoinfo);
 
-extern s64 uv_bios_get_pci_topology(u64 size, u64 *buf)
+s64 uv_bios_get_pci_topology(u64 size, u64 *buf)
 {
 	return uv_bios_call(UV_BIOS_GET_PCI_TOPOLOGY, (u64)buf, size, 0, 0, 0);
 }
-- 
2.31.1

