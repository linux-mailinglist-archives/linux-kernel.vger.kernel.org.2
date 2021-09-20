Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D738C410E09
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 02:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhITAm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 20:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbhITAm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 20:42:27 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C139C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 17:41:01 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t10so53912532lfd.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 17:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=+n99lWgG80JSbF+dL8zcHr9dFV+b0nZZGcbwVXXcNl8=;
        b=UqX2xREU5zQWJ4CFmYd9o7fEj7klNsVifyJE0ACPZnIytEt/M6k+/fliThVkofraYd
         T7rGklveLN76c+I5ygy7cFig6W49NOyJuYQTNSh25DSL5xWlyKKNnb6ULW/qpQjnF1Yx
         6aFB37HlFDJZywvKO8SQxLeTicK/Yp4LXVwGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=+n99lWgG80JSbF+dL8zcHr9dFV+b0nZZGcbwVXXcNl8=;
        b=3u1s/ezsZ5JYWiCi8bUtU2lsfSP4tXNdllUB4kXNCYpCKpLyy6dKaOaIHUwbGwl3eZ
         alN+M8AVtsFCsFaIEgFekGWGgPEYU61fE25zcS0hnsnVexxK/jdrJDqh1WYWXRC42nPM
         iDgXUI3+CRLEJzq8sawyb/HvCyp2vQad9YsoqVokh74nsNniCL3RqDJNwwxTgqAPoiWi
         fHuEvFlfmG+ekqZihKQiZFNXKLI/gR59cMW89+9f5Ncxxcnerz6CwIlqUqA/pbbltjiR
         64yj50M2u+LYQqE+BGrCWYxmZbTptNgDhq4Yc+4ieCxZHTmygyAGOeRsBx1Bp3MU5TF3
         CbLw==
X-Gm-Message-State: AOAM531sKwhUf+POdzMFGuXmg3gekyM1/3ZO1yMAxKg5EGh4+Do9IfvA
        7MQs13i+CFUyQyHn6c7Kd1Micik5mYLWj8Ff
X-Google-Smtp-Source: ABdhPJyK9DBLT4i8zdtOwost0GB1GqnG/KnwiIMUmlJATCQLGke6dxKnMY+2pa+vrSSkqCtfx8BDbw==
X-Received: by 2002:a2e:b0f6:: with SMTP id h22mr20580908ljl.336.1632098458803;
        Sun, 19 Sep 2021 17:40:58 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id r2sm1541330ljj.14.2021.09.19.17.40.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Sep 2021 17:40:58 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id i25so60644847lfg.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 17:40:58 -0700 (PDT)
X-Received: by 2002:a2e:bc1e:: with SMTP id b30mr20564142ljf.191.1632098457954;
 Sun, 19 Sep 2021 17:40:57 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Sep 2021 17:40:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wirexiZR+VO=H3xemGKOMkh8OasmXaKXTKUmAKYCzi8AQ@mail.gmail.com>
Message-ID: <CAHk-=wirexiZR+VO=H3xemGKOMkh8OasmXaKXTKUmAKYCzi8AQ@mail.gmail.com>
Subject: Linux 5.15-rc2
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So I've spent a fair amount of this week trying to sort out all the
odd warnings, and I want to particularly thank Guenter Roeck for his
work on tracking where the build failures due to -Werror come from.

Is it done? No. But on the whole I'm feeling fairly good about this
all, even if it has meant that I've been looking at some really odd
and grotty code. Who knew I'd still worry about some odd EISA driver
on alpha, after all these years? A slight change of pace ;)

The most annoying thing is probably the "fix one odd corner case,
three others rear their ugly heads". But I remain convinced that it's
all for a good cause, and that we really do want to have a clean build
even for the crazy odd cases.

We'll get there.

Anyway, I hope this release will turn more normal soon - but the rc2
week tends to be fairly quiet for me, so the fact that I then ended up
looking at reports of odd warnings-turned-errors this week wasn't too
bad.

There's obviously other fixes in here too, only a small subset of the
shortlog below is due to the warning fixes, even if that's what I've
personally been most involved with.

