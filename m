Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB3038DD62
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 23:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbhEWV7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 17:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbhEWV7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 17:59:09 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0409C061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 14:57:40 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id b26so21762487lfq.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 14:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=6U4/sAAWxKzyWaHVC+Y9Daxr9rR8tQHcvMLCl0pcD28=;
        b=epv79Q2h6+frWv5pEns2uvPVU5gB1+tEzaHWqyjw5BaJuKHbxD+IMT7GLKohaGraLl
         wSc1wOgZwnkhOg0u0bBkBtvnff0PKGuVQWG4KPdR4cSBaj4+LhiR8zjwkpCvFqEUBIbf
         Nn9BQMAdlCap7W/VX3nEBRB8A2xnnSL7SSBRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=6U4/sAAWxKzyWaHVC+Y9Daxr9rR8tQHcvMLCl0pcD28=;
        b=V8Tg5lIatfFUq2iEei2gpuvq3B7gLe45RTa4JZb5TEYmdcSRJAMvow2ZLLoNRFJRSn
         qvD6Zi1l4B0S0FYKBjClcwUWeVkrqBZvZ0dvJEiRsdOjJNrIMeZmcX4soil07T4RzE+S
         I3e3UNEAucqfAiCV0+9NJ5h83h/0XHyMUdNvtUh1Q4rsT3Mcohs+UoBJMh8LxEcIEcA0
         h5Eaj3wpxt9CMF4opjIudvK/qcoNvmWZApnsWM5LQFgtPCNOIVKi8k5fovRk0GHTMd83
         yJ622P5olYEVLqcYXDDH0uHRbHuVt/d0A45U0YoTiKFwXknTF1H3RlEELftn559mplMQ
         BM7A==
X-Gm-Message-State: AOAM531qTWCxISruG+5R1D5W1fDyXctv3gXlXYV7AF6BzbdBb5ynyoTO
        9vkbvLvEQoMwt38wMQcZg1Ld6S0RuUYa/iv6fio=
X-Google-Smtp-Source: ABdhPJwquZuCGkleYSS3p3CHYTiCprcmeQuTsJoFHteZhJXvwQMmOl9ANXiTc5/hh6aenamMvZ0b6w==
X-Received: by 2002:a19:e008:: with SMTP id x8mr8699346lfg.439.1621807057899;
        Sun, 23 May 2021 14:57:37 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id y8sm1516927ljy.7.2021.05.23.14.57.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 May 2021 14:57:37 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id j10so37772781lfb.12
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 14:57:37 -0700 (PDT)
X-Received: by 2002:a05:6512:1095:: with SMTP id j21mr8382748lfg.40.1621807056851;
 Sun, 23 May 2021 14:57:36 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 23 May 2021 11:57:20 -1000
X-Gmail-Original-Message-ID: <CAHk-=wiUwtRp+jjCMd9x8O90iD_YHVBQzJoKCsT9e06L7qob3Q@mail.gmail.com>
Message-ID: <CAHk-=wiUwtRp+jjCMd9x8O90iD_YHVBQzJoKCsT9e06L7qob3Q@mail.gmail.com>
Subject: Linux 5.13-rc3
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm. rc3 is when usually the other shoe drops, and we start having a
lot more fixes for fallout from the merge window.

Not so this time. It's been a very calm rc3 week, and at least in pure
number of commits this is the smallest rc3 we've had in the 5.x
series.

Considering that the merge window was not in any way small, this is a
bit surprising, but I suspect it's one of those "not everybody sent in
fixes this week" things that will rectify itself next week. I got no
networking pull this week, for example.

Anyway, enjoy the small rc while you can. I don't think there are any
huge and scary issues going on, and the appended shortlog certainly
doesn't have anything that I would consider odd or unusual. If
anything, maybe some of the fallout from the umn brouhaha stands out.

The diff looks normal too, with about 60% drivers (gpu, habanalabs and
sound is most noticeable, but there's noise elsewhere too). Other than
that, it's arch updates (x86, powerpc, arm64), filesystems (btrfs,
cifs, xfs) and some tooling work. And a bit of noise elsewhere
(locking, vm, signal info).

