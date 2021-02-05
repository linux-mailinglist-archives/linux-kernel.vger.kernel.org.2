Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153D5310D86
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 17:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhBEOTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 09:19:30 -0500
Received: from mga04.intel.com ([192.55.52.120]:16255 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232230AbhBEOPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:15:05 -0500
IronPort-SDR: oK2IHAB7iAjOR4V56J1bcfXJmCe/7LmTIdQrhjotNTXIo/hmD0iYFM6vQMInWb/aNXJ30Ql0PW
 kFBfpN+Eirow==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="178884921"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="178884921"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 07:16:44 -0800
IronPort-SDR: odaYtFD0s/d6w79WWG0Vg2ZYadMLRORj2bNbpRiugzfEunp8wx1V+GqwyOBpdgG7I7D9hSqxfE
 CqcvtPYmD50w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="416059427"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Feb 2021 07:16:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 9B320184; Fri,  5 Feb 2021 17:16:40 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFC 0/9] Linear Address Masking enabling
Date:   Fri,  5 Feb 2021 18:16:20 +0300
Message-Id: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linear Address Masking[1] (LAM) modifies the checking that is applied to
64-bit linear addresses, allowing software to use of the untranslated
address bits for metadata.

The patchset brings support for LAM for userspace addresses.

The most sensitive part of enabling is change in tlb.c, where CR3 flags
get set. Please take a look that what I'm doing makes sense.

The patchset is RFC quality and the code requires more testing before it
can be applied.

The userspace API is not finalized yet. The patchset extends API used by
ARM64: PR_GET/SET_TAGGED_ADDR_CTRL. The API is adjusted to not imply ARM
TBI: it now allows to request a number of bits of metadata needed and
report where these bits are located in the address.

There's an alternative proposal[2] for the API based on Intel CET
interface. Please let us know if you prefer one over another.

The feature competes for bits with 5-level paging: LAM_U48 makes it
impossible to map anything about 47-bits. The patchset made these
capability mutually exclusive: whatever used first wins. LAM_U57 can be
combined with mappings above 47-bits.

I include QEMU patch in case if somebody wants to play with the feature.

The branch:

	git://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam

Any comments are welcome.

[1] ISE, Chapter 14. https://software.intel.com/content/dam/develop/external/us/en/documents-tps/architecture-instruction-set-extensions-programming-reference.pdf
[2] https://github.com/hjl-tools/linux/commit/e85fa032e5b276ddf17edd056f92f599db9e8369

Kirill A. Shutemov (9):
  mm, arm64: Update PR_SET/GET_TAGGED_ADDR_CTRL interface
  x86/mm: Fix CR3_ADDR_MASK
  x86: CPUID and CR3/CR4 flags for Linear Address Masking
  x86/mm: Introduce TIF_LAM_U57 and TIF_LAM_U48
  x86/mm: Provide untagged_addr() helper
  x86/uaccess: Remove tags from the address before checking
  x86/mm: Handle tagged memory accesses from kernel threads
  x86/mm: Make LAM_U48 and mappings above 47-bits mutually exclusive
  x86/mm: Implement PR_SET/GET_TAGGED_ADDR_CTRL with LAM

 arch/arm64/include/asm/processor.h            |  12 +-
 arch/arm64/kernel/process.c                   |  45 +++++-
 arch/arm64/kernel/ptrace.c                    |   4 +-
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/elf.h                    |   3 +-
 arch/x86/include/asm/mmu.h                    |   1 +
 arch/x86/include/asm/mmu_context.h            |  13 ++
 arch/x86/include/asm/page_32.h                |   3 +
 arch/x86/include/asm/page_64.h                |  19 +++
 arch/x86/include/asm/processor-flags.h        |   2 +-
 arch/x86/include/asm/processor.h              |  10 ++
 arch/x86/include/asm/thread_info.h            |   9 +-
 arch/x86/include/asm/tlbflush.h               |   5 +
 arch/x86/include/asm/uaccess.h                |  16 +-
 arch/x86/include/uapi/asm/processor-flags.h   |   6 +
 arch/x86/kernel/process_64.c                  | 145 ++++++++++++++++++
 arch/x86/kernel/sys_x86_64.c                  |   5 +-
 arch/x86/mm/hugetlbpage.c                     |   6 +-
 arch/x86/mm/mmap.c                            |   9 +-
 arch/x86/mm/tlb.c                             | 124 +++++++++++++--
 kernel/sys.c                                  |  14 +-
 .../testing/selftests/arm64/tags/tags_test.c  |  31 ----
 .../selftests/{arm64 => vm}/tags/.gitignore   |   0
 .../selftests/{arm64 => vm}/tags/Makefile     |   0
 .../{arm64 => vm}/tags/run_tags_test.sh       |   0
 tools/testing/selftests/vm/tags/tags_test.c   |  57 +++++++
 26 files changed, 464 insertions(+), 76 deletions(-)
 delete mode 100644 tools/testing/selftests/arm64/tags/tags_test.c
 rename tools/testing/selftests/{arm64 => vm}/tags/.gitignore (100%)
 rename tools/testing/selftests/{arm64 => vm}/tags/Makefile (100%)
 rename tools/testing/selftests/{arm64 => vm}/tags/run_tags_test.sh (100%)
 create mode 100644 tools/testing/selftests/vm/tags/tags_test.c

-- 
2.26.2

