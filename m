Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24CD353A04
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 23:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhDDVb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 17:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhDDVbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 17:31:24 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BCFC061756
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 14:31:17 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g8so14805821lfv.12
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 14:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=J6WryfSN7Ui4wvMozfRLRCl+DC72eZj5FR5Xwj0NILo=;
        b=BRVazSjVRTwtggtBih5UyGPr2oFO8uF8j77WigX7RPfdpMK/3sHH8WsEIPgoyJgX8W
         /K9cfg0QmtofpcX9XzV/7XEmcioglJ5GuqWUpl6NNUy82FryyHgUfvXN1HOC7JbXV1wD
         RVfOamvxz/Yg3gEULBbf49MCsqCXjRREn1esA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=J6WryfSN7Ui4wvMozfRLRCl+DC72eZj5FR5Xwj0NILo=;
        b=ALwqPknKv+ziuXaMkuqqt+8+1tcOWzWPHGAW7AW7PSB9hC5x8zfNk3jnQQvWe67DFZ
         w6gyHRZsel4uOxXfEmY1fHEhab8ohDdi7t9Zk2LUnoSdcxwV9ZQQt9bzM6dctPyx5IOl
         XJzjMuiLiB6VCO1LcMf5vRfuYS/xXUfR/w1qk5xO2VpTWmbei+qhCUriBdTi6e8W+D3f
         PHpfu+YkJR2oXL/2VNtI/dbL1uqx+aKghq1LmyNo3VvjJUJ51qlruZj+oNmhbpdPKTyW
         LTu+k88pVc9Fh+zOSQTo/S2lfCNbMZrqGwY7XaWocVJfFagP4gQgKXCg8cFOhSTpa6aL
         hoGw==
X-Gm-Message-State: AOAM531g/GYywnVBuyhdawjipjxOsHU0PKo1GHsPEU4WqU2lOlIQcOq3
        LT27hloBNb+ri/HL+vshlbWk0ReJ3A2FteIs
X-Google-Smtp-Source: ABdhPJzI9A+ojjNpIq4cawT7Wbmok0tPfFnVUtYUTNN/CLnJpSal5lP1/4hu8IMR/GnqfcT25njFMg==
X-Received: by 2002:a19:818f:: with SMTP id c137mr15050784lfd.245.1617571875441;
        Sun, 04 Apr 2021 14:31:15 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id p8sm1564379lfr.303.2021.04.04.14.31.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Apr 2021 14:31:15 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id v15so14855583lfq.5
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 14:31:14 -0700 (PDT)
X-Received: by 2002:a05:6512:308b:: with SMTP id z11mr15191011lfd.487.1617571874572;
 Sun, 04 Apr 2021 14:31:14 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Apr 2021 14:30:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=whK9=wafv+cSLCGqFGPBbgp67Dut3jKCnWB--8y7Lxonw@mail.gmail.com>
Message-ID: <CAHk-=whK9=wafv+cSLCGqFGPBbgp67Dut3jKCnWB--8y7Lxonw@mail.gmail.com>
Subject: Linux 5.12-rc6
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Well, if rc5 was bigger than usual, and I worried about what that
meant for this release, rc6 is positively tiny.

So I think it was just due to the usual random timing fluctuations,
probably mainly networking updates (which were in rc5, but not in
rc6). Which means that unless things change in the next two weeks, the
schedule for this release is going to be the usual one.

Most of the changes here are drivers (gpu and usb stand out, that's
not because of any huge changes, it's mainly because everything else
is even smaller) and some arch updates (mainly x86 kvm, but some
arm64, powerpc, s390, xtensa and RISC-V too).

The rest is random other stuff (with io_uring showing up again, but
much smaller this time).

The shortlog is appended - small and easy to scan if you care about the det=
ails.

So hey, in between all those extra helpings of memma - it is Easter,
after all - go ahead and do some more testing as we approach the final
weeks of the release,

               Linus

---

Adrian Hunter (2):
      PM: runtime: Fix ordering in pm_runtime_get_suppliers()
      PM: runtime: Fix race getting/putting suppliers at probe

