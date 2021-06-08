Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC8D39FB7A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 18:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbhFHQBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 12:01:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:60385 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232773AbhFHQBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 12:01:50 -0400
IronPort-SDR: OAXBTQQunjTGnLcEwcHh15hrBhzzA9JIUKtweDnSURcbzHIw3eCUi0Dto7QdJltyEH/9r09vbe
 dEJvhtdMeClQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="204688348"
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="204688348"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 08:59:56 -0700
IronPort-SDR: 9eSfKfvbZIgTtMVqcQbgf1/1hxXG4ZOJWx3YSbfHDlJbB7dI3mdE6q06Ls9MND56zO6TKSvbGb
 7HcV4O4F8uHA==
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="637683394"
Received: from ticela-az-103.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.36.77])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 08:59:55 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v2-fix-v3 0/4] x86/tdx: Handle in-kernel MMIO
Date:   Tue,  8 Jun 2021 08:59:20 -0700
Message-Id: <cover.1623167569.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAPcyv4jR4Ci=yKmCWk2toNFr-8NBy-MXfDYiH0Xmv9KFiBm2wQ@mail.gmail.com>
References: <CAPcyv4jR4Ci=yKmCWk2toNFr-8NBy-MXfDYiH0Xmv9KFiBm2wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset addresses the review comments in the patch titled
"x86/tdx: Handle in-kernel MMIO". Since it requires
patch split, sending these together.

Changes since RFC-v2-fix-v2:
 * Further divided patch "x86/sev-es: Abstract out MMIO instruction
   decoding", and moved generic APIs common to both TDX/SEV into
   seperate patches. Also introduced new patch for AMD code to utilize
   the generic APIs.
 * Fixed commit log as per review comments.

Changes since RFC v2-fix:
 * Introduced "x86/sev-es: Abstract out MMIO instruction
   decoding" patch for sharing common code between TDX
   and SEV.
 * Modified TDX MMIO code to utilize common shared functions.
 * Modified commit log to reflect latest changes and to
   address review comments.

Changes since RFC v2:
 * Fixed commit log as per Dave's review.

Kirill A. Shutemov (4):
  x86/insn-eval: Introduce insn_get_modrm_reg_ptr()
  x86/insn-eval: Introduce insn_decode_mmio()
  x86/sev-es: Use insn_decode_mmio() for MMIO implementation
  x86/tdx: Handle in-kernel MMIO

 arch/x86/include/asm/insn-eval.h |  13 +++
 arch/x86/kernel/sev.c            | 171 ++++++++-----------------------
 arch/x86/kernel/tdx.c            | 109 ++++++++++++++++++++
 arch/x86/lib/insn-eval.c         | 102 ++++++++++++++++++
 4 files changed, 264 insertions(+), 131 deletions(-)

-- 
2.25.1