Go test, and keep the reports coming,

                Linus

---

Adam Borowski (1):
      net: wan: wanxl: define CROSS_COMPILE_M68K

Adrian Bunk (1):
      bnx2x: Fix enabling network interfaces without VFs

Adrian Hunter (1):
      perf script: Fix ip display when type !=3D attr->type

Aleksander Jan Bajkowski (1):
      net: dsa: lantiq_gswip: Add 200ms assert delay

Alex Deucher (1):
      drm/amdgpu/display: add a proper license to dc_link_dp.c

Alex Elder (1):
      net: ipa: initialize all filter table slots

Alexander Egorenkov (1):
      s390/sclp: fix Secure-IPL facility detection

Alim Akhtar (1):
      dt-bindings: ufs: Add bindings for Samsung ufs host

Andrea Claudi (1):
      selftest: net: fix typo in altname test

Andreas Larsson (1):
      sparc32: page align size in arch_dma_alloc

Andrii Nakryiko (1):
      perf bpf: Ignore deprecation warning when using libbpf's
btf__get_from_id()

Andy Shevchenko (1):
      x86/platform: Increase maximum GPIO number for X86_64

Anson Jacob (1):
      drm/amd/display: dc_assert_fp_enabled assert only if FPU is not enabl=
ed

Ansuel Smith (1):
      net: dsa: qca8k: fix kernel panic with legacy mdio mapping

Anton Eidelman (1):
      nvme-multipath: fix ANA state updates when a namespace is not present

Ariel Marcovitch (2):
      checkkconfigsymbols.py: Forbid passing 'HEAD' to --commit
      checkkconfigsymbols.py: Remove skipping of help lines in
parse_kconfig_file

Arnd Bergmann (2):
      ne2000: fix unused function warning
      drm/rockchip: cdn-dp-core: Make cdn_dp_core_resume __maybe_unused

Aya Levin (3):
      net/mlx5e: Fix mutual exclusion between CQE compression and HW TS
      net/mlx5e: Fix condition when retrieving PTP-rqn
      udp_tunnel: Fix udp_tunnel_nic work-queue type

Baptiste Lepers (1):
      events: Reuse value read using READ_ONCE instead of re-reading it

Baruch Siach (1):
      net/packet: clarify source of pr_*() messages

Bixuan Cui (1):
      bpf: Add oversize check before call kvcalloc()

Bjorn Helgaas (1):
      PCI/VPD: Defer VPD sizing until first access

Boqun Feng (1):
      locking/rwbase: Take care of ordering guarantee for fastpath reader

Chris Wilson (1):
      rtc: cmos: Disable irq around direct invocation of cmos_interrupt()

Christian K=C3=B6nig (1):
      drm/amdgpu: fix use after free during BO move

Christoph Hellwig (3):
      dma-mapping: fix the kerneldoc for dma_map_sg_attrs
      block: check if a profile is actually registered in
blk_integrity_unregister
      nvme: remove the call to nvme_update_disk_info in nvme_ns_remove

Colin Ian King (1):
      qlcnic: Remove redundant initialization of variable ret

C=C3=A9dric Le Goater (1):
      powerpc/xics: Set the IRQ chip data for the ICS native backend

Dan Carpenter (1):
      nvmet: fix a width vs precision bug in nvmet_subsys_attr_serial_show(=
)

Dan Li (1):
      arm64: Mark __stack_chk_guard as __ro_after_init

Daniel Borkmann (4):
      bpf: Relicense disassembler as GPL-2.0-only OR BSD-2-Clause
      bpf, cgroups: Fix cgroup v2 fallback on v1/v2 mixed mode
      bpf, selftests: Add cgroup v1 net_cls classid helpers
      bpf, selftests: Add test case for mixed cgroup v1/v2

Daniel Vetter (1):
      drm/i915: Release ctx->syncobj on final put, not on ctx close

Daniel Wagner (1):
      nvme: avoid race in shutdown namespace removal

Daniele Ceraolo Spurio (1):
      drm/i915/guc: drop guc_communication_enabled

