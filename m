Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5C934AB77
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhCZP1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:27:45 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37596 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhCZP1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:27:18 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1EE8820B5680;
        Fri, 26 Mar 2021 08:27:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1EE8820B5680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1616772437;
        bh=pjJC8+RuCiRNDhNHwIzgJu6U7+9wO1VcQ0wueos6N2Y=;
        h=From:To:Cc:Subject:Date:From;
        b=Gtq5M7e60kUb3b7t/PCrEEYN56deqD/0jJlgJSgugIK1US8nFGoDlMgdQDvu+GjMn
         eNoT7bBhYT6fpBZ917mdNtlALapS++F2ZGPgHezhGuSDuNrVoiA1QYCmjzT2YiFBYY
         mZChQi2j4Uu0DYlQIjcCMEX5msTo4GebuA6UHmS8=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: [PATCH] libnvdimm/region: Allow setting align attribute on regions without mappings
Date:   Fri, 26 Mar 2021 10:26:45 -0500
Message-Id: <20210326152645.85225-1-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The alignment constraint for namespace creation in a region was
increased, from 2M to 16M, for non-PowerPC architectures in v5.7 with
commit 2522afb86a8c ("libnvdimm/region: Introduce an 'align'
attribute"). The thought behind the change was that region alignment
should be uniform across all architectures and, since PowerPC had the
largest alignment constraint of 16M, all architectures should conform to
that alignment.

The change regressed namespace creation in pre-defined regions that
relied on 2M alignment but a workaround was provided in the form of a
sysfs attribute, named 'align', that could be adjusted to a non-default
alignment value.

However, the sysfs attribute's store function returned an error (-ENXIO)
when userspace attempted to change the alignment of a region that had no
mappings. This affected 2M aligned regions of volatile memory that were
defined in a device tree using "pmem-region" and created by the
of_pmem_region_driver, since those regions do not contain mappings
(ndr_mappings is 0).

Allow userspace to set the align attribute on pre-existing regions that
do not have mappings so that namespaces can still be within those
regions, despite not being aligned to 16M.

Fixes: 2522afb86a8c ("libnvdimm/region: Introduce an 'align' attribute")
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 drivers/nvdimm/region_devs.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index ef23119db574..09cff8aa6b40 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -545,29 +545,32 @@ static ssize_t align_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 {
 	struct nd_region *nd_region = to_nd_region(dev);
-	unsigned long val, dpa;
-	u32 remainder;
+	unsigned long val;
 	int rc;
 
 	rc = kstrtoul(buf, 0, &val);
 	if (rc)
 		return rc;
 
-	if (!nd_region->ndr_mappings)
-		return -ENXIO;
-
-	/*
-	 * Ensure space-align is evenly divisible by the region
-	 * interleave-width because the kernel typically has no facility
-	 * to determine which DIMM(s), dimm-physical-addresses, would
-	 * contribute to the tail capacity in system-physical-address
-	 * space for the namespace.
-	 */
-	dpa = div_u64_rem(val, nd_region->ndr_mappings, &remainder);
-	if (!is_power_of_2(dpa) || dpa < PAGE_SIZE
-			|| val > region_size(nd_region) || remainder)
+	if (val > region_size(nd_region))
 		return -EINVAL;
 
+	if (nd_region->ndr_mappings) {
+		unsigned long dpa;
+		u32 remainder;
+
+		/*
+		 * Ensure space-align is evenly divisible by the region
+		 * interleave-width because the kernel typically has no facility
+		 * to determine which DIMM(s), dimm-physical-addresses, would
+		 * contribute to the tail capacity in system-physical-address
+		 * space for the namespace.
+		 */
+		dpa = div_u64_rem(val, nd_region->ndr_mappings, &remainder);
+		if (!is_power_of_2(dpa) || dpa < PAGE_SIZE || remainder)
+			return -EINVAL;
+	}
+
 	/*
 	 * Given that space allocation consults this value multiple
 	 * times ensure it does not change for the duration of the
-- 
2.25.1

