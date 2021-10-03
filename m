Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1A0420411
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 23:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhJCV2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 17:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbhJCV2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 17:28:48 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42481C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 14:27:00 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g41so62950474lfv.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 14:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ixt3yCUBL4lbt+WvevOCpBnGpJiVBNaqpVA6SY8SdIA=;
        b=YRqzAHxcLEd3418MPVgmJ6SzAddnEUI6fwbvmCFMx3EnF7nbOJ+BqJbtK/w4JmhQQs
         HrAVzESaZ7RU3EA6Gw5LML3XKh8VWI+QoFhGJ8vhKtxl+iByKiB2mePudPty9+EEWGii
         gCWMgQ1lICoJPcmmgCelOTtT9Y1a0mmWyU430=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ixt3yCUBL4lbt+WvevOCpBnGpJiVBNaqpVA6SY8SdIA=;
        b=HYxBND3WJhmF/dj6RWltr7fEs3Wr6RJkfmDUerGcsceoTtyuVvvdGz2UuC3TJs3akj
         hTJiMSctDZBovACF+IX7RdWz40E4Jgod2czr4PIkJC4kfZaaRhox2xb1AvkEcrvfw6+r
         HigGtoQPJ4jB/K0rHSSFtK97c5YWqkRYbfbV5Brw7cwGXXhbIjx6hrkEgOkQJq4fKcCy
         Hf2AnvVQjnGSsDMhI+Y4dHeHu6eZT6qlBF2hX3FN4b2bFA8jd1+ef+8aGxL0LLh11n6m
         i56Q9d/cgE6Q6C35Xk4ZtTCJnXB+PMOmFm1f2XEOI1sRUhkI5glgeAHOj1FR/fwK34t/
         ncrQ==
X-Gm-Message-State: AOAM530zvk6HLenK45oWfjXyF7Lh1f49nFm8UfHtWoLlXkdQ5b1eBvYj
        zi4N3F4A/sAOX48HmoUu2bp+Y9YpdG60wpxr
X-Google-Smtp-Source: ABdhPJwmGZhoyY5zJUx06FJjke78Nr4xl4oVwPhlEyikoyCoiDOK6bAy/P+cE6+jctwITJGXtQUu2g==
X-Received: by 2002:a2e:b702:: with SMTP id j2mr11194610ljo.6.1633296417973;
        Sun, 03 Oct 2021 14:26:57 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id t21sm412829lft.201.2021.10.03.14.26.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Oct 2021 14:26:57 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id u18so63482565lfd.12
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 14:26:56 -0700 (PDT)
X-Received: by 2002:a05:651c:1250:: with SMTP id h16mr12349744ljh.68.1633296416404;
 Sun, 03 Oct 2021 14:26:56 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Oct 2021 14:26:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wifo=ocAVFtoutuLQvqYyNz1r014uJD8TRPJKpVaPLrRQ@mail.gmail.com>
Message-ID: <CAHk-=wifo=ocAVFtoutuLQvqYyNz1r014uJD8TRPJKpVaPLrRQ@mail.gmail.com>
Subject: Linux 5.15-rc4
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This release continues to look pretty normal after the initial
hiccups. At least going purely by number of commits, we're right smack
dab in the middle of the normal range for this time in the release
cycle, and the diffstat looks fairly normal too. A bit less
driver-heavy than usual, perhaps, but nothing big, and nothing that
makes me go "that's strange".

One thing standing out in the diffs might be the m68k 'set_fs()'
removal - not really a regression fix, but it has been pending for a
while, and it turned out that the problems attributed to it were due
to an entirely unrelated m68k signal handling issue. So with that
fixed, we could get rid of set_fs from another architecture. There's a
few more architectures I'd like to see it removed from, but all the
actively maintained ones have already removed it, so on the whole
set_fs really is a thing of the past, only used by legacy
architectures.

Anyway, about a third of the diff is drivers (net, sound, rdma, gpu),
with the rest being a mix of arch updates (the m68k set_fs stuff and
some kvm patches), tooling (mostly selftest updates), filesystem code
and core networking.

