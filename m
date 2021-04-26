Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CB036B89C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbhDZSEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:04:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:22346 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234398AbhDZSDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:03:37 -0400
IronPort-SDR: l6sT0s+yCBdoxXhpYdFKFuJEClzk2ebssk5HsHzrdnZcFSW5kCCN1kNkuEnmOiHnsz/YyExUuI
 kKpRANUCqZGw==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="194263260"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="194263260"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:51 -0700
IronPort-SDR: 6h45lSLWMpEFOppZWmpClT07DOk2MBlSf30RxyUJ5qf0r+ELWN2vH3dqb8i6UlnDI4AFHf+6in
 gfQXMeK4Jd/Q==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="447353407"
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
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v2 18/32] ACPICA: ACPI 6.4: MADT: add Multiprocessor Wakeup Mailbox Structure
Date:   Mon, 26 Apr 2021 11:01:45 -0700
Message-Id: <d9d620be50f26fd85827a389943c838aeabcff40.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPICA commit f1ee04207a212f6c519441e7e25397649ebc4cea

Add Multiprocessor Wakeup Mailbox Structure definition. It is useful
in parsing MADT Wake table.

Link: https://github.com/acpica/acpica/commit/f1ee0420
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 include/acpi/actbl2.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index b2362600b9ff..7dce422f6119 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -733,6 +733,20 @@ struct acpi_madt_multiproc_wakeup {
 	u64 base_address;
 };
 
+#define ACPI_MULTIPROC_WAKEUP_MB_OS_SIZE	2032
+#define ACPI_MULTIPROC_WAKEUP_MB_FIRMWARE_SIZE	2048
+
+struct acpi_madt_multiproc_wakeup_mailbox {
+	u16 command;
+	u16 reserved;		/* reserved - must be zero */
+	u32 apic_id;
+	u64 wakeup_vector;
+	u8 reserved_os[ACPI_MULTIPROC_WAKEUP_MB_OS_SIZE];	/* reserved for OS use */
+	u8 reserved_firmware[ACPI_MULTIPROC_WAKEUP_MB_FIRMWARE_SIZE];	/* reserved for firmware use */
+};
+
+#define ACPI_MP_WAKE_COMMAND_WAKEUP    1
+
 /*
  * Common flags fields for MADT subtables
  */
-- 
2.25.1

