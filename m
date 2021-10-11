Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6294C428442
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 02:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhJKAS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 20:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbhJKAS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 20:18:28 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9321C061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 17:16:28 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id u18so65876717lfd.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 17:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=KjjqZCPXUkFG6yC6du0sm8riGpwA68cJZILFepDj5Y0=;
        b=AgHrW2x9GyCWZTnJ80KrOA8pSa4q/3b2d6saMZEo9dDrYn1ye5p7IDlIhlh4aV5Ebd
         2yVJA8QtIXQSoj3Qs7poPzodV7EXepFbpari1uzdZL86dDkJL7WXiXuCwNKd8oqygsJ/
         R8WtbYBWqaiUtbnEoimhXnp7bDEn2tmY8FFzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=KjjqZCPXUkFG6yC6du0sm8riGpwA68cJZILFepDj5Y0=;
        b=4ifn/uKkh0xym1J5dWVlk3heNxipqkpArCwppOk2eXNNARve+xB4zy5iPKY4LBOHaQ
         jnHwptAcb8yiVzY5zCbXudgUbzx7I4zCFDPOXJaoMV5d2XRA4XrYHR8kz+MFcbZypHxl
         imBqv7tbmTQ38vyMyni372mMlSHLnP4znZ5iOcNhoXcizeKNjGQvA/AOyXuIePkrWMTJ
         VL+S4EJ1d9jvwMeJYWfY5Cc7ZPU5wdnPLmyE9Aer8xOSw8c1Zl7af0NVEnPKNIYnS42S
         IyLJzXw7Aif5Qm3YhjRkHJGR3efdYOutjQIzYvK8FYl6Gn+wwWCZmnKJtd8dvJAn5Awh
         ZcLA==
X-Gm-Message-State: AOAM533l9lSHQ2XLx7LMIaeyQ8D6n6MBgHKQD9zlgak3PQzMaz6cqoOb
        McmKphTP3fpdnu4i5sAa1FiGqNWisI2pDpm4
X-Google-Smtp-Source: ABdhPJxQ7ruvy5RuTE+r+dc/RZczBWLLSFRdgLuWGnODLnTcEQWcHn8V28q4cWSIjRGUocLWKVRJxw==
X-Received: by 2002:ac2:5c1e:: with SMTP id r30mr5851448lfp.33.1633911386329;
        Sun, 10 Oct 2021 17:16:26 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id u15sm625871lfl.20.2021.10.10.17.16.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Oct 2021 17:16:25 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id y26so66537155lfa.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 17:16:25 -0700 (PDT)
X-Received: by 2002:a2e:97cf:: with SMTP id m15mr18648690ljj.249.1633911385033;
 Sun, 10 Oct 2021 17:16:25 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 Oct 2021 17:16:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiTZxkHVg=Pz7XRd-9AEDp0qV5sWmQJWnQ4NrSPYRHNiA@mail.gmail.com>
Message-ID: <CAHk-=wiTZxkHVg=Pz7XRd-9AEDp0qV5sWmQJWnQ4NrSPYRHNiA@mail.gmail.com>
Subject: Linux 5.15-rc5
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So things continue to look quite normal, and it looks like the rough
patch (hah!) we had early in the release is all behind us.

Knock wood.

The commit stats look normal for an rc5, and the diffstat is fairly
regular too. We had more arch updates than perhaps is common, with
almost as many lines of diffs in architecture code as there is in
drivers.  Admittedly some of that "architecture" code ends up being
devicetree updates, so some of it could be attributed to driver code,
but that's not how our source tree is laid out..

Outside of arch code (x86, powerpc, arm, arm64) and drivers (mainly
gpu, networking and usb), we have a smattering of other changes: 9p
and ksmbd, core networking, and some perf tooling updates. And misc
smaller random stuff.

Shortlog appended for more of a flavor for the details. Please do give
this a whirl,

               Linus

---

Adam Borowski (1):
      asm-generic/io.h: give stub iounmap() on !MMU same prototype as elsew=
here

Adrian Hunter (1):
      scsi: ufs: core: Fix task management completion

