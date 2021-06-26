Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76843B4F02
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 16:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhFZOfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 10:35:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:16420 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhFZOfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 10:35:14 -0400
IronPort-SDR: sAWbm2P2PtJrwX31yLqimy1iB65MYdXYFZvtEgSEhz/UtwvYG58YBdKRAuNh7hA7opLZ71KDEd
 wSqT3RYL231w==
X-IronPort-AV: E=McAfee;i="6200,9189,10027"; a="188174862"
X-IronPort-AV: E=Sophos;i="5.83,301,1616482800"; 
   d="scan'208";a="188174862"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2021 07:32:51 -0700
X-IronPort-AV: E=Sophos;i="5.83,301,1616482800"; 
   d="scan'208";a="475134343"
Received: from mlubyani-mobl2.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.8.25])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2021 07:32:50 -0700
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
Subject: [PATCH v1 0/4] Add TDX Guest Support (Debug support)
Date:   Sat, 26 Jun 2021 07:32:40 -0700
Message-Id: <cover.1624717684.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

[set 1] - https://lore.kernel.org/patchwork/project/lkml/list/?series=505232
[set 2] - https://lore.kernel.org/patchwork/project/lkml/list/?series=506230
[set 3] - https://lore.kernel.org/patchwork/project/lkml/list/?series=506231
[set 4] - https://lore.kernel.org/patchwork/project/lkml/list/?series=506232

Also please note that this series alone is not necessarily fully
functional. You need to apply all the above 4 patch series to get 
a fully functional TDX guest.



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

