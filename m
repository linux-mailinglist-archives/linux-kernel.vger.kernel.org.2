Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B2C431042
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 08:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhJRGRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 02:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhJRGRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 02:17:30 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689B8C06161C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 23:15:19 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g36so48399726lfv.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 23:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=cKJkk6mQLF0Z2IaeIvmDwnwNSAoukj6QlskiGZnXNrY=;
        b=hrZ7xd1QYE+DMagk/6Wik3MwtOEgPNK4lyElUE4tz9OTEv5QqoGv6REcTA4+m0aUxN
         EsYTct4gdoMTRcDLasLdfYJkepy8FT2l4mZ7Il2QACEi6FjhsXb7WlPPWXm86cjJDJKQ
         06gN/TGM+XjYNMySjt7H+bW30ABl/XfCMlISM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=cKJkk6mQLF0Z2IaeIvmDwnwNSAoukj6QlskiGZnXNrY=;
        b=Ik67D0k5vrq0oKnWZvPWIqP6Gr4RBnB1vf7+cwyu2LrOKpxS9mYkzhOH20/OyAF/Hw
         0pTCapHrVIV96trGRH1GLFyXJAc3ODRAp2Z7W6zOitohus20xDGcIaKmpUpG2ffQ0Czo
         MUSPx6cjX/YQWgXKvX3ETcQYEoGD/oG/8z+SVb9Z0Gh7lK/iGh9JuQ8YcYMvq5BUGVmG
         cbMduZ5oqsh8cFe71BBUr6GPzWaNdFiBtPqMC56U9QxMNR7Chpr9F2CtrePf/nGlSnkj
         BN6Ump3qYAtN1+4NERc+vUP/ql49cFsBAOaVTon5oPcUpx56+vQhProkuXJOd0YWV7H+
         UZ7w==
X-Gm-Message-State: AOAM530529x9N9IIl64GtzcDXHuED5DdG4MQYy8x4i8eGRsFeepMq5k/
        As5XA6tsjusCcBkFlPLduxcvmfqH4qlRJw3k
X-Google-Smtp-Source: ABdhPJxepBlDOQoTpyTnhNqm5Z7bxf6qgYihQQ34jQfcfjhJ+mj+RgZ+YT+vsgWZcb+BIo0WEEY83w==
X-Received: by 2002:a05:6512:ba6:: with SMTP id b38mr26785436lfv.355.1634537717076;
        Sun, 17 Oct 2021 23:15:17 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 189sm1504321ljj.113.2021.10.17.23.15.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Oct 2021 23:15:16 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id p16so65283923lfa.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 23:15:16 -0700 (PDT)
X-Received: by 2002:a05:6512:710:: with SMTP id b16mr324757lfs.141.1634537715882;
 Sun, 17 Oct 2021 23:15:15 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Oct 2021 20:14:59 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjbXW13Eh6YnB4C5ghLrhJCq0u2bpSNA0JbK8eDb6o_XA@mail.gmail.com>
Message-ID: <CAHk-=wjbXW13Eh6YnB4C5ghLrhJCq0u2bpSNA0JbK8eDb6o_XA@mail.gmail.com>
Subject: Linux 5.15-rc6
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So here we are, slightly later on a Sunday than usual due to travel,
but rc6 is out.

I'd love to say that it's all looking average, but rc6 is actually
bigger han rc5 was, and larger than normal for this time in the
release cycle.

It's not _enormously_ larger than normal, and it's not the largest rc6
we've had, but it's still slightly worrisome. By rc6 I really do
expect things to have started calming down.

I'm hoping it's just one of those random timing effects, with a couple
of slightly bigger pulls having come in the last week, and we'll see
the next week being extra quiet because rc6 got some of the stuff that
would normally have hit rc7. It happens. But let's see how this goes.

The 5.15 cycle over-all remains one of the smaller cycles (at least
counting commits), so I wouldn't have expected this to be one that
requires an extra rc, but that may be what ends up happening unless
the upcoming week is really nice and calm.

That said, nothing in here looks _particularly_ worrisome. It really
smells like just random timing effects to me, with networking, GPU
drivers, and ntfs3 all having had a somewhat active week.  Other than
that it all really looks fairly normal.

