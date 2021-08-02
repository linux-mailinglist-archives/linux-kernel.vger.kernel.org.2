Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9A23DCE48
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 02:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbhHBAZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 20:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhHBAZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 20:25:32 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB07C06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 17:25:22 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id z2so30598967lft.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 17:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9D3kUuyq6xhiKDDSLhLyAwo4LE33Wa5VuZL8TAMNYks=;
        b=GNADlQWrFP1fRR/ZWDN5AwGiJxA+kPbUCqsjAFpoPfsP50aNN8yoNpHtEAie1lNWq8
         BJazc9Z9V1EIgtsAuaVbyW96t825Z4Ml3w9yStyhIp9S60PLGrSZN65+jeqCsfEcQgta
         sx9OKFQwvDDb+mnIU5BasrU+xw6raAxgZ3pFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9D3kUuyq6xhiKDDSLhLyAwo4LE33Wa5VuZL8TAMNYks=;
        b=TB7vUUuX9uxlq2SPBwKleftqmja84ABA3aNUFNdCSOVND2tEWYRUnG00NINck6FV/U
         Y/2b0XC1AnByX9bqyyztpjba4BKble3V3z0KUi7DraGsfjIfbFFTG6Qw4mJNCyLhbIfu
         Oh7f1AoE+NmXk2WEtLD65qgHpnFLIAjT76tesN4fOEUlzEp+E46q61wlktVYbc63YHFj
         V2psw90IjBi33GGTRJXmTWVN6CNmk+U+Mb3FBsaCAxRbSrPCLhLSuj5qNEtdAAxYf3F7
         I7Jz3x5ltIXo3zNVNxm21QkoHqU/K16Y6VZLlkHDvPEuau4/34QTFTSuAZiupPZw0hCw
         LKdg==
X-Gm-Message-State: AOAM531xVXrUR1CFs/Fn51h1ewIYhLlt4hTEZ5o14HaiVhJCsjWKTBfK
        fVpWybyD8/00HlmcQYWdo1UNpL3aKRskKnm+
X-Google-Smtp-Source: ABdhPJycMFlfTTH927t7xvPMIVtQAfdSIXAJa7Bw42TcX54ijSWFBHfwbvfUOqHeNte1TtVZFPPjag==
X-Received: by 2002:a05:6512:3e24:: with SMTP id i36mr6714879lfv.169.1627863920901;
        Sun, 01 Aug 2021 17:25:20 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id b15sm464859lff.104.2021.08.01.17.25.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Aug 2021 17:25:20 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id a26so30473574lfr.11
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 17:25:20 -0700 (PDT)
X-Received: by 2002:a05:6512:2388:: with SMTP id c8mr10085709lfv.201.1627863920015;
 Sun, 01 Aug 2021 17:25:20 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 1 Aug 2021 17:25:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=whv0g5YqoRXc8oxqJX3r+GP1dN3ia_Qg_V6UTjhi8vg8w@mail.gmail.com>
Message-ID: <CAHk-=whv0g5YqoRXc8oxqJX3r+GP1dN3ia_Qg_V6UTjhi8vg8w@mail.gmail.com>
Subject: Linux 5.14-rc4
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing to see here, entirely normal rc4.  It's mostly a very nice and
flat diffstat - so small spread out changes - with the exception of a
couple of blips in selftests and the xfs fixes.

Mostly drivers, some arch updates, networking, plus tooling and
selftests. Nothing odd stands out.

Shortlog appended for people who want to scan the details,

                 Linus

---

Alex Deucher (1):
      drm/amdgpu/display: only enable aux backlight control for OLED panels

Alex Hung (1):
      platform/x86: wireless-hotkey: remove hardcoded "hp" from the
error message

Alexander A. Klimov (1):
      alpha: Kconfig: Replace HTTP links with HTTPS ones

Andrew Jones (2):
      KVM: selftests: change pthread_yield to sched_yield
      KVM: arm64: selftests: get-reg-list: actually enable pmu regs in
