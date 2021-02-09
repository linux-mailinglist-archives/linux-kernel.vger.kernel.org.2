Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A0C31467C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 03:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhBICgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 21:36:09 -0500
Received: from mga04.intel.com ([192.55.52.120]:57305 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229706AbhBICfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 21:35:43 -0500
IronPort-SDR: 5fsilc8PAaFskLAFRuVBG4pM8ti461SoLyFmoFKTp3F72sY1TfReYUnsUKIz/Lr8NayHqVkCWt
 PWY1DJgj2P/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="179258445"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="xz'?yaml'?scan'208";a="179258445"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 18:34:51 -0800
IronPort-SDR: KGC/jq7blMntaCXcgQ8YFpmXt8G/A7/mBC0zNu46iBqhsJiXxxZK5X4h+KB8LMyUPrx1vXu94y
 qPD4OFm6eoTw==
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="xz'?yaml'?scan'208";a="395870272"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 18:34:42 -0800
Date:   Tue, 9 Feb 2021 10:50:21 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     0day robot <lkp@intel.com>, Jann Horn <jannh@google.com>,
        Len Brown <len.brown@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        bp@suse.de, tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
        x86@kernel.org, dave.hansen@intel.com, hjl.tools@gmail.com,
        Dave.Martin@arm.com, mpe@ellerman.id.au, carlos@redhat.com,
        tony.luck@intel.com, ravi.v.shankar@intel.com,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, chang.seok.bae@intel.com
Subject: [x86/signal]  dc8df6e85d: kernel-selftests.sigaltstack.sas.fail
Message-ID: <20210209025021.GA13872@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20210203172242.29644-5-chang.seok.bae@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5 ("x86/signal: Detect and p=
revent an alternate signal stack overflow")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git Chang-S-Bae=
/x86-Improve-Minimum-Alternate-Stack-Size/20210204-013311


in testcase: kernel-selftests
version: kernel-selftests-x86_64-b553cffa-1_20210122
with following parameters:

	group: group-s
	ucode: 0xe2

test-description: The kernel contains a set of "self tests" under the tools=
/testing/selftests/ directory. These are intended to be small unit tests to=
 exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz with 32G=
 memory

caused below changes (please refer to attached dmesg/kmsg for entire log/ba=
cktrace):




If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-7=
=2E6-kselftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5
2021-02-07 21:51:40 ln -sf /usr/bin/clang
2021-02-07 21:51:40 ln -sf /usr/bin/llc
2021-02-07 21:51:40 sed -i s/default_timeout=3D45/default_timeout=3D300/ ks=
elftest/runner.sh
safesetid test: not in Makefile
2021-02-07 21:51:40 make TARGETS=3Dsafesetid
make --no-builtin-rules ARCH=3Dx86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5'
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/unifdef
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/x86/include/generated/uapi/asm/errno.h
  WRAP    arch/x86/include/generated/uapi/asm/fcntl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctls.h
  WRAP    arch/x86/include/generated/uapi/asm/ipcbuf.h
  WRAP    arch/x86/include/generated/uapi/asm/param.h
  WRAP    arch/x86/include/generated/uapi/asm/poll.h
  WRAP    arch/x86/include/generated/uapi/asm/resource.h
  WRAP    arch/x86/include/generated/uapi/asm/socket.h
  WRAP    arch/x86/include/generated/uapi/asm/sockios.h
  WRAP    arch/x86/include/generated/uapi/asm/termbits.h
  WRAP    arch/x86/include/generated/uapi/asm/termios.h
  WRAP    arch/x86/include/generated/uapi/asm/types.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
  UPD     include/generated/uapi/linux/version.h
  HDRINST usr/include/video/sisfb.h
  HDRINST usr/include/video/uvesafb.h
  HDRINST usr/include/video/edid.h
  HDRINST usr/include/drm/i810_drm.h
  HDRINST usr/include/drm/exynos_drm.h
  HDRINST usr/include/drm/msm_drm.h
  HDRINST usr/include/drm/lima_drm.h
  HDRINST usr/include/drm/nouveau_drm.h
  HDRINST usr/include/drm/via_drm.h
  HDRINST usr/include/drm/vmwgfx_drm.h
  HDRINST usr/include/drm/virtgpu_drm.h
  HDRINST usr/include/drm/omap_drm.h
  HDRINST usr/include/drm/amdgpu_drm.h
  HDRINST usr/include/drm/drm.h
  HDRINST usr/include/drm/r128_drm.h
  HDRINST usr/include/drm/drm_fourcc.h
  HDRINST usr/include/drm/qxl_drm.h
  HDRINST usr/include/drm/sis_drm.h
  HDRINST usr/include/drm/armada_drm.h
  HDRINST usr/include/drm/panfrost_drm.h
  HDRINST usr/include/drm/v3d_drm.h
  HDRINST usr/include/drm/vc4_drm.h
  HDRINST usr/include/drm/etnaviv_drm.h
  HDRINST usr/include/drm/savage_drm.h
  HDRINST usr/include/drm/i915_drm.h
  HDRINST usr/include/drm/tegra_drm.h
  HDRINST usr/include/drm/vgem_drm.h
  HDRINST usr/include/drm/radeon_drm.h
  HDRINST usr/include/drm/drm_mode.h
  HDRINST usr/include/drm/drm_sarea.h
  HDRINST usr/include/drm/mga_drm.h
  HDRINST usr/include/mtd/mtd-abi.h
  HDRINST usr/include/mtd/nftl-user.h
  HDRINST usr/include/mtd/ubi-user.h
  HDRINST usr/include/mtd/inftl-user.h
  HDRINST usr/include/mtd/mtd-user.h
  HDRINST usr/include/xen/privcmd.h
  HDRINST usr/include/xen/evtchn.h
  HDRINST usr/include/xen/gntalloc.h
  HDRINST usr/include/xen/gntdev.h
  HDRINST usr/include/asm-generic/ipcbuf.h
  HDRINST usr/include/asm-generic/statfs.h
  HDRINST usr/include/asm-generic/int-l64.h
  HDRINST usr/include/asm-generic/termbits.h
  HDRINST usr/include/asm-generic/errno.h
  HDRINST usr/include/asm-generic/sembuf.h
  HDRINST usr/include/asm-generic/ucontext.h
  HDRINST usr/include/asm-generic/hugetlb_encode.h
  HDRINST usr/include/asm-generic/signal-defs.h
  HDRINST usr/include/asm-generic/poll.h
  HDRINST usr/include/asm-generic/termios.h
  HDRINST usr/include/asm-generic/socket.h
  HDRINST usr/include/asm-generic/ioctl.h
  HDRINST usr/include/asm-generic/sockios.h
  HDRINST usr/include/asm-generic/fcntl.h
  HDRINST usr/include/asm-generic/msgbuf.h
  HDRINST usr/include/asm-generic/kvm_para.h
  HDRINST usr/include/asm-generic/bpf_perf_event.h
  HDRINST usr/include/asm-generic/bitsperlong.h
  HDRINST usr/include/asm-generic/errno-base.h
  HDRINST usr/include/asm-generic/mman.h
  HDRINST usr/include/asm-generic/siginfo.h
  HDRINST usr/include/asm-generic/mman-common.h
  HDRINST usr/include/asm-generic/setup.h
  HDRINST usr/include/asm-generic/resource.h
  HDRINST usr/include/asm-generic/param.h
  HDRINST usr/include/asm-generic/swab.h
  HDRINST usr/include/asm-generic/posix_types.h
  HDRINST usr/include/asm-generic/types.h
  HDRINST usr/include/asm-generic/auxvec.h
  HDRINST usr/include/asm-generic/signal.h
  HDRINST usr/include/asm-generic/int-ll64.h
  HDRINST usr/include/asm-generic/ioctls.h
  HDRINST usr/include/asm-generic/unistd.h
  HDRINST usr/include/asm-generic/shmbuf.h
  HDRINST usr/include/asm-generic/stat.h
  HDRINST usr/include/rdma/ib_user_ioctl_verbs.h
  HDRINST usr/include/rdma/rdma_user_cm.h
  HDRINST usr/include/rdma/cxgb4-abi.h
  HDRINST usr/include/rdma/hns-abi.h
  HDRINST usr/include/rdma/i40iw-abi.h
  HDRINST usr/include/rdma/siw-abi.h
  HDRINST usr/include/rdma/ocrdma-abi.h
  HDRINST usr/include/rdma/hfi/hfi1_user.h
  HDRINST usr/include/rdma/hfi/hfi1_ioctl.h
  HDRINST usr/include/rdma/rdma_user_ioctl.h
  HDRINST usr/include/rdma/bnxt_re-abi.h
  HDRINST usr/include/rdma/ib_user_mad.h
  HDRINST usr/include/rdma/rdma_user_rxe.h
  HDRINST usr/include/rdma/mthca-abi.h
  HDRINST usr/include/rdma/rdma_netlink.h
  HDRINST usr/include/rdma/ib_user_ioctl_cmds.h
  HDRINST usr/include/rdma/rdma_user_ioctl_cmds.h
  HDRINST usr/include/rdma/qedr-abi.h
  HDRINST usr/include/rdma/ib_user_sa.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_verbs.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_cmds.h
  HDRINST usr/include/rdma/vmw_pvrdma-abi.h
  HDRINST usr/include/rdma/mlx4-abi.h
  HDRINST usr/include/rdma/rvt-abi.h
  HDRINST usr/include/rdma/efa-abi.h
  HDRINST usr/include/rdma/mlx5-abi.h
  HDRINST usr/include/rdma/ib_user_verbs.h
  HDRINST usr/include/misc/xilinx_sdfec.h
  HDRINST usr/include/misc/pvpanic.h
  HDRINST usr/include/misc/habanalabs.h
  HDRINST usr/include/misc/fastrpc.h
  HDRINST usr/include/misc/ocxl.h
  HDRINST usr/include/misc/cxl.h
  HDRINST usr/include/misc/uacce/uacce.h
  HDRINST usr/include/misc/uacce/hisi_qm.h
  HDRINST usr/include/linux/sed-opal.h
  HDRINST usr/include/linux/qnx4_fs.h
  HDRINST usr/include/linux/if_cablemodem.h
  HDRINST usr/include/linux/auto_fs4.h
  HDRINST usr/include/linux/toshiba.h
  HDRINST usr/include/linux/arm_sdei.h
  HDRINST usr/include/linux/mmtimer.h
  HDRINST usr/include/linux/devlink.h
  HDRINST usr/include/linux/joystick.h
  HDRINST usr/include/linux/ultrasound.h
  HDRINST usr/include/linux/rio_mport_cdev.h
  HDRINST usr/include/linux/userfaultfd.h
  HDRINST usr/include/linux/dvb/version.h
  HDRINST usr/include/linux/dvb/net.h
  HDRINST usr/include/linux/dvb/video.h
  HDRINST usr/include/linux/dvb/dmx.h
  HDRINST usr/include/linux/dvb/frontend.h
  HDRINST usr/include/linux/dvb/audio.h
  HDRINST usr/include/linux/dvb/osd.h
  HDRINST usr/include/linux/dvb/ca.h
  HDRINST usr/include/linux/ip6_tunnel.h
  HDRINST usr/include/linux/sock_diag.h
  HDRINST usr/include/linux/in.h
  HDRINST usr/include/linux/efs_fs_sb.h
  HDRINST usr/include/linux/tty.h
  HDRINST usr/include/linux/nfs_mount.h
  HDRINST usr/include/linux/kd.h
  HDRINST usr/include/linux/arcfb.h
  HDRINST usr/include/linux/membarrier.h
  HDRINST usr/include/linux/nfs_fs.h
  HDRINST usr/include/linux/vsockmon.h
  HDRINST usr/include/linux/netfilter_ipv4.h
  HDRINST usr/include/linux/ipv6_route.h
  HDRINST usr/include/linux/virtio_scsi.h
  HDRINST usr/include/linux/edd.h
  HDRINST usr/include/linux/atmarp.h
  HDRINST usr/include/linux/atm_eni.h
  HDRINST usr/include/linux/auto_fs.h
  HDRINST usr/include/linux/virtio_ring.h
  HDRINST usr/include/linux/iio/events.h
  HDRINST usr/include/linux/iio/types.h
  HDRINST usr/include/linux/libc-compat.h
  HDRINST usr/include/linux/futex.h
  HDRINST usr/include/linux/isst_if.h
  HDRINST usr/include/linux/net_namespace.h
  HDRINST usr/include/linux/fb.h
  HDRINST usr/include/linux/vboxguest.h
  HDRINST usr/include/linux/fadvise.h
  HDRINST usr/include/linux/seg6_genl.h
  HDRINST usr/include/linux/times.h
  HDRINST usr/include/linux/hsr_netlink.h
  HDRINST usr/include/linux/llc.h
  HDRINST usr/include/linux/uuid.h
  HDRINST usr/include/linux/nvme_ioctl.h
  HDRINST usr/include/linux/watchdog.h
  HDRINST usr/include/linux/tipc.h
  HDRINST usr/include/linux/capability.h
  HDRINST usr/include/linux/dm-ioctl.h
  HDRINST usr/include/linux/nbd-netlink.h
  HDRINST usr/include/linux/virtio_mem.h
  HDRINST usr/include/linux/hid.h
  HDRINST usr/include/linux/am437x-vpfe.h
  HDRINST usr/include/linux/rio_cm_cdev.h
  HDRINST usr/include/linux/cgroupstats.h
  HDRINST usr/include/linux/affs_hardblocks.h
  HDRINST usr/include/linux/net.h
  HDRINST usr/include/linux/virtio_input.h
  HDRINST usr/include/linux/blkpg.h
  HDRINST usr/include/linux/fd.h
  HDRINST usr/include/linux/cciss_defs.h
  HDRINST usr/include/linux/errno.h
  HDRINST usr/include/linux/ivtv.h
  HDRINST usr/include/linux/netlink.h
  HDRINST usr/include/linux/serial_reg.h
  HDRINST usr/include/linux/radeonfb.h
  HDRINST usr/include/linux/vm_sockets_diag.h
  HDRINST usr/include/linux/lwtunnel.h
  HDRINST usr/include/linux/time.h
  HDRINST usr/include/linux/pci_regs.h
  HDRINST usr/include/linux/perf_event.h
  HDRINST usr/include/linux/virtio_gpu.h
  HDRINST usr/include/linux/magic.h
  HDRINST usr/include/linux/close_range.h
  HDRINST usr/include/linux/v4l2-mediabus.h
  HDRINST usr/include/linux/ax25.h
  HDRINST usr/include/linux/binfmts.h
  HDRINST usr/include/linux/hdlc.h
  HDRINST usr/include/linux/cfm_bridge.h
  HDRINST usr/include/linux/v4l2-controls.h
  HDRINST usr/include/linux/mptcp.h
  HDRINST usr/include/linux/ndctl.h
  HDRINST usr/include/linux/mpls_iptunnel.h
  HDRINST usr/include/linux/a.out.h
  HDRINST usr/include/linux/nfsacl.h
  HDRINST usr/include/linux/rpmsg.h
  HDRINST usr/include/linux/seg6_iptunnel.h
  HDRINST usr/include/linux/netfilter_ipv6.h
  HDRINST usr/include/linux/tiocl.h
  HDRINST usr/include/linux/rpl.h
  HDRINST usr/include/linux/stm.h
  HDRINST usr/include/linux/qrtr.h
  HDRINST usr/include/linux/soundcard.h
  HDRINST usr/include/linux/route.h
  HDRINST usr/include/linux/hw_breakpoint.h
  HDRINST usr/include/linux/nfs4.h
  HDRINST usr/include/linux/keyctl.h
  HDRINST usr/include/linux/pktcdvd.h
  HDRINST usr/include/linux/android/binder.h
  HDRINST usr/include/linux/android/binderfs.h
  HDRINST usr/include/linux/firewire-cdev.h
  HDRINST usr/include/linux/mroute6.h
  HDRINST usr/include/linux/nilfs2_ondisk.h
  HDRINST usr/include/linux/zorro_ids.h
  HDRINST usr/include/linux/fsi.h
  HDRINST usr/include/linux/remoteproc_cdev.h
  HDRINST usr/include/linux/mrp_bridge.h
  HDRINST usr/include/linux/lirc.h
  HDRINST usr/include/linux/loop.h
  HDRINST usr/include/linux/cm4000_cs.h
  HDRINST usr/include/linux/inotify.h
  HDRINST usr/include/linux/prctl.h
  HDRINST usr/include/linux/aspeed-p2a-ctrl.h
  HDRINST usr/include/linux/hpet.h
  HDRINST usr/include/linux/synclink.h
  HDRINST usr/include/linux/reiserfs_xattr.h
  HDRINST usr/include/linux/if_fc.h
  HDRINST usr/include/linux/patchkey.h
  HDRINST usr/include/linux/mroute.h
  HDRINST usr/include/linux/if_slip.h
  HDRINST usr/include/linux/dn.h
  HDRINST usr/include/linux/batadv_packet.h
  HDRINST usr/include/linux/kernel-page-flags.h
  HDRINST usr/include/linux/ipx.h
  HDRINST usr/include/linux/signalfd.h
  HDRINST usr/include/linux/elf.h
  HDRINST usr/include/linux/tty_flags.h
  HDRINST usr/include/linux/phonet.h
  HDRINST usr/include/linux/tipc_sockets_diag.h
  HDRINST usr/include/linux/pmu.h
  HDRINST usr/include/linux/ip.h
  HDRINST usr/include/linux/nfs3.h
  HDRINST usr/include/linux/rseq.h
  HDRINST usr/include/linux/meye.h
  HDRINST usr/include/linux/firewire-constants.h
  HDRINST usr/include/linux/bt-bmc.h
  HDRINST usr/include/linux/vt.h
  HDRINST usr/include/linux/can.h
  HDRINST usr/include/linux/atm_idt77105.h
  HDRINST usr/include/linux/uleds.h
  HDRINST usr/include/linux/audit.h
  HDRINST usr/include/linux/ptrace.h
  HDRINST usr/include/linux/virtio_mmio.h
  HDRINST usr/include/linux/poll.h
  HDRINST usr/include/linux/if.h
  HDRINST usr/include/linux/vhost.h
  HDRINST usr/include/linux/nitro_enclaves.h
  HDRINST usr/include/linux/kfd_ioctl.h
  HDRINST usr/include/linux/serial_core.h
  HDRINST usr/include/linux/if_addrlabel.h
  HDRINST usr/include/linux/if_arcnet.h
  HDRINST usr/include/linux/btrfs.h
  HDRINST usr/include/linux/serio.h
  HDRINST usr/include/linux/sctp.h
  HDRINST usr/include/linux/const.h
  HDRINST usr/include/linux/nexthop.h
  HDRINST usr/include/linux/tc_act/tc_gact.h
  HDRINST usr/include/linux/tc_act/tc_bpf.h
  HDRINST usr/include/linux/tc_act/tc_ipt.h
  HDRINST usr/include/linux/tc_act/tc_ct.h
  HDRINST usr/include/linux/tc_act/tc_gate.h
  HDRINST usr/include/linux/tc_act/tc_skbedit.h
  HDRINST usr/include/linux/tc_act/tc_skbmod.h
  HDRINST usr/include/linux/tc_act/tc_ife.h
  HDRINST usr/include/linux/tc_act/tc_sample.h
  HDRINST usr/include/linux/tc_act/tc_mpls.h
  HDRINST usr/include/linux/tc_act/tc_nat.h
  HDRINST usr/include/linux/tc_act/tc_tunnel_key.h
  HDRINST usr/include/linux/tc_act/tc_connmark.h
  HDRINST usr/include/linux/tc_act/tc_ctinfo.h
  HDRINST usr/include/linux/tc_act/tc_defact.h
  HDRINST usr/include/linux/tc_act/tc_vlan.h
  HDRINST usr/include/linux/tc_act/tc_pedit.h
  HDRINST usr/include/linux/tc_act/tc_csum.h
  HDRINST usr/include/linux/tc_act/tc_mirred.h
  HDRINST usr/include/linux/netfilter_decnet.h
  HDRINST usr/include/linux/blktrace_api.h
  HDRINST usr/include/linux/termios.h
  HDRINST usr/include/linux/in6.h
  HDRINST usr/include/linux/sysctl.h
  HDRINST usr/include/linux/netfilter.h
  HDRINST usr/include/linux/tcp_metrics.h
  HDRINST usr/include/linux/socket.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6_tables.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_opts.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_HL.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_rt.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_srh.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_frag.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_LOG.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_mh.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_hl.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ipv6header.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_NPT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ah.h
  HDRINST usr/include/linux/wireguard.h
  HDRINST usr/include/linux/cyclades.h
  HDRINST usr/include/linux/uinput.h
  HDRINST usr/include/linux/kcov.h
  HDRINST usr/include/linux/bpfilter.h
  HDRINST usr/include/linux/nl80211.h
  HDRINST usr/include/linux/if_plip.h
  HDRINST usr/include/linux/mpls.h
  HDRINST usr/include/linux/dlm_device.h
  HDRINST usr/include/linux/n_r3964.h
  HDRINST usr/include/linux/kdev_t.h
  HDRINST usr/include/linux/ioctl.h
  HDRINST usr/include/linux/atmppp.h
  HDRINST usr/include/linux/scif_ioctl.h
  HDRINST usr/include/linux/fpga-dfl.h
  HDRINST usr/include/linux/tls.h
  HDRINST usr/include/linux/if_x25.h
  HDRINST usr/include/linux/string.h
  HDRINST usr/include/linux/nbd.h
  HDRINST usr/include/linux/pcitest.h
  HDRINST usr/include/linux/ivtvfb.h
  HDRINST usr/include/linux/ipsec.h
  HDRINST usr/include/linux/timerfd.h
  HDRINST usr/include/linux/acct.h
  HDRINST usr/include/linux/ip_vs.h
  HDRINST usr/include/linux/vfio_ccw.h
  HDRINST usr/include/linux/ethtool.h
  HDRINST usr/include/linux/gfs2_ondisk.h
  HDRINST usr/include/linux/dlm_netlink.h
  HDRINST usr/include/linux/isdn/capicmd.h
  HDRINST usr/include/linux/mei.h
  HDRINST usr/include/linux/uvcvideo.h
  HDRINST usr/include/linux/if_alg.h
  HDRINST usr/include/linux/atmsvc.h
  HDRINST usr/include/linux/io_uring.h
  HDRINST usr/include/linux/bcm933xx_hcs.h
  HDRINST usr/include/linux/if_link.h
  HDRINST usr/include/linux/connector.h
  HDRINST usr/include/linux/sockios.h
  HDRINST usr/include/linux/fcntl.h
  HDRINST usr/include/linux/filter.h
  HDRINST usr/include/linux/pr.h
  HDRINST usr/include/linux/securebits.h
  HDRINST usr/include/linux/kernel.h
  HDRINST usr/include/linux/xdp_diag.h
  HDRINST usr/include/linux/fanotify.h
  HDRINST usr/include/linux/v4l2-common.h
  HDRINST usr/include/linux/omapfb.h
  HDRINST usr/include/linux/nubus.h
  HDRINST usr/include/linux/videodev2.h
  HDRINST usr/include/linux/i2c.h
  HDRINST usr/include/linux/gtp.h
  HDRINST usr/include/linux/virtio_types.h
  HDRINST usr/include/linux/nfs_idmap.h
  HDRINST usr/include/linux/sonet.h
  HDRINST usr/include/linux/kernelcapi.h
  HDRINST usr/include/linux/stddef.h
  HDRINST usr/include/linux/rose.h
  HDRINST usr/include/linux/virtio_rng.h
  HDRINST usr/include/linux/timex.h
  HDRINST usr/include/linux/virtio_config.h
  HDRINST usr/include/linux/sem.h
  HDRINST usr/include/linux/hdreg.h
  HDRINST usr/include/linux/smc.h
  HDRINST usr/include/linux/icmp.h
  HDRINST usr/include/linux/nsfs.h
  HDRINST usr/include/linux/l2tp.h
  HDRINST usr/include/linux/input-event-codes.h
  HDRINST usr/include/linux/mdio.h
  HDRINST usr/include/linux/virtio_console.h
  HDRINST usr/include/linux/netfilter_arp.h
  HDRINST usr/include/linux/if_tun.h
  HDRINST usr/include/linux/xilinx-v4l2-controls.h
  HDRINST usr/include/linux/apm_bios.h
  HDRINST usr/include/linux/if_fddi.h
  HDRINST usr/include/linux/nvram.h
  HDRINST usr/include/linux/kvm_para.h
  HDRINST usr/include/linux/fib_rules.h
  HDRINST usr/include/linux/blkzoned.h
  HDRINST usr/include/linux/btf.h
  HDRINST usr/include/linux/if_eql.h
  HDRINST usr/include/linux/if_ether.h
  HDRINST usr/include/linux/raid/md_u.h
  HDRINST usr/include/linux/raid/md_p.h
  HDRINST usr/include/linux/vm_sockets.h
  HDRINST usr/include/linux/dns_resolver.h
  HDRINST usr/include/linux/media.h
  HDRINST usr/include/linux/media-bus-format.h
  HDRINST usr/include/linux/memfd.h
  HDRINST usr/include/linux/if_pppol2tp.h
  HDRINST usr/include/linux/random.h
  HDRINST usr/include/linux/virtio_net.h
  HDRINST usr/include/linux/map_to_7segment.h
  HDRINST usr/include/linux/bpf_perf_event.h
  HDRINST usr/include/linux/caif/caif_socket.h
  HDRINST usr/include/linux/caif/if_caif.h
  HDRINST usr/include/linux/auto_dev-ioctl.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_among.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nflog.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_802_3.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_limit.h
  HDRINST usr/include/linux/netfilter_bridge/ebtables.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_redirect.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_pkttype.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_t.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arpreply.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_stp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_vlan.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip6.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nat.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_m.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_log.h
  HDRINST usr/include/linux/iommu.h
  HDRINST usr/include/linux/posix_acl_xattr.h
  HDRINST usr/include/linux/cciss_ioctl.h
  HDRINST usr/include/linux/screen_info.h
  HDRINST usr/include/linux/parport.h
  HDRINST usr/include/linux/mqueue.h
  HDRINST usr/include/linux/pidfd.h
  HDRINST usr/include/linux/dcbnl.h
  HDRINST usr/include/linux/pkt_cls.h
  HDRINST usr/include/linux/aspeed-lpc-ctrl.h
  HDRINST usr/include/linux/i2c-dev.h
  HDRINST usr/include/linux/i2o-dev.h
  HDRINST usr/include/linux/virtio_fs.h
  HDRINST usr/include/linux/vfio.h
  HDRINST usr/include/linux/rpl_iptunnel.h
  HDRINST usr/include/linux/dma-heap.h
  HDRINST usr/include/linux/ipv6.h
  HDRINST usr/include/linux/gen_stats.h
  HDRINST usr/include/linux/if_arp.h
  HDRINST usr/include/linux/hidraw.h
  HDRINST usr/include/linux/in_route.h
  HDRINST usr/include/linux/if_vlan.h
  HDRINST usr/include/linux/taskstats.h
  HDRINST usr/include/linux/virtio_ids.h
  HDRINST usr/include/linux/unix_diag.h
  HDRINST usr/include/linux/hsi/cs-protocol.h
  HDRINST usr/include/linux/hsi/hsi_char.h
  HDRINST usr/include/linux/nfc.h
  HDRINST usr/include/linux/erspan.h
  HDRINST usr/include/linux/lp.h
  HDRINST usr/include/linux/sound.h
  HDRINST usr/include/linux/reiserfs_fs.h
  HDRINST usr/include/linux/atm_zatm.h
  HDRINST usr/include/linux/netfilter_bridge.h
  HDRINST usr/include/linux/sync_file.h
  HDRINST usr/include/linux/cec.h
  HDRINST usr/include/linux/omap3isp.h
  HDRINST usr/include/linux/veth.h
  HDRINST usr/include/linux/qemu_fw_cfg.h
  HDRINST usr/include/linux/if_macsec.h
  HDRINST usr/include/linux/neighbour.h
  HDRINST usr/include/linux/mman.h
  HDRINST usr/include/linux/bpf_common.h
  HDRINST usr/include/linux/input.h
  HDRINST usr/include/linux/utime.h
  HDRINST usr/include/linux/hiddev.h
  HDRINST usr/include/linux/raw.h
  HDRINST usr/include/linux/if_infiniband.h
  HDRINST usr/include/linux/atmlec.h
  HDRINST usr/include/linux/ptp_clock.h
  HDRINST usr/include/linux/kvm.h
  HDRINST usr/include/linux/gpio.h
  HDRINST usr/include/linux/atalk.h
  HDRINST usr/include/linux/capi.h
  HDRINST usr/include/linux/ncsi.h
  HDRINST usr/include/linux/vmcore.h
  HDRINST usr/include/linux/if_phonet.h
  HDRINST usr/include/linux/seg6_local.h
  HDRINST usr/include/linux/vhost_types.h
  HDRINST usr/include/linux/spi/spidev.h
  HDRINST usr/include/linux/fuse.h
  HDRINST usr/include/linux/gsmmux.h
  HDRINST usr/include/linux/eventpoll.h
  HDRINST usr/include/linux/chio.h
  HDRINST usr/include/linux/phantom.h
  HDRINST usr/include/linux/nfs4_mount.h
  HDRINST usr/include/linux/byteorder/big_endian.h
  HDRINST usr/include/linux/byteorder/little_endian.h
  HDRINST usr/include/linux/selinux_netlink.h
  HDRINST usr/include/linux/atmapi.h
  HDRINST usr/include/linux/bsg.h
  HDRINST usr/include/linux/resource.h
  HDRINST usr/include/linux/ipc.h
  HDRINST usr/include/linux/netfilter/xt_CHECKSUM.h
  HDRINST usr/include/linux/netfilter/nf_nat.h
  HDRINST usr/include/linux/netfilter/xt_iprange.h
  HDRINST usr/include/linux/netfilter/xt_CONNSECMARK.h
  HDRINST usr/include/linux/netfilter/xt_mac.h
  HDRINST usr/include/linux/netfilter/xt_RATEEST.h
  HDRINST usr/include/linux/netfilter/xt_osf.h
  HDRINST usr/include/linux/netfilter/xt_NFLOG.h
  HDRINST usr/include/linux/netfilter/xt_ipvs.h
  HDRINST usr/include/linux/netfilter/nfnetlink_compat.h
  HDRINST usr/include/linux/netfilter/xt_u32.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cthelper.h
  HDRINST usr/include/linux/netfilter/xt_NFQUEUE.h
  HDRINST usr/include/linux/netfilter/xt_CLASSIFY.h
  HDRINST usr/include/linux/netfilter/nfnetlink_osf.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_bitmap.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_list.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_hash.h
  HDRINST usr/include/linux/netfilter/xt_dscp.h
  HDRINST usr/include/linux/netfilter/xt_IDLETIMER.h
  HDRINST usr/include/linux/netfilter/xt_physdev.h
  HDRINST usr/include/linux/netfilter/xt_time.h
  HDRINST usr/include/linux/netfilter/xt_MARK.h
  HDRINST usr/include/linux/netfilter/xt_conntrack.h
  HDRINST usr/include/linux/netfilter/nf_tables_compat.h
  HDRINST usr/include/linux/netfilter/nfnetlink_log.h
  HDRINST usr/include/linux/netfilter/nf_log.h
  HDRINST usr/include/linux/netfilter/xt_devgroup.h
  HDRINST usr/include/linux/netfilter/xt_DSCP.h
  HDRINST usr/include/linux/netfilter/xt_recent.h
  HDRINST usr/include/linux/netfilter/xt_TPROXY.h
  HDRINST usr/include/linux/netfilter/xt_cluster.h
  HDRINST usr/include/linux/netfilter/xt_realm.h
  HDRINST usr/include/linux/netfilter/xt_TCPMSS.h
  HDRINST usr/include/linux/netfilter/xt_pkttype.h
  HDRINST usr/include/linux/netfilter/xt_statistic.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cttimeout.h
  HDRINST usr/include/linux/netfilter/xt_addrtype.h
  HDRINST usr/include/linux/netfilter/xt_connbytes.h
  HDRINST usr/include/linux/netfilter/xt_rpfilter.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tuple_common.h
  HDRINST usr/include/linux/netfilter/xt_nfacct.h
  HDRINST usr/include/linux/netfilter/xt_LOG.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_sctp.h
  HDRINST usr/include/linux/netfilter/xt_tcpmss.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_ftp.h
  HDRINST usr/include/linux/netfilter/xt_l2tp.h
  HDRINST usr/include/linux/netfilter/xt_comment.h
  HDRINST usr/include/linux/netfilter/xt_state.h
  HDRINST usr/include/linux/netfilter/xt_policy.h
  HDRINST usr/include/linux/netfilter/xt_rateest.h
  HDRINST usr/include/linux/netfilter/xt_cgroup.h
  HDRINST usr/include/linux/netfilter/xt_hashlimit.h
  HDRINST usr/include/linux/netfilter/xt_CONNMARK.h
  HDRINST usr/include/linux/netfilter/xt_string.h
  HDRINST usr/include/linux/netfilter/xt_CT.h
  HDRINST usr/include/linux/netfilter/xt_length.h
  HDRINST usr/include/linux/netfilter/nfnetlink_queue.h
  HDRINST usr/include/linux/netfilter/xt_HMARK.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tcp.h
  HDRINST usr/include/linux/netfilter/xt_SYNPROXY.h
  HDRINST usr/include/linux/netfilter/nfnetlink_conntrack.h
  HDRINST usr/include/linux/netfilter/xt_multiport.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_common.h
  HDRINST usr/include/linux/netfilter/xt_sctp.h
  HDRINST usr/include/linux/netfilter/xt_cpu.h
  HDRINST usr/include/linux/netfilter/nfnetlink.h
  HDRINST usr/include/linux/netfilter/xt_limit.h
  HDRINST usr/include/linux/netfilter/xt_ipcomp.h
  HDRINST usr/include/linux/netfilter/xt_ecn.h
  HDRINST usr/include/linux/netfilter/xt_quota.h
  HDRINST usr/include/linux/netfilter/xt_connlimit.h
  HDRINST usr/include/linux/netfilter/xt_AUDIT.h
  HDRINST usr/include/linux/netfilter/nfnetlink_acct.h
  HDRINST usr/include/linux/netfilter/nf_synproxy.h
  HDRINST usr/include/linux/netfilter/xt_dccp.h
  HDRINST usr/include/linux/netfilter/xt_socket.h
  HDRINST usr/include/linux/netfilter/xt_LED.h
  HDRINST usr/include/linux/netfilter/xt_mark.h
  HDRINST usr/include/linux/netfilter/xt_SECMARK.h
  HDRINST usr/include/linux/netfilter/nf_tables.h
  HDRINST usr/include/linux/netfilter/xt_TEE.h
  HDRINST usr/include/linux/netfilter/xt_owner.h
  HDRINST usr/include/linux/netfilter/xt_bpf.h
  HDRINST usr/include/linux/netfilter/xt_esp.h
  HDRINST usr/include/linux/netfilter/xt_TCPOPTSTRIP.h
  HDRINST usr/include/linux/netfilter/xt_set.h
  HDRINST usr/include/linux/netfilter/xt_helper.h
  HDRINST usr/include/linux/netfilter/x_tables.h
  HDRINST usr/include/linux/netfilter/xt_connmark.h
  HDRINST usr/include/linux/netfilter/xt_connlabel.h
  HDRINST usr/include/linux/netfilter/xt_tcpudp.h
  HDRINST usr/include/linux/fs.h
  HDRINST usr/include/linux/cycx_cfm.h
  HDRINST usr/include/linux/baycom.h
  HDRINST usr/include/linux/param.h
  HDRINST usr/include/linux/keyboard.h
  HDRINST usr/include/linux/fou.h
  HDRINST usr/include/linux/if_bridge.h
  HDRINST usr/include/linux/dqblk_xfs.h
  HDRINST usr/include/linux/if_bonding.h
  HDRINST usr/include/linux/agpgart.h
  HDRINST usr/include/linux/udf_fs_i.h
  HDRINST usr/include/linux/swab.h
  HDRINST usr/include/linux/bfs_fs.h
  HDRINST usr/include/linux/v4l2-subdev.h
  HDRINST usr/include/linux/netdevice.h
  HDRINST usr/include/linux/virtio_balloon.h
  HDRINST usr/include/linux/if_hippi.h
  HDRINST usr/include/linux/atmmpc.h
  HDRINST usr/include/linux/major.h
  HDRINST usr/include/linux/mempolicy.h
  HDRINST usr/include/linux/openat2.h
  HDRINST usr/include/linux/ipmi.h
  HDRINST usr/include/linux/i8k.h
  HDRINST usr/include/linux/cn_proc.h
  HDRINST usr/include/linux/usbdevice_fs.h
  HDRINST usr/include/linux/batman_adv.h
  HDRINST usr/include/linux/virtio_vsock.h
  HDRINST usr/include/linux/dlm_plock.h
  HDRINST usr/include/linux/fsl_hypervisor.h
  HDRINST usr/include/linux/if_xdp.h
  HDRINST usr/include/linux/oom.h
  HDRINST usr/include/linux/genwqe/genwqe_card.h
  HDRINST usr/include/linux/netfilter_arp/arpt_mangle.h
  HDRINST usr/include/linux/netfilter_arp/arp_tables.h
  HDRINST usr/include/linux/bcache.h
  HDRINST usr/include/linux/seccomp.h
  HDRINST usr/include/linux/kcmp.h
  HDRINST usr/include/linux/coresight-stm.h
  HDRINST usr/include/linux/matroxfb.h
  HDRINST usr/include/linux/tipc_config.h
  HDRINST usr/include/linux/genetlink.h
  HDRINST usr/include/linux/thermal.h
  HDRINST usr/include/linux/seg6.h
  HDRINST usr/include/linux/minix_fs.h
  HDRINST usr/include/linux/adfs_fs.h
  HDRINST usr/include/linux/adb.h
  HDRINST usr/include/linux/kcm.h
  HDRINST usr/include/linux/posix_types.h
  HDRINST usr/include/linux/um_timetravel.h
  HDRINST usr/include/linux/elf-em.h
  HDRINST usr/include/linux/shm.h
  HDRINST usr/include/linux/rxrpc.h
  HDRINST usr/include/linux/atm.h
  HDRINST usr/include/linux/uio.h
  HDRINST usr/include/linux/atmsap.h
  HDRINST usr/include/linux/posix_acl.h
  HDRINST usr/include/linux/reboot.h
  HDRINST usr/include/linux/aio_abi.h
  HDRINST usr/include/linux/pci.h
  HDRINST usr/include/linux/utsname.h
  HDRINST usr/include/linux/smc_diag.h
  HDRINST usr/include/linux/types.h
  HDRINST usr/include/linux/openvswitch.h
  HDRINST usr/include/linux/udmabuf.h
  HDRINST usr/include/linux/irqnr.h
  HDRINST usr/include/linux/wireless.h
  HDRINST usr/include/linux/atmdev.h
  HDRINST usr/include/linux/pps.h
  HDRINST usr/include/linux/ipmi_msgdefs.h
  HDRINST usr/include/linux/module.h
  HDRINST usr/include/linux/v4l2-dv-timings.h
  HDRINST usr/include/linux/rkisp1-config.h
  HDRINST usr/include/linux/dm-log-userspace.h
  HDRINST usr/include/linux/if_addr.h
  HDRINST usr/include/linux/mii.h
  HDRINST usr/include/linux/ife.h
  HDRINST usr/include/linux/iso_fs.h
  HDRINST usr/include/linux/sonypi.h
  HDRINST usr/include/linux/ppp-comp.h
  HDRINST usr/include/linux/wait.h
  HDRINST usr/include/linux/if_ltalk.h
  HDRINST usr/include/linux/auxvec.h
  HDRINST usr/include/linux/cramfs_fs.h
  HDRINST usr/include/linux/signal.h
  HDRINST usr/include/linux/dlm.h
  HDRINST usr/include/linux/errqueue.h
  HDRINST usr/include/linux/x25.h
  HDRINST usr/include/linux/quota.h
  HDRINST usr/include/linux/uhid.h
  HDRINST usr/include/linux/tee.h
  HDRINST usr/include/linux/vbox_err.h
  HDRINST usr/include/linux/atm_nicstar.h
  HDRINST usr/include/linux/rtc.h
  HDRINST usr/include/linux/qnxtypes.h
  HDRINST usr/include/linux/watch_queue.h
  HDRINST usr/include/linux/if_pppox.h
  HDRINST usr/include/linux/tipc_netlink.h
  HDRINST usr/include/linux/ila.h
  HDRINST usr/include/linux/psci.h
  HDRINST usr/include/linux/virtio_pci.h
  HDRINST usr/include/linux/fdreg.h
  HDRINST usr/include/linux/sched/types.h
  HDRINST usr/include/linux/max2175.h
  HDRINST usr/include/linux/bpf.h
  HDRINST usr/include/linux/kexec.h
  HDRINST usr/include/linux/icmpv6.h
  HDRINST usr/include/linux/packet_diag.h
  HDRINST usr/include/linux/pfkeyv2.h
  HDRINST usr/include/linux/snmp.h
  HDRINST usr/include/linux/unistd.h
  HDRINST usr/include/linux/vfio_zdev.h
  HDRINST usr/include/linux/vbox_vmmdev_types.h
  HDRINST usr/include/linux/netconf.h
  HDRINST usr/include/linux/bpqether.h
  HDRINST usr/include/linux/switchtec_ioctl.h
  HDRINST usr/include/linux/scc.h
  HDRINST usr/include/linux/userio.h
  HDRINST usr/include/linux/wmi.h
  HDRINST usr/include/linux/net_dropmon.h
  HDRINST usr/include/linux/coff.h
  HDRINST usr/include/linux/atm_tcp.h
  HDRINST usr/include/linux/cifs/cifs_netlink.h
  HDRINST usr/include/linux/cifs/cifs_mount.h
  HDRINST usr/include/linux/atmclip.h
  HDRINST usr/include/linux/xfrm.h
  HDRINST usr/include/linux/can/error.h
  HDRINST usr/include/linux/can/netlink.h
  HDRINST usr/include/linux/can/vxcan.h
  HDRINST usr/include/linux/can/isotp.h
  HDRINST usr/include/linux/can/gw.h
  HDRINST usr/include/linux/can/raw.h
  HDRINST usr/include/linux/can/j1939.h
  HDRINST usr/include/linux/can/bcm.h
  HDRINST usr/include/linux/mount.h
  HDRINST usr/include/linux/ppp-ioctl.h
  HDRINST usr/include/linux/virtio_9p.h
  HDRINST usr/include/linux/psp-sev.h
  HDRINST usr/include/linux/psample.h
  HDRINST usr/include/linux/nfs.h
  HDRINST usr/include/linux/jffs2.h
  HDRINST usr/include/linux/usbip.h
  HDRINST usr/include/linux/msdos_fs.h
  HDRINST usr/include/linux/if_team.h
  HDRINST usr/include/linux/virtio_blk.h
  HDRINST usr/include/linux/if_tunnel.h
  HDRINST usr/include/linux/netrom.h
  HDRINST usr/include/linux/rfkill.h
  HDRINST usr/include/linux/nfsd/stats.h
  HDRINST usr/include/linux/nfsd/nfsfh.h
  HDRINST usr/include/linux/nfsd/cld.h
  HDRINST usr/include/linux/nfsd/debug.h
  HDRINST usr/include/linux/nfsd/export.h
  HDRINST usr/include/linux/romfs_fs.h
  HDRINST usr/include/linux/falloc.h
  HDRINST usr/include/linux/sunrpc/debug.h
  HDRINST usr/include/linux/elf-fdpic.h
  HDRINST usr/include/linux/virtio_pmem.h
  HDRINST usr/include/linux/rtnetlink.h
  HDRINST usr/include/linux/nfs2.h
  HDRINST usr/include/linux/virtio_iommu.h
  HDRINST usr/include/linux/serial.h
  HDRINST usr/include/linux/tcp.h
  HDRINST usr/include/linux/fscrypt.h
  HDRINST usr/include/linux/un.h
  HDRINST usr/include/linux/ppdev.h
  HDRINST usr/include/linux/limits.h
  HDRINST usr/include/linux/nilfs2_api.h
  HDRINST usr/include/linux/rpmsg_types.h
  HDRINST usr/include/linux/gameport.h
  HDRINST usr/include/linux/hdlcdrv.h
  HDRINST usr/include/linux/ppp_defs.h
  HDRINST usr/include/linux/seg6_hmac.h
  HDRINST usr/include/linux/btrfs_tree.h
  HDRINST usr/include/linux/rds.h
  HDRINST usr/include/linux/lightnvm.h
  HDRINST usr/include/linux/virtio_crypto.h
  HDRINST usr/include/linux/dma-buf.h
  HDRINST usr/include/linux/udp.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_LOG.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ttl.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_CLUSTERIP.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ecn.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ECN.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ah.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_TTL.h
  HDRINST usr/include/linux/netfilter_ipv4/ip_tables.h
  HDRINST usr/include/linux/cryptouser.h
  HDRINST usr/include/linux/xattr.h
  HDRINST usr/include/linux/target_core_user.h
  HDRINST usr/include/linux/ipmi_bmc.h
  HDRINST usr/include/linux/atm_he.h
  HDRINST usr/include/linux/tc_ematch/tc_em_nbyte.h
  HDRINST usr/include/linux/tc_ematch/tc_em_meta.h
  HDRINST usr/include/linux/tc_ematch/tc_em_text.h
  HDRINST usr/include/linux/tc_ematch/tc_em_ipt.h
  HDRINST usr/include/linux/tc_ematch/tc_em_cmp.h
  HDRINST usr/include/linux/cuda.h
  HDRINST usr/include/linux/hash_info.h
  HDRINST usr/include/linux/dlmconstants.h
  HDRINST usr/include/linux/ethtool_netlink.h
  HDRINST usr/include/linux/pg.h
  HDRINST usr/include/linux/personality.h
  HDRINST usr/include/linux/fsmap.h
  HDRINST usr/include/linux/netlink_diag.h
  HDRINST usr/include/linux/atmioc.h
  HDRINST usr/include/linux/stat.h
  HDRINST usr/include/linux/sysinfo.h
  HDRINST usr/include/linux/smiapp.h
  HDRINST usr/include/linux/cdrom.h
  HDRINST usr/include/linux/cec-funcs.h
  HDRINST usr/include/linux/if_packet.h
  HDRINST usr/include/linux/vtpm_proxy.h
  HDRINST usr/include/linux/net_tstamp.h
  HDRINST usr/include/linux/coda.h
  HDRINST usr/include/linux/mtio.h
  HDRINST usr/include/linux/dccp.h
  HDRINST usr/include/linux/usb/raw_gadget.h
  HDRINST usr/include/linux/usb/g_printer.h
  HDRINST usr/include/linux/usb/video.h
  HDRINST usr/include/linux/usb/ch9.h
  HDRINST usr/include/linux/usb/charger.h
  HDRINST usr/include/linux/usb/g_uvc.h
  HDRINST usr/include/linux/usb/gadgetfs.h
  HDRINST usr/include/linux/usb/functionfs.h
  HDRINST usr/include/linux/usb/audio.h
  HDRINST usr/include/linux/usb/ch11.h
  HDRINST usr/include/linux/usb/midi.h
  HDRINST usr/include/linux/usb/tmc.h
  HDRINST usr/include/linux/usb/cdc-wdm.h
  HDRINST usr/include/linux/usb/cdc.h
  HDRINST usr/include/linux/time_types.h
  HDRINST usr/include/linux/hyperv.h
  HDRINST usr/include/linux/idxd.h
  HDRINST usr/include/linux/atmbr2684.h
  HDRINST usr/include/linux/hdlc/ioctl.h
  HDRINST usr/include/linux/sched.h
  HDRINST usr/include/linux/msg.h
  HDRINST usr/include/linux/mmc/ioctl.h
  HDRINST usr/include/linux/suspend_ioctls.h
  HDRINST usr/include/linux/if_ppp.h
  HDRINST usr/include/linux/fsverity.h
  HDRINST usr/include/linux/zorro.h
  HDRINST usr/include/linux/igmp.h
  HDRINST usr/include/linux/inet_diag.h
  HDRINST usr/include/linux/pkt_sched.h
  HDRINST usr/include/linux/fiemap.h
  HDRINST usr/include/linux/f2fs.h
  HDRINST usr/include/sound/compress_params.h
  HDRINST usr/include/sound/hdsp.h
  HDRINST usr/include/sound/compress_offload.h
  HDRINST usr/include/sound/firewire.h
  HDRINST usr/include/sound/asound_fm.h
  HDRINST usr/include/sound/asound.h
  HDRINST usr/include/sound/sfnt_info.h
  HDRINST usr/include/sound/snd_sst_tokens.h
  HDRINST usr/include/sound/sb16_csp.h
  HDRINST usr/include/sound/asoc.h
  HDRINST usr/include/sound/hdspm.h
  HDRINST usr/include/sound/sof/header.h
  HDRINST usr/include/sound/sof/tokens.h
  HDRINST usr/include/sound/sof/fw.h
  HDRINST usr/include/sound/sof/abi.h
  HDRINST usr/include/sound/asequencer.h
  HDRINST usr/include/sound/usb_stream.h
  HDRINST usr/include/sound/skl-tplg-interface.h
  HDRINST usr/include/sound/tlv.h
  HDRINST usr/include/sound/emu10k1.h
  HDRINST usr/include/scsi/cxlflash_ioctl.h
  HDRINST usr/include/scsi/scsi_bsg_ufs.h
  HDRINST usr/include/scsi/scsi_netlink_fc.h
  HDRINST usr/include/scsi/scsi_netlink.h
  HDRINST usr/include/scsi/scsi_bsg_fc.h
  HDRINST usr/include/scsi/fc/fc_gs.h
  HDRINST usr/include/scsi/fc/fc_ns.h
  HDRINST usr/include/scsi/fc/fc_els.h
  HDRINST usr/include/scsi/fc/fc_fs.h
  HDRINST usr/include/linux/version.h
  HDRINST usr/include/asm/sgx.h
  HDRINST usr/include/asm/statfs.h
  HDRINST usr/include/asm/byteorder.h
  HDRINST usr/include/asm/ptrace-abi.h
  HDRINST usr/include/asm/vsyscall.h
  HDRINST usr/include/asm/posix_types_64.h
  HDRINST usr/include/asm/sembuf.h
  HDRINST usr/include/asm/a.out.h
  HDRINST usr/include/asm/ucontext.h
  HDRINST usr/include/asm/hw_breakpoint.h
  HDRINST usr/include/asm/msr.h
  HDRINST usr/include/asm/prctl.h
  HDRINST usr/include/asm/ptrace.h
  HDRINST usr/include/asm/vm86.h
  HDRINST usr/include/asm/processor-flags.h
  HDRINST usr/include/asm/e820.h
  HDRINST usr/include/asm/hwcap2.h
  HDRINST usr/include/asm/msgbuf.h
  HDRINST usr/include/asm/mce.h
  HDRINST usr/include/asm/kvm_perf.h
  HDRINST usr/include/asm/posix_types_x32.h
  HDRINST usr/include/asm/kvm_para.h
  HDRINST usr/include/asm/sigcontext.h
  HDRINST usr/include/asm/bitsperlong.h
  HDRINST usr/include/asm/mman.h
  HDRINST usr/include/asm/boot.h
  HDRINST usr/include/asm/siginfo.h
  HDRINST usr/include/asm/kvm.h
  HDRINST usr/include/asm/setup.h
  HDRINST usr/include/asm/swab.h
  HDRINST usr/include/asm/posix_types_32.h
  HDRINST usr/include/asm/ist.h
  HDRINST usr/include/asm/posix_types.h
  HDRINST usr/include/asm/debugreg.h
  HDRINST usr/include/asm/bootparam.h
  HDRINST usr/include/asm/auxvec.h
  HDRINST usr/include/asm/signal.h
  HDRINST usr/include/asm/vmx.h
  HDRINST usr/include/asm/unistd.h
  HDRINST usr/include/asm/mtrr.h
  HDRINST usr/include/asm/ldt.h
  HDRINST usr/include/asm/sigcontext32.h
  HDRINST usr/include/asm/shmbuf.h
  HDRINST usr/include/asm/svm.h
  HDRINST usr/include/asm/perf_regs.h
  HDRINST usr/include/asm/stat.h
  HDRINST usr/include/asm/unistd_x32.h
  HDRINST usr/include/asm/unistd_64.h
  HDRINST usr/include/asm/unistd_32.h
  HDRINST usr/include/asm/types.h
  HDRINST usr/include/asm/termios.h
  HDRINST usr/include/asm/termbits.h
  HDRINST usr/include/asm/sockios.h
  HDRINST usr/include/asm/socket.h
  HDRINST usr/include/asm/resource.h
  HDRINST usr/include/asm/poll.h
  HDRINST usr/include/asm/param.h
  HDRINST usr/include/asm/ipcbuf.h
  HDRINST usr/include/asm/ioctls.h
  HDRINST usr/include/asm/ioctl.h
  HDRINST usr/include/asm/fcntl.h
  HDRINST usr/include/asm/errno.h
  HDRINST usr/include/asm/bpf_perf_event.h
  INSTALL ./usr/include
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/safes=
etid'
gcc -Wall -O2    safesetid-test.c -lcap -o /usr/src/perf_selftests-x86_64-r=
hel-7.6-kselftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/s=
elftests/safesetid/safesetid-test
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/safese=
tid'
2021-02-07 21:52:11 make run_tests -C safesetid
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/safeseti=
d'
TAP version 13
1..1
# selftests: safesetid: safesetid-test.sh
# mounting securityfs failed
# safesetid-test.sh: done
ok 1 selftests: safesetid: safesetid-test.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/safesetid'
2021-02-07 21:52:12 make run_tests -C seccomp
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/seccomp'
gcc -Wl,-no-as-needed -Wall  -lpthread  seccomp_bpf.c  -o /usr/src/perf_sel=
ftests-x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/=
tools/testing/selftests/seccomp/seccomp_bpf
gcc -Wl,-no-as-needed -Wall  -lpthread  seccomp_benchmark.c  -o /usr/src/pe=
rf_selftests-x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b6=
49bc5/tools/testing/selftests/seccomp/seccomp_benchmark
TAP version 13
1..2
# selftests: seccomp: seccomp_bpf
# TAP version 13
# 1..87
# # Starting 87 tests from 7 test cases.
# #  RUN           global.kcmp ...
# #            OK  global.kcmp
# ok 1 global.kcmp
# #  RUN           global.mode_strict_support ...
# #            OK  global.mode_strict_support
# ok 2 global.mode_strict_support
# #  RUN           global.mode_strict_cannot_call_prctl ...
# #            OK  global.mode_strict_cannot_call_prctl
# ok 3 global.mode_strict_cannot_call_prctl
# #  RUN           global.no_new_privs_support ...
# #            OK  global.no_new_privs_support
# ok 4 global.no_new_privs_support
# #  RUN           global.mode_filter_support ...
# #            OK  global.mode_filter_support
# ok 5 global.mode_filter_support
# #  RUN           global.mode_filter_without_nnp ...
# #            OK  global.mode_filter_without_nnp
# ok 6 global.mode_filter_without_nnp
# #  RUN           global.filter_size_limits ...
# #            OK  global.filter_size_limits
# ok 7 global.filter_size_limits
# #  RUN           global.filter_chain_limits ...
# #            OK  global.filter_chain_limits
# ok 8 global.filter_chain_limits
# #  RUN           global.mode_filter_cannot_move_to_strict ...
# #            OK  global.mode_filter_cannot_move_to_strict
# ok 9 global.mode_filter_cannot_move_to_strict
# #  RUN           global.mode_filter_get_seccomp ...
# #            OK  global.mode_filter_get_seccomp
# ok 10 global.mode_filter_get_seccomp
# #  RUN           global.ALLOW_all ...
# #            OK  global.ALLOW_all
# ok 11 global.ALLOW_all
# #  RUN           global.empty_prog ...
# #            OK  global.empty_prog
# ok 12 global.empty_prog
# #  RUN           global.log_all ...
# #            OK  global.log_all
# ok 13 global.log_all
# #  RUN           global.unknown_ret_is_kill_inside ...
# #            OK  global.unknown_ret_is_kill_inside
# ok 14 global.unknown_ret_is_kill_inside
# #  RUN           global.unknown_ret_is_kill_above_allow ...
# #            OK  global.unknown_ret_is_kill_above_allow
# ok 15 global.unknown_ret_is_kill_above_allow
# #  RUN           global.KILL_all ...
# #            OK  global.KILL_all
# ok 16 global.KILL_all
# #  RUN           global.KILL_one ...
# #            OK  global.KILL_one
# ok 17 global.KILL_one
# #  RUN           global.KILL_one_arg_one ...
# #            OK  global.KILL_one_arg_one
# ok 18 global.KILL_one_arg_one
# #  RUN           global.KILL_one_arg_six ...
# #            OK  global.KILL_one_arg_six
# ok 19 global.KILL_one_arg_six
# #  RUN           global.KILL_thread ...
# #            OK  global.KILL_thread
# ok 20 global.KILL_thread
# #  RUN           global.KILL_process ...
# #            OK  global.KILL_process
# ok 21 global.KILL_process
# #  RUN           global.KILL_unknown ...
# #            OK  global.KILL_unknown
# ok 22 global.KILL_unknown
# #  RUN           global.arg_out_of_range ...
# #            OK  global.arg_out_of_range
# ok 23 global.arg_out_of_range
# #  RUN           global.ERRNO_valid ...
# #            OK  global.ERRNO_valid
# ok 24 global.ERRNO_valid
# #  RUN           global.ERRNO_zero ...
# #            OK  global.ERRNO_zero
# ok 25 global.ERRNO_zero
# #  RUN           global.ERRNO_capped ...
# #            OK  global.ERRNO_capped
# ok 26 global.ERRNO_capped
# #  RUN           global.ERRNO_order ...
# #            OK  global.ERRNO_order
# ok 27 global.ERRNO_order
# #  RUN           global.negative_ENOSYS ...
# #            OK  global.negative_ENOSYS
# ok 28 global.negative_ENOSYS
# #  RUN           global.seccomp_syscall ...
# #            OK  global.seccomp_syscall
# ok 29 global.seccomp_syscall
# #  RUN           global.seccomp_syscall_mode_lock ...
# #            OK  global.seccomp_syscall_mode_lock
# ok 30 global.seccomp_syscall_mode_lock
# #  RUN           global.detect_seccomp_filter_flags ...
# #            OK  global.detect_seccomp_filter_flags
# ok 31 global.detect_seccomp_filter_flags
# #  RUN           global.TSYNC_first ...
# #            OK  global.TSYNC_first
# ok 32 global.TSYNC_first
# #  RUN           global.syscall_restart ...
# #            OK  global.syscall_restart
# ok 33 global.syscall_restart
# #  RUN           global.filter_flag_log ...
# #            OK  global.filter_flag_log
# ok 34 global.filter_flag_log
# #  RUN           global.get_action_avail ...
# #            OK  global.get_action_avail
# ok 35 global.get_action_avail
# #  RUN           global.get_metadata ...
# #            OK  global.get_metadata
# ok 36 global.get_metadata
# #  RUN           global.user_notification_basic ...
# #            OK  global.user_notification_basic
# ok 37 global.user_notification_basic
# #  RUN           global.user_notification_with_tsync ...
# #            OK  global.user_notification_with_tsync
# ok 38 global.user_notification_with_tsync
# #  RUN           global.user_notification_kill_in_middle ...
# #            OK  global.user_notification_kill_in_middle
# ok 39 global.user_notification_kill_in_middle
# #  RUN           global.user_notification_signal ...
# #            OK  global.user_notification_signal
# ok 40 global.user_notification_signal
# #  RUN           global.user_notification_closed_listener ...
# #            OK  global.user_notification_closed_listener
# ok 41 global.user_notification_closed_listener
# #  RUN           global.user_notification_child_pid_ns ...
# #            OK  global.user_notification_child_pid_ns
# ok 42 global.user_notification_child_pid_ns
# #  RUN           global.user_notification_sibling_pid_ns ...
# #            OK  global.user_notification_sibling_pid_ns
# ok 43 global.user_notification_sibling_pid_ns
# #  RUN           global.user_notification_fault_recv ...
# #            OK  global.user_notification_fault_recv
# ok 44 global.user_notification_fault_recv
# #  RUN           global.seccomp_get_notif_sizes ...
# #            OK  global.seccomp_get_notif_sizes
# ok 45 global.seccomp_get_notif_sizes
# #  RUN           global.user_notification_continue ...
# #            OK  global.user_notification_continue
# ok 46 global.user_notification_continue
# #  RUN           global.user_notification_filter_empty ...
# #            OK  global.user_notification_filter_empty
# ok 47 global.user_notification_filter_empty
# #  RUN           global.user_notification_filter_empty_threaded ...
# #            OK  global.user_notification_filter_empty_threaded
# ok 48 global.user_notification_filter_empty_threaded
# #  RUN           global.user_notification_addfd ...
# # seccomp_bpf.c:4026:user_notification_addfd:Expected fd (7) =3D=3D 5 (5)
# # seccomp_bpf.c:4033:user_notification_addfd:Expected fd (8) =3D=3D 6 (6)
# # user_notification_addfd: Test failed at step #5
# #          FAIL  global.user_notification_addfd
# not ok 49 global.user_notification_addfd
# #  RUN           global.user_notification_addfd_rlimit ...
# #            OK  global.user_notification_addfd_rlimit
# ok 50 global.user_notification_addfd_rlimit
# #  RUN           TRAP.dfl ...
# #            OK  TRAP.dfl
# ok 51 TRAP.dfl
# #  RUN           TRAP.ign ...
# #            OK  TRAP.ign
# ok 52 TRAP.ign
# #  RUN           TRAP.handler ...
# #            OK  TRAP.handler
# ok 53 TRAP.handler
# #  RUN           precedence.allow_ok ...
# #            OK  precedence.allow_ok
# ok 54 precedence.allow_ok
# #  RUN           precedence.kill_is_highest ...
# #            OK  precedence.kill_is_highest
# ok 55 precedence.kill_is_highest
# #  RUN           precedence.kill_is_highest_in_any_order ...
# #            OK  precedence.kill_is_highest_in_any_order
# ok 56 precedence.kill_is_highest_in_any_order
# #  RUN           precedence.trap_is_second ...
# #            OK  precedence.trap_is_second
# ok 57 precedence.trap_is_second
# #  RUN           precedence.trap_is_second_in_any_order ...
# #            OK  precedence.trap_is_second_in_any_order
# ok 58 precedence.trap_is_second_in_any_order
# #  RUN           precedence.errno_is_third ...
# #            OK  precedence.errno_is_third
# ok 59 precedence.errno_is_third
# #  RUN           precedence.errno_is_third_in_any_order ...
# #            OK  precedence.errno_is_third_in_any_order
# ok 60 precedence.errno_is_third_in_any_order
# #  RUN           precedence.trace_is_fourth ...
# #            OK  precedence.trace_is_fourth
# ok 61 precedence.trace_is_fourth
# #  RUN           precedence.trace_is_fourth_in_any_order ...
# #            OK  precedence.trace_is_fourth_in_any_order
# ok 62 precedence.trace_is_fourth_in_any_order
# #  RUN           precedence.log_is_fifth ...
# #            OK  precedence.log_is_fifth
# ok 63 precedence.log_is_fifth
# #  RUN           precedence.log_is_fifth_in_any_order ...
# #            OK  precedence.log_is_fifth_in_any_order
# ok 64 precedence.log_is_fifth_in_any_order
# #  RUN           TRACE_poke.read_has_side_effects ...
# #            OK  TRACE_poke.read_has_side_effects
# ok 65 TRACE_poke.read_has_side_effects
# #  RUN           TRACE_poke.getpid_runs_normally ...
# #            OK  TRACE_poke.getpid_runs_normally
# ok 66 TRACE_poke.getpid_runs_normally
# #  RUN           TRACE_syscall.ptrace.negative_ENOSYS ...
# #            OK  TRACE_syscall.ptrace.negative_ENOSYS
# ok 67 TRACE_syscall.ptrace.negative_ENOSYS
# #  RUN           TRACE_syscall.ptrace.syscall_allowed ...
# #            OK  TRACE_syscall.ptrace.syscall_allowed
# ok 68 TRACE_syscall.ptrace.syscall_allowed
# #  RUN           TRACE_syscall.ptrace.syscall_redirected ...
# #            OK  TRACE_syscall.ptrace.syscall_redirected
# ok 69 TRACE_syscall.ptrace.syscall_redirected
# #  RUN           TRACE_syscall.ptrace.syscall_errno ...
# #            OK  TRACE_syscall.ptrace.syscall_errno
# ok 70 TRACE_syscall.ptrace.syscall_errno
# #  RUN           TRACE_syscall.ptrace.syscall_faked ...
# #            OK  TRACE_syscall.ptrace.syscall_faked
# ok 71 TRACE_syscall.ptrace.syscall_faked
# #  RUN           TRACE_syscall.ptrace.skip_after ...
# #            OK  TRACE_syscall.ptrace.skip_after
# ok 72 TRACE_syscall.ptrace.skip_after
# #  RUN           TRACE_syscall.ptrace.kill_after ...
# #            OK  TRACE_syscall.ptrace.kill_after
# ok 73 TRACE_syscall.ptrace.kill_after
# #  RUN           TRACE_syscall.seccomp.negative_ENOSYS ...
# #            OK  TRACE_syscall.seccomp.negative_ENOSYS
# ok 74 TRACE_syscall.seccomp.negative_ENOSYS
# #  RUN           TRACE_syscall.seccomp.syscall_allowed ...
# #            OK  TRACE_syscall.seccomp.syscall_allowed
# ok 75 TRACE_syscall.seccomp.syscall_allowed
# #  RUN           TRACE_syscall.seccomp.syscall_redirected ...
# #            OK  TRACE_syscall.seccomp.syscall_redirected
# ok 76 TRACE_syscall.seccomp.syscall_redirected
# #  RUN           TRACE_syscall.seccomp.syscall_errno ...
# #            OK  TRACE_syscall.seccomp.syscall_errno
# ok 77 TRACE_syscall.seccomp.syscall_errno
# #  RUN           TRACE_syscall.seccomp.syscall_faked ...
# #            OK  TRACE_syscall.seccomp.syscall_faked
# ok 78 TRACE_syscall.seccomp.syscall_faked
# #  RUN           TRACE_syscall.seccomp.skip_after ...
# #            OK  TRACE_syscall.seccomp.skip_after
# ok 79 TRACE_syscall.seccomp.skip_after
# #  RUN           TRACE_syscall.seccomp.kill_after ...
# #            OK  TRACE_syscall.seccomp.kill_after
# ok 80 TRACE_syscall.seccomp.kill_after
# #  RUN           TSYNC.siblings_fail_prctl ...
# #            OK  TSYNC.siblings_fail_prctl
# ok 81 TSYNC.siblings_fail_prctl
# #  RUN           TSYNC.two_siblings_with_ancestor ...
# #            OK  TSYNC.two_siblings_with_ancestor
# ok 82 TSYNC.two_siblings_with_ancestor
# #  RUN           TSYNC.two_sibling_want_nnp ...
# #            OK  TSYNC.two_sibling_want_nnp
# ok 83 TSYNC.two_sibling_want_nnp
# #  RUN           TSYNC.two_siblings_with_no_filter ...
# #            OK  TSYNC.two_siblings_with_no_filter
# ok 84 TSYNC.two_siblings_with_no_filter
# #  RUN           TSYNC.two_siblings_with_one_divergence ...
# #            OK  TSYNC.two_siblings_with_one_divergence
# ok 85 TSYNC.two_siblings_with_one_divergence
# #  RUN           TSYNC.two_siblings_with_one_divergence_no_tid_in_err ...
# #            OK  TSYNC.two_siblings_with_one_divergence_no_tid_in_err
# ok 86 TSYNC.two_siblings_with_one_divergence_no_tid_in_err
# #  RUN           TSYNC.two_siblings_not_under_filter ...
# #            OK  TSYNC.two_siblings_not_under_filter
# ok 87 TSYNC.two_siblings_not_under_filter
# # FAILED: 86 / 87 tests passed.
# # Totals: pass:86 fail:1 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: seccomp: seccomp_bpf # exit=3D1
# selftests: seccomp: seccomp_benchmark
# net.core.bpf_jit_enable =3D 1
# net.core.bpf_jit_harden =3D 0
# Current BPF sysctl settings:
# Calibrating sample size for 15 seconds worth of syscalls ...
# Benchmarking 17053830 syscalls...
# 15.799478905 - 1.008576112 =3D 14790902793 (14.8s)
# getpid native: 867 ns
# 30.183459206 - 15.799744429 =3D 14383714777 (14.4s)
# getpid RET_ALLOW 1 filter (bitmap): 843 ns
# 43.333904192 - 30.183666199 =3D 13150237993 (13.2s)
# getpid RET_ALLOW 2 filters (bitmap): 771 ns
# 59.358945735 - 43.334091113 =3D 16024854622 (16.0s)
# getpid RET_ALLOW 3 filters (full): 939 ns
# 76.381648249 - 59.359141258 =3D 17022506991 (17.0s)
# getpid RET_ALLOW 4 filters (full): 998 ns
# Estimated total seccomp overhead for 1 bitmapped filter: 1844674407370955=
1592 ns
# Saw unexpected benchmark result. Try running again with more samples?
ok 2 selftests: seccomp: seccomp_benchmark
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/seccomp'
2021-02-07 21:53:31 make run_tests -C sgx
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sgx'
gcc -Wall -Werror -g -I../../../../tools/include -fPIC -z noexecstack -c ma=
in.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18=
a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sgx/main.o
gcc -Wall -Werror -g -I../../../../tools/include -fPIC -z noexecstack -c lo=
ad.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18=
a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sgx/load.o
gcc -Wall -Werror -g -I../../../../tools/include -fPIC -z noexecstack -c si=
gstruct.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-dc8df6e85d2=
c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sgx/sigstruct.o
gcc -Wall -Werror -g -I../../../../tools/include -fPIC -z noexecstack -c ca=
ll.S -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18=
a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sgx/call.o
gcc -Wall -Werror -g -I../../../../tools/include -fPIC -z noexecstack -c si=
gn_key.S -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-dc8df6e85d2c=
8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sgx/sign_key.o
gcc -Wall -Werror -g -I../../../../tools/include -fPIC -z noexecstack -o /u=
sr/src/perf_selftests-x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18a0992ae3cc=
8ad3d65b649bc5/tools/testing/selftests/sgx/test_sgx /usr/src/perf_selftests=
-x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/=
testing/selftests/sgx/main.o /usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sgx/l=
oad.o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18a0=
992ae3cc8ad3d65b649bc5/tools/testing/selftests/sgx/sigstruct.o /usr/src/per=
f_selftests-x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b64=
9bc5/tools/testing/selftests/sgx/call.o /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/self=
tests/sgx/sign_key.o -lcrypto
gcc -Wall -Werror -static -nostdlib -nostartfiles -fPIC -fno-stack-protecto=
r -mrdrnd -I../../../../tools/include -T test_encl.lds test_encl.c test_enc=
l_bootstrap.S -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-dc8df6e=
85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sgx/test_encl.elf
/usr/bin/ld: warning: .note.gnu.build-id section discarded, --build-id igno=
red
TAP version 13
1..1
# selftests: sgx: test_sgx
# Unable to open /dev/sgx_enclave
# 1..0 # SKIP cannot load enclaves
ok 1 selftests: sgx: test_sgx # SKIP
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sgx'
2021-02-07 21:53:32 make run_tests -C sigaltstack
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sigaltst=
ack'
gcc -Wall    sas.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-d=
c8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sigaltstack=
/sas
TAP version 13
1..1
# selftests: sigaltstack: sas
# Segmentation fault
not ok 1 selftests: sigaltstack: sas # exit=3D139
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sigaltsta=
ck'
2021-02-07 21:53:32 make run_tests -C size
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/size'
gcc -static -ffreestanding -nostartfiles -s    get_size.c  -o /usr/src/perf=
_selftests-x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649=
bc5/tools/testing/selftests/size/get_size
TAP version 13
1..1
# selftests: size: get_size
# TAP version 13
# # Testing system size.
# ok 1 get runtime memory use
# # System runtime memory report (units in Kilobytes):
#  ---
#  Total:  32741768
#  Free:   28444780
#  Buffer: 12
#  In use: 4296976
#  ...
# 1..1
ok 1 selftests: size: get_size
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/size'
2021-02-07 21:53:32 make run_tests -C sparc64
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sparc64'
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sparc64'
2021-02-07 21:53:32 make run_tests -C splice
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/splice'
gcc     default_file_splice_read.c  -o /usr/src/perf_selftests-x86_64-rhel-=
7.6-kselftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selft=
ests/splice/default_file_splice_read
gcc     splice_read.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/splice/s=
plice_read
TAP version 13
1..2
# selftests: splice: default_file_splice_read.sh
ok 1 selftests: splice: default_file_splice_read.sh
# selftests: splice: short_splice_read.sh
# splice: Invalid argument
# FAIL: /proc/10442/limits 4096
# splice: Invalid argument
# FAIL: /proc/10442/limits 2
# splice: Invalid argument
# FAIL: /proc/10442/comm 4096
# splice: Invalid argument
# FAIL: /proc/10442/comm 2
# ok: /proc/sys/fs/nr_open 4096
# ok: /proc/sys/fs/nr_open 2
# ok: /proc/sys/kernel/modprobe 4096
# ok: /proc/sys/kernel/modprobe 2
# ok: /proc/sys/kernel/version 4096
# ok: /proc/sys/kernel/version 2
# ok: /sys/module/test_module/coresize 4096
# ok: /sys/module/test_module/coresize 2
# ok: /sys/module/test_module/sections/.init.text 4096
# ok: /sys/module/test_module/sections/.init.text 2
not ok 2 selftests: splice: short_splice_read.sh # exit=3D1
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/splice'
2021-02-07 21:53:33 make run_tests -C static_keys
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/static_k=
eys'
TAP version 13
1..1
# selftests: static_keys: test_static_keys.sh
# static_key: ok
ok 1 selftests: static_keys: test_static_keys.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/static_ke=
ys'
LKP WARN miss config CONFIG_SYNC=3D of sync/config
2021-02-07 21:53:33 make run_tests -C sync
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sync'
gcc -c sync_alloc.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-d=
c8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sync/sync_a=
lloc.o
gcc -c sync_fence.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-d=
c8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sync/sync_f=
ence.o
gcc -c sync_merge.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-d=
c8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sync/sync_m=
erge.o
gcc -c sync_wait.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-dc=
8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sync/sync_wa=
it.o
gcc -c sync_stress_parallelism.c -o /usr/src/perf_selftests-x86_64-rhel-7.6=
-kselftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftest=
s/sync/sync_stress_parallelism.o
gcc -c sync_stress_consumer.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-ks=
elftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/s=
ync/sync_stress_consumer.o
gcc -c sync_stress_merge.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kself=
tests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sync=
/sync_stress_merge.o
gcc -c sync_test.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-dc=
8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sync/sync_te=
st.o -O2 -g -std=3Dgnu89 -pthread -Wall -Wextra -I../../../../usr/include/
gcc -c sync.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-dc8df6e=
85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sync/sync.o -O2 -=
g -std=3Dgnu89 -pthread -Wall -Wextra -I../../../../usr/include/
gcc -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18a=
0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sync/sync_test /usr/src/per=
f_selftests-x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b64=
9bc5/tools/testing/selftests/sync/sync_test.o /usr/src/perf_selftests-x86_6=
4-rhel-7.6-kselftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testin=
g/selftests/sync/sync.o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-=
dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sync/sync_=
alloc.o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18=
a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sync/sync_fence.o /usr/src=
/perf_selftests-x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18a0992ae3cc8ad3d6=
5b649bc5/tools/testing/selftests/sync/sync_merge.o /usr/src/perf_selftests-=
x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/t=
esting/selftests/sync/sync_wait.o /usr/src/perf_selftests-x86_64-rhel-7.6-k=
selftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/=
sync/sync_stress_parallelism.o /usr/src/perf_selftests-x86_64-rhel-7.6-ksel=
ftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/syn=
c/sync_stress_consumer.o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sync/sync=
_stress_merge.o -O2 -g -std=3Dgnu89 -pthread -Wall -Wextra -I../../../../us=
r/include/ -pthread
TAP version 13
1..1
# selftests: sync: sync_test
# TAP version 13
# 1..10
# # [RUN]	Testing sync framework
# ok 1 [RUN]	test_alloc_timeline
# ok 2 [RUN]	test_alloc_fence
# ok 3 [RUN]	test_alloc_fence_negative
# ok 4 [RUN]	test_fence_one_timeline_wait
# ok 5 [RUN]	test_fence_one_timeline_merge
# ok 6 [RUN]	test_fence_merge_same_fence
# ok 7 [RUN]	test_fence_multi_timeline_wait
# ok 8 [RUN]	test_stress_two_threads_shared_timeline
# ok 9 [RUN]	test_consumer_stress_multi_producer_single_consumer
# ok 10 [RUN]	test_merge_stress_random_merge
# # Totals: pass:10 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: sync: sync_test
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sync'
2021-02-07 21:53:37 make run_tests -C syscall_user_dispatch
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/syscall_=
user_dispatch'
gcc -Wall -I../../../../usr/include/    sud_test.c  -o /usr/src/perf_selfte=
sts-x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/too=
ls/testing/selftests/syscall_user_dispatch/sud_test
gcc -Wall -I../../../../usr/include/    sud_benchmark.c  -o /usr/src/perf_s=
elftests-x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc=
5/tools/testing/selftests/syscall_user_dispatch/sud_benchmark
TAP version 13
1..2
# selftests: syscall_user_dispatch: sud_test
# TAP version 13
# 1..6
# # Starting 6 tests from 1 test cases.
# #  RUN           global.dispatch_trigger_sigsys ...
# #            OK  global.dispatch_trigger_sigsys
# ok 1 global.dispatch_trigger_sigsys
# #  RUN           global.bad_prctl_param ...
# #            OK  global.bad_prctl_param
# ok 2 global.bad_prctl_param
# #  RUN           global.dispatch_and_return ...
# #            OK  global.dispatch_and_return
# ok 3 global.dispatch_and_return
# #  RUN           global.bad_selector ...
# #            OK  global.bad_selector
# ok 4 global.bad_selector
# #  RUN           global.disable_dispatch ...
# #            OK  global.disable_dispatch
# ok 5 global.disable_dispatch
# #  RUN           global.direct_dispatch_range ...
# #            OK  global.direct_dispatch_range
# ok 6 global.direct_dispatch_range
# # PASSED: 6 / 6 tests passed.
# # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: syscall_user_dispatch: sud_test
# selftests: syscall_user_dispatch: sud_benchmark
# Enabling syscall trapping.
# Caught sys_ff00
# Calibrating test set to last ~5 seconds...
# test iterations =3D 3500000
# Avg syscall time 1537ns.
# trapped_call_count 1, native_call_count 0.
# Avg syscall time 1582ns.
# Interception overhead: 2.9% (+45ns).
ok 2 selftests: syscall_user_dispatch: sud_benchmark
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/syscall_u=
ser_dispatch'
2021-02-07 21:53:49 make run_tests -C sysctl
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sysctl'
TAP version 13
1..1
# selftests: sysctl: sysctl.sh
# Checking production write strict setting ... ok
# Sun Feb  7 21:53:49 UTC 2021
# Running test: sysctl_test_0001 - run #0
# =3D=3D Testing sysctl behavior against /proc/sys/debug/test_sysctl/int_00=
01 =3D=3D
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Testing that 0x0000000100000000 fails as expected...ok
# Testing that 0x0000000100000001 fails as expected...ok
# Testing that 0x00000001ffffffff fails as expected...ok
# Testing that 0x0000000180000000 fails as expected...ok
# Testing that 0x000000017fffffff fails as expected...ok
# Testing that 0xffffffff00000000 fails as expected...ok
# Testing that 0xffffffff00000001 fails as expected...ok
# Testing that 0xffffffffffffffff fails as expected...ok
# Testing that 0xffffffff80000000 fails as expected...ok
# Testing that 0xffffffff7fffffff fails as expected...ok
# Testing that -0x0000000100000000 fails as expected...ok
# Testing that -0x0000000100000001 fails as expected...ok
# Testing that -0x00000001ffffffff fails as expected...ok
# Testing that -0x0000000180000000 fails as expected...ok
# Testing that -0x000000017fffffff fails as expected...ok
# Testing that -0xffffffff00000000 fails as expected...ok
# Testing that -0xffffffff00000001 fails as expected...ok
# Testing that -0xffffffffffffffff fails as expected...ok
# Testing that -0xffffffff80000000 fails as expected...ok
# Testing that -0xffffffff7fffffff fails as expected...ok
# Checking ignoring spaces up to PAGE_SIZE works on write ...ok
# Checking passing PAGE_SIZE of spaces fails on write ...ok
# Sun Feb  7 21:53:50 UTC 2021
# Running test: sysctl_test_0002 - run #0
# =3D=3D Testing sysctl behavior against /proc/sys/debug/test_sysctl/string=
_0001 =3D=3D
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Writing entire sysctl in short writes ... ok
# Writing middle of sysctl after unsynchronized seek ... ok
# Checking sysctl maxlen is at least 65 ... ok
# Checking sysctl keeps original string on overflow append ... ok
# Checking sysctl stays NULL terminated on write ... ok
# Checking sysctl stays NULL terminated on overwrite ... ok
# Sun Feb  7 21:53:50 UTC 2021
# Running test: sysctl_test_0003 - run #0
# =3D=3D Testing sysctl behavior against /proc/sys/debug/test_sysctl/int_00=
02 =3D=3D
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Testing that 0x0000000100000000 fails as expected...ok
# Testing that 0x0000000100000001 fails as expected...ok
# Testing that 0x00000001ffffffff fails as expected...ok
# Testing that 0x0000000180000000 fails as expected...ok
# Testing that 0x000000017fffffff fails as expected...ok
# Testing that 0xffffffff00000000 fails as expected...ok
# Testing that 0xffffffff00000001 fails as expected...ok
# Testing that 0xffffffffffffffff fails as expected...ok
# Testing that 0xffffffff80000000 fails as expected...ok
# Testing that 0xffffffff7fffffff fails as expected...ok
# Testing that -0x0000000100000000 fails as expected...ok
# Testing that -0x0000000100000001 fails as expected...ok
# Testing that -0x00000001ffffffff fails as expected...ok
# Testing that -0x0000000180000000 fails as expected...ok
# Testing that -0x000000017fffffff fails as expected...ok
# Testing that -0xffffffff00000000 fails as expected...ok
# Testing that -0xffffffff00000001 fails as expected...ok
# Testing that -0xffffffffffffffff fails as expected...ok
# Testing that -0xffffffff80000000 fails as expected...ok
# Testing that -0xffffffff7fffffff fails as expected...ok
# Checking ignoring spaces up to PAGE_SIZE works on write ...ok
# Checking passing PAGE_SIZE of spaces fails on write ...ok
# Testing INT_MAX works ...ok
# Testing INT_MAX + 1 will fail as expected...ok
# Testing negative values will work as expected...ok
# Sun Feb  7 21:53:50 UTC 2021
# Running test: sysctl_test_0004 - run #0
# =3D=3D Testing sysctl behavior against /proc/sys/debug/test_sysctl/uint_0=
001 =3D=3D
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Testing that 0x0000000100000000 fails as expected...ok
# Testing that 0x0000000100000001 fails as expected...ok
# Testing that 0x00000001ffffffff fails as expected...ok
# Testing that 0x0000000180000000 fails as expected...ok
# Testing that 0x000000017fffffff fails as expected...ok
# Testing that 0xffffffff00000000 fails as expected...ok
# Testing that 0xffffffff00000001 fails as expected...ok
# Testing that 0xffffffffffffffff fails as expected...ok
# Testing that 0xffffffff80000000 fails as expected...ok
# Testing that 0xffffffff7fffffff fails as expected...ok
# Testing that -0x0000000100000000 fails as expected...ok
# Testing that -0x0000000100000001 fails as expected...ok
# Testing that -0x00000001ffffffff fails as expected...ok
# Testing that -0x0000000180000000 fails as expected...ok
# Testing that -0x000000017fffffff fails as expected...ok
# Testing that -0xffffffff00000000 fails as expected...ok
# Testing that -0xffffffff00000001 fails as expected...ok
# Testing that -0xffffffffffffffff fails as expected...ok
# Testing that -0xffffffff80000000 fails as expected...ok
# Testing that -0xffffffff7fffffff fails as expected...ok
# Checking ignoring spaces up to PAGE_SIZE works on write ...ok
# Checking passing PAGE_SIZE of spaces fails on write ...ok
# Testing UINT_MAX works ...ok
# Testing UINT_MAX + 1 will fail as expected...ok
# Testing negative values will not work as expected ...ok
# Sun Feb  7 21:53:51 UTC 2021
# Running test: sysctl_test_0005 - run #0
# Testing array works as expected ... ok
# Testing skipping trailing array elements works ... ok
# Testing PAGE_SIZE limit on array works ... ok
# Testing exceeding PAGE_SIZE limit fails as expected ... ok
# Sun Feb  7 21:53:51 UTC 2021
# Running test: sysctl_test_0005 - run #1
# Testing array works as expected ... ok
# Testing skipping trailing array elements works ... ok
# Testing PAGE_SIZE limit on array works ... ok
# Testing exceeding PAGE_SIZE limit fails as expected ... ok
# Sun Feb  7 21:53:51 UTC 2021
# Running test: sysctl_test_0005 - run #2
# Testing array works as expected ... ok
# Testing skipping trailing array elements works ... ok
# Testing PAGE_SIZE limit on array works ... ok
# Testing exceeding PAGE_SIZE limit fails as expected ... ok
# Sun Feb  7 21:53:51 UTC 2021
# Running test: sysctl_test_0006 - run #0
# Checking bitmap handler... ok
# Sun Feb  7 21:53:51 UTC 2021
# Running test: sysctl_test_0006 - run #1
# Checking bitmap handler... ok
# Sun Feb  7 21:53:51 UTC 2021
# Running test: sysctl_test_0006 - run #2
# Checking bitmap handler... ok
# Sun Feb  7 21:53:53 UTC 2021
# Running test: sysctl_test_0006 - run #3
# Checking bitmap handler... ok
# Sun Feb  7 21:53:54 UTC 2021
# Running test: sysctl_test_0006 - run #4
# Checking bitmap handler... ok
# Sun Feb  7 21:53:56 UTC 2021
# Running test: sysctl_test_0006 - run #5
# Checking bitmap handler... ok
# Sun Feb  7 21:53:56 UTC 2021
# Running test: sysctl_test_0006 - run #6
# Checking bitmap handler... ok
# Sun Feb  7 21:53:57 UTC 2021
# Running test: sysctl_test_0006 - run #7
# Checking bitmap handler... ok
# Sun Feb  7 21:53:57 UTC 2021
# Running test: sysctl_test_0006 - run #8
# Checking bitmap handler... ok
# Sun Feb  7 21:53:58 UTC 2021
# Running test: sysctl_test_0006 - run #9
# Checking bitmap handler... ok
# Sun Feb  7 21:53:58 UTC 2021
# Running test: sysctl_test_0006 - run #10
# Checking bitmap handler... ok
# Sun Feb  7 21:53:58 UTC 2021
# Running test: sysctl_test_0006 - run #11
# Checking bitmap handler... ok
# Sun Feb  7 21:53:59 UTC 2021
# Running test: sysctl_test_0006 - run #12
# Checking bitmap handler... ok
# Sun Feb  7 21:54:01 UTC 2021
# Running test: sysctl_test_0006 - run #13
# Checking bitmap handler... ok
# Sun Feb  7 21:54:01 UTC 2021
# Running test: sysctl_test_0006 - run #14
# Checking bitmap handler... ok
# Sun Feb  7 21:54:02 UTC 2021
# Running test: sysctl_test_0006 - run #15
# Checking bitmap handler... ok
# Sun Feb  7 21:54:03 UTC 2021
# Running test: sysctl_test_0006 - run #16
# Checking bitmap handler... ok
# Sun Feb  7 21:54:05 UTC 2021
# Running test: sysctl_test_0006 - run #17
# Checking bitmap handler... ok
# Sun Feb  7 21:54:05 UTC 2021
# Running test: sysctl_test_0006 - run #18
# Checking bitmap handler... ok
# Sun Feb  7 21:54:05 UTC 2021
# Running test: sysctl_test_0006 - run #19
# Checking bitmap handler... ok
# Sun Feb  7 21:54:05 UTC 2021
# Running test: sysctl_test_0006 - run #20
# Checking bitmap handler... ok
# Sun Feb  7 21:54:07 UTC 2021
# Running test: sysctl_test_0006 - run #21
# Checking bitmap handler... ok
# Sun Feb  7 21:54:09 UTC 2021
# Running test: sysctl_test_0006 - run #22
# Checking bitmap handler... ok
# Sun Feb  7 21:54:10 UTC 2021
# Running test: sysctl_test_0006 - run #23
# Checking bitmap handler... ok
# Sun Feb  7 21:54:11 UTC 2021
# Running test: sysctl_test_0006 - run #24
# Checking bitmap handler... ok
# Sun Feb  7 21:54:12 UTC 2021
# Running test: sysctl_test_0006 - run #25
# Checking bitmap handler... ok
# Sun Feb  7 21:54:12 UTC 2021
# Running test: sysctl_test_0006 - run #26
# Checking bitmap handler... ok
# Sun Feb  7 21:54:14 UTC 2021
# Running test: sysctl_test_0006 - run #27
# Checking bitmap handler... ok
# Sun Feb  7 21:54:14 UTC 2021
# Running test: sysctl_test_0006 - run #28
# Checking bitmap handler... ok
# Sun Feb  7 21:54:15 UTC 2021
# Running test: sysctl_test_0006 - run #29
# Checking bitmap handler... ok
# Sun Feb  7 21:54:15 UTC 2021
# Running test: sysctl_test_0006 - run #30
# Checking bitmap handler... ok
# Sun Feb  7 21:54:17 UTC 2021
# Running test: sysctl_test_0006 - run #31
# Checking bitmap handler... ok
# Sun Feb  7 21:54:17 UTC 2021
# Running test: sysctl_test_0006 - run #32
# Checking bitmap handler... ok
# Sun Feb  7 21:54:17 UTC 2021
# Running test: sysctl_test_0006 - run #33
# Checking bitmap handler... ok
# Sun Feb  7 21:54:18 UTC 2021
# Running test: sysctl_test_0006 - run #34
# Checking bitmap handler... ok
# Sun Feb  7 21:54:19 UTC 2021
# Running test: sysctl_test_0006 - run #35
# Checking bitmap handler... ok
# Sun Feb  7 21:54:19 UTC 2021
# Running test: sysctl_test_0006 - run #36
# Checking bitmap handler... ok
# Sun Feb  7 21:54:21 UTC 2021
# Running test: sysctl_test_0006 - run #37
# Checking bitmap handler... ok
# Sun Feb  7 21:54:21 UTC 2021
# Running test: sysctl_test_0006 - run #38
# Checking bitmap handler... ok
# Sun Feb  7 21:54:22 UTC 2021
# Running test: sysctl_test_0006 - run #39
# Checking bitmap handler... ok
# Sun Feb  7 21:54:23 UTC 2021
# Running test: sysctl_test_0006 - run #40
# Checking bitmap handler... ok
# Sun Feb  7 21:54:23 UTC 2021
# Running test: sysctl_test_0006 - run #41
# Checking bitmap handler... ok
# Sun Feb  7 21:54:23 UTC 2021
# Running test: sysctl_test_0006 - run #42
# Checking bitmap handler... ok
# Sun Feb  7 21:54:23 UTC 2021
# Running test: sysctl_test_0006 - run #43
# Checking bitmap handler... ok
# Sun Feb  7 21:54:24 UTC 2021
# Running test: sysctl_test_0006 - run #44
# Checking bitmap handler... ok
# Sun Feb  7 21:54:24 UTC 2021
# Running test: sysctl_test_0006 - run #45
# Checking bitmap handler... ok
# Sun Feb  7 21:54:24 UTC 2021
# Running test: sysctl_test_0006 - run #46
# Checking bitmap handler... ok
# Sun Feb  7 21:54:24 UTC 2021
# Running test: sysctl_test_0006 - run #47
# Checking bitmap handler... ok
# Sun Feb  7 21:54:25 UTC 2021
# Running test: sysctl_test_0006 - run #48
# Checking bitmap handler... ok
# Sun Feb  7 21:54:25 UTC 2021
# Running test: sysctl_test_0006 - run #49
# Checking bitmap handler... ok
# Sun Feb  7 21:54:26 UTC 2021
# Running test: sysctl_test_0007 - run #0
# Testing if /proc/sys/debug/test_sysctl/boot_int is set to 1 ...ok
ok 1 selftests: sysctl: sysctl.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sysctl'



To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install                job.yaml  # job file is attached in =
this email
        bin/lkp split-job --compatible job.yaml
        bin/lkp run                    compatible-job.yaml



Thanks,
Oliver Sang


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.11.0-rc5-00462-gdc8df6e85d2c"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.11.0-rc5 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-15) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_LD_VERSION=235000000
CONFIG_CLANG_VERSION=0
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_LSM is not set
CONFIG_BPF_SYSCALL=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_BPF_PRELOAD is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_XXL=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_512GB=y
CONFIG_XEN_PV_SMP=y
# CONFIG_XEN_DOM0 is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_PVHVM_GUEST=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_X86_SGX=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=y
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=y
# CONFIG_KVM_AMD is not set
CONFIG_KVM_MMU_AUDIT=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
CONFIG_MEM_SOFT_DIRTY=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
# CONFIG_ZSWAP_DEFAULT_ON is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_TEST=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_REDIRECT=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
# CONFIG_TLS_DEVICE is not set
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IP_TUNNEL=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
# CONFIG_INET_ESP_OFFLOAD is not set
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
# CONFIG_TCP_CONG_NV is not set
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
# CONFIG_TCP_CONG_BBR is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
# CONFIG_INET6_ESP_OFFLOAD is not set
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=y
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_GRE=y
CONFIG_IPV6_FOU=y
CONFIG_IPV6_FOU_TUNNEL=y
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_NETLABEL=y
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=m
CONFIG_MPTCP_IPV6=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
# CONFIG_NF_LOG_NETDEV is not set
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
# CONFIG_NFT_NUMGEN is not set
CONFIG_NFT_CT=m
CONFIG_NFT_FLOW_OFFLOAD=m
CONFIG_NFT_COUNTER=m
# CONFIG_NFT_CONNLIMIT is not set
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
# CONFIG_NFT_QUOTA is not set
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
# CONFIG_NFT_XFRM is not set
# CONFIG_NFT_SOCKET is not set
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
# CONFIG_NF_DUP_NETDEV is not set
# CONFIG_NFT_DUP_NETDEV is not set
# CONFIG_NFT_FWD_NETDEV is not set
# CONFIG_NFT_REJECT_NETDEV is not set
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
CONFIG_NETFILTER_XT_TARGET_LED=m
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_NFACCT=m
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
# CONFIG_IP_VS_FO is not set
# CONFIG_IP_VS_OVF is not set
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
# CONFIG_NFT_DUP_IPV4 is not set
# CONFIG_NFT_FIB_IPV4 is not set
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_FLOW_TABLE_IPV4=m
CONFIG_NF_DUP_IPV4=m
# CONFIG_NF_LOG_ARP is not set
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
# CONFIG_NFT_DUP_IPV6 is not set
# CONFIG_NFT_FIB_IPV6 is not set
CONFIG_NF_FLOW_TABLE_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
# CONFIG_NF_TABLES_BRIDGE is not set
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=y
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
CONFIG_6LOWPAN_NHC=m
CONFIG_6LOWPAN_NHC_DEST=m
CONFIG_6LOWPAN_NHC_FRAGMENT=m
CONFIG_6LOWPAN_NHC_HOP=m
CONFIG_6LOWPAN_NHC_IPV6=m
CONFIG_6LOWPAN_NHC_MOBILITY=m
CONFIG_6LOWPAN_NHC_ROUTING=m
CONFIG_6LOWPAN_NHC_UDP=m
# CONFIG_6LOWPAN_GHC_EXT_HDR_HOP is not set
# CONFIG_6LOWPAN_GHC_UDP is not set
# CONFIG_6LOWPAN_GHC_ICMPV6 is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_DEST is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
CONFIG_NET_SCH_ETF=m
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=y
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=m
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_SCH_PLUG=m
CONFIG_NET_SCH_ETS=m
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
CONFIG_NET_EMATCH_CANID=m
CONFIG_NET_EMATCH_IPSET=m
CONFIG_NET_EMATCH_IPT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_MPLS=m
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_CONNMARK=m
CONFIG_NET_ACT_CTINFO=m
CONFIG_NET_ACT_SKBMOD=m
CONFIG_NET_ACT_IFE=m
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_ACT_CT=m
# CONFIG_NET_ACT_GATE is not set
CONFIG_NET_IFE_SKBMARK=m
CONFIG_NET_IFE_SKBPRIO=m
CONFIG_NET_IFE_SKBTCINDEX=m
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=m
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
CONFIG_CAN_8DEV_USB=m
CONFIG_CAN_EMS_USB=m
CONFIG_CAN_ESD_USB2=m
# CONFIG_CAN_GS_USB is not set
CONFIG_CAN_KVASER_USB=m
# CONFIG_CAN_MCBA_USB is not set
CONFIG_CAN_PEAK_USB=m
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_CMTP=m
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_MSFTEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=m
CONFIG_BT_BCM=m
CONFIG_BT_RTL=m
CONFIG_BT_HCIBTUSB=m
# CONFIG_BT_HCIBTUSB_AUTOSUSPEND is not set
CONFIG_BT_HCIBTUSB_BCM=y
# CONFIG_BT_HCIBTUSB_MTK is not set
CONFIG_BT_HCIBTUSB_RTL=y
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
CONFIG_BT_MRVL_SDIO=m
CONFIG_BT_ATH3K=m
# CONFIG_BT_MTKSDIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_LIB80211=m
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=m
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_BW is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
# CONFIG_PCI_PF_STUB is not set
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
# CONFIG_MTD_AR7_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_MCHP23K256 is not set
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

#
# NAND
#
# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_RAW_NAND is not set
# CONFIG_MTD_SPI_NAND is not set

#
# ECC engine support
#
# CONFIG_MTD_NAND_ECC_SW_HAMMING is not set
# CONFIG_MTD_NAND_ECC_SW_BCH is not set
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_MTD_HYPERBUS is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_FD=m
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
CONFIG_ZRAM=m
CONFIG_ZRAM_DEF_COMP_LZORLE=y
# CONFIG_ZRAM_DEF_COMP_LZO is not set
CONFIG_ZRAM_DEF_COMP="lzo-rle"
# CONFIG_ZRAM_WRITEBACK is not set
# CONFIG_ZRAM_MEMORY_TRACKING is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SKD is not set
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
# CONFIG_NVME_MULTIPATH is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=m
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=4
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=m
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_ARCMSR=m
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_SCSI_UFS_BSG is not set
CONFIG_SCSI_HPTIOP=m
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=m
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_STEX=m
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
CONFIG_TCM_QLA2XXX=m
# CONFIG_TCM_QLA2XXX_DEBUG is not set
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_QEDI is not set
# CONFIG_QEDF is not set
CONFIG_SCSI_LPFC=m
# CONFIG_SCSI_LPFC_DEBUG_FS is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=m
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
CONFIG_SATA_QSTOR=m
CONFIG_SATA_SX4=m
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
CONFIG_SATA_PROMISE=m
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=m
CONFIG_SATA_SVW=m
CONFIG_SATA_ULI=m
CONFIG_SATA_VIA=m
CONFIG_SATA_VITESSE=m

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=m
CONFIG_PATA_AMD=m
CONFIG_PATA_ARTOP=m
CONFIG_PATA_ATIIXP=m
CONFIG_PATA_ATP867X=m
CONFIG_PATA_CMD64X=m
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
CONFIG_PATA_HPT366=m
CONFIG_PATA_HPT37X=m
CONFIG_PATA_HPT3X2N=m
CONFIG_PATA_HPT3X3=m
# CONFIG_PATA_HPT3X3_DMA is not set
CONFIG_PATA_IT8213=m
CONFIG_PATA_IT821X=m
CONFIG_PATA_JMICRON=m
CONFIG_PATA_MARVELL=m
CONFIG_PATA_NETCELL=m
CONFIG_PATA_NINJA32=m
# CONFIG_PATA_NS87415 is not set
CONFIG_PATA_OLDPIIX=m
# CONFIG_PATA_OPTIDMA is not set
CONFIG_PATA_PDC2027X=m
CONFIG_PATA_PDC_OLD=m
# CONFIG_PATA_RADISYS is not set
CONFIG_PATA_RDC=m
CONFIG_PATA_SCH=m
CONFIG_PATA_SERVERWORKS=m
CONFIG_PATA_SIL680=m
CONFIG_PATA_SIS=m
CONFIG_PATA_TOSHIBA=m
# CONFIG_PATA_TRIFLEX is not set
CONFIG_PATA_VIA=m
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=m
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=m
# CONFIG_MD_CLUSTER is not set
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
# CONFIG_DM_WRITECACHE is not set
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
# CONFIG_DM_INTEGRITY is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
CONFIG_ISCSI_TARGET_CXGB4=m
# CONFIG_SBP_TARGET is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
# CONFIG_FUSION_FC is not set
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=y
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=y
CONFIG_IFB=y
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=y
CONFIG_GENEVE=y
CONFIG_BAREUDP=m
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_NTB_NETDEV=m
CONFIG_TUN=m
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=y
CONFIG_VIRTIO_NET=m
CONFIG_NLMON=m
CONFIG_NET_VRF=y
CONFIG_VSOCKMON=m
# CONFIG_ARCNET is not set
# CONFIG_ATM_DRIVERS is not set

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_ENA_ETHERNET=m
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
CONFIG_AMD_XGBE=m
# CONFIG_AMD_XGBE_DCB is not set
CONFIG_AMD_XGBE_HAVE_ECC=y
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_AQTION=m
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
CONFIG_ALX=m
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCMGENET is not set
CONFIG_BNX2=m
CONFIG_CNIC=m
# CONFIG_TIGON3 is not set
CONFIG_BNX2X=m
CONFIG_BNX2X_SRIOV=y
# CONFIG_SYSTEMPORT is not set
CONFIG_BNXT=m
CONFIG_BNXT_SRIOV=y
CONFIG_BNXT_FLOWER_OFFLOAD=y
CONFIG_BNXT_DCB=y
CONFIG_BNXT_HWMON=y
CONFIG_NET_VENDOR_BROCADE=y
CONFIG_BNA=m
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_MACB=m
CONFIG_MACB_USE_HWSTAMP=y
# CONFIG_MACB_PCI is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
CONFIG_LIQUIDIO=m
CONFIG_LIQUIDIO_VF=m
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
CONFIG_CHELSIO_T3=m
CONFIG_CHELSIO_T4=m
# CONFIG_CHELSIO_T4_DCB is not set
CONFIG_CHELSIO_T4VF=m
CONFIG_CHELSIO_LIB=m
CONFIG_CHELSIO_INLINE_CRYPTO=y
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=m
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
CONFIG_DNET=m
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
# CONFIG_NET_VENDOR_DLINK is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
CONFIG_BE2NET_HWMON=y
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=m
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBEVF=m
CONFIG_I40E=y
CONFIG_I40E_DCB=y
CONFIG_IAVF=m
CONFIG_I40EVF=m
# CONFIG_ICE is not set
CONFIG_FM10K=m
# CONFIG_IGC is not set
CONFIG_JME=m
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
CONFIG_MYRI10GE_DCA=y
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NFP=m
CONFIG_NFP_APP_FLOWER=y
CONFIG_NFP_APP_ABM_NIC=y
# CONFIG_NFP_DEBUG is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=m
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
CONFIG_QLCNIC=m
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_DCB=y
CONFIG_QLCNIC_HWMON=y
CONFIG_NETXEN_NIC=m
CONFIG_QED=m
CONFIG_QED_SRIOV=y
CONFIG_QEDE=m
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_ROCKER=m
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MTD=y
CONFIG_SFC_MCDI_MON=y
CONFIG_SFC_SRIOV=y
CONFIG_SFC_MCDI_LOGGING=y
CONFIG_SFC_FALCON=m
CONFIG_SFC_FALCON_MTD=y
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=m
# CONFIG_SMSC911X is not set
CONFIG_SMSC9420=m
CONFIG_NET_VENDOR_SOCIONEXT=y
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
CONFIG_TLAN=m
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLINK=m
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y
# CONFIG_SFP is not set

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=m
# CONFIG_ADIN_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
CONFIG_BROADCOM_PHY=m
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_CICADA_PHY=m
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=m
CONFIG_ICPLUS_PHY=m
CONFIG_LXT_PHY=m
# CONFIG_INTEL_XWAY_PHY is not set
CONFIG_LSI_ET1011C_PHY=m
CONFIG_MARVELL_PHY=m
# CONFIG_MARVELL_10G_PHY is not set
CONFIG_MICREL_PHY=m
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
CONFIG_NATIONAL_PHY=m
# CONFIG_NXP_TJA11XX_PHY is not set
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=m
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
CONFIG_VITESSE_PHY=m
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_DEVRES=y
CONFIG_MDIO_BITBANG=m
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_GPIO is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# CONFIG_PCS_XPCS is not set
# end of PCS device drivers

# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=m
CONFIG_PPPOE=m
CONFIG_PPTP=m
CONFIG_PPPOL2TP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=m
CONFIG_SLHC=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
CONFIG_USB_NET_CDCETHER=m
# CONFIG_USB_NET_CDC_EEM is not set
CONFIG_USB_NET_CDC_NCM=m
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
CONFIG_USB_NET_CDC_MBIM=m
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
CONFIG_USB_NET_CX82310_ETH=m
CONFIG_USB_NET_KALMIA=m
CONFIG_USB_NET_QMI_WWAN=m
CONFIG_USB_HSO=m
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
CONFIG_USB_VL600=m
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
# CONFIG_USB_RTL8153_ECM is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_ATH_COMMON=m
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_ATH9K_HW=m
CONFIG_ATH9K_COMMON=m
CONFIG_ATH9K_BTCOEX_SUPPORT=y
# CONFIG_ATH9K is not set
CONFIG_ATH9K_HTC=m
# CONFIG_ATH9K_HTC_DEBUGFS is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
CONFIG_IWLEGACY=m
CONFIG_IWL4965=m
CONFIG_IWL3945=m

#
# iwl3945 / iwl4965 Debugging Options
#
CONFIG_IWLEGACY_DEBUG=y
CONFIG_IWLEGACY_DEBUGFS=y
# end of iwl3945 / iwl4965 Debugging Options

CONFIG_IWLWIFI=m
CONFIG_IWLWIFI_LEDS=y
CONFIG_IWLDVM=m
CONFIG_IWLMVM=m
CONFIG_IWLWIFI_OPMODE_MODULAR=y
# CONFIG_IWLWIFI_BCAST_FILTERING is not set

#
# Debugging Options
#
# CONFIG_IWLWIFI_DEBUG is not set
CONFIG_IWLWIFI_DEBUGFS=y
# CONFIG_IWLWIFI_DEVICE_TRACING is not set
# end of Debugging Options

CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
# CONFIG_MT7663U is not set
# CONFIG_MT7663S is not set
# CONFIG_MT7915E is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
# CONFIG_RTL_CARDS is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
CONFIG_WAN=y
# CONFIG_LANMEDIA is not set
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
# CONFIG_HDLC_RAW_ETH is not set
CONFIG_HDLC_CISCO=m
CONFIG_HDLC_FR=m
CONFIG_HDLC_PPP=m

#
# X.25/LAPB support is disabled
#
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
# CONFIG_SBNI is not set
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=m
CONFIG_VMXNET3=m
CONFIG_FUJITSU_ES=m
CONFIG_HYPERV_NET=m
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
CONFIG_ISDN=y
CONFIG_ISDN_CAPI=y
CONFIG_CAPI_TRACE=y
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_MISDN=m
CONFIG_MISDN_DSP=m
CONFIG_MISDN_L1OIP=m

#
# mISDN hardware drivers
#
CONFIG_MISDN_HFCPCI=m
CONFIG_MISDN_HFCMULTI=m
CONFIG_MISDN_HFCUSB=m
CONFIG_MISDN_AVMFRITZ=m
CONFIG_MISDN_SPEEDFAX=m
CONFIG_MISDN_INFINEON=m
CONFIG_MISDN_W6692=m
CONFIG_MISDN_NETJET=m
CONFIG_MISDN_HDLC=m
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=m
# CONFIG_TABLET_USB_HANWANG is not set
CONFIG_TABLET_USB_KBTAB=m
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ADC is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMA140 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_WM97XX is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SUR40 is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
# CONFIG_TOUCHSCREEN_IQS5XX is not set
# CONFIG_TOUCHSCREEN_ZINITIX is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=m
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
CONFIG_INPUT_UINPUT=m
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
# CONFIG_INPUT_DA7280_HAPTICS is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_IQS269A is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=m
# CONFIG_RMI4_I2C is not set
# CONFIG_RMI4_SPI is not set
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F3A is not set
# CONFIG_RMI4_F54 is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_BCM63XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
# CONFIG_TRACE_SINK is not set
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=m
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set
CONFIG_NVRAM=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_DP83640_PHY=m
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# CONFIG_PTP_1588_CLOCK_OCP is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
CONFIG_PINCTRL_CANNONLAKE=m
# CONFIG_PINCTRL_CEDARFORK is not set
CONFIG_PINCTRL_DENVERTON=m
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
# CONFIG_PINCTRL_TIGERLAKE is not set

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=m
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
CONFIG_GPIO_MOCKUP=m
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
# CONFIG_SENSORS_AMD_ENERGY is not set
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SBTSI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
CONFIG_PROC_THERMAL_MMIO_RAPL=m
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_INTEL_PMT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_VIPERBOARD=m
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=m
CONFIG_IR_ENE=m
CONFIG_IR_IMON=m
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_MCEUSB=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
CONFIG_IR_REDRAT3=m
CONFIG_IR_STREAMZAP=m
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
CONFIG_IR_IGUANA=m
CONFIG_IR_TTUSBIR=m
CONFIG_RC_LOOPBACK=m
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_SIR is not set
# CONFIG_RC_XBOX_DVD is not set
# CONFIG_IR_TOY is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
CONFIG_MEDIA_SUPPORT=m
# CONFIG_MEDIA_SUPPORT_FILTER is not set
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_V4L2_I2C=y
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_DMA_SG=m
CONFIG_VIDEOBUF_VMALLOC=m
# end of Video4Linux options

#
# Media controller options
#
CONFIG_MEDIA_CONTROLLER_DVB=y
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=8
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#
CONFIG_TTPCI_EEPROM=m
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
CONFIG_USB_GSPCA=m
CONFIG_USB_M5602=m
CONFIG_USB_STV06XX=m
CONFIG_USB_GL860=m
CONFIG_USB_GSPCA_BENQ=m
CONFIG_USB_GSPCA_CONEX=m
CONFIG_USB_GSPCA_CPIA1=m
# CONFIG_USB_GSPCA_DTCS033 is not set
CONFIG_USB_GSPCA_ETOMS=m
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
CONFIG_USB_GSPCA_JL2005BCD=m
# CONFIG_USB_GSPCA_KINECT is not set
CONFIG_USB_GSPCA_KONICA=m
CONFIG_USB_GSPCA_MARS=m
CONFIG_USB_GSPCA_MR97310A=m
CONFIG_USB_GSPCA_NW80X=m
CONFIG_USB_GSPCA_OV519=m
CONFIG_USB_GSPCA_OV534=m
CONFIG_USB_GSPCA_OV534_9=m
CONFIG_USB_GSPCA_PAC207=m
CONFIG_USB_GSPCA_PAC7302=m
CONFIG_USB_GSPCA_PAC7311=m
CONFIG_USB_GSPCA_SE401=m
CONFIG_USB_GSPCA_SN9C2028=m
CONFIG_USB_GSPCA_SN9C20X=m
CONFIG_USB_GSPCA_SONIXB=m
CONFIG_USB_GSPCA_SONIXJ=m
CONFIG_USB_GSPCA_SPCA500=m
CONFIG_USB_GSPCA_SPCA501=m
CONFIG_USB_GSPCA_SPCA505=m
CONFIG_USB_GSPCA_SPCA506=m
CONFIG_USB_GSPCA_SPCA508=m
CONFIG_USB_GSPCA_SPCA561=m
CONFIG_USB_GSPCA_SPCA1528=m
CONFIG_USB_GSPCA_SQ905=m
CONFIG_USB_GSPCA_SQ905C=m
CONFIG_USB_GSPCA_SQ930X=m
CONFIG_USB_GSPCA_STK014=m
# CONFIG_USB_GSPCA_STK1135 is not set
CONFIG_USB_GSPCA_STV0680=m
CONFIG_USB_GSPCA_SUNPLUS=m
CONFIG_USB_GSPCA_T613=m
CONFIG_USB_GSPCA_TOPRO=m
# CONFIG_USB_GSPCA_TOUPTEK is not set
CONFIG_USB_GSPCA_TV8532=m
CONFIG_USB_GSPCA_VC032X=m
CONFIG_USB_GSPCA_VICAM=m
CONFIG_USB_GSPCA_XIRLINK_CIT=m
CONFIG_USB_GSPCA_ZC3XX=m
CONFIG_USB_PWC=m
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
# CONFIG_VIDEO_CPIA2 is not set
CONFIG_USB_ZR364XX=m
CONFIG_USB_STKWEBCAM=m
CONFIG_USB_S2255=m
# CONFIG_VIDEO_USBTV is not set

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_SYSFS=y
CONFIG_VIDEO_PVRUSB2_DVB=y
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_HDPVR=m
# CONFIG_VIDEO_STK1160_COMMON is not set
# CONFIG_VIDEO_GO7007 is not set

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=m
CONFIG_VIDEO_AU0828_V4L2=y
# CONFIG_VIDEO_AU0828_RC is not set
CONFIG_VIDEO_CX231XX=m
CONFIG_VIDEO_CX231XX_RC=y
CONFIG_VIDEO_CX231XX_ALSA=m
CONFIG_VIDEO_CX231XX_DVB=m
CONFIG_VIDEO_TM6000=m
CONFIG_VIDEO_TM6000_ALSA=m
CONFIG_VIDEO_TM6000_DVB=m

#
# Digital TV USB devices
#
CONFIG_DVB_USB=m
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_DIB3000MC=m
CONFIG_DVB_USB_A800=m
CONFIG_DVB_USB_DIBUSB_MB=m
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=m
CONFIG_DVB_USB_DIB0700=m
CONFIG_DVB_USB_UMT_010=m
CONFIG_DVB_USB_CXUSB=m
# CONFIG_DVB_USB_CXUSB_ANALOG is not set
CONFIG_DVB_USB_M920X=m
CONFIG_DVB_USB_DIGITV=m
CONFIG_DVB_USB_VP7045=m
CONFIG_DVB_USB_VP702X=m
CONFIG_DVB_USB_GP8PSK=m
CONFIG_DVB_USB_NOVA_T_USB2=m
CONFIG_DVB_USB_TTUSB2=m
CONFIG_DVB_USB_DTT200U=m
CONFIG_DVB_USB_OPERA1=m
CONFIG_DVB_USB_AF9005=m
CONFIG_DVB_USB_AF9005_REMOTE=m
CONFIG_DVB_USB_PCTV452E=m
CONFIG_DVB_USB_DW2102=m
CONFIG_DVB_USB_CINERGY_T2=m
CONFIG_DVB_USB_DTV5100=m
CONFIG_DVB_USB_AZ6027=m
CONFIG_DVB_USB_TECHNISAT_USB2=m
CONFIG_DVB_USB_V2=m
CONFIG_DVB_USB_AF9015=m
CONFIG_DVB_USB_AF9035=m
CONFIG_DVB_USB_ANYSEE=m
CONFIG_DVB_USB_AU6610=m
CONFIG_DVB_USB_AZ6007=m
CONFIG_DVB_USB_CE6230=m
CONFIG_DVB_USB_EC168=m
CONFIG_DVB_USB_GL861=m
CONFIG_DVB_USB_LME2510=m
CONFIG_DVB_USB_MXL111SF=m
CONFIG_DVB_USB_RTL28XXU=m
# CONFIG_DVB_USB_DVBSKY is not set
# CONFIG_DVB_USB_ZD1301 is not set
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m
CONFIG_SMS_USB_DRV=m
CONFIG_DVB_B2C2_FLEXCOP_USB=m
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
# CONFIG_DVB_AS102 is not set

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=m
# CONFIG_VIDEO_EM28XX_V4L2 is not set
CONFIG_VIDEO_EM28XX_ALSA=m
CONFIG_VIDEO_EM28XX_DVB=m
CONFIG_VIDEO_EM28XX_RC=m

#
# Software defined radio USB devices
#
# CONFIG_USB_AIRSPY is not set
# CONFIG_USB_HACKRF is not set
# CONFIG_USB_MSI2500 is not set
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_MEYE is not set
# CONFIG_VIDEO_SOLO6X10 is not set
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
# CONFIG_VIDEO_TW686X is not set

#
# Media capture/analog TV support
#
CONFIG_VIDEO_IVTV=m
# CONFIG_VIDEO_IVTV_DEPRECATED_IOCTLS is not set
# CONFIG_VIDEO_IVTV_ALSA is not set
CONFIG_VIDEO_FB_IVTV=m
# CONFIG_VIDEO_FB_IVTV_FORCE_PAT is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DT3155 is not set

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX18=m
CONFIG_VIDEO_CX18_ALSA=m
CONFIG_VIDEO_CX23885=m
CONFIG_MEDIA_ALTERA_CI=m
# CONFIG_VIDEO_CX25821 is not set
CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_ALSA=m
CONFIG_VIDEO_CX88_BLACKBIRD=m
CONFIG_VIDEO_CX88_DVB=m
CONFIG_VIDEO_CX88_ENABLE_VP3054=y
CONFIG_VIDEO_CX88_VP3054=m
CONFIG_VIDEO_CX88_MPEG=m
CONFIG_VIDEO_BT848=m
CONFIG_DVB_BT8XX=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_ALSA=m
CONFIG_VIDEO_SAA7134_RC=y
CONFIG_VIDEO_SAA7134_DVB=m
CONFIG_VIDEO_SAA7164=m

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_AV7110_IR=y
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y
CONFIG_DVB_BUDGET_CORE=m
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_DVB_BUDGET_PATCH=m
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
CONFIG_DVB_PLUTO2=m
CONFIG_DVB_DM1105=m
CONFIG_DVB_PT1=m
# CONFIG_DVB_PT3 is not set
CONFIG_MANTIS_CORE=m
CONFIG_DVB_MANTIS=m
CONFIG_DVB_HOPPER=m
CONFIG_DVB_NGENE=m
CONFIG_DVB_DDBRIDGE=m
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
# CONFIG_DVB_SMIPCIE is not set
# CONFIG_DVB_NETUP_UNIDVB is not set
# CONFIG_VIDEO_IPU3_CIO2 is not set
# CONFIG_VIDEO_PCI_SKELETON is not set
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y
# CONFIG_SMS_SIANO_DEBUGFS is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# MMC/SDIO DVB adapters
#
CONFIG_SMS_SDIO_DRV=m
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y

#
# IR I2C driver auto-selected by 'Autoselect ancillary drivers'
#
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_TDA7432=m
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TDA1997X is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_VP27SMPX=m
# CONFIG_VIDEO_SONY_BTF_MPX is not set
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_ADV7604 is not set
# CONFIG_VIDEO_ADV7842 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
CONFIG_VIDEO_SAA711X=m
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m
# end of Video decoders

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_ADV7511 is not set
# CONFIG_VIDEO_AD9389B is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m
# end of Video improvement chips

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
CONFIG_VIDEO_M52790=m
# CONFIG_VIDEO_I2C is not set
# CONFIG_VIDEO_ST_MIPID02 is not set
# end of Miscellaneous helper chips

#
# Camera sensor devices
#
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_IMX214 is not set
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX355 is not set
# CONFIG_VIDEO_OV02A10 is not set
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV5647 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV5670 is not set
# CONFIG_VIDEO_OV5675 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV7251 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV8856 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV9734 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_MT9M001 is not set
# CONFIG_VIDEO_MT9M032 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T001 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_NOON010PC30 is not set
# CONFIG_VIDEO_M5MOLS is not set
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K4ECGX is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_CCS is not set
# CONFIG_VIDEO_ET8EK8 is not set
# CONFIG_VIDEO_S5C73M3 is not set
# end of Camera sensor devices

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# SPI helper chips
#
# CONFIG_VIDEO_GS1662 is not set
# end of SPI helper chips

#
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
# CONFIG_MEDIA_TUNER_MSI001 is not set
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
# CONFIG_MEDIA_TUNER_MXL301RF is not set
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
# CONFIG_DVB_S5H1432 is not set
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
# CONFIG_DVB_DIB9000 is not set
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_RTL2832_SDR=m
CONFIG_DVB_SI2168=m
# CONFIG_DVB_ZD1301_DEMOD is not set
CONFIG_DVB_GP8PSK_FE=m
# CONFIG_DVB_CXD2880 is not set

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m
# CONFIG_DVB_MN88443X is not set

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
# CONFIG_DVB_LNBH29 is not set
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
# CONFIG_DVB_LGS8GL5 is not set
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
# CONFIG_DVB_HORUS3A is not set
# CONFIG_DVB_ASCOT2E is not set
# CONFIG_DVB_HELENE is not set

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
# CONFIG_DVB_SP2 is not set
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m

#
# drm/i915 Debugging
#
CONFIG_DRM_I915_WERROR=y
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_DEBUG_GEM is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=y
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=m
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m
# CONFIG_SND_PORTMAN2X4 is not set
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=5
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_ALI5451=m
CONFIG_SND_ASIHPI=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CTXFI=m
CONFIG_SND_DARLA20=m
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
CONFIG_SND_INDIGODJX=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1_SEQ=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
# CONFIG_SND_ES1938 is not set
CONFIG_SND_ES1968=m
CONFIG_SND_ES1968_INPUT=y
CONFIG_SND_ES1968_RADIO=y
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=m
CONFIG_SND_LX6464ES=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_MAESTRO3_INPUT=y
CONFIG_SND_MIXART=m
# CONFIG_SND_NM256 is not set
CONFIG_SND_PCXHR=m
# CONFIG_SND_RIPTIDE is not set
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_TRIDENT=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_GENERIC_LEDS=y
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=0
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# CONFIG_SND_HDA_INTEL_HDMI_SILENT_STREAM is not set
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=512
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=m
# CONFIG_SND_SPI is not set
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=y
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
CONFIG_SND_USB_HIFACE=m
CONFIG_SND_BCD2000=m
CONFIG_SND_USB_LINE6=m
CONFIG_SND_USB_POD=m
CONFIG_SND_USB_PODHD=m
CONFIG_SND_USB_TONEPORT=m
CONFIG_SND_USB_VARIAX=m
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
# CONFIG_SND_DICE is not set
# CONFIG_SND_OXFW is not set
CONFIG_SND_ISIGHT=m
# CONFIG_SND_FIREWORKS is not set
# CONFIG_SND_BEBOB is not set
# CONFIG_SND_FIREWIRE_DIGI00X is not set
# CONFIG_SND_FIREWIRE_TASCAM is not set
# CONFIG_SND_FIREWIRE_MOTU is not set
# CONFIG_SND_FIREFACE is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=m
# CONFIG_SND_SOC_ADI is not set
# CONFIG_SND_SOC_AMD_ACP is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_SOC_AMD_RENOIR is not set
# CONFIG_SND_ATMEL_SOC is not set
# CONFIG_SND_BCM63XX_I2S_WHISTLER is not set
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
# CONFIG_SND_SOC_FSL_AUDMIX is not set
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_FSL_XCVR is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# end of SoC Audio for Freescale CPUs

# CONFIG_SND_I2S_HI6210_I2S is not set
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SOC_INTEL_SST=m
# CONFIG_SND_SOC_INTEL_CATPT is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
CONFIG_SND_SOC_INTEL_SKYLAKE=m
CONFIG_SND_SOC_INTEL_SKL=m
CONFIG_SND_SOC_INTEL_APL=m
CONFIG_SND_SOC_INTEL_KBL=m
CONFIG_SND_SOC_INTEL_GLK=m
CONFIG_SND_SOC_INTEL_CNL=m
CONFIG_SND_SOC_INTEL_CFL=m
# CONFIG_SND_SOC_INTEL_CML_H is not set
# CONFIG_SND_SOC_INTEL_CML_LP is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=m
CONFIG_SND_SOC_INTEL_SKYLAKE_SSP_CLK=m
# CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=m
CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
CONFIG_SND_SOC_INTEL_MACH=y
# CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES is not set
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=m
# CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH is not set
# CONFIG_SND_SOC_INTEL_BYT_CHT_CX2072X_MACH is not set
CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH=m
CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_DA7219_MAX98357A_GENERIC=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_COMMON=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH=m
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH is not set
# CONFIG_SND_SOC_MTK_BTCVSD is not set
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
# CONFIG_SND_SOC_XILINX_SPDIF is not set
# CONFIG_SND_SOC_XTFPGA_I2S is not set
# CONFIG_ZX_TDM is not set
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
# CONFIG_SND_SOC_ADAU1372_I2C is not set
# CONFIG_SND_SOC_ADAU1372_SPI is not set
# CONFIG_SND_SOC_ADAU1701 is not set
# CONFIG_SND_SOC_ADAU1761_I2C is not set
# CONFIG_SND_SOC_ADAU1761_SPI is not set
# CONFIG_SND_SOC_ADAU7002 is not set
# CONFIG_SND_SOC_ADAU7118_HW is not set
# CONFIG_SND_SOC_ADAU7118_I2C is not set
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4118 is not set
# CONFIG_SND_SOC_AK4458 is not set
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
# CONFIG_SND_SOC_AK4642 is not set
# CONFIG_SND_SOC_AK5386 is not set
# CONFIG_SND_SOC_AK5558 is not set
# CONFIG_SND_SOC_ALC5623 is not set
# CONFIG_SND_SOC_BD28623 is not set
# CONFIG_SND_SOC_BT_SCO is not set
# CONFIG_SND_SOC_CS35L32 is not set
# CONFIG_SND_SOC_CS35L33 is not set
# CONFIG_SND_SOC_CS35L34 is not set
# CONFIG_SND_SOC_CS35L35 is not set
# CONFIG_SND_SOC_CS35L36 is not set
# CONFIG_SND_SOC_CS42L42 is not set
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
# CONFIG_SND_SOC_CS42L73 is not set
# CONFIG_SND_SOC_CS4234 is not set
# CONFIG_SND_SOC_CS4265 is not set
# CONFIG_SND_SOC_CS4270 is not set
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS4271_SPI is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
# CONFIG_SND_SOC_CS43130 is not set
# CONFIG_SND_SOC_CS4341 is not set
# CONFIG_SND_SOC_CS4349 is not set
# CONFIG_SND_SOC_CS53L30 is not set
# CONFIG_SND_SOC_CX2072X is not set
CONFIG_SND_SOC_DA7213=m
CONFIG_SND_SOC_DA7219=m
CONFIG_SND_SOC_DMIC=m
# CONFIG_SND_SOC_ES7134 is not set
# CONFIG_SND_SOC_ES7241 is not set
CONFIG_SND_SOC_ES8316=m
# CONFIG_SND_SOC_ES8328_I2C is not set
# CONFIG_SND_SOC_ES8328_SPI is not set
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_HDAC_HDMI=m
# CONFIG_SND_SOC_INNO_RK3036 is not set
# CONFIG_SND_SOC_MAX98088 is not set
CONFIG_SND_SOC_MAX98090=m
CONFIG_SND_SOC_MAX98357A=m
# CONFIG_SND_SOC_MAX98504 is not set
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98927=m
# CONFIG_SND_SOC_MAX98373_I2C is not set
CONFIG_SND_SOC_MAX98390=m
# CONFIG_SND_SOC_MAX9860 is not set
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
# CONFIG_SND_SOC_PCM1789_I2C is not set
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM179X_SPI is not set
# CONFIG_SND_SOC_PCM186X_I2C is not set
# CONFIG_SND_SOC_PCM186X_SPI is not set
# CONFIG_SND_SOC_PCM3060_I2C is not set
# CONFIG_SND_SOC_PCM3060_SPI is not set
# CONFIG_SND_SOC_PCM3168A_I2C is not set
# CONFIG_SND_SOC_PCM3168A_SPI is not set
# CONFIG_SND_SOC_PCM5102A is not set
# CONFIG_SND_SOC_PCM512x_I2C is not set
# CONFIG_SND_SOC_PCM512x_SPI is not set
# CONFIG_SND_SOC_RK3328 is not set
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RL6347A=m
CONFIG_SND_SOC_RT286=m
CONFIG_SND_SOC_RT298=m
CONFIG_SND_SOC_RT5514=m
CONFIG_SND_SOC_RT5514_SPI=m
# CONFIG_SND_SOC_RT5616 is not set
# CONFIG_SND_SOC_RT5631 is not set
CONFIG_SND_SOC_RT5640=m
CONFIG_SND_SOC_RT5645=m
CONFIG_SND_SOC_RT5651=m
CONFIG_SND_SOC_RT5663=m
CONFIG_SND_SOC_RT5670=m
# CONFIG_SND_SOC_SGTL5000 is not set
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
# CONFIG_SND_SOC_SIMPLE_MUX is not set
# CONFIG_SND_SOC_SIRF_AUDIO_CODEC is not set
# CONFIG_SND_SOC_SPDIF is not set
# CONFIG_SND_SOC_SSM2305 is not set
# CONFIG_SND_SOC_SSM2602_SPI is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
CONFIG_SND_SOC_SSM4567=m
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
# CONFIG_SND_SOC_STI_SAS is not set
# CONFIG_SND_SOC_TAS2552 is not set
# CONFIG_SND_SOC_TAS2562 is not set
# CONFIG_SND_SOC_TAS2764 is not set
# CONFIG_SND_SOC_TAS2770 is not set
# CONFIG_SND_SOC_TAS5086 is not set
# CONFIG_SND_SOC_TAS571X is not set
# CONFIG_SND_SOC_TAS5720 is not set
# CONFIG_SND_SOC_TAS6424 is not set
# CONFIG_SND_SOC_TDA7419 is not set
# CONFIG_SND_SOC_TFA9879 is not set
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
# CONFIG_SND_SOC_TLV320AIC31XX is not set
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
# CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
# CONFIG_SND_SOC_TLV320AIC3X is not set
# CONFIG_SND_SOC_TLV320ADCX140 is not set
CONFIG_SND_SOC_TS3A227E=m
# CONFIG_SND_SOC_TSCS42XX is not set
# CONFIG_SND_SOC_TSCS454 is not set
# CONFIG_SND_SOC_UDA1334 is not set
# CONFIG_SND_SOC_WM8510 is not set
# CONFIG_SND_SOC_WM8523 is not set
# CONFIG_SND_SOC_WM8524 is not set
# CONFIG_SND_SOC_WM8580 is not set
# CONFIG_SND_SOC_WM8711 is not set
# CONFIG_SND_SOC_WM8728 is not set
# CONFIG_SND_SOC_WM8731 is not set
# CONFIG_SND_SOC_WM8737 is not set
# CONFIG_SND_SOC_WM8741 is not set
# CONFIG_SND_SOC_WM8750 is not set
# CONFIG_SND_SOC_WM8753 is not set
# CONFIG_SND_SOC_WM8770 is not set
# CONFIG_SND_SOC_WM8776 is not set
# CONFIG_SND_SOC_WM8782 is not set
# CONFIG_SND_SOC_WM8804_I2C is not set
# CONFIG_SND_SOC_WM8804_SPI is not set
# CONFIG_SND_SOC_WM8903 is not set
# CONFIG_SND_SOC_WM8904 is not set
# CONFIG_SND_SOC_WM8960 is not set
# CONFIG_SND_SOC_WM8962 is not set
# CONFIG_SND_SOC_WM8974 is not set
# CONFIG_SND_SOC_WM8978 is not set
# CONFIG_SND_SOC_WM8985 is not set
# CONFIG_SND_SOC_ZL38060 is not set
# CONFIG_SND_SOC_ZX_AUD96P22 is not set
# CONFIG_SND_SOC_MAX9759 is not set
# CONFIG_SND_SOC_MT6351 is not set
# CONFIG_SND_SOC_MT6358 is not set
# CONFIG_SND_SOC_MT6660 is not set
# CONFIG_SND_SOC_NAU8315 is not set
# CONFIG_SND_SOC_NAU8540 is not set
# CONFIG_SND_SOC_NAU8810 is not set
# CONFIG_SND_SOC_NAU8822 is not set
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_NAU8825=m
# CONFIG_SND_SOC_TPA6130A2 is not set
# CONFIG_SND_SOC_LPASS_WSA_MACRO is not set
# CONFIG_SND_SOC_LPASS_VA_MACRO is not set
# end of CODEC drivers

# CONFIG_SND_SIMPLE_CARD is not set
CONFIG_SND_X86=y
CONFIG_HDMI_LPE_AUDIO=m
CONFIG_SND_SYNTH_EMUX=m
# CONFIG_SND_XEN_FRONTEND is not set
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=m
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_PRODIKEYS=m
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_GLORIOUS is not set
CONFIG_HID_HOLTEK=m
# CONFIG_HOLTEK_FF is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SONY=m
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID=m
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=y
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
CONFIG_USBIP_CORE=m
# CONFIG_USBIP_VHCI_HCD is not set
# CONFIG_USBIP_HOST is not set
# CONFIG_USBIP_DEBUG is not set
# CONFIG_USB_CDNS3 is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
CONFIG_USB_SERIAL_MOS7840=m
# CONFIG_USB_SERIAL_MXUPORT is not set
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
# CONFIG_USB_SERIAL_WISHBONE is not set
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
# CONFIG_USB_SERIAL_UPD78F0730 is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
# CONFIG_APPLE_MFI_FASTCHARGE is not set
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_LD=m
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=m
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=m
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=m
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_STUSB160X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=m
# CONFIG_MMC_SPI is not set
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_INTEL_IDXD is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_ZYNQMP_DPDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

CONFIG_DCA=m
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_LCD2S is not set
# CONFIG_PARPORT_PANEL is not set
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_MDEV_DEVICE=m
CONFIG_IRQ_BYPASS_MANAGER=y
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=m
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=m
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
CONFIG_VIRTIO_MEM=m
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
# CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not set
CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
CONFIG_XEN_DEV_EVTCHN=m
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_HAVE_VPMU=y
# CONFIG_XEN_UNPOPULATED_ALLOC is not set
# end of Xen driver support

# CONFIG_GREYBUS is not set
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
CONFIG_RTLLIB=m
CONFIG_RTLLIB_CRYPTO_CCMP=m
CONFIG_RTLLIB_CRYPTO_TKIP=m
CONFIG_RTLLIB_CRYPTO_WEP=m
CONFIG_RTL8192E=m
# CONFIG_RTL8723BS is not set
CONFIG_R8712U=m
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16203 is not set
# CONFIG_ADIS16240 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7816 is not set
# CONFIG_AD7280 is not set
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
# CONFIG_AD9832 is not set
# CONFIG_AD9834 is not set
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
# CONFIG_ADE7854 is not set
# end of Active energy metering IC

#
# Resolver to digital converters
#
# CONFIG_AD2S1210 is not set
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_FB_SM750 is not set
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
# end of Android

# CONFIG_LTE_GDM724X is not set
CONFIG_FIREWIRE_SERIAL=m
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# end of Gasket devices

# CONFIG_FIELDBUS_DEV is not set
# CONFIG_KPC2000 is not set
CONFIG_QLGE=m
# CONFIG_WIMAX is not set
# CONFIG_WFX is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_ALIENWARE_WMI is not set
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_XIAOMI_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMC is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
CONFIG_DCDBAS=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
CONFIG_DELL_SMBIOS_SMM=y
CONFIG_DELL_LAPTOP=m
CONFIG_DELL_RBTN=m
CONFIG_DELL_RBU=m
CONFIG_DELL_SMO8800=m
CONFIG_DELL_WMI=m
# CONFIG_DELL_WMI_SYSMAN is not set
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_AIO=m
# CONFIG_DELL_WMI_LED is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_INTEL_ATOMISP2_PM is not set
CONFIG_INTEL_HID_EVENT=m
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_MENLOW is not set
CONFIG_INTEL_OAKTRAIL=m
CONFIG_INTEL_VBTN=m
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_I2C_MULTI_INSTANTIATE is not set
# CONFIG_MLX_PLATFORM is not set
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

# CONFIG_INTEL_TURBO_MAX_3 is not set
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
CONFIG_INTEL_PMC_CORE=m
# CONFIG_INTEL_PMT_CLASS is not set
# CONFIG_INTEL_PMT_TELEMETRY is not set
# CONFIG_INTEL_PMT_CRASHLOG is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
# CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
# CONFIG_IIO_BUFFER_DMA is not set
# CONFIG_IIO_BUFFER_DMAENGINE is not set
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=m
# CONFIG_IIO_CONFIGFS is not set
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
# CONFIG_IIO_SW_TRIGGER is not set
# CONFIG_IIO_TRIGGERED_EVENT is not set

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
# CONFIG_ADIS16209 is not set
# CONFIG_ADXL345_I2C is not set
# CONFIG_ADXL345_SPI is not set
# CONFIG_ADXL372_SPI is not set
# CONFIG_ADXL372_I2C is not set
# CONFIG_BMA180 is not set
# CONFIG_BMA220 is not set
# CONFIG_BMA400 is not set
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
# CONFIG_DA311 is not set
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
CONFIG_HID_SENSOR_ACCEL_3D=m
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7455_SPI is not set
# CONFIG_MMA7660 is not set
# CONFIG_MMA8452 is not set
# CONFIG_MMA9551 is not set
# CONFIG_MMA9553 is not set
# CONFIG_MXC4005 is not set
# CONFIG_MXC6255 is not set
# CONFIG_SCA3000 is not set
# CONFIG_STK8312 is not set
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7091R5 is not set
# CONFIG_AD7124 is not set
# CONFIG_AD7192 is not set
# CONFIG_AD7266 is not set
# CONFIG_AD7291 is not set
# CONFIG_AD7292 is not set
# CONFIG_AD7298 is not set
# CONFIG_AD7476 is not set
# CONFIG_AD7606_IFACE_PARALLEL is not set
# CONFIG_AD7606_IFACE_SPI is not set
# CONFIG_AD7766 is not set
# CONFIG_AD7768_1 is not set
# CONFIG_AD7780 is not set
# CONFIG_AD7791 is not set
# CONFIG_AD7793 is not set
# CONFIG_AD7887 is not set
# CONFIG_AD7923 is not set
# CONFIG_AD7949 is not set
# CONFIG_AD799X is not set
# CONFIG_AD9467 is not set
# CONFIG_ADI_AXI_ADC is not set
# CONFIG_HI8435 is not set
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
# CONFIG_LTC2471 is not set
# CONFIG_LTC2485 is not set
# CONFIG_LTC2496 is not set
# CONFIG_LTC2497 is not set
# CONFIG_MAX1027 is not set
# CONFIG_MAX11100 is not set
# CONFIG_MAX1118 is not set
# CONFIG_MAX1241 is not set
# CONFIG_MAX1363 is not set
# CONFIG_MAX9611 is not set
# CONFIG_MCP320X is not set
# CONFIG_MCP3422 is not set
# CONFIG_MCP3911 is not set
# CONFIG_NAU7802 is not set
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADC0832 is not set
# CONFIG_TI_ADC084S021 is not set
# CONFIG_TI_ADC12138 is not set
# CONFIG_TI_ADC108S102 is not set
# CONFIG_TI_ADC128S052 is not set
# CONFIG_TI_ADC161S626 is not set
# CONFIG_TI_ADS1015 is not set
# CONFIG_TI_ADS7950 is not set
# CONFIG_TI_TLC4541 is not set
# CONFIG_VIPERBOARD_ADC is not set
# CONFIG_XILINX_XADC is not set
# end of Analog to digital converters

#
# Analog Front Ends
#
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_AD8366 is not set
# CONFIG_HMC425 is not set
# end of Amplifiers

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
# CONFIG_ATLAS_EZO_SENSOR is not set
# CONFIG_BME680 is not set
# CONFIG_CCS811 is not set
# CONFIG_IAQCORE is not set
# CONFIG_SCD30_CORE is not set
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SPS30 is not set
# CONFIG_VZ89X is not set
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
# end of Hid Sensor IIO Common

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
# end of SSP Sensor Common

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5360 is not set
# CONFIG_AD5380 is not set
# CONFIG_AD5421 is not set
# CONFIG_AD5446 is not set
# CONFIG_AD5449 is not set
# CONFIG_AD5592R is not set
# CONFIG_AD5593R is not set
# CONFIG_AD5504 is not set
# CONFIG_AD5624R_SPI is not set
# CONFIG_AD5686_SPI is not set
# CONFIG_AD5696_I2C is not set
# CONFIG_AD5755 is not set
# CONFIG_AD5758 is not set
# CONFIG_AD5761 is not set
# CONFIG_AD5764 is not set
# CONFIG_AD5770R is not set
# CONFIG_AD5791 is not set
# CONFIG_AD7303 is not set
# CONFIG_AD8801 is not set
# CONFIG_DS4424 is not set
# CONFIG_LTC1660 is not set
# CONFIG_LTC2632 is not set
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
# CONFIG_MCP4725 is not set
# CONFIG_MCP4922 is not set
# CONFIG_TI_DAC082S085 is not set
# CONFIG_TI_DAC5571 is not set
# CONFIG_TI_DAC7311 is not set
# CONFIG_TI_DAC7612 is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set
# CONFIG_ADF4371 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
# CONFIG_ADIS16130 is not set
# CONFIG_ADIS16136 is not set
# CONFIG_ADIS16260 is not set
# CONFIG_ADXRS290 is not set
# CONFIG_ADXRS450 is not set
# CONFIG_BMG160 is not set
# CONFIG_FXAS21002C is not set
CONFIG_HID_SENSOR_GYRO_3D=m
# CONFIG_MPU3050_I2C is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
# CONFIG_HDC2010 is not set
# CONFIG_HID_SENSOR_HUMIDITY is not set
# CONFIG_HTS221 is not set
# CONFIG_HTU21 is not set
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
# CONFIG_ADIS16460 is not set
# CONFIG_ADIS16475 is not set
# CONFIG_ADIS16480 is not set
# CONFIG_BMI160_I2C is not set
# CONFIG_BMI160_SPI is not set
# CONFIG_FXOS8700_I2C is not set
# CONFIG_FXOS8700_SPI is not set
# CONFIG_KMX61 is not set
# CONFIG_INV_ICM42600_I2C is not set
# CONFIG_INV_ICM42600_SPI is not set
# CONFIG_INV_MPU6050_I2C is not set
# CONFIG_INV_MPU6050_SPI is not set
# CONFIG_IIO_ST_LSM6DSX is not set
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
# CONFIG_ADUX1020 is not set
# CONFIG_AL3010 is not set
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
# CONFIG_APDS9960 is not set
# CONFIG_AS73211 is not set
# CONFIG_BH1750 is not set
# CONFIG_BH1780 is not set
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM36651 is not set
# CONFIG_GP2AP002 is not set
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
CONFIG_HID_SENSOR_ALS=m
CONFIG_HID_SENSOR_PROX=m
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
# CONFIG_LTR501 is not set
# CONFIG_LV0104CS is not set
# CONFIG_MAX44000 is not set
# CONFIG_MAX44009 is not set
# CONFIG_NOA1305 is not set
# CONFIG_OPT3001 is not set
# CONFIG_PA12203001 is not set
# CONFIG_SI1133 is not set
# CONFIG_SI1145 is not set
# CONFIG_STK3310 is not set
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
# CONFIG_TSL2772 is not set
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
# CONFIG_VCNL4035 is not set
# CONFIG_VEML6030 is not set
# CONFIG_VEML6070 is not set
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_BMC150_MAGN_SPI is not set
# CONFIG_MAG3110 is not set
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
# CONFIG_SENSORS_HMC5843_I2C is not set
# CONFIG_SENSORS_HMC5843_SPI is not set
# CONFIG_SENSORS_RM3100_I2C is not set
# CONFIG_SENSORS_RM3100_SPI is not set
# end of Magnetometer sensors

#
# Multiplexers
#
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
CONFIG_HID_SENSOR_DEVICE_ROTATION=m
# end of Inclinometer sensors

#
# Triggers - standalone
#
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
# CONFIG_IIO_SYSFS_TRIGGER is not set
# end of Triggers - standalone

#
# Linear and angular position sensors
#
# end of Linear and angular position sensors

#
# Digital potentiometers
#
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
# CONFIG_MAX5432 is not set
# CONFIG_MAX5481 is not set
# CONFIG_MAX5487 is not set
# CONFIG_MCP4018 is not set
# CONFIG_MCP4131 is not set
# CONFIG_MCP4531 is not set
# CONFIG_MCP41010 is not set
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
# CONFIG_BMP280 is not set
# CONFIG_DLHL60D is not set
# CONFIG_DPS310 is not set
CONFIG_HID_SENSOR_PRESS=m
# CONFIG_HP03 is not set
# CONFIG_ICP10100 is not set
# CONFIG_MPL115_I2C is not set
# CONFIG_MPL115_SPI is not set
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# CONFIG_AS3935 is not set
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
# CONFIG_LIDAR_LITE_V2 is not set
# CONFIG_MB1232 is not set
# CONFIG_PING is not set
# CONFIG_RFD77402 is not set
# CONFIG_SRF04 is not set
# CONFIG_SX9310 is not set
# CONFIG_SX9500 is not set
# CONFIG_SRF08 is not set
# CONFIG_VCNL3020 is not set
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
# CONFIG_AD2S1200 is not set
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_LTC2983 is not set
# CONFIG_MAXIM_THERMOCOUPLE is not set
# CONFIG_HID_SENSOR_TEMP is not set
# CONFIG_MLX90614 is not set
# CONFIG_MLX90632 is not set
# CONFIG_TMP006 is not set
# CONFIG_TMP007 is not set
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
# CONFIG_MAX31856 is not set
# end of Temperature sensors

CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
CONFIG_NTB_AMD=m
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
CONFIG_NTB_PERF=m
CONFIG_NTB_TRANSPORT=m
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_DWC is not set
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_USB_LGM_PHY is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_DEV_DAX_PMEM_COMPAT=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=m
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=m
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=m
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
# CONFIG_XFS_RT is not set
# CONFIG_XFS_ONLINE_SCRUB is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_UBIFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=m
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
# CONFIG_SECURITY_SELINUX_DISABLE is not set
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
CONFIG_IMA_READ_POLICY=y
CONFIG_IMA_APPRAISE=y
CONFIG_IMA_ARCH_POLICY=y
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=m

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=m
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=m
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
CONFIG_CRYPTO_DEV_CHELSIO=m
CONFIG_CRYPTO_DEV_VIRTIO=m
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_BTREE=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_COHERENT_POOL=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
CONFIG_DEBUG_INFO_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_32B is not set
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
CONFIG_TRACE_PREEMPT_TOGGLE=y
CONFIG_IRQSOFF_TRACER=y
CONFIG_PREEMPT_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
# CONFIG_SAMPLE_TRACE_EVENTS is not set
CONFIG_SAMPLE_TRACE_PRINTK=m
CONFIG_SAMPLE_FTRACE_DIRECT=m
# CONFIG_SAMPLE_TRACE_ARRAY is not set
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_LIVEPATCH is not set
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_VFIO_MDEV_MTTY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_VFIO_MDEV_MBOCHS is not set
# CONFIG_SAMPLE_WATCHDOG is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=y
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=m
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_BITOPS=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=y
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
CONFIG_TEST_HMM=m
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='kernel-selftests'
	export testcase='kernel-selftests'
	export category='functional'
	export kconfig='x86_64-rhel-7.6-kselftests'
	export need_memory='3G'
	export need_cpu=2
	export kernel_cmdline='sysctl.debug.test_sysctl.boot_int=1'
	export job_origin='kernel-selftests.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-skl-d05'
	export tbox_group='lkp-skl-d05'
	export submit_id='60205fd15ffe0e2e72326add'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-group-s-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5-20210208-77426-1mwwqme-3.yaml'
	export id='683027ea3a57b476c1ab632fdd5a13755fc1a115'
	export queuer_version='/lkp-src'
	export model='Skylake'
	export nr_cpu=4
	export memory='32G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=4
	export hdd_partitions='/dev/disk/by-id/wwn-0x5000c50091e544de-part*'
	export ssd_partitions='/dev/disk/by-id/wwn-0x55cd2e4151977e28-part2'
	export rootfs_partition='/dev/disk/by-id/wwn-0x55cd2e4151977e28-part1'
	export brand='Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz'
	export commit='dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5'
	export need_kconfig_hw='CONFIG_E1000E=y
CONFIG_SATA_AHCI'
	export ucode='0xe2'
	export need_linux_headers=true
	export need_linux_selftests=true
	export need_kconfig='CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_PID_NS=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
CONFIG_USER_NS=y
CONFIG_TEST_LKM=m
CONFIG_TEST_STATIC_KEYS=m
CONFIG_STAGING=y
CONFIG_ANDROID=y
CONFIG_SYNC=y ~ "<= v4.7"
CONFIG_SW_SYNC=y
CONFIG_GENERIC_ENTRY=y
CONFIG_TEST_SYSCTL=y'
	export enqueue_time='2021-02-08 05:46:57 +0800'
	export _id='60205fd15ffe0e2e72326add'
	export _rt='/result/kernel-selftests/group-s-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/gcc-9/dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='918913a57dffb6957c35bea5ffdc636fa44b1822'
	export base_commit='1048ba83fb1c00cd24172e23e8263972f6b5d9ac'
	export branch='linux-review/Chang-S-Bae/x86-Improve-Minimum-Alternate-Stack-Size/20210204-013311'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/kernel-selftests/group-s-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/gcc-9/dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/3'
	export scheduler_version='/lkp/lkp/.src-20210207-181621'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-group-s-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5-20210208-77426-1mwwqme-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-7.6-kselftests
branch=linux-review/Chang-S-Bae/x86-Improve-Minimum-Alternate-Stack-Size/20210204-013311
commit=dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5
BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/vmlinuz-5.11.0-rc5-00462-gdc8df6e85d2c
sysctl.debug.test_sysctl.boot_int=1
max_uptime=2100
RESULT_ROOT=/result/kernel-selftests/group-s-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/gcc-9/dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/3
LKP_SERVER=internal-lkp-server
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/modules.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/linux-selftests.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/kernel-selftests_20201231.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/kernel-selftests-x86_64-b553cffa-1_20210122.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20201117.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.10.0-03014-g76d4acf22b48'
	export repeat_to=4
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/vmlinuz-5.11.0-rc5-00462-gdc8df6e85d2c'
	export dequeue_time='2021-02-08 05:50:09 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-group-s-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5-20210208-77426-1mwwqme-3.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='group-s' $LKP_SRC/tests/wrapper kernel-selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env group='group-s' $LKP_SRC/stats/wrapper kernel-selftests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time kernel-selftests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--OgqxwSJOaUobr8KG
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
WVo=

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=kernel-selftests
Content-Transfer-Encoding: quoted-printable

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-7=
=2E6-kselftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5
2021-02-07 21:51:40 ln -sf /usr/bin/clang
2021-02-07 21:51:40 ln -sf /usr/bin/llc
2021-02-07 21:51:40 sed -i s/default_timeout=3D45/default_timeout=3D300/ ks=
elftest/runner.sh
safesetid test: not in Makefile
2021-02-07 21:51:40 make TARGETS=3Dsafesetid
make --no-builtin-rules ARCH=3Dx86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5'
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/unifdef
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/x86/include/generated/uapi/asm/errno.h
  WRAP    arch/x86/include/generated/uapi/asm/fcntl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctls.h
  WRAP    arch/x86/include/generated/uapi/asm/ipcbuf.h
  WRAP    arch/x86/include/generated/uapi/asm/param.h
  WRAP    arch/x86/include/generated/uapi/asm/poll.h
  WRAP    arch/x86/include/generated/uapi/asm/resource.h
  WRAP    arch/x86/include/generated/uapi/asm/socket.h
  WRAP    arch/x86/include/generated/uapi/asm/sockios.h
  WRAP    arch/x86/include/generated/uapi/asm/termbits.h
  WRAP    arch/x86/include/generated/uapi/asm/termios.h
  WRAP    arch/x86/include/generated/uapi/asm/types.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
  UPD     include/generated/uapi/linux/version.h
  HDRINST usr/include/video/sisfb.h
  HDRINST usr/include/video/uvesafb.h
  HDRINST usr/include/video/edid.h
  HDRINST usr/include/drm/i810_drm.h
  HDRINST usr/include/drm/exynos_drm.h
  HDRINST usr/include/drm/msm_drm.h
  HDRINST usr/include/drm/lima_drm.h
  HDRINST usr/include/drm/nouveau_drm.h
  HDRINST usr/include/drm/via_drm.h
  HDRINST usr/include/drm/vmwgfx_drm.h
  HDRINST usr/include/drm/virtgpu_drm.h
  HDRINST usr/include/drm/omap_drm.h
  HDRINST usr/include/drm/amdgpu_drm.h
  HDRINST usr/include/drm/drm.h
  HDRINST usr/include/drm/r128_drm.h
  HDRINST usr/include/drm/drm_fourcc.h
  HDRINST usr/include/drm/qxl_drm.h
  HDRINST usr/include/drm/sis_drm.h
  HDRINST usr/include/drm/armada_drm.h
  HDRINST usr/include/drm/panfrost_drm.h
  HDRINST usr/include/drm/v3d_drm.h
  HDRINST usr/include/drm/vc4_drm.h
  HDRINST usr/include/drm/etnaviv_drm.h
  HDRINST usr/include/drm/savage_drm.h
  HDRINST usr/include/drm/i915_drm.h
  HDRINST usr/include/drm/tegra_drm.h
  HDRINST usr/include/drm/vgem_drm.h
  HDRINST usr/include/drm/radeon_drm.h
  HDRINST usr/include/drm/drm_mode.h
  HDRINST usr/include/drm/drm_sarea.h
  HDRINST usr/include/drm/mga_drm.h
  HDRINST usr/include/mtd/mtd-abi.h
  HDRINST usr/include/mtd/nftl-user.h
  HDRINST usr/include/mtd/ubi-user.h
  HDRINST usr/include/mtd/inftl-user.h
  HDRINST usr/include/mtd/mtd-user.h
  HDRINST usr/include/xen/privcmd.h
  HDRINST usr/include/xen/evtchn.h
  HDRINST usr/include/xen/gntalloc.h
  HDRINST usr/include/xen/gntdev.h
  HDRINST usr/include/asm-generic/ipcbuf.h
  HDRINST usr/include/asm-generic/statfs.h
  HDRINST usr/include/asm-generic/int-l64.h
  HDRINST usr/include/asm-generic/termbits.h
  HDRINST usr/include/asm-generic/errno.h
  HDRINST usr/include/asm-generic/sembuf.h
  HDRINST usr/include/asm-generic/ucontext.h
  HDRINST usr/include/asm-generic/hugetlb_encode.h
  HDRINST usr/include/asm-generic/signal-defs.h
  HDRINST usr/include/asm-generic/poll.h
  HDRINST usr/include/asm-generic/termios.h
  HDRINST usr/include/asm-generic/socket.h
  HDRINST usr/include/asm-generic/ioctl.h
  HDRINST usr/include/asm-generic/sockios.h
  HDRINST usr/include/asm-generic/fcntl.h
  HDRINST usr/include/asm-generic/msgbuf.h
  HDRINST usr/include/asm-generic/kvm_para.h
  HDRINST usr/include/asm-generic/bpf_perf_event.h
  HDRINST usr/include/asm-generic/bitsperlong.h
  HDRINST usr/include/asm-generic/errno-base.h
  HDRINST usr/include/asm-generic/mman.h
  HDRINST usr/include/asm-generic/siginfo.h
  HDRINST usr/include/asm-generic/mman-common.h
  HDRINST usr/include/asm-generic/setup.h
  HDRINST usr/include/asm-generic/resource.h
  HDRINST usr/include/asm-generic/param.h
  HDRINST usr/include/asm-generic/swab.h
  HDRINST usr/include/asm-generic/posix_types.h
  HDRINST usr/include/asm-generic/types.h
  HDRINST usr/include/asm-generic/auxvec.h
  HDRINST usr/include/asm-generic/signal.h
  HDRINST usr/include/asm-generic/int-ll64.h
  HDRINST usr/include/asm-generic/ioctls.h
  HDRINST usr/include/asm-generic/unistd.h
  HDRINST usr/include/asm-generic/shmbuf.h
  HDRINST usr/include/asm-generic/stat.h
  HDRINST usr/include/rdma/ib_user_ioctl_verbs.h
  HDRINST usr/include/rdma/rdma_user_cm.h
  HDRINST usr/include/rdma/cxgb4-abi.h
  HDRINST usr/include/rdma/hns-abi.h
  HDRINST usr/include/rdma/i40iw-abi.h
  HDRINST usr/include/rdma/siw-abi.h
  HDRINST usr/include/rdma/ocrdma-abi.h
  HDRINST usr/include/rdma/hfi/hfi1_user.h
  HDRINST usr/include/rdma/hfi/hfi1_ioctl.h
  HDRINST usr/include/rdma/rdma_user_ioctl.h
  HDRINST usr/include/rdma/bnxt_re-abi.h
  HDRINST usr/include/rdma/ib_user_mad.h
  HDRINST usr/include/rdma/rdma_user_rxe.h
  HDRINST usr/include/rdma/mthca-abi.h
  HDRINST usr/include/rdma/rdma_netlink.h
  HDRINST usr/include/rdma/ib_user_ioctl_cmds.h
  HDRINST usr/include/rdma/rdma_user_ioctl_cmds.h
  HDRINST usr/include/rdma/qedr-abi.h
  HDRINST usr/include/rdma/ib_user_sa.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_verbs.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_cmds.h
  HDRINST usr/include/rdma/vmw_pvrdma-abi.h
  HDRINST usr/include/rdma/mlx4-abi.h
  HDRINST usr/include/rdma/rvt-abi.h
  HDRINST usr/include/rdma/efa-abi.h
  HDRINST usr/include/rdma/mlx5-abi.h
  HDRINST usr/include/rdma/ib_user_verbs.h
  HDRINST usr/include/misc/xilinx_sdfec.h
  HDRINST usr/include/misc/pvpanic.h
  HDRINST usr/include/misc/habanalabs.h
  HDRINST usr/include/misc/fastrpc.h
  HDRINST usr/include/misc/ocxl.h
  HDRINST usr/include/misc/cxl.h
  HDRINST usr/include/misc/uacce/uacce.h
  HDRINST usr/include/misc/uacce/hisi_qm.h
  HDRINST usr/include/linux/sed-opal.h
  HDRINST usr/include/linux/qnx4_fs.h
  HDRINST usr/include/linux/if_cablemodem.h
  HDRINST usr/include/linux/auto_fs4.h
  HDRINST usr/include/linux/toshiba.h
  HDRINST usr/include/linux/arm_sdei.h
  HDRINST usr/include/linux/mmtimer.h
  HDRINST usr/include/linux/devlink.h
  HDRINST usr/include/linux/joystick.h
  HDRINST usr/include/linux/ultrasound.h
  HDRINST usr/include/linux/rio_mport_cdev.h
  HDRINST usr/include/linux/userfaultfd.h
  HDRINST usr/include/linux/dvb/version.h
  HDRINST usr/include/linux/dvb/net.h
  HDRINST usr/include/linux/dvb/video.h
  HDRINST usr/include/linux/dvb/dmx.h
  HDRINST usr/include/linux/dvb/frontend.h
  HDRINST usr/include/linux/dvb/audio.h
  HDRINST usr/include/linux/dvb/osd.h
  HDRINST usr/include/linux/dvb/ca.h
  HDRINST usr/include/linux/ip6_tunnel.h
  HDRINST usr/include/linux/sock_diag.h
  HDRINST usr/include/linux/in.h
  HDRINST usr/include/linux/efs_fs_sb.h
  HDRINST usr/include/linux/tty.h
  HDRINST usr/include/linux/nfs_mount.h
  HDRINST usr/include/linux/kd.h
  HDRINST usr/include/linux/arcfb.h
  HDRINST usr/include/linux/membarrier.h
  HDRINST usr/include/linux/nfs_fs.h
  HDRINST usr/include/linux/vsockmon.h
  HDRINST usr/include/linux/netfilter_ipv4.h
  HDRINST usr/include/linux/ipv6_route.h
  HDRINST usr/include/linux/virtio_scsi.h
  HDRINST usr/include/linux/edd.h
  HDRINST usr/include/linux/atmarp.h
  HDRINST usr/include/linux/atm_eni.h
  HDRINST usr/include/linux/auto_fs.h
  HDRINST usr/include/linux/virtio_ring.h
  HDRINST usr/include/linux/iio/events.h
  HDRINST usr/include/linux/iio/types.h
  HDRINST usr/include/linux/libc-compat.h
  HDRINST usr/include/linux/futex.h
  HDRINST usr/include/linux/isst_if.h
  HDRINST usr/include/linux/net_namespace.h
  HDRINST usr/include/linux/fb.h
  HDRINST usr/include/linux/vboxguest.h
  HDRINST usr/include/linux/fadvise.h
  HDRINST usr/include/linux/seg6_genl.h
  HDRINST usr/include/linux/times.h
  HDRINST usr/include/linux/hsr_netlink.h
  HDRINST usr/include/linux/llc.h
  HDRINST usr/include/linux/uuid.h
  HDRINST usr/include/linux/nvme_ioctl.h
  HDRINST usr/include/linux/watchdog.h
  HDRINST usr/include/linux/tipc.h
  HDRINST usr/include/linux/capability.h
  HDRINST usr/include/linux/dm-ioctl.h
  HDRINST usr/include/linux/nbd-netlink.h
  HDRINST usr/include/linux/virtio_mem.h
  HDRINST usr/include/linux/hid.h
  HDRINST usr/include/linux/am437x-vpfe.h
  HDRINST usr/include/linux/rio_cm_cdev.h
  HDRINST usr/include/linux/cgroupstats.h
  HDRINST usr/include/linux/affs_hardblocks.h
  HDRINST usr/include/linux/net.h
  HDRINST usr/include/linux/virtio_input.h
  HDRINST usr/include/linux/blkpg.h
  HDRINST usr/include/linux/fd.h
  HDRINST usr/include/linux/cciss_defs.h
  HDRINST usr/include/linux/errno.h
  HDRINST usr/include/linux/ivtv.h
  HDRINST usr/include/linux/netlink.h
  HDRINST usr/include/linux/serial_reg.h
  HDRINST usr/include/linux/radeonfb.h
  HDRINST usr/include/linux/vm_sockets_diag.h
  HDRINST usr/include/linux/lwtunnel.h
  HDRINST usr/include/linux/time.h
  HDRINST usr/include/linux/pci_regs.h
  HDRINST usr/include/linux/perf_event.h
  HDRINST usr/include/linux/virtio_gpu.h
  HDRINST usr/include/linux/magic.h
  HDRINST usr/include/linux/close_range.h
  HDRINST usr/include/linux/v4l2-mediabus.h
  HDRINST usr/include/linux/ax25.h
  HDRINST usr/include/linux/binfmts.h
  HDRINST usr/include/linux/hdlc.h
  HDRINST usr/include/linux/cfm_bridge.h
  HDRINST usr/include/linux/v4l2-controls.h
  HDRINST usr/include/linux/mptcp.h
  HDRINST usr/include/linux/ndctl.h
  HDRINST usr/include/linux/mpls_iptunnel.h
  HDRINST usr/include/linux/a.out.h
  HDRINST usr/include/linux/nfsacl.h
  HDRINST usr/include/linux/rpmsg.h
  HDRINST usr/include/linux/seg6_iptunnel.h
  HDRINST usr/include/linux/netfilter_ipv6.h
  HDRINST usr/include/linux/tiocl.h
  HDRINST usr/include/linux/rpl.h
  HDRINST usr/include/linux/stm.h
  HDRINST usr/include/linux/qrtr.h
  HDRINST usr/include/linux/soundcard.h
  HDRINST usr/include/linux/route.h
  HDRINST usr/include/linux/hw_breakpoint.h
  HDRINST usr/include/linux/nfs4.h
  HDRINST usr/include/linux/keyctl.h
  HDRINST usr/include/linux/pktcdvd.h
  HDRINST usr/include/linux/android/binder.h
  HDRINST usr/include/linux/android/binderfs.h
  HDRINST usr/include/linux/firewire-cdev.h
  HDRINST usr/include/linux/mroute6.h
  HDRINST usr/include/linux/nilfs2_ondisk.h
  HDRINST usr/include/linux/zorro_ids.h
  HDRINST usr/include/linux/fsi.h
  HDRINST usr/include/linux/remoteproc_cdev.h
  HDRINST usr/include/linux/mrp_bridge.h
  HDRINST usr/include/linux/lirc.h
  HDRINST usr/include/linux/loop.h
  HDRINST usr/include/linux/cm4000_cs.h
  HDRINST usr/include/linux/inotify.h
  HDRINST usr/include/linux/prctl.h
  HDRINST usr/include/linux/aspeed-p2a-ctrl.h
  HDRINST usr/include/linux/hpet.h
  HDRINST usr/include/linux/synclink.h
  HDRINST usr/include/linux/reiserfs_xattr.h
  HDRINST usr/include/linux/if_fc.h
  HDRINST usr/include/linux/patchkey.h
  HDRINST usr/include/linux/mroute.h
  HDRINST usr/include/linux/if_slip.h
  HDRINST usr/include/linux/dn.h
  HDRINST usr/include/linux/batadv_packet.h
  HDRINST usr/include/linux/kernel-page-flags.h
  HDRINST usr/include/linux/ipx.h
  HDRINST usr/include/linux/signalfd.h
  HDRINST usr/include/linux/elf.h
  HDRINST usr/include/linux/tty_flags.h
  HDRINST usr/include/linux/phonet.h
  HDRINST usr/include/linux/tipc_sockets_diag.h
  HDRINST usr/include/linux/pmu.h
  HDRINST usr/include/linux/ip.h
  HDRINST usr/include/linux/nfs3.h
  HDRINST usr/include/linux/rseq.h
  HDRINST usr/include/linux/meye.h
  HDRINST usr/include/linux/firewire-constants.h
  HDRINST usr/include/linux/bt-bmc.h
  HDRINST usr/include/linux/vt.h
  HDRINST usr/include/linux/can.h
  HDRINST usr/include/linux/atm_idt77105.h
  HDRINST usr/include/linux/uleds.h
  HDRINST usr/include/linux/audit.h
  HDRINST usr/include/linux/ptrace.h
  HDRINST usr/include/linux/virtio_mmio.h
  HDRINST usr/include/linux/poll.h
  HDRINST usr/include/linux/if.h
  HDRINST usr/include/linux/vhost.h
  HDRINST usr/include/linux/nitro_enclaves.h
  HDRINST usr/include/linux/kfd_ioctl.h
  HDRINST usr/include/linux/serial_core.h
  HDRINST usr/include/linux/if_addrlabel.h
  HDRINST usr/include/linux/if_arcnet.h
  HDRINST usr/include/linux/btrfs.h
  HDRINST usr/include/linux/serio.h
  HDRINST usr/include/linux/sctp.h
  HDRINST usr/include/linux/const.h
  HDRINST usr/include/linux/nexthop.h
  HDRINST usr/include/linux/tc_act/tc_gact.h
  HDRINST usr/include/linux/tc_act/tc_bpf.h
  HDRINST usr/include/linux/tc_act/tc_ipt.h
  HDRINST usr/include/linux/tc_act/tc_ct.h
  HDRINST usr/include/linux/tc_act/tc_gate.h
  HDRINST usr/include/linux/tc_act/tc_skbedit.h
  HDRINST usr/include/linux/tc_act/tc_skbmod.h
  HDRINST usr/include/linux/tc_act/tc_ife.h
  HDRINST usr/include/linux/tc_act/tc_sample.h
  HDRINST usr/include/linux/tc_act/tc_mpls.h
  HDRINST usr/include/linux/tc_act/tc_nat.h
  HDRINST usr/include/linux/tc_act/tc_tunnel_key.h
  HDRINST usr/include/linux/tc_act/tc_connmark.h
  HDRINST usr/include/linux/tc_act/tc_ctinfo.h
  HDRINST usr/include/linux/tc_act/tc_defact.h
  HDRINST usr/include/linux/tc_act/tc_vlan.h
  HDRINST usr/include/linux/tc_act/tc_pedit.h
  HDRINST usr/include/linux/tc_act/tc_csum.h
  HDRINST usr/include/linux/tc_act/tc_mirred.h
  HDRINST usr/include/linux/netfilter_decnet.h
  HDRINST usr/include/linux/blktrace_api.h
  HDRINST usr/include/linux/termios.h
  HDRINST usr/include/linux/in6.h
  HDRINST usr/include/linux/sysctl.h
  HDRINST usr/include/linux/netfilter.h
  HDRINST usr/include/linux/tcp_metrics.h
  HDRINST usr/include/linux/socket.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6_tables.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_opts.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_HL.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_rt.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_srh.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_frag.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_LOG.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_mh.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_hl.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ipv6header.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_NPT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ah.h
  HDRINST usr/include/linux/wireguard.h
  HDRINST usr/include/linux/cyclades.h
  HDRINST usr/include/linux/uinput.h
  HDRINST usr/include/linux/kcov.h
  HDRINST usr/include/linux/bpfilter.h
  HDRINST usr/include/linux/nl80211.h
  HDRINST usr/include/linux/if_plip.h
  HDRINST usr/include/linux/mpls.h
  HDRINST usr/include/linux/dlm_device.h
  HDRINST usr/include/linux/n_r3964.h
  HDRINST usr/include/linux/kdev_t.h
  HDRINST usr/include/linux/ioctl.h
  HDRINST usr/include/linux/atmppp.h
  HDRINST usr/include/linux/scif_ioctl.h
  HDRINST usr/include/linux/fpga-dfl.h
  HDRINST usr/include/linux/tls.h
  HDRINST usr/include/linux/if_x25.h
  HDRINST usr/include/linux/string.h
  HDRINST usr/include/linux/nbd.h
  HDRINST usr/include/linux/pcitest.h
  HDRINST usr/include/linux/ivtvfb.h
  HDRINST usr/include/linux/ipsec.h
  HDRINST usr/include/linux/timerfd.h
  HDRINST usr/include/linux/acct.h
  HDRINST usr/include/linux/ip_vs.h
  HDRINST usr/include/linux/vfio_ccw.h
  HDRINST usr/include/linux/ethtool.h
  HDRINST usr/include/linux/gfs2_ondisk.h
  HDRINST usr/include/linux/dlm_netlink.h
  HDRINST usr/include/linux/isdn/capicmd.h
  HDRINST usr/include/linux/mei.h
  HDRINST usr/include/linux/uvcvideo.h
  HDRINST usr/include/linux/if_alg.h
  HDRINST usr/include/linux/atmsvc.h
  HDRINST usr/include/linux/io_uring.h
  HDRINST usr/include/linux/bcm933xx_hcs.h
  HDRINST usr/include/linux/if_link.h
  HDRINST usr/include/linux/connector.h
  HDRINST usr/include/linux/sockios.h
  HDRINST usr/include/linux/fcntl.h
  HDRINST usr/include/linux/filter.h
  HDRINST usr/include/linux/pr.h
  HDRINST usr/include/linux/securebits.h
  HDRINST usr/include/linux/kernel.h
  HDRINST usr/include/linux/xdp_diag.h
  HDRINST usr/include/linux/fanotify.h
  HDRINST usr/include/linux/v4l2-common.h
  HDRINST usr/include/linux/omapfb.h
  HDRINST usr/include/linux/nubus.h
  HDRINST usr/include/linux/videodev2.h
  HDRINST usr/include/linux/i2c.h
  HDRINST usr/include/linux/gtp.h
  HDRINST usr/include/linux/virtio_types.h
  HDRINST usr/include/linux/nfs_idmap.h
  HDRINST usr/include/linux/sonet.h
  HDRINST usr/include/linux/kernelcapi.h
  HDRINST usr/include/linux/stddef.h
  HDRINST usr/include/linux/rose.h
  HDRINST usr/include/linux/virtio_rng.h
  HDRINST usr/include/linux/timex.h
  HDRINST usr/include/linux/virtio_config.h
  HDRINST usr/include/linux/sem.h
  HDRINST usr/include/linux/hdreg.h
  HDRINST usr/include/linux/smc.h
  HDRINST usr/include/linux/icmp.h
  HDRINST usr/include/linux/nsfs.h
  HDRINST usr/include/linux/l2tp.h
  HDRINST usr/include/linux/input-event-codes.h
  HDRINST usr/include/linux/mdio.h
  HDRINST usr/include/linux/virtio_console.h
  HDRINST usr/include/linux/netfilter_arp.h
  HDRINST usr/include/linux/if_tun.h
  HDRINST usr/include/linux/xilinx-v4l2-controls.h
  HDRINST usr/include/linux/apm_bios.h
  HDRINST usr/include/linux/if_fddi.h
  HDRINST usr/include/linux/nvram.h
  HDRINST usr/include/linux/kvm_para.h
  HDRINST usr/include/linux/fib_rules.h
  HDRINST usr/include/linux/blkzoned.h
  HDRINST usr/include/linux/btf.h
  HDRINST usr/include/linux/if_eql.h
  HDRINST usr/include/linux/if_ether.h
  HDRINST usr/include/linux/raid/md_u.h
  HDRINST usr/include/linux/raid/md_p.h
  HDRINST usr/include/linux/vm_sockets.h
  HDRINST usr/include/linux/dns_resolver.h
  HDRINST usr/include/linux/media.h
  HDRINST usr/include/linux/media-bus-format.h
  HDRINST usr/include/linux/memfd.h
  HDRINST usr/include/linux/if_pppol2tp.h
  HDRINST usr/include/linux/random.h
  HDRINST usr/include/linux/virtio_net.h
  HDRINST usr/include/linux/map_to_7segment.h
  HDRINST usr/include/linux/bpf_perf_event.h
  HDRINST usr/include/linux/caif/caif_socket.h
  HDRINST usr/include/linux/caif/if_caif.h
  HDRINST usr/include/linux/auto_dev-ioctl.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_among.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nflog.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_802_3.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_limit.h
  HDRINST usr/include/linux/netfilter_bridge/ebtables.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_redirect.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_pkttype.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_t.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arpreply.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_stp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_vlan.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip6.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nat.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_m.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_log.h
  HDRINST usr/include/linux/iommu.h
  HDRINST usr/include/linux/posix_acl_xattr.h
  HDRINST usr/include/linux/cciss_ioctl.h
  HDRINST usr/include/linux/screen_info.h
  HDRINST usr/include/linux/parport.h
  HDRINST usr/include/linux/mqueue.h
  HDRINST usr/include/linux/pidfd.h
  HDRINST usr/include/linux/dcbnl.h
  HDRINST usr/include/linux/pkt_cls.h
  HDRINST usr/include/linux/aspeed-lpc-ctrl.h
  HDRINST usr/include/linux/i2c-dev.h
  HDRINST usr/include/linux/i2o-dev.h
  HDRINST usr/include/linux/virtio_fs.h
  HDRINST usr/include/linux/vfio.h
  HDRINST usr/include/linux/rpl_iptunnel.h
  HDRINST usr/include/linux/dma-heap.h
  HDRINST usr/include/linux/ipv6.h
  HDRINST usr/include/linux/gen_stats.h
  HDRINST usr/include/linux/if_arp.h
  HDRINST usr/include/linux/hidraw.h
  HDRINST usr/include/linux/in_route.h
  HDRINST usr/include/linux/if_vlan.h
  HDRINST usr/include/linux/taskstats.h
  HDRINST usr/include/linux/virtio_ids.h
  HDRINST usr/include/linux/unix_diag.h
  HDRINST usr/include/linux/hsi/cs-protocol.h
  HDRINST usr/include/linux/hsi/hsi_char.h
  HDRINST usr/include/linux/nfc.h
  HDRINST usr/include/linux/erspan.h
  HDRINST usr/include/linux/lp.h
  HDRINST usr/include/linux/sound.h
  HDRINST usr/include/linux/reiserfs_fs.h
  HDRINST usr/include/linux/atm_zatm.h
  HDRINST usr/include/linux/netfilter_bridge.h
  HDRINST usr/include/linux/sync_file.h
  HDRINST usr/include/linux/cec.h
  HDRINST usr/include/linux/omap3isp.h
  HDRINST usr/include/linux/veth.h
  HDRINST usr/include/linux/qemu_fw_cfg.h
  HDRINST usr/include/linux/if_macsec.h
  HDRINST usr/include/linux/neighbour.h
  HDRINST usr/include/linux/mman.h
  HDRINST usr/include/linux/bpf_common.h
  HDRINST usr/include/linux/input.h
  HDRINST usr/include/linux/utime.h
  HDRINST usr/include/linux/hiddev.h
  HDRINST usr/include/linux/raw.h
  HDRINST usr/include/linux/if_infiniband.h
  HDRINST usr/include/linux/atmlec.h
  HDRINST usr/include/linux/ptp_clock.h
  HDRINST usr/include/linux/kvm.h
  HDRINST usr/include/linux/gpio.h
  HDRINST usr/include/linux/atalk.h
  HDRINST usr/include/linux/capi.h
  HDRINST usr/include/linux/ncsi.h
  HDRINST usr/include/linux/vmcore.h
  HDRINST usr/include/linux/if_phonet.h
  HDRINST usr/include/linux/seg6_local.h
  HDRINST usr/include/linux/vhost_types.h
  HDRINST usr/include/linux/spi/spidev.h
  HDRINST usr/include/linux/fuse.h
  HDRINST usr/include/linux/gsmmux.h
  HDRINST usr/include/linux/eventpoll.h
  HDRINST usr/include/linux/chio.h
  HDRINST usr/include/linux/phantom.h
  HDRINST usr/include/linux/nfs4_mount.h
  HDRINST usr/include/linux/byteorder/big_endian.h
  HDRINST usr/include/linux/byteorder/little_endian.h
  HDRINST usr/include/linux/selinux_netlink.h
  HDRINST usr/include/linux/atmapi.h
  HDRINST usr/include/linux/bsg.h
  HDRINST usr/include/linux/resource.h
  HDRINST usr/include/linux/ipc.h
  HDRINST usr/include/linux/netfilter/xt_CHECKSUM.h
  HDRINST usr/include/linux/netfilter/nf_nat.h
  HDRINST usr/include/linux/netfilter/xt_iprange.h
  HDRINST usr/include/linux/netfilter/xt_CONNSECMARK.h
  HDRINST usr/include/linux/netfilter/xt_mac.h
  HDRINST usr/include/linux/netfilter/xt_RATEEST.h
  HDRINST usr/include/linux/netfilter/xt_osf.h
  HDRINST usr/include/linux/netfilter/xt_NFLOG.h
  HDRINST usr/include/linux/netfilter/xt_ipvs.h
  HDRINST usr/include/linux/netfilter/nfnetlink_compat.h
  HDRINST usr/include/linux/netfilter/xt_u32.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cthelper.h
  HDRINST usr/include/linux/netfilter/xt_NFQUEUE.h
  HDRINST usr/include/linux/netfilter/xt_CLASSIFY.h
  HDRINST usr/include/linux/netfilter/nfnetlink_osf.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_bitmap.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_list.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_hash.h
  HDRINST usr/include/linux/netfilter/xt_dscp.h
  HDRINST usr/include/linux/netfilter/xt_IDLETIMER.h
  HDRINST usr/include/linux/netfilter/xt_physdev.h
  HDRINST usr/include/linux/netfilter/xt_time.h
  HDRINST usr/include/linux/netfilter/xt_MARK.h
  HDRINST usr/include/linux/netfilter/xt_conntrack.h
  HDRINST usr/include/linux/netfilter/nf_tables_compat.h
  HDRINST usr/include/linux/netfilter/nfnetlink_log.h
  HDRINST usr/include/linux/netfilter/nf_log.h
  HDRINST usr/include/linux/netfilter/xt_devgroup.h
  HDRINST usr/include/linux/netfilter/xt_DSCP.h
  HDRINST usr/include/linux/netfilter/xt_recent.h
  HDRINST usr/include/linux/netfilter/xt_TPROXY.h
  HDRINST usr/include/linux/netfilter/xt_cluster.h
  HDRINST usr/include/linux/netfilter/xt_realm.h
  HDRINST usr/include/linux/netfilter/xt_TCPMSS.h
  HDRINST usr/include/linux/netfilter/xt_pkttype.h
  HDRINST usr/include/linux/netfilter/xt_statistic.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cttimeout.h
  HDRINST usr/include/linux/netfilter/xt_addrtype.h
  HDRINST usr/include/linux/netfilter/xt_connbytes.h
  HDRINST usr/include/linux/netfilter/xt_rpfilter.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tuple_common.h
  HDRINST usr/include/linux/netfilter/xt_nfacct.h
  HDRINST usr/include/linux/netfilter/xt_LOG.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_sctp.h
  HDRINST usr/include/linux/netfilter/xt_tcpmss.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_ftp.h
  HDRINST usr/include/linux/netfilter/xt_l2tp.h
  HDRINST usr/include/linux/netfilter/xt_comment.h
  HDRINST usr/include/linux/netfilter/xt_state.h
  HDRINST usr/include/linux/netfilter/xt_policy.h
  HDRINST usr/include/linux/netfilter/xt_rateest.h
  HDRINST usr/include/linux/netfilter/xt_cgroup.h
  HDRINST usr/include/linux/netfilter/xt_hashlimit.h
  HDRINST usr/include/linux/netfilter/xt_CONNMARK.h
  HDRINST usr/include/linux/netfilter/xt_string.h
  HDRINST usr/include/linux/netfilter/xt_CT.h
  HDRINST usr/include/linux/netfilter/xt_length.h
  HDRINST usr/include/linux/netfilter/nfnetlink_queue.h
  HDRINST usr/include/linux/netfilter/xt_HMARK.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tcp.h
  HDRINST usr/include/linux/netfilter/xt_SYNPROXY.h
  HDRINST usr/include/linux/netfilter/nfnetlink_conntrack.h
  HDRINST usr/include/linux/netfilter/xt_multiport.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_common.h
  HDRINST usr/include/linux/netfilter/xt_sctp.h
  HDRINST usr/include/linux/netfilter/xt_cpu.h
  HDRINST usr/include/linux/netfilter/nfnetlink.h
  HDRINST usr/include/linux/netfilter/xt_limit.h
  HDRINST usr/include/linux/netfilter/xt_ipcomp.h
  HDRINST usr/include/linux/netfilter/xt_ecn.h
  HDRINST usr/include/linux/netfilter/xt_quota.h
  HDRINST usr/include/linux/netfilter/xt_connlimit.h
  HDRINST usr/include/linux/netfilter/xt_AUDIT.h
  HDRINST usr/include/linux/netfilter/nfnetlink_acct.h
  HDRINST usr/include/linux/netfilter/nf_synproxy.h
  HDRINST usr/include/linux/netfilter/xt_dccp.h
  HDRINST usr/include/linux/netfilter/xt_socket.h
  HDRINST usr/include/linux/netfilter/xt_LED.h
  HDRINST usr/include/linux/netfilter/xt_mark.h
  HDRINST usr/include/linux/netfilter/xt_SECMARK.h
  HDRINST usr/include/linux/netfilter/nf_tables.h
  HDRINST usr/include/linux/netfilter/xt_TEE.h
  HDRINST usr/include/linux/netfilter/xt_owner.h
  HDRINST usr/include/linux/netfilter/xt_bpf.h
  HDRINST usr/include/linux/netfilter/xt_esp.h
  HDRINST usr/include/linux/netfilter/xt_TCPOPTSTRIP.h
  HDRINST usr/include/linux/netfilter/xt_set.h
  HDRINST usr/include/linux/netfilter/xt_helper.h
  HDRINST usr/include/linux/netfilter/x_tables.h
  HDRINST usr/include/linux/netfilter/xt_connmark.h
  HDRINST usr/include/linux/netfilter/xt_connlabel.h
  HDRINST usr/include/linux/netfilter/xt_tcpudp.h
  HDRINST usr/include/linux/fs.h
  HDRINST usr/include/linux/cycx_cfm.h
  HDRINST usr/include/linux/baycom.h
  HDRINST usr/include/linux/param.h
  HDRINST usr/include/linux/keyboard.h
  HDRINST usr/include/linux/fou.h
  HDRINST usr/include/linux/if_bridge.h
  HDRINST usr/include/linux/dqblk_xfs.h
  HDRINST usr/include/linux/if_bonding.h
  HDRINST usr/include/linux/agpgart.h
  HDRINST usr/include/linux/udf_fs_i.h
  HDRINST usr/include/linux/swab.h
  HDRINST usr/include/linux/bfs_fs.h
  HDRINST usr/include/linux/v4l2-subdev.h
  HDRINST usr/include/linux/netdevice.h
  HDRINST usr/include/linux/virtio_balloon.h
  HDRINST usr/include/linux/if_hippi.h
  HDRINST usr/include/linux/atmmpc.h
  HDRINST usr/include/linux/major.h
  HDRINST usr/include/linux/mempolicy.h
  HDRINST usr/include/linux/openat2.h
  HDRINST usr/include/linux/ipmi.h
  HDRINST usr/include/linux/i8k.h
  HDRINST usr/include/linux/cn_proc.h
  HDRINST usr/include/linux/usbdevice_fs.h
  HDRINST usr/include/linux/batman_adv.h
  HDRINST usr/include/linux/virtio_vsock.h
  HDRINST usr/include/linux/dlm_plock.h
  HDRINST usr/include/linux/fsl_hypervisor.h
  HDRINST usr/include/linux/if_xdp.h
  HDRINST usr/include/linux/oom.h
  HDRINST usr/include/linux/genwqe/genwqe_card.h
  HDRINST usr/include/linux/netfilter_arp/arpt_mangle.h
  HDRINST usr/include/linux/netfilter_arp/arp_tables.h
  HDRINST usr/include/linux/bcache.h
  HDRINST usr/include/linux/seccomp.h
  HDRINST usr/include/linux/kcmp.h
  HDRINST usr/include/linux/coresight-stm.h
  HDRINST usr/include/linux/matroxfb.h
  HDRINST usr/include/linux/tipc_config.h
  HDRINST usr/include/linux/genetlink.h
  HDRINST usr/include/linux/thermal.h
  HDRINST usr/include/linux/seg6.h
  HDRINST usr/include/linux/minix_fs.h
  HDRINST usr/include/linux/adfs_fs.h
  HDRINST usr/include/linux/adb.h
  HDRINST usr/include/linux/kcm.h
  HDRINST usr/include/linux/posix_types.h
  HDRINST usr/include/linux/um_timetravel.h
  HDRINST usr/include/linux/elf-em.h
  HDRINST usr/include/linux/shm.h
  HDRINST usr/include/linux/rxrpc.h
  HDRINST usr/include/linux/atm.h
  HDRINST usr/include/linux/uio.h
  HDRINST usr/include/linux/atmsap.h
  HDRINST usr/include/linux/posix_acl.h
  HDRINST usr/include/linux/reboot.h
  HDRINST usr/include/linux/aio_abi.h
  HDRINST usr/include/linux/pci.h
  HDRINST usr/include/linux/utsname.h
  HDRINST usr/include/linux/smc_diag.h
  HDRINST usr/include/linux/types.h
  HDRINST usr/include/linux/openvswitch.h
  HDRINST usr/include/linux/udmabuf.h
  HDRINST usr/include/linux/irqnr.h
  HDRINST usr/include/linux/wireless.h
  HDRINST usr/include/linux/atmdev.h
  HDRINST usr/include/linux/pps.h
  HDRINST usr/include/linux/ipmi_msgdefs.h
  HDRINST usr/include/linux/module.h
  HDRINST usr/include/linux/v4l2-dv-timings.h
  HDRINST usr/include/linux/rkisp1-config.h
  HDRINST usr/include/linux/dm-log-userspace.h
  HDRINST usr/include/linux/if_addr.h
  HDRINST usr/include/linux/mii.h
  HDRINST usr/include/linux/ife.h
  HDRINST usr/include/linux/iso_fs.h
  HDRINST usr/include/linux/sonypi.h
  HDRINST usr/include/linux/ppp-comp.h
  HDRINST usr/include/linux/wait.h
  HDRINST usr/include/linux/if_ltalk.h
  HDRINST usr/include/linux/auxvec.h
  HDRINST usr/include/linux/cramfs_fs.h
  HDRINST usr/include/linux/signal.h
  HDRINST usr/include/linux/dlm.h
  HDRINST usr/include/linux/errqueue.h
  HDRINST usr/include/linux/x25.h
  HDRINST usr/include/linux/quota.h
  HDRINST usr/include/linux/uhid.h
  HDRINST usr/include/linux/tee.h
  HDRINST usr/include/linux/vbox_err.h
  HDRINST usr/include/linux/atm_nicstar.h
  HDRINST usr/include/linux/rtc.h
  HDRINST usr/include/linux/qnxtypes.h
  HDRINST usr/include/linux/watch_queue.h
  HDRINST usr/include/linux/if_pppox.h
  HDRINST usr/include/linux/tipc_netlink.h
  HDRINST usr/include/linux/ila.h
  HDRINST usr/include/linux/psci.h
  HDRINST usr/include/linux/virtio_pci.h
  HDRINST usr/include/linux/fdreg.h
  HDRINST usr/include/linux/sched/types.h
  HDRINST usr/include/linux/max2175.h
  HDRINST usr/include/linux/bpf.h
  HDRINST usr/include/linux/kexec.h
  HDRINST usr/include/linux/icmpv6.h
  HDRINST usr/include/linux/packet_diag.h
  HDRINST usr/include/linux/pfkeyv2.h
  HDRINST usr/include/linux/snmp.h
  HDRINST usr/include/linux/unistd.h
  HDRINST usr/include/linux/vfio_zdev.h
  HDRINST usr/include/linux/vbox_vmmdev_types.h
  HDRINST usr/include/linux/netconf.h
  HDRINST usr/include/linux/bpqether.h
  HDRINST usr/include/linux/switchtec_ioctl.h
  HDRINST usr/include/linux/scc.h
  HDRINST usr/include/linux/userio.h
  HDRINST usr/include/linux/wmi.h
  HDRINST usr/include/linux/net_dropmon.h
  HDRINST usr/include/linux/coff.h
  HDRINST usr/include/linux/atm_tcp.h
  HDRINST usr/include/linux/cifs/cifs_netlink.h
  HDRINST usr/include/linux/cifs/cifs_mount.h
  HDRINST usr/include/linux/atmclip.h
  HDRINST usr/include/linux/xfrm.h
  HDRINST usr/include/linux/can/error.h
  HDRINST usr/include/linux/can/netlink.h
  HDRINST usr/include/linux/can/vxcan.h
  HDRINST usr/include/linux/can/isotp.h
  HDRINST usr/include/linux/can/gw.h
  HDRINST usr/include/linux/can/raw.h
  HDRINST usr/include/linux/can/j1939.h
  HDRINST usr/include/linux/can/bcm.h
  HDRINST usr/include/linux/mount.h
  HDRINST usr/include/linux/ppp-ioctl.h
  HDRINST usr/include/linux/virtio_9p.h
  HDRINST usr/include/linux/psp-sev.h
  HDRINST usr/include/linux/psample.h
  HDRINST usr/include/linux/nfs.h
  HDRINST usr/include/linux/jffs2.h
  HDRINST usr/include/linux/usbip.h
  HDRINST usr/include/linux/msdos_fs.h
  HDRINST usr/include/linux/if_team.h
  HDRINST usr/include/linux/virtio_blk.h
  HDRINST usr/include/linux/if_tunnel.h
  HDRINST usr/include/linux/netrom.h
  HDRINST usr/include/linux/rfkill.h
  HDRINST usr/include/linux/nfsd/stats.h
  HDRINST usr/include/linux/nfsd/nfsfh.h
  HDRINST usr/include/linux/nfsd/cld.h
  HDRINST usr/include/linux/nfsd/debug.h
  HDRINST usr/include/linux/nfsd/export.h
  HDRINST usr/include/linux/romfs_fs.h
  HDRINST usr/include/linux/falloc.h
  HDRINST usr/include/linux/sunrpc/debug.h
  HDRINST usr/include/linux/elf-fdpic.h
  HDRINST usr/include/linux/virtio_pmem.h
  HDRINST usr/include/linux/rtnetlink.h
  HDRINST usr/include/linux/nfs2.h
  HDRINST usr/include/linux/virtio_iommu.h
  HDRINST usr/include/linux/serial.h
  HDRINST usr/include/linux/tcp.h
  HDRINST usr/include/linux/fscrypt.h
  HDRINST usr/include/linux/un.h
  HDRINST usr/include/linux/ppdev.h
  HDRINST usr/include/linux/limits.h
  HDRINST usr/include/linux/nilfs2_api.h
  HDRINST usr/include/linux/rpmsg_types.h
  HDRINST usr/include/linux/gameport.h
  HDRINST usr/include/linux/hdlcdrv.h
  HDRINST usr/include/linux/ppp_defs.h
  HDRINST usr/include/linux/seg6_hmac.h
  HDRINST usr/include/linux/btrfs_tree.h
  HDRINST usr/include/linux/rds.h
  HDRINST usr/include/linux/lightnvm.h
  HDRINST usr/include/linux/virtio_crypto.h
  HDRINST usr/include/linux/dma-buf.h
  HDRINST usr/include/linux/udp.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_LOG.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ttl.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_CLUSTERIP.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ecn.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ECN.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ah.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_TTL.h
  HDRINST usr/include/linux/netfilter_ipv4/ip_tables.h
  HDRINST usr/include/linux/cryptouser.h
  HDRINST usr/include/linux/xattr.h
  HDRINST usr/include/linux/target_core_user.h
  HDRINST usr/include/linux/ipmi_bmc.h
  HDRINST usr/include/linux/atm_he.h
  HDRINST usr/include/linux/tc_ematch/tc_em_nbyte.h
  HDRINST usr/include/linux/tc_ematch/tc_em_meta.h
  HDRINST usr/include/linux/tc_ematch/tc_em_text.h
  HDRINST usr/include/linux/tc_ematch/tc_em_ipt.h
  HDRINST usr/include/linux/tc_ematch/tc_em_cmp.h
  HDRINST usr/include/linux/cuda.h
  HDRINST usr/include/linux/hash_info.h
  HDRINST usr/include/linux/dlmconstants.h
  HDRINST usr/include/linux/ethtool_netlink.h
  HDRINST usr/include/linux/pg.h
  HDRINST usr/include/linux/personality.h
  HDRINST usr/include/linux/fsmap.h
  HDRINST usr/include/linux/netlink_diag.h
  HDRINST usr/include/linux/atmioc.h
  HDRINST usr/include/linux/stat.h
  HDRINST usr/include/linux/sysinfo.h
  HDRINST usr/include/linux/smiapp.h
  HDRINST usr/include/linux/cdrom.h
  HDRINST usr/include/linux/cec-funcs.h
  HDRINST usr/include/linux/if_packet.h
  HDRINST usr/include/linux/vtpm_proxy.h
  HDRINST usr/include/linux/net_tstamp.h
  HDRINST usr/include/linux/coda.h
  HDRINST usr/include/linux/mtio.h
  HDRINST usr/include/linux/dccp.h
  HDRINST usr/include/linux/usb/raw_gadget.h
  HDRINST usr/include/linux/usb/g_printer.h
  HDRINST usr/include/linux/usb/video.h
  HDRINST usr/include/linux/usb/ch9.h
  HDRINST usr/include/linux/usb/charger.h
  HDRINST usr/include/linux/usb/g_uvc.h
  HDRINST usr/include/linux/usb/gadgetfs.h
  HDRINST usr/include/linux/usb/functionfs.h
  HDRINST usr/include/linux/usb/audio.h
  HDRINST usr/include/linux/usb/ch11.h
  HDRINST usr/include/linux/usb/midi.h
  HDRINST usr/include/linux/usb/tmc.h
  HDRINST usr/include/linux/usb/cdc-wdm.h
  HDRINST usr/include/linux/usb/cdc.h
  HDRINST usr/include/linux/time_types.h
  HDRINST usr/include/linux/hyperv.h
  HDRINST usr/include/linux/idxd.h
  HDRINST usr/include/linux/atmbr2684.h
  HDRINST usr/include/linux/hdlc/ioctl.h
  HDRINST usr/include/linux/sched.h
  HDRINST usr/include/linux/msg.h
  HDRINST usr/include/linux/mmc/ioctl.h
  HDRINST usr/include/linux/suspend_ioctls.h
  HDRINST usr/include/linux/if_ppp.h
  HDRINST usr/include/linux/fsverity.h
  HDRINST usr/include/linux/zorro.h
  HDRINST usr/include/linux/igmp.h
  HDRINST usr/include/linux/inet_diag.h
  HDRINST usr/include/linux/pkt_sched.h
  HDRINST usr/include/linux/fiemap.h
  HDRINST usr/include/linux/f2fs.h
  HDRINST usr/include/sound/compress_params.h
  HDRINST usr/include/sound/hdsp.h
  HDRINST usr/include/sound/compress_offload.h
  HDRINST usr/include/sound/firewire.h
  HDRINST usr/include/sound/asound_fm.h
  HDRINST usr/include/sound/asound.h
  HDRINST usr/include/sound/sfnt_info.h
  HDRINST usr/include/sound/snd_sst_tokens.h
  HDRINST usr/include/sound/sb16_csp.h
  HDRINST usr/include/sound/asoc.h
  HDRINST usr/include/sound/hdspm.h
  HDRINST usr/include/sound/sof/header.h
  HDRINST usr/include/sound/sof/tokens.h
  HDRINST usr/include/sound/sof/fw.h
  HDRINST usr/include/sound/sof/abi.h
  HDRINST usr/include/sound/asequencer.h
  HDRINST usr/include/sound/usb_stream.h
  HDRINST usr/include/sound/skl-tplg-interface.h
  HDRINST usr/include/sound/tlv.h
  HDRINST usr/include/sound/emu10k1.h
  HDRINST usr/include/scsi/cxlflash_ioctl.h
  HDRINST usr/include/scsi/scsi_bsg_ufs.h
  HDRINST usr/include/scsi/scsi_netlink_fc.h
  HDRINST usr/include/scsi/scsi_netlink.h
  HDRINST usr/include/scsi/scsi_bsg_fc.h
  HDRINST usr/include/scsi/fc/fc_gs.h
  HDRINST usr/include/scsi/fc/fc_ns.h
  HDRINST usr/include/scsi/fc/fc_els.h
  HDRINST usr/include/scsi/fc/fc_fs.h
  HDRINST usr/include/linux/version.h
  HDRINST usr/include/asm/sgx.h
  HDRINST usr/include/asm/statfs.h
  HDRINST usr/include/asm/byteorder.h
  HDRINST usr/include/asm/ptrace-abi.h
  HDRINST usr/include/asm/vsyscall.h
  HDRINST usr/include/asm/posix_types_64.h
  HDRINST usr/include/asm/sembuf.h
  HDRINST usr/include/asm/a.out.h
  HDRINST usr/include/asm/ucontext.h
  HDRINST usr/include/asm/hw_breakpoint.h
  HDRINST usr/include/asm/msr.h
  HDRINST usr/include/asm/prctl.h
  HDRINST usr/include/asm/ptrace.h
  HDRINST usr/include/asm/vm86.h
  HDRINST usr/include/asm/processor-flags.h
  HDRINST usr/include/asm/e820.h
  HDRINST usr/include/asm/hwcap2.h
  HDRINST usr/include/asm/msgbuf.h
  HDRINST usr/include/asm/mce.h
  HDRINST usr/include/asm/kvm_perf.h
  HDRINST usr/include/asm/posix_types_x32.h
  HDRINST usr/include/asm/kvm_para.h
  HDRINST usr/include/asm/sigcontext.h
  HDRINST usr/include/asm/bitsperlong.h
  HDRINST usr/include/asm/mman.h
  HDRINST usr/include/asm/boot.h
  HDRINST usr/include/asm/siginfo.h
  HDRINST usr/include/asm/kvm.h
  HDRINST usr/include/asm/setup.h
  HDRINST usr/include/asm/swab.h
  HDRINST usr/include/asm/posix_types_32.h
  HDRINST usr/include/asm/ist.h
  HDRINST usr/include/asm/posix_types.h
  HDRINST usr/include/asm/debugreg.h
  HDRINST usr/include/asm/bootparam.h
  HDRINST usr/include/asm/auxvec.h
  HDRINST usr/include/asm/signal.h
  HDRINST usr/include/asm/vmx.h
  HDRINST usr/include/asm/unistd.h
  HDRINST usr/include/asm/mtrr.h
  HDRINST usr/include/asm/ldt.h
  HDRINST usr/include/asm/sigcontext32.h
  HDRINST usr/include/asm/shmbuf.h
  HDRINST usr/include/asm/svm.h
  HDRINST usr/include/asm/perf_regs.h
  HDRINST usr/include/asm/stat.h
  HDRINST usr/include/asm/unistd_x32.h
  HDRINST usr/include/asm/unistd_64.h
  HDRINST usr/include/asm/unistd_32.h
  HDRINST usr/include/asm/types.h
  HDRINST usr/include/asm/termios.h
  HDRINST usr/include/asm/termbits.h
  HDRINST usr/include/asm/sockios.h
  HDRINST usr/include/asm/socket.h
  HDRINST usr/include/asm/resource.h
  HDRINST usr/include/asm/poll.h
  HDRINST usr/include/asm/param.h
  HDRINST usr/include/asm/ipcbuf.h
  HDRINST usr/include/asm/ioctls.h
  HDRINST usr/include/asm/ioctl.h
  HDRINST usr/include/asm/fcntl.h
  HDRINST usr/include/asm/errno.h
  HDRINST usr/include/asm/bpf_perf_event.h
  INSTALL ./usr/include
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/safes=
etid'
gcc -Wall -O2    safesetid-test.c -lcap -o /usr/src/perf_selftests-x86_64-r=
hel-7.6-kselftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/s=
elftests/safesetid/safesetid-test
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/safese=
tid'
2021-02-07 21:52:11 make run_tests -C safesetid
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/safeseti=
d'
TAP version 13
1..1
# selftests: safesetid: safesetid-test.sh
# mounting securityfs failed
# safesetid-test.sh: done
ok 1 selftests: safesetid: safesetid-test.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/safesetid'
2021-02-07 21:52:12 make run_tests -C seccomp
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/seccomp'
gcc -Wl,-no-as-needed -Wall  -lpthread  seccomp_bpf.c  -o /usr/src/perf_sel=
ftests-x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/=
tools/testing/selftests/seccomp/seccomp_bpf
gcc -Wl,-no-as-needed -Wall  -lpthread  seccomp_benchmark.c  -o /usr/src/pe=
rf_selftests-x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b6=
49bc5/tools/testing/selftests/seccomp/seccomp_benchmark
TAP version 13
1..2
# selftests: seccomp: seccomp_bpf
# TAP version 13
# 1..87
# # Starting 87 tests from 7 test cases.
# #  RUN           global.kcmp ...
# #            OK  global.kcmp
# ok 1 global.kcmp
# #  RUN           global.mode_strict_support ...
# #            OK  global.mode_strict_support
# ok 2 global.mode_strict_support
# #  RUN           global.mode_strict_cannot_call_prctl ...
# #            OK  global.mode_strict_cannot_call_prctl
# ok 3 global.mode_strict_cannot_call_prctl
# #  RUN           global.no_new_privs_support ...
# #            OK  global.no_new_privs_support
# ok 4 global.no_new_privs_support
# #  RUN           global.mode_filter_support ...
# #            OK  global.mode_filter_support
# ok 5 global.mode_filter_support
# #  RUN           global.mode_filter_without_nnp ...
# #            OK  global.mode_filter_without_nnp
# ok 6 global.mode_filter_without_nnp
# #  RUN           global.filter_size_limits ...
# #            OK  global.filter_size_limits
# ok 7 global.filter_size_limits
# #  RUN           global.filter_chain_limits ...
# #            OK  global.filter_chain_limits
# ok 8 global.filter_chain_limits
# #  RUN           global.mode_filter_cannot_move_to_strict ...
# #            OK  global.mode_filter_cannot_move_to_strict
# ok 9 global.mode_filter_cannot_move_to_strict
# #  RUN           global.mode_filter_get_seccomp ...
# #            OK  global.mode_filter_get_seccomp
# ok 10 global.mode_filter_get_seccomp
# #  RUN           global.ALLOW_all ...
# #            OK  global.ALLOW_all
# ok 11 global.ALLOW_all
# #  RUN           global.empty_prog ...
# #            OK  global.empty_prog
# ok 12 global.empty_prog
# #  RUN           global.log_all ...
# #            OK  global.log_all
# ok 13 global.log_all
# #  RUN           global.unknown_ret_is_kill_inside ...
# #            OK  global.unknown_ret_is_kill_inside
# ok 14 global.unknown_ret_is_kill_inside
# #  RUN           global.unknown_ret_is_kill_above_allow ...
# #            OK  global.unknown_ret_is_kill_above_allow
# ok 15 global.unknown_ret_is_kill_above_allow
# #  RUN           global.KILL_all ...
# #            OK  global.KILL_all
# ok 16 global.KILL_all
# #  RUN           global.KILL_one ...
# #            OK  global.KILL_one
# ok 17 global.KILL_one
# #  RUN           global.KILL_one_arg_one ...
# #            OK  global.KILL_one_arg_one
# ok 18 global.KILL_one_arg_one
# #  RUN           global.KILL_one_arg_six ...
# #            OK  global.KILL_one_arg_six
# ok 19 global.KILL_one_arg_six
# #  RUN           global.KILL_thread ...
# #            OK  global.KILL_thread
# ok 20 global.KILL_thread
# #  RUN           global.KILL_process ...
# #            OK  global.KILL_process
# ok 21 global.KILL_process
# #  RUN           global.KILL_unknown ...
# #            OK  global.KILL_unknown
# ok 22 global.KILL_unknown
# #  RUN           global.arg_out_of_range ...
# #            OK  global.arg_out_of_range
# ok 23 global.arg_out_of_range
# #  RUN           global.ERRNO_valid ...
# #            OK  global.ERRNO_valid
# ok 24 global.ERRNO_valid
# #  RUN           global.ERRNO_zero ...
# #            OK  global.ERRNO_zero
# ok 25 global.ERRNO_zero
# #  RUN           global.ERRNO_capped ...
# #            OK  global.ERRNO_capped
# ok 26 global.ERRNO_capped
# #  RUN           global.ERRNO_order ...
# #            OK  global.ERRNO_order
# ok 27 global.ERRNO_order
# #  RUN           global.negative_ENOSYS ...
# #            OK  global.negative_ENOSYS
# ok 28 global.negative_ENOSYS
# #  RUN           global.seccomp_syscall ...
# #            OK  global.seccomp_syscall
# ok 29 global.seccomp_syscall
# #  RUN           global.seccomp_syscall_mode_lock ...
# #            OK  global.seccomp_syscall_mode_lock
# ok 30 global.seccomp_syscall_mode_lock
# #  RUN           global.detect_seccomp_filter_flags ...
# #            OK  global.detect_seccomp_filter_flags
# ok 31 global.detect_seccomp_filter_flags
# #  RUN           global.TSYNC_first ...
# #            OK  global.TSYNC_first
# ok 32 global.TSYNC_first
# #  RUN           global.syscall_restart ...
# #            OK  global.syscall_restart
# ok 33 global.syscall_restart
# #  RUN           global.filter_flag_log ...
# #            OK  global.filter_flag_log
# ok 34 global.filter_flag_log
# #  RUN           global.get_action_avail ...
# #            OK  global.get_action_avail
# ok 35 global.get_action_avail
# #  RUN           global.get_metadata ...
# #            OK  global.get_metadata
# ok 36 global.get_metadata
# #  RUN           global.user_notification_basic ...
# #            OK  global.user_notification_basic
# ok 37 global.user_notification_basic
# #  RUN           global.user_notification_with_tsync ...
# #            OK  global.user_notification_with_tsync
# ok 38 global.user_notification_with_tsync
# #  RUN           global.user_notification_kill_in_middle ...
# #            OK  global.user_notification_kill_in_middle
# ok 39 global.user_notification_kill_in_middle
# #  RUN           global.user_notification_signal ...
# #            OK  global.user_notification_signal
# ok 40 global.user_notification_signal
# #  RUN           global.user_notification_closed_listener ...
# #            OK  global.user_notification_closed_listener
# ok 41 global.user_notification_closed_listener
# #  RUN           global.user_notification_child_pid_ns ...
# #            OK  global.user_notification_child_pid_ns
# ok 42 global.user_notification_child_pid_ns
# #  RUN           global.user_notification_sibling_pid_ns ...
# #            OK  global.user_notification_sibling_pid_ns
# ok 43 global.user_notification_sibling_pid_ns
# #  RUN           global.user_notification_fault_recv ...
# #            OK  global.user_notification_fault_recv
# ok 44 global.user_notification_fault_recv
# #  RUN           global.seccomp_get_notif_sizes ...
# #            OK  global.seccomp_get_notif_sizes
# ok 45 global.seccomp_get_notif_sizes
# #  RUN           global.user_notification_continue ...
# #            OK  global.user_notification_continue
# ok 46 global.user_notification_continue
# #  RUN           global.user_notification_filter_empty ...
# #            OK  global.user_notification_filter_empty
# ok 47 global.user_notification_filter_empty
# #  RUN           global.user_notification_filter_empty_threaded ...
# #            OK  global.user_notification_filter_empty_threaded
# ok 48 global.user_notification_filter_empty_threaded
# #  RUN           global.user_notification_addfd ...
# # seccomp_bpf.c:4026:user_notification_addfd:Expected fd (7) =3D=3D 5 (5)
# # seccomp_bpf.c:4033:user_notification_addfd:Expected fd (8) =3D=3D 6 (6)
# # user_notification_addfd: Test failed at step #5
# #          FAIL  global.user_notification_addfd
# not ok 49 global.user_notification_addfd
# #  RUN           global.user_notification_addfd_rlimit ...
# #            OK  global.user_notification_addfd_rlimit
# ok 50 global.user_notification_addfd_rlimit
# #  RUN           TRAP.dfl ...
# #            OK  TRAP.dfl
# ok 51 TRAP.dfl
# #  RUN           TRAP.ign ...
# #            OK  TRAP.ign
# ok 52 TRAP.ign
# #  RUN           TRAP.handler ...
# #            OK  TRAP.handler
# ok 53 TRAP.handler
# #  RUN           precedence.allow_ok ...
# #            OK  precedence.allow_ok
# ok 54 precedence.allow_ok
# #  RUN           precedence.kill_is_highest ...
# #            OK  precedence.kill_is_highest
# ok 55 precedence.kill_is_highest
# #  RUN           precedence.kill_is_highest_in_any_order ...
# #            OK  precedence.kill_is_highest_in_any_order
# ok 56 precedence.kill_is_highest_in_any_order
# #  RUN           precedence.trap_is_second ...
# #            OK  precedence.trap_is_second
# ok 57 precedence.trap_is_second
# #  RUN           precedence.trap_is_second_in_any_order ...
# #            OK  precedence.trap_is_second_in_any_order
# ok 58 precedence.trap_is_second_in_any_order
# #  RUN           precedence.errno_is_third ...
# #            OK  precedence.errno_is_third
# ok 59 precedence.errno_is_third
# #  RUN           precedence.errno_is_third_in_any_order ...
# #            OK  precedence.errno_is_third_in_any_order
# ok 60 precedence.errno_is_third_in_any_order
# #  RUN           precedence.trace_is_fourth ...
# #            OK  precedence.trace_is_fourth
# ok 61 precedence.trace_is_fourth
# #  RUN           precedence.trace_is_fourth_in_any_order ...
# #            OK  precedence.trace_is_fourth_in_any_order
# ok 62 precedence.trace_is_fourth_in_any_order
# #  RUN           precedence.log_is_fifth ...
# #            OK  precedence.log_is_fifth
# ok 63 precedence.log_is_fifth
# #  RUN           precedence.log_is_fifth_in_any_order ...
# #            OK  precedence.log_is_fifth_in_any_order
# ok 64 precedence.log_is_fifth_in_any_order
# #  RUN           TRACE_poke.read_has_side_effects ...
# #            OK  TRACE_poke.read_has_side_effects
# ok 65 TRACE_poke.read_has_side_effects
# #  RUN           TRACE_poke.getpid_runs_normally ...
# #            OK  TRACE_poke.getpid_runs_normally
# ok 66 TRACE_poke.getpid_runs_normally
# #  RUN           TRACE_syscall.ptrace.negative_ENOSYS ...
# #            OK  TRACE_syscall.ptrace.negative_ENOSYS
# ok 67 TRACE_syscall.ptrace.negative_ENOSYS
# #  RUN           TRACE_syscall.ptrace.syscall_allowed ...
# #            OK  TRACE_syscall.ptrace.syscall_allowed
# ok 68 TRACE_syscall.ptrace.syscall_allowed
# #  RUN           TRACE_syscall.ptrace.syscall_redirected ...
# #            OK  TRACE_syscall.ptrace.syscall_redirected
# ok 69 TRACE_syscall.ptrace.syscall_redirected
# #  RUN           TRACE_syscall.ptrace.syscall_errno ...
# #            OK  TRACE_syscall.ptrace.syscall_errno
# ok 70 TRACE_syscall.ptrace.syscall_errno
# #  RUN           TRACE_syscall.ptrace.syscall_faked ...
# #            OK  TRACE_syscall.ptrace.syscall_faked
# ok 71 TRACE_syscall.ptrace.syscall_faked
# #  RUN           TRACE_syscall.ptrace.skip_after ...
# #            OK  TRACE_syscall.ptrace.skip_after
# ok 72 TRACE_syscall.ptrace.skip_after
# #  RUN           TRACE_syscall.ptrace.kill_after ...
# #            OK  TRACE_syscall.ptrace.kill_after
# ok 73 TRACE_syscall.ptrace.kill_after
# #  RUN           TRACE_syscall.seccomp.negative_ENOSYS ...
# #            OK  TRACE_syscall.seccomp.negative_ENOSYS
# ok 74 TRACE_syscall.seccomp.negative_ENOSYS
# #  RUN           TRACE_syscall.seccomp.syscall_allowed ...
# #            OK  TRACE_syscall.seccomp.syscall_allowed
# ok 75 TRACE_syscall.seccomp.syscall_allowed
# #  RUN           TRACE_syscall.seccomp.syscall_redirected ...
# #            OK  TRACE_syscall.seccomp.syscall_redirected
# ok 76 TRACE_syscall.seccomp.syscall_redirected
# #  RUN           TRACE_syscall.seccomp.syscall_errno ...
# #            OK  TRACE_syscall.seccomp.syscall_errno
# ok 77 TRACE_syscall.seccomp.syscall_errno
# #  RUN           TRACE_syscall.seccomp.syscall_faked ...
# #            OK  TRACE_syscall.seccomp.syscall_faked
# ok 78 TRACE_syscall.seccomp.syscall_faked
# #  RUN           TRACE_syscall.seccomp.skip_after ...
# #            OK  TRACE_syscall.seccomp.skip_after
# ok 79 TRACE_syscall.seccomp.skip_after
# #  RUN           TRACE_syscall.seccomp.kill_after ...
# #            OK  TRACE_syscall.seccomp.kill_after
# ok 80 TRACE_syscall.seccomp.kill_after
# #  RUN           TSYNC.siblings_fail_prctl ...
# #            OK  TSYNC.siblings_fail_prctl
# ok 81 TSYNC.siblings_fail_prctl
# #  RUN           TSYNC.two_siblings_with_ancestor ...
# #            OK  TSYNC.two_siblings_with_ancestor
# ok 82 TSYNC.two_siblings_with_ancestor
# #  RUN           TSYNC.two_sibling_want_nnp ...
# #            OK  TSYNC.two_sibling_want_nnp
# ok 83 TSYNC.two_sibling_want_nnp
# #  RUN           TSYNC.two_siblings_with_no_filter ...
# #            OK  TSYNC.two_siblings_with_no_filter
# ok 84 TSYNC.two_siblings_with_no_filter
# #  RUN           TSYNC.two_siblings_with_one_divergence ...
# #            OK  TSYNC.two_siblings_with_one_divergence
# ok 85 TSYNC.two_siblings_with_one_divergence
# #  RUN           TSYNC.two_siblings_with_one_divergence_no_tid_in_err ...
# #            OK  TSYNC.two_siblings_with_one_divergence_no_tid_in_err
# ok 86 TSYNC.two_siblings_with_one_divergence_no_tid_in_err
# #  RUN           TSYNC.two_siblings_not_under_filter ...
# #            OK  TSYNC.two_siblings_not_under_filter
# ok 87 TSYNC.two_siblings_not_under_filter
# # FAILED: 86 / 87 tests passed.
# # Totals: pass:86 fail:1 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: seccomp: seccomp_bpf # exit=3D1
# selftests: seccomp: seccomp_benchmark
# net.core.bpf_jit_enable =3D 1
# net.core.bpf_jit_harden =3D 0
# Current BPF sysctl settings:
# Calibrating sample size for 15 seconds worth of syscalls ...
# Benchmarking 17053830 syscalls...
# 15.799478905 - 1.008576112 =3D 14790902793 (14.8s)
# getpid native: 867 ns
# 30.183459206 - 15.799744429 =3D 14383714777 (14.4s)
# getpid RET_ALLOW 1 filter (bitmap): 843 ns
# 43.333904192 - 30.183666199 =3D 13150237993 (13.2s)
# getpid RET_ALLOW 2 filters (bitmap): 771 ns
# 59.358945735 - 43.334091113 =3D 16024854622 (16.0s)
# getpid RET_ALLOW 3 filters (full): 939 ns
# 76.381648249 - 59.359141258 =3D 17022506991 (17.0s)
# getpid RET_ALLOW 4 filters (full): 998 ns
# Estimated total seccomp overhead for 1 bitmapped filter: 1844674407370955=
1592 ns
# Saw unexpected benchmark result. Try running again with more samples?
ok 2 selftests: seccomp: seccomp_benchmark
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/seccomp'
2021-02-07 21:53:31 make run_tests -C sgx
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sgx'
gcc -Wall -Werror -g -I../../../../tools/include -fPIC -z noexecstack -c ma=
in.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18=
a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sgx/main.o
gcc -Wall -Werror -g -I../../../../tools/include -fPIC -z noexecstack -c lo=
ad.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18=
a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sgx/load.o
gcc -Wall -Werror -g -I../../../../tools/include -fPIC -z noexecstack -c si=
gstruct.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-dc8df6e85d2=
c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sgx/sigstruct.o
gcc -Wall -Werror -g -I../../../../tools/include -fPIC -z noexecstack -c ca=
ll.S -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18=
a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sgx/call.o
gcc -Wall -Werror -g -I../../../../tools/include -fPIC -z noexecstack -c si=
gn_key.S -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-dc8df6e85d2c=
8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sgx/sign_key.o
gcc -Wall -Werror -g -I../../../../tools/include -fPIC -z noexecstack -o /u=
sr/src/perf_selftests-x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18a0992ae3cc=
8ad3d65b649bc5/tools/testing/selftests/sgx/test_sgx /usr/src/perf_selftests=
-x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/=
testing/selftests/sgx/main.o /usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sgx/l=
oad.o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18a0=
992ae3cc8ad3d65b649bc5/tools/testing/selftests/sgx/sigstruct.o /usr/src/per=
f_selftests-x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b64=
9bc5/tools/testing/selftests/sgx/call.o /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/self=
tests/sgx/sign_key.o -lcrypto
gcc -Wall -Werror -static -nostdlib -nostartfiles -fPIC -fno-stack-protecto=
r -mrdrnd -I../../../../tools/include -T test_encl.lds test_encl.c test_enc=
l_bootstrap.S -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-dc8df6e=
85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sgx/test_encl.elf
/usr/bin/ld: warning: .note.gnu.build-id section discarded, --build-id igno=
red
TAP version 13
1..1
# selftests: sgx: test_sgx
# Unable to open /dev/sgx_enclave
# 1..0 # SKIP cannot load enclaves
ok 1 selftests: sgx: test_sgx # SKIP
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sgx'
2021-02-07 21:53:32 make run_tests -C sigaltstack
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sigaltst=
ack'
gcc -Wall    sas.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-d=
c8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sigaltstack=
/sas
TAP version 13
1..1
# selftests: sigaltstack: sas
# Segmentation fault
not ok 1 selftests: sigaltstack: sas # exit=3D139
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sigaltsta=
ck'
2021-02-07 21:53:32 make run_tests -C size
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/size'
gcc -static -ffreestanding -nostartfiles -s    get_size.c  -o /usr/src/perf=
_selftests-x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649=
bc5/tools/testing/selftests/size/get_size
TAP version 13
1..1
# selftests: size: get_size
# TAP version 13
# # Testing system size.
# ok 1 get runtime memory use
# # System runtime memory report (units in Kilobytes):
#  ---
#  Total:  32741768
#  Free:   28444780
#  Buffer: 12
#  In use: 4296976
#  ...
# 1..1
ok 1 selftests: size: get_size
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/size'
2021-02-07 21:53:32 make run_tests -C sparc64
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sparc64'
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sparc64'
2021-02-07 21:53:32 make run_tests -C splice
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/splice'
gcc     default_file_splice_read.c  -o /usr/src/perf_selftests-x86_64-rhel-=
7.6-kselftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selft=
ests/splice/default_file_splice_read
gcc     splice_read.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/splice/s=
plice_read
TAP version 13
1..2
# selftests: splice: default_file_splice_read.sh
ok 1 selftests: splice: default_file_splice_read.sh
# selftests: splice: short_splice_read.sh
# splice: Invalid argument
# FAIL: /proc/10442/limits 4096
# splice: Invalid argument
# FAIL: /proc/10442/limits 2
# splice: Invalid argument
# FAIL: /proc/10442/comm 4096
# splice: Invalid argument
# FAIL: /proc/10442/comm 2
# ok: /proc/sys/fs/nr_open 4096
# ok: /proc/sys/fs/nr_open 2
# ok: /proc/sys/kernel/modprobe 4096
# ok: /proc/sys/kernel/modprobe 2
# ok: /proc/sys/kernel/version 4096
# ok: /proc/sys/kernel/version 2
# ok: /sys/module/test_module/coresize 4096
# ok: /sys/module/test_module/coresize 2
# ok: /sys/module/test_module/sections/.init.text 4096
# ok: /sys/module/test_module/sections/.init.text 2
not ok 2 selftests: splice: short_splice_read.sh # exit=3D1
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/splice'
2021-02-07 21:53:33 make run_tests -C static_keys
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/static_k=
eys'
TAP version 13
1..1
# selftests: static_keys: test_static_keys.sh
# static_key: ok
ok 1 selftests: static_keys: test_static_keys.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/static_ke=
ys'
LKP WARN miss config CONFIG_SYNC=3D of sync/config
2021-02-07 21:53:33 make run_tests -C sync
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sync'
gcc -c sync_alloc.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-d=
c8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sync/sync_a=
lloc.o
gcc -c sync_fence.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-d=
c8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sync/sync_f=
ence.o
gcc -c sync_merge.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-d=
c8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sync/sync_m=
erge.o
gcc -c sync_wait.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-dc=
8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sync/sync_wa=
it.o
gcc -c sync_stress_parallelism.c -o /usr/src/perf_selftests-x86_64-rhel-7.6=
-kselftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftest=
s/sync/sync_stress_parallelism.o
gcc -c sync_stress_consumer.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-ks=
elftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/s=
ync/sync_stress_consumer.o
gcc -c sync_stress_merge.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kself=
tests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sync=
/sync_stress_merge.o
gcc -c sync_test.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-dc=
8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sync/sync_te=
st.o -O2 -g -std=3Dgnu89 -pthread -Wall -Wextra -I../../../../usr/include/
gcc -c sync.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-dc8df6e=
85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sync/sync.o -O2 -=
g -std=3Dgnu89 -pthread -Wall -Wextra -I../../../../usr/include/
gcc -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18a=
0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sync/sync_test /usr/src/per=
f_selftests-x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b64=
9bc5/tools/testing/selftests/sync/sync_test.o /usr/src/perf_selftests-x86_6=
4-rhel-7.6-kselftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testin=
g/selftests/sync/sync.o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-=
dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sync/sync_=
alloc.o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18=
a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sync/sync_fence.o /usr/src=
/perf_selftests-x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18a0992ae3cc8ad3d6=
5b649bc5/tools/testing/selftests/sync/sync_merge.o /usr/src/perf_selftests-=
x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/t=
esting/selftests/sync/sync_wait.o /usr/src/perf_selftests-x86_64-rhel-7.6-k=
selftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/=
sync/sync_stress_parallelism.o /usr/src/perf_selftests-x86_64-rhel-7.6-ksel=
ftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/syn=
c/sync_stress_consumer.o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sync/sync=
_stress_merge.o -O2 -g -std=3Dgnu89 -pthread -Wall -Wextra -I../../../../us=
r/include/ -pthread
TAP version 13
1..1
# selftests: sync: sync_test
# TAP version 13
# 1..10
# # [RUN]	Testing sync framework
# ok 1 [RUN]	test_alloc_timeline
# ok 2 [RUN]	test_alloc_fence
# ok 3 [RUN]	test_alloc_fence_negative
# ok 4 [RUN]	test_fence_one_timeline_wait
# ok 5 [RUN]	test_fence_one_timeline_merge
# ok 6 [RUN]	test_fence_merge_same_fence
# ok 7 [RUN]	test_fence_multi_timeline_wait
# ok 8 [RUN]	test_stress_two_threads_shared_timeline
# ok 9 [RUN]	test_consumer_stress_multi_producer_single_consumer
# ok 10 [RUN]	test_merge_stress_random_merge
# # Totals: pass:10 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: sync: sync_test
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sync'
2021-02-07 21:53:37 make run_tests -C syscall_user_dispatch
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/syscall_=
user_dispatch'
gcc -Wall -I../../../../usr/include/    sud_test.c  -o /usr/src/perf_selfte=
sts-x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/too=
ls/testing/selftests/syscall_user_dispatch/sud_test
gcc -Wall -I../../../../usr/include/    sud_benchmark.c  -o /usr/src/perf_s=
elftests-x86_64-rhel-7.6-kselftests-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc=
5/tools/testing/selftests/syscall_user_dispatch/sud_benchmark
TAP version 13
1..2
# selftests: syscall_user_dispatch: sud_test
# TAP version 13
# 1..6
# # Starting 6 tests from 1 test cases.
# #  RUN           global.dispatch_trigger_sigsys ...
# #            OK  global.dispatch_trigger_sigsys
# ok 1 global.dispatch_trigger_sigsys
# #  RUN           global.bad_prctl_param ...
# #            OK  global.bad_prctl_param
# ok 2 global.bad_prctl_param
# #  RUN           global.dispatch_and_return ...
# #            OK  global.dispatch_and_return
# ok 3 global.dispatch_and_return
# #  RUN           global.bad_selector ...
# #            OK  global.bad_selector
# ok 4 global.bad_selector
# #  RUN           global.disable_dispatch ...
# #            OK  global.disable_dispatch
# ok 5 global.disable_dispatch
# #  RUN           global.direct_dispatch_range ...
# #            OK  global.direct_dispatch_range
# ok 6 global.direct_dispatch_range
# # PASSED: 6 / 6 tests passed.
# # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: syscall_user_dispatch: sud_test
# selftests: syscall_user_dispatch: sud_benchmark
# Enabling syscall trapping.
# Caught sys_ff00
# Calibrating test set to last ~5 seconds...
# test iterations =3D 3500000
# Avg syscall time 1537ns.
# trapped_call_count 1, native_call_count 0.
# Avg syscall time 1582ns.
# Interception overhead: 2.9% (+45ns).
ok 2 selftests: syscall_user_dispatch: sud_benchmark
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/syscall_u=
ser_dispatch'
2021-02-07 21:53:49 make run_tests -C sysctl
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sysctl'
TAP version 13
1..1
# selftests: sysctl: sysctl.sh
# Checking production write strict setting ... ok
# Sun Feb  7 21:53:49 UTC 2021
# Running test: sysctl_test_0001 - run #0
# =3D=3D Testing sysctl behavior against /proc/sys/debug/test_sysctl/int_00=
01 =3D=3D
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Testing that 0x0000000100000000 fails as expected...ok
# Testing that 0x0000000100000001 fails as expected...ok
# Testing that 0x00000001ffffffff fails as expected...ok
# Testing that 0x0000000180000000 fails as expected...ok
# Testing that 0x000000017fffffff fails as expected...ok
# Testing that 0xffffffff00000000 fails as expected...ok
# Testing that 0xffffffff00000001 fails as expected...ok
# Testing that 0xffffffffffffffff fails as expected...ok
# Testing that 0xffffffff80000000 fails as expected...ok
# Testing that 0xffffffff7fffffff fails as expected...ok
# Testing that -0x0000000100000000 fails as expected...ok
# Testing that -0x0000000100000001 fails as expected...ok
# Testing that -0x00000001ffffffff fails as expected...ok
# Testing that -0x0000000180000000 fails as expected...ok
# Testing that -0x000000017fffffff fails as expected...ok
# Testing that -0xffffffff00000000 fails as expected...ok
# Testing that -0xffffffff00000001 fails as expected...ok
# Testing that -0xffffffffffffffff fails as expected...ok
# Testing that -0xffffffff80000000 fails as expected...ok
# Testing that -0xffffffff7fffffff fails as expected...ok
# Checking ignoring spaces up to PAGE_SIZE works on write ...ok
# Checking passing PAGE_SIZE of spaces fails on write ...ok
# Sun Feb  7 21:53:50 UTC 2021
# Running test: sysctl_test_0002 - run #0
# =3D=3D Testing sysctl behavior against /proc/sys/debug/test_sysctl/string=
_0001 =3D=3D
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Writing entire sysctl in short writes ... ok
# Writing middle of sysctl after unsynchronized seek ... ok
# Checking sysctl maxlen is at least 65 ... ok
# Checking sysctl keeps original string on overflow append ... ok
# Checking sysctl stays NULL terminated on write ... ok
# Checking sysctl stays NULL terminated on overwrite ... ok
# Sun Feb  7 21:53:50 UTC 2021
# Running test: sysctl_test_0003 - run #0
# =3D=3D Testing sysctl behavior against /proc/sys/debug/test_sysctl/int_00=
02 =3D=3D
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Testing that 0x0000000100000000 fails as expected...ok
# Testing that 0x0000000100000001 fails as expected...ok
# Testing that 0x00000001ffffffff fails as expected...ok
# Testing that 0x0000000180000000 fails as expected...ok
# Testing that 0x000000017fffffff fails as expected...ok
# Testing that 0xffffffff00000000 fails as expected...ok
# Testing that 0xffffffff00000001 fails as expected...ok
# Testing that 0xffffffffffffffff fails as expected...ok
# Testing that 0xffffffff80000000 fails as expected...ok
# Testing that 0xffffffff7fffffff fails as expected...ok
# Testing that -0x0000000100000000 fails as expected...ok
# Testing that -0x0000000100000001 fails as expected...ok
# Testing that -0x00000001ffffffff fails as expected...ok
# Testing that -0x0000000180000000 fails as expected...ok
# Testing that -0x000000017fffffff fails as expected...ok
# Testing that -0xffffffff00000000 fails as expected...ok
# Testing that -0xffffffff00000001 fails as expected...ok
# Testing that -0xffffffffffffffff fails as expected...ok
# Testing that -0xffffffff80000000 fails as expected...ok
# Testing that -0xffffffff7fffffff fails as expected...ok
# Checking ignoring spaces up to PAGE_SIZE works on write ...ok
# Checking passing PAGE_SIZE of spaces fails on write ...ok
# Testing INT_MAX works ...ok
# Testing INT_MAX + 1 will fail as expected...ok
# Testing negative values will work as expected...ok
# Sun Feb  7 21:53:50 UTC 2021
# Running test: sysctl_test_0004 - run #0
# =3D=3D Testing sysctl behavior against /proc/sys/debug/test_sysctl/uint_0=
001 =3D=3D
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Testing that 0x0000000100000000 fails as expected...ok
# Testing that 0x0000000100000001 fails as expected...ok
# Testing that 0x00000001ffffffff fails as expected...ok
# Testing that 0x0000000180000000 fails as expected...ok
# Testing that 0x000000017fffffff fails as expected...ok
# Testing that 0xffffffff00000000 fails as expected...ok
# Testing that 0xffffffff00000001 fails as expected...ok
# Testing that 0xffffffffffffffff fails as expected...ok
# Testing that 0xffffffff80000000 fails as expected...ok
# Testing that 0xffffffff7fffffff fails as expected...ok
# Testing that -0x0000000100000000 fails as expected...ok
# Testing that -0x0000000100000001 fails as expected...ok
# Testing that -0x00000001ffffffff fails as expected...ok
# Testing that -0x0000000180000000 fails as expected...ok
# Testing that -0x000000017fffffff fails as expected...ok
# Testing that -0xffffffff00000000 fails as expected...ok
# Testing that -0xffffffff00000001 fails as expected...ok
# Testing that -0xffffffffffffffff fails as expected...ok
# Testing that -0xffffffff80000000 fails as expected...ok
# Testing that -0xffffffff7fffffff fails as expected...ok
# Checking ignoring spaces up to PAGE_SIZE works on write ...ok
# Checking passing PAGE_SIZE of spaces fails on write ...ok
# Testing UINT_MAX works ...ok
# Testing UINT_MAX + 1 will fail as expected...ok
# Testing negative values will not work as expected ...ok
# Sun Feb  7 21:53:51 UTC 2021
# Running test: sysctl_test_0005 - run #0
# Testing array works as expected ... ok
# Testing skipping trailing array elements works ... ok
# Testing PAGE_SIZE limit on array works ... ok
# Testing exceeding PAGE_SIZE limit fails as expected ... ok
# Sun Feb  7 21:53:51 UTC 2021
# Running test: sysctl_test_0005 - run #1
# Testing array works as expected ... ok
# Testing skipping trailing array elements works ... ok
# Testing PAGE_SIZE limit on array works ... ok
# Testing exceeding PAGE_SIZE limit fails as expected ... ok
# Sun Feb  7 21:53:51 UTC 2021
# Running test: sysctl_test_0005 - run #2
# Testing array works as expected ... ok
# Testing skipping trailing array elements works ... ok
# Testing PAGE_SIZE limit on array works ... ok
# Testing exceeding PAGE_SIZE limit fails as expected ... ok
# Sun Feb  7 21:53:51 UTC 2021
# Running test: sysctl_test_0006 - run #0
# Checking bitmap handler... ok
# Sun Feb  7 21:53:51 UTC 2021
# Running test: sysctl_test_0006 - run #1
# Checking bitmap handler... ok
# Sun Feb  7 21:53:51 UTC 2021
# Running test: sysctl_test_0006 - run #2
# Checking bitmap handler... ok
# Sun Feb  7 21:53:53 UTC 2021
# Running test: sysctl_test_0006 - run #3
# Checking bitmap handler... ok
# Sun Feb  7 21:53:54 UTC 2021
# Running test: sysctl_test_0006 - run #4
# Checking bitmap handler... ok
# Sun Feb  7 21:53:56 UTC 2021
# Running test: sysctl_test_0006 - run #5
# Checking bitmap handler... ok
# Sun Feb  7 21:53:56 UTC 2021
# Running test: sysctl_test_0006 - run #6
# Checking bitmap handler... ok
# Sun Feb  7 21:53:57 UTC 2021
# Running test: sysctl_test_0006 - run #7
# Checking bitmap handler... ok
# Sun Feb  7 21:53:57 UTC 2021
# Running test: sysctl_test_0006 - run #8
# Checking bitmap handler... ok
# Sun Feb  7 21:53:58 UTC 2021
# Running test: sysctl_test_0006 - run #9
# Checking bitmap handler... ok
# Sun Feb  7 21:53:58 UTC 2021
# Running test: sysctl_test_0006 - run #10
# Checking bitmap handler... ok
# Sun Feb  7 21:53:58 UTC 2021
# Running test: sysctl_test_0006 - run #11
# Checking bitmap handler... ok
# Sun Feb  7 21:53:59 UTC 2021
# Running test: sysctl_test_0006 - run #12
# Checking bitmap handler... ok
# Sun Feb  7 21:54:01 UTC 2021
# Running test: sysctl_test_0006 - run #13
# Checking bitmap handler... ok
# Sun Feb  7 21:54:01 UTC 2021
# Running test: sysctl_test_0006 - run #14
# Checking bitmap handler... ok
# Sun Feb  7 21:54:02 UTC 2021
# Running test: sysctl_test_0006 - run #15
# Checking bitmap handler... ok
# Sun Feb  7 21:54:03 UTC 2021
# Running test: sysctl_test_0006 - run #16
# Checking bitmap handler... ok
# Sun Feb  7 21:54:05 UTC 2021
# Running test: sysctl_test_0006 - run #17
# Checking bitmap handler... ok
# Sun Feb  7 21:54:05 UTC 2021
# Running test: sysctl_test_0006 - run #18
# Checking bitmap handler... ok
# Sun Feb  7 21:54:05 UTC 2021
# Running test: sysctl_test_0006 - run #19
# Checking bitmap handler... ok
# Sun Feb  7 21:54:05 UTC 2021
# Running test: sysctl_test_0006 - run #20
# Checking bitmap handler... ok
# Sun Feb  7 21:54:07 UTC 2021
# Running test: sysctl_test_0006 - run #21
# Checking bitmap handler... ok
# Sun Feb  7 21:54:09 UTC 2021
# Running test: sysctl_test_0006 - run #22
# Checking bitmap handler... ok
# Sun Feb  7 21:54:10 UTC 2021
# Running test: sysctl_test_0006 - run #23
# Checking bitmap handler... ok
# Sun Feb  7 21:54:11 UTC 2021
# Running test: sysctl_test_0006 - run #24
# Checking bitmap handler... ok
# Sun Feb  7 21:54:12 UTC 2021
# Running test: sysctl_test_0006 - run #25
# Checking bitmap handler... ok
# Sun Feb  7 21:54:12 UTC 2021
# Running test: sysctl_test_0006 - run #26
# Checking bitmap handler... ok
# Sun Feb  7 21:54:14 UTC 2021
# Running test: sysctl_test_0006 - run #27
# Checking bitmap handler... ok
# Sun Feb  7 21:54:14 UTC 2021
# Running test: sysctl_test_0006 - run #28
# Checking bitmap handler... ok
# Sun Feb  7 21:54:15 UTC 2021
# Running test: sysctl_test_0006 - run #29
# Checking bitmap handler... ok
# Sun Feb  7 21:54:15 UTC 2021
# Running test: sysctl_test_0006 - run #30
# Checking bitmap handler... ok
# Sun Feb  7 21:54:17 UTC 2021
# Running test: sysctl_test_0006 - run #31
# Checking bitmap handler... ok
# Sun Feb  7 21:54:17 UTC 2021
# Running test: sysctl_test_0006 - run #32
# Checking bitmap handler... ok
# Sun Feb  7 21:54:17 UTC 2021
# Running test: sysctl_test_0006 - run #33
# Checking bitmap handler... ok
# Sun Feb  7 21:54:18 UTC 2021
# Running test: sysctl_test_0006 - run #34
# Checking bitmap handler... ok
# Sun Feb  7 21:54:19 UTC 2021
# Running test: sysctl_test_0006 - run #35
# Checking bitmap handler... ok
# Sun Feb  7 21:54:19 UTC 2021
# Running test: sysctl_test_0006 - run #36
# Checking bitmap handler... ok
# Sun Feb  7 21:54:21 UTC 2021
# Running test: sysctl_test_0006 - run #37
# Checking bitmap handler... ok
# Sun Feb  7 21:54:21 UTC 2021
# Running test: sysctl_test_0006 - run #38
# Checking bitmap handler... ok
# Sun Feb  7 21:54:22 UTC 2021
# Running test: sysctl_test_0006 - run #39
# Checking bitmap handler... ok
# Sun Feb  7 21:54:23 UTC 2021
# Running test: sysctl_test_0006 - run #40
# Checking bitmap handler... ok
# Sun Feb  7 21:54:23 UTC 2021
# Running test: sysctl_test_0006 - run #41
# Checking bitmap handler... ok
# Sun Feb  7 21:54:23 UTC 2021
# Running test: sysctl_test_0006 - run #42
# Checking bitmap handler... ok
# Sun Feb  7 21:54:23 UTC 2021
# Running test: sysctl_test_0006 - run #43
# Checking bitmap handler... ok
# Sun Feb  7 21:54:24 UTC 2021
# Running test: sysctl_test_0006 - run #44
# Checking bitmap handler... ok
# Sun Feb  7 21:54:24 UTC 2021
# Running test: sysctl_test_0006 - run #45
# Checking bitmap handler... ok
# Sun Feb  7 21:54:24 UTC 2021
# Running test: sysctl_test_0006 - run #46
# Checking bitmap handler... ok
# Sun Feb  7 21:54:24 UTC 2021
# Running test: sysctl_test_0006 - run #47
# Checking bitmap handler... ok
# Sun Feb  7 21:54:25 UTC 2021
# Running test: sysctl_test_0006 - run #48
# Checking bitmap handler... ok
# Sun Feb  7 21:54:25 UTC 2021
# Running test: sysctl_test_0006 - run #49
# Checking bitmap handler... ok
# Sun Feb  7 21:54:26 UTC 2021
# Running test: sysctl_test_0007 - run #0
# Testing if /proc/sys/debug/test_sysctl/boot_int is set to 1 ...ok
ok 1 selftests: sysctl: sysctl.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/tools/testing/selftests/sysctl'

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/kernel-selftests.yaml
suite: kernel-selftests
testcase: kernel-selftests
category: functional
kconfig: x86_64-rhel-7.6-kselftests
need_memory: 3G
need_cpu: 2
kernel-selftests:
  group: group-s
kernel_cmdline: sysctl.debug.test_sysctl.boot_int=1
job_origin: kernel-selftests.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-skl-d05
tbox_group: lkp-skl-d05
submit_id: 60204d008e75fb34c6227a28
job_file: "/lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-group-s-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5-20210208-13510-1k4t9mu-0.yaml"
id: dc5489427480d331c1001d73b681252c72e7faf5
queuer_version: "/lkp-src"

#! hosts/lkp-skl-d05
model: Skylake
nr_cpu: 4
memory: 32G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/wwn-0x5000c50091e544de-part*"
ssd_partitions: "/dev/disk/by-id/wwn-0x55cd2e4151977e28-part2"
rootfs_partition: "/dev/disk/by-id/wwn-0x55cd2e4151977e28-part1"
brand: Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz

#! include/category/functional
kmsg: 
heartbeat: 
meminfo: 

#! include/queue/cyclic
commit: dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5

#! include/testbox/lkp-skl-d05
need_kconfig_hw:
- CONFIG_E1000E=y
- CONFIG_SATA_AHCI
ucode: '0xe2'

# for sysctl

#! include/kernel-selftests
need_linux_headers: true
need_linux_selftests: true
need_kconfig:
- CONFIG_SECURITY=y
- CONFIG_SECURITYFS=y
- CONFIG_PID_NS=y
- CONFIG_SECCOMP=y
- CONFIG_SECCOMP_FILTER=y
- CONFIG_USER_NS=y
- CONFIG_TEST_LKM=m
- CONFIG_TEST_STATIC_KEYS=m
- CONFIG_STAGING=y
- CONFIG_ANDROID=y
- CONFIG_SYNC=y ~ "<= v4.7"
- CONFIG_SW_SYNC=y
- CONFIG_GENERIC_ENTRY=y
- CONFIG_TEST_SYSCTL=y
enqueue_time: 2021-02-08 04:26:41.190833439 +08:00
_id: 60204d008e75fb34c6227a28
_rt: "/result/kernel-selftests/group-s-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/gcc-9/dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5"

#! schedule options
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: 35e48b7d85fc04bfb58ed6546c2f311789c31a27
base_commit: 1048ba83fb1c00cd24172e23e8263972f6b5d9ac
branch: linux-devel/devel-hourly-20210207-072039
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/kernel-selftests/group-s-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/gcc-9/dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/0"
scheduler_version: "/lkp/lkp/.src-20210207-181621"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-group-s-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5-20210208-13510-1k4t9mu-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-7.6-kselftests
- branch=linux-devel/devel-hourly-20210207-072039
- commit=dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/vmlinuz-5.11.0-rc5-00462-gdc8df6e85d2c
- sysctl.debug.test_sysctl.boot_int=1
- max_uptime=2100
- RESULT_ROOT=/result/kernel-selftests/group-s-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/gcc-9/dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/0
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/modules.cgz"
linux_headers_initrd: "/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/linux-headers.cgz"
linux_selftests_initrd: "/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/linux-selftests.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/kernel-selftests_20201231.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/kernel-selftests-x86_64-b553cffa-1_20210122.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20201117.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20210205-205910/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.11.0-rc6-06039-gafb9e7f7a128

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/dc8df6e85d2c8f18a0992ae3cc8ad3d65b649bc5/vmlinuz-5.11.0-rc5-00462-gdc8df6e85d2c"
dequeue_time: 2021-02-08 05:36:21.827600732 +08:00

#! /lkp/lkp/.src-20210207-181621/include/site/inn
job_state: finished
loadavg: 1.39 0.75 0.31 1/142 11824
start_time: '1612733905'
end_time: '1612734067'
version: "/lkp/lkp/.src-20210207-181653:7dce720b:46674d007"

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

ln -sf /usr/bin/clang
ln -sf /usr/bin/llc
sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
make TARGETS=safesetid
make run_tests -C safesetid
make run_tests -C seccomp
make run_tests -C sgx
make run_tests -C sigaltstack
make run_tests -C size
make run_tests -C sparc64
make run_tests -C splice
make run_tests -C static_keys
make run_tests -C sync
make run_tests -C syscall_user_dispatch
make run_tests -C sysctl

--OgqxwSJOaUobr8KG--