Full details in the shortlog below.

Please give it a whirl. And let's hope for a nice calm next week and a
smaller rc7.

              Linus

---

Adam Manzanares (1):
      nvme: fix per-namespace chardev deletion

Akilesh Kailash (1):
      dm verity: skip redundant verity_handle_err() on I/O errors

Al Viro (1):
      csky: don't let sigreturn play with priveleged bits of status registe=
r

Aleksander Morgado (1):
      USB: serial: qcserial: add EM9191 QDL support

Alexander Usyskin (1):
      mei: hbm: drop hbm responses on early shutdown

Alexandru Tachici (3):
      iio: adc: ad7192: Add IRQ flag
      iio: adc: ad7780: Fix IRQ flag
      iio: adc: ad7793: Fix IRQ flag

Alexey Bayduraev (1):
      perf report: Output non-zero offset for decompressed records

Alvin =C5=A0ipraga (1):
      net: dsa: fix spurious error message when unoffloaded port leaves bri=
dge

Andy Shevchenko (3):
      mei: me: add Ice Lake-N device id.
      gpio: pca953x: Improve bias setting
      gpio: mockup: Convert to use software nodes

Apurva Nandan (1):
      spi: Use 'flash' node name instead of 'spi-flash' in example

Ard Biesheuvel (1):
      efi/cper: use stack buffer for error record decoding

Arnd Bergmann (8):
      module: fix clang CFI with MODULE_UNLOAD=3Dn
      drm/msm/submit: fix overflow check on 64-bit architectures
      staging: vc04_services: shut up out-of-range warning
      cb710: avoid NULL pointer subtraction
      bitfield: build kunit tests without structleak plugin
      iommu/arm: fix ARM_SMMU_QCOM compilation
      ethernet: s2io: fix setting mac address during resume
      eeprom: 93xx46: fix MODULE_DEVICE_TABLE

ArthurChiao (1):
      cgroupv2, docs: fix misinformation in "device controller" section

Arun Ramadoss (1):
      net: dsa: microchip: Added the condition for scheduling ksz_mib_read_=
work

Aya Levin (1):
      net/mlx5e: Mutually exclude RX-FCS and RX-port-timestamp

Baowen Zheng (1):
      nfp: flow_offload: move flow_indr_dev_register from app init to app s=
tart

Biju Das (2):
      clk: renesas: r9a07g044: Mark IA55_CLK and DMAC_ACLK critical
      clk: renesas: rzg2l: Fix clk status function

Billy Tsai (1):
      iio: adc: aspeed: set driver data when adc probe.

Borislav Petkov (2):
      x86/Kconfig: Do not enable AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT automati=
cally
      x86/fpu: Mask out the invalid MXCSR bits properly

Brendan Higgins (4):
      gcc-plugins/structleak: add makefile var for disabling structleak
      iio/test-format: build kunit tests without structleak plugin
      device property: build kunit tests without structleak plugin
      thunderbolt: build kunit tests without structleak plugin

Cai Huoqing (1):
      MAINTAINERS: Update the devicetree documentation path of imx fec driv=
er

Cameron Berkenpas (1):
      ALSA: hda/realtek: Fix for quirk to enable speaker output on the
Lenovo 13s Gen2

Chris Chiu (1):
      ALSA: hda - Enable headphone mic on Dell Latitude laptops with ALC325=
4

Christoph Hellwig (7):
      block: call submit_bio_checks under q_usage_counter
      block: factor out a blk_try_enter_queue helper
      block: split bio_queue_enter from blk_queue_enter
      block: drain file system I/O on del_gendisk
      block: keep q_usage_counter in atomic mode after del_gendisk
      kyber: avoid q->disk dereferences in trace points
      block: warn when putting the final reference on a registered disk

Christophe JAILLET (3):
      iio: adc128s052: Fix the error handling path of 'adc128_probe()'
      fs/ntfs3: Remove a useless test in 'indx_find()'
      fs/ntfs3: Remove a useless shadowing variable