The appended shortlog gives you more details, but if you really want
to dig into it, go for the git tree.

Go test,
            Linus

---

Aaro Koskinen (1):
      smsc95xx: fix stalled rx after link change

Akira Yokosawa (1):
      drm/i915/guc, docs: Fix pdfdocs build error by removing nested grid

Al Viro (3):
      m68k: Handle arrivals of multiple signals correctly
      m68k: Update ->thread.esp0 before calling syscall_trace() in
ret_from_signal
      m68k: Leave stack mangling to asm wrapper of sigreturn()

Alexander Wetzel (1):
      mac80211: Fix Ptk0 rekey documentation

Alexey Dobriyan (1):
      ALSA: pcxhr: "fix" PCXHR_REG_TO_PORT definition

Anand K Mistry (1):
      perf/x86: Reset destroy callback on event init failure

Andrea Claudi (1):
      ipvs: check that ip_vs_conn_tab_bits is between 8 and 20

Andrej Shadura (1):
      HID: u2fzero: ignore incomplete packets without data

Andrew Lunn (3):
      dsa: mv88e6xxx: 6161: Use chip wide MAX MTU
      dsa: mv88e6xxx: Fix MTU definition
      dsa: mv88e6xxx: Include tagger overhead when setting MTU for DSA
and CPU ports

Andrey Gusakov (1):
      gpio: pca953x: do not ignore i2c errors

Arnaud Pouliquen (1):
      MAINTAINERS: fix update references to stm32 audio bindings

Arnd Bergmann (3):
      net: ks8851: fix link error
      dmascc: add CONFIG_VIRT_TO_BUS dependency
      net: hns3: fix hclge_dbg_dump_tm_pg() stack usage

Arun Easi (1):
      scsi: qla2xxx: Fix excessive messages during device logout

Bartosz Golaszewski (1):
      MAINTAINERS: update my email address

Basavaraj Natikar (3):
      pinctrl: amd: Add irq field data
      pinctrl: amd: Handle wake-up interrupt
      HID: amd_sfh: Fix potential NULL pointer dereference

Bjorn Helgaas (1):
      iommu/vt-d: Drop "0x" prefix from PCI bus & device addresses

Brandon Wyman (1):
      hwmon: (pmbus/ibm-cffps) max_power_out swap changes

Cai Huoqing (2):
      drm/exynos: Make use of the helper function
devm_platform_ioremap_resource()
      net: mdio-ipq4019: Fix the error for an optional regs resource

Cameron Berkenpas (1):
      ALSA: hda/realtek: Quirks to enable speaker output for Lenovo
Legion 7i 15IMHG05, Yoga 7i 14ITL5/15ITL5, and 13s Gen2 laptops.

Charlene Liu (1):
      drm/amd/display: Pass PCI deviceid into DC

Chen Jingwen (1):
      elf: don't use MAP_FIXED_NOREPLACE for elf interpreter mappings

Chenyi Qiang (1):
      KVM: nVMX: Fix nested bus lock VM exit

Chih-Kang Chang (1):
      mac80211: Fix ieee80211_amsdu_aggregate frag_tail bug

Christoph Hellwig (7):
      m68k: Document that access_ok is broken for !CONFIG_CPU_HAS_ADDRESS_S=
PACES
      m68k: Remove the 030 case in virt_to_phys_slow
      m68k: Use BUILD_BUG for passing invalid sizes to get_user/put_user
      m68k: Factor the 8-byte lowlevel {get,put}_user code into helpers
      m68k: Provide __{get,put}_kernel_nofault
      m68k: Remove set_fs()
      nvdimm/pmem: fix creating the dax group

Christoph Lameter (1):
      IB/cma: Do not send IGMP leaves for sendonly Multicast groups

Colin Ian King (4):
      vfio/pci: add missing identifier name in argument of function prototy=