pmu sublist

Aneesh Kumar K.V (1):
      mm/migrate: fix NR_ISOLATED corruption on 64-bit

Arkadiusz Kubalewski (2):
      i40e: Fix logic of disabling queues
      i40e: Fix firmware LLDP agent related warning

Arnaldo Carvalho de Melo (1):
      Revert "perf map: Fix dso->nsinfo refcounting"

Arnd Bergmann (2):
      netfilter: nfnl_hook: fix unused variable warning
      alpha: fp_emul: avoid init/cleanup_module names

Aya Levin (4):
      net/mlx5e: Consider PTP-RQ when setting RX VLAN stripping
      net/mlx5e: Fix page allocation failure for trap-RQ over SF
      net/mlx5e: Fix page allocation failure for ptp-RQ over SF
      net/mlx5: Unload device upon firmware fatal error

Bjorn Andersson (1):
      drm/msm/dp: Initialize the INTF_CONFIG register

Bob Pearson (1):
      RDMA/rxe: Fix memory leak in error path code

Catherine Sullivan (1):
      gve: Update MAINTAINERS list

Chen Li (1):
      alpha: remove undef inline in compiler.h

Chen Shen (1):
      sctp: delete addr based on sin6_scope_id

Chris Mi (1):
      net/mlx5: Fix mlx5_vport_tbl_attr chain from u16 to u32

Christian Borntraeger (1):
      KVM: s390: restore old debugfs names

Christoph Hellwig (2):
      libata: fix ata_pio_sector for CONFIG_HIGHMEM
      block: delay freeing the gendisk

Christophe JAILLET (1):
      HID: fix typo in Kconfig

Colin Ian King (1):
      HID: Kconfig: Fix spelling mistake "Uninterruptable" -> "Uninterrupti=
ble"

Corentin Labbe (2):
      alpha: __udiv_qrnnd should be exported
      alpha: defconfig: add necessary configs for boot testing

Dale Zhao (1):
      drm/amd/display: ensure dentist display clock update finished in DCN2=
0

Dan Carpenter (1):
      can: hi311x: fix a signedness bug in hi3110_cmd()

Daniel Borkmann (5):
      bpf: Remove superfluous aux sanitation on subprog rejection
      bpf: Fix pointer arithmetic mask tightening under state pruning
      bpf, selftests: Add test cases for pointer alu from multiple paths
      bpf: Introduce BPF nospec instruction for mitigating Spectre v4
      bpf: Fix leakage due to insufficient speculative store bypass mitigat=
ion

Darrick J. Wong (1):
      xfs: prevent spoofing of rtbitmap blocks when recovering buffers

Dave Chinner (11):
      xfs: flush data dev on external log write
      xfs: external logs need to flush data device
      xfs: fold __xlog_state_release_iclog into xlog_state_release_iclog
      xfs: fix ordering violation between cache flushes and tail updates
      xfs: factor out forced iclog flushes
      xfs: log forces imply data device cache flushes
      xfs: avoid unnecessary waits in xfs_log_force_lsn()
      xfs: logging the on disk inode LSN can make it go backwards
      xfs: Enforce attr3 buffer recovery order
      xfs: need to see iclog flags in tracing
      xfs: limit iclog tail updates

David Hildenbrand (1):
      binfmt: remove support for em86 (alpha only)

David Matlack (2):
      KVM: selftests: Fix missing break in dirty_log_perf_test arg parsing
      KVM: selftests: Introduce access_tracking_perf_test

David Sterba (1):
      btrfs: calculate number of eb pages properly in csum_tree_block

Desmond Cheong Zhi Xi (1):
      btrfs: fix rw device counting in __btrfs_free_extra_devids

Dima Chumak (1):
      net/mlx5e: Fix nullptr in mlx5e_hairpin_get_mdev()

Dongliang Mu (1):
      netfilter: nf_tables: fix audit memory leak in nf_tables_commit