Chun-Kuang Hu (5):
      Revert "drm/mediatek: Clear pending flag when cmdq packet is done"
      Revert "drm/mediatek: Add cmdq_handle in mtk_crtc"
      Revert "drm/mediatek: Detect CMDQ execution timeout"
      Revert "drm/mediatek: Remove struct cmdq_client"
      Revert "drm/mediatek: Use mailbox rx_callback instead of cmdq_task_cb=
"

Chunguang Xu (1):
      docs/cgroup: remove some duplicate words

Cindy Lu (1):
      vhost-vdpa: Fix the wrong input in config_cb

Colin Ian King (6):
      fs/ntfs3: Remove redundant initialization of variable err
      iio: adc: rzg2l_adc: Fix -EBUSY timeout error return
      fs/ntfs3: Fix a memory leak on object opts
      tracing: Fix missing * in comment block
      drm/msm: Fix null pointer dereference on pointer edp
      dm clone: make array 'descs' static

Cornelia Huck (2):
      KVM: s390: remove myself as reviewer
      vfio-ccw: step down as maintainer

C=C3=A9dric Le Goater (1):
      powerpc/xive: Discard disabled interrupts in get_irqchip_state()

Dafna Hirschfeld (1):
      spi: mediatek: skip delays if they are 0

Dan Carpenter (10):
      iio: dac: ti-dac5571: fix an error code in probe()
      iio: ssp_sensors: fix error code in ssp_print_mcu_debug()
      iio: ssp_sensors: add more range checking in ssp_parse_dataframe()
      staging: r8188eu: prevent array underflow in rtw_hal_update_ra_mask()
      drm/msm/a4xx: fix error handling in a4xx_gpu_init()
      drm/msm/a3xx: fix error handling in a3xx_gpu_init()
      drm/msm/dsi: Fix an error code in msm_dsi_modeset_init()
      drm/msm/dsi: fix off by one in dsi_bus_clk_enable error handling
      pata_legacy: fix a couple uninitialized variable bugs
      block/rnbd-clt-sysfs: fix a couple uninitialized variable bugs

Daniel Latypov (2):
      kunit: tool: better handling of quasi-bool args (--json, --raw_output=
)
      kunit: fix kernel-doc warnings due to mismatched arg names

Daniel Scally (1):
      platform/x86: intel_skl_int3472: Correct null check

Daniele Palmas (1):
      USB: serial: option: add Telit LE910Cx composition 0x1204

Dexuan Cui (1):
      drm/hyperv: Fix double mouse pointers

Dinh Nguyen (2):
      clk: socfpga: agilex: fix duplicate s2f_user0_clk
      MAINTAINERS: Update entry for the Stratix10 firmware

Dmitry Baryshkov (2):
      drm/msm/mdp5: fix cursor-related warnings
      drm/msm/dsi/phy: fix clock names in 28nm_8960 phy

Douglas Anderson (1):
      drm/edid: In connector_bad_edid() cap num_of_ext by num_blocks read

Eiichi Tsukata (1):
      sctp: account stream padding length for reconf chunk

Fabio Estevam (1):
      drm/msm: Do not run snapshot on non-DPU devices

Filipe Manana (5):
      btrfs: deal with errors when checking if a dir entry exists
during log replay
      btrfs: deal with errors when replaying dir entry during log replay
      btrfs: deal with errors when adding inode reference during log replay
      btrfs: unify lookup return value when dir entry is missing
      btrfs: check for error when looking up inode during dir entry replay

Florian Fainelli (1):
      net: phy: Do not shutdown PHYs in READY state

Guenter Roeck (3):
      csky: Select ARCH_WANT_FRAME_POINTERS only if compiler supports it
      csky: bitops: Remove duplicate __clear_bit define
      csky: Make HAVE_TCM depend on !COMPILE_TEST

Guo Ren (1):
      csky: Fixup regs.sr broken in ptrace

Haiyang Zhang (1):
      net: mana: Fix error handling in mana_create_rxq()

Halil Pasic (1):
      virtio: write back F_VERSION_1 before validate

Hans Potsch (1):
      EDAC/armada-xp: Fix output of uncorrectable error counter

Hans de Goede (1):
      platform/x86: dell: Make DELL_WMI_PRIVACY depend on DELL_WMI

Hao Xu (1):
      io_uring: fix wrong condition to grab uring lock

Heiko Carstens (1):
      s390: add Alexander Gordeev as reviewer