pe
      net: hns: Fix spelling mistake "maped" -> "mapped"
      perf vendor events powerpc: Fix spelling mistake "icach" -> "icache"
      scsi: virtio_scsi: Fix spelling mistake "Unsupport" -> "Unsupported"

Dan Carpenter (4):
      vduse: missing error code in vduse_init()
      vdpa: potential uninitialized return in vhost_vdpa_va_map()
      crypto: ccp - fix resource leaks in ccp_run_aes_gcm_cmd()
      ksmbd: missing check for NULL in convert_to_nt_pathname()

Daniel Borkmann (2):
      bpf, cgroup: Assign cgroup in cgroup_sk_alloc when called from interr=
upt
      bpf, test, cgroup: Use sk_{alloc,free} for test cases

Daniele Palmas (1):
      drivers: net: mhi: fix error path in mhi_net_newlink

Dave Marchevsky (1):
      MAINTAINERS: Add btf headers to BPF

Dave Wysochanski (1):
      cachefiles: Fix oops in trace_cachefiles_mark_buried due to NULL obje=
ct

David Collins (1):
      pinctrl: qcom: spmi-gpio: correct parent irqspec translation

David Matlack (3):
      KVM: selftests: Change backing_src flag to -s in demand_paging_test
      KVM: selftests: Refactor help message for -s backing_src
      KVM: selftests: Create a separate dirty bitmap per slot

Davide Caratti (1):
      mptcp: allow changing the 'backup' bit when no sockets are open

Desnes A. Nunes do Rosario (1):
      Revert "ibmvnic: check failover_pending in login response"

Dmitry Osipenko (3):
      drm/tegra: dc: Remove unused variables
      drm/tegra: uapi: Fix wrong mapping end address in case of disabled IO=
MMU
      gpu/host1x: fence: Make spinlock static

Eddie James (1):
      hwmon: (occ) Fix P10 VRM temp sensors

Eli Cohen (2):
      vdpa/mlx5: Clear ready indication for control VQ
      vdpa/mlx5: Avoid executing set_vq_ready() if device is reset

Enzo Matsumiya (1):
      ksmbd: fix documentation for 2 functions

Eric Biggers (1):
      fs-verity: fix signed integer overflow with i_size near S64_MAX

Eric Dumazet (3):
      netfilter: conntrack: serialize hash resizes and cleanups
      net: udp: annotate data race around udp_sk(sk)->corkflag
      af_unix: fix races in sk_peer_pid and sk_peer_cred accesses

Eric Whitney (2):
      ext4: remove extent cache entries when truncating inline data
      ext4: enforce buffer head state assertion in ext4_da_map_blocks

Evgeny Novikov (1):
      HID: amd_sfh: Fix potential NULL pointer dereference

F.A.Sulaiman (1):
      HID: betop: fix slab-out-of-bounds Write in betop_probe

Fares Mehanna (1):
      kvm: x86: Add AMD PMU MSRs to msrs_to_save_all[]

Felix Fietkau (1):
      Revert "mac80211: do not use low data rates for data frames with
no ack flag"

Feng Zhou (1):
      ixgbe: Fix NULL pointer dereference in ixgbe_xdp_setup

Florian Fainelli (1):
      net: phy: bcm7xxx: Fixed indirect MMD operations

Florian Westphal (11):
      netfilter: conntrack: make max chain length random
      netfilter: conntrack: include zone id in tuple hash again
      netfilter: nat: include zone id in nat table hash again
      selftests: netfilter: add selftest for directional zone support
      selftests: netfilter: add zone stress test with colliding tuples
      netfilter: nf_tables: unlink table before deleting it
      netfilter: nf_nat_masquerade: make async masq_inet6_event handling ge=
neric
      netfilter: nf_nat_masquerade: defer conntrack walk to work queue
      netfilter: iptable_raw: drop bogus net_init annotation
      netfilter: log: work around missing softdep backend module
      mptcp: don't return sockets in foreign netns

