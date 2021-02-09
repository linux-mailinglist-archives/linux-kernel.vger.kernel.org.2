Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8787D31577E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 21:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbhBIUJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 15:09:08 -0500
Received: from linux.microsoft.com ([13.77.154.182]:57624 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbhBISXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 13:23:11 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9098920B6C40;
        Tue,  9 Feb 2021 10:22:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9098920B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1612894949;
        bh=SIuimfnV2MObrfn23wlG04LPv+kLJI/iRotGmcNA5RU=;
        h=From:To:Cc:Subject:Date:From;
        b=pcIL4nqIL5+aibEFNv97ur/ViDIXxA2Y15KOsSXMriIPyRPgFVlZdZTI+nSOk3XjW
         cZh6G1W4gf+5Rro8Var/WgNn55uvHnkt+kp520kKiPVMXfIbt60ETSq1UcLkLROKoJ
         Wkp5Md2E0llIIpJmf2wVuOsF9JGDKyKrnyM5ND2I=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, joe@perches.com, catalin.marinas@arm.com,
        mpe@ellerman.id.au
Cc:     james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, mbrugger@suse.com, hsinyi@chromium.org,
        tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v17 00/10] Carry forward IMA measurement log on kexec on ARM64
Date:   Tue,  9 Feb 2021 10:21:50 -0800
Message-Id: <20210209182200.30606-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On kexec file load Integrity Measurement Architecture (IMA) subsystem
may verify the IMA signature of the kernel and initramfs, and measure
it.  The command line parameters passed to the kernel in the kexec call
may also be measured by IMA.  A remote attestation service can verify
a TPM quote based on the TPM event log, the IMA measurement list, and
the TPM PCR data.  This can be achieved only if the IMA measurement log
is carried over from the current kernel to the next kernel across
the kexec call.

powerpc already supports carrying forward the IMA measurement log on
kexec.  This patch set adds support for carrying forward the IMA
measurement log on kexec on ARM64.

This patch set moves the platform independent code defined for powerpc
such that it can be reused for other platforms as well.  A chosen node
"linux,ima-kexec-buffer" is added to the DTB for ARM64 to hold
the address and the size of the memory reserved to carry
the IMA measurement log.

This patch set has been tested for ARM64 platform using QEMU.
I would like help from the community for testing this change on powerpc.
Thanks.

This patch set is based on
commit 96acc833dec8 ("ima: Free IMA measurement buffer after kexec syscall")
in https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
"next-integrity" branch.

Changelog:

v17
  - Renamed of_kexec_setup_new_fdt() to of_kexec_alloc_and_setup_fdt(),
    and moved memory allocation for the new FDT to this function.

v16
  - Defined functions to allocate and free buffer for FDT for powerpc
    and arm64.
  - Moved ima_buffer_addr and ima_buffer_size fields from
    "struct kimage_arch" in powerpc to "struct kimage"
v15
  - Included Rob's patches in the patch set, and rebased
    the changes to "next-integrity" branch.
  - Allocate memory for DTB, on arm64, using kmalloc() instead of
    vmalloc() to keep it consistent with powerpc implementation.
  - Call of_kexec_setup_new_fdt() from setup_new_fdt_ppc64() and
    remove setup_new_fdt() in the same patch to keep it bisect safe.

v14
  - Select CONFIG_HAVE_IMA_KEXEC for CONFIG_KEXEC_FILE, for powerpc
    and arm64, if CONFIG_IMA is enabled.
  - Use IS_ENABLED() macro instead of "#ifdef" in remove_ima_buffer(),
    ima_get_kexec_buffer(), and ima_free_kexec_buffer().
  - Call of_kexec_setup_new_fdt() from setup_new_fdt_ppc64() and
    remove setup_new_fdt() in "arch/powerpc/kexec/file_load.c".

v13
  - Moved the arch independent functions to drivers/of/kexec.c
    and then refactored the code.
  - Moved arch_ima_add_kexec_buffer() to
    security/integrity/ima/ima_kexec.c

v12
  - Use fdt_appendprop_addrrange() in setup_ima_buffer()
    to setup the IMA measurement list property in
    the device tree.
  - Moved architecture independent functions from
    "arch/powerpc/kexec/ima.c" to "drivers/of/kexec."
  - Deleted "arch/powerpc/kexec/ima.c" and
    "arch/powerpc/include/asm/ima.h".

v11
  - Rebased the changes on the kexec code refactoring done by
    Rob Herring in his "dt/kexec" branch
  - Removed "extern" keyword in function declarations
  - Removed unnecessary header files included in C files
  - Updated patch descriptions per Thiago's comments

v10
  - Moved delete_fdt_mem_rsv(), remove_ima_buffer(),
    get_ima_kexec_buffer, and get_root_addr_size_cells()
    to drivers/of/kexec.c
  - Moved arch_ima_add_kexec_buffer() to
    security/integrity/ima/ima_kexec.c
  - Conditionally define IMA buffer fields in struct kimage_arch

v9
  - Moved delete_fdt_mem_rsv() to drivers/of/kexec_fdt.c
  - Defined a new function get_ima_kexec_buffer() in
    drivers/of/ima_kexec.c to replace do_get_kexec_buffer()
  - Changed remove_ima_kexec_buffer() to the original function name
    remove_ima_buffer()
  - Moved remove_ima_buffer() to drivers/of/ima_kexec.c
  - Moved ima_get_kexec_buffer() and ima_free_kexec_buffer()
    to security/integrity/ima/ima_kexec.c