Heinrich Schuchardt (1):
      efi/libstub: Simplify "Exiting bootservices" message

Herve Codina (4):
      net: stmmac: fix get_hw_feature() on old hardware
      dt-bindings: net: snps,dwmac: add dwmac 3.40a IP version
      net: stmmac: add support for dwmac 3.40a
      ARM: dts: spear3xx: Fix gmac node

Hui Liu (1):
      iio: mtk-auxadc: fix case IIO_CHAN_INFO_PROCESSED

Hui Wang (1):
      ALSA: hda/realtek: Fix the mic type detection issue for ASUS G551JW

Ian Kent (1):
      kernfs: don't create a negative dentry if inactive node exists

Ido Schimmel (1):
      mlxsw: thermal: Fix out-of-bounds memory accesses

Jackie Liu (2):
      tracing: Fix missing osnoise tracer on max_latency
      acpi/arm64: fix next_platform_timer() section mismatch error

Jacob Keller (1):
      ice: fix locking for Tx timestamp tracking flush

Jiazi Li (1):
      dm: fix mempool NULL pointer race when completing IO

Jiri Valek - 2N (1):
      iio: light: opt3001: Fixed timeout error when 0 lux

Johan Hovold (3):
      serial: 8250: allow disabling of Freescale 16550 compile test
      USB: xhci: dbc: fix tty registration race
      workqueue: fix state-dump console deadlock

John Liu (1):
      ALSA: hda/realtek: Enable 4-speaker output for Dell Precision 5560 la=
ptop

Jonas Hahnfeld (1):
      ALSA: usb-audio: Add quirk for VF0770

Jonathan Bell (2):
      xhci: guard accesses to ep_state in xhci_endpoint_reset()
      xhci: add quirk for host controllers that don't update endpoint DCS

Josef Bacik (2):
      btrfs: update refs for any root except tree log roots
      btrfs: fix abort logic in btrfs_replace_file_extents

Justin Iurman (2):
      ipv6: ioam: move the check for undefined bits
      selftests: net: modify IOAM tests for undef bits

Kai Vehmanen (1):
      ALSA: hda: avoid write to STATESTS if controller is in reset

Kailang Yang (1):
      ALSA: hda/realtek - ALC236 headset MIC recording issue

Kamal Dasu (1):
      spi: bcm-qspi: clear MSPI spifie interrupt during probe

Kan Liang (1):
      perf/x86/msr: Add Sapphire Rapids CPU support

Kari Argillander (41):
      fs/ntfs3: Remove unnecesarry mount option noatime
      fs/ntfs3: Remove unnecesarry remount flag handling
      fs/ntfs3: Convert mount options to pointer in sbi
      fs/ntfs3: Use new api for mounting
      fs/ntfs3: Init spi more in init_fs_context than fill_super
      fs/ntfs3: Make mount option nohidden more universal
      fs/ntfs3: Add iocharset=3D mount option as alias for nls=3D
      fs/ntfs3: Rename mount option no_acs_rules > (no)acsrules
      fs/ntfs3: Show uid/gid always in show_options()
      fs/ntfs3. Add forward declarations for structs to debug.h
      fs/ntfs3: Add missing header files to ntfs.h
      fs/ntfs3: Add missing headers and forward declarations to ntfs_fs.h
      fs/ntfs3: Add missing header and guards to lib/ headers
      fs/ntfs3: Change right headers to bitfunc.c
      fs/ntfs3: Change right headers to upcase.c
      fs/ntfs3: Change right headers to lznt.c
      fs/ntfs3: Remove unneeded header files from c files
      fs/ntfs3: Limit binary search table size
      fs/ntfs3: Make binary search to search smaller chunks in beginning
      fs/ntfs3: Always use binary search with entry search
      fs/ntfs3: Remove '+' before constant in ni_insert_resident()
      fs/ntfs3: Place Comparisons constant right side of the test
      fs/ntfs3: Remove braces from single statment block
      fs/ntfs3: Remove tabs before spaces from comment
      fs/ntfs3: Fix ntfs_look_for_free_space() does only report -ENOSPC
      fs/ntfs3: Remove always false condition check
      fs/ntfs3: Use clamp/max macros instead of comparisons
      fs/ntfs3: Use min/max macros instated of ternary operators
      fs/ntfs3: Fix wrong error message $Logfile -> $UpCase
      fs/ntfs3: Change EINVAL to ENOMEM when d_make_root fails
      fs/ntfs3: Remove impossible fault condition in fill_super
      fs/ntfs3: Return straight without goto in fill_super
      fs/ntfs3: Remove unnecessary variable loading in fill_super
      fs/ntfs3: Use sb instead of sbi->sb in fill_super
      fs/ntfs3: Remove tmp var is_ro in ntfs_fill_super
      fs/ntfs3: Remove tmp pointer bd_inode in fill_super
      fs/ntfs3: Remove tmp pointer upcase in fill_super
      fs/ntfs3: Initialize pointer before use place in fill_super
      fs/ntfs3: Initiliaze sb blocksize only in one place + refactor
      Doc/fs/ntfs3: Fix rst format and make it cleaner
      fs/ntfs3: Remove deprecated mount options nls

