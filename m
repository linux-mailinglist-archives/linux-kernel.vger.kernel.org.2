Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2780230620B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343620AbhA0Rav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbhA0R1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:27:49 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBA7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 09:27:09 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id e17so1976610qto.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 09:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xf4oOUdBrXHTRbTLm7RifGmblRGfoXb7fq+J97+O8D8=;
        b=TX4ECh1pHjsVv12q3jR2uKF6/YTcwiCwgIjVqv6UeEc0RVzpr7Xx+g3w9Jk7hxeUij
         y6RQt0AkgveKaCyvyLbz9R0wRNvGMgujnOWyiy4MvtzEkzmws7rg+l0aI84d4Dvvc6mJ
         HaYPXj1FldXAjIlMj905LX6rLDDea8hjURSw1plZJpu8iAJV9FHxJ57I3y+HYSdLOcUq
         syV9m3XCFk62Wy+P+PTkuKG5KreHsl3mpwAGufBTXll85CL+dtpbsbk4p7elTn+NkhK8
         sLGBic3z0YtzWC+v6Y4Nubq7o8uPCvRbaY6JIMJ/PI4NooxAn0Wt3/09wUA1V8g6iWbA
         m0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xf4oOUdBrXHTRbTLm7RifGmblRGfoXb7fq+J97+O8D8=;
        b=Y68W2GxqpyBmPBbuBIqYAXccQlo2Sv8Ct1Y3gtVflqx8vU4l0KBrKDJBCD/zCimFCy
         j5Nv2o+PhWojOr2zsA6lNFT/WIRbKUaFg7n40APymA6OhKvxQiJgrmcj9zJhZ6g2zA+6
         KPSXPgBepwjpp54PGFnPIr4tzKDm+j/gKGhi/OxSEL140plpSN7OzPeNAnOab9hdHbLR
         jpBjIbfHCACbCZyGe50njc4XBkzO2Q1LVHBek3nuA9Kq3iz9/C3Pwji5sNTy1ScCvgkc
         PwJ7zbdAnEL0KanfpGWVxoluAbX/FpqxOG+u17jlQasWh/40tX/EpK66QUHEYVJz8xdz
         qdgA==
X-Gm-Message-State: AOAM532EmmM9SaYLPz4r9OcdBE5vbLF1dTWhoVpuFiXq9QkAgEzhdrbQ
        OHnoiqrppGV13nRrgf3ysSZ/+A==
X-Google-Smtp-Source: ABdhPJylHw7D8SCfYIEQPpHJtqFdzR9gRUp3qWrUWOgNGqGO17mAMhAo4xLE98I+GugX9uW5Iqf9MA==
X-Received: by 2002:ac8:4a97:: with SMTP id l23mr10840484qtq.51.1611768428205;
        Wed, 27 Jan 2021 09:27:08 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id z2sm1728019qtz.71.2021.01.27.09.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 09:27:07 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com
Subject: [PATCH v11 0/6] arm64: MMU enabled kexec relocation
Date:   Wed, 27 Jan 2021 12:27:00 -0500
Message-Id: <20210127172706.617195-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
v11:
	- Fixed missing KEXEC_CORE dependency for trans_pgd.c
	- Removed useless "if(rc) return rc" statement (thank you Tyler Hicks)
	- Another 12 patches were accepted into maintainer's get.
	  Re-based patches against:
	  https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
	  Branch: for-next/kexec
v10:
	- Addressed a lot of comments form James Morse and from  Marc Zyngier
	- Added review-by's
	- Synchronized with mainline

v9:	- 9 patches from previous series landed in upstream, so now series
	  is smaller
	- Added two patches from James Morse to address idmap issues for machines
	  with high physical addresses.
	- Addressed comments from Selin Dag about compiling issues. He also tested
	  my series and got similar performance results: ~60 ms instead of ~580 ms
	  with an initramfs size of ~120MB.
v8:
	- Synced with mainline to keep series up-to-date
