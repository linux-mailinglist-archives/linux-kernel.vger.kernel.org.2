Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15783993B5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 21:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhFBTob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 15:44:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:49276 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229611AbhFBToa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 15:44:30 -0400
IronPort-SDR: QLqGfIaLcPZlJ3jkt2t9+jhiY4t2UWEF6NVoc7F7x6iV0vG+2APoINqgpL+kAe6BLnzDfjdmg5
 Uc2l7SFzUKGA==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="265054735"
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="265054735"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 12:42:43 -0700
IronPort-SDR: 3NNe3E2HhZJZfdVk41qoWbeyC153/aN+AHcDPdoXx0XHlyjDVcf8fJRP8fdvB38BUN1wGnVYez
 6qDpL0FKS9tQ==
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="445965410"
Received: from ccmolito-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.34.188])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 12:42:42 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC v2-fix-v2 0/2] x86/tdx: Handle in-kernel MMIO
Date:   Wed,  2 Jun 2021 12:42:17 -0700
Message-Id: <20210602194220.2227863-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3e9a26c3-8eee-88f5-f8e2-8a2dd2c028ea@intel.com>
References: <3e9a26c3-8eee-88f5-f8e2-8a2dd2c028ea@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset addresses the review comments in the patch titled
"x86/tdx: Handle in-kernel MMIO". Since it requires
patch split, sending these together.

Changes since RFC v2-fix:
 * Introduced "x86/sev-es: Abstract out MMIO instruction
   decoding" patch for sharing common code between TDX
   and SEV.
 * Modified TDX MMIO code to utilize common shared functions.
 * Modified commit log to reflect latest changes and to
   address review comments.

Changes since RFC v2:
 * Fixed commit log as per Dave's review.

Kirill A. Shutemov (2):
  x86/sev-es: Abstract out MMIO instruction decoding
  x86/tdx: Handle in-kernel MMIO

 arch/x86/include/asm/insn-eval.h |  13 +++
 arch/x86/kernel/sev.c            | 171 ++++++++-----------------------
 arch/x86/kernel/tdx.c            | 108 +++++++++++++++++++
 arch/x86/lib/insn-eval.c         | 102 ++++++++++++++++++
 4 files changed, 263 insertions(+), 131 deletions(-)

-- 
2.25.1