Karsten Graul (1):
      net/smc: improved fix wait on already cleared link

Keith Busch (1):
      nvme-pci: Fix abort command id

Konstantin Komarov (25):
      fs/ntfs3: Fix insertion of attr in ni_ins_attr_ext
      fs/ntfs3: Change max hardlinks limit to 4000
      fs/ntfs3: Add sync flag to ntfs_sb_write_run and al_update
      fs/ntfs3: Fix logical error in ntfs_create_inode
      fs/ntfs3: Move ni_lock_dir and ni_unlock into ntfs_create_inode
      fs/ntfs3: Refactor ntfs_get_acl_ex for better readability
      fs/ntfs3: Pass flags to ntfs_set_ea in ntfs_set_acl_ex
      fs/ntfs3: Change posix_acl_equiv_mode to posix_acl_update_mode
      fs/ntfs3: Refactoring lock in ntfs_init_acl
      fs/ntfs3: Reject mount if boot's cluster size < media sector size
      fs/ntfs3: Refactoring of ntfs_init_from_boot
      fs/ntfs3: Check for NULL if ATTR_EA_INFO is incorrect
      fs/ntfs3: Use available posix_acl_release instead of
ntfs_posix_acl_release
      fs/ntfs3: Remove locked argument in ntfs_set_ea
      fs/ntfs3: Refactoring of ntfs_set_ea
      fs/ntfs3: Forbid FALLOC_FL_PUNCH_HOLE for normal files
      fs/ntfs3: Remove unnecessary functions
      fs/ntfs3: Keep prealloc for all types of files
      fs/ntfs3: Fix memory leak if fill_super failed
      fs/ntfs3: Rework ntfs_utf16_to_nls
      fs/ntfs3: Refactor ntfs_readlink_hlp
      fs/ntfs3: Refactor ntfs_create_inode
      fs/ntfs3: Refactor ni_parse_reparse
      fs/ntfs3: Refactor ntfs_read_mft
      fs/ntfs3: Check for NULL pointers in ni_try_remove_attr_list

Kuogee Hsieh (1):
      drm/msm/dp: only signal audio when disconnected detected at dp_pm_res=
ume

Laurent Pinchart (1):
      drm: rcar-du: Don't create encoder for unconnected LVDS outputs

Lin Ma (1):
      nfc: nci: fix the UAF of rf_conn_info object

Linus Torvalds (1):
      Linux 5.15-rc6

Luca Weiss (1):
      clk: qcom: add select QCOM_GDSC for SM6350

Lukas Bulwahn (1):
      MAINTAINERS: rectify entry for SY8106A REGULATOR DRIVER

Maarten Zanders (1):
      net: dsa: mv88e6xxx: don't use PHY_DETECT on internal PHY's

Marek Vasut (2):
      drm/msm: Avoid potential overflow in timeout_to_jiffies()
      drm/nouveau/fifo: Reinstate the correct engine bit programming

Marijn Suijten (1):
      drm/msm/dsi: dsi_phy_14nm: Take ready-bit into account in poll_for_re=
ady

