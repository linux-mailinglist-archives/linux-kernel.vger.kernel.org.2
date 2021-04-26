Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BDF36B1AE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 12:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbhDZKc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 06:32:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:46548 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233072AbhDZKcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 06:32:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BE6A2B202;
        Mon, 26 Apr 2021 10:31:32 +0000 (UTC)
Date:   Mon, 26 Apr 2021 12:31:35 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/sgx for v5.13
Message-ID: <YIaWh9VSEMQnn5E2@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the SGX pile of updates for v5.13.

Thx.

---

The following changes since commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0:

  Linux 5.12-rc3 (2021-03-14 14:41:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_v5.13

for you to fetch changes up to 523caed9efbb049339706b124185c9358c1b6477:

  x86/sgx: Mark sgx_vepc_vm_ops static (2021-04-12 19:48:32 +0200)

----------------------------------------------------------------
Add the guest side of SGX support in KVM guests. Work by Sean
Christopherson, Kai Huang and Jarkko Sakkinen. Along with the usual
fixes, cleanups and improvements.

----------------------------------------------------------------
Dave Hansen (1):
      selftests/sgx: Improve error detection and messages

Ira Weiny (1):
      x86/sgx: Remove unnecessary kmap() from sgx_ioc_enclave_init()

Jarkko Sakkinen (3):
      x86/sgx: Replace section->init_laundry_list with sgx_dirty_page_list
      x86/sgx: Add a basic NUMA allocation scheme to sgx_alloc_epc_page()
      x86/sgx: Do not update sgx_nr_free_pages in sgx_setup_epc_section()

Kai Huang (4):
      x86/cpufeatures: Make SGX_LC feature bit depend on SGX bit
      x86/sgx: Wipe out EREMOVE from sgx_free_epc_page()
      x86/sgx: Initialize virtual EPC driver even when SGX driver is disabled
      x86/sgx: Add helper to update SGX_LEPUBKEYHASHn MSRs

Sean Christopherson (10):
      x86/cpufeatures: Add SGX1 and SGX2 sub-features
      x86/sgx: Add SGX_CHILD_PRESENT hardware error code
      x86/sgx: Introduce virtual EPC for use by KVM guests
      x86/cpu/intel: Allow SGX virtualization without Launch Control support
      x86/sgx: Expose SGX architectural definitions to the kernel
      x86/sgx: Move ENCLS leaf definitions to sgx.h
      x86/sgx: Add SGX2 ENCLS leaf definitions (EAUG, EMODPR and EMODT)
      x86/sgx: Add encls_faulted() helper
      x86/sgx: Add helpers to expose ECREATE and EINIT to KVM
      x86/sgx: Move provisioning device creation out of SGX driver

Tianjia Zhang (1):
      selftests/sgx: Use getauxval() to simplify test code

Wei Yongjun (1):
      x86/sgx: Mark sgx_vepc_vm_ops static

 Documentation/x86/sgx.rst                          |  41 +++
 MAINTAINERS                                        |   1 +
 arch/x86/Kconfig                                   |   1 +
 arch/x86/include/asm/cpufeatures.h                 |   2 +
 .../{kernel/cpu/sgx/arch.h => include/asm/sgx.h}   |  50 ++-
 arch/x86/kernel/cpu/cpuid-deps.c                   |   3 +
 arch/x86/kernel/cpu/feat_ctl.c                     |  71 ++--
 arch/x86/kernel/cpu/scattered.c                    |   2 +
 arch/x86/kernel/cpu/sgx/Makefile                   |   1 +
 arch/x86/kernel/cpu/sgx/driver.c                   |  17 -
 arch/x86/kernel/cpu/sgx/encl.c                     |  33 +-
 arch/x86/kernel/cpu/sgx/encl.h                     |   1 +
 arch/x86/kernel/cpu/sgx/encls.h                    |  30 +-
 arch/x86/kernel/cpu/sgx/ioctl.c                    |  43 +--
 arch/x86/kernel/cpu/sgx/main.c                     | 264 ++++++++++-----
 arch/x86/kernel/cpu/sgx/sgx.h                      |  40 ++-
 arch/x86/kernel/cpu/sgx/virt.c                     | 376 +++++++++++++++++++++
 arch/x86/kvm/Kconfig                               |  12 +
 tools/testing/selftests/sgx/defines.h              |   2 +-
 tools/testing/selftests/sgx/load.c                 |  69 +++-
 tools/testing/selftests/sgx/main.c                 |  26 +-
 21 files changed, 861 insertions(+), 224 deletions(-)
 rename arch/x86/{kernel/cpu/sgx/arch.h => include/asm/sgx.h} (89%)
 create mode 100644 arch/x86/kernel/cpu/sgx/virt.c

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