Dylan MacKenzie (1):
      HID: amd_sfh: Use correct MMIO register for DMA address

Felix Fietkau (2):
      mac80211: fix starting aggregation sessions on mesh interfaces
      mac80211: fix enabling 4-address mode on a sta vif after assoc

Filipe Manana (1):
      btrfs: fix lost inode on log replay after mix of fsync, rename
and inode eviction

Florian Westphal (1):
      netfilter: conntrack: adjust stop timestamp to real expiry value

Geetha sowjanya (2):
      octeontx2-af: Fix PKIND overlap between LBK and LMAC interfaces
      octeontx2-pf: Fix interface down flag on error

Gilad Naaman (1):
      net: Set true network header for ECN decapsulation

Goldwyn Rodrigues (1):
      btrfs: mark compressed range uptodate only if all bio succeed

Gustavo A. R. Silva (3):
      ARM: riscpc: Fix fall-through warning for Clang
      scsi: acornscsi: Fix fall-through warning for clang
      scsi: fas216: Fix fall-through warning for Clang

Hans de Goede (2):
      platform/x86: think-lmi: Split kobject_init() and kobject_add() calls
      platform/x86: think-lmi: Fix possible mem-leaks on
tlmi_analyze() error-exit

Hao Xu (1):
      io_uring: fix poll requests leaking second poll entries

Haochen Tong (1):
      HID: apple: Add support for Keychron K1 wireless keyboard

Hariprasad Kelam (1):
      octeontx2-pf: Dont enable backpressure on LBK links

Harshvardhan Jha (1):
      net: qede: Fix end of loop tests for list_for_each_entry

He Zhe (1):
      alpha: Add syscall_get_return_value()

Hoang Le (1):
      tipc: fix sleeping in tipc accept routine

Hui Wang (1):
      Revert "ACPI: resources: Add checks for ACPI IRQ override"

Jagan Teki (1):
      drm/panel: panel-simple: Fix proper bpc for ytc700tlag_05_201c

James Clark (1):
      perf cs-etm: Split --dump-raw-trace by AUX records

Jason Ekstrand (1):
      drm/ttm: Initialize debugfs from ttm_global_init()

Jason Gerecke (2):
      HID: wacom: Re-enable touch by default for Cintiq 24HDT / 27QHDT
      HID: wacom: Skip processing of touches with negative slot values

Javier Pello (1):
      fs/ext2: Avoid page_address on pages returned by ext2_get_page

Jedrzej Jagielski (2):
      i40e: Fix queue-to-TC mapping on Tx
      i40e: Fix log TC creation failure when max num of queues is exceeded

Jens Axboe (3):
      io_uring: fix race in unified task_work running
      io_uring: always reissue from task_work context
      io_uring: don't block level reissue off completion path

Jiapeng Chong (1):
      mlx4: Fix missing error code in mlx4_load_one()

Jiri Kosina (2):
      drm/amdgpu: Fix resource leak on probe error path
      drm/amdgpu: Avoid printing of stack contents on firmware load error

Joakim Zhang (1):
      arm64: dts: imx8mp: remove fallback compatible string for FlexCAN

Johan Almbladh (1):
      mac80211: Do not strip skb headroom on monitor frames

Johannes Berg (1):
      nl80211: limit band information in non-split data

Johannes Weiner (1):
      mm: memcontrol: fix blocking rstat function called from atomic
cgroup1 thresholding code

John Fastabend (3):
      bpf, sockmap: Zap ingress queues after stopping strparser
      bpf, sockmap: On cleanup we additionally need to remove cached skb
      bpf, sockmap: Fix memleak on ingress msg enqueue

John Garry (2):
      perf pmu: Fix alias matching
      blk-mq-sched: Fix blk_mq_sched_alloc_tags() error handling

Juergen Gross (1):
      x86/kvm: fix vcpu-id indexed array sizes

