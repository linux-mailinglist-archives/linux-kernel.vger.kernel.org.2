Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B900F3A1F4B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 23:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhFIVsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 17:48:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:4874 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230246AbhFIVsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 17:48:16 -0400
IronPort-SDR: rtjjvy+7w2l9XIE1mHBMiERV/Pp8zllxa7NTUUggEsYT8VH2v2TH1M4RjCfkrp7oUOT0bmnt42
 LyPNPXVwY9lg==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="266330399"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="266330399"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 14:46:21 -0700
IronPort-SDR: lHS51KRXIu/qUGpDveCBDosUSasck356g7OAsKhB4W38LS/BsfjfwmgdSEUOCBCu0X6ufHhE+U
 69LzT2s4jL5g==
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="448450472"
Received: from qwang4-mobl1.ccr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.35.228])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 14:46:19 -0700
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
Subject: [PATCH v1 00/10] Add TDX Guest Support (#VE handler support)
Date:   Wed,  9 Jun 2021 14:45:45 -0700
Message-Id: <20210609214555.1955404-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Intel's Trust Domain Extensions (TDX) protect guest VMs from malicious
hosts and some physical attacks. This series adds #VE handler support,
for port I/O, MMIO and MWAIT/MONITOR features in TDX guest.

This series is the continuation of the patch series titled "Add TDX Guest
Support (Initial support)" which added initial support for TDX guests. You
can find the patchset in the following link.

https://lore.kernel.org/patchwork/project/lkml/list/?series=502143

Protected Guest support patch which is common for both AMD SEV and TDX
guest is also included in this patch series because port IO #VE handler
support has dependency on it.

Also please note that this series alone is not necessarily fully
functional.

You can find TDX related documents in the following link.

https://software.intel.com/content/www/br/pt/develop/articles/intel-trust-domain-extensions.html

Andi Kleen (1):
  x86/tdx: Handle early IO operations

Kirill A. Shutemov (6):
  x86/io: Allow to override inX() and outX() implementation
  x86/tdx: Handle port I/O
  x86/insn-eval: Introduce insn_get_modrm_reg_ptr()
  x86/insn-eval: Introduce insn_decode_mmio()
  x86/sev-es: Use insn_decode_mmio() for MMIO implementation
  x86/tdx: Handle in-kernel MMIO

Kuppuswamy Sathyanarayanan (3):
  x86: Introduce generic protected guest abstraction
  x86/tdx: Handle port I/O in decompression code
  x86/tdx: Handle MWAIT and MONITOR

 arch/Kconfig                           |   3 +
 arch/x86/Kconfig                       |   2 +
 arch/x86/boot/compressed/Makefile      |   1 +
 arch/x86/boot/compressed/tdcall.S      |   3 +
 arch/x86/include/asm/insn-eval.h       |  13 ++
 arch/x86/include/asm/io.h              |  23 ++-
 arch/x86/include/asm/protected_guest.h |  20 +++
 arch/x86/include/asm/sev.h             |   3 +
 arch/x86/include/asm/tdx.h             |  61 +++++++
 arch/x86/kernel/head64.c               |   3 +
 arch/x86/kernel/sev.c                  | 186 +++++++--------------
 arch/x86/kernel/tdx.c                  | 216 +++++++++++++++++++++++++
 arch/x86/lib/insn-eval.c               | 102 ++++++++++++
 arch/x86/mm/mem_encrypt.c              |   1 +
 include/linux/protected_guest.h        |  24 +++
 15 files changed, 524 insertions(+), 137 deletions(-)
 create mode 100644 arch/x86/boot/compressed/tdcall.S
 create mode 100644 arch/x86/include/asm/protected_guest.h
 create mode 100644 include/linux/protected_guest.h

-- 
2.25.1

