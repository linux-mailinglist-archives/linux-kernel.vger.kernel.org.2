Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18154392619
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 06:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhE0EZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 00:25:48 -0400
Received: from mga17.intel.com ([192.55.52.151]:56123 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229453AbhE0EZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 00:25:45 -0400
IronPort-SDR: lcOFcnNHPCxk2/uvZUR2stcHLGvQFc5G/LTLFKSs9spX6rnIVkhbNH/39EKowiXscIn2TKKdrg
 9z1gxPWiBXnA==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="182979643"
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="182979643"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 21:24:12 -0700
IronPort-SDR: vTsaw6QNaM/5cgvOZHBHc/jzqVYYdLz1srgA4CeZJ31uwN1Yn8rbWDsNebYiorPAs3KYb8QZkS
 QlN/fpwTAjwQ==
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="480391407"
Received: from skgangad-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.33.45])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 21:24:12 -0700
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
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC v2-fix-v1 0/3] x86/tdx: Handle port I/O
Date:   Wed, 26 May 2021 21:23:53 -0700
Message-Id: <20210527042356.3983284-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAPcyv4gBNqDFQEYjWqYTckPg-yy=LrvMw_FNY+tUuEwD35CfyA@mail.gmail.com>
References: <CAPcyv4gBNqDFQEYjWqYTckPg-yy=LrvMw_FNY+tUuEwD35CfyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset addresses the review comments in the patch titled
"[RFC v2 14/32] x86/tdx: Handle port I/O". Since it requires
patch split, sending these together.

Changes since RFC v2:
 * Removed assembly implementation of port IO emulation code
   and modified __in/__out IO helpers to directly call C function
   for in/out instruction emulation in decompression code.
 * Added helper function tdx_get_iosize() to make it easier for
   calling tdg_out/tdg_int() C functions from decompression code.
 * Added support for early exception handler to support IO
   instruction emulation in early boot kernel code.
 * Removed alternative_ usage and made kernel only use #VE based
   IO instruction emulation support outside the decompression module.
 * Added support for protection_guest_has() API to generalize
   AMD SEV/TDX specific initialization code in common drivers.
 * Fixed commit log and comments as per review comments.


Andi Kleen (1):
  x86/tdx: Handle early IO operations

Kirill A. Shutemov (1):
  x86/tdx: Handle port I/O

Kuppuswamy Sathyanarayanan (1):
  tdx: Introduce generic protected_guest abstraction

 arch/Kconfig                           |   3 +
 arch/x86/Kconfig                       |   1 +
 arch/x86/boot/compressed/Makefile      |   1 +
 arch/x86/boot/compressed/tdcall.S      |   3 +
 arch/x86/boot/compressed/tdx.c         |  28 ++++++
 arch/x86/include/asm/io.h              |   7 +-
 arch/x86/include/asm/protected_guest.h |  24 +++++
 arch/x86/include/asm/tdx.h             |  60 ++++++++++++-
 arch/x86/kernel/head64.c               |   4 +
 arch/x86/kernel/tdx.c                  | 116 +++++++++++++++++++++++++
 include/linux/protected_guest.h        |  23 +++++
 11 files changed, 267 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/boot/compressed/tdcall.S
 create mode 100644 arch/x86/include/asm/protected_guest.h
 create mode 100644 include/linux/protected_guest.h

-- 
2.25.1

