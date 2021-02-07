Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFB3312857
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 00:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhBGX23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 18:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhBGX1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 18:27:01 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB374C061786
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 15:26:20 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id u20so12779102qku.7
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 15:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=znyXb+K4kU3R/Yvlr833eh13pVEYF37rWeuEdenuTnY=;
        b=uOGN2tQQN1hixdWcobRvB+RNJd2sZ/enZz6qR2i11k1ncT4c25SH3o5CZzYB8gRwWk
         hOCWgqV7/6fi0c4lnlex9K97AApKp7RGc615s5RFEro+zkLQUTytD/Cyy7kUrkKWaHtM
         AP6735X27/woutWVMU4l+AYiZ2w2PzAEUica0CPablpU7U4o/0ACw37aD8ZhRi1e3vVK
         HwkE55NZQivChe95H8UU708iCcbgixIwVVW+I4BOKvc7s6dIeIyHo3e+BLxfLuzRESYg
         5zoziYYdBNLYGDJ8LoVGHJx+SFqvmag58iPnl30pRAe9p4YHblJRsRt7eOw24dhC6Tb7
         5RXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=znyXb+K4kU3R/Yvlr833eh13pVEYF37rWeuEdenuTnY=;
        b=qaTYil1wDSCWee6nSG8WHEBwzqJk3cD+7sIrykiunvuNVTkWPWXWIeQMynBqHN1Y2b
         cO3OqwTTGLVnSw93e7EkjA8JlOu4jVr1Y+Ez3fUZvSrUy7QUwQYPjCXwuyEgK2XyEznp
         SaqgcmbRkCIllWRf9suRO/AmuIIINF9Pt8ZOYYBKcFat6uKPRRbEdr6rGw01LhkjhmtY
         ODaCS3RKp5dW271YJZ0alrLqDhY7RxMRoKun8nH/qPNMErtze/t2W5iQg2k3+vxL3nWf
         KKM+QPPqjpmaAyjp1dxA+u8WpxWWadUHnupAZ8V/zMEGS1m0Qzw0HtPfPkv1Qxfgkjnl
         3AOg==
X-Gm-Message-State: AOAM532PelKjeEfI7wAuA78sr0kj/WX+c/C/AP5xQF8iX8jpcUKGfDg2
        ui76rqt7jQADAygjlwlW6tE=
X-Google-Smtp-Source: ABdhPJzPVGQg1frkrjxAAhqF30SzcwSzctIxh/7IFHbPiX7IHUdeG/uA/lQwvUv+UjU+yNbV3db+qg==
X-Received: by 2002:a05:620a:14a6:: with SMTP id x6mr14211725qkj.152.1612740379755;
        Sun, 07 Feb 2021 15:26:19 -0800 (PST)
Received: from OpenSuse ([156.146.36.180])
        by smtp.gmail.com with ESMTPSA id 196sm15870338qkl.4.2021.02.07.15.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 15:26:18 -0800 (PST)
Date:   Mon, 8 Feb 2021 04:56:13 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.11-rc7
Message-ID: <YCB3FV0gh+cNMhLL@OpenSuse>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wgxhBkWH0D6chYcwqDvdh2rB5ZVpToxodz5Q6qaFd_qyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NS7fh8N4u3WhSjLC"
Content-Disposition: inline
In-Reply-To: <CAHk-=wgxhBkWH0D6chYcwqDvdh2rB5ZVpToxodz5Q6qaFd_qyg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NS7fh8N4u3WhSjLC
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14:32 Sun 07 Feb 2021, Linus Torvalds wrote:
>
>and hopefully life goes on with the weekly celebration involving
>compiling and testing new kernels instead.
>
>Right?
>
Yup, that's the standard ritual! Now, time to spin this RC fellow too side =
by side :)

