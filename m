Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB0939FB0B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 17:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhFHPmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 11:42:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:7767 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231996AbhFHPme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 11:42:34 -0400
IronPort-SDR: d3aRzP+3S6sFUd5uQDtuxTRPDKd45Qo7IAdy7Qfgvv5KlGNLiaDvfmlRYioVbc4q2GxrhmneaK
 AUq+MzirG/iA==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="201849037"
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="201849037"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 08:40:30 -0700
IronPort-SDR: YpOV4FO2hhJwyS1M3ho7/A8lj2Od4mrDRlaSd8geubsNCZjd9LS6TXZXsQbMDjnEqSKd/D3T3y
 ynWY9o6OXWzw==
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="552314839"
Received: from ticela-az-103.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.36.77])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 08:40:29 -0700
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
Subject: [RFC v2-fix-v2 0/3] x86/tdx: Handle port I/O
Date:   Tue,  8 Jun 2021 08:40:20 -0700
Message-Id: <cover.1623165571.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAPcyv4iOJJjghTPTLCkvT-Y_SJOhCbfm66m_NO5Ue+eVr_0NZA@mail.gmail.com>
References: <CAPcyv4iOJJjghTPTLCkvT-Y_SJOhCbfm66m_NO5Ue+eVr_0NZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset addresses the review comments in the patch titled
"[RFC v2 14/32] x86/tdx: Handle port I/O". Since it requires
patch split, sending these together.

Changes since RFC v2-fix-v1:
 * Splitted TDX decompression IO support into a seperate patch.
 * Implemented tdg_handle_io() and tdx_early_io() in the similar
   way as per review suggestion.
 * Added VE_IS_IO_OUT() macro as per review suggestion.
 * Added VE_IS_IO_STRING() to check the string I/O case in
   tdx_early_io()
 * Removed helper function tdg_in() and tdg_out() and directly
   called IO hypercall to make the implementation uniform in
   decompression code, early IO code and normal IO handler code.

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
  x86/tdx: Handle port I/O in decompression code

 arch/x86/boot/compressed/Makefile |  1 +
 arch/x86/boot/compressed/tdcall.S |  3 ++
 arch/x86/include/asm/io.h         | 15 +++---
 arch/x86/include/asm/tdx.h        | 54 ++++++++++++++++++++
 arch/x86/kernel/head64.c          |  3 ++
 arch/x86/kernel/tdx.c             | 84 +++++++++++++++++++++++++++++++
 6 files changed, 154 insertions(+), 6 deletions(-)
 create mode 100644 arch/x86/boot/compressed/tdcall.S

-- 
2.25.1

