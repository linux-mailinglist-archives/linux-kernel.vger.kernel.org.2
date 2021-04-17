Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DB0362D24
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 05:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbhDQDNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 23:13:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:51209 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235613AbhDQDNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 23:13:16 -0400
IronPort-SDR: 9EroxlIML7PA+JGf/G7Oh5IsXQcazA4ZRgL8CuSE9VeLSTG3X5oqJ90GO6IsiclfSFBmXit/iH
 JFC+g8EwV44Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="195168021"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="195168021"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 20:12:50 -0700
IronPort-SDR: jszdzjwDiu0x0hPWiOnKEJ5tDmUixbkPY8OjiI5PEv1PJvz8vs3fRir1Ghn5LtyjhiNfswnk4j
 D72f7Osk9wLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="451639876"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Apr 2021 20:12:50 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 11EA85808F0;
        Fri, 16 Apr 2021 20:12:50 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
        hdegoede@redhat.com, mgross@linux.intel.com,
        gayatri.kammela@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 9/9] platform/x86: intel_pmc_core: Add support for Alder Lake PCH-P
Date:   Fri, 16 Apr 2021 20:12:52 -0700
Message-Id: <20210417031252.3020837-10-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210417031252.3020837-1-david.e.box@linux.intel.com>
References: <20210417031252.3020837-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alder PCH-P is based on Tiger Lake PCH.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
---

V2:	No change

 drivers/platform/x86/intel_pmc_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 786b67171ddc..900aa5e40a0f 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -1577,6 +1577,7 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	&tgl_reg_map),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	&icl_reg_map),
 	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&tgl_reg_map),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&tgl_reg_map),
 	{}
 };
 
-- 
2.25.1