~Bhaskar
>             Linus
>
>---
>
>Ahmed S. Darwish (1):
>      net: arcnet: Fix RESET flag handling
>
>Aleksandr Loktionov (1):
>      i40e: Revert "i40e: don't report link up for a VF who hasn't
>enabled queues"
>
>Alex Elder (4):
>      net: ipa: add a missing __iomem attribute
>      net: ipa: be explicit about endianness
>      net: ipa: use the right accessor in ipa_endpoint_status_skip()
>      net: ipa: fix two format specifier errors
>
>Alexander Ovechkin (1):
>      net: sched: replaced invalid qdisc tree flush helper in qdisc_replace
>
>Alexander Popov (1):
>      vsock: fix the race conditions in multi-transport support
>
>Alexandre Belloni (1):
>      ARM: dts: lpc32xx: Revert set default clock rate of HCLK PLL
>
>Alexandre Ghiti (1):
>      riscv: virt_addr_valid must check the address belongs to linear mapp=
ing
>
>Alexey Dobriyan (1):
>      Input: i8042 - unbreak Pegatron C15B
>
>Alexey Kardashevskiy (1):
>      tracepoint: Fix race between tracing and removing tracepoint
>
>Amir Goldstein (1):
>      ovl: skip getxattr of security labels
>
>Andreas Oetken (1):
>      net: hsr: align sup_multicast_addr in struct hsr_priv to u16 boundary
>
>Andres Calderon Jaramillo (1):
>      drm/i915/display: Prevent double YUV range correction on HDR planes
>
>Andrew Scull (1):
>      KVM: arm64: Don't clobber x4 in __do_hyp_init
>
>Andy Shevchenko (1):
>      scripts: switch explicitly to Python 3
>
>AngeloGioacchino Del Regno (2):
>      dt-bindings: input: touchscreen: goodix: Add binding for GT9286 IC
>      Input: goodix - add support for Goodix GT9286 chip
>
>Arnd Bergmann (1):
>      kallsyms: fix nonconverging kallsyms table with lld
>
>Atish Patra (2):
>      RISC-V: Fix .init section permission update
>      RISC-V: Define MAXPHYSMEM_1GB only for RV32
>
>Aurelien Aptel (1):
>      cifs: report error instead of invalid when revalidating a dentry fai=
ls
>
>Barry Song (2):
>      dma-mapping: benchmark: fix kernel crash when dma_map_single fails
>      dma-mapping: benchmark: use u8 for reserved field in uAPI structure
>
>Ben Gardon (1):
>      KVM: x86/mmu: Fix TDP MMU zap collapsible SPTEs
>
>Benjamin Valentin (1):
>      Input: xpad - sync supported devices with fork on GitHub
>
>Bhawanpreet Lakha (1):
>      drm/amd/display: reuse current context instead of recreating one
>
>Bjorn Andersson (2):
>      arm64: defconfig: Make INTERCONNECT_QCOM_SDM845 builtin
>      arm64: dts: qcom: sdm845: Reserve LPASS clocks in gcc
>
>Bjorn Helgaas (1):
>      Revert "PCI/ASPM: Save/restore L1SS Capability for suspend/resume"
>
>Borislav Petkov (2):
>      tools/power/turbostat: Fallback to an MSR read for EPB
>      x86/efi: Remove EFI PGD build time checks
>
>Catalin Marinas (2):
>      arm64: Do not pass tagged addresses to __is_lm_address()
>      arm64: Use simpler arithmetics for the linear map macros
>
>Chenxin Jin (1):
>      USB: serial: cp210x: add new VID/PID for supporting Teraoka AD2000
>
>Chinmay Agarwal (1):
>      neighbour: Prevent a dead entry from updating gc_list
>
>Chris Wilson (3):
>      drm/i915/gt: Move the breadcrumb to the signaler if completed upon c=
ancel
>      drm/i915/gt: Close race between enable_breadcrumbs and cancel_breadc=
rumbs
>      drm/i915/gem: Drop lru bumping on display unpinning
>
>Christian K=C3=B6nig (1):
>      drm/amdgpu: enable freesync for A+A configs
>
>Christoph Schemmel (1):
>      USB: serial: option: Adding support for Cinterion MV31
>
>Chuck Lever (1):
>      SUNRPC: Fix NFS READs that start at non-page-aligned offsets
>
>Chunfeng Yun (2):
>      usb: xhci-mtk: skip dropping bandwidth of unchecked endpoints
>      usb: xhci-mtk: break loop when find the endpoint to drop
>
>Claus Stovgaard (1):
>      nvme-pci: ignore the subsysem NQN on Phison E16
>
>DENG Qingfang (1):
>      net: dsa: mv88e6xxx: override existent unicast portvec in port_fdb_a=
dd
>
>Dafna Hirschfeld (3):
>      media: rkisp1: uapi: change hist_bins array type from __u16 to __u32
>      media: rkisp1: stats: remove a wrong cast to u8
>      media: rkisp1: stats: mask the hist_bins values
>
>Dan Carpenter (2):
>      USB: gadget: legacy: fix an error code in eth_bind()
>      net: ipa: pass correct dma_handle to dma_free_coherent()
>
>Dan Williams (3):
>      ACPI: NFIT: Fix flexible_array.cocci warnings
>      libnvdimm/namespace: Fix visibility of namespace resource attribute
>      libnvdimm/dimm: Avoid race between probe and available_slots_show()
>
>Daniel Jurgens (1):
>      net/mlx5: Fix function calculation for page trees
>
>Dave Airlie (1):
>      drm/nouveau: fix dma syncing warning with debugging on.
>
>Dave Hansen (1):
>      x86/apic: Add extra serialization for non-serializing MSRs
>
>David Howells (1):
>      rxrpc: Fix deadlock around release of dst cached on udp tunnel
>
>Dmitry Baryshkov (3):
>      drm/bridge/lontium-lt9611uxc: fix waiting for EDID to become availab=
le
>      drm/bridge/lontium-lt9611uxc: fix get_edid return code
>      drm/bridge/lontium-lt9611uxc: move HPD notification out of IRQ handl=
er
>
>Dmitry Osipenko (1):
>      ARM: 9043/1: tegra: Fix misplaced tegra_uart_config in decompressor
>
>Dongseok Yi (1):
>      udp: ipv4: manipulate network header of NATed UDP GRO fraglist
>
>Eli Cohen (2):
>      vdpa/mlx5: Fix memory key MTT population
>      vdpa/mlx5: Restore the hardware used index after change map
>
>Enrico Weigelt, metux IT consult (1):
>      kconfig: mconf: fix HOSTCC call
>
>Felix Fietkau (1):
>      mac80211: fix station rate table updates on assoc
>
>Fenghua Yu (1):
>      x86/split_lock: Enable the split lock feature on another Alder Lake =
CPU
>
>Fengnan Chang (1):
>      mmc: core: Limit retries when analyse of SDIO tuples fails
>
>Gabriel Krisman Bertazi (2):
>      entry: Ensure trap after single-step on system call return
>      entry: Use different define for selector variable in SUD
>
>Gary Bisson (1):
>      usb: dwc3: fix clock issue during resume in OTG mode
>
>Geert Uytterhoeven (4):
>      Input: st1232 - fix off-by-one error in resolution handling
>      Input: st1232 - do not read more bytes than needed
>      Input: st1232 - wait until device is ready before reading resolution
>      ntp: Use freezable workqueue for RTC synchronization
>
>George Shen (1):
>      drm/amd/display: Fix DPCD translation for LTTPR AUX_RD_INTERVAL
>
>Gustavo A. R. Silva (1):
>      smb3: Fix out-of-bounds bug in SMB2_negotiate()
>
>H. Nikolaus Schaller (2):
>      DTS: ARM: gta04: remove legacy spi-cs-high to make display work again
>      ARM: dts; gta04: SPI panel chip select is active low
>
>Hajime Tazaki (1):
>      um: ubd: fix command line handling of ubd
>
>Hans de Goede (4):
>      platform/x86: hp-wmi: Disable tablet-mode reporting by default
>      ACPI: scan: Fix battery devices sometimes never binding
>      staging: rtl8723bs: Move wiphy setup to after reading the
>regulatory settings from the chip
>      genirq: Prevent [devm_]irq_alloc_desc from returning irq 0
>
>Heiko Stuebner (4):
>      media: rockchip: rkisp1: reduce number of histogram grid elements in=
 uapi
