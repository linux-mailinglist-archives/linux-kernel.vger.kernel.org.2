Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF7B427C46
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 19:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbhJIRPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 13:15:15 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:55641 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhJIRPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 13:15:14 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 9AA7F60006;
        Sat,  9 Oct 2021 17:13:09 +0000 (UTC)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: [PATCH v7 0/3] Introduce 64b relocatable kernel 
Date:   Sat,  9 Oct 2021 19:12:56 +0200
Message-Id: <20211009171259.2515351-1-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After multiple attempts, this patchset is now based on the fact that the
64b kernel mapping was moved outside the linear mapping.

The first patch allows to build relocatable kernels but is not selected         
by default. That patch should ease KASLR implementation a lot.                                                            
The second and third patches take advantage of an already existing powerpc       
script that checks relocations at compile-time, and uses it for riscv.           

This patchset was tested on:

* qemu riscv64 defconfig: OK
* Unmatched ubuntu config: OK

Changes in v7:
  * Rebase on top of v5.15
  * Fix LDFLAGS_vmlinux which was overriden when CONFIG_DYNAMIC_FTRACE was
    set
  * Make relocate_kernel static
  * Add Ack from Michael

Changes in v6:
  * Remove the kernel move to vmalloc zone
  * Rebased on top of for-next
  * Remove relocatable property from 32b kernel as the kernel is mapped in
    the linear mapping and would then need to be copied physically too
  * CONFIG_RELOCATABLE depends on !XIP_KERNEL
  * Remove Reviewed-by from first patch as it changed a bit

Changes in v5:
  * Add "static __init" to create_kernel_page_table function as reported by
    Kbuild test robot
  * Add reviewed-by from Zong
  * Rebase onto v5.7

Changes in v4:                                                                   
  * Fix BPF region that overlapped with kernel's as suggested by Zong            
  * Fix end of module region that could be larger than 2GB as suggested by Zong  
  * Fix the size of the vm area reserved for the kernel as we could lose         
    PMD_SIZE if the size was already aligned on PMD_SIZE                         
  * Split compile time relocations check patch into 2 patches as suggested by Anup
  * Applied Reviewed-by from Zong and Anup                                       

Changes in v3:                                                                   
  * Move kernel mapping to vmalloc                                               

Changes in v2:                                                                   
  * Make RELOCATABLE depend on MMU as suggested by Anup                          
  * Rename kernel_load_addr into kernel_virt_addr as suggested by Anup           
  * Use __pa_symbol instead of __pa, as suggested by Zong                        
  * Rebased on top of v5.6-rc3                                                   
  * Tested with sv48 patchset                                                    
  * Add Reviewed/Tested-by from Zong and Anup

Alexandre Ghiti (3):
  riscv: Introduce CONFIG_RELOCATABLE
  powerpc: Move script to check relocations at compile time in scripts/
  riscv: Check relocations at compile time

 arch/powerpc/tools/relocs_check.sh | 18 ++--------
 arch/riscv/Kconfig                 | 12 +++++++
 arch/riscv/Makefile                |  7 ++--
 arch/riscv/Makefile.postlink       | 36 ++++++++++++++++++++
 arch/riscv/kernel/vmlinux.lds.S    |  6 ++++
 arch/riscv/mm/Makefile             |  4 +++
 arch/riscv/mm/init.c               | 54 +++++++++++++++++++++++++++++-
 arch/riscv/tools/relocs_check.sh   | 26 ++++++++++++++
 scripts/relocs_check.sh            | 20 +++++++++++
 9 files changed, 164 insertions(+), 19 deletions(-)
 create mode 100644 arch/riscv/Makefile.postlink
 create mode 100755 arch/riscv/tools/relocs_check.sh
 create mode 100755 scripts/relocs_check.sh

-- 
2.30.2