For details, see the shortlog (or for even more details, the git tree
itself, of course).

               Linus

---

Ajish Koshy (1):
      scsi: pm80xx: Fix drives missing during rmmod/insmod loop

Alaa Emad (2):
      media: dvb: Add check on sp8870_readreg return
      media: gspca: mt9m111: Check write_bridge for timeout

Alexander Potapenko (1):
      kasan: slab: always reset the tag in get_freepointer_safe()

Alexey Dobriyan (1):
      proc: remove Alexey from MAINTAINERS

Alexey Kardashevskiy (1):
      powerpc: Fix early setup to make early_ioremap() work

Andy Shevchenko (2):
      gpio: xilinx: Correct kernel doc for xgpio_probe()
      platform/x86: intel_punit_ipc: Append MODULE_DEVICE_TABLE for ACPI

Anirudh Rayabharam (5):
      net: fujitsu: fix potential null-ptr-deref
      net/smc: properly handle workqueue allocation failure
      net: stmicro: handle clk_prepare() failure during init
      ath6kl: return error code in ath6kl_wmi_set_roam_lrssi_cmd()
      rapidio: handle create_workqueue() failure

Arnd Bergmann (4):
      dt-bindings: nvmem: mediatek: remove duplicate mt8192 line
      kcsan: Fix debugfs initcall return type
      platform/surface: aggregator: avoid clang -Wconstant-conversion warni=
ng
      mm/shuffle: fix section mismatch warning

Atul Gopinathan (3):
      serial: max310x: unregister uart driver in case of failure and abort
      cdrom: gdrom: deallocate struct gdrom_unit fields in remove_gdrom
      ALSA: sb8: Add a comment note regarding an unused pointer

Barnab=C3=A1s P=C5=91cze (1):
      platform/x86: ideapad-laptop: fix method name typo

Bart Van Assche (1):
      scsi: ufs: core: Increase the usable queue depth

Bharat Jauhari (1):
      habanalabs: expose ASIC specific PLL index

Boris Burkov (1):
      btrfs: return whole extents in fiemap

Changfeng (1):
      drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid compute hang

Chris Park (1):
      drm/amd/display: Disconnect non-DP with no EDID

Chris Wilson (1):
      drm/i915/gem: Pin the L-shape quirked object as unshrinkable

Christian Brauner (1):
      fs/mount_setattr: tighten permission checks

Christian K=C3=B6nig (3):
      drm/radeon: use the dummy page for GART if needed
      drm/amdgpu: stop touching sched.ready in the backend
      dma-buf: fix unintended pin/unpin warnings

Christoph Hellwig (1):
      block: prevent block device lookups at the beginning of del_gendisk

Christophe JAILLET (4):
      openrisc: Fix a memory leak
      quota: Use 'hlist_for_each_entry' to simplify code
      uio_hv_generic: Fix a memory leak in error handling paths
      uio_hv_generic: Fix another memory leak in error handling paths

Dan Carpenter (2):
      firmware: arm_scpi: Prevent the ternary sign expansion bug
      RDMA/uverbs: Fix a NULL vs IS_ERR() bug

Daniel Beer (1):
      mmc: sdhci-pci-gli: increase 1.8V regulator wait

Daniel Cordova A (1):
      ALSA: hda: fixup headset for ASUS GU502 laptop

Darrick J. Wong (5):
      ics932s401: fix broken handling of errors when word reading fails
      xfs: adjust rt allocation minlen when extszhint > rtextsize
      xfs: retry allocations when locality-based search fails
      xfs: fix deadlock retry tracepoint arguments
      xfs: restore old ioctl definitions

Du Cheng (2):
      net: caif: remove BUG_ON(dev =3D=3D NULL) in caif_xmit
      ethernet: sun: niu: fix missing checks of niu_pci_eeprom_read()

Elia Devito (1):
      ALSA: hda/realtek: Add fixup for HP Spectre x360 15-df0xxx