v7:
	-- Addressed comments from James Morse
	- arm64: hibernate: pass the allocated pgdp to ttbr0
	  Removed "Fixes" tag, and added Added Reviewed-by: James Morse
	- arm64: hibernate: check pgd table allocation
	  Sent out as a standalone patch so it can be sent to stable
	  Series applies on mainline + this patch
	- arm64: hibernate: add trans_pgd public functions
	  Remove second allocation of tmp_pg_dir in swsusp_arch_resume
	  Added Reviewed-by: James Morse <james.morse@arm.com>
	- arm64: kexec: move relocation function setup and clean up
	  Fixed typo in commit log
	  Changed kern_reloc to phys_addr_t types.
	  Added explanation why kern_reloc is needed.
	  Split into four patches:
	  arm64: kexec: make dtb_mem always enabled
	  arm64: kexec: remove unnecessary debug prints
	  arm64: kexec: call kexec_image_info only once
	  arm64: kexec: move relocation function setup
	- arm64: kexec: add expandable argument to relocation function
	  Changed types of new arguments from unsigned long to phys_addr_t.
	  Changed offset prefix to KEXEC_*
	  Split into four patches:
	  arm64: kexec: cpu_soft_restart change argument types
	  arm64: kexec: arm64_relocate_new_kernel clean-ups
	  arm64: kexec: arm64_relocate_new_kernel don't use x0 as temp
	  arm64: kexec: add expandable argument to relocation function
	- arm64: kexec: configure trans_pgd page table for kexec
	  Added invalid entries into EL2 vector table
	  Removed KEXEC_EL2_VECTOR_TABLE_SIZE and KEXEC_EL2_VECTOR_TABLE_OFFSET
	  Copy relocation functions and table into separate pages
	  Changed types in kern_reloc_arg.
	  Split into three patches:
	  arm64: kexec: offset for relocation function
	  arm64: kexec: kexec EL2 vectors
	  arm64: kexec: configure trans_pgd page table for kexec
	- arm64: kexec: enable MMU during kexec relocation
	  Split into two patches:
	  arm64: kexec: enable MMU during kexec relocation
	  arm64: kexec: remove head from relocation argument
v6:
	- Sync with mainline tip
	- Added Acked's from Dave Young
v5:
	- Addressed comments from Matthias Brugger: added review-by's, improved
	  comments, and made cleanups to swsusp_arch_resume() in addition to
	  create_safe_exec_page().
	- Synced with mainline tip.
v4:
	- Addressed comments from James Morse.
	- Split "check pgd table allocation" into two patches, and moved to
	  the beginning of series  for simpler backport of the fixes.
	  Added "Fixes:" tags to commit logs.
	- Changed "arm64, hibernate:" to "arm64: hibernate:"
	- Added Reviewed-by's
	- Moved "add PUD_SECT_RDONLY" earlier in series to be with other
	  clean-ups
	- Added "Derived from:" to arch/arm64/mm/trans_pgd.c
	- Removed "flags" from trans_info
	- Changed .trans_alloc_page assumption to return zeroed page.
	- Simplify changes to trans_pgd_map_page(), by keeping the old
	  code.
	- Simplify changes to trans_pgd_create_copy, by keeping the old
	  code.
	- Removed: "add trans_pgd_create_empty"
	- replace init_mm with NULL, and keep using non "__" version of
	  populate functions.
v3:
	- Split changes to create_safe_exec_page() into several patches for
	  easier review as request by Mark Rutland. This is why this series
	  has 3 more patches.
	- Renamed trans_table to tans_pgd as agreed with Mark. The header
	  comment in trans_pgd.c explains that trans stands for
	  transitional page tables. Meaning they are used in transition
	  between two kernels.
v2:
	- Fixed hibernate bug reported by James Morse
	- Addressed comments from James Morse:
	  * More incremental changes to trans_table
	  * Removed TRANS_FORCEMAP
	  * Added kexec reboot data for image with 380M in size.