Guangbin Huang (3):
      net: hns3: PF enable promisc for VF when mac table is overflow
      net: hns3: fix always enable rx vlan filter problem after selftest
      net: hns3: disable firmware compatible features when uninstall PF

Guo Zhi (1):
      RDMA/hfi1: Fix kernel pointer leak

Haimin Zhang (1):
      KVM: x86: Handle SRCU initialization failure during page track init

Hawking Zhang (1):
      drm/amdgpu: correct initial cp_hqd_quantum for gfx9

Heiko Stuebner (2):
      pinctrl/rockchip: add a queue for deferred pin output settings on pro=
be
      gpio/rockchip: fetch deferred output settings on probe

Horatiu Vultur (1):
      net: mdio: mscc-miim: Fix the mdio controller

Hou Tao (3):
      bpf: Handle return value of BPF_PROG_TYPE_STRUCT_OPS prog
      kernfs: also call kernfs_set_rev() for positive dentry
      ext4: limit the number of blocks in one ADD_RANGE TLV

Hou Wenlong (1):
      kvm: fix wrong exception emulation in check_rdtsc

Hugh Dickins (1):
      drm/i915: fix blank screen booting crashes

Hyunchul Lee (1):
      ksmbd: add buffer validation for SMB2_CREATE_CONTEXT

Ian Rogers (2):
      perf test: Fix DWARF unwind for optimized builds.
      perf arm: Fix off-by-one directory paths.

Jackie Liu (1):
      watchdog/sb_watchdog: fix compilation problem due to COMPILE_TEST

Jacob Keller (2):
      e100: fix length calculation in e100_get_regs_len
      e100: fix buffer overrun in e100_get_regs

Jakub Kicinski (1):
      net: dev_addr_list: handle first address in __hw_addr_add_ex

James Clark (1):
      perf tests: Fix flaky test 'Object code reading'

Jaroslav Kysela (1):
      ALSA: rawmidi: introduce SNDRV_RAWMIDI_IOCTL_USER_PVERSION

Jason Gunthorpe (5):
      IB/qib: Fix clang confusion of NULL pointer comparison
      RDMA/cma: Do not change route.addr.src_addr.ss_family
      RDMA/cma: Ensure rdma_addr_cancel() happens before issuing more reque=
sts
      RDMA/hns: Work around broken constant propagation in gcc 8
      vfio/ap_ops: Add missed vfio_uninit_group_dev()

Jeffle Xu (1):
      ext4: fix reserved space counter leakage

Jens Axboe (2):
      io-wq: exclusively gate signal based exit on get_signal() return
      Revert "block, bfq: honor already-setup queue merges"

Jeremy Sowden (1):
      netfilter: ip6_tables: zero-initialize fragment offset

Jernej Skrabec (1):
      media: hantro: Fix check for single irq

Jia He (1):
      ACPI: NFIT: Use fallback node id when numa info in NFIT table is inco=
rrect

Jian Shen (5):
      net: hns3: do not allow call hns3_nic_net_open repeatedly
      net: hns3: remove tc enable checking
      net: hns3: don't rollback when destroy mqprio fail
      net: hns3: fix mixed flag HCLGE_FLAG_MQPRIO_ENABLE and
HCLGE_FLAG_DCB_ENABLE
      net: hns3: fix show wrong state when add existing uc mac address

Jiapeng Chong (1):
      scsi: ses: Fix unsigned comparison with less than zero

Jiri Benc (2):
      selftests, bpf: Fix makefile dependencies on libbpf
      selftests, bpf: test_lwt_ip_encap: Really disable rp_filter

Johan Almbladh (1):
      bpf, x86: Fix bpf mapping of atomic fetch implementation

Johan Hovold (5):
      ipack: ipoctal: fix stack information leak
      ipack: ipoctal: fix tty registration race
      ipack: ipoctal: fix tty-registration error handling
      ipack: ipoctal: fix missing allocation-failure check
      ipack: ipoctal: fix module reference leak

