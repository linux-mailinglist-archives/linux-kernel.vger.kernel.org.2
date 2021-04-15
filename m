Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F25360AEE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 15:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbhDONrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 09:47:00 -0400
Received: from mga12.intel.com ([192.55.52.136]:16378 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231391AbhDONqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 09:46:54 -0400
IronPort-SDR: TSuQuZovKGxgTiJNrgjzNT185pvFmj4HHSp9T/Pjz6P6uS4EMedxNR9PkRAjZi5dHAw3z38FLi
 Nx+TTOJPaH2A==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="174349061"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="174349061"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 06:46:30 -0700
IronPort-SDR: u2uZssqTys+8Gc4MtRXWS7kFK+8hKU90Pe/y4BI/aYbQOIul2Lkm5tWXKENxWglWuAvrl5Irgk
 1wDi7SFV+afA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="461619424"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 15 Apr 2021 06:46:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0899B12A; Thu, 15 Apr 2021 16:46:43 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vaibhav Jain <vaibhav@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v1 1/1] powerpc/papr_scm: Properly handle UUID types and API
Date:   Thu, 15 Apr 2021 16:46:37 +0300
Message-Id: <20210415134637.17770-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse to and export from UUID own type, before dereferencing.
This also fixes wrong comment (Little Endian UUID is something else)
and should fix Sparse warnings about assigning strict types to POD.

Fixes: 43001c52b603 ("powerpc/papr_scm: Use ibm,unit-guid as the iset cookie")
Fixes: 259a948c4ba1 ("powerpc/pseries/scm: Use a specific endian format for storing uuid from the device tree")
Cc: Oliver O'Halloran <oohall@gmail.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Not tested
 arch/powerpc/platforms/pseries/papr_scm.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index ae6f5d80d5ce..4366e1902890 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -1085,8 +1085,9 @@ static int papr_scm_probe(struct platform_device *pdev)
 	u32 drc_index, metadata_size;
 	u64 blocks, block_size;
 	struct papr_scm_priv *p;
+	u8 uuid_raw[UUID_SIZE];
 	const char *uuid_str;
-	u64 uuid[2];
+	uuid_t uuid;
 	int rc;
 
 	/* check we have all the required DT properties */
@@ -1129,16 +1130,18 @@ static int papr_scm_probe(struct platform_device *pdev)
 	p->hcall_flush_required = of_property_read_bool(dn, "ibm,hcall-flush-required");
 
 	/* We just need to ensure that set cookies are unique across */
-	uuid_parse(uuid_str, (uuid_t *) uuid);
+	uuid_parse(uuid_str, &uuid);
+
 	/*
 	 * cookie1 and cookie2 are not really little endian
-	 * we store a little endian representation of the
+	 * we store a raw buffer representation of the
 	 * uuid str so that we can compare this with the label
 	 * area cookie irrespective of the endian config with which
 	 * the kernel is built.
 	 */
-	p->nd_set.cookie1 = cpu_to_le64(uuid[0]);
-	p->nd_set.cookie2 = cpu_to_le64(uuid[1]);
+	export_uuid(uuid_raw, &uuid);
+	p->nd_set.cookie1 = get_unaligned_le64(&uuid_raw[0]);
+	p->nd_set.cookie2 = get_unaligned_le64(&uuid_raw[8]);
 
 	/* might be zero */
 	p->metadata_size = metadata_size;
-- 
2.30.2