Ahmad Fatoum (1):
      driver core: clear deferred probe reason on probe retry

Alex Deucher (1):
      drm/amdgpu/vangogh: don't check for dpm in is_dpm_running when in sus=
pend

Andrew Price (1):
      gfs2: Flag a withdraw if init_threads() fails

Andy Shevchenko (2):
      pinctrl: intel: Show the GPIO base calculation explicitly
      usb: dwc3: pci: Enable dis_uX_susphy_quirk for Intel Merrifield

Aneesh Kumar K.V (1):
      powerpc/mm/book3s64: Use the correct storage key value when
calling H_PROTECT

Arnd Bergmann (2):
      drm/imx: imx-ldb: fix out of bounds array access warning
      pinctrl: qcom: fix unintentional string concatenation

Artur Petrosyan (2):
      usb: dwc2: Fix HPRT0.PrtSusp bit setting for HiKey 960 board.
      usb: dwc2: Prevent core suspend when port connection flag is 0

Atul Gopinathan (2):
      staging: rtl8192e: Fix incorrect source in memcpy()
      staging: rtl8192e: Change state information from u16 to u8

Ben Dooks (1):
      riscv: evaluate put_user() arg before enabling user access

Benjamin Li (1):
      interconnect: qcom: msm8939: remove rpm-ids from non-RPM nodes

Bob Peterson (1):
      gfs2: report "already frozen/thawed" errors

Christoph Hellwig (2):
      block: update a few comments in uapi/linux/blkpg.h
      block: remove the unused RQF_ALLOCED flag

Chunfeng Yun (1):
      usb: xhci-mtk: fix broken streams issue on 0.96 xHCI

Damien Le Moal (1):
      null_blk: fix command timeout completion handling

Daniel Jordan (1):
      vfio/type1: Empty batch for pfnmap pages

Dinghao Liu (1):
      extcon: Fix error handling in extcon_dev_register

Dmitry Osipenko (1):
      drm/tegra: dc: Don't set PLL clock to 0Hz

Dongli Zhang (1):
      KVM: x86: remove unused declaration of kvm_write_tsc()

Du Cheng (1):
      drivers: video: fbcon: fix NULL dereference in fbcon_cursor()

Evan Quan (1):
      drm/amd/pm: no need to force MCLK to highest when no display connecte=
d

Geert Uytterhoeven (1):
      cpufreq: Fix scaling_{available,boost}_frequencies_show() comments

Georgi Djakov (1):
      interconnect: Fix kerneldoc warning

Gulam Mohamed (1):
      scsi: iscsi: Fix race condition between login and sync thread

Haiwei Li (1):
      KVM: clean up the unused argument

Hans de Goede (1):
      ACPI: scan: Fix _STA getting called on devices with unmet dependencie=
s

Heiko Carstens (3):
      s390/vdso: copy tod_steering_delta value to vdso_data page
      s390/vdso: fix tod_steering_delta type
      s390/vdso: fix initializing and updating of vdso_data

Huacai Chen (1):
      drm/amdgpu: Set a suitable dev_info.gart_page_size

Hui Wang (2):
      ALSA: hda/realtek: fix a determine_headset_type issue for a Dell AIO
      ALSA: hda/realtek: call alc_update_headset_mode() in hp_automute_hook

Ikjoon Jang (1):
      ALSA: usb-audio: Apply sample rate quirk to Logitech Connect

Ilya Lipnitskiy (1):
      mm: fix race by making init_zero_pfn() early_initcall

Jan Beulich (1):
      xen-blkback: don't leak persistent grants from xen_blkbk_map()

Jason Gunthorpe (1):
      vfio/nvlink: Add missing SPAPR_TCE_IOMMU depends

Jens Axboe (5):
      tomoyo: don't special case PF_IO_WORKER for PF_KTHREAD
      io_uring: drop sqd lock before handling signals for SQPOLL
      io_uring: don't mark S_ISBLK async work as unbounded
      io_uring: move reissue into regular IO path
      io_uring: fix !CONFIG_BLOCK compilation failure