Johannes Berg (3):
      mac80211: mesh: fix potentially unaligned access
      mac80211-hwsim: fix late beacon hrtimer handling
      mac80211: fix use-after-free in CCMP/GCMP RX

Jonathan Hsu (1):
      scsi: ufs: Fix illegal offset in UPIU event trace

Josh Poimboeuf (1):
      crypto: x86/sm4 - Fix frame pointer stack corruption

Joshua-Dickens (1):
      HID: wacom: Add new Intuos BT (CTL-4100WL/CTL-6100WL) device IDs

Josip Pavic (1):
      drm/amd/display: initialize backlight_ramping_override to false

Jozsef Kadlecsik (1):
      netfilter: ipset: Fix oversized kvmalloc() calls

Kan Liang (1):
      perf/x86/intel: Update event constraints for ICX

Keith Busch (1):
      nvme: add command id quirk for apple controllers

Kumar Kartikeya Dwivedi (1):
      libbpf: Fix segfault in static linker for objects without BTF

Kuniyuki Iwashima (1):
      af_unix: Return errno instead of NULL in unix_create1().

Lai Jiangshan (3):
      KVM: X86: Fix missed remote tlb flush in rmap_write_protect()
      KVM: X86: Synchronize the shadow pagetable before link it
      KVM: Remove tlbs_dirty

Leon Romanovsky (1):
      RDMA/usnic: Lock VF with mutex instead of spinlock

Leslie Shi (1):
      drm/amdgpu: fix gart.bo pin_count leak

Like Xu (4):
      perf doc: Fix typos all over the place
      perf config: Refine error message to eliminate confusion
      perf iostat: Use system-wide mode if the target cpu_list is unspecifi=
ed
      perf iostat: Fix Segmentation fault from NULL 'struct
perf_counts_values *'

Linus Torvalds (4):
      vboxfs: fix broken legacy mount signature checking
      kvm: fix objtool relocation warning
      objtool: print out the symbol type when complaining about it
      Linux 5.15-rc4

Lorenz Bauer (1):
      bpf: Exempt CAP_BPF from checks against bpf_jit_limit

Lorenzo Bianconi (1):
      mac80211: limit injected vht mcs/nss in ieee80211_parse_tx_radiotap

Marc Herbert (1):
      ASoC: SOF: loader: release_firmware() on load failure to avoid batchi=
ng

Marc Zyngier (1):
      KVM: arm64: Fix PMU probe ordering

Matthew Auld (1):
      drm/i915/request: fix early tracepoints

Matthew Hagan (1):
      net: bgmac-platform: handle mac-address deferral

Maxim Levitsky (11):
      KVM: x86: nSVM: restore the L1 host state prior to resuming
nested guest on SMM exit
      KVM: x86: reset pdptrs_from_userspace when exiting smm
      KVM: x86: SVM: call KVM_REQ_GET_NESTED_STATE_PAGES on exit from SMM m=
ode
      KVM: x86: nSVM: refactor svm_leave_smm and smm_enter_smm
      KVM: x86: VMX: synthesize invalid VM exit when emulating invalid
guest state
      KVM: x86: nVMX: don't fail nested VM entry on invalid guest
state if !from_vmentry
      KVM: x86: nVMX: re-evaluate emulation_required on nested VM exit
      KVM: x86: nSVM: restore int_vector in svm_clear_vintr
      KVM: x86: selftests: test simultaneous uses of V_IRQ from L1 and L0
      KVM: x86: nSVM: test eax for 4K alignment for GP errata workaround
      KVM: x86: nSVM: don't copy virt_ext from vmcb12

Mel Gorman (1):
      sched/fair: Null terminate buffer when updating tunable_scaling

Michael S. Tsirkin (1):
      virtio: don't fail on !of_device_is_compatible

Michal Koutn=C3=BD (1):
      sched/fair: Add ancestors of unthrottled undecayed cfs_rq

Michal Simek (1):
      pinctrl: core: Remove duplicated word from devm_pinctrl_unregister()

