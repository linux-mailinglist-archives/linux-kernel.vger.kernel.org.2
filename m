Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0C538E0C7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 08:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhEXGEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 02:04:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:3169 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229824AbhEXGES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 02:04:18 -0400
IronPort-SDR: MdgdGCjn0RAEiqBjFbmrP+N0l5MMMnp5hlpgsDUbzqOKT8nSO6D1Xs/sdErryuTrINuOTcS21V
 j+pnGaFL7hUw==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="189245952"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="189245952"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 23:02:49 -0700
IronPort-SDR: A9Fivcv/5lpFq4bIKS5c3GKeL/6di7jdiUZRN9y2bj2BmypMXwznTXkOSYZsB7G75agY815OPS
 wfnGiXA/MBVA==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="441882334"
Received: from eyoukerh-mobl.ger.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.2.69])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 23:02:48 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Rafael J Wysocki <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Len Brown <lenb@kernel.org>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/1] x86/acpi, x86/boot: Add multiprocessor wake-up support
Date:   Sun, 23 May 2021 23:02:21 -0700
Message-Id: <20210524060221.519093-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <e4dc31d5-d897-50fa-34e7-f5c033d5f5db@linux.intel.com>
References: <e4dc31d5-d897-50fa-34e7-f5c033d5f5db@linux.intel.com>
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

Changes since v4:
 * Used smp_store_release() in place of WRITE_ONCE().
 * Addressed some checkpatch warnings.

Changes since v3:
 * Removed acpi_mp_wake_mailbox_init() and moved init code to
   acpi_wakeup_cpu().
 * Removed redundant NULL pointer check for acpi_mp_wake_mailbox.
 * Added comments/debug prints as per Rafael's suggestion.
 * Removed MADT/SVKL ACPI patches from this patchset. It will be
   merged via ACPICA submission.

 arch/x86/include/asm/apic.h |  3 ++
 arch/x86/kernel/acpi/boot.c | 96 +++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/apic/apic.c |  8 ++++
 3 files changed, 107 insertions(+)

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
index 14cd3186dc77..c51134eb55d0 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -65,6 +65,10 @@ int acpi_fix_pin2_polarity __initdata;
 static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
 #endif
 
+static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
+static u64 acpi_mp_wake_mailbox_paddr;
+static physid_mask_t apic_id_wakemap = PHYSID_MASK_NONE;
+
 #ifdef CONFIG_X86_IO_APIC
 /*
  * Locks related to IOAPIC hotplug
@@ -329,6 +333,68 @@ acpi_parse_lapic_nmi(union acpi_subtable_headers * header, const unsigned long e
 	return 0;
 }
 
+static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
+{
+	u8 timeout = 0xFF;
+
+	/* Remap mailbox memory only for the first call to acpi_wakeup_cpu() */
+	if (physids_empty(apic_id_wakemap)) {
+		acpi_mp_wake_mailbox = memremap(acpi_mp_wake_mailbox_paddr,
+						sizeof(*acpi_mp_wake_mailbox),
+						MEMREMAP_WB);
+	}
+
+	/*
+	 * According to the ACPI specification r6.4, sec 5.2.12.19, the
+	 * mailbox-based wakeup mechanism cannot be used more than once
+	 * for the same CPU, so skip sending wake commands to already
+	 * awake CPU.
+	 */
+	if (physid_isset(apicid, apic_id_wakemap)) {
+		pr_err("CPU already awake (APIC ID %x), skipping wakeup\n",
+		       apicid);
+		return -EINVAL;
+	}
+
+	/*
+	 * Mailbox memory is shared between firmware and OS. Firmware will
+	 * listen on mailbox command address, and once it receives the wakeup
+	 * command, CPU associated with the given apicid will be booted. So,
+	 * the value of apic_id and wakeup_vector has to be set before updating
+	 * the wakeup command. So use smp_store_release to let the compiler know
+	 * about it and preserve the order of writes.
+	 */
+	smp_store_release(&acpi_mp_wake_mailbox->apic_id, apicid);
+	smp_store_release(&acpi_mp_wake_mailbox->wakeup_vector, start_ip);
+	smp_store_release(&acpi_mp_wake_mailbox->command,
+			  ACPI_MP_WAKE_COMMAND_WAKEUP);
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
+	if (timeout) {
+		/*
+		 * If the CPU wakeup process is successful, store the
+		 * status in apic_id_wakemap to prevent re-wakeup
+		 * requests.
+		 */
+		physid_set(apicid, apic_id_wakemap);
+		return 0;
+	}
+
+	/* If timed out (timeout == 0), return error */
+	return -EIO;
+}
+
 #endif				/*CONFIG_X86_LOCAL_APIC */
 
 #ifdef CONFIG_X86_IO_APIC
@@ -1086,6 +1152,30 @@ static int __init acpi_parse_madt_lapic_entries(void)
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
+	mp_wake = (struct acpi_madt_multiproc_wakeup *)header;
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
@@ -1284,6 +1374,12 @@ static void __init acpi_process_madt(void)
 
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