Mark Brown (7):
      spi: spidev: Add SPI ID table
      fpga: ice40-spi: Add SPI device ID table
      misc: gehc: Add SPI ID table
      eeprom: at25: Add SPI ID table
      eeprom: 93xx46: Add SPI device ID table
      gpio: 74x164: Add SPI device ID table
      spi: Fix deadlock when adding SPI controllers on SPI buses

Masami Hiramatsu (1):
      bootconfig: init: Fix memblock leak in xbc_make_cmdline()

Mateusz Kwiatkowski (1):
      ARM: dts: bcm283x: Fix VEC address for BCM2711

Matthew Auld (1):
      drm/i915: remember to call i915_sw_fence_fini

Matthew Brost (1):
      drm/i915: Fix bug in user proto-context creation that leaked contexts

Maxim Mikityanskiy (1):
      net/mlx5e: Fix division by 0 in mlx5e_select_queue for representors

Md Sadre Alam (1):
      mtd: rawnand: qcom: Update code word value for raw read

Michael Cullen (1):
      Input: xpad - add support for another USB ID of Nacon GC-100

Michael Ellerman (2):
      KVM: PPC: Book3S HV: Fix stack handling in idle_kvm_start_guest()
      KVM: PPC: Book3S HV: Make idle_kvm_start_guest() return 0 if it
went to guest

Michael Forney (2):
      objtool: Check for gelf_update_rel[a] failures
      objtool: Update section header before relocations

Michael S. Tsirkin (1):
      Revert "virtio-blk: Add validation for block size in config space"

Michael Walle (1):
      spi: spi-nxp-fspi: don't depend on a specific node name erratum worka=
round

Mike Kravetz (1):
      arm64/hugetlb: fix CMA gigantic page order for non-4K PAGE_SIZE

Mike Rapoport (1):
      memblock: exclude NOMAP regions from kmemleak

Ming Lei (1):
      dm rq: don't queue request to blk-mq during DM suspend

Miquel Raynal (3):
      iio: adc: max1027: Fix wrong shift with 12-bit devices
      iio: adc: max1027: Fix the number of max1X31 channels
      usb: musb: dsps: Fix the probe error path

Moritz Fischer (2):
      MAINTAINERS: Add Hao and Yilun as maintainers
      MAINTAINERS: Drop outdated FPGA Manager website

Nanyong Sun (1):
      net: encx24j600: check error in devm_regmap_init_encx24j600

Nathan Chancellor (1):
      Input: touchscreen - avoid bitwise vs logical OR warning

Nicolas Saenz Julienne (2):
      ARM: dts: bcm2711-rpi-4-b: Fix pcie0's unit address formatting
      ARM: dts: bcm2711-rpi-4-b: Fix usb's unit address

Nikolay Martynov (1):
      xhci: Enable trust tx length quirk for Fresco FL11 USB controller

Nuno S=C3=A1 (2):
      iio: adis16475: fix deadlock on frequency set
      iio: adis16480: fix devices that do not support sleep mode

Oleksij Rempel (1):
      Input: resistive-adc-touch - fix division by zero error on z1 =3D=3D =
0

Paolo Abeni (1):
      mptcp: fix possible stall on recvmsg()

Paolo Valente (1):
      block, bfq: reset last_bfqq_created on group change

Pavankumar Kondeti (1):
      xhci: Fix command ring pointer corruption while aborting a command

Philipp Zabel (1):
      ARM: imx: register reset controller from a platform driver

Prashant Malani (3):
      platform/x86: intel_scu_ipc: Fix busy loop expiry time
      platform/x86: intel_scu_ipc: Increase virtual timeout to 10s
      platform/x86: intel_scu_ipc: Update timeout value in comment

Qu Wenruo (1):
      btrfs: unlock newly allocated extent buffer after error

Rajaravi Krishna Katta (1):
      habanalabs: fix resetting args in wait for CS IOCTL

Randy Dunlap (3):
      misc: HI6421V600_IRQ should depend on HAS_IOMEM
      VDUSE: fix documentation underline warning
      drm/r128: fix build for UML

Rob Clark (5):
      drm/msm: Fix crash on dev file close
      drm/msm/a6xx: Serialize GMU communication
      drm/msm/a6xx: Track current ctx by seqno
      drm/msm: A bit more docs + cleanup
      drm/msm: One sched entity per process per priority

