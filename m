Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02056441934
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 10:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbhKAJ67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 05:58:59 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46254 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbhKAJ5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 05:57:40 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 846D42191A;
        Mon,  1 Nov 2021 09:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635760505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BjvmN7hagLvRm1mQmQfOMHKSQjOfQqrOC6T5x/n8PFA=;
        b=2LdxyofLwYP6DFe8tcnvAHLdQQxhNnFb12YVI6fYXU83vuR1hcAzCzHzI3i4gZBCE2lJgQ
        N/+Y2m25k2VYo+9Xr9GHJtPN36SwrNMeHDP9bq267ls5nAvjuRedJbQI2P055Jsq6v3lQ3
        Drrq/5KyJGWljFoUNzsWc850CdsnyN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635760505;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BjvmN7hagLvRm1mQmQfOMHKSQjOfQqrOC6T5x/n8PFA=;
        b=7TQzCUOFddMYqXqmGnYSC+QyGelfL/iwUos3wBPHNR0s57xEWP5jIIDOOhH/yga1lhaFQh
        TWoZePi73m+D6SDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 728F513AA9;
        Mon,  1 Nov 2021 09:55:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /V+rG3m5f2GPQgAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 01 Nov 2021 09:55:05 +0000
Date:   Mon, 1 Nov 2021 10:55:06 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cc for v5.16
Message-ID: <YX+5ekjTbK3rhX+Y@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the first generic confidential computing branch update
for v5.16. This is going to contain work which is shared between the
different confidential computing solutions like SEV, TDX, etc.

Thx.

---
The following changes since commit 9e1ff307c779ce1f0f810c7ecce3d95bbae40896:

  Linux 5.15-rc4 (2021-10-03 14:08:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cc_for_v5.16_rc1

for you to fetch changes up to e9d1d2bb75b2d5d4b426769c5aae0ce8cef3558f:

  treewide: Replace the use of mem_encrypt_active() with cc_platform_has() (2021-10-04 11:47:24 +0200)

----------------------------------------------------------------
Add an interface called cc_platform_has() which is supposed to be used
by confidential computing solutions to query different aspects of the
system. The intent behind it is to unify testing of such aspects instead
of having each confidential computing solution add its own set of tests
to code paths in the kernel, leading to an unwieldy mess.

----------------------------------------------------------------
Tom Lendacky (8):
      x86/ioremap: Selectively build arch override encryption functions
      arch/cc: Introduce a function to check for confidential computing features
      x86/sev: Add an x86 version of cc_platform_has()
      powerpc/pseries/svm: Add a powerpc version of cc_platform_has()
      x86/sme: Replace occurrences of sme_active() with cc_platform_has()
      x86/sev: Replace occurrences of sev_active() with cc_platform_has()
      x86/sev: Replace occurrences of sev_es_active() with cc_platform_has()
      treewide: Replace the use of mem_encrypt_active() with cc_platform_has()

 arch/Kconfig                                 |  3 +
 arch/powerpc/include/asm/mem_encrypt.h       |  5 --
 arch/powerpc/platforms/pseries/Kconfig       |  1 +
 arch/powerpc/platforms/pseries/Makefile      |  2 +
 arch/powerpc/platforms/pseries/cc_platform.c | 26 ++++++++
 arch/powerpc/platforms/pseries/svm.c         |  5 +-
 arch/s390/include/asm/mem_encrypt.h          |  2 -
 arch/x86/Kconfig                             |  1 +
 arch/x86/include/asm/io.h                    |  8 +++
 arch/x86/include/asm/kexec.h                 |  2 +-
 arch/x86/include/asm/mem_encrypt.h           | 12 +---
 arch/x86/kernel/Makefile                     |  6 ++
 arch/x86/kernel/cc_platform.c                | 69 ++++++++++++++++++++++
 arch/x86/kernel/crash_dump_64.c              |  4 +-
 arch/x86/kernel/head64.c                     |  9 ++-
 arch/x86/kernel/kvm.c                        |  3 +-
 arch/x86/kernel/kvmclock.c                   |  4 +-
 arch/x86/kernel/machine_kexec_64.c           | 19 +++---
 arch/x86/kernel/pci-swiotlb.c                |  9 ++-
 arch/x86/kernel/relocate_kernel_64.S         |  2 +-
 arch/x86/kernel/sev.c                        |  6 +-
 arch/x86/kvm/svm/svm.c                       |  3 +-
 arch/x86/mm/ioremap.c                        | 18 +++---
 arch/x86/mm/mem_encrypt.c                    | 55 +++++------------
 arch/x86/mm/mem_encrypt_identity.c           |  9 ++-
 arch/x86/mm/pat/set_memory.c                 |  3 +-
 arch/x86/platform/efi/efi_64.c               |  9 +--
 arch/x86/realmode/init.c                     |  8 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |  4 +-
 drivers/gpu/drm/drm_cache.c                  |  4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c          |  4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c          |  6 +-
 drivers/iommu/amd/init.c                     |  7 ++-
 drivers/iommu/amd/iommu.c                    |  3 +-
 drivers/iommu/amd/iommu_v2.c                 |  3 +-
 drivers/iommu/iommu.c                        |  3 +-
 fs/proc/vmcore.c                             |  6 +-
 include/linux/cc_platform.h                  | 88 ++++++++++++++++++++++++++++
 include/linux/mem_encrypt.h                  |  4 --
 kernel/dma/swiotlb.c                         |  4 +-
 40 files changed, 310 insertions(+), 129 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/cc_platform.c
 create mode 100644 arch/x86/kernel/cc_platform.c
 create mode 100644 include/linux/cc_platform.h

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