Eric W. Biederman (5):
      siginfo: Move si_trapno inside the union inside _si_fault
      signal: Implement SIL_FAULT_TRAPNO
      signal: Factor force_sig_perf out of perf_sigtrap
      signal: Deliver all of the siginfo perf data in _perf
      signalfd: Remove SIL_PERF_EVENT fields from signalfd_siginfo

Filipe Manana (2):
      btrfs: fix removed dentries still existing after log is synced
      btrfs: release path before starting transaction when cloning inline e=
xtent

Geert Uytterhoeven (1):
      irqchip/apple-aic: APPLE_AIC should depend on ARCH_APPLE

Greg Kroah-Hartman (45):
      Revert "crypto: cavium/nitrox - add an error message to explain
the failure of pci_request_mem_regions"
      Revert "media: rcar_drif: fix a memory disclosure"
      Revert "hwmon: (lm80) fix a missing check of bus read in lm80 probe"
      Revert "serial: mvebu-uart: Fix to avoid a potential NULL
pointer dereference"
      Revert "media: usb: gspca: add a missed check for goto_low_power"
      Revert "ALSA: sb: fix a missing check of snd_ctl_add"
      Revert "leds: lp5523: fix a missing check of return value of lp55xx_r=
ead"
      Revert "serial: max310x: pass return value of spi_register_driver"
      Revert "rtlwifi: fix a potential NULL pointer dereference"
      net: rtlwifi: properly check for alloc_workqueue() failure
      Revert "net: fujitsu: fix a potential NULL pointer dereference"
      Revert "net/smc: fix a NULL pointer dereference"
      Revert "net: caif: replace BUG_ON with recovery code"
      Revert "net: stmicro: fix a missing check of clk_prepare"
      Revert "niu: fix missing checks of niu_pci_eeprom_read"
      Revert "qlcnic: Avoid potential NULL pointer dereference"
      Revert "gdrom: fix a memory leak bug"
      Revert "char: hpet: fix a missing check of ioremap"
      Revert "scsi: ufs: fix a missing check of devm_reset_control_get"
      Revert "ALSA: gus: add a check of the status of snd_ctl_add"
      Revert "ALSA: sb8: add a check for request_region"
      Revert "ALSA: usx2y: Fix potential NULL pointer dereference"
      Revert "video: hgafb: fix potential NULL pointer dereference"
      Revert "isdn: mISDNinfineon: fix potential NULL pointer dereference"
      Revert "ath6kl: return error code in ath6kl_wmi_set_roam_lrssi_cmd()"
      Revert "rapidio: fix a NULL pointer dereference when
create_workqueue() fails"
      Revert "isdn: mISDN: Fix potential NULL pointer dereference of kzallo=
c"
      Revert "ecryptfs: replace BUG_ON with error handling code"
      Revert "dmaengine: qcom_hidma: Check for driver register failure"
      Revert "libertas: add checks for the return value of sysfs_create_gro=
up"
      libertas: register sysfs groups properly
      Revert "ASoC: rt5645: fix a NULL pointer dereference"
      Revert "ASoC: cs43130: fix a NULL pointer dereference"
      ASoC: cs43130: handle errors in cs43130_probe() properly
      Revert "media: dvb: Add check on sp8870_readreg"
      Revert "media: gspca: mt9m111: Check write_bridge for timeout"
      Revert "media: gspca: Check the return value of write_bridge for time=
out"
      media: gspca: properly check for errors in po1030_probe()
      Revert "net: liquidio: fix a NULL pointer dereference"
      Revert "video: imsttfb: fix potential NULL pointer dereferences"
      video: imsttfb: check for ioremap() failures
      Revert "brcmfmac: add a check for the status of usb_register"
      brcmfmac: properly check for bus register errors
      cdrom: gdrom: initialize global variable at init time
      Revert "Revert "ALSA: usx2y: Fix potential NULL pointer dereference""

Guchun Chen (2):
      drm/amdgpu: update gc golden setting for Navi12
      drm/amdgpu: update sdma golden setting for Navi12

Gulam Mohamed (1):
      block: fix a race between del_gendisk and BLKRRPART

Hans de Goede (3):
      platform/x86: intel_int0002_vgpio: Only call enable_irq_wake()
