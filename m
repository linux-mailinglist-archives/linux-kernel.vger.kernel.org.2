Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31604521A7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 02:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346375AbhKPBFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 20:05:55 -0500
Received: from mga11.intel.com ([192.55.52.93]:28686 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1359748AbhKPA6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 19:58:40 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="231044927"
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; 
   d="scan'208";a="231044927"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 16:45:58 -0800
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; 
   d="scan'208";a="671742568"
Received: from asu1-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.20.192])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 16:45:57 -0800
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/4] Share common features between AMD SEV / TDX guest
Date:   Mon, 15 Nov 2021 16:45:24 -0800
Message-Id: <20211116004528.2928887-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Intel's Trust Domain Extensions (TDX) protect guest VMs from malicious
hosts and some physical attacks. TDX has a lot of similarities to AMD SEV.
Features like encryption/decryption and string I/O unroll support can
be shared between these two technologies.

This patch set adds infrastructure changes required to share the code
between AMD SEV and TDX.

Kirill A. Shutemov (1):
  x86: Move common memory encryption code to mem_encrypt.c

Kuppuswamy Sathyanarayanan (3):
  x86/sev: Remove sev_enable_key usage in outs##bwl()/ins##bwl()
  x86/sev: Use CC_ATTR attribute to generalize string I/O unroll
  x86/sev: Rename mem_encrypt.c to mem_encrypt_amd.c

 arch/x86/Kconfig              |  10 +-
 arch/x86/include/asm/io.h     |  20 +-
 arch/x86/kernel/cc_platform.c |   4 +
 arch/x86/mm/Makefile          |   7 +-
 arch/x86/mm/mem_encrypt.c     | 443 +---------------------------------
 arch/x86/mm/mem_encrypt_amd.c | 438 +++++++++++++++++++++++++++++++++
 include/linux/cc_platform.h   |  11 +
 7 files changed, 474 insertions(+), 459 deletions(-)
 create mode 100644 arch/x86/mm/mem_encrypt_amd.c

-- 
2.25.1