>      media: rockchip: rkisp1: carry ip version information
>      media: rockchip: rkisp1: extend uapi array sizes
>      usb: dwc2: Fix endpoint direction check in ep_from_windex
>
>Heiner Kallweit (2):
>      r8169: work around RTL8125 UDP hw bug
>      r8169: fix WoL on shutdown if CONFIG_DEBUG_SHIRQ is set
>
>Heinrich Schuchardt (1):
>      dt-bindings: input: adc-keys: clarify description
>
>Hermann Lauer (1):
>      ARM: dts: sun7i: a20: bananapro: Fix ethernet phy-mode
>
>Huang Rui (2):
>      drm/amdgpu: fix the issue that retry constantly once the buffer
>is oversize
>      drm/amdkfd: fix null pointer panic while free buffer in kfd
>
>Hugh Dickins (1):
>      mm: thp: fix MADV_REMOVE deadlock on shmem THP
>
>Ikjoon Jang (1):
>      usb: xhci-mtk: fix unreleased bandwidth data
>
>Imre Deak (4):
>      drm/dp/mst: Export drm_dp_get_vc_payload_bw()
>      drm/i915: Fix the MST PBN divider calculation
>      drm/i915/dp: Move intel_dp_set_signal_levels() to intel_dp_link_trai=
ning.c
>      drm/i915/dp: Fix LTTPR vswing/pre-emp setting in non-transparent mode
>
>James Smart (1):
>      scsi: lpfc: Fix EEH encountering oops with NVMe traffic
>
>Jeremy Figgins (1):
>      USB: usblp: don't call usb_set_interface if there's a single alt
>
>Jianpeng Ma (1):
>      libnvdimm/pmem: Remove unused header
>
>Joerg Roedel (1):
>      iommu: Check dev->iommu in dev_iommu_priv_get() before dereferencing=
 it
