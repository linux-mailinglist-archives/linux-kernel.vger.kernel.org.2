Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD453B4EFB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 16:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhFZO2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 10:28:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:18176 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230108AbhFZO2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 10:28:07 -0400
IronPort-SDR: ZG8JOXEClYouVn/YY8gIPtXssY4Rk7/CX29MuBAxz5Wm/DQ14zga626aKJKCyzAjzhigasde44
 mQtDvJOzyQPg==
X-IronPort-AV: E=McAfee;i="6200,9189,10027"; a="195087082"
X-IronPort-AV: E=Sophos;i="5.83,301,1616482800"; 
   d="scan'208";a="195087082"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2021 07:25:45 -0700
X-IronPort-AV: E=Sophos;i="5.83,301,1616482800"; 
   d="scan'208";a="640382972"
Received: from mlubyani-mobl2.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.8.25])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2021 07:25:44 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [PATCH v2 7/7] x86/tdx: ioapic: Add shared bit for IOAPIC base address
Date:   Sat, 26 Jun 2021 07:25:35 -0700
Message-Id: <9c34d620353d63152d4b08e30109721ae222cbf8.1624667052.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1624667052.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1624667052.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Isaku Yamahata <isaku.yamahata@intel.com>

The kernel interacts with each bare-metal IOAPIC with a special
MMIO page. When running under KVM, the guest's IOAPICs are
emulated by KVM.

When running as a TDX guest, the guest needs to mark each IOAPIC
mapping as "shared" with the host.  This ensures that TDX private
protections are not applied to the page, which allows the TDX host
emulation to work.

Earlier patches in this series modified ioremap() so that
ioremap()-created mappings such as virtio will be marked as
shared. However, the IOAPIC code does not use ioremap() and instead
uses the fixmap mechanism.

Introduce a special fixmap helper just for the IOAPIC code.  Ensure
that it marks IOAPIC pages as "shared".  This replaces
set_fixmap_nocache() with __set_fixmap() since __set_fixmap()
allows custom 'prot' values.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/kernel/apic/io_apic.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index d5c691a3208b..be967c73683e 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -49,6 +49,7 @@
 #include <linux/slab.h>
 #include <linux/memblock.h>
 #include <linux/msi.h>
+#include <linux/protected_guest.h>
 
 #include <asm/irqdomain.h>
 #include <asm/io.h>
@@ -65,6 +66,7 @@
 #include <asm/irq_remapping.h>
 #include <asm/hw_irq.h>
 #include <asm/apic.h>
+#include <asm/tdx.h>
 
 #define	for_each_ioapic(idx)		\
 	for ((idx) = 0; (idx) < nr_ioapics; (idx)++)
@@ -2675,6 +2677,18 @@ static struct resource * __init ioapic_setup_resources(void)
 	return res;
 }
 
+static void io_apic_set_fixmap_nocache(enum fixed_addresses idx,
+				       phys_addr_t phys)
+{
+	pgprot_t flags = FIXMAP_PAGE_NOCACHE;
+
+	/* Set TDX guest shared bit in pgprot flags */
+	if (prot_guest_has(PR_GUEST_SHARED_MAPPING_INIT))
+		flags = pgprot_protected_guest(flags);
+
+	__set_fixmap(idx, phys, flags);
+}
+
 void __init io_apic_init_mappings(void)
 {
 	unsigned long ioapic_phys, idx = FIX_IO_APIC_BASE_0;
@@ -2707,7 +2721,7 @@ void __init io_apic_init_mappings(void)
 				      __func__, PAGE_SIZE, PAGE_SIZE);
 			ioapic_phys = __pa(ioapic_phys);
 		}
-		set_fixmap_nocache(idx, ioapic_phys);
+		io_apic_set_fixmap_nocache(idx, ioapic_phys);
 		apic_printk(APIC_VERBOSE, "mapped IOAPIC to %08lx (%08lx)\n",
 			__fix_to_virt(idx) + (ioapic_phys & ~PAGE_MASK),
 			ioapic_phys);
@@ -2836,7 +2850,7 @@ int mp_register_ioapic(int id, u32 address, u32 gsi_base,
 	ioapics[idx].mp_config.flags = MPC_APIC_USABLE;
 	ioapics[idx].mp_config.apicaddr = address;
 
-	set_fixmap_nocache(FIX_IO_APIC_BASE_0 + idx, address);
+	io_apic_set_fixmap_nocache(FIX_IO_APIC_BASE_0 + idx, address);
 	if (bad_ioapic_register(idx)) {
 		clear_fixmap(FIX_IO_APIC_BASE_0 + idx);
 		return -ENODEV;
-- 
2.25.1

