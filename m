Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D7B3E08C8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 21:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240725AbhHDT2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 15:28:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:42526 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231281AbhHDT2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 15:28:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="235953219"
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="235953219"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 12:27:47 -0700
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="585563744"
Received: from mjkendri-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.17.117])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 12:27:46 -0700
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
Subject: [PATCH v4 0/5] Add TDX Guest Support (boot fixes)
Date:   Wed,  4 Aug 2021 12:27:23 -0700
Message-Id: <20210804192729.2902472-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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

[set 1, v5] - https://lore.kernel.org/patchwork/project/lkml/list/?series=510805
[set 2, v4] - https://lore.kernel.org/patchwork/project/lkml/list/?series=510814

Also please note that this series alone is not necessarily fully
functional.

You can find TDX related documents in the following link.

https://software.intel.com/content/www/br/pt/develop/articles/intel-trust-domain-extensions.html

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

 arch/x86/boot/compressed/head_64.S       | 16 +++++--
 arch/x86/boot/compressed/pgtable.h       |  2 +-
 arch/x86/include/asm/acenv.h             |  7 ++-
 arch/x86/include/asm/realmode.h          | 12 +++++
 arch/x86/kernel/head_64.S                | 20 +++++++-
 arch/x86/kernel/smpboot.c                |  2 +-
 arch/x86/kernel/tdx.c                    | 18 ++++++++
 arch/x86/kernel/topology.c               |  3 +-
 arch/x86/realmode/rm/header.S            |  1 +
 arch/x86/realmode/rm/trampoline_64.S     | 59 ++++++++++++++++++++++--
 arch/x86/realmode/rm/trampoline_common.S | 12 ++++-
 11 files changed, 138 insertions(+), 14 deletions(-)

-- 
2.25.1

