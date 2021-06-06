Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423FC39D223
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 01:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhFFXKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 19:10:07 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:34341 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhFFXKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 19:10:06 -0400
Received: by mail-lf1-f45.google.com with SMTP id f30so23073086lfj.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 16:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=60ykCW6DgWLMOiU8SRO9EUfyiLJ9V/ACWQnXrIB3Qj4=;
        b=NDwL4y2uJkYCFrc6uRzeqgPYlhKDSoWhgmYFHRXp9VxSSP5ZweZyHpOHOzsdIR6iyA
         roDW2xUoU8YKqERA4tA+vdHFH1Gwa3KcnM1E+r4XBPBpOUjhkgZCJHBK7qIgP5FzbABX
         UmhAa8YP0cx16LTiEUykpOJEz7btBJkyeHSD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=60ykCW6DgWLMOiU8SRO9EUfyiLJ9V/ACWQnXrIB3Qj4=;
        b=pL+kKRjboOqLyX9/o7WeQ+ewpr0CQvA+zK9FQhAFNHDVRezolfCcfcz8fi737M4AZa
         VLRqTh2r6ajPvOOxx74xQ9Rd5OFCnptPfJNBIH4wo1b4Jk77VHxH4B+cF/oDFgnsmHRB
         bcX/mAzAFxD7WOSPsH+fhwLTblLymS+E6roISsKWZDjKFT77WRXRERylk1E2bZ2kKkCY
         Iq5j2Nh+HxgHx8KCnFoC+P9hbABJ84zWUBXd+SwobUqHy5dCqoS0teIrQCt/+3p5mQiN
         odl5V4gzv7U6ZQNJqZuEm9kHzEMXtZ7MYoMJqg2KcY4FBkaMKf2/FSJUChvTHlUknsMj
         1yrg==
X-Gm-Message-State: AOAM532+p0Mopxxy4OuScK4uWtKm8PFx7034QBl2jfVmWLwgXsMC5kyA
        0emRy/IXBSk4o+aCQHLPRYCcRGaJChtqMefE7uk=
X-Google-Smtp-Source: ABdhPJwzE00EF05TmDQn71dYEi6iE5UCjAI0OdJOr1IzqhB0XHL76GjfQc5FHXxDpvDX44idmjatUg==
X-Received: by 2002:a19:6d12:: with SMTP id i18mr9712403lfc.249.1623020827826;
        Sun, 06 Jun 2021 16:07:07 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id b44sm1554370ljr.68.2021.06.06.16.07.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 16:07:07 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id p17so22268248lfc.6
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 16:07:07 -0700 (PDT)
X-Received: by 2002:ac2:55b7:: with SMTP id y23mr8693528lfg.40.1623020826789;
 Sun, 06 Jun 2021 16:07:06 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Jun 2021 16:06:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgxOqRbXUwQ73sMgxfOg9+B7BeTgZ6JP9oHR9BPhKGjOg@mail.gmail.com>
Message-ID: <CAHk-=wgxOqRbXUwQ73sMgxfOg9+B7BeTgZ6JP9oHR9BPhKGjOg@mail.gmail.com>
Subject: Linux 5.13-rc5
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm. Things haven't really started to calm down very much yet, but rc5
seems to be fairly average in size. I'm hoping things will start
shrinking now.