>
>Johan Jonker (1):
>      arm64: dts: rockchip: remove interrupt-names property from
>rk3399 vdec node
>
>Johannes Berg (7):
>      um: return error from ioremap()
>      um: virtio: free vu_dev only with the contained struct device
>      Revert "um: allocate a guard page to helper threads"
>      Revert "um: support some of ARCH_HAS_SET_MEMORY"
>      um: fix os_idle_sleep() to not hang
>      um: time: fix initialization in time-travel mode
>      init/gcov: allow CONFIG_CONSTRUCTORS on UML to fix module gcov
>
>Josh Poimboeuf (1):
>      x86/build: Disable CET instrumentation in the kernel
>
>Kai-Heng Feng (1):
>      igc: Report speed and duplex as unknown when device is runtime suspe=
nded
>
>Keith Busch (1):
>      update the email address for Keith Bush
>
>Kent Gibson (1):
>      gpiolib: cdev: clear debounce period if line set to output
>
>Kevin Lo (2):
>      igc: set the default return value to -IGC_ERR_NVM in igc_write_nvm_s=
rwr
>      igc: check return value of ret_val in igc_config_fc_after_link_up
>
>Lai Jiangshan (2):
>      x86/debug: Prevent data breakpoints on __per_cpu_offset
>      x86/debug: Prevent data breakpoints on cpu_dr7
>
>Liangyan (1):
>      ovl: fix dentry leak in ovl_get_redirect
>
>Lijun Pan (1):
>      ibmvnic: device remove has higher precedence over reset
>
>Lin Feng (1):
>      bfq-iosched: Revert "bfq: Fix computation of shallow depth"
>
>Linus Torvalds (1):
>      Linux 5.11-rc7
>
>Linus Walleij (1):
>      ARM: OMAP1: OSK: fix ohci-omap breakage
>
>Loris Reiff (2):
>      bpf, cgroup: Fix optlen WARN_ON_ONCE toctou
>      bpf, cgroup: Fix problematic bounds check
>
>Manivannan Sadhasivam (1):
>      mailmap: add entries for Manivannan Sadhasivam
>
>Maor Dickman (1):
>      net/mlx5e: Release skb in case of failure in tc update skb
>
>Maor Gottlieb (1):
>      net/mlx5: Fix leak upon failure of rule creation
>
>Marc Zyngier (2):
>      arm64: dts: rockchip: Fix PCIe DT properties on rk3399
>      genirq/msi: Activate Multi-MSI early when MSI_FLAG_ACTIVATE_EARLY is=
 set