MichelleJin (1):
      mac80211: check return value of rhashtable_init

Mingwei Zhang (1):
      KVM: SVM: fix missing sev_decommission in sev_receive_start

Mizuho Mori (1):
      HID: apple: Fix logical maximum and usage maximum of Magic Keyboard J=
IS

Mun Yew Tham (1):
      MAINTAINERS: Update Mun Yew Tham as Altera Pio Driver maintainer

Nadezda Lutovinova (3):
      hwmon: (w83791d) Fix NULL pointer dereference by removing
unnecessary structure field
      hwmon: (w83792d) Fix NULL pointer dereference by removing
unnecessary structure field
      hwmon: (w83793) Fix NULL pointer dereference by removing
unnecessary structure field

Namjae Jeon (7):
      ksmbd: fix invalid request buffer access in compound
      MAINTAINERS: rename cifs_common to smbfs_common in cifs and ksmbd ent=
ry
      ksmbd: remove NTLMv1 authentication
      ksmbd: use correct basic info level in set_file_basic_info()
      ksmbd: add request buffer validation in smb2_set_info
      ksmbd: add validation in smb2 negotiate
      ksmbd: fix transform header validation

Nick Desaulniers (1):
      nbd: use shifts rather than multiplies

Nicolas Dufresne (1):
      media: cedrus: Fix SUNXI tile size calculation

Nirmoy Das (1):
      debugfs: debugfs_create_file_size(): use IS_ERR to check for error

Oliver Upton (5):
      selftests: KVM: Fix check for !POLLIN in demand_paging_test
      selftests: KVM: Align SMCCC call with the spec in steal_time
      selftests: KVM: Call ucall_init when setting up in rseq_test
      selftests: KVM: Explicitly use movq to read xmm registers
      selftests: KVM: Don't clobber XMM register when read

Pablo Neira Ayuso (1):
      netfilter: nf_tables: Fix oversized kvmalloc() calls

Paolo Abeni (1):
      net: introduce and use lock_sock_fast_nested()

Paul Fertser (3):
      hwmon: (tmp421) handle I2C errors
      hwmon: (tmp421) report /PVLD condition as fault
      hwmon: (tmp421) fix rounding for negative values

Pavel Begunkov (1):
      io_uring: kill fasync

Peter Gonda (3):
      KVM: SEV: Acquire vcpu mutex when updating VMSA
      KVM: SEV: Update svm_vm_copy_asid_from for SEV-ES
      KVM: SEV: Allow some commands for mirror VM

Peter Ujfalusi (4):
      ASoC: SOF: imx: imx8: Bar index is only valid for IRAM and SRAM types
      ASoC: SOF: imx: imx8m: Bar index is only valid for IRAM and SRAM type=
s
      ASoC: SOF: loader: Re-phrase the missing firmware error to avoid
duplication
      ASoC: SOF: trace: Omit error print when waking up trace sleepers

Peter Zijlstra (2):
      objtool: Teach get_alt_entry() about more relocation types
      sched: Always inline is_percpu_thread()

Pierre-Louis Bossart (1):
      ASoC: Intel: sof_sdw: tag SoundWire BEs as non-atomic

Piotr Krysiuk (1):
      bpf, mips: Validate conditional branch offsets

Praful Swarnakar (1):
      drm/amd/display: Fix Display Flicker on embedded panels

Prike Liang (1):
      drm/amdgpu: force exit gfxoff on sdma resume for rmb s0ix

Rafael J. Wysocki (1):
      thermal: Update information in MAINTAINERS

Rahul Lakkireddy (1):
      scsi: csiostor: Add module softdep on cxgb4

Rajendra Nayak (1):
      pinctrl: qcom: sc7280: Add PM suspend callbacks

Randy Dunlap (4):
      media: s5p-jpeg: rename JPEG marker constants to prevent build warnin=
gs
      NIOS2: fix kconfig unmet dependency warning for SERIAL_CORE_CONSOLE
      NIOS2: setup.c: drop unused variable 'dram_start'
      net: sun: SUNVNET_COMMON should depend on INET

