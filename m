Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85EBD396A9B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 03:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhFAB36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 21:29:58 -0400
Received: from mga04.intel.com ([192.55.52.120]:3203 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231714AbhFAB35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 21:29:57 -0400
IronPort-SDR: v5u3useogAbn07TsB0wy6tmSRllfL+G1JqHlkr4/IIfDP/AgKkjhMqBIg1KBkj7p54/8dADw+d
 rmCCP6VQ+X7Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="201581159"
X-IronPort-AV: E=Sophos;i="5.83,238,1616482800"; 
   d="scan'208";a="201581159"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 18:28:16 -0700
IronPort-SDR: LdflEPn/pqMd1nuxECE8lFxsc4K+3L/1UEpfsLCaBHPxYmMv31o8M4L3UIabZ/T24I7C0K3/1z
 icAgTLaEa5Zg==
X-IronPort-AV: E=Sophos;i="5.83,238,1616482800"; 
   d="scan'208";a="548894154"
Received: from mjdelaro-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.3.23])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 18:28:15 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC v2-fix-v3 1/1] x86/tdx: ioapic: Add shared bit for IOAPIC base address
Date:   Mon, 31 May 2021 18:28:05 -0700
Message-Id: <20210601012805.3559-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210524232940.801877-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210524232940.801877-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since RFC v2-fix-v2:
 * Replaced is_tdx_guest() call with protected_guest_has() call.
 * Used pgprot_protected_guest() instead of prot_tdg_shared().

Changes since RFC v2:
 * Fixed commit log and comment as per review comment

 arch/x86/kernel/apic/io_apic.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 73ff4dd426a8..9c0dff0d7aa4 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -49,6 +49,7 @@
 #include <linux/slab.h>
 #include <linux/memblock.h>
 #include <linux/msi.h>
+#include <linux/protected_guest.h>
 
 #include <asm/irqdomain.h>
 #include <asm/io.h>
@@ -2675,6 +2676,18 @@ static struct resource * __init ioapic_setup_resources(void)
 	return res;
 }
 
+static void io_apic_set_fixmap_nocache(enum fixed_addresses idx,
+				       phys_addr_t phys)
+{
+	pgprot_t flags = FIXMAP_PAGE_NOCACHE;
+
+	/* Set TDX guest shared bit in pgprot flags */
+	if (protected_guest_has(VM_SHARED_MAPPING_INIT))
+		flags = pgprot_protected_guest(flags);
+
+	__set_fixmap(idx, phys, flags);
+}
+
 void __init io_apic_init_mappings(void)
 {
 	unsigned long ioapic_phys, idx = FIX_IO_APIC_BASE_0;
@@ -2707,7 +2720,7 @@ void __init io_apic_init_mappings(void)
 				      __func__, PAGE_SIZE, PAGE_SIZE);
 			ioapic_phys = __pa(ioapic_phys);
 		}
-		set_fixmap_nocache(idx, ioapic_phys);
+		io_apic_set_fixmap_nocache(idx, ioapic_phys);
 		apic_printk(APIC_VERBOSE, "mapped IOAPIC to %08lx (%08lx)\n",
 			__fix_to_virt(idx) + (ioapic_phys & ~PAGE_MASK),
 			ioapic_phys);
@@ -2836,7 +2849,7 @@ int mp_register_ioapic(int id, u32 address, u32 gsi_base,
 	ioapics[idx].mp_config.flags = MPC_APIC_USABLE;
 	ioapics[idx].mp_config.apicaddr = address;
 
-	set_fixmap_nocache(FIX_IO_APIC_BASE_0 + idx, address);
+	io_apic_set_fixmap_nocache(FIX_IO_APIC_BASE_0 + idx, address);
 	if (bad_ioapic_register(idx)) {
 		clear_fixmap(FIX_IO_APIC_BASE_0 + idx);
 		return -ENODEV;
-- 
2.25.1

