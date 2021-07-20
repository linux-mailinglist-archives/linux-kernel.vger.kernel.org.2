Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610D63CF35B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 06:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244550AbhGTDyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 23:54:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:61766 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238610AbhGTDx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 23:53:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="190760788"
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="190760788"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 21:33:51 -0700
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="661016010"
Received: from ywei11-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.138.31])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 21:33:41 -0700
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
Subject: [PATCH v2 0/4] Add TDX Guest Support (Debug support)
Date:   Mon, 19 Jul 2021 21:33:34 -0700
Message-Id: <20210720043338.2123695-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Intel's Trust Domain Extensions (TDX) protect guest VMs from malicious
hosts and some physical attacks.

Following patches adds tracepoint support for TDX Guest TDCALL requests
and #VE exceptions. It also includes helper function to detect TD-DEBUG
mode which will be used by patches in other TDX series to add TD-DEBUG
mode specific features support.

This series is the continuation of the following TDX guest related patches.

[set 1] - https://lore.kernel.org/patchwork/project/lkml/list/?series=508773
[set 2] - https://lore.kernel.org/patchwork/project/lkml/list/?series=508792
[set 3] - https://lore.kernel.org/patchwork/project/lkml/list/?series=508794
[set 4] - https://lore.kernel.org/patchwork/project/lkml/list/?series=508795

Also please note that this series alone is not necessarily fully
functional. You need to apply all the above 4 patch series to get 
a fully functional TDX guest.

Changes since v1:
 * Rebased on top of v5.14-rc1.

Kuppuswamy Sathyanarayanan (3):
  x86/tdx: Add TDCALL tracepoint
  x86/tdx: Expose TDX Guest #VE count in /proc/interrupts
  x86/tdx: Add tdg_debug_enabled() interface

Sean Christopherson (1):
  x86/tdx: Add #VE tracepoint

 arch/x86/include/asm/hardirq.h   |   3 +
 arch/x86/include/asm/tdx.h       |   1 +
 arch/x86/include/asm/trace/tdx.h | 150 +++++++++++++++++++++++++++++++
 arch/x86/kernel/irq.c            |   6 ++
 arch/x86/kernel/tdx.c            |  71 ++++++++++++---
 arch/x86/kernel/traps.c          |   2 +
 6 files changed, 220 insertions(+), 13 deletions(-)
 create mode 100644 arch/x86/include/asm/trace/tdx.h

-- 
2.25.1