Dave Ertman (1):
      ice: Correctly deal with PFs that do not support RDMA

David Brazdil (1):
      of: restricted dma: Fix condition for rmem init

David Heidelberg (1):
      dt-bindings: arm: Fix Toradex compatible typo

David Hildenbrand (1):
      s390/pci_mmio: fully validate the VMA before calling follow_pte()

David Thompson (1):
      mlxbf_gige: clear valid_polarity upon open

Doug Smythies (1):
      cpufreq: intel_pstate: Override parameters if HWP forced by BIOS

Edwin Peer (1):
      bnxt_en: make bnxt_free_skbs() safe to call after bnxt_free_mem()

Eli Cohen (1):
      net/{mlx5|nfp|bnxt}: Remove unnecessary RTNL lock assert

Eric Dumazet (3):
      net/af_unix: fix a data-race in unix_dgram_poll
      net-caif: avoid user-triggerable WARN_ON(1)
      Revert "Revert "ipv4: fix memory leaks in ip_cmsg_send() callers""

Ernst Sj=C3=B6strand (1):
      drm/amd/amdgpu: Increase HWIP_MAX_INSTANCE to 10

Eugene Syromiatnikov (1):
      io-wq: provide IO_WQ_* constants for
IORING_REGISTER_IOWQ_MAX_WORKERS arg items

Evan Quan (2):
      PCI: Add AMD GPU multi-function power dependencies
      drm/amd/pm: fix runpm hang when amdgpu loaded prior to sound driver

Felix Kuehling (1):
      drm/amdkfd: make needs_pcie_atomics FW-version dependent

Florian Fainelli (1):
      r6040: Restore MDIO clock frequency after MAC reset

Ganesh Goudar (1):
      powerpc/mce: Fix access error in mce handler

Geert Uytterhoeven (2):
      m68k: mvme: Remove overdue #warnings in RTC handling
      sh: Add missing FORCE prerequisites in Makefile

Guenter Roeck (9):
      net: ni65: Avoid typecast of pointer to u32
      m68k: Double cast io functions to unsigned long
      compiler.h: Introduce absolute_pointer macro
      net: i825xx: Use absolute_pointer for memcpy from fixed memory locati=
on
      alpha: Move setup.h out of uapi
      alpha: Use absolute_pointer to define COMMAND_LINE
      alpha: Declare virt_to_phys and virt_to_bus parameter as pointer
to volatile
      cpufreq: vexpress: Drop unused variable
      net: 6pack: Fix tx timeout and slot time

Hamza Mahfooz (1):
      dma-debug: prevent an error message from causing runtime problems

Hao Xu (2):
      io-wq: code clean of io_wqe_create_worker()
      io-wq: fix potential race of acct->nr_workers

Harry Wentland (1):
      drm/amd/display: Get backlight from PWM if DMCU is not initialized

Heiko Carstens (3):
      s390: update defconfigs
      s390/ap: fix kernel doc comments
      s390: remove WARN_DYNAMIC_STACK

Helge Deller (2):
      parisc: Use absolute_pointer() to define PAGE0
      parisc: Declare pci_iounmap() parisc version only when CONFIG_PCI ena=
bled

Hersen Wu (1):
      drm/amd/display: dsc mst 2 4K displays go dark with 2 lane HBR3

Hoang Le (1):
      tipc: increase timeout in tipc_sk_enqueue()

Huang Rui (1):
      drm/ttm: fix type mismatch error on sparc64

Ian Rogers (1):
      libperf evsel: Make use of FD robust.

James Morse (1):
      cpufreq: schedutil: Destroy mutex before kobject_put() frees the memo=
ry

James Zhu (3):
      drm/amdkfd: separate kfd_iommu_resume from kfd_resume
      drm/amdgpu: add amdgpu_amdkfd_resume_iommu
      drm/amdgpu: move iommu_resume before ip init/resume

Jan Beulich (9):
      xen/pvcalls: backend can be a module
      swiotlb-xen: avoid double free
      swiotlb-xen: fix late init retry
      swiotlb-xen: maintain slab count properly
      swiotlb-xen: suppress certain init retries
      swiotlb-xen: limit init retries
      swiotlb-xen: drop leftover __ref
      swiotlb-xen: arrange to have buffer info logged
      swiotlb-xen: drop DEFAULT_NSLABS