Alex Deucher (2):
      Documentation/gpu: remove spurious "+" in amdgpu.rst
      drm/amdgpu/display: fix dependencies for DRM_AMD_DC_SI

Alexandre Ghiti (1):
      riscv: Flush current cpu icache before other cpus

Alexey Kardashevskiy (1):
      powerpc/iommu: Report the correct most efficient DMA mask for PCI dev=
ices

Alyssa Rosenzweig (1):
      MAINTAINERS: Add Alyssa Rosenzweig as M1 reviewer

Amit Pundir (1):
      arm64: dts: qcom: sdm850-yoga: Reshuffle IPA memory mappings

Andrew Lunn (1):
      dsa: tag_dsa: Fix mask for trunked packets

Andrii Nakryiko (1):
      libbpf: Fix memory leak in strset

Andy Shevchenko (3):
      ptp_pch: Load module automatically if ID matches
      usb: dwc3: gadget: Revert "set gadgets parent to the right controller=
"
      hyper-v: Replace uuid.h with types.h

Antonio Martorana (1):
      soc: qcom: socinfo: Fixed argument passed to platform_set_data()

Arnaldo Carvalho de Melo (1):
      tools include UAPI: Sync sound/asound.h copy with the kernel sources

Arnd Bergmann (11):
      firmware: arm_scmi: Remove __exit annotation
      ath5k: fix building with LEDS=3Dm
      mwifiex: avoid null-pointer-subtraction warning
      media: atomisp: restore missing 'return' statement
      usb: xhci: tegra: mark PM functions as __maybe_unused
      ARM: omap1: move omap15xx local bus handling to usb.c
      ARM: dove: mark 'putc' as inline
      ARM: sharpsl_param: work around -Wstringop-overread warning
      fbdev: simplefb: fix Kconfig dependencies
      firmware: include drivers/firmware/Kconfig unconditionally
      qcom_scm: hide Kconfig symbol

Aya Levin (3):
      net/mlx5: Force round second at 1PPS out start time
      net/mlx5: Avoid generating event after PPS out in Real time mode
      net/mlx5e: Mutually exclude setting of TX-port-TS and MQPRIO in
channel mode

Ben Hutchings (1):
      Partially revert "usb: Kconfig: using select for USB_COMMON dependenc=
y"

Ben Skeggs (3):
      drm/nouveau/kms/tu102-: delay enabling cursor until after assign_wind=
ows
      drm/nouveau/ga102-: support ttm buffer moves via copy engine
      drm/nouveau/fifo/ga102: initialise chid on return from channel creati=
on

Benjamin Coddington (1):
      NFSD: Keep existing listeners on portlist error

Borislav Petkov (1):
      x86/fpu: Restore the masking out of reserved MXCSR bits

Branislav Rankov (2):
      perf build: Add missing -lstdc++ when linking with libopencsd
      perf build: Fix plugin static linking with libopencsd on ARM and ARM6=
4

Catherine Sullivan (2):
      gve: Correct available tx qpl check
      gve: Properly handle errors in gve_assign_qpl

Chris Morgan (1):
      drm/rockchip: Update crtc fixup to account for fractional clk change

Christophe Branchereau (1):
      drm/panel: abt-y030xx067a: yellow tint fix

Christophe Leroy (1):
      powerpc/32s: Fix kuap_kernel_restore()

Claudiu Beznea (13):
      ARM: at91: pm: do not panic if ram controllers are not enabled
      ARM: dts: at91: sama7g5: add ram controllers
      ARM: dts: at91: sama7g5: add securam node
      ARM: dts: at91: sama7g5: add shdwc node
      ARM: dts: at91: sama7g5: add chipid
      ARM: at91: pm: switch backup area to vbat in backup mode
      ARM: dts: at91: sama7g5ek: add suspend voltage for ddr3l rail
      ARM: at91: pm: group constants and addresses loading
      ARM: at91: pm: preload base address of controllers in tlb
      ARM: dts: at91: sama7g5ek: use proper slew-rate settings for GMACs
      ARM: dts: at91: sama7g5ek: to not touch slew-rate for SDMMC pins
      mmc: sdhci-of-at91: wait for calibration done before proceed
      mmc: sdhci-of-at91: replace while loop with read_poll_timeout