Jeremy Szu (1):
      ALSA: hda/realtek: fix mute/micmute LEDs for HP 640 G8

Jia-Ju Bai (1):
      interconnect: core: fix error return code of icc_link_destroy()

Johan Hovold (8):
      USB: cdc-acm: fix double free on probe failure
      USB: cdc-acm: fix use-after-free after probe failure
      USB: cdc-acm: drop redundant driver-data assignment
      USB: cdc-acm: drop redundant driver-data reset
      USB: cdc-acm: clean up probe error labels
      USB: cdc-acm: use negation for NULL checks
      USB: cdc-acm: always claim data interface
      USB: cdc-acm: do not log successful probe on later errors

Jonathan Marek (1):
      pinctrl: qcom: lpass lpi: use default pullup/strength values

Kefeng Wang (2):
      riscv: Drop const annotation for sp
      riscv: Make NUMA depend on MMU

Krzysztof Kozlowski (1):
      extcon: Add stubs for extcon_register_notifier_all() functions

Lars Povlsen (1):
      pinctrl: microchip-sgpio: Fix wrong register offset for IRQ trigger

Linus Torvalds (1):
      Linux 5.12-rc6

Liu Ying (1):
      drm/imx: imx-ldb: Register LDB channel1 when it is the only
channel to be used

Lv Yunlong (1):
      video: hyperv_fb: Fix a double free in hvfb_probe

Marc Zyngier (1):
      KVM: arm64: Fix CPU interface MMIO compatibility detection

Matthew Rosato (1):
      MAINTAINERS: add backups for s390 vfio drivers

Matthew Wilcox (Oracle) (8):
      XArray: Fix split documentation
      XArray: Fix splitting to non-zero orders
      XArray: Add xa_limit_16b
      radix tree test suite: Fix compilation
      radix tree test suite: Register the main thread with the RCU library
      idr test suite: Take RCU read lock in idr_find_test_1
      idr test suite: Create anchor before launching throbber
      idr test suite: Improve reporting from idr_find_test_1

Mauri Sandberg (1):
      MIPS: kernel: setup.c: fix compilation error

Max Filippov (2):
      xtensa: move coprocessor_flush to the .text section
      xtensa: fix uaccess-related livelock in do_page_fault

Mikko Perttunen (1):
      gpu: host1x: Use different lock classes for each client

Nathan Lynch (2):
      powerpc/pseries/mobility: use struct for shared state
      powerpc/pseries/mobility: handle premature return from H_JOIN

Nirmoy Das (1):
      drm/amdgpu: fix offset calculation in amdgpu_vm_bo_clear_mappings()

Oliver Neukum (3):
      cdc-acm: fix BREAK rx code path adding necessary calls
      USB: cdc-acm: untangle a circular dependency between callback and sof=
tint
      USB: cdc-acm: downgrade message to debug

Pan Bian (1):
      drm/imx: fix memory leak when fails to init

Paolo Bonzini (4):
      KVM: SVM: load control fields from VMCB12 before checking them
      KVM: SVM: ensure that EFER.SVME is set when running nested guest
or on nested vmexit
      KVM: x86: reduce pvclock_gtod_sync_lock critical sections
      KVM: x86: disable interrupts while pvclock_gtod_sync_lock is taken

Pavel Begunkov (5):
      io_uring: always go for cancellation spin on exec
      io_uring: handle setup-failed ctx in kill_timeouts
      io_uring/io-wq: protect against sprintf overflow
      io_uring: fix EIOCBQUEUED iter revert
      block: don't ignore REQ_NOWAIT for direct IO

Qu Huang (1):
      drm/amdkfd: dqm fence memory corruption

Rafael J. Wysocki (1):
      ACPI: tables: x86: Reserve memory occupied by ACPI tables

Rajendra Nayak (2):
      pinctrl: qcom: sc7280: Fix SDC_QDSD_PINGROUP and UFS_RESET offsets
      pinctrl: qcom: sc7280: Fix SDC1_RCLK configurations

