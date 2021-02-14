Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6020A31B31C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 23:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhBNWqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 17:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhBNWqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 17:46:13 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4B6C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 14:45:32 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id e17so5673216ljl.8
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 14:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=g+rx6KLAXX5jMCRXVNm65arMhg1sZrzqetlf7vVa1sY=;
        b=Vjy4UP7wuIQnjv8MCT2j0wjQdNJX3mcoJa4NU2yywkvf5vLbzbsrzi00QLD52bmxai
         cafAvXn/Vw8E/loVWR21ZACIJeg7h5fzU8NcyqRREgrBdWe03Puxs+0zjYWX42oz1sU5
         GmlVmD3Bj1kWrimLJ4uEPHM82yShX3yv1+QoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=g+rx6KLAXX5jMCRXVNm65arMhg1sZrzqetlf7vVa1sY=;
        b=q82QvD21S0X661H86DEbT09BoUzmIML8hfKJke+bI/G1IOZK2tHrbWPaT+W9hTL4S3
         i7jmExsqNoWWjxm28o/ECD9nGJ1bV5ItflZzqJOykR2uHOVIpUX9Z03N/xC5dt/Hy0f3
         dplCDfPcOPZCPeux3THzkPfSb5l7tMyVS1y+0lv0u6UV73caQ0J8kuIY1PwH8S/SAPOT
         TTVVKv1QSa3GzsLoaflG7T+Brh7JNcSSA+4tdW9A05/WmnpFDpwdic2fF8x6frBMCXVB
         drq876PcKAdOn7uitpoipwlOBndqriXO65ZFFxj4WUEc2oA5D8Ujo+7CguEia/XteeU/
         wGOA==
X-Gm-Message-State: AOAM530v0AUP+1UOUZSQX+XAE4aB2TGz41T7+aAKj+rzO4HP/m5O7M6u
        W5J9PI0/gwjzdSgCxqU02fnb1w4aGwKDXA==
X-Google-Smtp-Source: ABdhPJxzxPhmACtrYQmm5gN31bHGZW92ZlqKCHyyVUv6Bdh7Gqs6clfAx2d/G6q3cZEFW3qklxXHnQ==
X-Received: by 2002:a2e:a54f:: with SMTP id e15mr7875524ljn.441.1613342730746;
        Sun, 14 Feb 2021 14:45:30 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id b7sm3411151ljk.52.2021.02.14.14.45.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Feb 2021 14:45:30 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id v30so7524525lfq.6
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 14:45:30 -0800 (PST)
X-Received: by 2002:a19:6916:: with SMTP id e22mr6934880lfc.421.1613342729666;
 Sun, 14 Feb 2021 14:45:29 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Feb 2021 14:45:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg8LpRi9+P2_V+ehJ2_EoJifNh2QmVf47aLXfkCd-1UAQ@mail.gmail.com>
Message-ID: <CAHk-=wg8LpRi9+P2_V+ehJ2_EoJifNh2QmVf47aLXfkCd-1UAQ@mail.gmail.com>
Subject: Linux 5.11
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing unexpected or particularly scary happened this week, so here
we are - with 5.11 tagged and pushed out.

In fact, it's a smaller-than-average set of commits from rc7 to final,
which makes me happy. And I already have several pull requests lined
up for tomorrow, so we're all set for the merge window to start.

But in the meantime - and yes, I know it's Valentine's Day here in the
US - maybe give this release a good testing before you go back and
play with development kernels. All right? Because I'm sure your SO
will understand.

            Linus

---

Alain Volmat (1):
      i2c: stm32f7: fix configuration of the digital filter

Alex Deucher (1):
      Revert "drm/amd/display: Update NV1x SR latency values"

Alex Elder (1):
      net: ipa: set error code in gsi_channel_setup()

Alexei Starovoitov (1):
      bpf: Unbreak BPF_PROG_TYPE_KPROBE when kprobe is called via do_int3

Andrea Parri (Microsoft) (1):
      hv_netvsc: Reset the RSC count if NVSP_STAT_FAIL in netvsc_receive()

Andrey Konovalov (4):
      kasan: fix stack traces dependency for HW_TAGS
      MAINTAINERS: update KASAN file list
      MAINTAINERS: update Andrey Konovalov's email address
      MAINTAINERS: add Andrey Konovalov to KASAN reviewers

Andrey Ryabinin (1):
      MAINTAINERS: update Andrey Ryabinin's email address

Aneesh Kumar K.V (1):
      powerpc/kuap: Allow kernel thread to access userspace after kthread_u=
se_mm