Cristian Marussi (3):
      firmware: arm_scmi: Fix virtio transport Kconfig dependency
      firmware: arm_scmi: Simplify spinlocks in virtio transport
      firmware: arm_scmi: Add proper barriers to scmi virtio device

C=C3=A9dric Le Goater (1):
      powerpc/pseries/msi: Add an empty irq_write_msi_msg() handler

Dan Carpenter (3):
      iwlwifi: mvm: d3: Fix off by ones in iwl_mvm_wowlan_get_rsc_v5_data()
      iwlwifi: mvm: d3: missing unlock in iwl_mvm_wowlan_program_keys()
      scsi: elx: efct: Delete stray unlock statement

Dave Wysochanski (1):
      cachefiles: Fix oops with cachefiles_cull() due to NULL object

David Heidelberg (2):
      ARM: dts: qcom: apq8064: use compatible which contains chipid
      ARM: dts: qcom: apq8064: update Adreno clock names

David Howells (7):
      nfs: Fix kerneldoc warning shown up by W=3D1
      afs: Fix kerneldoc warning shown up by W=3D1
      9p: Fix a bunch of kerneldoc warnings shown up by W=3D1
      fscache: Fix some kerneldoc warnings shown up by W=3D1
      fscache: Remove an unused static variable
      netfs: Fix READ/WRITE confusion when calling iov_iter_xarray()
      afs: Fix afs_launder_page() to set correct start file position

Dmitry Baryshkov (3):
      arm64: dts: qcom: pm8150: use qcom,pm8998-pon binding
      arm64: dts: qcom: pm8150: specify reboot mode magics
      arm64: dts: qcom: qrb5165-rb5: enabled pwrkey and resin nodes

Douglas Anderson (1):
      Revert "arm64: dts: qcom: sc7280: Fixup the cpufreq node"

Edmund Dea (1):
      drm/kmb: Enable alpha blended second plane

Eric Dumazet (9):
      net: add kerneldoc comment for sk_peer_lock
      net_sched: fix NULL deref in fifo_set_limit()
      net: bridge: use nla_total_size_64bit() in br_get_linkxstats_size()
      net: bridge: fix under estimation in br_get_linkxstats_size()
      net/sched: sch_taprio: properly cancel timer from taprio_destroy()
      netlink: annotate data races around nlk->bound
      rtnetlink: fix if_nlmsg_stats_size() under estimation
      gve: fix gve_get_stats()
      gve: report 64bit tx_bytes counter from gve_handle_report_stats()

Eugen Hristev (1):
      ARM: dts: at91: sama5d2_som1_ek: disable ISC node by default

Eugene Syromiatnikov (1):
      include/uapi/linux/xfrm.h: Fix XFRM_MSG_MAPPING ABI breakage

Fabio Estevam (3):
      Revert "ARM: imx6q: drop of_platform_default_populate() from init_mac=
hine"
      ARM: dts: imx6qdl-pico: Fix Ethernet support
      usb: chipidea: ci_hdrc_imx: Also search for 'phys' phandle

Florian Westphal (1):
      netfilter: conntrack: fix boot failure with nf_conntrack.enable_hooks=
=3D1

Geert Uytterhoeven (2):
      firmware: qcom_scm: QCOM_SCM should depend on ARCH_QCOM
      dt-bindings: drm/bridge: ti-sn65dsi86: Fix reg value

George Shen (1):
      drm/amd/display: Skip override for preferred link settings
during link training

Guchun Chen (1):
      drm/amdgpu: handle the case of pci_channel_io_frozen only in
amdgpu_pci_resume

Guenter Roeck (1):
      xtensa: xtfpga: Try software restart before simulating CPU reset

Haibo Chen (2):
      ARM: dts: imx: change the spi-nor tx
      arm64: dts: imx8: change the spi-nor tx

Hansen (1):
      drm/amd/display: Fix detection of 4 lane for DPALT