>
>Marek Szyprowski (1):
>      arm64: dts: meson: switch TFLASH_VDD_EN pin to open drain on Odroid-=
C4
>
>Marek Vasut (8):
>      Input: ili210x - implement pressure reporting for ILI251x
>      ARM: dts: stm32: Fix polarity of the DH DRC02 uSD card detect
>      ARM: dts: stm32: Connect card-detect signal on DHCOM
>      ARM: dts: stm32: Disable WP on DHCOM uSD slot
>      ARM: dts: stm32: Disable optional TSC2004 on DRC02 board
>      ARM: dts: stm32: Fix GPIO hog names on DHCOM
>      ARM: dts: stm32: Fix GPIO hog flags on DHCOM PicoITX
>      ARM: dts: stm32: Fix GPIO hog flags on DHCOM DRC02
>
>Mario Limonciello (2):
>      thunderbolt: Fix possible NULL pointer dereference in tb_acpi_add_li=
nk()
>      platform/x86: dell-wmi-sysman: fix a NULL pointer dereference
>
>Masahiro Yamada (8):
>      kbuild: simplify GCC_PLUGINS enablement in dummy-tools/gcc
>      doc: gcc-plugins: update gcc-plugins.rst
>      Revert "checkpatch: add check for keyword 'boolean' in Kconfig
>definitions"
>      powerpc/vdso: fix unnecessary rebuilds of vgettimeofday.o
>      powerpc/vdso64: remove meaningless vgettimeofday.o build rule
>      kbuild: remove PYTHON variable
>      scripts/clang-tools: switch explicitly to Python 3
>      kbuild: fix duplicated flags in DEBUG_CFLAGS
>
>Masami Hiramatsu (1):
>      tracing/kprobe: Fix to support kretprobe events on unloaded modules
>
>Mathias Nyman (1):
>      xhci: fix bounce buffer usage for non-sg list case
>
>Maxim Mikityanskiy (1):
>      net/mlx5e: Update max_opened_tc also when channels are closed
>
>Michael Roth (1):
>      KVM: x86: fix CPUID entries returned by KVM_GET_CPUID2 ioctl
>
>Michel D=C3=A4nzer (1):
>      drm/ttm: Use __GFP_NOWARN for huge pages in ttm_pool_alloc_page
>
>Miguel Ojeda (1):
>      clang-format: Update with the latest for_each macro list
>
>Mike Rapoport (1):
>      Revert "x86/setup: don't remove E820_TYPE_RAM for pfn 0"
>
>Mikita Lipski (1):
>      drm/amd/display: Release DSC before acquiring
>
>Mikko Ylinen (1):
>      bpf: Drop disabled LSM hooks from the sleepable set
>
>Miklos Szeredi (4):
>      ovl: add warning on user_ns mismatch
>      ovl: perform vfs_getxattr() with mounter creds
>      cap: fix conversions on getxattr
>      ovl: avoid deadlock on directory ioctl
>
>Muchun Song (6):
>      mm: hugetlbfs: fix cannot migrate the fallocated HugeTLB page
>      mm: hugetlb: fix a race between freeing and dissolving the page
>      mm: hugetlb: fix a race between isolating and freeing page
>      mm: hugetlb: remove VM_BUG_ON_PAGE from page_huge_active
>      mm: migrate: do not migrate HugeTLB page whose refcount is one
>      mm: hugetlb: fix missing put_page in gather_surplus_pages()
>
>Nathan Chancellor (3):
>      Documentation/llvm: Add a section about supported architectures
>      ubsan: implement __ubsan_handle_alignment_assumption
>      MAINTAINERS/.mailmap: use my @kernel.org address
>
>Neil Armstrong (1):
>      Revert "arm64: dts: amlogic: add missing ethernet reset ID"
>
>Pali Roh=C3=A1r (1):
>      usb: host: xhci: mvebu: make USB 3.0 PHY optional for Armada 3720
>
>Pan Bian (1):
>      bpf, inode_storage: Put file handler if no storage was found
>
>Paolo Bonzini (2):
>      KVM: x86: Allow guests to see MSR_IA32_TSX_CTRL even if tsx=3Doff
>      KVM: x86: cleanup CR3 reserved bits checks
>
>Paul Kocialkowski (1):
>      soc: sunxi: mbus: Remove DE2 display engine compatibles
>
>Pavel Begunkov (1):
>      io_uring: drop mm/files between task_work_submit
>
>Pavel Shilovsky (1):
>      smb3: fix crediting for compounding when only one request in flight
>
>Peter Gonda (1):
>      Fix unsynchronized access to sev members through svm_register_enc_re=
gion
>
>Peter Zijlstra (1):
>      x86/debug: Fix DR6 handling
>
>Pho Tran (1):
>      USB: serial: cp210x: add pid/vid for WSDA-200-USB
>
>Quanyang Wang (1):
>      gpiolib: free device name on error path to fix kmemleak
>
>Quentin Monnet (1):
>      bpf, preload: Fix build when $(O) points to a relative path
>
>Raoni Fassina Firmino (1):
>      powerpc/64/signal: Fix regression in __kernel_sigtramp_rt64() semant=
ics
>
>Ravi Bangoria (1):
>      powerpc/sstep: Fix array out of bound warning
>
>Rick Edgecombe (1):
>      mm/vmalloc: separate put pages and flush VM flags
>
>Robert Karszniewicz (1):
>      Documentation/Kbuild: Remove references to gcc-plugin.sh
>
>Robin Murphy (1):
>      arm64: dts: rockchip: Disable display for NanoPi R2S
>
>Rokudo Yan (1):
>      mm, compaction: move high_pfn to the for loop scope
>
>Rolf Eike Beer (1):
>      scripts: use pkg-config to locate libcrypto
>
>Roman Gushchin (1):
>      memblock: do not start bottom-up allocations with kernel_end
>
>Russell King (3):
>      ARM: footbridge: fix dc21285 PCI configuration accessors
>      ARM: ensure the signal page contains defined contents
>      ARM: kexec: fix oops after TLB are invalidated
>
>Sabyrzhan Tasbolatov (1):
>      net/rds: restrict iovecs length for RDS_CMSG_RDMA_ARGS
>
>Sagi Grimberg (1):
>      nvmet-tcp: fix out-of-bounds access when receiving multiple h2cdata =
PDUs
>
>Sandy Huang (1):
>      arm64: dts: rockchip: fix vopl iommu irq on px30
>
>Santosh Sivaraj (7):
>      testing/nvdimm: Add test module for non-nfit platforms
>      ndtest: Add compatability string to treat it as PAPR family
>      ndtest: Add dimms to the two buses
>      ndtest: Add dimm attributes
>      ndtest: Add regions and mappings to the test buses
>      ndtest: Add nvdimm control functions
>      ndtest: Add papr health related flags
>
>Sargun Dhillon (1):
>      ovl: implement volatile-specific fsync error behaviour
>
>Sean Christopherson (3):
>      KVM: x86: Update emulator context mode if SYSENTER xfers to 64-bit m=
ode
>      KVM: SVM: Treat SVM as unsupported when running as an SEV guest
>      KVM: x86: Set so called 'reserved CR3 bits in LM mask' at vCPU reset
>
>Sebastien Van Cauwenberghe (1):
>      riscv: Align on L1_CACHE_BYTES when STRICT_KERNEL_RWX
>
>Serge Semin (1):
>      arm64: dts: amlogic: meson-g12: Set FL-adj property value
>
>Shawn Guo (1):
>      arm64: dts: qcom: c630: keep both touchpad devices enabled
>
>Simon South (1):
>      arm64: dts: rockchip: Use only supported PCIe link speed on Pinebook=
 Pro