Robert Foss (1):
      drm/msm/dpu: Fix address of SM8150 PINGPONG5 IRQ register

Roberto Sassu (1):
      s390: fix strrchr() implementation

Rolf Eike Beer (1):
      workqueue: annotate alloc_workqueue() as printf

Sachi King (2):
      platform/x86: amd-pmc: Add alternative acpi id for PMC controller
      ACPI: PM: Include alternate AMDI0005 id in special behaviour

Saeed Mahameed (1):
      net/mlx5e: Switchdev representors are not vlan challenged

Saravana Kannan (3):
      driver core: Reject pointless SYNC_STATE_ONLY device links
      drivers: bus: simple-pm-bus: Add support for probing simple bus
only devices
      drivers: bus: Delete CONFIG_SIMPLE_PM_BUS

Sean Nyekjaer (1):
      iio: accel: fxls8962af: return IRQ_HANDLED when fifo is flushed

Sebastian Andrzej Siewior (1):
      mqprio: Correct stats in mqprio_dump_class_stats().

Shannon Nelson (1):
      ionic: don't remove netdev->dev_addr when syncing uc list

Shawn Guo (1):
      clk: qcom: gcc-sm6115: Fix offset for hlos1_vote_turing_mmu_tbu0_gdsc

Shay Drory (1):
      net/mlx5: Fix cleanup of bridge delayed work

Shravan S (1):
      platform/x86: int1092: Fix non sequential device mode handling

Shunsuke Nakamura (2):
      libperf test evsel: Fix build error on !x86 architectures
      libperf tests: Fix test_stat_cpu

Srinivas Kandagatla (1):
      misc: fastrpc: Add missing lock before accessing find_vma()

Stefan Wahren (2):
      ARM: dts: bcm2711: fix MDIO #address- and #size-cells
      ARM: dts: bcm2711-rpi-4-b: fix sd_io_1v8_reg regulator states

Stephan Gerhold (1):
      drm/msm: Fix devfreq NULL pointer dereference on a3xx

Stephen Boyd (2):
      af_unix: Rename UNIX-DGRAM to UNIX to maintain backwards compatabilit=
y
      nvmem: Fix shift-out-of-bound (UBSAN) with byte size cells