Ritesh Harjani (1):
      ext4: fix loff_t overflow in ext4_max_bitmap_size()

Ronnie Sahlberg (1):
      ksmbd: remove RFC1002 check in smb2 request

Saravana Kannan (6):
      driver core: fw_devlink: Improve handling of cyclic dependencies
      driver core: fw_devlink: Add support for
FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD
      net: mdiobus: Set FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD for mdiobus pa=
rents
      driver core: Set deferred probe reason when deferred by driver core
      driver core: Create __fwnode_link_del() helper function
      driver core: Add debug logs when fwnode links are added/deleted

Sean Christopherson (10):
      KVM: x86: Mark all registers as avail/dirty at vCPU creation
      KVM: x86: Clear KVM's cached guest CR3 at RESET/INIT
      KVM: VMX: Remove defunct "nr_active_uret_msrs" field
      KVM: SEV: Pin guest memory for write for RECEIVE_UPDATE_DATA
      KVM: x86: Query vcpu->vcpu_idx directly and drop its accessor
      KVM: x86: Identify vCPU0 by its vcpu_idx instead of its vCPUs array e=
ntry
      KVM: Clean up benign vcpu->cpu data races when kicking vCPUs
      KVM: KVM: Use cpumask_available() to check for NULL cpumask when
kicking vCPUs
      KVM: x86: Swap order of CPUID entry "index" vs. "significant flag" ch=
ecks
      KVM: selftests: Ensure all migrations are performed when test is affi=
ned

Sean Young (1):
      media: ir_toy: prevent device from hanging during transmit

Selvin Xavier (1):
      MAINTAINERS: Update Broadcom RDMA maintainers

Sergey Senozhatsky (1):
      KVM: do not shrink halt_poll_ns below grow_start

Shannon Nelson (1):
      ionic: fix gathering of debug stats

Shawn Guo (4):
      interconnect: qcom: sdm660: Fix id of slv_cnoc_mnoc_cfg
      interconnect: qcom: sdm660: Correct NOC_QOS_PRIORITY shift and mask
      dt-bindings: interconnect: sdm660: Add missing a2noc qos clocks
      interconnect: qcom: sdm660: Add missing a2noc qos clocks

Shengjiu Wang (5):
      ASoC: fsl_sai: register platform component before registering cpu dai
      ASoC: fsl_esai: register platform component before registering cpu da=
i
      ASoC: fsl_micfil: register platform component before registering cpu =
dai
      ASoC: fsl_spdif: register platform component before registering cpu d=
ai
      ASoC: fsl_xcvr: register platform component before registering cpu da=
i

Simon Ser (1):
      drm/amdgpu: check tiling flags when creating FB on GFX8-

Sindhu Devale (4):
      RDMA/irdma: Skip CQP ring during a reset
      RDMA/irdma: Validate number of CQ entries on create CQ
      RDMA/irdma: Report correct WC error when transport retry counter
is exceeded
      RDMA/irdma: Report correct WC error when there are MW bind errors

Song Liu (1):
      perf/core: fix userpage->time_enabled of inactive events

Stefan Binding (1):
      ALSA: hda/cs8409: Setup Dolphin Headset Mic as Phantom Jack

Sven Peter (2):
      iommu/dart: Remove iommu_flush_ops
      iommu/dart: Clear sid2group entry when a group is freed

Takashi Iwai (2):
      Revert "ALSA: hda: Drop workaround for a hang at shutdown again"
      ALSA: usb-audio: Unify mixer resume and reset_resume procedure

Takashi Sakamoto (2):
      ALSA: oxfw: fix transmission method for Loud models based on OXFW971
      ALSA: firewire-motu: fix truncated bytes in message tracepoints

Tao Liu (1):
      RDMA/cma: Fix listener leak in rdma_cma_listen_on_all() failure

Tejas Upadhyay (1):
      drm/i915: Remove warning from the rps worker

