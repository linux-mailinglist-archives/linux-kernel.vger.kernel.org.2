Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAD83A1F75
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 23:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhFIV5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 17:57:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:1779 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229542AbhFIV5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 17:57:42 -0400
IronPort-SDR: puh5ZZ5fhmdtztwCwtWZWVHLw0UwONT2+4V6N9JDdPMOXBEghIzAQIk6xXld07gfkCgK6uITqB
 vHVpHJ5p96Ww==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="205208536"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="205208536"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 14:55:47 -0700
IronPort-SDR: /+jQjvMFUSsS6g98hbXX4WwOVC66BIVbktcC2my5BuFvhvKm5GIIFoW47OsUlVn11Ie8XzQ4KL
 1mgBHjPA+f/A==
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="482555055"
Received: from qwang4-mobl1.ccr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.35.228])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 14:55:45 -0700
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
Subject: [PATCH v1 0/7] Add TDX Guest Support (shared-mm support)
Date:   Wed,  9 Jun 2021 14:55:30 -0700
Message-Id: <20210609215537.1956150-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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

https://lore.kernel.org/patchwork/project/lkml/list/?series=502143
https://lore.kernel.org/patchwork/project/lkml/list/?series=503701
https://lore.kernel.org/patchwork/project/lkml/list/?series=503702

Also please note that this series alone is not necessarily fully
functional. You need to apply all the above 3 patch series to get
a fully functional TDX guest.

You can find TDX related documents in the following link.

https://software.intel.com/content/www/br/pt/develop/articles/intel-trust-domain-extensions.html

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
 arch/x86/include/asm/tdx.h                | 23 +++++++++
 arch/x86/kernel/apic/io_apic.c            | 17 ++++++-
 arch/x86/kernel/tdx.c                     | 58 +++++++++++++++++++++++
 arch/x86/mm/Makefile                      |  2 +
 arch/x86/mm/ioremap.c                     |  9 ++--
 arch/x86/mm/mem_encrypt.c                 | 10 ++--
 arch/x86/mm/mem_encrypt_common.c          | 39 +++++++++++++++
 arch/x86/mm/pat/set_memory.c              | 46 +++++++++++++++---
 11 files changed, 218 insertions(+), 20 deletions(-)
 create mode 100644 arch/x86/include/asm/mem_encrypt_common.h
 create mode 100644 arch/x86/mm/mem_encrypt_common.c

-- 
2.25.1