Steven Rostedt (1):
      nds32/ftrace: Fix Error: invalid operands (*UND* and *UND*
sections) for `^'

Steven Rostedt (VMware) (2):
      tracing: Fix event probe removal from dynamic events
      selftests/ftrace: Update test for more eprobe removal process

Sudeep Holla (2):
      firmware: arm_ffa: Add missing remove callback to ffa_bus_type
      firmware: arm_ffa: Fix __ffa_devices_unregister

Sumit Garg (1):
      tee: optee: Fix missing devices unregister during optee_remove

Takashi Iwai (5):
      ALSA: usb-audio: Fix a missing error check in scarlett gen2 mixer
      ALSA: seq: Fix a potential UAF by wrong private_free call order
      ALSA: usb-audio: Enable rate validation for Scarlett devices
      ALSA: hda: intel: Allow repeatedly probing on codec configuration err=
ors
      ALSA: pcm: Workaround for a wrong offset in SYNC_PTR compat ioctl

Tariq Toukan (1):
      net/mlx5e: Allow only complete TXQs partition in MQPRIO channel mode

Tetsuo Handa (1):
      brd: reduce the brd_devices_mutex scope

Thomas Zimmermann (1):
      drm/fbdev: Clamp fbdev surface size if too large

Tomaz Solc (1):
      USB: serial: option: add prod. id for Quectel EG91

Uwe Kleine-K=C3=B6nig (2):
      spi-mux: Fix false-positive lockdep splats
      Input: snvs_pwrkey - add clk handling

Vadim Pasternak (2):
      platform/mellanox: mlxreg-io: Fix argument base in kstrtou32() call
      platform/mellanox: mlxreg-io: Fix read access of n-bytes size attribu=
tes

Valentine Fatiev (1):
      net/mlx5e: Fix memory leak in mlx5_core_destroy_cq() error path

Vamshi K Sthambamkadi (1):
      tracing: Fix memory leak in eprobe_register()

Vegard Nossum (4):
      r8152: select CRC32 and CRYPTO/CRYPTO_HASH/CRYPTO_SHA256
      net: arc: select CRC32
      net: korina: select CRC32
      drm/panel: olimex-lcd-olinuxino: select CRC32

Ville Baillie (1):
      spi: atmel: Fix PDC transfer setup bug

Vineet Gupta (1):
      ARC: fix potential build snafu

Vladimir Oltean (18):
      net: dsa: fix bridge_num not getting cleared after ports leaving
the bridge
      net: dsa: tag_dsa: send packets with TX fwd offload from
VLAN-unaware bridges using VID 0
      net: dsa: mv88e6xxx: keep the pvid at 0 when VLAN-unaware
      net: dsa: mv88e6xxx: isolate the ATU databases of standalone and
bridged ports
      net: dsa: hold rtnl_lock in dsa_switch_setup_tag_protocol
      net: dsa: move sja1110_process_meta_tstamp inside the tagging
protocol driver
      net: dsa: sja1105: break dependency between dsa_port_is_sja1105
and switch driver
      net: mscc: ocelot: make use of all 63 PTP timestamp identifiers
      net: mscc: ocelot: avoid overflowing the PTP timestamp FIFO
      net: mscc: ocelot: warn when a PTP IRQ is raised for an unknown skb
      net: mscc: ocelot: deny TX timestamping of non-PTP packets
      net: mscc: ocelot: cross-check the sequence id from the
timestamp FIFO with the skb PTP header
      net: dsa: tag_ocelot: break circular dependency with ocelot
switch lib driver
      net: dsa: tag_ocelot_8021q: break circular dependency with
ocelot switch lib
      net: dsa: felix: purge skb from TX timestamping queue if it cannot be=
 sent
      net: dsa: tag_ocelot_8021q: fix inability to inject STP BPDUs
into BLOCKING ports
      net: dsa: felix: break at first CPU port during init and teardown
      Revert "net: procfs: add seq_puts() statement for dev_mcast"

Waiman Long (1):
      cgroup/cpuset: Change references of cpuset_mutex to cpuset_rwsem

Wan Jiabing (1):
      net: mscc: ocelot: Fix dumplicated argument in ocelot

Wang Hai (2):
      PCI/MSI: Handle msi_populate_sysfs() errors correctly
      ata: ahci_platform: fix null-ptr-deref in
ahci_platform_enable_regulators()

Werner Sembach (3):
      ALSA: hda/realtek: Complete partial device name to avoid ambiguity
      ALSA: hda/realtek: Add quirk for Clevo X170KM-G
      ALSA: hda/realtek: Add quirk for TongFang PHxTxX1

Wu Zongyong (1):
      vhost_vdpa: unset vq irq before freeing irq

Xiaolong Huang (1):
      isdn: cpai: check ctr->cnr to avoid array index out of bound

Xin Long (1):
      icmp: fix icmp_ext_echo_iio parsing in icmp_build_probe

Xiyu Yang (1):
      kunit: fix reference count leak in kfree_at_end

Xuan Zhuo (1):
      virtio-net: fix for skb_over_panic inside big mode

Yang Yingliang (1):
      iio: adc: rzg2l_adc: add missing clk_disable_unprepare() in
rzg2l_adc_pm_runtime_resume()

Yu-Tung Chang (1):
      USB: serial: option: add Quectel EC200S-CN module support

Zenghui Yu (1):
      drm/i915: Free the returned object of acpi_evaluate_dsm()

Zephaniah E. Loss-Cutler-Hull (1):
      platform/x86: gigabyte-wmi: add support for B550 AORUS ELITE AX V2

Zhang Jianhua (1):
      efi: Change down_interruptible() in virt_efi_reset_system() to
down_trylock()

Zheyu Ma (1):
      isdn: mISDN: Fix sleeping function called from invalid context

Ziyang Xuan (3):
      nfc: fix error handling of nfc_proto_register()
      NFC: digital: fix possible memory leak in digital_tg_listen_mdaa()
      NFC: digital: fix possible memory leak in digital_in_send_sdd_req()

chongjiapeng (1):
      qed: Fix missing error code in qed_slowpath_start()