Ard Biesheuvel (1):
      Revert "ACPICA: Interpreter: fix memory leak by using existing buffer=
"

Arnd Bergmann (3):
      ath9k: fix build error with LEDS_CLASS=3Dm
      mm/mremap: fix BUILD_BUG_ON() error in get_extent
      leds: rt8515: add V4L2_FLASH_LED_CLASS dependency

Borislav Petkov (1):
      x86/build: Disable CET instrumentation in the kernel for 32-bit too

Bui Quang Minh (1):
      bpf: Check for integer overflow when using roundup_pow_of_two()

Camelia Groza (3):
      dpaa_eth: reserve space for the xdp_frame under the A050385 erratum
      dpaa_eth: reduce data alignment requirements for the A050385 erratum
      dpaa_eth: try to move the data in place for the A050385 erratum

Catalin Marinas (1):
      arm64: mte: Allow PTRACE_PEEKMTETAGS access to the zero page

Cezary Rojewski (1):
      dmaengine dw: Revert "dmaengine: dw: Enable runtime PM"

Chen Zhou (1):
      cgroup-v1: add disabled controller check in cgroup1_parse_param()

Christian K=C3=B6nig (1):
      drm/ttm: make sure pool pages are cleared

Christoph Schemmel (1):
      NET: usb: qmi_wwan: Adding support for Cinterion MV31

Christophe JAILLET (1):
      dmaengine: ti: k3-udma: Fix a resource leak in an error handling path

Daniel Borkmann (3):
      bpf: Fix verifier jsgt branch analysis on max bound
      bpf: Fix verifier jmp32 pruning decision logic
      bpf: Fix 32 bit src register truncation on div/mod

Dave Jiang (4):
      dmaengine: idxd: Fix list corruption in description completion
      dmaengine: idxd: fix misc interrupt completion
      dmaengine: move channel device_node deletion to driver
      dmaengine: idxd: check device state before issue command

David Howells (1):
      rxrpc: Fix clearance of Tx/Rx ring when releasing a call

Edwin Peer (1):
      net: watchdog: hold device global xmit lock during tx disable

Eric Dumazet (1):
      net: gro: do not keep too many GRO packets in napi->rx_list

Fabian Frederick (1):
      selftests: netfilter: fix current year

Fangrui Song (1):
      firmware_loader: align .builtin_fw to 8

Florian Westphal (1):
      netfilter: conntrack: skip identical origin tuple in same zone only

Geert Uytterhoeven (1):
      gpio: mxs: GPIO_MXS should not default to y unconditionally

Horatiu Vultur (2):
      bridge: mrp: Fix the usage of br_mrp_port_switchdev_set_state
      switchdev: mrp: Remove SWITCHDEV_ATTR_ID_MRP_PORT_STAT

Imre Deak (2):
      drm/dp_mst: Don't report ports connected if nothing is attached to th=
em
      drm/i915/tgl+: Make sure TypeC FIA is powered up when initializing it

Jarkko Sakkinen (1):
      x86/sgx: Maintain encl->refcount for each encl->mm_list entry

Jens Axboe (1):
      Revert "io_uring: don't take fs for recvmsg/sendmsg"

Jernej Skrabec (5):
      drm/sun4i: tcon: set sync polarity for tcon1 channel
      drm/sun4i: dw-hdmi: always set clock rate
      drm/sun4i: Fix H6 HDMI PHY configuration
      drm/sun4i: dw-hdmi: Fix max. frequency for H6
      clk: sunxi-ng: mp: fix parent rate change flag check

Joachim Henke (1):
      nilfs2: make splice write available again

Johannes Weiner (1):
      Revert "mm: memcontrol: avoid workload stalls when lowering memory.hi=
gh"

Jozsef Kadlecsik (1):
      netfilter: xt_recent: Fix attempt to update deleted entry

Juergen Gross (1):
      xen/netback: avoid race in xenvif_rx_ring_slots_available()

Julien Grall (1):
      arm/xen: Don't probe xenbus as part of an early initcall

Linus Torvalds (1):
      Linux 5.11

Lorenzo Bianconi (1):
      mt76: dma: fix a possible memory leak in mt76_add_fragment()

Masahiro Yamada (2):
      kbuild: fix CONFIG_TRIM_UNUSED_KSYMS build for ppc64
      sparc: remove wrong comment from arch/sparc/include/asm/Kbuild

Maurizio Lombardi (1):
      scsi: scsi_debug: Fix a memory leak

Maxime Ripard (1):
      drm/vc4: hvs: Fix buffer overflow with the dlist handling

Mike Rapoport (1):
      m68k: make __pfn_to_phys() and __phys_to_pfn() available for !MMU

