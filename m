Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623723A063B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 23:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbhFHVmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 17:42:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:45443 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234276AbhFHVmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 17:42:42 -0400
IronPort-SDR: Mwkvxd1uGcDfwu83ySw4nwO58ejLyHO9p5kZ9bnZVj9K4obzbbFwHluyBqOiGbzn5qZt62a9/l
 lKHydsqgZZ0w==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="226309333"
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="226309333"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 14:40:48 -0700
IronPort-SDR: YHHSLCsVEKiLOA60qU3ailMiBn65b5jbvmwtrkJE2+nTG+p9FpmsLWCddbECCgZa45bsRYJD8A
 qvAqTlNCW7Qg==
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="448057487"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 14:40:47 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [RFC PATCH 0/4] Machine check recovery for SGX
Date:   Tue,  8 Jun 2021 14:40:34 -0700
Message-Id: <20210608214038.1026259-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Early draft because there are people outside of Intel that want to
see how this is coming along, and this is the easiest way to share.

I wouldn't advise running this code on a production system as testing
has been very light.

SGX memory pages are allocated from special protected memory ranges
and do not have Linux "struct page" structures to manage them.

A recent architecture change results in new behavior for SGX enclaves
on a system when a recoverable local machine check occurs.
a) If the machine check is triggered by code executing outside of an
   enclave, then it can be handled as normal by the OS. Enclaves are
   not affected
b) If the machine check is triggered by code in an enclave, then that
   enclave cannot be re-entered. But other enclaves on the system can
   continue to execute.

This means that "recovery" from an error in an active enclave page
will result in the termination of that enclave.

Memory controller patrol scrubbing may find errors in unused SGX pages.
Those can simply be removed from the free list so that they will not
be used.

On bare metal there are two cases for "regular" SGX pages:
1) Error is found by patrol scrubber. Action is to remove the page
   from the enclave. If the page isn't accessed again, then the enclave
   can continue to execute. If the page is accessed the page cannot be
   replaced, so the enclave will be terminated.
   This part of the code (and the free page part) tested using
   /sys/devices/system/memory/hard_offline_page to call memory_failure().

2) Error triggers a machine check when enclave code accesses poison. In
   this case a SIGBUS is sent to the task that owns the enclave (just
   like the non-SGX case).
   This part of the code has been tested with EINJ error injection.

Poison in other types of SGX pages (e.g. SECS) isn't handled yet.

The virtualization case is just a shell. Linux doesn't know how the
guest is using each page. For now just SIGKILL the task (qemu?) that
owns the SGX pages.
This part of the code compiles, but has not been tested.

Tony Luck (4):
  x86/sgx: Track phase and type of SGX EPC pages
  x86/sgx: Add basic infrastructure to recover from errors in SGX memory
  x86/sgx: Hook sgx_memory_failure() into mainline code
  x86/sgx: Add hook to error injection address validation

 .../firmware-guide/acpi/apei/einj.rst         |  19 +++
 arch/x86/include/asm/sgx.h                    |   6 +
 arch/x86/kernel/cpu/sgx/encl.c                |   4 +-
 arch/x86/kernel/cpu/sgx/ioctl.c               |   4 +-
 arch/x86/kernel/cpu/sgx/main.c                | 147 +++++++++++++++++-
 arch/x86/kernel/cpu/sgx/sgx.h                 |  17 +-
 arch/x86/kernel/cpu/sgx/virt.c                |  11 +-
 drivers/acpi/apei/einj.c                      |   3 +-
 include/linux/mm.h                            |  15 ++
 mm/memory-failure.c                           |   4 +
 10 files changed, 219 insertions(+), 11 deletions(-)

-- 
2.29.2

