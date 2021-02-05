Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA72311B35
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhBFE5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:57:21 -0500
Received: from mga09.intel.com ([134.134.136.24]:63285 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229884AbhBFDfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:35:11 -0500
IronPort-SDR: JP0e5Te/C2lKXSmAvFdHZq8J9uu6VrECf/C3tHsmBSCVsq0QRJaRSt9zHXNTIvfbCKyWCFwp93
 m7d4ujFUZ/uQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="181650738"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="181650738"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:12 -0800
IronPort-SDR: H/5kBlMvrU19a1v53+8Q1Cf/kqhAvUzw60xoX68GvKjaef4kfJjICz6CYVOMoXuYSyePCok5Vs
 eRDSynvIUavA==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="416183925"
Received: from mdhake-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.53.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:11 -0800
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [RFC v1 14/26] ACPI: tables: Add multiprocessor wake-up support
Date:   Fri,  5 Feb 2021 15:38:31 -0800
Message-Id: <a4c4dbe6d60d354bfed2859cc6f7114390b10909.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per Guest-Host Communication Interface (GHCI)
Specification for Intel TDX, sec 4.1, a new sub
structure – multiprocessor wake-up structure - is added to the
ACPI Multiple APIC Description Table (MADT) to describe the
information of the mailbox. If a platform firmware produces the
multiprocessor wake-up structure, then the BSP in OS may use this
new mailbox-based mechanism to wake up the APs.

Add ACPI MADT wake table parsing support and if MADT wake table is
present, update apic->wakeup_secondary_cpu with new API which
uses MADT wake mailbox to wake-up CPU.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/include/asm/apic.h     |  3 ++
 arch/x86/kernel/acpi/boot.c     | 56 +++++++++++++++++++++++++++++++++
 arch/x86/kernel/apic/probe_32.c |  8 +++++
 arch/x86/kernel/apic/probe_64.c |  8 +++++
 drivers/acpi/tables.c           |  9 ++++++
 include/acpi/actbl2.h           | 21 ++++++++++++-
 6 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 34cb3c159481..63f970c61cbe 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -497,6 +497,9 @@ static inline unsigned int read_apic_id(void)
 	return apic->get_apic_id(reg);
 }
 
+typedef int (*wakeup_cpu_handler)(int apicid, unsigned long start_eip);
+extern void acpi_wake_cpu_handler_update(wakeup_cpu_handler handler);
+
 extern int default_apic_id_valid(u32 apicid);
 extern int default_acpi_madt_oem_check(char *, char *);
 extern void default_setup_apic_routing(void);
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 7bdc0239a943..37ada1908fb7 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -65,6 +65,9 @@ int acpi_fix_pin2_polarity __initdata;
 static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
 #endif
 
+static struct acpi_madt_mp_wake_mailbox *acpi_mp_wake_mailbox;
+static u64 acpi_mp_wake_mailbox_paddr;
+
 #ifdef CONFIG_X86_IO_APIC
 /*
  * Locks related to IOAPIC hotplug
@@ -329,6 +332,29 @@ acpi_parse_lapic_nmi(union acpi_subtable_headers * header, const unsigned long e
 	return 0;
 }
 
+static void acpi_mp_wake_mailbox_init(void)
+{
+	if (acpi_mp_wake_mailbox)
+		return;
+
+	acpi_mp_wake_mailbox = memremap(acpi_mp_wake_mailbox_paddr,
+			sizeof(*acpi_mp_wake_mailbox), MEMREMAP_WB);
+}
+
+static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
+{
+	acpi_mp_wake_mailbox_init();
+
+	if (!acpi_mp_wake_mailbox)
+		return -EINVAL;
+
+	WRITE_ONCE(acpi_mp_wake_mailbox->apic_id, apicid);
+	WRITE_ONCE(acpi_mp_wake_mailbox->wakeup_vector, start_ip);
+	WRITE_ONCE(acpi_mp_wake_mailbox->command, ACPI_MP_WAKE_COMMAND_WAKEUP);
+
+	return 0;
+}
+
 #endif				/*CONFIG_X86_LOCAL_APIC */
 
 #ifdef CONFIG_X86_IO_APIC
@@ -1086,6 +1112,30 @@ static int __init acpi_parse_madt_lapic_entries(void)
 	}
 	return 0;
 }