Mohammad Athari Bin Ismail (1):
      net: stmmac: set TxQ mode back to DCB after disabling CBS

Nathan Chancellor (1):
      i3c/master/mipi-i3c-hci: Fix position of __maybe_unused in
i3c_hci_of_match

NeilBrown (1):
      net: fix iteration for sctp transport seq_files

Nikita Shubin (2):
      gpio: ep93xx: fix BUG_ON port F usage
      gpio: ep93xx: Fix single irqchip with multi gpiochips

Norbert Slusarek (2):
      net/vmw_vsock: fix NULL pointer dereference
      net/vmw_vsock: improve locking in vsock_connect_timeout()

Odin Ugedal (2):
      cgroup: fix psi monitor for root cgroup
      cgroup: update PSI file description in docs

Pablo Neira Ayuso (2):
      netfilter: nftables: fix possible UAF over chains from packet
path in netns
      netfilter: nftables: relax check for stateful expressions in set
definition

Palmer Dabbelt (1):
      Revert "dts: phy: add GPIO number and active state used for phy reset=
"

Phillip Lougher (4):
      squashfs: avoid out of bounds writes in decompressors
      squashfs: add more sanity checks in id lookup
      squashfs: add more sanity checks in inode lookup
      squashfs: add more sanity checks in xattr id lookup

Quanyang Wang (1):
      drm/xlnx: fix kmemleak by sending vblank_event in atomic_disable

Rafael J. Wysocki (2):
      cpufreq: ACPI: Extend frequency tables to cover boost frequencies
      cpufreq: ACPI: Update arch scale-invariance max perf ratio if
CPPC is not there

Raju Rangoju (1):
      cxgb4: Add new T6 PCI device id 0x6092

Randy Dunlap (1):
      h8300: fix PREEMPTION build, TI_PRE_COUNT undefined

Rolf Eike Beer (1):
      scripts: set proper OpenSSL include dir also for sign-file

Rong Chen (2):
      selftests/vm: rename file run_vmtests to run_vmtests.sh
      scripts/recordmcount.pl: support big endian for ARCH sh

Ronnie Sahlberg (3):
      cifs: fix dfs-links
      cifs: do not disable noperm if multiuser mount option is not provided
      cifs: In the new mount api we get the full devname as source=3D

Sabyrzhan Tasbolatov (1):
      net/qrtr: restrict user-controlled length in qrtr_tun_write_iter()

Seth Forshee (2):
      tmpfs: disallow CONFIG_TMPFS_INODE64 on s390
      tmpfs: disallow CONFIG_TMPFS_INODE64 on alpha

Shay Agroskin (1):
      net: ena: Update XDP verdict upon failure

Shyam Prasad N (1):
      cifs: Set CIFS_MOUNT_USE_PREFIX_PATH flag on setting cifs_sb->prepath=
.

Stefano Garzarella (2):
      vsock/virtio: update credit only if socket is not closed
      vsock: fix locking in vsock_shutdown()

Steven Rostedt (VMware) (2):
      tracing: Do not count ftrace events in top level enable output
      tracing: Check length before giving out the filter buffer

Su Yue (1):
      btrfs: initialize fs_info::csum_size earlier in open_ctree

Sukadev Bhattiprolu (1):
      ibmvnic: Clear failover_pending if unable to schedule

Sven Auhagen (1):
      netfilter: flowtable: fix tcp and udp header checksum update

Thomas Gleixner (1):
      x86/pci: Create PCI/MSI irqdomain after x86_init.pci.arch_init()

Vadim Fedorenko (2):
      selftests/tls: fix selftest with CHACHA20-POLY1305
      selftests: txtimestamp: fix compilation issue

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Fix overlay frontbuffer tracking

Vladimir Oltean (3):
      net: enetc: initialize the RFS and RSS memories
      net: dsa: call teardown method on probe failure
      net: dsa: felix: implement port flushing on .phylink_mac_link_down

Vlastimil Babka (1):
      mm, slub: better heuristic for number of cpus when calculating slab o=
rder

Willem de Bruijn (1):
      udp: fix skb_copy_and_csum_datagram with odd segment sizes

Xie He (1):
      net: hdlc_x25: Return meaningful error code in x25_open

Yufeng Mo (3):
      net: hns3: add a check for queue_id in hclge_reset_vf_queue()
      net: hns3: add a check for tqp_index in hclge_get_ring_chain_from_mbx=
()
      net: hns3: add a check for index in hclge_get_rss_key()

Zefan Li (2):
      MAINTAINERS: Remove stale URLs for cpuset
      MAINTAINERS: Update my email address