Junxiao Bi (2):
      ocfs2: fix zero out valid data
      ocfs2: issue zeroout to EOF blocks

Kangmin Park (1):
      ipv6: decrease hop limit counter in ip6_forward()

Kevin Lo (1):
      net: phy: broadcom: re-add check for PHY_BRCM_DIS_TXCRXC_NOENRGY
on the BCM54811 PHY

Krzysztof Kozlowski (1):
      nfc: nfcsim: fix use after free during module unload

Kuogee Hsieh (2):
      drm/msm/dp: use dp_ctrl_off_link_stream during PHY compliance test ru=
n
      drm/msm/dp: signal audio plugged change at dp_pm_resume

Letu Ren (1):
      net/qla3xxx: fix schedule while atomic in ql_wait_for_drvr_lock
and ql_adapter_reset

Li RongQing (1):
      KVM: use cpu_relax when halt polling

Linus Torvalds (2):
      pipe: make pipe writes always wake up readers
      Linux 5.14-rc4

Loic Poulain (1):
      wwan: core: Fix missing RTM_NEWLINK event for default link

Lorenz Bauer (1):
      bpf: Fix OOB read when printing XDP link fdinfo

Lucas De Marchi (2):
      drm/i915: fix not reading DSC disable fuse in GLK
      drm/i915/display: split DISPLAY_VER 9 and 10 in intel_setup_outputs()

Lukas Bulwahn (2):
      RDMA/irdma: Make spdxcheck.py happy
      arch: Kconfig: clean up obsolete use of HAVE_IDE

Lukasz Cieplicki (1):
      i40e: Add additional info to PHY type error

Luke D. Jones (1):
      HID: asus: Remove check for same LED brightness on set

Maor Dickman (2):
      net/mlx5e: Disable Rx ntuple offload for uplink representor
      net/mlx5: E-Switch, Set destination vport vhca id only when
merged eswitch is supported

Maor Gottlieb (1):
      net/mlx5: Fix flow table chaining

Marc Kleine-Budde (2):
      can: mcp251xfd: mcp251xfd_irq(): stop timestamping worker in
case error in IRQ
      MAINTAINERS: add Yasushi SHOJI as reviewer for the Microchip CAN
BUS Analyzer Tool driver

Marc Zyngier (1):
      KVM: arm64: Fix detection of shared VMAs on guest fault

Marcelo Ricardo Leitner (1):
      sctp: fix return value check in __sctp_rcv_asconf_lookup

Mario Limonciello (2):
      platform/x86: amd-pmc: Use return code on suspend
      ACPI: PM: Add support for upcoming AMD uPEP HID AMDI007

Mark Pearson (2):
      platform/x86: think-lmi: Add pending_reboot support
      platform/x86: think-lmi: Move pending_reboot_attr to the
attributes sysfs dir

Matteo Croce (2):
      virt_wifi: fix error on connect
      lib/test_string.c: move string selftest in the Runtime Testing menu

Mauro Carvalho Chehab (1):
      docs: virt: kvm: api.rst: replace some characters

Maxim Levitsky (3):
      KVM: SVM: svm_set_vintr don't warn if AVIC is active but is
about to be deactivated
      KVM: SVM: tweak warning about enabled AVIC on nested entry
      KVM: SVM: use vmcb01 in svm_refresh_apicv_exec_ctrl

Maxim Mikityanskiy (1):
      net/mlx5e: Add NETIF_F_HW_TC to hw_features when HTB offload is avail=
able

Michael Chan (1):
      bnxt_en: Add missing periodic PHC overflow check

Michael Ellerman (1):
      powerpc/vdso: Don't use r30 to avoid breaking Go lang

Michael Zaidman (2):
      HID: ft260: fix format type warning in ft260_word_show()
      HID: ft260: fix device removal due to USB disconnect

Mike Rapoport (1):
      alpha: register early reserved memory in memblock

Miklos Szeredi (1):
      af_unix: fix garbage collect vs MSG_PEEK