Jean-Philippe Brucker (2):
      selftests/bpf: Fix build of task_pt_regs test for arm64
      PCI/ACPI: Don't reset a fwnode set by OF

Jeff Moyer (1):
      x86/pat: Pass valid address to sanitize_phys()

Jens Axboe (6):
      io_uring: ensure symmetry in handling iter types in loop_rw_iter()
      io_uring: pin SQPOLL data before unlocking ring lock
      iov_iter: add helper to save iov_iter state
      io_uring: allow retry for O_NONBLOCK if async is supported
      io_uring: use iov_iter state save/restore helpers
      Revert "iov_iter: track truncated size"

Jeremy Kerr (1):
      mctp: perform route destruction under RCU read lock

Jesper Nilsson (1):
      net: stmmac: allow CSR clock of 300MHz

Jiaran Zhang (2):
      net: hns3: fix the exception when query imp info
      net: hns3: fix the timing issue of VF clearing interrupt sources

Joakim Zhang (2):
      net: stmmac: fix system hang caused by eee_ctrl_timer during
suspend/resume
      net: stmmac: platform: fix build warning when with !CONFIG_PM_SLEEP

Jon Derrick (1):
      MAINTAINERS: Add Nirmal Patel as VMD maintainer

Juergen Gross (4):
      xen/balloon: use a kernel thread instead a workqueue
      PM: base: power: don't try to use non-existing RTC for storing data
      xen: reset legacy rtc flag for PV domU
      xen: fix usage of pmd_populate in mremap for pv guests

Kai-Heng Feng (1):
      drm/i915/dp: Use max params for panels < eDP 1.4

Keith Busch (1):
      nvme-tcp: fix io_work priority inversion

Kenneth Feng (1):
      drm/amd/pm: fix the issue of uploading powerplay table

Kortan (1):
      gen_compile_commands: fix missing 'sys' package

Lang Yu (5):
      drm/amdgpu: fix sysfs_emit/sysfs_emit_at warnings(v2)
      drm/amdgpu: update SMU PPSMC for cyan skilfish
      drm/amdgpu: update SMU driver interface for cyan skilfish(v3)
      drm/amdgpu: add some pptable funcs for cyan skilfish(v3)
      drm/amdgpu: add manual sclk/vddc setting support for cyan skilfish(v3=
)

Lee Shawn C (1):
      drm/i915/dp: return proper DPRX link training result

Len Baker (1):
      net: mana: Prefer struct_size over open coded arithmetic

Li Jinlin (1):
      blk-cgroup: fix UAF by grabbing blkcg lock before destroying blkg pd

Lihong Kou (1):
      block: flush the integrity workqueue in blk_integrity_unregister

Lin, Zhenpeng (1):
      dccp: don't duplicate ccid when cloning dccp sock

Linus Torvalds (17):
      compiler_attributes.h: drop __has_attribute() support for gcc4
      Drop some straggling mentions of gcc-4.9 as being stale
      memblock: introduce saner 'memblock_free_ptr()' interface
      sparc: avoid stringop-overread errors
      qnx4: avoid stringop-overread errors
      3com 3c515: make it compile on 64-bit architectures
      spi: Fix tegra20 build with CONFIG_PM=3Dn
      alpha: make 'Jensen' IO functions build again
      tgafb: clarify dependencies
      alpha: mark 'Jensen' platform as no longer broken
      alpha: move __udiv_qrnnd library function to arch/alpha/lib/
      Revert drm/vc4 hdmi runtime PM changes
      Revert "drm/vc4: hdmi: Remove drm_encoder->crtc usage"
      alpha: enable GENERIC_PCI_IOMAP unconditionally
      dmascc: use proper 'virt_to_bus()' rather than casting to 'int'
      pci_iounmap'2: Electric Boogaloo: try to make sense of it all
      Linux 5.15-rc2

