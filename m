Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFB93DFA91
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 06:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbhHDEeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 00:34:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:41728 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234994AbhHDEcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 00:32:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="213574638"
X-IronPort-AV: E=Sophos;i="5.84,293,1620716400"; 
   d="scan'208";a="213574638"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 21:32:39 -0700
X-IronPort-AV: E=Sophos;i="5.84,293,1620716400"; 
   d="scan'208";a="511702729"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 21:32:39 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-mm@kvack.org
Subject: [PATCH V7 18/18] devdax: Enable stray access protection
Date:   Tue,  3 Aug 2021 21:32:31 -0700
Message-Id: <20210804043231.2655537-19-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210804043231.2655537-1-ira.weiny@intel.com>
References: <20210804043231.2655537-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Device dax is primarily accessed through user space.  Kernel access is
controlled through the kmap interfaces.

Now that all valid kernel initiated access to dax devices have been
accounted for with pgmap_mk_{readwrite,noaccess}() through kmap, turn
on PGMAP_PKEYS_PROTECT for device dax.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V7
	Use pgmap_protetion_enabled()
	s/PGMAP_PKEYS_PROTECT/PGMAP_PROTECTION/
---
 drivers/dax/device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index dd8222a42808..cdf6ef4c1edb 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -426,6 +426,8 @@ int dev_dax_probe(struct dev_dax *dev_dax)
 	}
 
 	pgmap->type = MEMORY_DEVICE_GENERIC;
+	if (pgmap_protection_enabled())
+		pgmap->flags |= PGMAP_PROTECTION;
 	addr = devm_memremap_pages(dev, pgmap);
 	if (IS_ERR(addr))
 		return PTR_ERR(addr);
-- 
2.28.0.rc0.12.gb6a658bd00c9