Mohammad Athari Bin Ismail (1):
      net: stmmac: add est_irq_status callback function for GMAC 4.10 and 5=
.10

Naresh Kumar PBS (1):
      RDMA/bnxt_re: Fix stats counters

Nguyen Dinh Phi (1):
      cfg80211: Fix possible memory leak in function cfg80211_bss_update

Oleksij Rempel (1):
      can: j1939: j1939_session_deactivate(): clarify lifetime of session o=
bject

Pablo Neira Ayuso (3):
      netfilter: flowtable: avoid possible false sharing
      netfilter: nft_last: avoid possible false sharing
      netfilter: nft_nat: allow to specify layer 4 protocol NAT only

Paolo Bonzini (2):
      KVM: SVM: delay svm_vcpu_init_msrpm after svm->vmcb is initialized
      KVM: add missing compat KVM_CLEAR_DIRTY_LOG

Parav Pandit (1):
      devlink: Fix phys_port_name of virtual port and merge error

Paul Gortmaker (1):
      cgroup1: fix leaked context root causing sporadic NULL deref in LTP

Paul Jakma (1):
      NIU: fix incorrect error return, missed in previous revert

Pavel Begunkov (1):
      io_uring: fix io_prep_async_link locking

Pavel Skripkin (6):
      net: qrtr: fix memory leaks
      net: llc: fix skb_over_panic
      can: mcba_usb_start(): add missing urb->transfer_dma initialization
      can: usb_8dev: fix memory leak
      can: ems_usb: fix memory leak
      can: esd_usb2: fix memory leak

Ping Bao (1):
      platform/x86: intel-hid: add Alder Lake ACPI device ID

Prarit Bhargava (1):
      alpha: Send stop IPI to send to online CPUs

Pratik Vishwakarma (1):
      drm/amdgpu: Check pmops for desired suspend state

Randy Dunlap (1):
      m68k/coldfire: change pll var. to clk_pll

Rob Clark (1):
      drm/msm: Fix display fault handling

Robert Foss (1):
      drm/msm/dpu: Fix sm8250_mdp register length

Rodrigo Vivi (1):
      drm/i915/bios: Fix ports mask

Roi Dayan (1):
      net/mlx5: E-Switch, handle devcom events only for ports on the same d=
evice

Ronnie Sahlberg (1):
      cifs: add missing parsing of backupuid

Sean Paul (1):
      drm/msm/dp: Initialize dp->aux->drm_dev before registration

Shakeel Butt (1):
      slub: fix unreclaimable slab stat for bulk free

Shannon Nelson (5):
      ionic: make all rx_mode work threadsafe
      ionic: catch no ptp support earlier
      ionic: remove intr coalesce update from napi
      ionic: fix up dim accounting for tx and rx
      ionic: count csum_none when offload enabled

Shreyansh Chouhan (1):
      reiserfs: check directory items on read from disk

Shyam Sundar S K (8):
      platform/x86: amd-pmc: Fix command completion code
      platform/x86: amd-pmc: Fix SMU firmware reporting mechanism
      platform/x86: amd-pmc: call dump registers only once
      platform/x86: amd-pmc: Add support for logging SMU metrics
      platform/x86: amd-pmc: Add support for logging s0ix counters
      platform/x86: amd-pmc: Add support for ACPI ID AMDI0006
      platform/x86: amd-pmc: Add new acpi id for future PMC controllers
      platform/x86: amd-pmc: Fix undefined reference to __udivdi3

Simon Ser (1):
      maintainers: add bugs and chat URLs for amdgpu

Somnath Kotur (1):
      bnxt_en: Fix static checker warning in bnxt_fw_reset_task()

Srikar Dronamraju (1):
      powerpc/pseries: Fix regression while building external modules

Srinivas Pandruvada (1):
      ACPI: DPTF: Fix reading of attributes

Stephane Grosjean (1):
      can: peak_usb: pcan_usb_handle_bus_evt(): fix reading rxerr/txerr val=