Hayes Wang (1):
      r8152: avoid to resubmit rx immediately

Heikki Krogerus (1):
      usb: typec: tipd: Remove dependency on "connector" child fwnode

Heiko Thiery (1):
      arm64: dts: imx8mm-kontron-n801x-som: do not allow to switch off buck=
2

Ilan Peer (1):
      iwlwifi: mvm: Fix possible NULL dereference

Ilya Lipnitskiy (1):
      MIPS: Revert "add support for buggy MT7621S core detection"

Imre Deak (1):
      drm/i915/tc: Fix TypeC port init/resume time sanitization

J. Bruce Fields (1):
      SUNRPC: fix sign error causing rpcsec_gss drops

Jakub Kicinski (1):
      etherdevice: use __dev_addr_set()

James Morse (2):
      x86/resctrl: Free the ctrlval arrays when domain_setup_mon_state() fa=
ils
      x86/resctrl: Fix kfree() of the wrong type in domain_add_cpu()

James Smart (1):
      scsi: lpfc: Fix memory overwrite during FC-GS I/O abort handling

Jamie Iles (1):
      i2c: acpi: fix resource leak in reconfiguration device addition

Jan Beulich (12):
      xen/privcmd: replace kcalloc() by kvcalloc() when allocating empty pa=
ges
      xen/privcmd: fix error handling in mmap-resource processing
      xen/privcmd: drop "pages" parameter from xen_remap_pfn()
      xen/x86: prevent PVH type from getting clobbered
      xen/x86: allow PVH Dom0 without XEN_PV=3Dy
      xen/x86: make "earlyprintk=3Dxen" work better for PVH Dom0
      xen/x86: allow "earlyprintk=3Dxen" to work for PV Dom0
      xen/x86: make "earlyprintk=3Dxen" work for HVM/PVH DomU
      xen/x86: generalize preferred console model from PV to PVH Dom0
      xen/x86: hook up xen_banner() also for PVH
      x86/PVH: adjust function/data placement
      xen/x86: adjust data placement

Jeremy Cline (1):
      drm/nouveau: avoid a use-after-free when BO init fails

Jernej Skrabec (1):
      drm/sun4i: dw-hdmi: Fix HDMI PHY clock setup

Jiang Wang (1):
      unix: Fix an issue in unix_shutdown causing the other end
read/write failures

Jiri Benc (1):
      i40e: fix endless loop under rtnl

Joe Lawrence (2):
      objtool: Make .altinstructions section entry size consistent
      objtool: Remove redundant 'len' field from struct section

Joel Stanley (2):
      ARM: config: multi v7: Enable dependancies
      ARM: config: mutli v7: Reenable FB dependency

Johan Almbladh (1):
      bpf, arm: Fix register clobbering in div/mod implementation

Johan Hovold (2):
      USB: cdc-acm: fix racy tty buffer accesses
      USB: cdc-acm: fix break reporting

Johannes Thumshirn (1):
      block: decode QUEUE_FLAG_HCTX_ACTIVE in debugfs output

John Garry (1):
      scsi: acornscsi: Remove scsi_cmd_to_tag() reference

Josh Poimboeuf (1):
      objtool: Remove reloc symbol type checks in get_alt_entry()

Jude Shih (1):
      drm/amd/display: USB4 bring up set correct address

Juergen Gross (1):
      xen/balloon: fix cancelled balloon action

Kai-Heng Feng (1):
      drm/i915/audio: Use BIOS provided value for RKL HDA link

Kan Liang (1):
      perf tests attr: Add missing topdown metrics events

Kewei Xu (1):
      i2c: mediatek: Add OFFSET_EXT_CONF setting back

Krzysztof Kozlowski (5):
      arm64: dts: arm: align watchdog and mmc node names with dtschema
      ARM: dts: arm: align watchdog and mmc node names with dtschema
      arm64: dts: arm: drop unused interrupt-names in MHU
      MAINTAINERS: Move Daniel Drake to credits
      dt-bindings: panel: ili9341: correct indentation