Theodore Ts'o (1):
      ext4: add error checking to ext4_ext_replay_set_iblocks()

Thierry Reding (1):
      gpu: host1x: Plug potential memory leak

Thomas Gleixner (2):
      ALSA: pcsp: Make hrtimer forwarding more robust
      net: bridge: mcast: Associate the seqcount with its protecting lock.

Tobias Klauser (1):
      cpumask: Omit terminating null byte in cpumap_print_{list,bitmask}_to=
_buf

Trevor Wu (3):
      ASoC: mediatek: add required config dependency
      ASoC: mediatek: common: handle NULL case in suspend/resume function
      ASoC: mediatek: mt8195: remove wrong fixup assignment on HDMITX

Uwe Kleine-K=C3=B6nig (1):
      hwmon: (ltc2947) Properly handle errors when looking for the
external clock

Vadim Pasternak (2):
      hwmon: (mlxreg-fan) Return non-zero value when fan current state
is enforced from sysfs
      hwmon: (pmbus/mp2975) Add missed POUT attribute for page 1
mp2975 controller

Vincent Whitchurch (1):
      mmc: dw_mmc: Only inject fault before done/error

Vineeth Vijayan (1):
      s390/cio: avoid excessive path-verification requests

Vitaly Kuznetsov (2):
      KVM: x86: Fix stack-out-of-bounds memory access from
ioapic_write_indirect()
      KVM: nVMX: Filter out all unsupported controls when eVMCS was activat=
ed

Vlad Buslov (1):
      net: sched: flower: protect fl_walk() with rcu

Vladimir Oltean (1):
      net: enetc: fix the incorrect clearing of IF_MODE bits

Wenpeng Liang (2):
      RDMA/hns: Fix the size setting error when copying CQE in clean_cq()
      RDMA/hns: Add the check of the CQE size of the user space

Wolfram Sang (1):
      mmc: renesas_sdhi: fix regression with hard reset on old SDHIs

Wong Vee Khee (1):
      net: stmmac: fix EEE init issue when paired with EEE capable PHYs

Xiao Liang (1):
      net: ipv4: Fix rtnexthop len when RTA_FLOW is present

Xie Yongji (1):
      vduse: Cleanup the old kernel states after reset failure

Xin Long (1):
      sctp: break out if skb_header_pointer returns NULL in sctp_rcv_ootb

Xu Liang (1):
      net: phy: enhance GPY115 loopback disable function

Yanfei Xu (1):
      net: mdiobus: Fix memory leak in __mdiobus_register

Yong Zhi (1):
      ASoC: SOF: Fix DSP oops stack dump output contents

Yu Zhang (1):
      KVM: nVMX: fix comments of handle_vmon()

YueHaibing (1):
      mac80211: Drop frames from invalid MAC address in ad-hoc mode

Zelin Deng (2):
      x86/kvmclock: Move this_cpu_pvti into kvmclock.h
      ptp: Fix ptp_kvm_getcrosststamp issue for x86 ptp_kvm

Zenghui Yu (1):
      KVM: arm64: nvhe: Fix missing FORCE for hyp-reloc.S build rule

Zhang Yi (5):
      ext4: check and update i_disksize properly
      ext4: correct the error path of ext4_write_inline_data_end()
      ext4: factor out write end code of inline file
      ext4: drop unnecessary journal handle in delalloc write
      ext4: recheck buffer uptodate bit under buffer lock

Zhenzhong Duan (1):
      KVM: VMX: Fix a TSX_CTRL_CPUID_CLEAR field mask issue

Zhi A Wang (1):
      drm/i915/gvt: fix the usage of ww lock in gvt scheduler.

suma hegde (1):
      hwmon: (k10temp) Remove residues of current and voltage

yangerkun (2):
      ext4: flush s_error_work before journal destroy in ext4_fill_super
      ext4: fix potential infinite loop in ext4_dx_readdir()

=E7=8E=8B=E8=B4=87 (1):
      net: prevent user from passing illegal stab size