ues

Steve French (2):
      SMB3: fix readpage for large swap cache
      smb3: rc uninitialized in one fallocate path

Subbaraya Sundeep (1):
      octeontx2-af: Fix uninitialized variables in rvu_switch

Sunil Goutham (2):
      octeontx2-af: Remove unnecessary devm_kfree
      octeontx2-af: Do NIX_RX_SW_SYNC twice

Tang Bin (2):
      nfc: s3fwrn5: fix undefined parameter values in dev_err()
      nfc: s3fwrn5: fix undefined parameter values in dev_err()

Tariq Toukan (1):
      net/mlx5e: RX, Avoid possible data corruption when relaxed
ordering and LRO combined

Tatyana Nikolova (2):
      RDMA/irdma: Fix unused variable total_size warning
      RDMA/irdma: Check vsi pointer before using it

Tejun Heo (1):
      blk-iocost: fix operation ordering in iocg_wake_fn()

Tetsuo Handa (1):
      loop: reintroduce global lock for safe loop_validate_file() traversal

Thomas Wei=C3=9Fschuh (1):
      platform/x86: gigabyte-wmi: add support for B550 Aorus Elite V2

Tony Luck (1):
      dmaengine: idxd: Change license on idxd.h to LGPL

Victor Lu (2):
      drm/amd/display: Guard DST_Y_PREFETCH register overflow in DCN21
      drm/amd/display: Add missing DCN21 IP parameter

Vitaly Kuznetsov (4):
      KVM: nSVM: Rename nested_svm_vmloadsave() to svm_copy_vmloadsave_stat=
e()
      KVM: nSVM: Swap the parameter order for
svm_copy_vmrun_state()/svm_copy_vmloadsave_state()
      KVM: Documentation: Fix KVM_CAP_ENFORCE_PV_FEATURE_CPUID name
      KVM: x86: Check the right feature bit for MSR_KVM_ASYNC_PF_ACK access

Vladimir Oltean (1):
      net: dsa: mv88e6xxx: silently accept the deletion of VID 0 too

Wang Hai (3):
      tulip: windbond-840: Fix missing pci_disable_device() in probe and re=
move
      sis900: Fix missing pci_disable_device() in probe and remove
      mm/memcg: fix NULL pointer dereference in memcg_slab_free_hook()

Xin Long (4):
      tipc: fix implicit-connect for SYN+
      tipc: do not write skb_shinfo frags when doing decrytion
      sctp: improve the code for pmtu probe send and recv update
      sctp: send pmtu probe only if packet loss in Search Complete state

Yang Yingliang (2):
      platform/x86: amd-pmc: Fix missing unlock on error in amd_pmc_send_cm=
d()
      workqueue: fix UAF in pwq_unbound_release_workfn()

Ye Xiang (1):
      HID: intel-ish-hid: use async resume function

Yu Kuai (1):
      reiserfs: add check for root_inode in reiserfs_fill_super

Yufeng Mo (1):
      net: hns3: change the method of obtaining default ptp cycle

Zhang Changzhong (1):
      can: j1939: j1939_xtp_rx_dat_one(): fix rxtimer value between
consecutive TP.DT to 750ms

Zheng Yongjun (1):
      alpha: convert comma to semicolon

Zhu Yanjun (4):
      RDMA/irdma: Change the returned type to void
      RDMA/irdma: change the returned type of
irdma_sc_repost_aeq_entries to void
      RDMA/irdma: Change the returned type of irdma_set_hw_rsrc to void
      RDMA/irdma: Change returned type of irdma_setup_virt_qp to void

Ziyang Xuan (1):
      can: raw: raw_setsockopt(): fix raw_rcv panic for sock UAF

gushengxian (2):
      alpha: Remove space between * and parameter name
      alpha: fix spelling mistakes

tangchunyou (1):
      alpha: fix typos in a comment

zhang kai (1):
      net: let flow have same hash in two directions
