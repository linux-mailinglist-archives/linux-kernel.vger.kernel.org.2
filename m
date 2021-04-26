Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E33136B8A0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbhDZSFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:05:12 -0400
Received: from mga04.intel.com ([192.55.52.120]:22347 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234421AbhDZSDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:03:38 -0400
IronPort-SDR: RuvxSEjzou+LVFCt5oetjjsQQ6xKVDrDREEmx6WywHVT+8UQu2NBm3DYdiKLYhNhTZnyxi6I5A
 28yMy9OV2pgw==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="194263266"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="194263266"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:52 -0700
IronPort-SDR: I+W78jMXLuZTpxBuRUQV1nGEsKHLHQVXhQYvb9YWhQu/g8cJQ/uihDmh4I+t8AVFC6pwEGFgkL
 XgktldjYKlHQ==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="447353415"
Received: from ssumanpx-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.34.197])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:51 -0700
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
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [RFC v2 20/32] x86/acpi, x86/boot: Add multiprocessor wake-up support
Date:   Mon, 26 Apr 2021 11:01:47 -0700
Message-Id: <7668517006b7be1c3558ddde4f43e87b5ce814de.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per ACPI specification r6.4, sec 5.2.12.19, a new sub
structure – multiprocessor wake-up structure - is added to the
ACPI Multiple APIC Description Table (MADT) to describe the
information of the mailbox. If a platform firmware produces the
multiprocessor wake-up structure, then OS may use this new
mailbox-based mechanism to wake up the APs.

Add ACPI MADT wake table parsing support for x86 platform and if
MADT wake table is present, update apic->wakeup_secondary_cpu with
new API which uses MADT wake mailbox to wake-up CPU.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/include/asm/apic.h |  3 ++
 arch/x86/kernel/acpi/boot.c | 79 +++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/apic/apic.c |  8 ++++
 3 files changed, 90 insertions(+)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 412b51e059c8..3e94e1f402ea 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -487,6 +487,9 @@ static inline unsigned int read_apic_id(void)
 	return apic->get_apic_id(reg);
 }
 
+typedef int (*wakeup_cpu_handler)(int apicid, unsigned long start_eip);
+extern void acpi_wake_cpu_handler_update(wakeup_cpu_handler handler);
+
 extern int default_apic_id_valid(u32 apicid);
 extern int default_acpi_madt_oem_check(char *, char *);
 extern void default_setup_apic_routing(void);
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 14cd3186dc77..fce2aa7d718f 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -65,6 +65,9 @@ int acpi_fix_pin2_polarity __initdata;
 static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
 #endif
 
+static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
+static u64 acpi_mp_wake_mailbox_paddr;
+
 #ifdef CONFIG_X86_IO_APIC
 /*
  * Locks related to IOAPIC hotplug
@@ -329,6 +332,52 @@ acpi_parse_lapic_nmi(union acpi_subtable_headers * header, const unsigned long e
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
+	u8 timeout = 0xFF;
+
+	acpi_mp_wake_mailbox_init();
+
+	if (!acpi_mp_wake_mailbox)
+		return -EINVAL;
+
+	/*
+	 * Mailbox memory is shared between firmware and OS. Firmware will
+	 * listen on mailbox command address, and once it receives the wakeup
+	 * command, CPU associated with the given apicid will be booted. So,
+	 * the value of apic_id and wakeup_vector has to be set before updating
+	 * the wakeup command. So use WRITE_ONCE to let the compiler know about
+	 * it and preserve the order of writes.
+	 */
+	WRITE_ONCE(acpi_mp_wake_mailbox->apic_id, apicid);
+	WRITE_ONCE(acpi_mp_wake_mailbox->wakeup_vector, start_ip);
+	WRITE_ONCE(acpi_mp_wake_mailbox->command, ACPI_MP_WAKE_COMMAND_WAKEUP);
+
+	/*
+	 * After writing wakeup command, wait for maximum timeout of 0xFF
+	 * for firmware to reset the command address back zero to indicate
+	 * the successful reception of command.
+	 * NOTE: 255 as timeout value is decided based on our experiments.
+	 *
+	 * XXX: Change the timeout once ACPI specification comes up with
+	 *      standard maximum timeout value.
+	 */
+	while (READ_ONCE(acpi_mp_wake_mailbox->command) && timeout--)
+		cpu_relax();
+
+	/* If timedout, return error */
+	return timeout ? 0 : -EIO;
+}
+
 #endif				/*CONFIG_X86_LOCAL_APIC */
 
 #ifdef CONFIG_X86_IO_APIC
@@ -1086,6 +1135,30 @@ static int __init acpi_parse_madt_lapic_entries(void)
 	}
 	return 0;
 }
+
+static int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
+				      const unsigned long end)
+{
+	struct acpi_madt_multiproc_wakeup *mp_wake;
+
+	if (acpi_mp_wake_mailbox)
+		return -EINVAL;
+
+	if (!IS_ENABLED(CONFIG_SMP))
+		return -ENODEV;
+
+	mp_wake = (struct acpi_madt_multiproc_wakeup *) header;
+	if (BAD_MADT_ENTRY(mp_wake, end))
+		return -EINVAL;
+
+	acpi_table_print_madt_entry(&header->common);
+
+	acpi_mp_wake_mailbox_paddr = mp_wake->base_address;
+
+	acpi_wake_cpu_handler_update(acpi_wakeup_cpu);
+
+	return 0;
+}
 #endif				/* CONFIG_X86_LOCAL_APIC */
 
 #ifdef	CONFIG_X86_IO_APIC
@@ -1284,6 +1357,12 @@ static void __init acpi_process_madt(void)
 
 				smp_found_config = 1;
 			}
+
+			/*
+			 * Parse MADT MP Wake entry.
+			 */
+			acpi_table_parse_madt(ACPI_MADT_TYPE_MULTIPROC_WAKEUP,
+					      acpi_parse_mp_wake, 1);
 		}
 		if (error == -EINVAL) {
 			/*
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 4f26700f314d..f1b90a4b89e8 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2554,6 +2554,14 @@ u32 x86_msi_msg_get_destid(struct msi_msg *msg, bool extid)
 }
 EXPORT_SYMBOL_GPL(x86_msi_msg_get_destid);
 
+void __init acpi_wake_cpu_handler_update(wakeup_cpu_handler handler)
+{
+	struct apic **drv;
+
+	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++)
+		(*drv)->wakeup_secondary_cpu = handler;
+}
+
 /*
  * Override the generic EOI implementation with an optimized version.
  * Only called during early boot when only one CPU is active and with
-- 
2.25.1