Lucas Stach (8):
      drm/etnaviv: return context from etnaviv_iommu_context_get
      drm/etnaviv: put submit prev MMU context when it exists
      drm/etnaviv: stop abusing mmu_context as FE running marker
      drm/etnaviv: keep MMU context across runtime suspend/resume
      drm/etnaviv: exec and MMU state is lost when resetting the GPU
      drm/etnaviv: fix MMU context leak on GPU reset
      drm/etnaviv: reference MMU context when setting up hardware state
      drm/etnaviv: add missing MMU context put when reaping MMU mapping

Lv Ruyi (1):
      arm64/kernel: remove duplicate include in process.c

Maor Gottlieb (1):
      net/mlx5: Fix potential sleeping in atomic context

Mark Bloch (1):
      net/mlx5: Lag, don't update lag if lag isn't supported

Mark Brown (1):
      arm64/sve: Use correct size when reinitialising SVE state

Masami Hiramatsu (1):
      tools/bootconfig: Define memblock_free_ptr() to fix build error

Mauro Carvalho Chehab (2):
      dt-bindings: net: dsa: sja1105: update nxp,sja1105.yaml reference
      dt-bindings: arm: mediatek: mmsys: update mediatek,mmsys.yaml referen=
ce

Meenakshikumar Somasundaram (1):
      drm/amd/display: Link training retry fix for abort case

Michael Chan (2):
      bnxt_en: Fix error recovery regression
      bnxt_en: Clean up completion ring page arrays completely

Michael Ellerman (1):
      powerpc/boot: Fix build failure since GCC 4.9 removal

Michael Petlan (1):
      perf machine: Initialize srcline string member in add_location struct

Michel D=C3=A4nzer (1):
      drm/amdgpu: Drop inline from amdgpu_ras_eeprom_max_record_count

Mike Rapoport (1):
      x86/mm: Fix kern_addr_valid() to cope with existing but not
present entries

Ming Lei (1):
      blk-mq: avoid to iterate over stale request

Nathan Chancellor (6):
      tools: compiler-gcc.h: Guard error attribute use with __has_attribute
      drm/i915/selftests: Do not use import_obj uninitialized
      drm/i915/selftests: Always initialize err in
igt_dmabuf_import_same_driver_lmem()
      drm/i915: Enable -Wsometimes-uninitialized
      x86/build: Do not add -falign flags unconditionally for clang
      kbuild: Add -Werror=3Dignored-optimization-argument to CLANG_FLAGS

Nathan Rossi (1):
      net: phylink: Update SFP selected interface on advertising changes

Nicholas Kazlauskas (2):
      drm/amd/display: Add NULL checks for vblank workqueue
      drm/amd/display: Fix white screen page fault for gpuvm

Nicholas Piggin (4):
      powerpc/64s: system call scv tabort fix for corrupt irq soft-mask sta=
te
      selftests/powerpc: Add scv versions of the basic TM syscall tests
      powerpc/64s: system call rfscv workaround for TM bugs
      KVM: PPC: Book3S HV: Tolerate treclaim. in fake-suspend mode
changing registers

Nick Desaulniers (10):
      Documentation: raise minimum supported version of GCC to 5.1
      compiler.h: drop fallback overflow checkers
      mm/ksm: remove old GCC 4.9+ check
      Kconfig.debug: drop GCC 5+ version check for DWARF5
      riscv: remove Kconfig check for GCC version for ARCH_RV64I
      powerpc: remove GCC version check for UPD_CONSTR
      arm64: remove GCC version check for ARCH_SUPPORTS_INT128
      Makefile: drop GCC < 5 -fno-var-tracking-assignments workaround
      compiler-gcc.h: drop checks for older GCC versions
      vmlinux.lds.h: remove old check for GCC 4.9

Nirmoy Das (2):
      drm/amdgpu: use IS_ERR for debugfs APIs
      drm/radeon: pass drm dev radeon_agp_head_init directly

Paolo Abeni (2):
      vhost_net: fix OoB on sendmsg() failure.
      igc: fix tunnel offloading

Parav Pandit (1):
      net/mlx5: Fix rdma aux device on devlink reload