when using s2idle
      platform/x86: dell-smbios-wmi: Fix oops on rmmod dell_smbios
      platform/x86: touchscreen_dmi: Add info for the Chuwi Hi10 Pro
(CWI529) tablet

Hsin-Yi Wang (1):
      misc: eeprom: at24: check suspend status before disable regulator

Hui Wang (1):
      ALSA: hda/realtek: reset eapd coeff to default value for alc287

Igor Matheus Andrade Torrente (1):
      video: hgafb: fix potential NULL pointer dereference

James Smart (1):
      nvme-fc: clear q_live at beginning of association teardown

James Zhu (1):
      drm/amdgpu: add video_codecs query support for aldebaran

Jan Beulich (3):
      x86/Xen: swap NX determination and GDT setup on BSP
      xen-pciback: redo VF placement in the virtual topology
      xen-pciback: reconfigure also from backend watch handler

Jan Kara (1):
      quota: Disable quotactl_path syscall

Javed Hasan (1):
      scsi: qedf: Add pointer checks in qedf_update_link_speed()

Jessica Yu (1):
      module: check for exit sections in layout_sections() instead of
module_init_section()

Jiapeng Chong (1):
      cifs: Fix inconsistent indenting

Jim Cromie (2):
      dyndbg: avoid calling dyndbg_emit_prefix when it has no work
      dyndbg: drop uninformative vpr_info

Jingwen Chen (1):
      drm/amd/amdgpu: fix refcount leak

Joerg Roedel (3):
      x86/sev-es: Don't return NULL from sev_es_get_ghcb()
      x86/sev-es: Forward page-faults which happen during emulation
      x86/sev-es: Use __put_user()/__get_user() for data accesses

Johannes Thumshirn (3):
      btrfs: return 0 for dev_extent_hole_check_zoned hole_start in
case of error
      btrfs: zoned: pass start block to btrfs_use_zone_append
      btrfs: zoned: fix parallel compressed writes

Jon Hunter (1):
      gpio: tegra186: Don't set parent IRQ affinity

Jonathan Neusch=C3=A4fer (2):
      scripts/jobserver-exec: Fix a typo ("envirnoment")
      ARM: npcm: wpcm450: select interrupt controller driver

Josef Bacik (2):
      btrfs: avoid RCU stalls while running delayed iputs
      btrfs: do not BUG_ON in link_to_fixup_dir

Kai-Heng Feng (1):
      platform/x86: hp_accel: Avoid invoking _INI to speed up resume

Kees Cook (1):
      tools build: Fix quiet cmd indentation

Keith Busch (1):
      nvme-tcp: rerun io_work if req_list is not empty

Kevin Hilman (1):
      MAINTAINERS: ARM/Amlogic SoCs: add Neil as primary maintainer

Krzysztof Kozlowski (1):
      drm/exynos: correct exynos_drm_fimd kerneldoc

Lang Yu (1):
      drm/amd/amdgpu: fix a potential deadlock in gpu reset

Leo Yan (1):
      locking/lockdep: Correct calling tracepoints

Leon Romanovsky (5):
      RDMA/siw: Properly check send and receive CQ pointers
      RDMA/siw: Release xarray entry
      RDMA/core: Prevent divide-by-zero error triggered by the user
      RDMA/rxe: Clear all QP fields if creation failed
      RDMA/rxe: Return CQE error if invalid lkey was supplied

Like Xu (2):
      perf/x86: Avoid touching LBR_TOS MSR for Arch LBR
      perf/x86/lbr: Remove cpuc->lbr_xsave allocation from atomic context

Liming Sun (1):
      platform/mellanox: mlxbf-tmfifo: Fix a memory barrier issue

Linus Torvalds (2):
      Revert "i915: fix remap_io_sg to verify the pgprot"
      Linux 5.13-rc3

Luca Stefani (1):
      binder: Return EFAULT if we fail BINDER_ENABLE_ONEWAY_SPAM_DETECTION

Lv Yunlong (1):
      habanalabs/gaudi: Fix a potential use after free in
gaudi_memset_device_memory