v8:
  - Moved remove_ima_kexec_buffer(), do_get_kexec_buffer(), and
    delete_fdt_mem_rsv() to drivers/of/fdt.c
  - Moved ima_dump_measurement_list() and ima_add_kexec_buffer()
    back to security/integrity/ima/ima_kexec.c

v7:
  - Renamed remove_ima_buffer() to remove_ima_kexec_buffer() and moved
    this function definition to kernel.
  - Moved delete_fdt_mem_rsv() definition to kernel
  - Moved ima_dump_measurement_list() and ima_add_kexec_buffer() to
    a new file namely ima_kexec_fdt.c in IMA

v6:
  - Remove any existing FDT_PROP_IMA_KEXEC_BUFFER property in the device
    tree and also its corresponding memory reservation in the currently
    running kernel.
  - Moved the function remove_ima_buffer() defined for powerpc to IMA
    and renamed the function to ima_remove_kexec_buffer(). Also, moved
    delete_fdt_mem_rsv() from powerpc to IMA.

v5:
  - Merged get_addr_size_cells() and do_get_kexec_buffer() into a single
    function when moving the arch independent code from powerpc to IMA
  - Reverted the change to use FDT functions in powerpc code and added
    back the original code in get_addr_size_cells() and
    do_get_kexec_buffer() for powerpc.
  - Added fdt_add_mem_rsv() for ARM64 to reserve the memory for
    the IMA log buffer during kexec.
  - Fixed the warning reported by kernel test bot for ARM64
    arch_ima_add_kexec_buffer() - moved this function to a new file
    namely arch/arm64/kernel/ima_kexec.c

v4:
  - Submitting the patch series on behalf of the original author
    Prakhar Srivastava <prsriva@linux.microsoft.com>
  - Moved FDT_PROP_IMA_KEXEC_BUFFER ("linux,ima-kexec-buffer") to
    libfdt.h so that it can be shared by multiple platforms.

v3:
Breakup patches further into separate patches.
  - Refactoring non architecture specific code out of powerpc
  - Update powerpc related code to use fdt functions
  - Update IMA buffer read related code to use of functions
  - Add support to store the memory information of the IMA
    measurement logs to be carried forward.
  - Update the property strings to align with documented nodes
    https://github.com/devicetree-org/dt-schema/pull/46

v2:
  Break patches into separate patches.
  - Powerpc related Refactoring
  - Updating the docuemntation for chosen node
  - Updating arm64 to support IMA buffer pass

v1:
  Refactoring carrying over IMA measuremnet logs over Kexec. This patch
    moves the non-architecture specific code out of powerpc and adds to
    security/ima.(Suggested by Thiago)
  Add Documentation regarding the ima-kexec-buffer node in the chosen
    node documentation

v0:
  Add a layer of abstraction to use the memory reserved by device tree
    for ima buffer pass.
  Add support for ima buffer pass using reserved memory for arm64 kexec.
    Update the arch sepcific code path in kexec file load to store the
    ima buffer in the reserved memory. The same reserved memory is read
    on kexec or cold boot.

Lakshmi Ramasubramanian (6):
  powerpc: Move ima buffer fields to struct kimage
  powerpc: Enable passing IMA log to next kernel on kexec
  powerpc: Move arch independent ima kexec functions to
    drivers/of/kexec.c
  kexec: Use fdt_appendprop_addrrange() to add ima buffer to FDT
  powerpc: Delete unused function delete_fdt_mem_rsv()
  arm64: Enable passing IMA log to next kernel on kexec

Rob Herring (4):
  powerpc: Rename kexec elfcorehdr_addr to elf_headers_mem
  of: Add a common kexec FDT setup function
  arm64: Use common of_kexec_alloc_and_setup_fdt()
  powerpc: Use common of_kexec_alloc_and_setup_fdt()

 arch/arm64/Kconfig                     |   1 +
 arch/arm64/kernel/machine_kexec_file.c | 180 +---------
 arch/powerpc/Kconfig                   |   2 +-
 arch/powerpc/include/asm/ima.h         |  30 --
 arch/powerpc/include/asm/kexec.h       |  12 +-
 arch/powerpc/kexec/Makefile            |   7 -
 arch/powerpc/kexec/elf_64.c            |  29 +-
 arch/powerpc/kexec/file_load.c         | 183 +---------
 arch/powerpc/kexec/file_load_64.c      |  11 +-
 arch/powerpc/kexec/ima.c               | 219 ------------
 drivers/of/Makefile                    |   6 +
 drivers/of/kexec.c                     | 473 +++++++++++++++++++++++++
 include/linux/kexec.h                  |   3 +
 include/linux/of.h                     |  20 ++
 security/integrity/ima/ima.h           |   4 -
 security/integrity/ima/ima_kexec.c     |   3 +-
 16 files changed, 539 insertions(+), 644 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/ima.h
 delete mode 100644 arch/powerpc/kexec/ima.c
 create mode 100644 drivers/of/kexec.c

-- 
2.30.0

