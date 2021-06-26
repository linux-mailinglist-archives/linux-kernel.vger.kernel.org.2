Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3573B4EED
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 16:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhFZOYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 10:24:49 -0400
Received: from mga03.intel.com ([134.134.136.65]:10767 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhFZOYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 10:24:48 -0400
IronPort-SDR: d1bgSvAnhyNROBn61JkLICQFStL3FY5tRJayoYUO9DwsbAgulDFfrJYQdWXM+OzERRTF8uipPY
 dG0rq63iCOVg==
X-IronPort-AV: E=McAfee;i="6200,9189,10027"; a="207828219"
X-IronPort-AV: E=Sophos;i="5.83,301,1616482800"; 
   d="scan'208";a="207828219"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2021 07:22:25 -0700
X-IronPort-AV: E=Sophos;i="5.83,301,1616482800"; 
   d="scan'208";a="640382630"
Received: from mlubyani-mobl2.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.8.25])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2021 07:22:25 -0700
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
Subject: [PATCH v2 0/5] Add TDX Guest Support (boot fixes)
Date:   Sat, 26 Jun 2021 07:22:08 -0700
Message-Id: <cover.1624666915.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

[set 1] - https://lore.kernel.org/patchwork/project/lkml/list/?series=505232
[set 2] - https://lore.kernel.org/patchwork/project/lkml/list/?series=506230

Also please note that this series alone is not necessarily fully
functional.

You can find TDX related documents in the following link.

https://software.intel.com/content/www/br/pt/develop/articles/intel-trust-domain-extensions.html

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