Maor Gottlieb (3):
      RDMA/mlx5: Verify that DM operation is reasonable
      RDMA/mlx5: Recover from fatal event in dual port mode
      RDMA/mlx5: Fix query DCT via DEVX

Marc Zyngier (1):
      ARM: PXA: Fix cplds irqdesc allocation when using legacy mode

Martin =C3=85gren (1):
      uio/uio_pci_generic: fix return value changed in refactoring

Matt Wang (1):
      scsi: BusLogic: Fix 64-bit system enumeration error for Buslogic

Maximilian Luz (3):
      platform/surface: aggregator: Do not mark interrupt as shared
      platform/surface: aggregator: Add platform-drivers-x86 list to
MAINTAINERS entry
      platform/surface: dtx: Fix poll function

Michal Hocko (1):
      Revert "mm/gup: check page posion status for coredump."

Michal Kubecek (1):
      kbuild: dummy-tools: adjust to stricter stackprotector check

Mike Kravetz (1):
      userfaultfd: hugetlbfs: fix new flag usage in error path

Mike Rapoport (2):
      openrisc: mm/init.c: remove unused memblock_region variable in map_ra=
m()
      openrisc: mm/init.c: remove unused variable 'end' in paging_init()

Mikulas Patocka (4):
      dm snapshot: fix a crash when an origin has no snapshots
      dm snapshot: fix crash with transient storage and zero chunk size
      dm integrity: revert to not using discard filler when recalulating
      dm integrity: fix sparse warnings

Nathan Chancellor (1):
      x86/build: Fix location of '-plugin-opt=3D' flags

Neil Armstrong (2):
      mmc: meson-gx: make replace WARN_ONCE with dev_warn_once about
scatterlist offset alignment
      mmc: meson-gx: also check SD_IO_RW_EXTENDED for scatterlist size alig=
nment

Nicholas Piggin (2):
      powerpc/64s/syscall: Use pt_regs.trap to distinguish syscall ABI
difference between sc and scv syscalls
      powerpc/64s/syscall: Fix ptrace syscall info with scv syscalls

Niklas S=C3=B6derlund (2):
      arm64: dts: renesas: aistarvision-mipi-adapter-2.1: Fix CSI40 ports
      arm64: dts: renesas: Add port@0 node for all CSI-2 nodes to dtsi

Nikola Cornij (1):
      drm/amd/display: Use the correct max downscaling value for DCN3.x fam=
ily

Oded Gabbay (3):
      habanalabs: skip reading f/w errors on bad status
      habanalabs: change error level of security not ready
      habanalabs: ignore f/w status error

Ofir Bitton (1):
      habanalabs: wait for interrupt wrong timeout calculation

Pavel Begunkov (2):
      io_uring: don't modify req->poll for rw
      io_uring: fortify tctx/io_wq cleanup

PeiSen Hou (1):
      ALSA: hda/realtek: Add some CLOVE SSIDs of ALC293

Peter Wang (1):
      scsi: ufs: ufs-mediatek: Fix power down spec violation

Peter Zijlstra (1):
      openrisc: Define memory barrier mb

Petr Mladek (1):
      watchdog: reliable handling of timestamps

Phillip Potter (7):
      leds: lp5523: check return value of lp5xx_read and jump to cleanup co=
de
      scsi: ufs: handle cleanup correctly on devm_reset_control_get error
      isdn: mISDNinfineon: check/cleanup ioremap failure correctly in setup=
_io
      isdn: mISDN: correctly handle ph_info allocation failure in
hfcsusb_ph_info
      fs: ecryptfs: remove BUG_ON from crypt_scatterlist
      dmaengine: qcom_hidma: comment platform_driver_register call
      ASoC: rt5645: add error checking to rt5645_probe function

Qiu Wenbo (1):
      platform/x86: ideapad-laptop: fix a NULL pointer dereference

Rijo Thomas (1):
      tee: amdtee: unload TA only when its refcount becomes 0

Rikard Falkeborn (1):
      linux/bits.h: fix compilation error with GENMASK

Rob Herring (2):
      dt-bindings: media: renesas,drif: Use graph schema
      dt-bindings: More removals of type references on common properties