+
+static int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
+				      const unsigned long end)
+{
+	struct acpi_madt_mp_wake *mp_wake = NULL;
+
+	if (!IS_ENABLED(CONFIG_SMP))
+		return -ENODEV;
+
+	mp_wake = (struct acpi_madt_mp_wake *)header;
+	if (BAD_MADT_ENTRY(mp_wake, end))
+		return -EINVAL;
+
+	if (acpi_mp_wake_mailbox)
+		return -EINVAL;
+
+	acpi_table_print_madt_entry(&header->common);
+
+	acpi_mp_wake_mailbox_paddr = mp_wake->mailbox_address;
+
+	acpi_wake_cpu_handler_update(acpi_wakeup_cpu);
+
+	return 0;
+}
 #endif				/* CONFIG_X86_LOCAL_APIC */
 
 #ifdef	CONFIG_X86_IO_APIC
@@ -1284,6 +1334,12 @@ static void __init acpi_process_madt(void)
 
 				smp_found_config = 1;
 			}
+
+			/*
+			 * Parse MADT MP Wake entry.
+			 */
+			acpi_table_parse_madt(ACPI_MADT_TYPE_MP_WAKE,
+					      acpi_parse_mp_wake, 1);
 		}
 		if (error == -EINVAL) {
 			/*
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index a61f642b1b90..d450014841b2 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -207,3 +207,11 @@ int __init default_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 	}
 	return 0;
 }
+
+void __init acpi_wake_cpu_handler_update(wakeup_cpu_handler handler)
+{
+	struct apic **drv;
+
+	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++)
+		(*drv)->wakeup_secondary_cpu = handler;
+}
diff --git a/arch/x86/kernel/apic/probe_64.c b/arch/x86/kernel/apic/probe_64.c
index c46720f185c0..986dbb68d3c4 100644
--- a/arch/x86/kernel/apic/probe_64.c
+++ b/arch/x86/kernel/apic/probe_64.c
@@ -50,3 +50,11 @@ int __init default_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 	}
 	return 0;
 }
+
+void __init acpi_wake_cpu_handler_update(wakeup_cpu_handler handler)
+{
+	struct apic **drv;
+
+	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++)
+		(*drv)->wakeup_secondary_cpu = handler;
+}
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index e48690a006a4..5e38748c5db1 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -207,6 +207,15 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		}
 		break;
 
+	case ACPI_MADT_TYPE_MP_WAKE:
+		{
+			struct acpi_madt_mp_wake *p =
+				(struct acpi_madt_mp_wake *)header;
+			pr_debug("MP Wake (version[%d] mailbox_address[%llx])\n",
+				 p->version, p->mailbox_address);
+		}
+		break;
+
 	default:
 		pr_warn("Found unsupported MADT entry (type = 0x%x)\n",
 			header->type);
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index ec66779cb193..be953b638499 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -517,7 +517,8 @@ enum acpi_madt_type {
 	ACPI_MADT_TYPE_GENERIC_MSI_FRAME = 13,
 	ACPI_MADT_TYPE_GENERIC_REDISTRIBUTOR = 14,
 	ACPI_MADT_TYPE_GENERIC_TRANSLATOR = 15,
-	ACPI_MADT_TYPE_RESERVED = 16	/* 16 and greater are reserved */
+	ACPI_MADT_TYPE_MP_WAKE = 16,
+	ACPI_MADT_TYPE_RESERVED = 17	/* 17 and greater are reserved */
 };
 
 /*
@@ -724,6 +725,24 @@ struct acpi_madt_generic_translator {
 	u32 reserved2;
 };
 
+/* 16: MP Wake (ACPI 6.?) */
+
+struct acpi_madt_mp_wake {
+	struct acpi_subtable_header header;
+	u16 version;
+	u32 reserved2;
+	u64 mailbox_address;
+};
+
+struct acpi_madt_mp_wake_mailbox {
+	u16 command;
+	u16 flags;
+	u32 apic_id;
+	u64 wakeup_vector;
+};
+
+#define ACPI_MP_WAKE_COMMAND_WAKEUP	1
+
 /*
  * Common flags fields for MADT subtables
  */
-- 
2.25.1