Richard Gong (1):
      firmware: stratix10-svc: reset COMMAND_RECONFIG_FLAG_PARTIAL to 0

Roger Pau Monne (1):
      pinctrl: intel: check REVID register value for device presence

Roja Rani Yarubandi (1):
      soc: qcom-geni-se: Cleanup the code to remove proxy votes

Sean Christopherson (4):
      KVM: x86/mmu: Ensure TLBs are flushed when yielding during GFN range =
zap
      KVM: x86/mmu: Ensure TLBs are flushed for TDP MMU during NX zapping
      KVM: x86/mmu: Don't allow TDP MMU to yield when recovering NX pages
      kbuild: lto: Merge module sections if and only if
CONFIG_LTO_CLANG is enabled

Shawn Guo (1):
      usb: dwc3: qcom: skip interconnect init for ACPI probe

Shuah Khan (1):
      usbip: vhci_hcd fix shift out-of-bounds in vhci_hub_control()

Siddharth Chandrasekaran (1):
      KVM: make: Fix out-of-source module builds

Stefan Raspl (1):
      tools/kvm_stat: Add restart delay

Steven Rostedt (VMware) (2):
      ftrace: Check if pages were allocated before calling free_pages()
      tracing: Fix stack trace event size

Suzuki K Poulose (2):
      KVM: arm64: Hide system instruction access to Trace registers
      KVM: arm64: Disable guest access to trace filter controls

Takashi Iwai (2):
      ALSA: hda: Re-add dropped snd_poewr_change_state() calls
      ALSA: hda: Add missing sanity checks in PM prepare/complete callbacks

Tetsuo Handa (1):
      reiserfs: update reiserfs_xattrs_initialized() condition

Thierry Reding (2):
      drm/tegra: dc: Restore coupling of display controllers
      drm/tegra: sor: Grab runtime PM reference across reset

Thinh Nguyen (2):
      usb: dwc3: gadget: Set gadget_max_speed when set ssp_rate
      usb: dwc3: gadget: Use max speed if unspecified

Tian Tao (1):
      drm/exynos/decon5433: Remove the unused include statements

Tomas Winkler (1):
      mei: allow map and unmap of client dma buffer only for disconnected c=
lient

Tong Zhang (1):
      usb: gadget: udc: amd5536udc_pci fix null-ptr-dereference

Tony Lindgren (1):
      usb: musb: Fix suspend with devices connected for a64

Vincent Palatin (1):
      USB: quirks: ignore remote wake-up on Fibocom L850-GL LTE modem

Vinod Koul (1):
      MAINTAINERS: Add linux-phy list and patchwork

Vitaly Kuznetsov (5):
      KVM: x86/vPMU: Forbid writing to MSR_F15H_PERF MSRs when guest
doesn't have X86_FEATURE_PERFCTR_CORE
      selftests: kvm: make hardware_disable_test less verbose
      KVM: x86: Prevent 'hv_clock->system_time' from going negative in
kvm_guest_time_update()
      selftests: kvm: Check that TSC page value is small after KVM_SET_CLOC=
K(0)
      ACPI: processor: Fix CPU0 wakeup in acpi_idle_play_dead()

Wang Panzhenzhuan (1):
      pinctrl: rockchip: fix restore error in resume

Wesley Cheng (1):
      usb: dwc3: gadget: Clear DEP flags after stop transfers in ep disable

X=E2=84=B9 Ruoyao (1):
      drm/amdgpu: check alignment on CPU page for bo map

Yang Li (1):
      riscv: remove unneeded semicolon

Yufen Yu (1):
      block: only update parent bi_status when bio fail

Zhen Lei (1):
      soc: litex: Remove duplicated header file inclusion

Zheyu Ma (1):
      firewire: nosy: Fix a use-after-free bug in nosy_ioctl()

Zihao Yu (1):
      riscv,entry: fix misaligned base for excp_vect_table