Kumar Kartikeya Dwivedi (2):
      samples: bpf: Fix vmlinux.h generation for XDP samples
      libbpf: Fix segfault in light skeleton for objects without BTF

Lama Kayal (1):
      net/mlx5e: Fix the presented RQ index in PTP stats

Lang Yu (1):
      drm/amdkfd: fix a potential ttm->sg memory leak

Leon Romanovsky (1):
      MAINTAINERS: Remove Bin Luo as his email bounces

Lijo Lazar (1):
      drm/amdgpu: During s0ix don't wait to signal GFXOFF

Like Xu (1):
      perf jevents: Free the sys_event_tables list after processing entries

Linus Torvalds (1):
      Linux 5.15-rc5

Linus Walleij (1):
      ARM: defconfig: gemini: Restore framebuffer

Liu, Zhan (2):
      drm/amd/display: Fix B0 USB-C DP Alt mode
      drm/amd/display: Fix DCN3 B0 DP Alt Mapping

Long Li (1):
      PCI: hv: Fix sleep while in non-sleep context when removing
child devices from the bus

Luca Boccassi (1):
      samples/bpf: Relicense bpf_insn.h as GPL-2.0-only OR BSD-2-Clause

Lukas Bulwahn (3):
      x86/entry: Correct reference to intended CONFIG_64_BIT
      x86/platform/olpc: Correct ifdef symbol to intended CONFIG_OLPC_XO15_=
SCI
      x86/Kconfig: Correct reference to MWINCHIP3D

Lukasz Majczak (1):
      drm/i915/bdb: Fix version check

Maarten Lankhorst (1):
      drm/i915: Fix runtime pm handling in i915_gem_shrink

Mahesh Salgaonkar (1):
      pseries/eeh: Fix the kdump kernel crash during eeh_pseries_init

Marcel Ziswiler (2):
      ARM: imx_v6_v7_defconfig: enable fb
      dt-bindings: net: dsa: marvell: fix compatible in example

Marek Vasut (2):
      ARM: dts: imx: Add missing pinctrl-names for panel on M53Menlo
      ARM: dts: imx: Fix USB host power regulator polarity on M53Menlo

Marijn Suijten (1):
      ARM: dts: qcom: apq8064: Use 27MHz PXO clock as DSI PLL reference

Mark Brown (1):
      video: fbdev: gbefb: Only instantiate device when built for IP32

Max Filippov (2):
      xtensa: call irqchip_init only when CONFIG_USE_OF is selected
      xtensa: xtfpga: use CONFIG_USE_OF instead of CONFIG_OF

Maxime Ripard (1):
      drm/vc4: hdmi: Remove unused struct

Michael Walle (1):
      arm64: dts: ls1028a: fix eSDHC2 node

Michal Vok=C3=A1=C4=8D (1):
      ARM: dts: imx6dl-yapp4: Fix lp5562 LED driver probe

Mike Christie (1):
      scsi: iscsi: Fix iscsi_task use after free

Mike Manning (1):
      net: prefer socket bound to interface when not in VRF

Miklos Szeredi (1):
      ovl: fix IOCB_DIRECT if underlying fs doesn't support direct IO

Moshe Shemesh (1):
      net/mlx5: E-Switch, Fix double allocation of acl flow counter

Namjae Jeon (6):
      ksmbd: add the check to vaildate if stream protocol length
exceeds maximum value
      ksmbd: check strictly data area in ksmbd_smb2_check_message()
      ksmbd: remove the leftover of smb2.0 dialect support
      ksmbd: use buf_data_size instead of recalculation in smb3_decrypt_req=
()
      ksmbd: fix version mismatch with out of tree
      ksmbd: fix oops from fuse driver

Nathan Chancellor (1):
      bus: ti-sysc: Add break in switch statement in sysc_init_soc()

Naveen N. Rao (10):
      powerpc/lib: Add helper to check if offset is within conditional