Networking (both drivers and core networking code) is once again
responsible for a fairly big chunk of the fixes in rc5, but there's
certainly a fair number of fixes elsewhere to - architectures (arm64
has mostly devicetree updates, but we've got fixes to x86, mips,
powerpc in there too), other drivers (GPU driver fixes stand out, but
there's also sound, HID, scsi, nvme.. you name it).

And we have a scattering of fixes elsewhere too: filesystems (btrfs,
ext4, gfs2, ocfs, fanotify), soem core vm fixes, and some selftest and
perf tool updates.

Most of the discussion I've seen is already about future things, but
please do give this a whirl and make sure that 5.13 is stable and
good.

Shortlog appended as usual for people who want to scan the details -
you can easily scroll through this to get a feel for the kinds of
things that have been going on. Nothing really looks all that hugely
exciting (unless one of the issues happened to impact you personally,
of course).

                 Linus

---

Ahelenia Ziemia=C5=84ska (2):
      HID: multitouch: require Finger field to mark Win8 reports as MT
      HID: multitouch: set Stylus suffix for Stylus-application devices, to=
o

Alexander Aring (1):
      net: sock: fix in-kernel mark setting

Alexey Makhalov (1):
      ext4: fix memory leak in ext4_fill_super

Amir Goldstein (1):
      fanotify: fix permission model of unprivileged group

Andreas Gruenbacher (3):
      gfs2: Prevent direct-I/O write fallback errors from getting lost
      gfs2: Fix mmap locking for write faults
      Revert "gfs2: Fix mmap locking for write faults"

Andy Shevchenko (1):
      net: ieee802154: mrf24j40: Drop unneeded of_match_ptr()

Anirudh Rayabharam (1):
      HID: usbhid: fix info leak in hid_submit_ctrl

Ariel Levkovich (1):
      net/sched: act_ct: Fix ct template allocation for zone 0

Armin Wolf (1):
      hwmon: (dell-smm-hwmon) Fix index values

Arnd Bergmann (1):
      HID: i2c-hid: fix format string mismatch

Asher Song (1):
      drm/amdgpu: add judgement for dc support

Aya Levin (3):
      net/mlx5e: Fix incompatible casting
      net/mlx5e: Fix HW TS with CQE compression according to profile
      net/mlx5e: Fix conflict with HW TS and CQE compression

Basavaraj Natikar (2):
      HID: amd_sfh: Use devm_kzalloc() instead of kzalloc()
      HID: amd_sfh: Fix memory leak in amd_sfh_work

Benjamin Moody (1):
      HID: semitek: new driver for GK6X series keyboards

Bindu Ramamurthy (1):
      drm/amd/display: Allow bandwidth validation for 0 streams.

Bixuan Cui (1):
      HID: gt683r: add missing MODULE_DEVICE_TABLE

Bob Peterson (4):
      gfs2: Fix I_NEW check in gfs2_dinode_in
      gfs2: fix scheduling while atomic bug in glocks
      gfs2: fix a deadlock on withdraw-during-mount
      gfs2: Clean up revokes on normal withdraws

Borislav Petkov (3):
      x86/thermal: Fix LVT thermal setup for SMI delivery mode
      dmaengine: idxd: Use cpu_feature_enabled()
      x86/alternative: Optimize single-byte NOPs at an arbitrary position

Brett Creeley (2):
      ice: Fix allowing VF to request more/less queues via virtchnl
      ice: Fix VFR issues for AVF drivers that expect ATQLEN cleared

Carlos M (1):
      ALSA: hda: Fix for mute key LED for HP Pavilion 15-CK0xx

Changbin Du (1):
      efi/fdt: fix panic when no valid fdt found

Chu Lin (1):
      hwmon/pmbus: (q54sj108a2) The PMBUS_MFR_ID is actually 6 chars
instead of 5

Coco Li (1):
      ipv6: Fix KASAN: slab-out-of-bounds Read in fib6_nh_flush_exceptions

Dan Carpenter (1):
      efi/libstub: prevent read overflow in find_file_option()

Dan Robertson (1):
      net: ieee802154: fix null deref in parse dev addr

Daniel Borkmann (1):
      bpf, lockdown, audit: Fix buggy SELinux lockdown permission checks

Daniel Rosenberg (2):
      ext4: fix no-key deletion for encrypt+casefold
      ext4: Only advertise encrypted_casefold when encryption and
unicode are enabled

Daniel Wagner (1):
      scsi: qedf: Do not put host in qedf_vport_create() unconditionally

Dave Ertman (1):
      ice: Allow all LLDP packets from PF to Tx

David Hildenbrand (1):
      drivers/base/memory: fix trying offlining memory blocks with
memory holes on aarch64

David Matlack (1):
      proc: add .gitignore for proc-subset-pid selftest

David Sterba (1):
      MAINTAINERS: add btrfs IRC link

Ding Hui (1):
      mm/page_alloc: fix counting of free pages after take off from buddy

Dmitry Osipenko (1):
      drm/tegra: Correct DRM_FORMAT_MOD_NVIDIA_SECTOR_LAYOUT

Dmitry Torokhov (2):
      HID: hid-input: add mapping for emoji picker key
      HID: hid-debug: recognize KEY_ASSISTANT and KEY_KBD_LAYOUT_NEXT

Dongliang Mu (1):
      ALSA: control led: fix memory leak in snd_ctl_led_register

Erik Kaneda (1):
      ACPICA: Clean up context mutex during object deletion

Ewan D. Milne (1):
      scsi: scsi_devinfo: Add blacklist entry for HPE OPEN-V

Fabio Estevam (3):
      ARM: imx: pm-imx27: Include "common.h"
      ARM: dts: imx7d-meerkat96: Fix the 'tuning-step' property
      ARM: dts: imx7d-pico: Fix the 'tuning-step' property

Felix Fietkau (4):
      mt76: connac: fix HT A-MPDU setting field in STA_REC_PHY
      mt76: mt7921: fix max aggregation subframes setting
      mt76: validate rx A-MSDU subframes
      mt76: mt7921: remove leftover 80+80 HE capability

Filipe Manana (2):
      btrfs: fix fsync failure and transaction abort after writes to
prealloc extents
      btrfs: fix deadlock when cloning inline extents and low on available =
space

Florian Westphal (1):
      netfilter: conntrack: unregister ipv4 sockopts on error unwind

Frederic Barrat (1):
      Revert "powerpc/kernel/iommu: Align size for IOMMU_PAGE_SIZE()
to save TCEs"

Geert Uytterhoeven (2):
      ARM: dts: imx: emcon-avari: Fix nxp,pca8574 #gpio-cells
      virtchnl: Add missing padding to virtchnl_proto_hdrs

Gerald Schaefer (1):
      mm/debug_vm_pgtable: fix alignment for pmd/pud_advanced_tests()

Grant Peltier (1):
      hwmon: (pmbus/isl68137) remove READ_TEMPERATURE_3 for RAA228228

Gustavo A. R. Silva (1):
      vfio/iommu_type1: Use struct_size() for kzalloc()

Haiyue Wang (1):
      ice: handle the VF VSI rebuild failure

Hamza Mahfooz (1):
      HID: remove the unnecessary redefinition of a macro

Hannes Reinecke (4):
      nvme-loop: reset queue count to 1 in nvme_loop_destroy_io_queues()
      nvme-loop: clear NVME_LOOP_Q_LIVE when
nvme_loop_configure_admin_queue() fails
      nvme-loop: check for NVME_LOOP_Q_LIVE in nvme_loop_destroy_admin_queu=
e()
      nvme-loop: do not warn for deleted controllers during reset

Hans de Goede (4):
      HID: quirks: Add HID_QUIRK_NO_INIT_REPORTS quirk for Dell K15A
keyboard-dock
      HID: core: Remove extraneous empty line before
EXPORT_SYMBOL_GPL(hid_check_keys_pressed)Ahelenia Ziemia=C5=84ska (2):
      HID: multitouch: require Finger field to mark Win8 reports as MT
      HID: multitouch: set Stylus suffix for Stylus-application devices, to=
o

Alexander Aring (1):
      net: sock: fix in-kernel mark setting

Alexey Makhalov (1):
      ext4: fix memory leak in ext4_fill_super

Amir Goldstein (1):
      fanotify: fix permission model of unprivileged group

Andreas Gruenbacher (3):
      gfs2: Prevent direct-I/O write fallback errors from getting lost
      gfs2: Fix mmap locking for write faults
      Revert "gfs2: Fix mmap locking for write faults"

Andy Shevchenko (1):
      net: ieee802154: mrf24j40: Drop unneeded of_match_ptr()

Anirudh Rayabharam (1):
      HID: usbhid: fix info leak in hid_submit_ctrl

Ariel Levkovich (1):
      net/sched: act_ct: Fix ct template allocation for zone 0

Armin Wolf (1):
      hwmon: (dell-smm-hwmon) Fix index values

Arnd Bergmann (1):
      HID: i2c-hid: fix format string mismatch

Asher Song (1):
      drm/amdgpu: add judgement for dc support

Aya Levin (3):
      net/mlx5e: Fix incompatible casting
      net/mlx5e: Fix HW TS with CQE compression according to profile
      net/mlx5e: Fix conflict with HW TS and CQE compression

Basavaraj Natikar (2):
      HID: amd_sfh: Use devm_kzalloc() instead of kzalloc()
      HID: amd_sfh: Fix memory leak in amd_sfh_work

Benjamin Moody (1):
      HID: semitek: new driver for GK6X series keyboards

Bindu Ramamurthy (1):
      drm/amd/display: Allow bandwidth validation for 0 streams.

Bixuan Cui (1):
      HID: gt683r: add missing MODULE_DEVICE_TABLE

Bob Peterson (4):
      gfs2: Fix I_NEW check in gfs2_dinode_in
      gfs2: fix scheduling while atomic bug in glocks
      gfs2: fix a deadlock on withdraw-during-mount
      gfs2: Clean up revokes on normal withdraws

Borislav Petkov (3):
      x86/thermal: Fix LVT thermal setup for SMI delivery mode
      dmaengine: idxd: Use cpu_feature_enabled()
      x86/alternative: Optimize single-byte NOPs at an arbitrary position

Brett Creeley (2):
      ice: Fix allowing VF to request more/less queues via virtchnl
      ice: Fix VFR issues for AVF drivers that expect ATQLEN cleared

Carlos M (1):
      ALSA: hda: Fix for mute key LED for HP Pavilion 15-CK0xx

Changbin Du (1):
      efi/fdt: fix panic when no valid fdt found

Chu Lin (1):
      hwmon/pmbus: (q54sj108a2) The PMBUS_MFR_ID is actually 6 chars
instead of 5

Coco Li (1):
      ipv6: Fix KASAN: slab-out-of-bounds Read in fib6_nh_flush_exceptions

Dan Carpenter (1):
      efi/libstub: prevent read overflow in find_file_option()

Dan Robertson (1):
      net: ieee802154: fix null deref in parse dev addr

Daniel Borkmann (1):
      bpf, lockdown, audit: Fix buggy SELinux lockdown permission checks

Daniel Rosenberg (2):
      ext4: fix no-key deletion for encrypt+casefold
      ext4: Only advertise encrypted_casefold when encryption and
unicode are enabled

Daniel Wagner (1):
      scsi: qedf: Do not put host in qedf_vport_create() unconditionally

Dave Ertman (1):
      ice: Allow all LLDP packets from PF to Tx

David Hildenbrand (1):
      drivers/base/memory: fix trying offlining memory blocks with
memory holes on aarch64

David Matlack (1):
      proc: add .gitignore for proc-subset-pid selftest

David Sterba (1):
      MAINTAINERS: add btrfs IRC link

Ding Hui (1):
      mm/page_alloc: fix counting of free pages after take off from buddy

Dmitry Osipenko (1):
      drm/tegra: Correct DRM_FORMAT_MOD_NVIDIA_SECTOR_LAYOUT

Dmitry Torokhov (2):
      HID: hid-input: add mapping for emoji picker key
      HID: hid-debug: recognize KEY_ASSISTANT and KEY_KBD_LAYOUT_NEXT

Dongliang Mu (1):
      ALSA: control led: fix memory leak in snd_ctl_led_register

Erik Kaneda (1):
      ACPICA: Clean up context mutex during object deletion

Ewan D. Milne (1):
      scsi: scsi_devinfo: Add blacklist entry for HPE OPEN-V

Fabio Estevam (3):
      ARM: imx: pm-imx27: Include "common.h"
      ARM: dts: imx7d-meerkat96: Fix the 'tuning-step' property
      ARM: dts: imx7d-pico: Fix the 'tuning-step' property

Felix Fietkau (4):
      mt76: connac: fix HT A-MPDU setting field in STA_REC_PHY
      mt76: mt7921: fix max aggregation subframes setting
      mt76: validate rx A-MSDU subframes
      mt76: mt7921: remove leftover 80+80 HE capability

Filipe Manana (2):
      btrfs: fix fsync failure and transaction abort after writes to
prealloc extents
      btrfs: fix deadlock when cloning inline extents and low on available =
space

Florian Westphal (1):
      netfilter: conntrack: unregister ipv4 sockopts on error unwind

Frederic Barrat (1):
      Revert "powerpc/kernel/iommu: Align size for IOMMU_PAGE_SIZE()
to save TCEs"

Geert Uytterhoeven (2):
      ARM: dts: imx: emcon-avari: Fix nxp,pca8574 #gpio-cells
      virtchnl: Add missing padding to virtchnl_proto_hdrs

Gerald Schaefer (1):
      mm/debug_vm_pgtable: fix alignment for pmd/pud_advanced_tests()

Grant Peltier (1):
      hwmon: (pmbus/isl68137) remove READ_TEMPERATURE_3 for RAA228228

Gustavo A. R. Silva (1):
      vfio/iommu_type1: Use struct_size() for kzalloc()

Haiyue Wang (1):
      ice: handle the VF VSI rebuild failure

Hamza Mahfooz (1):
      HID: remove the unnecessary redefinition of a macro

Hannes Reinecke (4):
      nvme-loop: reset queue count to 1 in nvme_loop_destroy_io_queues()
      nvme-loop: clear NVME_LOOP_Q_LIVE when
nvme_loop_configure_admin_queue() fails
      nvme-loop: check for NVME_LOOP_Q_LIVE in nvme_loop_destroy_admin_queu=
e()
      nvme-loop: do not warn for deleted controllers during reset

Hans de Goede (4):
      HID: quirks: Add HID_QUIRK_NO_INIT_REPORTS quirk for Dell K15A
keyboard-dock
      HID: core: Remove extraneous empty line before
EXPORT_SYMBOL_GPL(hid_check_keys_pressed)
      HID: multitouch: Disable event reporting on suspend on the Asus
T101HA touchpad
      HID: asus: Cleanup Asus T101HA keyboard-dock handling

Harshad Shirwadkar (1):
      ext4: fix fast commit alignment issues

Heiner Kallweit (1):
      efi: Allow EFI_MEMORY_XP and EFI_MEMORY_RO both to be cleared

Hillf Danton (1):
      gfs2: Fix use-after-free in gfs2_glock_shrink_scan

Hui Wang (1):
      ALSA: hda: update the power_state during the direct-complete

James Smart (1):
      scsi: lpfc: Fix failure to transmit ABTS on FC link

Jan Kara (1):
      MAINTAINERS: Add Matthew Bobrowski as a reviewer

Jason A. Donenfeld (9):
      wireguard: selftests: remove old conntrack kconfig value
      wireguard: selftests: make sure rp_filter is disabled on vethc
      wireguard: do not use -O3
      wireguard: use synchronize_net rather than synchronize_rcu
      wireguard: peer: allocate in kmem_cache
      wireguard: allowedips: initialize list head in selftest
      wireguard: allowedips: remove nodes in O(1)
      wireguard: allowedips: allocate nodes in kmem_cache
      wireguard: allowedips: free empty intermediate nodes when
removing single node

Javier Martinez Canillas (1):
      kbuild: Quote OBJCOPY var to avoid a pahole call break the build

Jean-Philippe Brucker (1):
      PCI/MSI: Fix MSIs for generic hosts that use device-tree's "msi-map"

Jens Wiklander (1):
      optee: use export_uuid() to copy client UUID

Jerome Brunet (1):
      arm64: meson: select COMMON_CLK

Jiansong Chen (1):
      drm/amdgpu: refine amdgpu_fru_get_product_info

Jiapeng Chong (2):
      ethernet: myri10ge: Fix missing error code in myri10ge_probe()
      rtnetlink: Fix missing error code in rtnl_bridge_notify()

Jiashuo Liang (1):
      x86/fault: Don't send SIGSEGV twice on SEGV_PKUERR

Jisheng Zhang (1):
      riscv: mm: Fix W+X mappings at boot

Joe Perches (1):
      MAINTAINERS: nfc mailing lists are subscribers-only

Johan Hovold (1):
      HID: magicmouse: fix NULL-deref on disconnect

Johnny Chuang (1):
      HID: i2c-hid: Skip ELAN power-on command after reset

Josef Bacik (6):
      btrfs: fix error handling in btrfs_del_csums
      btrfs: return errors from btrfs_del_csums in cleanup_ref_head
      btrfs: mark ordered extent and inode with error if we fail to finish
      btrfs: fixup error handling in fixup_inode_link_counts
      btrfs: check error value from btrfs_update_inode in tree log
      btrfs: abort in rename_exchange if we fail to insert the second ref

Josh Triplett (1):
      net: ipconfig: Don't override command-line hostnames or domains

Jos=C3=A9 Exp=C3=B3sito (1):
      HID: magicmouse: fix crash when disconnecting Magic Trackpad 2

Julian Anastasov (1):
      ipvs: ignore IP_VS_SVC_F_HASHED flag when adding service

Junxiao Bi (1):
      ocfs2: fix data corruption by fallocate

Kai Vehmanen (1):
      ALSA: hda: Add AlderLake-M PCI ID

Khem Raj (1):
      riscv: Use -mno-relax when using lld linker

Krzysztof Kozlowski (1):
      nfc: fix NULL ptr dereference in llcp_sock_getname() after failed con=
nect

Kurt Kanzenbach (1):
      igb: Fix XDP with PTP enabled

Larry Finger (1):
      Bluetooth: Add a new USB ID for RTL8822CE

Lee Jones (2):
      i2c: altera: Fix formatting issue in struct and demote unworthy
kernel-doc headers
      i2c: tegra-bpmp: Demote kernel-doc abuses

Li Huafei (1):
      perf probe: Fix NULL pointer dereference in convert_variable_location=
()

Lin Ma (2):
      Bluetooth: fix the erroneous flush_work() order
      Bluetooth: use correct lock to prevent UAF of hdev object

Linus Torvalds (1):
      Linux 5.13-rc5

Lorenzo Bianconi (4):
      mt76: mt7921: fix possible AOOB issue in mt7921_mcu_tx_rate_report
      mt76: connac: do not schedule mac_work if the device is not running
      mt76: mt76x0e: fix device hang during suspend/resume
      mt76: mt7615: do not set MT76_STATE_PM at bootstrap

Lorenzo Pieralisi (1):
      MAINTAINERS: Add Krzysztof as PCI host/endpoint controllers reviewer

Luben Tuikov (1):
      drm/amdgpu: Don't query CE and UE errors

Lucas Stach (2):
      arm64: dts: zii-ultra: remove second GEN_3V3 regulator instance
      arm64: dts: zii-ultra: fix 12V_MAIN voltage

Luiz Augusto von Dentz (1):
      Bluetooth: btusb: Fix failing to init controllers with operation firm=
ware

Luke D Jones (2):
      HID: asus: Filter keyboard EC for old ROG keyboard
      HID: asus: filter G713/G733 key event to prevent shutdown

Lyude Paul (1):
      drm/tegra: Get ref for DP AUX channel, not its ddc adapter

Maciej Falkowski (3):
      ARM: OMAP1: Fix use of possibly uninitialized irq variable
      ARM: OMAP1: isp1301-omap: Add missing gpiod_add_lookup_table function
      ARM: OMAP1: ams-delta: remove unused function ams_delta_camera_power

Maciej Fijalkowski (1):
      ice: track AF_XDP ZC enabled queues in bitmap

Magnus Karlsson (6):
      i40e: add correct exception tracing for XDP
      ice: add correct exception tracing for XDP
      ixgbe: add correct exception tracing for XDP
      igb: add correct exception tracing for XDP
      ixgbevf: add correct exception tracing for XDP
      igc: add correct exception tracing for XDP

Marcel Holtmann (1):
      Bluetooth: Fix VIRTIO_ID_BT assigned number

Marco Elver (1):
      kfence: use TASK_IDLE when awaiting allocation

Marek Vasut (1):
      ARM: dts: imx6q-dhcom: Add PU,VDD1P1,VDD2P5 regulators

Mark Bolhuis (1):
      HID: Add BUS_VIRTUAL to hid_connect logging

Mark Rutland (1):
      pid: take a reference when initializing `cad_pid`

Mateusz Jo=C5=84czyk (1):
      HID: a4tech: use A4_2WHEEL_MOUSE_HACK_B8 for A4TECH NB-95

Matthew Auld (1):
      Revert "i915: use io_mapping_map_user"

Matthew Wilcox (1):
      Revert "fb_defio: Remove custom address_space_operations"

Maurizio Lombardi (1):
      scsi: target: core: Fix warning on realtime kernels

Max Gurtovoy (2):
      vfio/platform: fix module_put call in error flow
      nvmet: fix freeing unallocated p2pmem

Maxim Mikityanskiy (2):
      net/tls: Replace TLS_RX_SYNC_RUNNING with RCU
      net/tls: Fix use-after-free after the TLS device goes down and up

Maximilian Luz (1):
      HID: surface-hid: Fix integer endian conversion

Michael Walle (3):
      arm64: dts: ls1028a: fix memory node
      arm64: dts: freescale: sl28: var4: fix RGMII clock and voltage
      arm64: dts: freescale: sl28: var1: fix RGMII clock and voltage

Michael Zaidman (2):
      HID: ft260: check data size in ft260_smbus_write()
      HID: ft260: improve error handling of ft260_hid_feature_report_get()

Michal Vok=C3=A1=C4=8D (1):
      ARM: dts: imx6dl-yapp4: Fix RGMII connection to QCA8334 switch

Michel Lespinasse (1):
      mailmap: use private address for Michel Lespinasse

Mike Rapoport (1):
      x86/setup: Always reserve the first 1M of RAM

Mina Almasry (1):
      mm, hugetlb: fix simple resv_huge_pages underflow on UFFDIO_COPY

Moshe Shemesh (1):
      net/mlx5: Check firmware sync reset requested is set before
trying to abort it

Namhyung Kim (3):
      perf record: Move probing cgroup sampling support
      perf evsel: Add missing cloning of evsel->use_config_name
      perf stat: Honor event config name on --no-merge

Naoya Horiguchi (1):
      hugetlb: pass head page to remove_hugetlb_page()

Nathan Chancellor (1):
      drm/tegra: Fix shift overflow in tegra_shared_plane_atomic_update

Naveen N. Rao (1):
      powerpc/kprobes: Fix validation of prefixed instructions across
page boundary

Nicholas Kazlauskas (1):
      drm/amd/display: Fix GPU scaling regression by FS video support

Nicholas Piggin (2):
      powerpc: Fix reverse map real-mode address lookup with huge vmalloc
      KVM: PPC: Book3S HV: Save host FSCR in the P7/8 path

Nirenjan Krishnan (1):
      HID: quirks: Set INCREMENT_USAGE_ON_DUPLICATE for Saitek X65

Nirmoy Das (1):
      drm/amdgpu: make sure we unpin the UVD BO

Nishanth Menon (6):
      arm64: dts: ti: k3-*: Rename the TI-SCI clocks node name
      arm64: dts: ti: k3-am65-wakeup: Add debug region to TI-SCI node
      arm64: dts: ti: k3-am65-wakeup: Drop un-necessary properties
from dmsc node
      arm64: dts: ti: k3-*: Rename the TI-SCI node
      arm64: dts: ti: k3-am65|j721e|am64: Map the dma / navigator
subsystem via explicit ranges
      arm64: dts: ti: k3*: Introduce reg definition for interrupt routers

Pablo Neira Ayuso (5):
      netfilter: nf_tables: missing error reporting for not selected expres=
sions
      netfilter: nf_tables: extended netlink error reporting for chain type
      netfilter: nf_tables: fix table flag updates
      netfilter: nft_ct: skip expectations for confirmed conntrack
      netfilter: nfnetlink_cthelper: hit EBUSY on updates if size mismatche=
s

Paolo Abeni (4):
      mptcp: fix sk_forward_memory corruption on retransmission
      mptcp: always parse mptcp options for MPC reqsk
      mptcp: do not reset MP_CAPABLE subflow on mapping errors
      mptcp: update selftest for fallback due to OoO

Parav Pandit (1):
      devlink: Correct VIRTUAL port to not have phys_port attributes

Paul Blakey (1):
      net/sched: act_ct: Offload connections with commit action

Paul Greenwalt (1):
      ice: report supported and advertised autoneg using PHY capabilities

Pavel Begunkov (1):
      io_uring: fix misaccounting fix buf pinned pages

Pavel Machek (CIP) (1):
      drm/tegra: sor: Do not leak runtime PM reference

Pavel Skripkin (5):
      net: kcm: fix memory leak in kcm_sendmsg
      net: caif: added cfserl_release function
      net: caif: add proper error handling
      net: caif: fix memory leak in caif_device_notify
      net: caif: fix memory leak in cfusbl_device_notify

Phillip Potter (1):
      ext4: fix memory leak in ext4_mb_init_backend on error path.

Pu Wen (1):
      x86/sev: Check SME/SEV support in CPUID first

Qiheng Lin (1):
      soc: amlogic: meson-clk-measure: remove redundant dev_err call
in meson_msr_probe()

Qu Wenruo (1):
      btrfs: fix compressed writes that cross stripe boundary

Rahul Lakkireddy (2):
      cxgb4: fix regression with HASH tc prio value update
      cxgb4: avoid link re-train during TC-MQPRIO configuration

Randy Dunlap (1):
      vfio/pci: zap_vma_ptes() needs MMU

Rasmus Villemoes (1):
      efi: cper: fix snprintf() use in cper_dimm_err_location()

Riccardo Mancini (2):
      perf symbol-elf: Fix memory leak by freeing sdt_note.args
      perf env: Fix memory leak of bpf_prog_info_linear member

Ritesh Harjani (1):
      ext4: fix accessing uninit percpu counter variable with fast_commit

Rodrigo Siqueira (1):
      drm/amd/display: Fix overlay validation by considering cursors

Roi Dayan (3):
      net/mlx5e: Disable TLS offload for uplink representor
      net/mlx5e: Check for needed capability for cvlan matching
      net/mlx5e: Fix adding encap rules to slow path

Roja Rani Yarubandi (2):
      i2c: qcom-geni: Add shutdown callback for i2c
      i2c: qcom-geni: Suspend and resume the bus during SYSTEM_SLEEP_PM ops

Roman Li (1):
      drm/amd/display: Fix potential memory leak in DMUB hw_init

Saeed Mirzamohammadi (1):
      HID: quirks: Add quirk for Lenovo optical mouse

Sagi Grimberg (1):
      nvme-rdma: fix in-casule data send for chained sgls

Simon Ser (1):
      amd/display: convert DRM_DEBUG_ATOMIC to drm_dbg_atomic

Srinivas Pandruvada (2):
      HID: hid-sensor-hub: Return error for hid_set_field() failure
      HID: hid-sensor-custom: Process failure of sensor_hub_set_feature()

Sriranjani P (1):
      net: stmmac: fix kernel panic due to NULL pointer dereference of
mdio_bus_data

Stanley Chu (1):
      scsi: ufs: ufs-mediatek: Fix HCI version in some platforms

Stefan Binding (1):
      ALSA: hda/cirrus: Set Initial DMIC volume to -26 dB

Takashi Iwai (2):
      ALSA: hda: Fix a regression in Capture Switch mixer read
      ALSA: timer: Fix master timer notification

Thierry Reding (3):
      gpu: host1x: Split up client initalization and registration
      drm/tegra: sor: Fully initialize SOR before registration
      drm/tegra: sor: Fix AUX device reference leak

Thomas Bogendoerfer (1):
      Revert "MIPS: make userspace mapping young by default"

Thomas Gleixner (2):
      x86/apic: Mark _all_ legacy interrupts when IO/APIC is missing
      x86/cpufeatures: Force disable X86_FEATURE_ENQCMD and remove
update_pasid()

Thomas Richter (1):
      perf test: Test 17 fails with make LIBPFM4=3D1 on s390 z/VM

Tiezhu Yang (1):
      perf tools: Copy uapi/asm/perf_regs.h from the kernel for MIPS

Tom Rix (1):
      HID: logitech-hidpp: initialize level variable

Tomi Valkeinen (1):
      arm64: dts: ti: k3-am654-base-board: remove ov5640

Tony Lindgren (3):
      bus: ti-sysc: Fix missing quirk flags for sata
      bus: ti-sysc: Fix am335x resume hang for usb otg module
      bus: ti-sysc: Fix flakey idling of uarts and stop using swsup_sidle_a=
ct

Victor Zhao (1):
      drm/amd/amdgpu:save psp ring wptr to avoid attack

Vignesh Raghavendra (1):
      arm64: dts: ti: j7200-main: Mark Main NAVSS as dma-coherent

Vincent (1):
      riscv: skip errata_cip_453.o if CONFIG_ERRATA_SIFIVE_CIP_453 is disab=
led

Vladimir Oltean (1):
      net: dsa: tag_8021q: fix the VLAN IDs used for encoding sub-VLANs

V=C3=A1clav Kubern=C3=A1t (1):
      hwmon: (pmbus/fsp-3y) Fix FSP-3Y YH-5151E VOUT

Wei Yongjun (3):
      HID: thrustmaster: fix return value check in thrustmaster_probe()
      samples: vfio-mdev: fix error handing in mdpy_fb_probe()
      ieee802154: fix error return code in ieee802154_llsec_getparams()

Wende Tan (1):
      RISC-V: Fix memblock_free() usages in init_resources()

Wong Vee Khee (1):
      net: stmmac: fix issue where clk is being unprepared twice

Xuan Zhuo (3):
      virtio-net: fix for unable to handle page fault for address
      virtio_net: get build_skb() buf by data ptr
      virtio-net: fix for skb_over_panic inside big mode

Yang Li (1):
      net/ieee802154: drop unneeded assignment in llsec_iter_devkeys()

Ye Bin (1):
      ext4: fix bug on in ext4_es_cache_extent as ext4_split_extent_at fail=
ed

Ye Xiang (1):
      HID: intel-ish-hid: ipc: Add Alder Lake device IDs

Yevgeny Kliteynik (1):
      net/mlx5: DR, Create multi-destination flow table with level less tha=
n 64

Yongqiang Liu (1):
      ARM: OMAP2+: Fix build warning when mmc_omap is not built

Yu Kuai (2):
      perf stat: Fix error return code in bperf__load()
      mm/kasan/init.c: fix doc warning

YueHaibing (1):
      lib: crc64: fix kernel-doc warning

Yunjian Wang (1):
      sch_htb: fix refcount leak in htb_parent_to_leaf_offload

Zhen Lei (3):
      vfio/pci: Fix error return code in vfio_ecap_init()
      HID: pidff: fix error return code in hid_pidff_init()
      ieee802154: fix error return code in ieee802154_add_iface()

Zheng Yongjun (3):
      net/x25: Return the correct errno code
      net: Return the correct errno code
      fib: Return the correct errno code

Zhihao Cheng (1):
      drm/i915/selftests: Fix return value check in live_breadcrumbs_smoket=
est()

zhang kai (1):
      sit: set name of device back to struct parms

      HID: multitouch: Disable event reporting on suspend on the Asus
T101HA touchpad
      HID: asus: Cleanup Asus T101HA keyboard-dock handling

Harshad Shirwadkar (1):
      ext4: fix fast commit alignment issues

Heiner Kallweit (1):
      efi: Allow EFI_MEMORY_XP and EFI_MEMORY_RO both to be cleared

Hillf Danton (1):
      gfs2: Fix use-after-free in gfs2_glock_shrink_scan

Hui Wang (1):
      ALSA: hda: update the power_state during the direct-complete

James Smart (1):
      scsi: lpfc: Fix failure to transmit ABTS on FC link

Jan Kara (1):
      MAINTAINERS: Add Matthew Bobrowski as a reviewer

Jason A. Donenfeld (9):
      wireguard: selftests: remove old conntrack kconfig value
      wireguard: selftests: make sure rp_filter is disabled on vethc
      wireguard: do not use -O3
      wireguard: use synchronize_net rather than synchronize_rcu
      wireguard: peer: allocate in kmem_cache
      wireguard: allowedips: initialize list head in selftest
      wireguard: allowedips: remove nodes in O(1)
      wireguard: allowedips: allocate nodes in kmem_cache
      wireguard: allowedips: free empty intermediate nodes when
removing single node

Javier Martinez Canillas (1):
      kbuild: Quote OBJCOPY var to avoid a pahole call break the build

Jean-Philippe Brucker (1):
      PCI/MSI: Fix MSIs for generic hosts that use device-tree's "msi-map"

Jens Wiklander (1):
      optee: use export_uuid() to copy client UUID

Jerome Brunet (1):
      arm64: meson: select COMMON_CLK

Jiansong Chen (1):
      drm/amdgpu: refine amdgpu_fru_get_product_info

Jiapeng Chong (2):
      ethernet: myri10ge: Fix missing error code in myri10ge_probe()
      rtnetlink: Fix missing error code in rtnl_bridge_notify()

Jiashuo Liang (1):
      x86/fault: Don't send SIGSEGV twice on SEGV_PKUERR

Jisheng Zhang (1):
      riscv: mm: Fix W+X mappings at boot

Joe Perches (1):
      MAINTAINERS: nfc mailing lists are subscribers-only

Johan Hovold (1):
      HID: magicmouse: fix NULL-deref on disconnect

Johnny Chuang (1):
      HID: i2c-hid: Skip ELAN power-on command after reset

Josef Bacik (6):
      btrfs: fix error handling in btrfs_del_csums
      btrfs: return errors from btrfs_del_csums in cleanup_ref_head
      btrfs: mark ordered extent and inode with error if we fail to finish
      btrfs: fixup error handling in fixup_inode_link_counts
      btrfs: check error value from btrfs_update_inode in tree log
      btrfs: abort in rename_exchange if we fail to insert the second ref

Josh Triplett (1):
      net: ipconfig: Don't override command-line hostnames or domains

Jos=C3=A9 Exp=C3=B3sito (1):
      HID: magicmouse: fix crash when disconnecting Magic Trackpad 2

Julian Anastasov (1):
      ipvs: ignore IP_VS_SVC_F_HASHED flag when adding service

Junxiao Bi (1):
      ocfs2: fix data corruption by fallocate

Kai Vehmanen (1):
      ALSA: hda: Add AlderLake-M PCI ID

Khem Raj (1):
      riscv: Use -mno-relax when using lld linker

Krzysztof Kozlowski (1):
      nfc: fix NULL ptr dereference in llcp_sock_getname() after failed con=
nect

Kurt Kanzenbach (1):
      igb: Fix XDP with PTP enabled

Larry Finger (1):
      Bluetooth: Add a new USB ID for RTL8822CE

Lee Jones (2):
      i2c: altera: Fix formatting issue in struct and demote unworthy
kernel-doc headers
      i2c: tegra-bpmp: Demote kernel-doc abuses

Li Huafei (1):
      perf probe: Fix NULL pointer dereference in convert_variable_location=
()

Lin Ma (2):
      Bluetooth: fix the erroneous flush_work() order
      Bluetooth: use correct lock to prevent UAF of hdev object

Linus Torvalds (1):
      Linux 5.13-rc5

Lorenzo Bianconi (4):
      mt76: mt7921: fix possible AOOB issue in mt7921_mcu_tx_rate_report
      mt76: connac: do not schedule mac_work if the device is not running
      mt76: mt76x0e: fix device hang during suspend/resume
      mt76: mt7615: do not set MT76_STATE_PM at bootstrap

Lorenzo Pieralisi (1):
      MAINTAINERS: Add Krzysztof as PCI host/endpoint controllers reviewer

Luben Tuikov (1):
      drm/amdgpu: Don't query CE and UE errors

Lucas Stach (2):
      arm64: dts: zii-ultra: remove second GEN_3V3 regulator instance
      arm64: dts: zii-ultra: fix 12V_MAIN voltage

Luiz Augusto von Dentz (1):
      Bluetooth: btusb: Fix failing to init controllers with operation firm=
ware

Luke D Jones (2):
      HID: asus: Filter keyboard EC for old ROG keyboard
      HID: asus: filter G713/G733 key event to prevent shutdown

Lyude Paul (1):
      drm/tegra: Get ref for DP AUX channel, not its ddc adapter

Maciej Falkowski (3):
      ARM: OMAP1: Fix use of possibly uninitialized irq variable
      ARM: OMAP1: isp1301-omap: Add missing gpiod_add_lookup_table function
      ARM: OMAP1: ams-delta: remove unused function ams_delta_camera_power

Maciej Fijalkowski (1):
      ice: track AF_XDP ZC enabled queues in bitmap

Magnus Karlsson (6):
      i40e: add correct exception tracing for XDP
      ice: add correct exception tracing for XDP
      ixgbe: add correct exception tracing for XDP
      igb: add correct exception tracing for XDP
      ixgbevf: add correct exception tracing for XDP
      igc: add correct exception tracing for XDP

Marcel Holtmann (1):
      Bluetooth: Fix VIRTIO_ID_BT assigned number

Marco Elver (1):
      kfence: use TASK_IDLE when awaiting allocation

Marek Vasut (1):
      ARM: dts: imx6q-dhcom: Add PU,VDD1P1,VDD2P5 regulators

Mark Bolhuis (1):
      HID: Add BUS_VIRTUAL to hid_connect logging

Mark Rutland (1):
      pid: take a reference when initializing `cad_pid`

Mateusz Jo=C5=84czyk (1):
      HID: a4tech: use A4_2WHEEL_MOUSE_HACK_B8 for A4TECH NB-95

Matthew Auld (1):
      Revert "i915: use io_mapping_map_user"

Matthew Wilcox (1):
      Revert "fb_defio: Remove custom address_space_operations"

Maurizio Lombardi (1):
      scsi: target: core: Fix warning on realtime kernels

Max Gurtovoy (2):
      vfio/platform: fix module_put call in error flow
      nvmet: fix freeing unallocated p2pmem

Maxim Mikityanskiy (2):
      net/tls: Replace TLS_RX_SYNC_RUNNING with RCU
      net/tls: Fix use-after-free after the TLS device goes down and up

Maximilian Luz (1):
      HID: surface-hid: Fix integer endian conversion

Michael Walle (3):
      arm64: dts: ls1028a: fix memory node
      arm64: dts: freescale: sl28: var4: fix RGMII clock and voltage
      arm64: dts: freescale: sl28: var1: fix RGMII clock and voltage

Michael Zaidman (2):
      HID: ft260: check data size in ft260_smbus_write()
      HID: ft260: improve error handling of ft260_hid_feature_report_get()

Michal Vok=C3=A1=C4=8D (1):
      ARM: dts: imx6dl-yapp4: Fix RGMII connection to QCA8334 switch

Michel Lespinasse (1):
      mailmap: use private address for Michel Lespinasse

Mike Rapoport (1):
      x86/setup: Always reserve the first 1M of RAM

Mina Almasry (1):
      mm, hugetlb: fix simple resv_huge_pages underflow on UFFDIO_COPY

Moshe Shemesh (1):
      net/mlx5: Check firmware sync reset requested is set before
trying to abort it

Namhyung Kim (3):
      perf record: Move probing cgroup sampling support
      perf evsel: Add missing cloning of evsel->use_config_name
      perf stat: Honor event config name on --no-merge

Naoya Horiguchi (1):
      hugetlb: pass head page to remove_hugetlb_page()

Nathan Chancellor (1):
      drm/tegra: Fix shift overflow in tegra_shared_plane_atomic_update

Naveen N. Rao (1):
      powerpc/kprobes: Fix validation of prefixed instructions across
page boundary

Nicholas Kazlauskas (1):
      drm/amd/display: Fix GPU scaling regression by FS video support

Nicholas Piggin (2):
      powerpc: Fix reverse map real-mode address lookup with huge vmalloc
      KVM: PPC: Book3S HV: Save host FSCR in the P7/8 path

Nirenjan Krishnan (1):
      HID: quirks: Set INCREMENT_USAGE_ON_DUPLICATE for Saitek X65

Nirmoy Das (1):
      drm/amdgpu: make sure we unpin the UVD BO

Nishanth Menon (6):
      arm64: dts: ti: k3-*: Rename the TI-SCI clocks node name
      arm64: dts: ti: k3-am65-wakeup: Add debug region to TI-SCI node
      arm64: dts: ti: k3-am65-wakeup: Drop un-necessary properties
from dmsc node
      arm64: dts: ti: k3-*: Rename the TI-SCI node
      arm64: dts: ti: k3-am65|j721e|am64: Map the dma / navigator
subsystem via explicit ranges
      arm64: dts: ti: k3*: Introduce reg definition for interrupt routers

Pablo Neira Ayuso (5):
      netfilter: nf_tables: missing error reporting for not selected expres=
sions
      netfilter: nf_tables: extended netlink error reporting for chain type
      netfilter: nf_tables: fix table flag updates
      netfilter: nft_ct: skip expectations for confirmed conntrack
      netfilter: nfnetlink_cthelper: hit EBUSY on updates if size mismatche=
s

Paolo Abeni (4):
      mptcp: fix sk_forward_memory corruption on retransmission
      mptcp: always parse mptcp options for MPC reqsk
      mptcp: do not reset MP_CAPABLE subflow on mapping errors
      mptcp: update selftest for fallback due to OoO

Parav Pandit (1):
      devlink: Correct VIRTUAL port to not have phys_port attributes

Paul Blakey (1):
      net/sched: act_ct: Offload connections with commit action

Paul Greenwalt (1):
      ice: report supported and advertised autoneg using PHY capabilities

Pavel Begunkov (1):
      io_uring: fix misaccounting fix buf pinned pages

Pavel Machek (CIP) (1):
      drm/tegra: sor: Do not leak runtime PM reference

Pavel Skripkin (5):
      net: kcm: fix memory leak in kcm_sendmsg
      net: caif: added cfserl_release function
      net: caif: add proper error handling
      net: caif: fix memory leak in caif_device_notify
      net: caif: fix memory leak in cfusbl_device_notify

Phillip Potter (1):
      ext4: fix memory leak in ext4_mb_init_backend on error path.

Pu Wen (1):
      x86/sev: Check SME/SEV support in CPUID first

Qiheng Lin (1):
      soc: amlogic: meson-clk-measure: remove redundant dev_err call
in meson_msr_probe()

Qu Wenruo (1):
      btrfs: fix compressed writes that cross stripe boundary

Rahul Lakkireddy (2):
      cxgb4: fix regression with HASH tc prio value update
      cxgb4: avoid link re-train during TC-MQPRIO configuration

Randy Dunlap (1):
      vfio/pci: zap_vma_ptes() needs MMU

Rasmus Villemoes (1):
      efi: cper: fix snprintf() use in cper_dimm_err_location()

Riccardo Mancini (2):
      perf symbol-elf: Fix memory leak by freeing sdt_note.args
      perf env: Fix memory leak of bpf_prog_info_linear member

Ritesh Harjani (1):
      ext4: fix accessing uninit percpu counter variable with fast_commit

Rodrigo Siqueira (1):
      drm/amd/display: Fix overlay validation by considering cursors

Roi Dayan (3):
      net/mlx5e: Disable TLS offload for uplink representor
      net/mlx5e: Check for needed capability for cvlan matching
      net/mlx5e: Fix adding encap rules to slow path

Roja Rani Yarubandi (2):
      i2c: qcom-geni: Add shutdown callback for i2c
      i2c: qcom-geni: Suspend and resume the bus during SYSTEM_SLEEP_PM ops

Roman Li (1):
      drm/amd/display: Fix potential memory leak in DMUB hw_init

Saeed Mirzamohammadi (1):
      HID: quirks: Add quirk for Lenovo optical mouse

Sagi Grimberg (1):
      nvme-rdma: fix in-casule data send for chained sgls

Simon Ser (1):
      amd/display: convert DRM_DEBUG_ATOMIC to drm_dbg_atomic

Srinivas Pandruvada (2):
      HID: hid-sensor-hub: Return error for hid_set_field() failure
      HID: hid-sensor-custom: Process failure of sensor_hub_set_feature()

Sriranjani P (1):
      net: stmmac: fix kernel panic due to NULL pointer dereference of
mdio_bus_data

Stanley Chu (1):
      scsi: ufs: ufs-mediatek: Fix HCI version in some platforms

Stefan Binding (1):
      ALSA: hda/cirrus: Set Initial DMIC volume to -26 dB

Takashi Iwai (2):
      ALSA: hda: Fix a regression in Capture Switch mixer read
      ALSA: timer: Fix master timer notification

Thierry Reding (3):
      gpu: host1x: Split up client initalization and registration
      drm/tegra: sor: Fully initialize SOR before registration
      drm/tegra: sor: Fix AUX device reference leak

Thomas Bogendoerfer (1):
      Revert "MIPS: make userspace mapping young by default"

Thomas Gleixner (2):
      x86/apic: Mark _all_ legacy interrupts when IO/APIC is missing
      x86/cpufeatures: Force disable X86_FEATURE_ENQCMD and remove
update_pasid()

Thomas Richter (1):
      perf test: Test 17 fails with make LIBPFM4=3D1 on s390 z/VM

Tiezhu Yang (1):
      perf tools: Copy uapi/asm/perf_regs.h from the kernel for MIPS

Tom Rix (1):
      HID: logitech-hidpp: initialize level variable

Tomi Valkeinen (1):
      arm64: dts: ti: k3-am654-base-board: remove ov5640

Tony Lindgren (3):
      bus: ti-sysc: Fix missing quirk flags for sata
      bus: ti-sysc: Fix am335x resume hang for usb otg module
      bus: ti-sysc: Fix flakey idling of uarts and stop using swsup_sidle_a=
ct

Victor Zhao (1):
      drm/amd/amdgpu:save psp ring wptr to avoid attack

Vignesh Raghavendra (1):
      arm64: dts: ti: j7200-main: Mark Main NAVSS as dma-coherent

Vincent (1):
      riscv: skip errata_cip_453.o if CONFIG_ERRATA_SIFIVE_CIP_453 is disab=
led

Vladimir Oltean (1):
      net: dsa: tag_8021q: fix the VLAN IDs used for encoding sub-VLANs

V=C3=A1clav Kubern=C3=A1t (1):
      hwmon: (pmbus/fsp-3y) Fix FSP-3Y YH-5151E VOUT

Wei Yongjun (3):
      HID: thrustmaster: fix return value check in thrustmaster_probe()
      samples: vfio-mdev: fix error handing in mdpy_fb_probe()
      ieee802154: fix error return code in ieee802154_llsec_getparams()

Wende Tan (1):
      RISC-V: Fix memblock_free() usages in init_resources()

Wong Vee Khee (1):
      net: stmmac: fix issue where clk is being unprepared twice

Xuan Zhuo (3):
      virtio-net: fix for unable to handle page fault for address
      virtio_net: get build_skb() buf by data ptr
      virtio-net: fix for skb_over_panic inside big mode

Yang Li (1):
      net/ieee802154: drop unneeded assignment in llsec_iter_devkeys()

Ye Bin (1):
      ext4: fix bug on in ext4_es_cache_extent as ext4_split_extent_at fail=
ed

Ye Xiang (1):
      HID: intel-ish-hid: ipc: Add Alder Lake device IDs

Yevgeny Kliteynik (1):
      net/mlx5: DR, Create multi-destination flow table with level less tha=
n 64

Yongqiang Liu (1):
      ARM: OMAP2+: Fix build warning when mmc_omap is not built

Yu Kuai (2):
      perf stat: Fix error return code in bperf__load()
      mm/kasan/init.c: fix doc warning

YueHaibing (1):
      lib: crc64: fix kernel-doc warning

Yunjian Wang (1):
      sch_htb: fix refcount leak in htb_parent_to_leaf_offload

Zhen Lei (3):
      vfio/pci: Fix error return code in vfio_ecap_init()
      HID: pidff: fix error return code in hid_pidff_init()
      ieee802154: fix error return code in ieee802154_add_iface()

Zheng Yongjun (3):
      net/x25: Return the correct errno code
      net: Return the correct errno code
      fib: Return the correct errno code

Zhihao Cheng (1):
      drm/i915/selftests: Fix return value check in live_breadcrumbs_smoket=
est()

zhang kai (1):
      sit: set name of device back to struct parms