Enable MMU during kexec relocation in order to improve reboot performance.

If kexec functionality is used for a fast system update, with a minimal
downtime, the relocation of kernel + initramfs takes a significant portion
of reboot.

The reason for slow relocation is because it is done without MMU, and thus
not benefiting from D-Cache.

Performance data
----------------
For this experiment, the size of kernel plus initramfs is small, only 25M.
If initramfs was larger, than the improvements would be greater, as time
spent in relocation is proportional to the size of relocation.

Previously:
kernel shutdown	0.022131328s
relocation	0.440510736s
kernel startup	0.294706768s

Relocation was taking: 58.2% of reboot time

Now:
kernel shutdown	0.032066576s
relocation	0.022158152s
kernel startup	0.296055880s

Now: Relocation takes 6.3% of reboot time

Total reboot is x2.16 times faster.

With bigger userland (fitImage 380M), the reboot time is improved by 3.57s,
and is reduced from 3.9s down to 0.33s

Previous approaches and discussions
-----------------------------------
v10: https://lore.kernel.org/linux-arm-kernel/20210125191923.1060122-1-pasha.tatashin@soleen.com
v9: https://lore.kernel.org/lkml/20200326032420.27220-1-pasha.tatashin@soleen.com
v8: https://lore.kernel.org/lkml/20191204155938.2279686-1-pasha.tatashin@soleen.com
v7: https://lore.kernel.org/lkml/20191016200034.1342308-1-pasha.tatashin@soleen.com
v6: https://lore.kernel.org/lkml/20191004185234.31471-1-pasha.tatashin@soleen.com
v5: https://lore.kernel.org/lkml/20190923203427.294286-1-pasha.tatashin@soleen.com
v4: https://lore.kernel.org/lkml/20190909181221.309510-1-pasha.tatashin@soleen.com
v3: https://lore.kernel.org/lkml/20190821183204.23576-1-pasha.tatashin@soleen.com
v2: https://lore.kernel.org/lkml/20190817024629.26611-1-pasha.tatashin@soleen.com
v1: https://lore.kernel.org/lkml/20190801152439.11363-1-pasha.tatashin@soleen.com

Older approaches:
https://lore.kernel.org/lkml/20190709182014.16052-1-pasha.tatashin@soleen.com
reserve space for kexec to avoid relocation, involves changes to generic code
to optimize a problem that exists on arm64 only:

https://lore.kernel.org/lkml/20190716165641.6990-1-pasha.tatashin@soleen.com
The first attempt to enable MMU, some bugs that prevented performance
improvement. The page tables unnecessary configured idmap for the whole
physical space.

https://lore.kernel.org/lkml/20190731153857.4045-1-pasha.tatashin@soleen.com
No linear copy, bug with EL2 reboots.

Pavel Tatashin (6):
  arm64: kexec: add expandable argument to relocation function
  arm64: kexec: use ld script for relocation function
  arm64: kexec: kexec may require EL2 vectors
  arm64: kexec: configure trans_pgd page table for kexec
  arm64: kexec: enable MMU during kexec relocation
  arm64: kexec: remove head from relocation argument

 arch/arm64/Kconfig                  |   2 +-
 arch/arm64/include/asm/kexec.h      |  37 ++++++
 arch/arm64/include/asm/sections.h   |   1 +
 arch/arm64/kernel/asm-offsets.c     |  15 +++
 arch/arm64/kernel/cpu-reset.S       |  11 +-
 arch/arm64/kernel/cpu-reset.h       |   8 +-
 arch/arm64/kernel/machine_kexec.c   | 139 ++++++++++++++++++--
 arch/arm64/kernel/relocate_kernel.S | 190 ++++++++++++++++++----------
 arch/arm64/kernel/vmlinux.lds.S     |  19 +++
 9 files changed, 332 insertions(+), 90 deletions(-)

-- 
2.25.1