branch range
      powerpc/bpf: Validate branch ranges
      powerpc/bpf: Fix BPF_MOD when imm =3D=3D 1
      powerpc/bpf: Fix BPF_SUB when imm =3D=3D 0x80000000
      powerpc/security: Add a helper to query stf_barrier type
      powerpc/bpf: Emit stf barrier instruction sequences for BPF_NOSPEC
      powerpc/bpf ppc32: Fix ALU32 BPF_ARSH operation
      powerpc/bpf ppc32: Fix JMP32_JSET_K
      powerpc/bpf ppc32: Do not emit zero extend instruction for 64-bit BPF=
_END
      powerpc/bpf ppc32: Fix BPF_SUB when imm =3D=3D 0x80000000

Neil Armstrong (1):
      mmc: meson-gx: do not use memcpy_to/fromio for dram-access-quirk

Nicholas Piggin (5):
      powerpc/64s: fix program check interrupt emergency stack path
      powerpc/traps: do not enable irqs in _exception
      powerpc/64: warn if local irqs are enabled in NMI or hardirq context
      powerpc/64/interrupt: Reconcile soft-mask state in NMI and fix false =
BUG
      powerpc/64s: Fix unrecoverable MCE calling async handler from NMI

Nicolas Dichtel (3):
      xfrm: make user policy API complete
      xfrm: notify default policy on update
      xfrm: fix rcu lock in xfrm_notify_userpolicy()

Niklas Schnelle (1):
      s390/pci: fix zpci_zdev_put() on reserve

Nikola Cornij (1):
      drm/amd/display: Limit display scaling to up to 4k for DCN 3.1

Nishanth Menon (1):
      MAINTAINERS: Add Vignesh to TI K3 platform maintainership

Oleksij Rempel (1):
      ARM: imx6: disable the GIC CPU interface before calling
stby-poweroff sequence

Pablo Neira Ayuso (3):
      netfilter: nf_tables: add position handle in event notification
      netfilter: nf_tables: reverse order in rule replacement expansion
      netfilter: nf_tables: honor NLM_F_CREATE and NLM_F_EXCL in event
notification

Pali Roh=C3=A1r (1):
      powerpc/fsl/dts: Fix phy-connection-type for fm1mac3

Palmer Dabbelt (2):
      RISC-V: Include clone3() on rv32
      checksyscalls: Unconditionally ignore fstat{,at}64

Patrick Ho (1):
      nfsd: fix error handling of register_pernet_subsys() in init_nfsd()

Pavel Hofman (1):
      usb: gadget: f_uac2: fixed EP-IN wMaxPacketSize

Pavel Skripkin (3):
      net: xfrm: fix shift-out-of-bounds in xfrm_get_default
      Revert "net: mdiobus: Fix memory leak in __mdiobus_register"
      phy: mdio: fix memory leak

Punit Agrawal (1):
      net: stmmac: dwmac-rk: Fix ethernet on rk3399 based devices

Raed Salem (1):
      net/mlx5e: IPSEC RX, enable checksum complete

Rafael J. Wysocki (1):
      PCI: ACPI: Check parent pointer in acpi_pci_find_companion()

Randy Dunlap (2):
      xtensa: use CONFIG_USE_OF instead of CONFIG_OF
      DRM: delete DRM IRQ legacy midlayer docs

Rikard Falkeborn (1):
      usb: cdc-wdm: Fix check for WWAN

Rob Herring (6):
      arm: dts: vexpress: Drop unused properties from motherboard node
      arm: dts: vexpress-v2p-ca9: Fix the SMB unit-address
      arm: dts: vexpress: Fix addressing issues with 'motherboard-bus' node=
s
      arm: dts: vexpress: Fix motherboard bus 'interrupt-map'
      dt-bindings: media: Fix more graph 'unevaluatedProperties'
related warnings
      dt-bindings: Drop more redundant 'maxItems/minItems'

Robin Murphy (1):
      arm64: dts: fvp: Remove panel timings

Roger Quadros (1):
      ARM: dts: omap3430-sdp: Fix NAND device node

Romain Perier (1):
      MAINTAINERS: Add myself as MStar/Sigmastar Armv7 SoC maintainers

Sean Anderson (1):
      net: sfp: Fix typo in state machine debug string

Shannon Nelson (1):
      ionic: move filter sync_needed bit set

