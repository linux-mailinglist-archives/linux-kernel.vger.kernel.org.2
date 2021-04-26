Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD9B36B89B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbhDZSEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:04:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:22347 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234387AbhDZSDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:03:37 -0400
IronPort-SDR: kwX4pRcgDxHrT/bbbYzFv7WBrxx6ijeccmqsx8dBM6GC178gBu/n9NVyULFbYxHbiLhE4TfQT0
 xiIqY17v6W+A==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="194263259"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="194263259"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:50 -0700
IronPort-SDR: Sub1XyoE6rhbaksTCZDFcifoKyZNR0Y5Z5Q6BrmW7raZi9DaAX4/QQvqPVherSlY8JcNF/Hb22
 YnBwM3OXcn+w==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="447353403"
Received: from ssumanpx-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.34.197])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:50 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [RFC v2 17/32] ACPICA: ACPI 6.4: MADT: add Multiprocessor Wakeup Structure
Date:   Mon, 26 Apr 2021 11:01:44 -0700
Message-Id: <63bc0f33c42dcdb2e2f834633fc59a3beb7ec9b6.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Erik Kaneda <erik.kaneda@intel.com>

ACPICA commit b9eb6f3a19b816824d6f47a6bc86fd8ce690e04b

Link: https://github.com/acpica/acpica/commit/b9eb6f3a
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index d6478c430c99..b2362600b9ff 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -516,7 +516,8 @@ enum acpi_madt_type {
 	ACPI_MADT_TYPE_GENERIC_MSI_FRAME = 13,
 	ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR = 14,
 	ACPI_MADT_TYPE_GENERIC_TRANSLATOR = 15,
-	ACPI_MADT_TYPE_RESERVED = 16	/* 16 and greater are reserved */
+	ACPI_MADT_TYPE_MULTIPROC_WAKEUP = 16,
+	ACPI_MADT_TYPE_RESERVED = 17	/* 17 and greater are reserved */
 };
 
 /*
@@ -723,6 +724,15 @@ struct acpi_madt_generic_translator {
 	u32 reserved2;
 };
 
+/* 16: Multiprocessor wakeup (ACPI 6.4) */
+
+struct acpi_madt_multiproc_wakeup {
+	struct acpi_subtable_header header;
+	u16 mailbox_version;
+	u32 reserved;		/* reserved - must be zero */
+	u64 base_address;
+};
+
 /*
  * Common flags fields for MADT subtables
  */
-- 
2.25.1

