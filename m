Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99933CF309
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 06:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245231AbhGTDee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 23:34:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:8799 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236175AbhGTDdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 23:33:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="232950370"
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="232950370"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 21:13:51 -0700
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="468818626"
Received: from ywei11-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.138.31])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 21:13:50 -0700
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
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/7] Add TDX Guest Support (shared-mm support)
Date:   Mon, 19 Jul 2021 21:13:39 -0700
Message-Id: <20210720041346.2121680-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Intel's Trust Domain Extensions (TDX) protect guest VMs from malicious
hosts and some physical attacks. Since VMM is untrusted entity, it does
not allow VMM to access guest private memory. Any memory that is required
for communication with VMM must be shared explicitly. This series adds
support to securely share guest memory with VMM when it is required by
guest.

This series is the continuation of the patch series titled "Add TDX Guest
Support (Initial support)", "Add TDX Guest Support (#VE handler support)"
and "Add TDX Guest Support (boot fixes)" which added initial support,
 #VE handler support and boot fixes for TDX guests. You  can find the
related patchsets in the following links.

[set 1] - https://lore.kernel.org/patchwork/project/lkml/list/?series=508773
[set 2] - https://lore.kernel.org/patchwork/project/lkml/list/?series=508792
[set 3] - https://lore.kernel.org/patchwork/project/lkml/list/?series=508794

Also please note that this series alone is not necessarily fully
functional. You need to apply all the above 3 patch series to get
a fully functional TDX guest.

You can find TDX related documents in the following link.

https://software.intel.com/content/www/br/pt/develop/articles/intel-trust-domain-extensions.html

Changes since v2:
 * Rebased on top of v5.14-rc1.
 * No functional changes.

Isaku Yamahata (1):
  x86/tdx: ioapic: Add shared bit for IOAPIC base address

Kirill A. Shutemov (6):
  x86/mm: Move force_dma_unencrypted() to common code
  x86/tdx: Exclude Shared bit from physical_mask
  x86/tdx: Make pages shared in ioremap()
  x86/tdx: Add helper to do MapGPA hypercall
  x86/tdx: Make DMA pages shared
  x86/kvm: Use bounce buffers for TD guest

 arch/x86/Kconfig                          |  9 +++-
 arch/x86/include/asm/mem_encrypt_common.h | 20 ++++++++
 arch/x86/include/asm/pgtable.h            |  5 ++
 arch/x86/include/asm/tdx.h                | 22 +++++++++
 arch/x86/kernel/apic/io_apic.c            | 18 ++++++-
 arch/x86/kernel/tdx.c                     | 60 +++++++++++++++++++++++
 arch/x86/mm/Makefile                      |  2 +
 arch/x86/mm/ioremap.c                     | 10 ++--
 arch/x86/mm/mem_encrypt.c                 | 10 ++--
 arch/x86/mm/mem_encrypt_common.c          | 38 ++++++++++++++
 arch/x86/mm/pat/set_memory.c              | 49 +++++++++++++++---
 11 files changed, 222 insertions(+), 21 deletions(-)
 create mode 100644 arch/x86/include/asm/mem_encrypt_common.h
 create mode 100644 arch/x86/mm/mem_encrypt_common.c

-- 
2.25.1

