Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24B33939D6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 01:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbhE0X7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 19:59:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:49062 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235491AbhE0X7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 19:59:08 -0400
IronPort-SDR: T2W9qIr/dtqz+GUuBWsVkMxC04o0jkwa5ItcseE6VGH2YNPw51Tzeiay9QGF7eN4inVNl5Tktx
 Hg2wZAmEFqoA==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="199820394"
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="199820394"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 16:57:32 -0700
IronPort-SDR: EdBbJMdOe+AIAvP+bJlbPTifDhKTmzM3qg8+7htfJwckCp78t3RIrkyvxgwspQIHQK2Xq1uFGA
 nhkMOHUu2zEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="548362372"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga001.fm.intel.com with ESMTP; 27 May 2021 16:57:31 -0700
Subject: [PATCH 0/5] x86/pkeys: PKRU manipulation bug fixes and cleanups
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, luto@kernel.org,
        shuah@kernel.org, babu.moger@amd.com, dave.kleikamp@oracle.com,
        linuxram@us.ibm.com, bauerman@linux.ibm.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 27 May 2021 16:51:09 -0700
Message-Id: <20210527235109.B2A9F45F@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski recently noted a probable bug in write_pkru(), but
it was unclear if it was user-visible.  A recent bug report in
related code[1] forced me to take a look.

Basically, manipulation of XSAVE state is too unstructured.
get_xsave_addr() gives callers the impression they can read and
write XSAVE state when there are a lot of pitfalls, like updates
to xstate.features bits.

As a result, more than one call site screws up the modification
of PKRU in the XSAVE buffer.  This series fixes that problem up
and also hopefully carves out a less error-prone path that can
be reused for other XSAVE features.

This series:
 * Moves the PKRU manipulation to a more appropriate location,
   away from the page table code
 * Wraps get_xsave_addr() with more structured, less error-prone
   interfaces.
 * Conditionally hides a pkey debugfs file, eliminating the need
   for new runtime checks to work with the new interface.
 * Add a selftest to make it more likely to catch bugs like this
   in the future.  This improved selftest catches this issue on
   Intel CPUs.  Without the improvement, it only triggers on AMD.

This has been lightly tested so far.  It probably needs a
tested-by from at least the AMD folks before anyone applies it.

1. https://lore.kernel.org/linux-kselftest/b2e0324a-9125-bb34-9e76-81817df27c48@amd.com/

--

 arch/x86/include/asm/fpu/internal.h          |    8 -
 arch/x86/include/asm/fpu/xstate.h            |  130 +++++++++++++++++++++++++++
 arch/x86/include/asm/pgtable.h               |   29 ------
 arch/x86/include/asm/processor.h             |    7 +
 arch/x86/kernel/cpu/common.c                 |    6 -
 arch/x86/kernel/fpu/xstate.c                 |    2 
 arch/x86/kernel/process_64.c                 |    1 
 arch/x86/kvm/svm/sev.c                       |    1 
 arch/x86/kvm/x86.c                           |    1 
 arch/x86/mm/pkeys.c                          |   13 +-
 tools/testing/selftests/vm/Makefile          |    4 
 tools/testing/selftests/vm/pkey-x86.h        |    1 
 tools/testing/selftests/vm/protection_keys.c |   73 +++++++++++++++
 13 files changed, 227 insertions(+), 49 deletions(-)

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Babu Moger <babu.moger@amd.com>
Cc: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
