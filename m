Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19AE93B4F1C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 17:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFZPOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 11:14:15 -0400
Received: from mga14.intel.com ([192.55.52.115]:22924 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229796AbhFZPOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 11:14:15 -0400
IronPort-SDR: w/feVpNxXEVm86iT2mtfR2CDOVqRh730JqzBx9+yCgzQtrtijx1qPB9+KUs0R6OyrWiukXmLJt
 BpzYRqt4WrBg==
X-IronPort-AV: E=McAfee;i="6200,9189,10027"; a="207613925"
X-IronPort-AV: E=Sophos;i="5.83,301,1616482800"; 
   d="scan'208";a="207613925"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2021 08:11:52 -0700
X-IronPort-AV: E=Sophos;i="5.83,301,1616482800"; 
   d="scan'208";a="642895545"
Received: from mlubyani-mobl2.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.8.25])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2021 08:11:51 -0700
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
Subject: [PATCH v1 0/6] Add TDX Guest Support (Attestation support)
Date:   Sat, 26 Jun 2021 08:11:40 -0700
Message-Id: <cover.1624719668.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Intel's Trust Domain Extensions (TDX) protect guest VMs from malicious
hosts and some physical attacks. VM guest with TDX support is called
as TD Guest.

In TD Guest, the attestation process is used to verify the 
trustworthiness of TD guest to the 3rd party servers. Such attestation
process is required by 3rd party servers before sending sensitive
information to TD guests. One usage example is to get encryption keys
from the key server for mounting the encrypted rootfs or secondary drive.
    
Following patches adds the attestation support to TDX guest which
includes attestation user interface driver, user agent example, and
related hypercall support.

In this series, only following patches are in arch/x86 and are
intended for x86 maintainers review.

* x86/tdx: Add TDREPORT TDX Module call support
* x86/tdx: Add GetQuote TDX hypercall support
* x86/tdx: Add SetupEventNotifyInterrupt TDX hypercall support

Patch titled "platform/x86: intel_tdx_attest: Add TDX Guest attestation
interface driver" adds the attestation driver support. This is supposed
to be reviewed by platform-x86 maintainers.

Also, patch titled "tools/tdx: Add a sample attestation user app" adds
a testing app for attestation feature which needs review from
bpf@vger.kernel.org.

This series is the continuation of the following TDX patch series which
added basic TDX guest support.

[set 1] - https://lore.kernel.org/patchwork/project/lkml/list/?series=505232
[set 2] - https://lore.kernel.org/patchwork/project/lkml/list/?series=506230
[set 3] - https://lore.kernel.org/patchwork/project/lkml/list/?series=506231
[set 4] - https://lore.kernel.org/patchwork/project/lkml/list/?series=506232
[set 5] - https://lore.kernel.org/patchwork/project/lkml/list/?series=506233

Also please note that this series alone is not necessarily fully
functional.

You can find TDX related documents in the following link.

https://software.intel.com/content/www/br/pt/develop/articles/intel-trust-domain-extensions.html


Kuppuswamy Sathyanarayanan (6):
  x86/tdx: Add TDREPORT TDX Module call support
  x86/tdx: Add GetQuote TDX hypercall support
  x86/tdx: Add SetupEventNotifyInterrupt TDX hypercall support
  x86/tdx: Add TDX Guest event notify interrupt vector support
  platform/x86: intel_tdx_attest: Add TDX Guest attestation interface
    driver
  tools/tdx: Add a sample attestation user app

 arch/x86/include/asm/hardirq.h          |   1 +
 arch/x86/include/asm/idtentry.h         |   4 +
 arch/x86/include/asm/irq_vectors.h      |   7 +-
 arch/x86/include/asm/tdx.h              |   6 +
 arch/x86/kernel/irq.c                   |   7 +
 arch/x86/kernel/tdx.c                   | 129 +++++++++++++
 drivers/platform/x86/Kconfig            |   9 +
 drivers/platform/x86/Makefile           |   1 +
 drivers/platform/x86/intel_tdx_attest.c | 171 +++++++++++++++++
 include/uapi/misc/tdx.h                 |  20 ++
 tools/Makefile                          |  13 +-
 tools/tdx/Makefile                      |  19 ++
 tools/tdx/attest/.gitignore             |   2 +
 tools/tdx/attest/Makefile               |  24 +++
 tools/tdx/attest/tdx-attest-test.c      | 232 ++++++++++++++++++++++++
 15 files changed, 638 insertions(+), 7 deletions(-)
 create mode 100644 drivers/platform/x86/intel_tdx_attest.c
 create mode 100644 include/uapi/misc/tdx.h
 create mode 100644 tools/tdx/Makefile
 create mode 100644 tools/tdx/attest/.gitignore
 create mode 100644 tools/tdx/attest/Makefile
 create mode 100644 tools/tdx/attest/tdx-attest-test.c

-- 
2.25.1