Shawn Guo (2):
      soc: qcom: mdt_loader: Drop PT_LOAD check on hash segment
      arm64: dts: qcom: sdm630: Add missing a2noc qos clocks

Shay Drory (2):
      net/mlx5: Fix length of irq_index in chars
      net/mlx5: Fix setting number of EQs of SFs

Shuah Khan (1):
      selftests: drivers/dma-buf: Fix implicit declaration warns

Soeren Moch (1):
      Revert "brcmfmac: use ISO3166 country code and 0 rev as fallback"

Stefan Assmann (1):
      iavf: fix double unlock of crit_lock

Stephen Boyd (1):
      arm64: dts: qcom: sc7180-trogdor: Fix lpass dai link for HDMI

Sven Peter (1):
      MAINTAINERS: Add Sven Peter as ARM/APPLE MACHINE maintainer

Sylwester Dziedziuch (1):
      i40e: Fix freeing of uninitialized misc IRQ vector

Tao Liu (1):
      gve: Avoid freeing NULL pointer

Tariq Toukan (2):
      net/mlx5e: Keep the value for maximum number of channels in-sync
      net/mlx5e: Improve MQPRIO resiliency

Tatsuhiko Yasumatsu (1):
      bpf: Fix integer overflow in prealloc_elems_and_freelist()

Tetsuo Handa (1):
      block: genhd: fix double kfree() in __alloc_disk_node()

Thomas Gleixner (1):
      x86/hpet: Use another crystalball to evaluate HPET usability

Tiezhu Yang (1):
      bpf, s390: Fix potential memory leak about jit_data

Tim Harvey (1):
      arm64: dts: imx8m*-venice-gw7902: fix M2_RST# gpio

Tom Lendacky (1):
      x86/sev: Return an error on a returned non-zero SW_EXITINFO1[31:0]

Tong Tiangen (3):
      riscv/vdso: Refactor asm/vdso.h
      riscv/vdso: Move vdso data page up front
      riscv/vdso: make arch_setup_additional_pages wait for mmap_sem
for write killable

Tony Lindgren (2):
      soc: ti: omap-prm: Fix external abort for am335x pruss
      bus: ti-sysc: Use CLKDM_NOAUTO for dra7 dcan1 for errata i893

Trond Myklebust (2):
      nfsd4: Handle the NFSv4 READDIR 'dircount' hint being zero
      nfsd: Fix a warning for nfsd_file_close_inode

Vadim Pasternak (2):
      i2c: mlxcpld: Fix criteria for frequency setting
      i2c: mlxcpld: Modify register setting for 400KHz frequency

Vegard Nossum (1):
      x86/entry: Clear X86_FEATURE_SMAP when CONFIG_X86_SMAP=3Dn

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Extend the async flip VT-d w/a to skl/bxt

Vitaly Kuznetsov (1):
      x86/hyperv: Avoid erroneously sending IPI to 'self'

Vladimir Oltean (1):
      net: mscc: ocelot: fix VCAP filters remaining active after being dele=
ted

Vladimir Zapolskiy (1):
      iwlwifi: pcie: add configuration of a Wi-Fi adapter on Dell XPS 15

Wong Vee Khee (3):
      net: pcs: xpcs: fix incorrect CL37 AN sequence
      net: pcs: xpcs: fix incorrect steps on disable EEE
      net: stmmac: trigger PCS EEE to turn off on link down

Xu Yang (2):
      usb: typec: tcpci: don't handle vSafe0V event if it's not enabled
      usb: typec: tcpm: handle SRC_STARTUP state if cc changes

Yang Yingliang (2):
      drm/nouveau/kms/nv50-: fix file release memory leak
      drm/nouveau/debugfs: fix file release memory leak

Yifan Zhang (2):
      drm/amdkfd: remove redundant iommu cleanup code
      drm/amdgpu: init iommu after amdkfd device init

Zheng Liang (1):
      ovl: fix missing negative dentry check in ovl_rename()

jing yangyang (1):
      tee/optee/shm_pool: fix application of sizeof to pointer