Rohith Surabattula (3):
      Fix kernel oops when CONFIG_DEBUG_ATOMIC_SLEEP is enabled.
      Defer close only when lease is enabled.
      Fix KASAN identified use-after-free issue.

Ronnie Sahlberg (1):
      cifs: fix memory leak in smb2_copychunk_range

Sagi Grimberg (1):
      nvme-tcp: fix possible use-after-completion

Shay Drory (1):
      RDMA/core: Don't access cm_id after its destruction

Shyam Sundar S K (1):
      platform/x86: hp-wireless: add AMD's hardware id to the supported lis=
t

Simon Rettberg (1):
      drm/i915/gt: Disable HiZ Raw Stall Optimization on broken gen7

Steve French (1):
      SMB3: incorrect file id in requests compounded with open

Takashi Iwai (4):
      ALSA: usb-audio: Validate MS endpoint descriptors
      ALSA: usb-audio: Fix potential out-of-bounce access in MIDI EP parser
      ALSA: intel8x0: Don't update period unless prepared
      ALSA: line6: Fix racy initialization of LINE6 MIDI

Takashi Sakamoto (7):
      ALSA: dice: fix stream format at middle sampling rate for Alesis iO 2=
6
      ALSA: bebob/oxfw: fix Kconfig entry for Mackie d.2 Pro
      ALSA: firewire-lib: fix check for the size of isochronous packet payl=
oad
      ALSA: firewire-lib: fix calculation for size of IR context payload
      ALSA: firewire-lib: fix amdtp_packet tracepoints event for
packet_index field
      ALSA: dice: disable double_pcm_frames mode for M-Audio Profire
610, 2626 and Avid M-Box 3 Pro
      ALSA: dice: fix stream format for TC Electronic Konnekt Live at
high sampling transfer frequency

Teava Radu (1):
      platform/x86: touchscreen_dmi: Add info for the Mediacom Winpad
7.0 W700 tablet

Thomas Wei=C3=9Fschuh (3):
      platform/x86: gigabyte-wmi: streamline dmi matching
      platform/x86: gigabyte-wmi: add support for X570 UD
      platform/x86: gigabyte-wmi: add support for B550 Aorus Elite

Tom Lendacky (2):
      x86/sev-es: Move sev_es_put_ghcb() in prep for follow on patch
      x86/sev-es: Invalidate the GHCB after completing VMGEXIT

Tom Seewald (3):
      qlcnic: Add null check after calling netdev_alloc_skb
      char: hpet: add checks after calling ioremap
      net: liquidio: Add missing null pointer checks

Varad Gautam (1):
      ipc/mqueue, msg, sem: avoid relying on a stack reference past its exp=
iry

Wan Jiabing (3):
      firmware: arm_scmi: Remove duplicate declaration of struct
scmi_protocol_handle
      dt-bindings: phy: cadence-torrent: update reference file of docs
      leds: Fix reference file name of documentation

Wu Bo (2):
      nvmet: fix memory leak in nvmet_alloc_ctrl()
      nvme-loop: fix memory leak in nvme_loop_create_ctrl()

Yang Yingliang (1):
      tools/testing/selftests/exec: fix link error

Yi Li (1):
      drm/amdgpu: Fix GPU TLB update error when PAGE_SIZE > AMDGPU_PAGE_SIZ=
E

Zhen Lei (5):
      scsi: qla2xxx: Fix error return code in qla82xx_write_flash_dword()
      irqchip: Remove redundant error printing
      drm/exynos: Remove redundant error printing in exynos_dsi_probe()
      drm/exynos/decon5433: Remove redundant error printing in
exynos5433_decon_probe()
      lib: kunit: suppress a compilation warning of frame size

Zhenyu Wang (1):
      drm/i915/gvt: Move mdev attribute groups into kvmgt module

Zou Wei (1):
      gpio: cadence: Add missing MODULE_DEVICE_TABLE

Zqiang (1):
      locking/mutex: clear MUTEX_FLAGS if wait_list is empty due to signal

wenhuizhang (1):
      cifs: remove deadstore in cifs_close_all_deferred_files()

xinhui pan (1):
      drm/amdgpu: Fix a use-after-free
