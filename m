Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F59542341C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 01:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbhJEXIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 19:08:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:14151 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236962AbhJEXIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 19:08:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="205998499"
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; 
   d="scan'208";a="205998499"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 16:06:12 -0700
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; 
   d="scan'208";a="438907950"
Received: from alyee-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.5.222])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 16:06:11 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/6] Add TDX Guest Support (boot support)
Date:   Tue,  5 Oct 2021 16:05:44 -0700
Message-Id: <20211005230550.1819406-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Intel's Trust Domain Extensions (TDX) protect guest VMs from malicious
hosts and some physical attacks. This series adds boot code support
and some additional fixes required for successful boot of TDX guest.

This series is the continuation of the patch series titled "Add TDX Guest
Support (Initial support)" and "Add TDX Guest Support (#VE handler support
)", which added initial support and #VE handler support for TDX guests. You
can find the related patchsets in the following links.

[set 1, v8] - https://lore.kernel.org/lkml/20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com/
[set 2, v7] - https://lore.kernel.org/lkml/20211005204136.1812078-1-sathyanarayanan.kuppuswamy@linux.intel.com/

Also please note that this series alone is not necessarily fully
functional.

You can find TDX related documents in the following link.

https://software.intel.com/content/www/br/pt/develop/articles/intel-trust-domain-extensions.html

Changes since v6:
 * Included "x86/split_lock: Fix the split lock #AC handling when
   running as guest" part of this series.
 * Rebased on top of other TDX patches (set 1 & set 2).

Changes since v5:
 * Rebased on top of Tom Lendackys CC guest change.
 * Rebased on top of v5.15-rc1
 * No functional changes.

Changes since v4:
 * Renamed tdg_* prefix with tdx_*.
 * No functional changes.

Changes since v3:
 * Rebased on top of Tom Lendackys protected guest change.
 * No functional changes.

Changes since v2:
 * Rebased on top of v5.14-rc1.
 * No functional changes.

Changes since v1:
 * Rebased on top of v3 version of "Add TDX Guest Support (Initial support)"
   patchset. Since it had some changes at the TDCALL implementation level, we
   have to rebase other dependent patches.

Kuppuswamy Sathyanarayanan (2):
  x86/topology: Disable CPU online/offline control for TDX guest
  x86: Skip WBINVD instruction for VM guest

Sean Christopherson (3):
  x86/boot: Add a trampoline for APs booting in 64-bit mode
  x86/boot: Avoid #VE during boot for TDX platforms
  x86/tdx: Forcefully disable legacy PIC for TDX guests

Xiaoyao Li (1):
  x86/split_lock: Fix the split lock #AC handling when running as guest

 arch/x86/boot/compressed/head_64.S       | 16 +++++--
 arch/x86/boot/compressed/pgtable.h       |  2 +-
 arch/x86/include/asm/acenv.h             |  7 ++-
 arch/x86/include/asm/realmode.h          | 12 +++++
 arch/x86/kernel/cpu/intel.c              |  7 ++-
 arch/x86/kernel/head_64.S                | 20 +++++++-
 arch/x86/kernel/smpboot.c                |  2 +-
 arch/x86/kernel/tdx.c                    | 19 ++++++++
 arch/x86/kernel/topology.c               |  3 +-
 arch/x86/realmode/rm/header.S            |  1 +
 arch/x86/realmode/rm/trampoline_64.S     | 59 ++++++++++++++++++++++--
 arch/x86/realmode/rm/trampoline_common.S | 12 ++++-
 12 files changed, 145 insertions(+), 15 deletions(-)

-- 
2.25.1