>
>Souptick Joarder (1):
>      Input: ariel-pwrbutton - remove unused variable ariel_pwrbutton_id_t=
able
>
>Stefan Chulski (1):
>      net: mvpp2: TCAM entry enable should be written after SRAM data
>
>Steven Rostedt (VMware) (1):
>      fgraph: Initialize tracing_graph_pause at task creation
>
>Stylon Wang (1):
>      drm/amd/display: Revert "Fix EDID parsing after resume from suspend"
>
>Sung Lee (1):
>      drm/amd/display: Add more Clock Sources to DCN2.1
>
>Tero Kristo (1):
>      MAINTAINERS: Update my email address and maintainer level status
>
>Thomas Gleixner (2):
>      rtc: mc146818: Dont test for bit 0-5 in Register D
>      Revert "lib: Restrict cpumask_local_spread to houskeeping CPUs"
>
>Thomas Meyer (2):
>      um: stdio_console: Make preferred console
>      um: kmsg_dumper: always dump when not tty console
>
>Thorsten Leemhuis (1):
>      nvme-pci: avoid the deepest sleep state on Kingston A2000 SSDs
>
>Tony Lindgren (5):
>      soc: ti: omap-prm: Fix boot time errors for rst_map_012 bits 0 and 1
>      ARM: OMAP2+: Fix suspcious RCU usage splats for omap_enter_idle_coup=
led
>      ARM: OMAP2+: Fix booting for am335x after moving to simple-pm-bus
>      drivers: bus: simple-pm-bus: Fix compatibility with simple-bus for a=
uxdata
>      ARM: dts: omap4-droid4: Fix lost keypad slide interrupts for droid4
>
>Ulf Hansson (1):
>      mmc: sdhci-pltfm: Fix linking err for sdhci-brcmstb
>
>Vadim Fedorenko (1):
>      net: ip_tunnel: fix mtu calculation
>
>Victor Lu (3):
>      drm/amd/display: Fix dc_sink kref count in emulated_link_detect
>      drm/amd/display: Free atomic state after drm_atomic_commit
>      drm/amd/display: Decrement refcount of dc_sink before reassignment
>
>Viktor Rosendahl (1):
>      tracing: Use pause-on-trace with the latency tracers
>
>Ville Syrj=C3=A4l=C3=A4 (3):
>      drm/i915: Skip vswing programming for TBT
>      drm/i915: Extract intel_ddi_power_up_lanes()
>      drm/i915: Power up combo PHY lanes for for HDMI as well
>
>Vincent Bernat (1):
>      docs: networking: swap words in icmp_errors_use_inbound_ifaddr doc
>
>Vincenzo Frascino (2):
>      kasan: add explicit preconditions to kasan_report()
>      kasan: make addr_has_metadata() return true for valid addresses
>
>Viresh Kumar (1):
>      mailmap: fix name/email for Viresh Kumar
>
>Vitaly Kuznetsov (1):
>      KVM: x86: Supplement __cr4_reserved_bits() with X86_FEATURE_PCID che=
ck
>
>Waiman Long (1):
>      mm/filemap: add missing mem_cgroup_uncharge() to
>__add_to_page_cache_locked()
>
>Wang ShaoBo (1):
>      kretprobe: Avoid re-registration of the same kretprobe earlier
>
>Wolfram Sang (1):
>      gpio: gpiolib: remove shadowed variable
>
>Xiaoguang Wang (1):
>      io_uring: don't modify identity's files uncess identity is cowed
>
>Xiaojian Du (1):
>      drm/amd/pm: fill in the data member of v2 gpu metrics table for vang=
ogh
>
>Xie He (1):
>      net: lapb: Copy the skb before sending a packet
>
>Yoshihiro Shimoda (1):
>      usb: renesas_usbhs: Clear pipe running flag in usbhs_pkt_pop()
>
>Yu Zhang (1):
>      KVM: Documentation: Fix documentation for nested.
>
>Zheng Zhan Liang (1):
>      KVM/x86: assign hva with the right value to vm_munmap the pages
>
>Zyta Szpak (1):
>      arm64: dts: ls1046a: fix dcfg address range
>
>chen gong (1):
>      drm/amdgpu/gfx10: update CGTS_TCC_DISABLE and
>CGTS_USER_TCC_DISABLE register offsets for VGH
>
>kernel test robot (1):
>      usb: gadget: aspeed: add missing of_node_put

--NS7fh8N4u3WhSjLC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmAgdxEACgkQsjqdtxFL
KRX1Xgf5Abigyr7r5UxzG50FTLsHRzrgiOPa/bNpq+nG1rJ6m8ECu0sbvudnoRYD
JCZ3jBBc5LcmjUbe31gNtiTKuxgU4EdH3AljYMEsk7J49hrX+PMnheTq6pnKKoj/
xnKJGavhly1u7MtP8VC2VDhHh5gzSfK8DB6YpaU39kdXMnSHrXJ1PS5GyjEGXXeR
9jRlCNzD2gnl0GnweRX/TW9vB+r7cFY6EnxKNUdeRuP8pFiPq0gIfDNNu8jl0wtd
vNW771QXz0ZScWO1oc+qTBsLvYnthc9UnjVA71Hh5KR4LKEpGjwJ70Tz9iVUc+Pk
uucD4wm+QEjqlv4rp2bmDinqI2YrVA==
=dnwm
-----END PGP SIGNATURE-----

--NS7fh8N4u3WhSjLC--