Paul Menzel (1):
      drm/amdgpu: Demote TMZ unsupported log message from warning to info

Pavel Begunkov (2):
      io_uring: auto-removal for direct open/accept
      io_uring: move iopoll reissue into regular IO path

Peter Zijlstra (2):
      locking/rwbase: Properly match set_and_save_state() to restore_state(=
)
      locking/rwbase: Extract __rwbase_write_trylock()

Qingqing Zhuo (1):
      drm/amd/display: Fix unstable HPCP compliance on Chrome Barcelo

Ramji Jiyani (1):
      kbuild: Fix comment typo in scripts/Makefile.modpost

Randy Dunlap (1):
      ptp: dp83640: don't define PAGE0

Ravi Bangoria (1):
      perf annotate: Fix fused instr logic for assembly functions

Ruozhu Li (1):
      nvme-rdma: destroy cm id before destroy qp to avoid use after free

Saeed Mahameed (1):
      net/mlx5: FWTrace, cancel work on alloc pd error flow

Samuel Holland (1):
      dt-bindings: net: sun8i-emac: Add compatible for D1

Saravana Kannan (1):
      Revert "of: property: fw_devlink: Add support for "phy-handle" proper=
ty"

Shai Malin (1):
      qed: Handle management FW error

Simon Ser (2):
      amd/display: downgrade validation failure log level
      amd/display: enable panel orientation quirks

Sukadev Bhattiprolu (2):
      ibmvnic: check failover_pending in login response
      ibmvnic: check failover_pending in login response

Thomas Hellstr=C3=B6m (1):
      drm/i915/gem: Fix the mman selftest

Tong Zhang (1):
      net: macb: fix use after free on rmmod

Tony Luck (1):
      x86/mce: Avoid infinite loop for copy from user recovery

Vasily Averin (1):
      ipc: remove memcg accounting for sops objects in do_semtimedop()

Vinay Belgaumkar (1):
      drm/i915: Get PM ref before accessing HW register

Vitaly Kuznetsov (1):
      Drivers: hv: vmbus: Fix kernel crash upon unbinding a device
from uio_hv_generic driver

Vlad Buslov (1):
      net/mlx5: Bridge, fix uninitialized variable usage

Vladimir Oltean (3):
      net: dsa: destroy the phylink instance on any error in dsa_slave_phy_=
setup
      Revert "net: phy: Uniform PHY driver access"
      net: dsa: flush switchdev workqueue before tearing down CPU/DSA ports

Wei Liu (2):
      asm-generic/hyperv: provide cpumask_to_vpset_noself
      x86/hyperv: remove on-stack cpumask from hv_send_ipi_mask_allbutself

Will Deacon (1):
      x86/uaccess: Fix 32-bit __get_user_asm_u64() when CC_HAS_ASM_GOTO_OUT=
PUT=3Dy

Xiang wangx (1):
      selftests: nci: replace unsigned int with int

Xiaoguang Wang (1):
      io_uring: fix missing sigmask restore in io_cqring_wait()

Xiyu Yang (1):
      net/l2tp: Fix reference count leak in l2tp_udp_recv_core

Yajun Deng (1):
      Revert "ipv4: fix memory leaks in ip_cmsg_send() callers"

Yanfei Xu (1):
      blkcg: fix memory leak in blk_iolatency_init

Yonghong Song (1):
      bpf, mm: Fix lockdep warning triggered by stack_map_get_build_id_offs=
et()

Yufeng Mo (3):
      net: hns3: pad the short tunnel frame before sending to hardware
      net: hns3: change affinity_mask to numa node range
      net: hns3: disable mac in flr process

Yunsheng Lin (1):
      net: hns3: add option to turn off page pool feature

zhang kai (1):
      ipv6: delay fib6_sernum increase in fib6_add

zhenggy (1):
      tcp: fix tp->undo_retrans accounting in tcp_sacktag_one()

=C3=8D=C3=B1igo Huguet (2):
      sfc: fallback for lack of xdp tx queues
      sfc: last resort fallback for lack of xdp tx queues
