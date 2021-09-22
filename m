Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3888241539C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 00:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238353AbhIVW4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 18:56:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:62851 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238293AbhIVW4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 18:56:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="221832430"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="221832430"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 15:54:47 -0700
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="653457324"
Received: from mnamagi-mobl1.gar.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.34.84])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 15:54:46 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 00/10] Add TDX Guest Support (#VE handler support)
Date:   Wed, 22 Sep 2021 15:52:29 -0700
Message-Id: <20210922225239.3501262-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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

[set 1, v7] - https://lore.kernel.org/lkml/20210916183550.15349-1-sathyanarayanan.kuppuswamy@linux.intel.com/

Also please note that this series alone is not necessarily fully
functional.

You can find TDX related documents in the following link.

https://software.intel.com/content/www/br/pt/develop/articles/intel-trust-domain-extensions.html

Changes since v5:
 * Rebased on top of v5.15-rc1.
 * Rebased on top of Tom Landeckys latest CC support patches.

Changes since v4:
 * Renamed tdg_ prefix to tdx_.
 * Rest of changelogs are included in patches in-line.

Changes since v3:
 * Rebased on top of Tom Lendacky protected guest changes.
 * Rest of changelogs are included in patches in-line.

Changes since v2:
 * Rebased on top of v5.14-rc1.
 * Rest of changelogs are included in patches in-line.

Changes since v1:
 * Rebased on top of TDX guest set 1 patches (which had some core API changes).
 * Moved "x86/tdx: Add early_is_tdx_guest() interface" patch from set 1 patch
   series to this patchset (since it is only used in early I/O support case).
 * Rest of changelogs are included in patches in-line.

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
  x86/tdx: Add early_is_tdx_guest() interface
  x86/tdx: Handle port I/O in decompression code
  x86/tdx: Handle MWAIT and MONITOR

 arch/x86/boot/compressed/Makefile |   2 +
 arch/x86/boot/compressed/tdcall.S |   3 +
 arch/x86/boot/compressed/tdx.c    |  31 +++++
 arch/x86/boot/cpuflags.c          |  12 +-
 arch/x86/boot/cpuflags.h          |   2 +
 arch/x86/include/asm/insn-eval.h  |  13 ++
 arch/x86/include/asm/io.h         |  24 +++-
 arch/x86/include/asm/tdx.h        |  64 +++++++++
 arch/x86/kernel/cpu/intel.c       |   1 +
 arch/x86/kernel/head64.c          |   3 +
 arch/x86/kernel/sev.c             | 171 ++++++------------------
 arch/x86/kernel/tdx.c             | 211 ++++++++++++++++++++++++++++++
 arch/x86/lib/insn-eval.c          | 102 +++++++++++++++
 include/linux/cc_platform.h       |  11 ++
 14 files changed, 511 insertions(+), 139 deletions(-)
 create mode 100644 arch/x86/boot/compressed/tdcall.S
 create mode 100644 arch/x86/boot/compressed/tdx.c

-- 
2.25.1

