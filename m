Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC8C3CF2E9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 05:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348694AbhGTDLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 23:11:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:24179 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348005AbhGTDJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 23:09:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="211229334"
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="211229334"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 20:49:23 -0700
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="661006621"
Received: from ywei11-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.138.31])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 20:49:23 -0700
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
Subject: [PATCH v3 00/10] Add TDX Guest Support (#VE handler support)
Date:   Mon, 19 Jul 2021 20:48:51 -0700
Message-Id: <20210720034901.2120205-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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

[set 1] - https://lore.kernel.org/patchwork/project/lkml/list/?series=508773

Also please note that this series alone is not necessarily fully
functional.

You can find TDX related documents in the following link.

https://software.intel.com/content/www/br/pt/develop/articles/intel-trust-domain-extensions.html

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
 arch/x86/include/asm/io.h         |  23 +++-
 arch/x86/include/asm/tdx.h        |  66 ++++++++++
 arch/x86/kernel/head64.c          |   3 +
 arch/x86/kernel/sev.c             | 171 ++++++-------------------
 arch/x86/kernel/tdx.c             | 204 ++++++++++++++++++++++++++++++
 arch/x86/lib/insn-eval.c          | 102 +++++++++++++++
 12 files changed, 493 insertions(+), 139 deletions(-)
 create mode 100644 arch/x86/boot/compressed/tdcall.S
 create mode 100644 arch/x86/boot/compressed/tdx.c

-- 
2.25.1

