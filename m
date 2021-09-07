Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB85402A92
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 16:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237329AbhIGORl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 10:17:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:35352 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235766AbhIGORi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 10:17:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="218346917"
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="xz'?yaml'?scan'208";a="218346917"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 07:10:32 -0700
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="xz'?yaml'?scan'208";a="469210888"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 07:10:27 -0700
Date:   Tue, 7 Sep 2021 22:27:58 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, mptcp@lists.01.org
Subject: [veth]  9d3684c24a: kernel-selftests.net/mptcp.mptcp_join.sh.fail
Message-ID: <20210907142758.GD17617@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wLAMOaPNJ0fu1fTG"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: 9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867 ("veth: create by default nr_possible_cpus queues")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


in testcase: kernel-selftests
version: kernel-selftests-x86_64-fb843668-1_20210905
with following parameters:

	group: mptcp
	ucode: 0x11

test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


on test machine: 288 threads 2 sockets Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):




If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8.3-kselftests-9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867
2021-09-06 14:54:41 ln -sf /usr/bin/clang
2021-09-06 14:54:41 ln -sf /usr/bin/llc
2021-09-06 14:54:41 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
2021-09-06 14:54:42 make -j288 -C net/mptcp
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867/tools/testing/selftests/net/mptcp'
make --no-builtin-rules ARCH=x86 -C ../../../../.. headers_install
gcc -Wall -Wl,--no-as-needed -O2 -g  -I../../../../../usr/include    mptcp_connect.c  -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867/tools/testing/selftests/net/mptcp/mptcp_connect
gcc -Wall -Wl,--no-as-needed -O2 -g  -I../../../../../usr/include    pm_nl_ctl.c  -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867/tools/testing/selftests/net/mptcp/pm_nl_ctl
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867'
  HOSTCC  scripts/basic/fixdep
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
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  UPD     include/generated/uapi/linux/version.h
  HOSTCC  scripts/unifdef
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
  HDRINST usr/include/video/edid.h
  HDRINST usr/include/video/uvesafb.h
  HDRINST usr/include/video/sisfb.h
  HDRINST usr/include/drm/v3d_drm.h
  HDRINST usr/include/drm/vgem_drm.h
  HDRINST usr/include/drm/panfrost_drm.h
  HDRINST usr/include/drm/armada_drm.h
  HDRINST usr/include/drm/i915_drm.h
  HDRINST usr/include/drm/msm_drm.h
  HDRINST usr/include/drm/sis_drm.h
  HDRINST usr/include/drm/nouveau_drm.h
  HDRINST usr/include/drm/i810_drm.h
  HDRINST usr/include/drm/vmwgfx_drm.h
  HDRINST usr/include/drm/drm_sarea.h
  HDRINST usr/include/drm/lima_drm.h
  HDRINST usr/include/drm/omap_drm.h
  HDRINST usr/include/drm/virtgpu_drm.h
  HDRINST usr/include/drm/r128_drm.h
  HDRINST usr/include/drm/amdgpu_drm.h
  HDRINST usr/include/drm/radeon_drm.h
  HDRINST usr/include/drm/exynos_drm.h
  HDRINST usr/include/drm/mga_drm.h
  HDRINST usr/include/drm/etnaviv_drm.h
  HDRINST usr/include/drm/drm.h
  HDRINST usr/include/drm/tegra_drm.h
  HDRINST usr/include/drm/savage_drm.h
  HDRINST usr/include/drm/vc4_drm.h
  HDRINST usr/include/drm/via_drm.h
  HDRINST usr/include/drm/drm_fourcc.h
  HDRINST usr/include/drm/qxl_drm.h
  HDRINST usr/include/drm/drm_mode.h
  HDRINST usr/include/mtd/inftl-user.h
  HDRINST usr/include/mtd/mtd-user.h
  HDRINST usr/include/mtd/ubi-user.h
  HDRINST usr/include/mtd/nftl-user.h
  HDRINST usr/include/mtd/mtd-abi.h
  HDRINST usr/include/xen/gntalloc.h
  HDRINST usr/include/xen/evtchn.h
  HDRINST usr/include/xen/gntdev.h
  HDRINST usr/include/xen/privcmd.h
  HDRINST usr/include/asm-generic/int-l64.h
  HDRINST usr/include/asm-generic/sembuf.h
  HDRINST usr/include/asm-generic/msgbuf.h
  HDRINST usr/include/asm-generic/stat.h
  HDRINST usr/include/asm-generic/hugetlb_encode.h
  HDRINST usr/include/asm-generic/param.h
  HDRINST usr/include/asm-generic/kvm_para.h
  HDRINST usr/include/asm-generic/types.h
  HDRINST usr/include/asm-generic/ioctls.h
  HDRINST usr/include/asm-generic/termios.h
  HDRINST usr/include/asm-generic/int-ll64.h
  HDRINST usr/include/asm-generic/fcntl.h
  HDRINST usr/include/asm-generic/ipcbuf.h
  HDRINST usr/include/asm-generic/shmbuf.h
  HDRINST usr/include/asm-generic/mman.h
  HDRINST usr/include/asm-generic/errno.h
  HDRINST usr/include/asm-generic/swab.h
  HDRINST usr/include/asm-generic/termbits.h
  HDRINST usr/include/asm-generic/mman-common.h
  HDRINST usr/include/asm-generic/siginfo.h
  HDRINST usr/include/asm-generic/poll.h
  HDRINST usr/include/asm-generic/errno-base.h
  HDRINST usr/include/asm-generic/socket.h
  HDRINST usr/include/asm-generic/posix_types.h
  HDRINST usr/include/asm-generic/bpf_perf_event.h
  HDRINST usr/include/asm-generic/unistd.h
  HDRINST usr/include/asm-generic/ioctl.h
  HDRINST usr/include/asm-generic/setup.h
  HDRINST usr/include/asm-generic/auxvec.h
  HDRINST usr/include/asm-generic/resource.h
  HDRINST usr/include/asm-generic/ucontext.h
  HDRINST usr/include/asm-generic/signal.h
  HDRINST usr/include/asm-generic/signal-defs.h
  HDRINST usr/include/asm-generic/bitsperlong.h
  HDRINST usr/include/asm-generic/sockios.h
  HDRINST usr/include/asm-generic/statfs.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_verbs.h
  HDRINST usr/include/rdma/qedr-abi.h
  HDRINST usr/include/rdma/ib_user_ioctl_cmds.h
  HDRINST usr/include/rdma/ib_user_mad.h
  HDRINST usr/include/rdma/rdma_netlink.h
  HDRINST usr/include/rdma/irdma-abi.h
  HDRINST usr/include/rdma/rdma_user_ioctl_cmds.h
  HDRINST usr/include/rdma/rdma_user_cm.h
  HDRINST usr/include/rdma/ocrdma-abi.h
  HDRINST usr/include/rdma/rdma_user_ioctl.h
  HDRINST usr/include/rdma/bnxt_re-abi.h
  HDRINST usr/include/rdma/ib_user_verbs.h
  HDRINST usr/include/rdma/efa-abi.h
  HDRINST usr/include/rdma/ib_user_sa.h
  HDRINST usr/include/rdma/mlx5-abi.h
  HDRINST usr/include/rdma/vmw_pvrdma-abi.h
  HDRINST usr/include/rdma/ib_user_ioctl_verbs.h
  HDRINST usr/include/rdma/hns-abi.h
  HDRINST usr/include/rdma/rvt-abi.h
  HDRINST usr/include/rdma/mthca-abi.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_cmds.h
  HDRINST usr/include/rdma/cxgb4-abi.h
  HDRINST usr/include/rdma/rdma_user_rxe.h
  HDRINST usr/include/rdma/siw-abi.h
  HDRINST usr/include/rdma/mlx4-abi.h
  HDRINST usr/include/rdma/hfi/hfi1_ioctl.h
  HDRINST usr/include/rdma/hfi/hfi1_user.h
  HDRINST usr/include/misc/ocxl.h
  HDRINST usr/include/misc/uacce/uacce.h
  HDRINST usr/include/misc/uacce/hisi_qm.h
  HDRINST usr/include/misc/fastrpc.h
  HDRINST usr/include/misc/pvpanic.h
  HDRINST usr/include/misc/xilinx_sdfec.h
  HDRINST usr/include/misc/habanalabs.h
  HDRINST usr/include/misc/cxl.h
  HDRINST usr/include/linux/ax25.h
  HDRINST usr/include/linux/virtio_iommu.h
  HDRINST usr/include/linux/ipv6.h
  HDRINST usr/include/linux/capi.h
  HDRINST usr/include/linux/switchtec_ioctl.h
  HDRINST usr/include/linux/x25.h
  HDRINST usr/include/linux/cuda.h
  HDRINST usr/include/linux/kexec.h
  HDRINST usr/include/linux/v4l2-common.h
  HDRINST usr/include/linux/efs_fs_sb.h
  HDRINST usr/include/linux/netfilter/xt_connmark.h
  HDRINST usr/include/linux/netfilter/xt_length.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cthelper.h
  HDRINST usr/include/linux/netfilter/xt_nfacct.h
  HDRINST usr/include/linux/netfilter/xt_recent.h
  HDRINST usr/include/linux/netfilter/xt_dccp.h
  HDRINST usr/include/linux/netfilter/xt_NFQUEUE.h
  HDRINST usr/include/linux/netfilter/xt_physdev.h
  HDRINST usr/include/linux/netfilter/xt_MARK.h
  HDRINST usr/include/linux/netfilter/xt_conntrack.h
  HDRINST usr/include/linux/netfilter/xt_TPROXY.h
  HDRINST usr/include/linux/netfilter/xt_tcpmss.h
  HDRINST usr/include/linux/netfilter/xt_CHECKSUM.h
  HDRINST usr/include/linux/netfilter/xt_iprange.h
  HDRINST usr/include/linux/netfilter/xt_tcpudp.h
  HDRINST usr/include/linux/netfilter/xt_socket.h
  HDRINST usr/include/linux/netfilter/xt_set.h
  HDRINST usr/include/linux/netfilter/xt_rpfilter.h
  HDRINST usr/include/linux/netfilter/xt_bpf.h
  HDRINST usr/include/linux/netfilter/xt_connlabel.h
  HDRINST usr/include/linux/netfilter/xt_state.h
  HDRINST usr/include/linux/netfilter/xt_multiport.h
  HDRINST usr/include/linux/netfilter/xt_NFLOG.h
  HDRINST usr/include/linux/netfilter/xt_LED.h
  HDRINST usr/include/linux/netfilter/xt_ipvs.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_common.h
  HDRINST usr/include/linux/netfilter/xt_u32.h
  HDRINST usr/include/linux/netfilter/nfnetlink_conntrack.h
  HDRINST usr/include/linux/netfilter/xt_connlimit.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_ftp.h
  HDRINST usr/include/linux/netfilter/nf_log.h
  HDRINST usr/include/linux/netfilter/xt_hashlimit.h
  HDRINST usr/include/linux/netfilter/xt_TCPOPTSTRIP.h
  HDRINST usr/include/linux/netfilter/nfnetlink_hook.h
  HDRINST usr/include/linux/netfilter/xt_mark.h
  HDRINST usr/include/linux/netfilter/xt_statistic.h
  HDRINST usr/include/linux/netfilter/xt_CLASSIFY.h
  HDRINST usr/include/linux/netfilter/xt_connbytes.h
  HDRINST usr/include/linux/netfilter/xt_esp.h
  HDRINST usr/include/linux/netfilter/xt_ecn.h
  HDRINST usr/include/linux/netfilter/xt_AUDIT.h
  HDRINST usr/include/linux/netfilter/xt_realm.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cttimeout.h
  HDRINST usr/include/linux/netfilter/xt_l2tp.h
  HDRINST usr/include/linux/netfilter/xt_RATEEST.h
  HDRINST usr/include/linux/netfilter/nf_synproxy.h
  HDRINST usr/include/linux/netfilter/xt_owner.h
  HDRINST usr/include/linux/netfilter/xt_DSCP.h
  HDRINST usr/include/linux/netfilter/nfnetlink_osf.h
  HDRINST usr/include/linux/netfilter/xt_sctp.h
  HDRINST usr/include/linux/netfilter/xt_cgroup.h
  HDRINST usr/include/linux/netfilter/nf_tables_compat.h
  HDRINST usr/include/linux/netfilter/xt_CONNMARK.h
  HDRINST usr/include/linux/netfilter/xt_pkttype.h
  HDRINST usr/include/linux/netfilter/xt_helper.h
  HDRINST usr/include/linux/netfilter/xt_mac.h
  HDRINST usr/include/linux/netfilter/nfnetlink_log.h
  HDRINST usr/include/linux/netfilter/xt_quota.h
  HDRINST usr/include/linux/netfilter/xt_LOG.h
  HDRINST usr/include/linux/netfilter/xt_dscp.h
  HDRINST usr/include/linux/netfilter/nfnetlink_acct.h
  HDRINST usr/include/linux/netfilter/nfnetlink_compat.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tuple_common.h
  HDRINST usr/include/linux/netfilter/xt_SYNPROXY.h
  HDRINST usr/include/linux/netfilter/xt_CONNSECMARK.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_sctp.h
  HDRINST usr/include/linux/netfilter/xt_rateest.h
  HDRINST usr/include/linux/netfilter/xt_CT.h
  HDRINST usr/include/linux/netfilter/xt_comment.h
  HDRINST usr/include/linux/netfilter/xt_osf.h
  HDRINST usr/include/linux/netfilter/xt_HMARK.h
  HDRINST usr/include/linux/netfilter/xt_devgroup.h
  HDRINST usr/include/linux/netfilter/xt_addrtype.h
  HDRINST usr/include/linux/netfilter/nf_nat.h
  HDRINST usr/include/linux/netfilter/xt_TCPMSS.h
  HDRINST usr/include/linux/netfilter/xt_SECMARK.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_list.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_hash.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_bitmap.h
  HDRINST usr/include/linux/netfilter/xt_TEE.h
  HDRINST usr/include/linux/netfilter/x_tables.h
  HDRINST usr/include/linux/netfilter/nfnetlink.h
  HDRINST usr/include/linux/netfilter/nf_tables.h
  HDRINST usr/include/linux/netfilter/xt_cluster.h
  HDRINST usr/include/linux/netfilter/xt_cpu.h
  HDRINST usr/include/linux/netfilter/xt_ipcomp.h
  HDRINST usr/include/linux/netfilter/xt_string.h
  HDRINST usr/include/linux/netfilter/nfnetlink_queue.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tcp.h
  HDRINST usr/include/linux/netfilter/xt_IDLETIMER.h
  HDRINST usr/include/linux/netfilter/xt_policy.h
  HDRINST usr/include/linux/netfilter/xt_time.h
  HDRINST usr/include/linux/netfilter/xt_limit.h
  HDRINST usr/include/linux/virtio_rng.h
  HDRINST usr/include/linux/nbd-netlink.h
  HDRINST usr/include/linux/agpgart.h
  HDRINST usr/include/linux/irqnr.h
  HDRINST usr/include/linux/net_namespace.h
  HDRINST usr/include/linux/lwtunnel.h
  HDRINST usr/include/linux/seg6_local.h
  HDRINST usr/include/linux/dm-log-userspace.h
  HDRINST usr/include/linux/bfs_fs.h
  HDRINST usr/include/linux/spi/spi.h
  HDRINST usr/include/linux/spi/spidev.h
  HDRINST usr/include/linux/memfd.h
  HDRINST usr/include/linux/fou.h
  HDRINST usr/include/linux/media.h
  HDRINST usr/include/linux/romfs_fs.h
  HDRINST usr/include/linux/bsg.h
  HDRINST usr/include/linux/connector.h
  HDRINST usr/include/linux/byteorder/little_endian.h
  HDRINST usr/include/linux/byteorder/big_endian.h
  HDRINST usr/include/linux/vfio_ccw.h
  HDRINST usr/include/linux/in.h
  HDRINST usr/include/linux/hdreg.h
  HDRINST usr/include/linux/suspend_ioctls.h
  HDRINST usr/include/linux/nitro_enclaves.h
  HDRINST usr/include/linux/nilfs2_api.h
  HDRINST usr/include/linux/fsverity.h
  HDRINST usr/include/linux/if_slip.h
  HDRINST usr/include/linux/serial_core.h
  HDRINST usr/include/linux/tipc_sockets_diag.h
  HDRINST usr/include/linux/auto_fs.h
  HDRINST usr/include/linux/tcp_metrics.h
  HDRINST usr/include/linux/wwan.h
  HDRINST usr/include/linux/atmmpc.h
  HDRINST usr/include/linux/iio/types.h
  HDRINST usr/include/linux/iio/events.h
  HDRINST usr/include/linux/iio/buffer.h
  HDRINST usr/include/linux/sock_diag.h
  HDRINST usr/include/linux/ipmi_msgdefs.h
  HDRINST usr/include/linux/pmu.h
  HDRINST usr/include/linux/fscrypt.h
  HDRINST usr/include/linux/nfs.h
  HDRINST usr/include/linux/isdn/capicmd.h
  HDRINST usr/include/linux/stat.h
  HDRINST usr/include/linux/atalk.h
  HDRINST usr/include/linux/cifs/cifs_mount.h
  HDRINST usr/include/linux/cifs/cifs_netlink.h
  HDRINST usr/include/linux/ptp_clock.h
  HDRINST usr/include/linux/rose.h
  HDRINST usr/include/linux/loop.h
  HDRINST usr/include/linux/acrn.h
  HDRINST usr/include/linux/un.h
  HDRINST usr/include/linux/atmsvc.h
  HDRINST usr/include/linux/psample.h
  HDRINST usr/include/linux/gen_stats.h
  HDRINST usr/include/linux/nfc.h
  HDRINST usr/include/linux/toshiba.h
  HDRINST usr/include/linux/kernelcapi.h
  HDRINST usr/include/linux/if_tunnel.h
  HDRINST usr/include/linux/timex.h
  HDRINST usr/include/linux/xattr.h
  HDRINST usr/include/linux/dn.h
  HDRINST usr/include/linux/rxrpc.h
  HDRINST usr/include/linux/unix_diag.h
  HDRINST usr/include/linux/nubus.h
  HDRINST usr/include/linux/meye.h
  HDRINST usr/include/linux/videodev2.h
  HDRINST usr/include/linux/futex.h
  HDRINST usr/include/linux/param.h
  HDRINST usr/include/linux/module.h
  HDRINST usr/include/linux/ppp_defs.h
  HDRINST usr/include/linux/if_pppol2tp.h
  HDRINST usr/include/linux/cgroupstats.h
  HDRINST usr/include/linux/lp.h
  HDRINST usr/include/linux/cec.h
  HDRINST usr/include/linux/netfilter_ipv4/ip_tables.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ah.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_CLUSTERIP.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ttl.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_LOG.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ecn.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ECN.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_TTL.h
  HDRINST usr/include/linux/if_link.h
  HDRINST usr/include/linux/zorro_ids.h
  HDRINST usr/include/linux/netdevice.h
  HDRINST usr/include/linux/i2c-dev.h
  HDRINST usr/include/linux/if_addr.h
  HDRINST usr/include/linux/firewire-constants.h
  HDRINST usr/include/linux/if_macsec.h
  HDRINST usr/include/linux/major.h
  HDRINST usr/include/linux/vboxguest.h
  HDRINST usr/include/linux/kernel.h
  HDRINST usr/include/linux/sysinfo.h
  HDRINST usr/include/linux/mdio.h
  HDRINST usr/include/linux/netfilter_bridge.h
  HDRINST usr/include/linux/seg6_hmac.h
  HDRINST usr/include/linux/vhost_types.h
  HDRINST usr/include/linux/kvm_para.h
  HDRINST usr/include/linux/atmppp.h
  HDRINST usr/include/linux/ppdev.h
  HDRINST usr/include/linux/kcm.h
  HDRINST usr/include/linux/rpmsg_types.h
  HDRINST usr/include/linux/nvram.h
  HDRINST usr/include/linux/elf.h
  HDRINST usr/include/linux/types.h
  HDRINST usr/include/linux/if_fc.h
  HDRINST usr/include/linux/can/vxcan.h
  HDRINST usr/include/linux/can/bcm.h
  HDRINST usr/include/linux/can/error.h
  HDRINST usr/include/linux/can/gw.h
  HDRINST usr/include/linux/can/j1939.h
  HDRINST usr/include/linux/can/raw.h
  HDRINST usr/include/linux/can/isotp.h
  HDRINST usr/include/linux/can/netlink.h
  HDRINST usr/include/linux/input-event-codes.h
  HDRINST usr/include/linux/ife.h
  HDRINST usr/include/linux/isst_if.h
  HDRINST usr/include/linux/vsockmon.h
  HDRINST usr/include/linux/virtio_pcidev.h
  HDRINST usr/include/linux/packet_diag.h
  HDRINST usr/include/linux/ipc.h
  HDRINST usr/include/linux/v4l2-dv-timings.h
  HDRINST usr/include/linux/rpmsg.h
  HDRINST usr/include/linux/rtnetlink.h
  HDRINST usr/include/linux/ccs.h
  HDRINST usr/include/linux/i2c.h
  HDRINST usr/include/linux/personality.h
  HDRINST usr/include/linux/if_xdp.h
  HDRINST usr/include/linux/coda.h
  HDRINST usr/include/linux/keyboard.h
  HDRINST usr/include/linux/tipc.h
  HDRINST usr/include/linux/nfs4_mount.h
  HDRINST usr/include/linux/cfm_bridge.h
  HDRINST usr/include/linux/apm_bios.h
  HDRINST usr/include/linux/gameport.h
  HDRINST usr/include/linux/fdreg.h
  HDRINST usr/include/linux/icmpv6.h
  HDRINST usr/include/linux/sonypi.h
  HDRINST usr/include/linux/virtio_snd.h
  HDRINST usr/include/linux/rio_cm_cdev.h
  HDRINST usr/include/linux/nfs3.h
  HDRINST usr/include/linux/io_uring.h
  HDRINST usr/include/linux/virtio_console.h
  HDRINST usr/include/linux/dma-heap.h
  HDRINST usr/include/linux/idxd.h
  HDRINST usr/include/linux/udf_fs_i.h
  HDRINST usr/include/linux/ipsec.h
  HDRINST usr/include/linux/if_pppox.h
  HDRINST usr/include/linux/rpl.h
  HDRINST usr/include/linux/blkzoned.h
  HDRINST usr/include/linux/landlock.h
  HDRINST usr/include/linux/atm_eni.h
  HDRINST usr/include/linux/seg6_iptunnel.h
  HDRINST usr/include/linux/if_phonet.h
  HDRINST usr/include/linux/dlm_plock.h
  HDRINST usr/include/linux/if_vlan.h
  HDRINST usr/include/linux/stddef.h
  HDRINST usr/include/linux/net_dropmon.h
  HDRINST usr/include/linux/virtio_crypto.h
  HDRINST usr/include/linux/atmioc.h
  HDRINST usr/include/linux/sunrpc/debug.h
  HDRINST usr/include/linux/map_to_7segment.h
  HDRINST usr/include/linux/vtpm_proxy.h
  HDRINST usr/include/linux/fsi.h
  HDRINST usr/include/linux/fuse.h
  HDRINST usr/include/linux/userfaultfd.h
  HDRINST usr/include/linux/sched/types.h
  HDRINST usr/include/linux/psp-sev.h
  HDRINST usr/include/linux/nsfs.h
  HDRINST usr/include/linux/virtio_net.h
  HDRINST usr/include/linux/arcfb.h
  HDRINST usr/include/linux/ppp-ioctl.h
  HDRINST usr/include/linux/reiserfs_xattr.h
  HDRINST usr/include/linux/if_packet.h
  HDRINST usr/include/linux/tiocl.h
  HDRINST usr/include/linux/uhid.h
  HDRINST usr/include/linux/tcp.h
  HDRINST usr/include/linux/cciss_ioctl.h
  HDRINST usr/include/linux/netlink_diag.h
  HDRINST usr/include/linux/termios.h
  HDRINST usr/include/linux/dlm_device.h
  HDRINST usr/include/linux/if_addrlabel.h
  HDRINST usr/include/linux/usbip.h
  HDRINST usr/include/linux/smc.h
  HDRINST usr/include/linux/if_hippi.h
  HDRINST usr/include/linux/hpet.h
  HDRINST usr/include/linux/nbd.h
  HDRINST usr/include/linux/virtio_balloon.h
  HDRINST usr/include/linux/virtio_9p.h
  HDRINST usr/include/linux/fadvise.h
  HDRINST usr/include/linux/cycx_cfm.h
  HDRINST usr/include/linux/pkt_sched.h
  HDRINST usr/include/linux/rkisp1-config.h
  HDRINST usr/include/linux/random.h
  HDRINST usr/include/linux/mptcp.h
  HDRINST usr/include/linux/net_tstamp.h
  HDRINST usr/include/linux/cec-funcs.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_pkttype.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nflog.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_802_3.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_limit.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_redirect.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_t.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nat.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_vlan.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_stp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arpreply.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip6.h
  HDRINST usr/include/linux/netfilter_bridge/ebtables.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_m.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_log.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_among.h
  HDRINST usr/include/linux/keyctl.h
  HDRINST usr/include/linux/um_timetravel.h
  HDRINST usr/include/linux/netconf.h
  HDRINST usr/include/linux/atmapi.h
  HDRINST usr/include/linux/uinput.h
  HDRINST usr/include/linux/mempolicy.h
  HDRINST usr/include/linux/atm_nicstar.h
  HDRINST usr/include/linux/acct.h
  HDRINST usr/include/linux/mmc/ioctl.h
  HDRINST usr/include/linux/uuid.h
  HDRINST usr/include/linux/if_ppp.h
  HDRINST usr/include/linux/neighbour.h
  HDRINST usr/include/linux/mii.h
  HDRINST usr/include/linux/atm_zatm.h
  HDRINST usr/include/linux/edd.h
  HDRINST usr/include/linux/virtio_bt.h
  HDRINST usr/include/linux/cciss_defs.h
  HDRINST usr/include/linux/erspan.h
  HDRINST usr/include/linux/reiserfs_fs.h
  HDRINST usr/include/linux/uleds.h
  HDRINST usr/include/linux/dlmconstants.h
  HDRINST usr/include/linux/pkt_cls.h
  HDRINST usr/include/linux/hdlcdrv.h
  HDRINST usr/include/linux/signalfd.h
  HDRINST usr/include/linux/fsl_mc.h
  HDRINST usr/include/linux/rpl_iptunnel.h
  HDRINST usr/include/linux/ila.h
  HDRINST usr/include/linux/lirc.h
  HDRINST usr/include/linux/hdlc.h
  HDRINST usr/include/linux/atmsap.h
  HDRINST usr/include/linux/virtio_mem.h
  HDRINST usr/include/linux/tc_ematch/tc_em_text.h
  HDRINST usr/include/linux/tc_ematch/tc_em_meta.h
  HDRINST usr/include/linux/tc_ematch/tc_em_ipt.h
  HDRINST usr/include/linux/tc_ematch/tc_em_nbyte.h
  HDRINST usr/include/linux/tc_ematch/tc_em_cmp.h
  HDRINST usr/include/linux/smc_diag.h
  HDRINST usr/include/linux/raid/md_u.h
  HDRINST usr/include/linux/raid/md_p.h
  HDRINST usr/include/linux/mrp_bridge.h
  HDRINST usr/include/linux/virtio_input.h
  HDRINST usr/include/linux/atmarp.h
  HDRINST usr/include/linux/utime.h
  HDRINST usr/include/linux/usb/functionfs.h
  HDRINST usr/include/linux/usb/audio.h
  HDRINST usr/include/linux/usb/ch11.h
  HDRINST usr/include/linux/usb/cdc.h
  HDRINST usr/include/linux/usb/charger.h
  HDRINST usr/include/linux/usb/cdc-wdm.h
  HDRINST usr/include/linux/usb/gadgetfs.h
  HDRINST usr/include/linux/usb/video.h
  HDRINST usr/include/linux/usb/midi.h
  HDRINST usr/include/linux/usb/ch9.h
  HDRINST usr/include/linux/usb/tmc.h
  HDRINST usr/include/linux/usb/g_uvc.h
  HDRINST usr/include/linux/usb/raw_gadget.h
  HDRINST usr/include/linux/usb/g_printer.h
  HDRINST usr/include/linux/reboot.h
  HDRINST usr/include/linux/shm.h
  HDRINST usr/include/linux/v4l2-mediabus.h
  HDRINST usr/include/linux/nfsd/stats.h
  HDRINST usr/include/linux/nfsd/cld.h
  HDRINST usr/include/linux/nfsd/nfsfh.h
  HDRINST usr/include/linux/nfsd/debug.h
  HDRINST usr/include/linux/nfsd/export.h
  HDRINST usr/include/linux/remoteproc_cdev.h
  HDRINST usr/include/linux/mpls.h
  HDRINST usr/include/linux/if_fddi.h
  HDRINST usr/include/linux/fcntl.h
  HDRINST usr/include/linux/eventpoll.h
  HDRINST usr/include/linux/hash_info.h
  HDRINST usr/include/linux/thermal.h
  HDRINST usr/include/linux/elf-fdpic.h
  HDRINST usr/include/linux/batman_adv.h
  HDRINST usr/include/linux/adfs_fs.h
  HDRINST usr/include/linux/phantom.h
  HDRINST usr/include/linux/posix_acl.h
  HDRINST usr/include/linux/bpf_common.h
  HDRINST usr/include/linux/bpqether.h
  HDRINST usr/include/linux/rtc.h
  HDRINST usr/include/linux/nvme_ioctl.h
  HDRINST usr/include/linux/sctp.h
  HDRINST usr/include/linux/netfilter.h
  HDRINST usr/include/linux/qnxtypes.h
  HDRINST usr/include/linux/nfsacl.h
  HDRINST usr/include/linux/kd.h
  HDRINST usr/include/linux/vm_sockets.h
  HDRINST usr/include/linux/if_x25.h
  HDRINST usr/include/linux/nfs_fs.h
  HDRINST usr/include/linux/msdos_fs.h
  HDRINST usr/include/linux/utsname.h
  HDRINST usr/include/linux/oom.h
  HDRINST usr/include/linux/mman.h
  HDRINST usr/include/linux/cdrom.h
  HDRINST usr/include/linux/hiddev.h
  HDRINST usr/include/linux/route.h
  HDRINST usr/include/linux/sed-opal.h
  HDRINST usr/include/linux/if_eql.h
  HDRINST usr/include/linux/btrfs_tree.h
  HDRINST usr/include/linux/ptrace.h
  HDRINST usr/include/linux/inet_diag.h
  HDRINST usr/include/linux/fsmap.h
  HDRINST usr/include/linux/virtio_ring.h
  HDRINST usr/include/linux/time.h
  HDRINST usr/include/linux/errno.h
  HDRINST usr/include/linux/xfrm.h
  HDRINST usr/include/linux/iso_fs.h
  HDRINST usr/include/linux/if_ltalk.h
  HDRINST usr/include/linux/ethtool_netlink.h
  HDRINST usr/include/linux/uvcvideo.h
  HDRINST usr/include/linux/dma-buf.h
  HDRINST usr/include/linux/bcm933xx_hcs.h
  HDRINST usr/include/linux/netfilter_arp/arp_tables.h
  HDRINST usr/include/linux/netfilter_arp/arpt_mangle.h
  HDRINST usr/include/linux/taskstats.h
  HDRINST usr/include/linux/mmtimer.h
  HDRINST usr/include/linux/matroxfb.h
  HDRINST usr/include/linux/bcache.h
  HDRINST usr/include/linux/affs_hardblocks.h
  HDRINST usr/include/linux/vbox_err.h
  HDRINST usr/include/linux/swab.h
  HDRINST usr/include/linux/xilinx-v4l2-controls.h
  HDRINST usr/include/linux/cn_proc.h
  HDRINST usr/include/linux/virtio_types.h
  HDRINST usr/include/linux/securebits.h
  HDRINST usr/include/linux/nl80211.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_rt.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_frag.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_LOG.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_HL.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_srh.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_mh.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_NPT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_hl.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6_tables.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ah.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ipv6header.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_opts.h
  HDRINST usr/include/linux/kcmp.h
  HDRINST usr/include/linux/pps.h
  HDRINST usr/include/linux/v4l2-controls.h
  HDRINST usr/include/linux/net.h
  HDRINST usr/include/linux/rseq.h
  HDRINST usr/include/linux/mei.h
  HDRINST usr/include/linux/kvm.h
  HDRINST usr/include/linux/inotify.h
  HDRINST usr/include/linux/wireguard.h
  HDRINST usr/include/linux/iommu.h
  HDRINST usr/include/linux/batadv_packet.h
  HDRINST usr/include/linux/nfs2.h
  HDRINST usr/include/linux/msg.h
  HDRINST usr/include/linux/mpls_iptunnel.h
  HDRINST usr/include/linux/zorro.h
  HDRINST usr/include/linux/hsi/cs-protocol.h
  HDRINST usr/include/linux/hsi/hsi_char.h
  HDRINST usr/include/linux/ip6_tunnel.h
  HDRINST usr/include/linux/atmclip.h
  HDRINST usr/include/linux/magic.h
  HDRINST usr/include/linux/ivtv.h
  HDRINST usr/include/linux/udp.h
  HDRINST usr/include/linux/in6.h
  HDRINST usr/include/linux/scif_ioctl.h
  HDRINST usr/include/linux/mount.h
  HDRINST usr/include/linux/atm_idt77105.h
  HDRINST usr/include/linux/openat2.h
  HDRINST usr/include/linux/if_bonding.h
  HDRINST usr/include/linux/time_types.h
  HDRINST usr/include/linux/auto_dev-ioctl.h
  HDRINST usr/include/linux/max2175.h
  HDRINST usr/include/linux/nfs4.h
  HDRINST usr/include/linux/virtio_vsock.h
  HDRINST usr/include/linux/atmdev.h
  HDRINST usr/include/linux/virtio_fs.h
  HDRINST usr/include/linux/ip_vs.h
  HDRINST usr/include/linux/watch_queue.h
  HDRINST usr/include/linux/fiemap.h
  HDRINST usr/include/linux/l2tp.h
  HDRINST usr/include/linux/ppp-comp.h
  HDRINST usr/include/linux/vdpa.h
  HDRINST usr/include/linux/poll.h
  HDRINST usr/include/linux/radeonfb.h
  HDRINST usr/include/linux/genwqe/genwqe_card.h
  HDRINST usr/include/linux/netfilter_arp.h
  HDRINST usr/include/linux/cxl_mem.h
  HDRINST usr/include/linux/atm.h
  HDRINST usr/include/linux/atm_he.h
  HDRINST usr/include/linux/qrtr.h
  HDRINST usr/include/linux/target_core_user.h
  HDRINST usr/include/linux/am437x-vpfe.h
  HDRINST usr/include/linux/dlm.h
  HDRINST usr/include/linux/lightnvm.h
  HDRINST usr/include/linux/fd.h
  HDRINST usr/include/linux/const.h
  HDRINST usr/include/linux/socket.h
  HDRINST usr/include/linux/gtp.h
  HDRINST usr/include/linux/udmabuf.h
  HDRINST usr/include/linux/sched.h
  HDRINST usr/include/linux/omapfb.h
  HDRINST usr/include/linux/blkpg.h
  HDRINST usr/include/linux/surface_aggregator/cdev.h
  HDRINST usr/include/linux/surface_aggregator/dtx.h
  HDRINST usr/include/linux/string.h
  HDRINST usr/include/linux/cm4000_cs.h
  HDRINST usr/include/linux/i2o-dev.h
  HDRINST usr/include/linux/virtio_mmio.h
  HDRINST usr/include/linux/close_range.h
  HDRINST usr/include/linux/serial_reg.h
  HDRINST usr/include/linux/dvb/dmx.h
  HDRINST usr/include/linux/dvb/frontend.h
  HDRINST usr/include/linux/dvb/version.h
  HDRINST usr/include/linux/dvb/ca.h
  HDRINST usr/include/linux/dvb/net.h
  HDRINST usr/include/linux/netfilter_ipv4.h
  HDRINST usr/include/linux/audit.h
  HDRINST usr/include/linux/baycom.h
  HDRINST usr/include/linux/arm_sdei.h
  HDRINST usr/include/linux/virtio_ids.h
  HDRINST usr/include/linux/vfio_zdev.h
  HDRINST usr/include/linux/synclink.h
  HDRINST usr/include/linux/libc-compat.h
  HDRINST usr/include/linux/watchdog.h
  HDRINST usr/include/linux/posix_types.h
  HDRINST usr/include/linux/nfs_idmap.h
  HDRINST usr/include/linux/pktcdvd.h
  HDRINST usr/include/linux/times.h
  HDRINST usr/include/linux/capability.h
  HDRINST usr/include/linux/perf_event.h
  HDRINST usr/include/linux/atm_tcp.h
  HDRINST usr/include/linux/virtio_config.h
  HDRINST usr/include/linux/fs.h
  HDRINST usr/include/linux/qemu_fw_cfg.h
  HDRINST usr/include/linux/wait.h
  HDRINST usr/include/linux/ipmi.h
  HDRINST usr/include/linux/falloc.h
  HDRINST usr/include/linux/hid.h
  HDRINST usr/include/linux/virtio_scsi.h
  HDRINST usr/include/linux/seg6_genl.h
  HDRINST usr/include/linux/pr.h
  HDRINST usr/include/linux/wmi.h
  HDRINST usr/include/linux/elf-em.h
  HDRINST usr/include/linux/usbdevice_fs.h
  HDRINST usr/include/linux/coff.h
  HDRINST usr/include/linux/hidraw.h
  HDRINST usr/include/linux/membarrier.h
  HDRINST usr/include/linux/bpf_perf_event.h
  HDRINST usr/include/linux/smiapp.h
  HDRINST usr/include/linux/tls.h
  HDRINST usr/include/linux/if_team.h
  HDRINST usr/include/linux/misc/bcm_vk.h
  HDRINST usr/include/linux/sonet.h
  HDRINST usr/include/linux/if_ether.h
  HDRINST usr/include/linux/fb.h
  HDRINST usr/include/linux/i8k.h
  HDRINST usr/include/linux/tipc_config.h
  HDRINST usr/include/linux/rio_mport_cdev.h
  HDRINST usr/include/linux/netfilter_ipv6.h
  HDRINST usr/include/linux/bt-bmc.h
  HDRINST usr/include/linux/gsmmux.h
  HDRINST usr/include/linux/firewire-cdev.h
  HDRINST usr/include/linux/parport.h
  HDRINST usr/include/linux/aspeed-p2a-ctrl.h
  HDRINST usr/include/linux/input.h
  HDRINST usr/include/linux/nilfs2_ondisk.h
  HDRINST usr/include/linux/tty.h
  HDRINST usr/include/linux/unistd.h
  HDRINST usr/include/linux/if_cablemodem.h
  HDRINST usr/include/linux/ioctl.h
  HDRINST usr/include/linux/atmlec.h
  HDRINST usr/include/linux/filter.h
  HDRINST usr/include/linux/ivtvfb.h
  HDRINST usr/include/linux/vt.h
  HDRINST usr/include/linux/if.h
  HDRINST usr/include/linux/if_arp.h
  HDRINST usr/include/linux/if_plip.h
  HDRINST usr/include/linux/cryptouser.h
  HDRINST usr/include/linux/pcitest.h
  HDRINST usr/include/linux/kdev_t.h
  HDRINST usr/include/linux/media-bus-format.h
  HDRINST usr/include/linux/ipx.h
  HDRINST usr/include/linux/hyperv.h
  HDRINST usr/include/linux/snmp.h
  HDRINST usr/include/linux/igmp.h
  HDRINST usr/include/linux/ipv6_route.h
  HDRINST usr/include/linux/gfs2_ondisk.h
  HDRINST usr/include/linux/if_bridge.h
  HDRINST usr/include/linux/virtio_pci.h
  HDRINST usr/include/linux/llc.h
  HDRINST usr/include/linux/pci_regs.h
  HDRINST usr/include/linux/pfkeyv2.h
  HDRINST usr/include/linux/can.h
  HDRINST usr/include/linux/rds.h
  HDRINST usr/include/linux/seccomp.h
  HDRINST usr/include/linux/a.out.h
  HDRINST usr/include/linux/mqueue.h
  HDRINST usr/include/linux/auxvec.h
  HDRINST usr/include/linux/vmcore.h
  HDRINST usr/include/linux/fib_rules.h
  HDRINST usr/include/linux/kfd_ioctl.h
  HDRINST usr/include/linux/coresight-stm.h
  HDRINST usr/include/linux/patchkey.h
  HDRINST usr/include/linux/chio.h
  HDRINST usr/include/linux/prctl.h
  HDRINST usr/include/linux/cramfs_fs.h
  HDRINST usr/include/linux/android/binder.h
  HDRINST usr/include/linux/android/binderfs.h
  HDRINST usr/include/linux/resource.h
  HDRINST usr/include/linux/xdp_diag.h
  HDRINST usr/include/linux/dns_resolver.h
  HDRINST usr/include/linux/hsr_netlink.h
  HDRINST usr/include/linux/if_arcnet.h
  HDRINST usr/include/linux/auto_fs4.h
  HDRINST usr/include/linux/if_infiniband.h
  HDRINST usr/include/linux/sysctl.h
  HDRINST usr/include/linux/mroute6.h
  HDRINST usr/include/linux/dccp.h
  HDRINST usr/include/linux/pg.h
  HDRINST usr/include/linux/kcov.h
  HDRINST usr/include/linux/caif/caif_socket.h
  HDRINST usr/include/linux/caif/if_caif.h
  HDRINST usr/include/linux/errqueue.h
  HDRINST usr/include/linux/virtio_blk.h
  HDRINST usr/include/linux/dlm_netlink.h
  HDRINST usr/include/linux/limits.h
  HDRINST usr/include/linux/aspeed-lpc-ctrl.h
  HDRINST usr/include/linux/v4l2-subdev.h
  HDRINST usr/include/linux/fanotify.h
  HDRINST usr/include/linux/bpfilter.h
  HDRINST usr/include/linux/minix_fs.h
  HDRINST usr/include/linux/signal.h
  HDRINST usr/include/linux/stm.h
  HDRINST usr/include/linux/qnx4_fs.h
  HDRINST usr/include/linux/scc.h
  HDRINST usr/include/linux/devlink.h
  HDRINST usr/include/linux/f2fs.h
  HDRINST usr/include/linux/serial.h
  HDRINST usr/include/linux/ip.h
  HDRINST usr/include/linux/hw_breakpoint.h
  HDRINST usr/include/linux/ultrasound.h
  HDRINST usr/include/linux/netlink.h
  HDRINST usr/include/linux/vfio.h
  HDRINST usr/include/linux/hdlc/ioctl.h
  HDRINST usr/include/linux/virtio_pmem.h
  HDRINST usr/include/linux/bpf.h
  HDRINST usr/include/linux/screen_info.h
  HDRINST usr/include/linux/genetlink.h
  HDRINST usr/include/linux/gpio.h
  HDRINST usr/include/linux/nexthop.h
  HDRINST usr/include/linux/timerfd.h
  HDRINST usr/include/linux/adb.h
  HDRINST usr/include/linux/phonet.h
  HDRINST usr/include/linux/uio.h
  HDRINST usr/include/linux/atmbr2684.h
  HDRINST usr/include/linux/ncsi.h
  HDRINST usr/include/linux/sound.h
  HDRINST usr/include/linux/vhost.h
  HDRINST usr/include/linux/ipmi_bmc.h
  HDRINST usr/include/linux/netfilter_decnet.h
  HDRINST usr/include/linux/pidfd.h
  HDRINST usr/include/linux/fsl_hypervisor.h
  HDRINST usr/include/linux/serio.h
  HDRINST usr/include/linux/seg6.h
  HDRINST usr/include/linux/sync_file.h
  HDRINST usr/include/linux/jffs2.h
  HDRINST usr/include/linux/mroute.h
  HDRINST usr/include/linux/tc_act/tc_skbmod.h
  HDRINST usr/include/linux/tc_act/tc_defact.h
  HDRINST usr/include/linux/tc_act/tc_mpls.h
  HDRINST usr/include/linux/tc_act/tc_ipt.h
  HDRINST usr/include/linux/tc_act/tc_gact.h
  HDRINST usr/include/linux/tc_act/tc_ct.h
  HDRINST usr/include/linux/tc_act/tc_bpf.h
  HDRINST usr/include/linux/tc_act/tc_nat.h
  HDRINST usr/include/linux/tc_act/tc_ctinfo.h
  HDRINST usr/include/linux/tc_act/tc_vlan.h
  HDRINST usr/include/linux/tc_act/tc_tunnel_key.h
  HDRINST usr/include/linux/tc_act/tc_csum.h
  HDRINST usr/include/linux/tc_act/tc_connmark.h
  HDRINST usr/include/linux/tc_act/tc_sample.h
  HDRINST usr/include/linux/tc_act/tc_mirred.h
  HDRINST usr/include/linux/tc_act/tc_gate.h
  HDRINST usr/include/linux/tc_act/tc_ife.h
  HDRINST usr/include/linux/tc_act/tc_skbedit.h
  HDRINST usr/include/linux/tc_act/tc_pedit.h
  HDRINST usr/include/linux/sem.h
  HDRINST usr/include/linux/if_alg.h
  HDRINST usr/include/linux/soundcard.h
  HDRINST usr/include/linux/if_tun.h
  HDRINST usr/include/linux/kernel-page-flags.h
  HDRINST usr/include/linux/virtio_gpu.h
  HDRINST usr/include/linux/dqblk_xfs.h
  HDRINST usr/include/linux/btrfs.h
  HDRINST usr/include/linux/userio.h
  HDRINST usr/include/linux/nfs_mount.h
  HDRINST usr/include/linux/openvswitch.h
  HDRINST usr/include/linux/quota.h
  HDRINST usr/include/linux/icmp.h
  HDRINST usr/include/linux/selinux_netlink.h
  HDRINST usr/include/linux/dcbnl.h
  HDRINST usr/include/linux/in_route.h
  HDRINST usr/include/linux/pci.h
  HDRINST usr/include/linux/vbox_vmmdev_types.h
  HDRINST usr/include/linux/wireless.h
  HDRINST usr/include/linux/binfmts.h
  HDRINST usr/include/linux/rfkill.h
  HDRINST usr/include/linux/sockios.h
  HDRINST usr/include/linux/blktrace_api.h
  HDRINST usr/include/linux/posix_acl_xattr.h
  HDRINST usr/include/linux/btf.h
  HDRINST usr/include/linux/mtio.h
  HDRINST usr/include/linux/netrom.h
  HDRINST usr/include/linux/dm-ioctl.h
  HDRINST usr/include/linux/tty_flags.h
  HDRINST usr/include/linux/aio_abi.h
  HDRINST usr/include/linux/tipc_netlink.h
  HDRINST usr/include/linux/psci.h
  HDRINST usr/include/linux/ndctl.h
  HDRINST usr/include/linux/fpga-dfl.h
  HDRINST usr/include/linux/joystick.h
  HDRINST usr/include/linux/tee.h
  HDRINST usr/include/linux/veth.h
  HDRINST usr/include/linux/ethtool.h
  HDRINST usr/include/linux/vm_sockets_diag.h
  HDRINST usr/include/linux/omap3isp.h
  HDRINST usr/include/sound/sfnt_info.h
  HDRINST usr/include/sound/skl-tplg-interface.h
  HDRINST usr/include/sound/compress_offload.h
  HDRINST usr/include/sound/firewire.h
  HDRINST usr/include/sound/asequencer.h
  HDRINST usr/include/sound/hdsp.h
  HDRINST usr/include/sound/emu10k1.h
  HDRINST usr/include/sound/sb16_csp.h
  HDRINST usr/include/sound/snd_sst_tokens.h
  HDRINST usr/include/sound/asoc.h
  HDRINST usr/include/sound/asound.h
  HDRINST usr/include/sound/compress_params.h
  HDRINST usr/include/sound/usb_stream.h
  HDRINST usr/include/sound/tlv.h
  HDRINST usr/include/sound/hdspm.h
  HDRINST usr/include/sound/sof/abi.h
  HDRINST usr/include/sound/sof/header.h
  HDRINST usr/include/sound/sof/tokens.h
  HDRINST usr/include/sound/sof/fw.h
  HDRINST usr/include/sound/asound_fm.h
  HDRINST usr/include/scsi/scsi_netlink.h
  HDRINST usr/include/scsi/fc/fc_ns.h
  HDRINST usr/include/scsi/fc/fc_fs.h
  HDRINST usr/include/scsi/fc/fc_els.h
  HDRINST usr/include/scsi/fc/fc_gs.h
  HDRINST usr/include/scsi/scsi_netlink_fc.h
  HDRINST usr/include/scsi/scsi_bsg_ufs.h
  HDRINST usr/include/scsi/cxlflash_ioctl.h
  HDRINST usr/include/scsi/scsi_bsg_fc.h
  HDRINST usr/include/linux/version.h
  HDRINST usr/include/asm/mce.h
  HDRINST usr/include/asm/ist.h
  HDRINST usr/include/asm/sembuf.h
  HDRINST usr/include/asm/msgbuf.h
  HDRINST usr/include/asm/stat.h
  HDRINST usr/include/asm/processor-flags.h
  HDRINST usr/include/asm/boot.h
  HDRINST usr/include/asm/sgx.h
  HDRINST usr/include/asm/kvm_para.h
  HDRINST usr/include/asm/ldt.h
  HDRINST usr/include/asm/byteorder.h
  HDRINST usr/include/asm/hwcap2.h
  HDRINST usr/include/asm/debugreg.h
  HDRINST usr/include/asm/posix_types_x32.h
  HDRINST usr/include/asm/shmbuf.h
  HDRINST usr/include/asm/mman.h
  HDRINST usr/include/asm/perf_regs.h
  HDRINST usr/include/asm/ptrace.h
  HDRINST usr/include/asm/swab.h
  HDRINST usr/include/asm/vm86.h
  HDRINST usr/include/asm/kvm.h
  HDRINST usr/include/asm/siginfo.h
  HDRINST usr/include/asm/posix_types.h
  HDRINST usr/include/asm/sigcontext.h
  HDRINST usr/include/asm/ptrace-abi.h
  HDRINST usr/include/asm/vmx.h
  HDRINST usr/include/asm/unistd.h
  HDRINST usr/include/asm/setup.h
  HDRINST usr/include/asm/mtrr.h
  HDRINST usr/include/asm/svm.h
  HDRINST usr/include/asm/vsyscall.h
  HDRINST usr/include/asm/a.out.h
  HDRINST usr/include/asm/bootparam.h
  HDRINST usr/include/asm/e820.h
  HDRINST usr/include/asm/auxvec.h
  HDRINST usr/include/asm/posix_types_32.h
  HDRINST usr/include/asm/prctl.h
  HDRINST usr/include/asm/ucontext.h
  HDRINST usr/include/asm/sigcontext32.h
  HDRINST usr/include/asm/signal.h
  HDRINST usr/include/asm/posix_types_64.h
  HDRINST usr/include/asm/hw_breakpoint.h
  HDRINST usr/include/asm/kvm_perf.h
  HDRINST usr/include/asm/bitsperlong.h
  HDRINST usr/include/asm/msr.h
  HDRINST usr/include/asm/statfs.h
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
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867'
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867/tools/testing/selftests/net/mptcp'
2021-09-06 14:54:51 make run_tests -C net/mptcp
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867/tools/testing/selftests/net/mptcp'
make --no-builtin-rules ARCH=x86 -C ../../../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867'
  INSTALL ./usr/include
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867'
TAP version 13
1..6
# selftests: net/mptcp: mptcp_connect.sh
# INFO: set ns3-61362bbd-m5KpnS dev ns3eth2: ethtool -K tso off gso off
# Created /tmp/tmp.j9XKdVjbH4 (size 1268764	/tmp/tmp.j9XKdVjbH4) containing data sent by client
# Created /tmp/tmp.89p9h8oMQI (size 7760924	/tmp/tmp.89p9h8oMQI) containing data sent by server
# New MPTCP socket can be blocked via sysctl		[ OK ]
# setsockopt(..., TCP_ULP, "mptcp", ...) blocked	[ OK ]
# INFO: validating network environment with pings
# INFO: Using loss of 0.53% delay 18 ms reorder 95% 39% with delay 4ms on ns3eth4
# ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP	(duration   795ms) [ OK ]
# ns1 MPTCP -> ns1 (10.0.1.1:10001      ) TCP  	(duration   475ms) [ OK ]
# ns1 TCP   -> ns1 (10.0.1.1:10002      ) MPTCP	(duration   446ms) [ OK ]
# ns1 MPTCP -> ns1 (dead:beef:1::1:10003) MPTCP	(duration   480ms) [ OK ]
# ns1 MPTCP -> ns1 (dead:beef:1::1:10004) TCP  	(duration   450ms) [ OK ]
# ns1 TCP   -> ns1 (dead:beef:1::1:10005) MPTCP	(duration   432ms) [ OK ]
# ns1 MPTCP -> ns2 (10.0.1.2:10006      ) MPTCP	(duration   633ms) [ OK ]
# ns1 MPTCP -> ns2 (dead:beef:1::2:10007) MPTCP	(duration   629ms) [ OK ]
# ns1 MPTCP -> ns2 (10.0.2.1:10008      ) MPTCP	(duration   428ms) [ OK ]
# ns1 MPTCP -> ns2 (dead:beef:2::1:10009) MPTCP	(duration   482ms) [ OK ]
# ns1 MPTCP -> ns3 (10.0.2.2:10010      ) MPTCP	(duration  1152ms) [ OK ]
# ns1 MPTCP -> ns3 (dead:beef:2::2:10011) MPTCP	(duration  1304ms) [ OK ]
# ns1 MPTCP -> ns3 (10.0.3.2:10012      ) MPTCP	(duration  1173ms) [ OK ]
# ns1 MPTCP -> ns3 (dead:beef:3::2:10013) MPTCP	(duration  1323ms) [ OK ]
# ns1 MPTCP -> ns4 (10.0.3.1:10014      ) MPTCP	(duration  1292ms) [ OK ]
# ns1 MPTCP -> ns4 (dead:beef:3::1:10015) MPTCP	(duration  1621ms) [ OK ]
# ns2 MPTCP -> ns1 (10.0.1.1:10016      ) MPTCP	(duration   429ms) [ OK ]
# ns2 MPTCP -> ns1 (dead:beef:1::1:10017) MPTCP	(duration   482ms) [ OK ]
# ns2 MPTCP -> ns3 (10.0.2.2:10018      ) MPTCP	(duration   935ms) [ OK ]
# ns2 MPTCP -> ns3 (dead:beef:2::2:10019) MPTCP	(duration  1040ms) [ OK ]
# ns2 MPTCP -> ns3 (10.0.3.2:10020      ) MPTCP	(duration  1259ms) [ OK ]
# ns2 MPTCP -> ns3 (dead:beef:3::2:10021) MPTCP	(duration  1130ms) [ OK ]
# ns2 MPTCP -> ns4 (10.0.3.1:10022      ) MPTCP	(duration  1031ms) [ OK ]
# ns2 MPTCP -> ns4 (dead:beef:3::1:10023) MPTCP	(duration  1209ms) [ OK ]
# ns3 MPTCP -> ns1 (10.0.1.1:10024      ) MPTCP	(duration   479ms) [ OK ]
# ns3 MPTCP -> ns1 (dead:beef:1::1:10025) MPTCP	(duration   543ms) [ OK ]
# ns3 MPTCP -> ns2 (10.0.1.2:10026      ) MPTCP	(duration   454ms) [ OK ]
# ns3 MPTCP -> ns2 (dead:beef:1::2:10027) MPTCP	(duration  5182ms) [ OK ]
# ns3 MPTCP -> ns2 (10.0.2.1:10028      ) MPTCP	(duration   446ms) [ OK ]
# ns3 MPTCP -> ns2 (dead:beef:2::1:10029) MPTCP	(duration   950ms) [ OK ]
# ns3 MPTCP -> ns4 (10.0.3.1:10030      ) MPTCP	(duration   440ms) [ OK ]
# ns3 MPTCP -> ns4 (dead:beef:3::1:10031) MPTCP	(duration   492ms) [ OK ]
# ns4 MPTCP -> ns1 (10.0.1.1:10032      ) MPTCP	(duration   473ms) [ OK ]
# ns4 MPTCP -> ns1 (dead:beef:1::1:10033) MPTCP	(duration   761ms) [ OK ]
# ns4 MPTCP -> ns2 (10.0.1.2:10034      ) MPTCP	(duration   496ms) [ OK ]
# ns4 MPTCP -> ns2 (dead:beef:1::2:10035) MPTCP	(duration  4897ms) [ OK ]
# ns4 MPTCP -> ns2 (10.0.2.1:10036      ) MPTCP	(duration   532ms) [ OK ]
# ns4 MPTCP -> ns2 (dead:beef:2::1:10037) MPTCP	(duration  2560ms) [ OK ]
# ns4 MPTCP -> ns3 (10.0.2.2:10038      ) MPTCP	(duration   442ms) [ OK ]
# ns4 MPTCP -> ns3 (dead:beef:2::2:10039) MPTCP	(duration   491ms) [ OK ]
# ns4 MPTCP -> ns3 (10.0.3.2:10040      ) MPTCP	(duration   439ms) [ OK ]
# ns4 MPTCP -> ns3 (dead:beef:3::2:10041) MPTCP	(duration   532ms) [ OK ]
# INFO: with peek mode: saveWithPeek
# ns1 MPTCP -> ns1 (10.0.1.1:10042      ) MPTCP	(duration   503ms) [ OK ]
# ns1 MPTCP -> ns1 (10.0.1.1:10043      ) TCP  	(duration   293ms) [ OK ]
# ns1 TCP   -> ns1 (10.0.1.1:10044      ) MPTCP	(duration   281ms) [ OK ]
# ns1 MPTCP -> ns1 (dead:beef:1::1:10045) MPTCP	(duration   276ms) [ OK ]
# ns1 MPTCP -> ns1 (dead:beef:1::1:10046) TCP  	(duration   298ms) [ OK ]
# ns1 TCP   -> ns1 (dead:beef:1::1:10047) MPTCP	(duration   285ms) [ OK ]
# INFO: with peek mode: saveAfterPeek
# ns1 MPTCP -> ns1 (10.0.1.1:10048      ) MPTCP	(duration   279ms) [ OK ]
# ns1 MPTCP -> ns1 (10.0.1.1:10049      ) TCP  	(duration   292ms) [ OK ]
# ns1 TCP   -> ns1 (10.0.1.1:10050      ) MPTCP	(duration   276ms) [ OK ]
# ns1 MPTCP -> ns1 (dead:beef:1::1:10051) MPTCP	(duration   279ms) [ OK ]
# ns1 MPTCP -> ns1 (dead:beef:1::1:10052) TCP  	(duration   296ms) [ OK ]
# ns1 TCP   -> ns1 (dead:beef:1::1:10053) MPTCP	(duration   284ms) [ OK ]
# Time: 133 seconds
ok 1 selftests: net/mptcp: mptcp_connect.sh
# selftests: net/mptcp: pm_netlink.sh
# defaults addr list                                 [ OK ]
# defaults limits                                    [ OK ]
# simple add/get addr                                [ OK ]
# dump addrs                                         [ OK ]
# simple del addr                                    [ OK ]
# dump addrs after del                               [ OK ]
# duplicate addr                                     [ OK ]
# id addr increment                                  [ OK ]
# hard addr limit                                    [ OK ]
# above hard addr limit                              [ OK ]
# id limit                                           [ OK ]
# flush addrs                                        [ OK ]
# rcv addrs above hard limit                         [ OK ]
# subflows above hard limit                          [ OK ]
# set limits                                         [ OK ]
# set ids                                            [ OK ]
# wrap-around ids                                    [ OK ]
ok 2 selftests: net/mptcp: pm_netlink.sh
# selftests: net/mptcp: mptcp_join.sh
# Created /tmp/tmp.hmz5XarEJv (size 1 KB) containing data sent by client
# Created /tmp/tmp.GTVVohoN8T (size 1 KB) containing data sent by server
# 01 no JOIN                              syn[ ok ] - synack[ ok ] - ack[ ok ]
# 02 single subflow, limited by client    syn[ ok ] - synack[ ok ] - ack[ ok ]
# 03 single subflow, limited by server    syn[ ok ] - synack[ ok ] - ack[ ok ]
# 04 single subflow                       syn[ ok ] - synack[ ok ] - ack[ ok ]
# 05 multiple subflows                    syn[ ok ] - synack[ ok ] - ack[ ok ]
# 06 multiple subflows, limited by server syn[ ok ] - synack[ ok ] - ack[ ok ]
# 07 single subflow, dev                  syn[ ok ] - synack[ ok ] - ack[ ok ]
# 08 unused signal address                syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 09 signal address                       syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 10 subflow and signal                   syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 11 multiple subflows and signal         syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 12 signal addresses                     syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 13 signal invalid addresses             syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# Created /tmp/tmp.hmz5XarEJv (size 93440 KB) containing data sent by client
# 14 multiple flows, signal, link failure syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 15 signal address, ADD_ADDR timeout     syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 16 signal address, ADD_ADDR6 timeout    syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 17 signal addresses, ADD_ADDR timeout   syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 18 invalid address, ADD_ADDR timeout    syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 19 remove single subflow                syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 20 remove multiple subflows             syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 21 remove single address                syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 22 remove subflow and signal            syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 23 remove subflows and signal           syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 24 remove addresses                     syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 25 remove invalid addresses             syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 26 flush subflows and signal            syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 27 flush subflows                       syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 28 flush addresses                      syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 29 flush invalid addresses              syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 30 remove id 0 subflow                  syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 31 remove id 0 address                  syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 32 add single subflow                   syn[ ok ] - synack[ ok ] - ack[ ok ]
# 33 add signal address                   syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 34 add multiple subflows                syn[ ok ] - synack[ ok ] - ack[ ok ]
# 35 add multiple subflows IPv6           syn[ ok ] - synack[ ok ] - ack[ ok ]
# 36 add multiple addresses IPv6          syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [fail] got 1 ADD_ADDR echo[s] expected 2
# 
# Server ns stats
# MPTcpExtMPCapableSYNRX          1                  0.0
# MPTcpExtMPCapableACKRX          1                  0.0
# MPTcpExtMPJoinSynRx             2                  0.0
# MPTcpExtMPJoinAckRx             2                  0.0
# MPTcpExtEchoAdd                 1                  0.0
# Client ns stats
# MPTcpExtMPCapableSYNTX          1                  0.0
# MPTcpExtMPCapableSYNACKRX       1                  0.0
# MPTcpExtMPJoinSynAckRx          2                  0.0
# MPTcpExtAddAddr                 2                  0.0
# 37 single subflow IPv6                  syn[ ok ] - synack[ ok ] - ack[ ok ]
# 38 unused signal address IPv6           syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 39 single address IPv6                  syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 40 remove single address IPv6           syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 41 remove subflow and signal IPv6       syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 42 single subflow IPv4-mapped           syn[ ok ] - synack[ ok ] - ack[ ok ]
# 43 signal address IPv4-mapped           syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 44 single subflow v4-map-v6             syn[ ok ] - synack[ ok ] - ack[ ok ]
# 45 signal address v4-map-v6             syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 46 single subflow v6-map-v4             syn[ ok ] - synack[ ok ] - ack[ ok ]
# 47 signal address v6-map-v4             syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 48 no JOIN with diff families v4-v6     syn[ ok ] - synack[ ok ] - ack[ ok ]
# 49 no JOIN with diff families v4-v6-2   syn[ ok ] - synack[ ok ] - ack[ ok ]
# 50 no JOIN with diff families v6-v4     syn[ ok ] - synack[ ok ] - ack[ ok ]
# 51 single subflow, backup               syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         ptx[ ok ] - prx   [ ok ]
# 52 single address, backup               syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
#                                         ptx[ ok ] - prx   [ ok ]
# 53 signal address with port             syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ] - pt [ ok ]
#                                         syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         syn[ ok ] - ack   [ ok ]
# 54 subflow and signal with port         syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ] - pt [ ok ]
#                                         syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         syn[ ok ] - ack   [ ok ]
# 55 remove single address with port      syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ] - pt [ ok ]
#                                         syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         syn[ ok ] - ack   [ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 56 remove subflow and signal with port  syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ] - pt [ ok ]
#                                         syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         syn[ ok ] - ack   [ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 57 flush subflows and signal with port  syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 58 multiple addresses with port         syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ] - pt [ ok ]
#                                         syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         syn[ ok ] - ack   [ ok ]
# 59 multiple addresses with ports        syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ] - pt [ ok ]
#                                         syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         syn[ ok ] - ack   [ ok ]
# 60 single subflow with syn cookies      syn[ ok ] - synack[ ok ] - ack[ ok ]
# 61 multiple subflows with syn cookies   syn[ ok ] - synack[ ok ] - ack[ ok ]
# 62 subflows limited by server w cookies syn[ ok ] - synack[ ok ] - ack[ ok ]
# 63 signal address with syn cookies      syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 64 subflow and signal w cookies         syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 65 subflows and signal w. cookies       syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
#
not ok 3 selftests: net/mptcp: mptcp_join.sh # TIMEOUT 600 seconds
# selftests: net/mptcp: diag.sh
# no msk on netns creation                          [  ok  ]
# after MPC handshake                               [  ok  ]
# ....chk remote_key                                [  ok  ]
# ....chk no fallback                               [  ok  ]
# check fallback                                    [  ok  ]
# many msk socket present                           [  ok  ]
ok 4 selftests: net/mptcp: diag.sh
# selftests: net/mptcp: simult_flows.sh
# balanced bwidth                                     4674 max 5005 [ OK ]
# balanced bwidth - reverse direction                 4642 max 5005 [ OK ]
# balanced bwidth with unbalanced delay               4643 max 5005 [ OK ]
# balanced bwidth with unbalanced delay - reverse direction  4645 max 5005 [ OK ]
# unbalanced bwidth                                   3024 max 3245 [ OK ]
# unbalanced bwidth - reverse direction               3095 max 3245 [ OK ]
# unbalanced bwidth with unbalanced delay             3199 max 3245 [ OK ]
# unbalanced bwidth with unbalanced delay - reverse direction  3026 max 3245 [ OK ]
# unbalanced bwidth with opposed, unbalanced delay    3115 max 3245 [ OK ]
# unbalanced bwidth with opposed, unbalanced delay - reverse direction  3056 max 3245 [ OK ]
ok 5 selftests: net/mptcp: simult_flows.sh
# selftests: net/mptcp: mptcp_sockopt.sh
# Created /tmp/tmp.lNuwYVM4uY (size 1 KB) containing data sent by client
# Created /tmp/tmp.WibeqPcNW6 (size 1 KB) containing data sent by server
# PASS: all packets had packet mark set
ok 6 selftests: net/mptcp: mptcp_sockopt.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867/tools/testing/selftests/net/mptcp'



To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install                job.yaml  # job file is attached in this email
        bin/lkp split-job --compatible job.yaml  # generate the yaml file for lkp run
        bin/lkp run                    generated-yaml-file



---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation

Thanks,
Oliver Sang


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.14.0-rc1-00300-g9d3684c24a52"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.14.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-22) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23502
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23502
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
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
# CONFIG_USELIB is not set
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

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
# CONFIG_BPF_PRELOAD is not set
CONFIG_BPF_LSM=y
# end of BPF subsystem

# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_DYNAMIC=y
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
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
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_MISC is not set
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
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
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
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
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
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_AUDIT_ARCH=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
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
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
# CONFIG_XEN_PV is not set
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
# CONFIG_GART_IOMMU is not set
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
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
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
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
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
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y

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
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
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
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
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
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
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
CONFIG_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_PRMT=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
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
# CONFIG_X86_PCC_CPUFREQ is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
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
# CONFIG_ISCSI_IBFT is not set
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
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=y
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=y
# CONFIG_X86_SGX_KVM is not set
CONFIG_KVM_AMD=y
# CONFIG_KVM_XEN is not set
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
CONFIG_ARCH_WANTS_NO_INSTR=y
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
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
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
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
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
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
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
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y

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
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
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
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_FC_APPID is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
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
CONFIG_MQ_IOSCHED_DEADLINE_CGROUP=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
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
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
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
# CONFIG_CMA is not set
# CONFIG_MEM_SOFT_DIRTY is not set
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
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_TEST=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
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
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
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
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
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
CONFIG_INET6_ESP_OFFLOAD=m
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
# CONFIG_NETFILTER_NETLINK_HOOK is not set
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
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
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
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
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_FLOW_OFFLOAD=m
CONFIG_NFT_COUNTER=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
CONFIG_NETFILTER_XTABLES=y
CONFIG_NETFILTER_XTABLES_COMPAT=y

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
# CONFIG_NETFILTER_XT_TARGET_LED is not set
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
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
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
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
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
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

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
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_FLOW_TABLE_IPV4=m
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
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
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
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
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
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
# CONFIG_IP6_NF_TARGET_HL is not set
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
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
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
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
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
# CONFIG_6LOWPAN_NHC is not set
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
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_SCH_PLUG=m
CONFIG_NET_SCH_ETS=m
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

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
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
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
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_ETAS_ES58X is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
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
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_MSFTEXT is not set
# CONFIG_BT_AOSPEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
# CONFIG_BT_HCIBTUSB is not set
# CONFIG_BT_HCIBTSDIO is not set
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBPA10X is not set
# CONFIG_BT_HCIBFUSB is not set
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
# CONFIG_BT_MRVL_SDIO is not set
# CONFIG_BT_MTKSDIO is not set
# CONFIG_BT_VIRTIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
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
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
CONFIG_NFC=m
# CONFIG_NFC_DIGITAL is not set
CONFIG_NFC_NCI=m
# CONFIG_NFC_NCI_SPI is not set
# CONFIG_NFC_NCI_UART is not set
# CONFIG_NFC_HCI is not set

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_VIRTUAL_NCI=m
# CONFIG_NFC_FDP is not set
# CONFIG_NFC_PN533_USB is not set
# CONFIG_NFC_PN533_I2C is not set
# CONFIG_NFC_MRVL_USB is not set
# CONFIG_NFC_ST_NCI_I2C is not set
# CONFIG_NFC_ST_NCI_SPI is not set
# CONFIG_NFC_NXP_NCI is not set
# CONFIG_NFC_S3FWRN5_I2C is not set
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=m
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

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
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
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

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
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

CONFIG_ALLOW_DEV_COREDUMP=y
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
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=m
CONFIG_ZRAM_DEF_COMP_LZORLE=y
# CONFIG_ZRAM_DEF_COMP_LZO is not set
CONFIG_ZRAM_DEF_COMP="lzo-rle"
CONFIG_ZRAM_WRITEBACK=y
# CONFIG_ZRAM_MEMORY_TRACKING is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
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
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
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
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# end of Misc devices

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
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_EFCT is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
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
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
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
# CONFIG_PATA_ACPI is not set
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
CONFIG_MD_CLUSTER=m
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
CONFIG_DM_WRITECACHE=m
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
CONFIG_DM_INTEGRITY=m
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

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
# CONFIG_BONDING is not set
CONFIG_DUMMY=y
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
CONFIG_IFB=y
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
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
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=y
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
CONFIG_NET_VRF=y
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
CONFIG_IXGBE_IPSEC=y
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_MICROSOFT_MANA is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
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
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
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
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
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
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
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
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
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
# CONFIG_MT7921E is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
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
# CONFIG_MAC80211_HWSIM is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

CONFIG_XEN_NETDEV_FRONTEND=y
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_HYPERV_NET is not set
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
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
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=y

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
CONFIG_SERIAL_8250_NR_UARTS=64
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
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
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
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
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
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
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
# CONFIG_TCG_TIS_I2C_CR50 is not set
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
# CONFIG_XILLYUSB is not set
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
CONFIG_I2C_MUX_MLXCPLD=m
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
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
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
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
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
# CONFIG_DP83640_PHY is not set
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
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=m
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
# CONFIG_GPIO_BT8XX is not set
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
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
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
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
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
CONFIG_SENSORS_I5500=m
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
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
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
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_FSP_3Y is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_DPS920AB is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2888 is not set
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_PIM4328 is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_STPDDC60 is not set
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
# CONFIG_SENSORS_SHT4x is not set
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

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

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
# CONFIG_MLX_WDT is not set
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
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
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
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
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
# CONFIG_MFD_ATC260X_I2C is not set
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
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_IR_ENE=m
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_RC_LOOPBACK=m
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
CONFIG_IR_SIR=m
# CONFIG_RC_XBOX_DVD is not set
# CONFIG_IR_TOY is not set
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
# CONFIG_CEC_GPIO is not set
# CONFIG_CEC_SECO is not set
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
CONFIG_MEDIA_SUPPORT=m
# CONFIG_MEDIA_SUPPORT_FILTER is not set
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

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
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
# end of Video4Linux options

#
# Media controller options
#
# CONFIG_MEDIA_CONTROLLER_DVB is not set
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_RADIO_ADAPTERS=y
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
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# MMC/SDIO DVB adapters
#
# CONFIG_SMS_SDIO_DRV is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
# CONFIG_DVB_FIREDTV is not set
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_TVAUDIO is not set
# CONFIG_VIDEO_TDA7432 is not set
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
# CONFIG_VIDEO_MSP3400 is not set
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
# CONFIG_VIDEO_CS53L32A is not set
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
# CONFIG_VIDEO_WM8775 is not set
# CONFIG_VIDEO_WM8739 is not set
# CONFIG_VIDEO_VP27SMPX is not set
# CONFIG_VIDEO_SONY_BTF_MPX is not set
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set
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
# CONFIG_VIDEO_SAA711X is not set
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
# CONFIG_VIDEO_SAA717X is not set
# CONFIG_VIDEO_CX25840 is not set
# end of Video decoders

#
# Video encoders
#
# CONFIG_VIDEO_SAA7127 is not set
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
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set
# end of Video improvement chips

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set
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
# CONFIG_VIDEO_M52790 is not set
# CONFIG_VIDEO_I2C is not set
# CONFIG_VIDEO_ST_MIPID02 is not set
# end of Miscellaneous helper chips

#
# Camera sensor devices
#
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_IMX208 is not set
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
# CONFIG_VIDEO_OV5648 is not set
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
# CONFIG_VIDEO_OV8865 is not set
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
# CONFIG_VIDEO_RDACM21 is not set
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
CONFIG_CXD2880_SPI_DRV=m
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
CONFIG_MEDIA_TUNER_MSI001=m
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
CONFIG_MEDIA_TUNER_MXL301RF=m
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
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_S5H1432=m
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
CONFIG_DVB_DIB9000=m
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
CONFIG_DVB_ZD1301_DEMOD=m
CONFIG_DVB_CXD2880=m

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
CONFIG_DVB_MXL692=m

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
CONFIG_DVB_MN88443X=m

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
CONFIG_DVB_LNBH29=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GL5=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
CONFIG_DVB_HORUS3A=m
CONFIG_DVB_ASCOT2E=m
CONFIG_DVB_HELENE=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
CONFIG_DVB_SP2=m
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=y
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
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
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
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
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
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=m
# CONFIG_DRM_UDL is not set
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
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_XEN_FRONTEND is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_HYPERV is not set
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
# CONFIG_FB_SSD1307 is not set
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

# CONFIG_SOUND is not set

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
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
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
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PLAYSTATION is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SONY is not set
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
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
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
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
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
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

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
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_MEMSTICK is not set
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
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
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
# CONFIG_LEDS_TRIGGER_TTY is not set
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
# CONFIG_RTC_DRV_RV3029_HWMON is not set
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
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
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
CONFIG_IRQ_BYPASS_MANAGER=y
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
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
# CONFIG_XEN_BALLOON is not set
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
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
# CONFIG_XEN_UNPOPULATED_ALLOC is not set
# end of Xen driver support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_RTL8723BS is not set
# CONFIG_R8712U is not set
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set
# CONFIG_FB_SM750 is not set
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
# end of Android

# CONFIG_LTE_GDM724X is not set
# CONFIG_FIREWIRE_SERIAL is not set
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_QLGE is not set
# CONFIG_WFX is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMC is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
# CONFIG_WIRELESS_HOTKEY is not set
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_THINKPAD_LMI is not set
CONFIG_X86_PLATFORM_DRIVERS_INTEL=y
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
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
CONFIG_INTEL_PMC_CORE=m
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Clock driver for ARM Reference designs
#
# CONFIG_ICST is not set
# CONFIG_CLK_SP810 is not set
# end of Clock driver for ARM Reference designs

# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
CONFIG_HWSPINLOCK=y

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
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
# CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y
# CONFIG_VIRTIO_IOMMU is not set

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
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
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
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_DTPM is not set
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
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
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
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
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
CONFIG_OVERLAY_FS=y
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
# CONFIG_NETFS_STATS is not set
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
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
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
CONFIG_HUGETLB_PAGE_FREE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON is not set
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
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
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
CONFIG_NFS_V4_2_SSC_HELPER=y
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
CONFIG_CIFS_STATS2=y
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
CONFIG_SECURITY_WRITABLE_HOOKS=y
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
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DISABLE=y
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
CONFIG_SECURITY_LANDLOCK=y
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
CONFIG_IMA_WRITE_POLICY=y
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
# CONFIG_IMA_DISABLE_HTABLE is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
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
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
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
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
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
CONFIG_CRYPTO_DES3_EDE_X86_64=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
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
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
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
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
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
# CONFIG_SYSTEM_REVOCATION_LIST is not set
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
CONFIG_CRC7=m
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
CONFIG_SWIOTLB=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
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
CONFIG_STACKDEPOT=y
CONFIG_STACK_HASH_ORDER=20
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
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
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
CONFIG_DEBUG_INFO_BTF=y
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_DEBUG_INFO_BTF_MODULES=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_STACK_VALIDATION=y
# CONFIG_VMLINUX_MAP is not set
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
# CONFIG_DEBUG_RODATA_TEST is not set
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
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
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
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
CONFIG_WQ_WATCHDOG=y
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
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
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
CONFIG_BUG_ON_DATA_CORRUPTION=y
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
CONFIG_HAVE_OBJTOOL_MCOUNT=y
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
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
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
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
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
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_SORT is not set
# CONFIG_TEST_DIV64 is not set
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
CONFIG_TEST_SCANF=m
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
CONFIG_TEST_FIRMWARE=y
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
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='kernel-selftests'
	export testcase='kernel-selftests'
	export category='functional'
	export kconfig='x86_64-rhel-8.3-kselftests'
	export need_memory='3G'
	export need_cpu=2
	export kernel_cmdline='sysctl.debug.test_sysctl.boot_int=1'
	export job_origin='kernel-selftests.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-knm01'
	export tbox_group='lkp-knm01'
	export submit_id='613607d420c79073cbdb7079'
	export job_file='/lkp/jobs/scheduled/lkp-knm01/kernel-selftests-mptcp-ucode=0x11-debian-10.4-x86_64-20200603.cgz-9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867-20210906-95179-1aeumc7-2.yaml'
	export id='193e230a968629234d2f6b52a04cf75b1f24c383'
	export queuer_version='/lkp-src'
	export model='Knights Mill'
	export nr_node=2
	export nr_cpu=288
	export memory='80G'
	export nr_hdd_partitions=2
	export nr_ssd_partitions=2
	export hdd_partitions='/dev/disk/by-id/ata-WDC_WD30EZRX-00SPEB0_WD-WCC4E4EK5J23-part2
/dev/disk/by-id/ata-WDC_WD30EZRX-00SPEB0_WD-WCC4E4EK5J23-part3'
	export ssd_partitions='/dev/disk/by-id/nvme-INTEL_SSDPECME016T4_CVF8709100031P6IGN-1-part1
/dev/disk/by-id/nvme-INTEL_SSDPECME016T4_CVF8709100031P6IGN-2-part1'
	export swap_partitions='LABEL=SWAP'
	export rootfs_partition='/dev/disk/by-id/ata-WDC_WD30EZRX-00SPEB0_WD-WCC4E4EK5J23-part1'
	export brand='Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz'
	export commit='9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867'
	export need_kconfig_hw='{"IGB"=>"y"}
SATA_AHCI
BLK_DEV_NVME'
	export ucode='0x11'
	export bisect_dmesg=true
	export need_kconfig='{"BLOCK"=>"y"}
{"BTRFS_FS"=>"m"}
{"EFI"=>"y"}
EFIVAR_FS
{"FTRACE"=>"y"}
{"IP_ADVANCED_ROUTER"=>"y"}
{"IP_MULTIPLE_TABLES"=>"y"}
{"MEMORY_HOTPLUG_SPARSE"=>"y"}
MEMORY_NOTIFIER_ERROR_INJECT
NOTIFIER_ERROR_INJECTION
{"RC_CORE"=>"m, v4.14-rc1"}
{"RC_DECODERS"=>"y"}
{"RC_DEVICES"=>"y"}
{"RUNTIME_TESTING_MENU"=>"y"}
{"STAGING"=>"y"}
{"SYNC_FILE"=>"y"}
TEST_FIRMWARE
{"TEST_KMOD"=>"m"}
{"TEST_LKM"=>"m"}
TEST_USER_COPY
{"TUN"=>"m"}
{"XFS_FS"=>"m"}'
	export initrds='linux_headers
linux_selftests'
	export enqueue_time='2021-09-06 20:21:41 +0800'
	export _id='613607e620c79073cbdb707a'
	export _rt='/result/kernel-selftests/mptcp-ucode=0x11/lkp-knm01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='29414d6e109d1dd7d5c7002a4078b26f08a79c1a'
	export base_commit='7d2a07b769330c34b4deabeed939325c77a7ec2f'
	export branch='linus/master'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/kernel-selftests/mptcp-ucode=0x11/lkp-knm01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867/3'
	export scheduler_version='/lkp/lkp/.src-20210906-182405'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-knm01/kernel-selftests-mptcp-ucode=0x11-debian-10.4-x86_64-20200603.cgz-9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867-20210906-95179-1aeumc7-2.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3-kselftests
branch=linus/master
commit=9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867/vmlinuz-5.14.0-rc1-00300-g9d3684c24a52
sysctl.debug.test_sysctl.boot_int=1
max_uptime=2100
RESULT_ROOT=/result/kernel-selftests/mptcp-ucode=0x11/lkp-knm01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867/modules.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867/linux-selftests.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20210707.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/kernel-selftests_20210905.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/kernel-selftests-x86_64-fb843668-1_20210905.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.13.0-09569-g8e8d9442d113'
	export repeat_to=6
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867/vmlinuz-5.14.0-rc1-00300-g9d3684c24a52'
	export dequeue_time='2021-09-06 22:49:44 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-knm01/kernel-selftests-mptcp-ucode=0x11-debian-10.4-x86_64-20200603.cgz-9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867-20210906-95179-1aeumc7-2.cgz'

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

	run_test group='mptcp' $LKP_SRC/tests/wrapper kernel-selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env group='mptcp' $LKP_SRC/stats/wrapper kernel-selftests
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

--wLAMOaPNJ0fu1fTG
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=kernel-selftests

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8.3-kselftests-9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867
2021-09-06 14:54:41 ln -sf /usr/bin/clang
2021-09-06 14:54:41 ln -sf /usr/bin/llc
2021-09-06 14:54:41 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
2021-09-06 14:54:42 make -j288 -C net/mptcp
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867/tools/testing/selftests/net/mptcp'
make --no-builtin-rules ARCH=x86 -C ../../../../.. headers_install
gcc -Wall -Wl,--no-as-needed -O2 -g  -I../../../../../usr/include    mptcp_connect.c  -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867/tools/testing/selftests/net/mptcp/mptcp_connect
gcc -Wall -Wl,--no-as-needed -O2 -g  -I../../../../../usr/include    pm_nl_ctl.c  -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867/tools/testing/selftests/net/mptcp/pm_nl_ctl
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867'
  HOSTCC  scripts/basic/fixdep
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
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  UPD     include/generated/uapi/linux/version.h
  HOSTCC  scripts/unifdef
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
  HDRINST usr/include/video/edid.h
  HDRINST usr/include/video/uvesafb.h
  HDRINST usr/include/video/sisfb.h
  HDRINST usr/include/drm/v3d_drm.h
  HDRINST usr/include/drm/vgem_drm.h
  HDRINST usr/include/drm/panfrost_drm.h
  HDRINST usr/include/drm/armada_drm.h
  HDRINST usr/include/drm/i915_drm.h
  HDRINST usr/include/drm/msm_drm.h
  HDRINST usr/include/drm/sis_drm.h
  HDRINST usr/include/drm/nouveau_drm.h
  HDRINST usr/include/drm/i810_drm.h
  HDRINST usr/include/drm/vmwgfx_drm.h
  HDRINST usr/include/drm/drm_sarea.h
  HDRINST usr/include/drm/lima_drm.h
  HDRINST usr/include/drm/omap_drm.h
  HDRINST usr/include/drm/virtgpu_drm.h
  HDRINST usr/include/drm/r128_drm.h
  HDRINST usr/include/drm/amdgpu_drm.h
  HDRINST usr/include/drm/radeon_drm.h
  HDRINST usr/include/drm/exynos_drm.h
  HDRINST usr/include/drm/mga_drm.h
  HDRINST usr/include/drm/etnaviv_drm.h
  HDRINST usr/include/drm/drm.h
  HDRINST usr/include/drm/tegra_drm.h
  HDRINST usr/include/drm/savage_drm.h
  HDRINST usr/include/drm/vc4_drm.h
  HDRINST usr/include/drm/via_drm.h
  HDRINST usr/include/drm/drm_fourcc.h
  HDRINST usr/include/drm/qxl_drm.h
  HDRINST usr/include/drm/drm_mode.h
  HDRINST usr/include/mtd/inftl-user.h
  HDRINST usr/include/mtd/mtd-user.h
  HDRINST usr/include/mtd/ubi-user.h
  HDRINST usr/include/mtd/nftl-user.h
  HDRINST usr/include/mtd/mtd-abi.h
  HDRINST usr/include/xen/gntalloc.h
  HDRINST usr/include/xen/evtchn.h
  HDRINST usr/include/xen/gntdev.h
  HDRINST usr/include/xen/privcmd.h
  HDRINST usr/include/asm-generic/int-l64.h
  HDRINST usr/include/asm-generic/sembuf.h
  HDRINST usr/include/asm-generic/msgbuf.h
  HDRINST usr/include/asm-generic/stat.h
  HDRINST usr/include/asm-generic/hugetlb_encode.h
  HDRINST usr/include/asm-generic/param.h
  HDRINST usr/include/asm-generic/kvm_para.h
  HDRINST usr/include/asm-generic/types.h
  HDRINST usr/include/asm-generic/ioctls.h
  HDRINST usr/include/asm-generic/termios.h
  HDRINST usr/include/asm-generic/int-ll64.h
  HDRINST usr/include/asm-generic/fcntl.h
  HDRINST usr/include/asm-generic/ipcbuf.h
  HDRINST usr/include/asm-generic/shmbuf.h
  HDRINST usr/include/asm-generic/mman.h
  HDRINST usr/include/asm-generic/errno.h
  HDRINST usr/include/asm-generic/swab.h
  HDRINST usr/include/asm-generic/termbits.h
  HDRINST usr/include/asm-generic/mman-common.h
  HDRINST usr/include/asm-generic/siginfo.h
  HDRINST usr/include/asm-generic/poll.h
  HDRINST usr/include/asm-generic/errno-base.h
  HDRINST usr/include/asm-generic/socket.h
  HDRINST usr/include/asm-generic/posix_types.h
  HDRINST usr/include/asm-generic/bpf_perf_event.h
  HDRINST usr/include/asm-generic/unistd.h
  HDRINST usr/include/asm-generic/ioctl.h
  HDRINST usr/include/asm-generic/setup.h
  HDRINST usr/include/asm-generic/auxvec.h
  HDRINST usr/include/asm-generic/resource.h
  HDRINST usr/include/asm-generic/ucontext.h
  HDRINST usr/include/asm-generic/signal.h
  HDRINST usr/include/asm-generic/signal-defs.h
  HDRINST usr/include/asm-generic/bitsperlong.h
  HDRINST usr/include/asm-generic/sockios.h
  HDRINST usr/include/asm-generic/statfs.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_verbs.h
  HDRINST usr/include/rdma/qedr-abi.h
  HDRINST usr/include/rdma/ib_user_ioctl_cmds.h
  HDRINST usr/include/rdma/ib_user_mad.h
  HDRINST usr/include/rdma/rdma_netlink.h
  HDRINST usr/include/rdma/irdma-abi.h
  HDRINST usr/include/rdma/rdma_user_ioctl_cmds.h
  HDRINST usr/include/rdma/rdma_user_cm.h
  HDRINST usr/include/rdma/ocrdma-abi.h
  HDRINST usr/include/rdma/rdma_user_ioctl.h
  HDRINST usr/include/rdma/bnxt_re-abi.h
  HDRINST usr/include/rdma/ib_user_verbs.h
  HDRINST usr/include/rdma/efa-abi.h
  HDRINST usr/include/rdma/ib_user_sa.h
  HDRINST usr/include/rdma/mlx5-abi.h
  HDRINST usr/include/rdma/vmw_pvrdma-abi.h
  HDRINST usr/include/rdma/ib_user_ioctl_verbs.h
  HDRINST usr/include/rdma/hns-abi.h
  HDRINST usr/include/rdma/rvt-abi.h
  HDRINST usr/include/rdma/mthca-abi.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_cmds.h
  HDRINST usr/include/rdma/cxgb4-abi.h
  HDRINST usr/include/rdma/rdma_user_rxe.h
  HDRINST usr/include/rdma/siw-abi.h
  HDRINST usr/include/rdma/mlx4-abi.h
  HDRINST usr/include/rdma/hfi/hfi1_ioctl.h
  HDRINST usr/include/rdma/hfi/hfi1_user.h
  HDRINST usr/include/misc/ocxl.h
  HDRINST usr/include/misc/uacce/uacce.h
  HDRINST usr/include/misc/uacce/hisi_qm.h
  HDRINST usr/include/misc/fastrpc.h
  HDRINST usr/include/misc/pvpanic.h
  HDRINST usr/include/misc/xilinx_sdfec.h
  HDRINST usr/include/misc/habanalabs.h
  HDRINST usr/include/misc/cxl.h
  HDRINST usr/include/linux/ax25.h
  HDRINST usr/include/linux/virtio_iommu.h
  HDRINST usr/include/linux/ipv6.h
  HDRINST usr/include/linux/capi.h
  HDRINST usr/include/linux/switchtec_ioctl.h
  HDRINST usr/include/linux/x25.h
  HDRINST usr/include/linux/cuda.h
  HDRINST usr/include/linux/kexec.h
  HDRINST usr/include/linux/v4l2-common.h
  HDRINST usr/include/linux/efs_fs_sb.h
  HDRINST usr/include/linux/netfilter/xt_connmark.h
  HDRINST usr/include/linux/netfilter/xt_length.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cthelper.h
  HDRINST usr/include/linux/netfilter/xt_nfacct.h
  HDRINST usr/include/linux/netfilter/xt_recent.h
  HDRINST usr/include/linux/netfilter/xt_dccp.h
  HDRINST usr/include/linux/netfilter/xt_NFQUEUE.h
  HDRINST usr/include/linux/netfilter/xt_physdev.h
  HDRINST usr/include/linux/netfilter/xt_MARK.h
  HDRINST usr/include/linux/netfilter/xt_conntrack.h
  HDRINST usr/include/linux/netfilter/xt_TPROXY.h
  HDRINST usr/include/linux/netfilter/xt_tcpmss.h
  HDRINST usr/include/linux/netfilter/xt_CHECKSUM.h
  HDRINST usr/include/linux/netfilter/xt_iprange.h
  HDRINST usr/include/linux/netfilter/xt_tcpudp.h
  HDRINST usr/include/linux/netfilter/xt_socket.h
  HDRINST usr/include/linux/netfilter/xt_set.h
  HDRINST usr/include/linux/netfilter/xt_rpfilter.h
  HDRINST usr/include/linux/netfilter/xt_bpf.h
  HDRINST usr/include/linux/netfilter/xt_connlabel.h
  HDRINST usr/include/linux/netfilter/xt_state.h
  HDRINST usr/include/linux/netfilter/xt_multiport.h
  HDRINST usr/include/linux/netfilter/xt_NFLOG.h
  HDRINST usr/include/linux/netfilter/xt_LED.h
  HDRINST usr/include/linux/netfilter/xt_ipvs.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_common.h
  HDRINST usr/include/linux/netfilter/xt_u32.h
  HDRINST usr/include/linux/netfilter/nfnetlink_conntrack.h
  HDRINST usr/include/linux/netfilter/xt_connlimit.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_ftp.h
  HDRINST usr/include/linux/netfilter/nf_log.h
  HDRINST usr/include/linux/netfilter/xt_hashlimit.h
  HDRINST usr/include/linux/netfilter/xt_TCPOPTSTRIP.h
  HDRINST usr/include/linux/netfilter/nfnetlink_hook.h
  HDRINST usr/include/linux/netfilter/xt_mark.h
  HDRINST usr/include/linux/netfilter/xt_statistic.h
  HDRINST usr/include/linux/netfilter/xt_CLASSIFY.h
  HDRINST usr/include/linux/netfilter/xt_connbytes.h
  HDRINST usr/include/linux/netfilter/xt_esp.h
  HDRINST usr/include/linux/netfilter/xt_ecn.h
  HDRINST usr/include/linux/netfilter/xt_AUDIT.h
  HDRINST usr/include/linux/netfilter/xt_realm.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cttimeout.h
  HDRINST usr/include/linux/netfilter/xt_l2tp.h
  HDRINST usr/include/linux/netfilter/xt_RATEEST.h
  HDRINST usr/include/linux/netfilter/nf_synproxy.h
  HDRINST usr/include/linux/netfilter/xt_owner.h
  HDRINST usr/include/linux/netfilter/xt_DSCP.h
  HDRINST usr/include/linux/netfilter/nfnetlink_osf.h
  HDRINST usr/include/linux/netfilter/xt_sctp.h
  HDRINST usr/include/linux/netfilter/xt_cgroup.h
  HDRINST usr/include/linux/netfilter/nf_tables_compat.h
  HDRINST usr/include/linux/netfilter/xt_CONNMARK.h
  HDRINST usr/include/linux/netfilter/xt_pkttype.h
  HDRINST usr/include/linux/netfilter/xt_helper.h
  HDRINST usr/include/linux/netfilter/xt_mac.h
  HDRINST usr/include/linux/netfilter/nfnetlink_log.h
  HDRINST usr/include/linux/netfilter/xt_quota.h
  HDRINST usr/include/linux/netfilter/xt_LOG.h
  HDRINST usr/include/linux/netfilter/xt_dscp.h
  HDRINST usr/include/linux/netfilter/nfnetlink_acct.h
  HDRINST usr/include/linux/netfilter/nfnetlink_compat.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tuple_common.h
  HDRINST usr/include/linux/netfilter/xt_SYNPROXY.h
  HDRINST usr/include/linux/netfilter/xt_CONNSECMARK.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_sctp.h
  HDRINST usr/include/linux/netfilter/xt_rateest.h
  HDRINST usr/include/linux/netfilter/xt_CT.h
  HDRINST usr/include/linux/netfilter/xt_comment.h
  HDRINST usr/include/linux/netfilter/xt_osf.h
  HDRINST usr/include/linux/netfilter/xt_HMARK.h
  HDRINST usr/include/linux/netfilter/xt_devgroup.h
  HDRINST usr/include/linux/netfilter/xt_addrtype.h
  HDRINST usr/include/linux/netfilter/nf_nat.h
  HDRINST usr/include/linux/netfilter/xt_TCPMSS.h
  HDRINST usr/include/linux/netfilter/xt_SECMARK.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_list.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_hash.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_bitmap.h
  HDRINST usr/include/linux/netfilter/xt_TEE.h
  HDRINST usr/include/linux/netfilter/x_tables.h
  HDRINST usr/include/linux/netfilter/nfnetlink.h
  HDRINST usr/include/linux/netfilter/nf_tables.h
  HDRINST usr/include/linux/netfilter/xt_cluster.h
  HDRINST usr/include/linux/netfilter/xt_cpu.h
  HDRINST usr/include/linux/netfilter/xt_ipcomp.h
  HDRINST usr/include/linux/netfilter/xt_string.h
  HDRINST usr/include/linux/netfilter/nfnetlink_queue.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tcp.h
  HDRINST usr/include/linux/netfilter/xt_IDLETIMER.h
  HDRINST usr/include/linux/netfilter/xt_policy.h
  HDRINST usr/include/linux/netfilter/xt_time.h
  HDRINST usr/include/linux/netfilter/xt_limit.h
  HDRINST usr/include/linux/virtio_rng.h
  HDRINST usr/include/linux/nbd-netlink.h
  HDRINST usr/include/linux/agpgart.h
  HDRINST usr/include/linux/irqnr.h
  HDRINST usr/include/linux/net_namespace.h
  HDRINST usr/include/linux/lwtunnel.h
  HDRINST usr/include/linux/seg6_local.h
  HDRINST usr/include/linux/dm-log-userspace.h
  HDRINST usr/include/linux/bfs_fs.h
  HDRINST usr/include/linux/spi/spi.h
  HDRINST usr/include/linux/spi/spidev.h
  HDRINST usr/include/linux/memfd.h
  HDRINST usr/include/linux/fou.h
  HDRINST usr/include/linux/media.h
  HDRINST usr/include/linux/romfs_fs.h
  HDRINST usr/include/linux/bsg.h
  HDRINST usr/include/linux/connector.h
  HDRINST usr/include/linux/byteorder/little_endian.h
  HDRINST usr/include/linux/byteorder/big_endian.h
  HDRINST usr/include/linux/vfio_ccw.h
  HDRINST usr/include/linux/in.h
  HDRINST usr/include/linux/hdreg.h
  HDRINST usr/include/linux/suspend_ioctls.h
  HDRINST usr/include/linux/nitro_enclaves.h
  HDRINST usr/include/linux/nilfs2_api.h
  HDRINST usr/include/linux/fsverity.h
  HDRINST usr/include/linux/if_slip.h
  HDRINST usr/include/linux/serial_core.h
  HDRINST usr/include/linux/tipc_sockets_diag.h
  HDRINST usr/include/linux/auto_fs.h
  HDRINST usr/include/linux/tcp_metrics.h
  HDRINST usr/include/linux/wwan.h
  HDRINST usr/include/linux/atmmpc.h
  HDRINST usr/include/linux/iio/types.h
  HDRINST usr/include/linux/iio/events.h
  HDRINST usr/include/linux/iio/buffer.h
  HDRINST usr/include/linux/sock_diag.h
  HDRINST usr/include/linux/ipmi_msgdefs.h
  HDRINST usr/include/linux/pmu.h
  HDRINST usr/include/linux/fscrypt.h
  HDRINST usr/include/linux/nfs.h
  HDRINST usr/include/linux/isdn/capicmd.h
  HDRINST usr/include/linux/stat.h
  HDRINST usr/include/linux/atalk.h
  HDRINST usr/include/linux/cifs/cifs_mount.h
  HDRINST usr/include/linux/cifs/cifs_netlink.h
  HDRINST usr/include/linux/ptp_clock.h
  HDRINST usr/include/linux/rose.h
  HDRINST usr/include/linux/loop.h
  HDRINST usr/include/linux/acrn.h
  HDRINST usr/include/linux/un.h
  HDRINST usr/include/linux/atmsvc.h
  HDRINST usr/include/linux/psample.h
  HDRINST usr/include/linux/gen_stats.h
  HDRINST usr/include/linux/nfc.h
  HDRINST usr/include/linux/toshiba.h
  HDRINST usr/include/linux/kernelcapi.h
  HDRINST usr/include/linux/if_tunnel.h
  HDRINST usr/include/linux/timex.h
  HDRINST usr/include/linux/xattr.h
  HDRINST usr/include/linux/dn.h
  HDRINST usr/include/linux/rxrpc.h
  HDRINST usr/include/linux/unix_diag.h
  HDRINST usr/include/linux/nubus.h
  HDRINST usr/include/linux/meye.h
  HDRINST usr/include/linux/videodev2.h
  HDRINST usr/include/linux/futex.h
  HDRINST usr/include/linux/param.h
  HDRINST usr/include/linux/module.h
  HDRINST usr/include/linux/ppp_defs.h
  HDRINST usr/include/linux/if_pppol2tp.h
  HDRINST usr/include/linux/cgroupstats.h
  HDRINST usr/include/linux/lp.h
  HDRINST usr/include/linux/cec.h
  HDRINST usr/include/linux/netfilter_ipv4/ip_tables.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ah.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_CLUSTERIP.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ttl.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_LOG.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ecn.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ECN.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_TTL.h
  HDRINST usr/include/linux/if_link.h
  HDRINST usr/include/linux/zorro_ids.h
  HDRINST usr/include/linux/netdevice.h
  HDRINST usr/include/linux/i2c-dev.h
  HDRINST usr/include/linux/if_addr.h
  HDRINST usr/include/linux/firewire-constants.h
  HDRINST usr/include/linux/if_macsec.h
  HDRINST usr/include/linux/major.h
  HDRINST usr/include/linux/vboxguest.h
  HDRINST usr/include/linux/kernel.h
  HDRINST usr/include/linux/sysinfo.h
  HDRINST usr/include/linux/mdio.h
  HDRINST usr/include/linux/netfilter_bridge.h
  HDRINST usr/include/linux/seg6_hmac.h
  HDRINST usr/include/linux/vhost_types.h
  HDRINST usr/include/linux/kvm_para.h
  HDRINST usr/include/linux/atmppp.h
  HDRINST usr/include/linux/ppdev.h
  HDRINST usr/include/linux/kcm.h
  HDRINST usr/include/linux/rpmsg_types.h
  HDRINST usr/include/linux/nvram.h
  HDRINST usr/include/linux/elf.h
  HDRINST usr/include/linux/types.h
  HDRINST usr/include/linux/if_fc.h
  HDRINST usr/include/linux/can/vxcan.h
  HDRINST usr/include/linux/can/bcm.h
  HDRINST usr/include/linux/can/error.h
  HDRINST usr/include/linux/can/gw.h
  HDRINST usr/include/linux/can/j1939.h
  HDRINST usr/include/linux/can/raw.h
  HDRINST usr/include/linux/can/isotp.h
  HDRINST usr/include/linux/can/netlink.h
  HDRINST usr/include/linux/input-event-codes.h
  HDRINST usr/include/linux/ife.h
  HDRINST usr/include/linux/isst_if.h
  HDRINST usr/include/linux/vsockmon.h
  HDRINST usr/include/linux/virtio_pcidev.h
  HDRINST usr/include/linux/packet_diag.h
  HDRINST usr/include/linux/ipc.h
  HDRINST usr/include/linux/v4l2-dv-timings.h
  HDRINST usr/include/linux/rpmsg.h
  HDRINST usr/include/linux/rtnetlink.h
  HDRINST usr/include/linux/ccs.h
  HDRINST usr/include/linux/i2c.h
  HDRINST usr/include/linux/personality.h
  HDRINST usr/include/linux/if_xdp.h
  HDRINST usr/include/linux/coda.h
  HDRINST usr/include/linux/keyboard.h
  HDRINST usr/include/linux/tipc.h
  HDRINST usr/include/linux/nfs4_mount.h
  HDRINST usr/include/linux/cfm_bridge.h
  HDRINST usr/include/linux/apm_bios.h
  HDRINST usr/include/linux/gameport.h
  HDRINST usr/include/linux/fdreg.h
  HDRINST usr/include/linux/icmpv6.h
  HDRINST usr/include/linux/sonypi.h
  HDRINST usr/include/linux/virtio_snd.h
  HDRINST usr/include/linux/rio_cm_cdev.h
  HDRINST usr/include/linux/nfs3.h
  HDRINST usr/include/linux/io_uring.h
  HDRINST usr/include/linux/virtio_console.h
  HDRINST usr/include/linux/dma-heap.h
  HDRINST usr/include/linux/idxd.h
  HDRINST usr/include/linux/udf_fs_i.h
  HDRINST usr/include/linux/ipsec.h
  HDRINST usr/include/linux/if_pppox.h
  HDRINST usr/include/linux/rpl.h
  HDRINST usr/include/linux/blkzoned.h
  HDRINST usr/include/linux/landlock.h
  HDRINST usr/include/linux/atm_eni.h
  HDRINST usr/include/linux/seg6_iptunnel.h
  HDRINST usr/include/linux/if_phonet.h
  HDRINST usr/include/linux/dlm_plock.h
  HDRINST usr/include/linux/if_vlan.h
  HDRINST usr/include/linux/stddef.h
  HDRINST usr/include/linux/net_dropmon.h
  HDRINST usr/include/linux/virtio_crypto.h
  HDRINST usr/include/linux/atmioc.h
  HDRINST usr/include/linux/sunrpc/debug.h
  HDRINST usr/include/linux/map_to_7segment.h
  HDRINST usr/include/linux/vtpm_proxy.h
  HDRINST usr/include/linux/fsi.h
  HDRINST usr/include/linux/fuse.h
  HDRINST usr/include/linux/userfaultfd.h
  HDRINST usr/include/linux/sched/types.h
  HDRINST usr/include/linux/psp-sev.h
  HDRINST usr/include/linux/nsfs.h
  HDRINST usr/include/linux/virtio_net.h
  HDRINST usr/include/linux/arcfb.h
  HDRINST usr/include/linux/ppp-ioctl.h
  HDRINST usr/include/linux/reiserfs_xattr.h
  HDRINST usr/include/linux/if_packet.h
  HDRINST usr/include/linux/tiocl.h
  HDRINST usr/include/linux/uhid.h
  HDRINST usr/include/linux/tcp.h
  HDRINST usr/include/linux/cciss_ioctl.h
  HDRINST usr/include/linux/netlink_diag.h
  HDRINST usr/include/linux/termios.h
  HDRINST usr/include/linux/dlm_device.h
  HDRINST usr/include/linux/if_addrlabel.h
  HDRINST usr/include/linux/usbip.h
  HDRINST usr/include/linux/smc.h
  HDRINST usr/include/linux/if_hippi.h
  HDRINST usr/include/linux/hpet.h
  HDRINST usr/include/linux/nbd.h
  HDRINST usr/include/linux/virtio_balloon.h
  HDRINST usr/include/linux/virtio_9p.h
  HDRINST usr/include/linux/fadvise.h
  HDRINST usr/include/linux/cycx_cfm.h
  HDRINST usr/include/linux/pkt_sched.h
  HDRINST usr/include/linux/rkisp1-config.h
  HDRINST usr/include/linux/random.h
  HDRINST usr/include/linux/mptcp.h
  HDRINST usr/include/linux/net_tstamp.h
  HDRINST usr/include/linux/cec-funcs.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_pkttype.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nflog.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_802_3.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_limit.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_redirect.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_t.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nat.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_vlan.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_stp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arpreply.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip6.h
  HDRINST usr/include/linux/netfilter_bridge/ebtables.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_m.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_log.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_among.h
  HDRINST usr/include/linux/keyctl.h
  HDRINST usr/include/linux/um_timetravel.h
  HDRINST usr/include/linux/netconf.h
  HDRINST usr/include/linux/atmapi.h
  HDRINST usr/include/linux/uinput.h
  HDRINST usr/include/linux/mempolicy.h
  HDRINST usr/include/linux/atm_nicstar.h
  HDRINST usr/include/linux/acct.h
  HDRINST usr/include/linux/mmc/ioctl.h
  HDRINST usr/include/linux/uuid.h
  HDRINST usr/include/linux/if_ppp.h
  HDRINST usr/include/linux/neighbour.h
  HDRINST usr/include/linux/mii.h
  HDRINST usr/include/linux/atm_zatm.h
  HDRINST usr/include/linux/edd.h
  HDRINST usr/include/linux/virtio_bt.h
  HDRINST usr/include/linux/cciss_defs.h
  HDRINST usr/include/linux/erspan.h
  HDRINST usr/include/linux/reiserfs_fs.h
  HDRINST usr/include/linux/uleds.h
  HDRINST usr/include/linux/dlmconstants.h
  HDRINST usr/include/linux/pkt_cls.h
  HDRINST usr/include/linux/hdlcdrv.h
  HDRINST usr/include/linux/signalfd.h
  HDRINST usr/include/linux/fsl_mc.h
  HDRINST usr/include/linux/rpl_iptunnel.h
  HDRINST usr/include/linux/ila.h
  HDRINST usr/include/linux/lirc.h
  HDRINST usr/include/linux/hdlc.h
  HDRINST usr/include/linux/atmsap.h
  HDRINST usr/include/linux/virtio_mem.h
  HDRINST usr/include/linux/tc_ematch/tc_em_text.h
  HDRINST usr/include/linux/tc_ematch/tc_em_meta.h
  HDRINST usr/include/linux/tc_ematch/tc_em_ipt.h
  HDRINST usr/include/linux/tc_ematch/tc_em_nbyte.h
  HDRINST usr/include/linux/tc_ematch/tc_em_cmp.h
  HDRINST usr/include/linux/smc_diag.h
  HDRINST usr/include/linux/raid/md_u.h
  HDRINST usr/include/linux/raid/md_p.h
  HDRINST usr/include/linux/mrp_bridge.h
  HDRINST usr/include/linux/virtio_input.h
  HDRINST usr/include/linux/atmarp.h
  HDRINST usr/include/linux/utime.h
  HDRINST usr/include/linux/usb/functionfs.h
  HDRINST usr/include/linux/usb/audio.h
  HDRINST usr/include/linux/usb/ch11.h
  HDRINST usr/include/linux/usb/cdc.h
  HDRINST usr/include/linux/usb/charger.h
  HDRINST usr/include/linux/usb/cdc-wdm.h
  HDRINST usr/include/linux/usb/gadgetfs.h
  HDRINST usr/include/linux/usb/video.h
  HDRINST usr/include/linux/usb/midi.h
  HDRINST usr/include/linux/usb/ch9.h
  HDRINST usr/include/linux/usb/tmc.h
  HDRINST usr/include/linux/usb/g_uvc.h
  HDRINST usr/include/linux/usb/raw_gadget.h
  HDRINST usr/include/linux/usb/g_printer.h
  HDRINST usr/include/linux/reboot.h
  HDRINST usr/include/linux/shm.h
  HDRINST usr/include/linux/v4l2-mediabus.h
  HDRINST usr/include/linux/nfsd/stats.h
  HDRINST usr/include/linux/nfsd/cld.h
  HDRINST usr/include/linux/nfsd/nfsfh.h
  HDRINST usr/include/linux/nfsd/debug.h
  HDRINST usr/include/linux/nfsd/export.h
  HDRINST usr/include/linux/remoteproc_cdev.h
  HDRINST usr/include/linux/mpls.h
  HDRINST usr/include/linux/if_fddi.h
  HDRINST usr/include/linux/fcntl.h
  HDRINST usr/include/linux/eventpoll.h
  HDRINST usr/include/linux/hash_info.h
  HDRINST usr/include/linux/thermal.h
  HDRINST usr/include/linux/elf-fdpic.h
  HDRINST usr/include/linux/batman_adv.h
  HDRINST usr/include/linux/adfs_fs.h
  HDRINST usr/include/linux/phantom.h
  HDRINST usr/include/linux/posix_acl.h
  HDRINST usr/include/linux/bpf_common.h
  HDRINST usr/include/linux/bpqether.h
  HDRINST usr/include/linux/rtc.h
  HDRINST usr/include/linux/nvme_ioctl.h
  HDRINST usr/include/linux/sctp.h
  HDRINST usr/include/linux/netfilter.h
  HDRINST usr/include/linux/qnxtypes.h
  HDRINST usr/include/linux/nfsacl.h
  HDRINST usr/include/linux/kd.h
  HDRINST usr/include/linux/vm_sockets.h
  HDRINST usr/include/linux/if_x25.h
  HDRINST usr/include/linux/nfs_fs.h
  HDRINST usr/include/linux/msdos_fs.h
  HDRINST usr/include/linux/utsname.h
  HDRINST usr/include/linux/oom.h
  HDRINST usr/include/linux/mman.h
  HDRINST usr/include/linux/cdrom.h
  HDRINST usr/include/linux/hiddev.h
  HDRINST usr/include/linux/route.h
  HDRINST usr/include/linux/sed-opal.h
  HDRINST usr/include/linux/if_eql.h
  HDRINST usr/include/linux/btrfs_tree.h
  HDRINST usr/include/linux/ptrace.h
  HDRINST usr/include/linux/inet_diag.h
  HDRINST usr/include/linux/fsmap.h
  HDRINST usr/include/linux/virtio_ring.h
  HDRINST usr/include/linux/time.h
  HDRINST usr/include/linux/errno.h
  HDRINST usr/include/linux/xfrm.h
  HDRINST usr/include/linux/iso_fs.h
  HDRINST usr/include/linux/if_ltalk.h
  HDRINST usr/include/linux/ethtool_netlink.h
  HDRINST usr/include/linux/uvcvideo.h
  HDRINST usr/include/linux/dma-buf.h
  HDRINST usr/include/linux/bcm933xx_hcs.h
  HDRINST usr/include/linux/netfilter_arp/arp_tables.h
  HDRINST usr/include/linux/netfilter_arp/arpt_mangle.h
  HDRINST usr/include/linux/taskstats.h
  HDRINST usr/include/linux/mmtimer.h
  HDRINST usr/include/linux/matroxfb.h
  HDRINST usr/include/linux/bcache.h
  HDRINST usr/include/linux/affs_hardblocks.h
  HDRINST usr/include/linux/vbox_err.h
  HDRINST usr/include/linux/swab.h
  HDRINST usr/include/linux/xilinx-v4l2-controls.h
  HDRINST usr/include/linux/cn_proc.h
  HDRINST usr/include/linux/virtio_types.h
  HDRINST usr/include/linux/securebits.h
  HDRINST usr/include/linux/nl80211.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_rt.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_frag.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_LOG.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_HL.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_srh.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_mh.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_NPT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_hl.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6_tables.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ah.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ipv6header.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_opts.h
  HDRINST usr/include/linux/kcmp.h
  HDRINST usr/include/linux/pps.h
  HDRINST usr/include/linux/v4l2-controls.h
  HDRINST usr/include/linux/net.h
  HDRINST usr/include/linux/rseq.h
  HDRINST usr/include/linux/mei.h
  HDRINST usr/include/linux/kvm.h
  HDRINST usr/include/linux/inotify.h
  HDRINST usr/include/linux/wireguard.h
  HDRINST usr/include/linux/iommu.h
  HDRINST usr/include/linux/batadv_packet.h
  HDRINST usr/include/linux/nfs2.h
  HDRINST usr/include/linux/msg.h
  HDRINST usr/include/linux/mpls_iptunnel.h
  HDRINST usr/include/linux/zorro.h
  HDRINST usr/include/linux/hsi/cs-protocol.h
  HDRINST usr/include/linux/hsi/hsi_char.h
  HDRINST usr/include/linux/ip6_tunnel.h
  HDRINST usr/include/linux/atmclip.h
  HDRINST usr/include/linux/magic.h
  HDRINST usr/include/linux/ivtv.h
  HDRINST usr/include/linux/udp.h
  HDRINST usr/include/linux/in6.h
  HDRINST usr/include/linux/scif_ioctl.h
  HDRINST usr/include/linux/mount.h
  HDRINST usr/include/linux/atm_idt77105.h
  HDRINST usr/include/linux/openat2.h
  HDRINST usr/include/linux/if_bonding.h
  HDRINST usr/include/linux/time_types.h
  HDRINST usr/include/linux/auto_dev-ioctl.h
  HDRINST usr/include/linux/max2175.h
  HDRINST usr/include/linux/nfs4.h
  HDRINST usr/include/linux/virtio_vsock.h
  HDRINST usr/include/linux/atmdev.h
  HDRINST usr/include/linux/virtio_fs.h
  HDRINST usr/include/linux/ip_vs.h
  HDRINST usr/include/linux/watch_queue.h
  HDRINST usr/include/linux/fiemap.h
  HDRINST usr/include/linux/l2tp.h
  HDRINST usr/include/linux/ppp-comp.h
  HDRINST usr/include/linux/vdpa.h
  HDRINST usr/include/linux/poll.h
  HDRINST usr/include/linux/radeonfb.h
  HDRINST usr/include/linux/genwqe/genwqe_card.h
  HDRINST usr/include/linux/netfilter_arp.h
  HDRINST usr/include/linux/cxl_mem.h
  HDRINST usr/include/linux/atm.h
  HDRINST usr/include/linux/atm_he.h
  HDRINST usr/include/linux/qrtr.h
  HDRINST usr/include/linux/target_core_user.h
  HDRINST usr/include/linux/am437x-vpfe.h
  HDRINST usr/include/linux/dlm.h
  HDRINST usr/include/linux/lightnvm.h
  HDRINST usr/include/linux/fd.h
  HDRINST usr/include/linux/const.h
  HDRINST usr/include/linux/socket.h
  HDRINST usr/include/linux/gtp.h
  HDRINST usr/include/linux/udmabuf.h
  HDRINST usr/include/linux/sched.h
  HDRINST usr/include/linux/omapfb.h
  HDRINST usr/include/linux/blkpg.h
  HDRINST usr/include/linux/surface_aggregator/cdev.h
  HDRINST usr/include/linux/surface_aggregator/dtx.h
  HDRINST usr/include/linux/string.h
  HDRINST usr/include/linux/cm4000_cs.h
  HDRINST usr/include/linux/i2o-dev.h
  HDRINST usr/include/linux/virtio_mmio.h
  HDRINST usr/include/linux/close_range.h
  HDRINST usr/include/linux/serial_reg.h
  HDRINST usr/include/linux/dvb/dmx.h
  HDRINST usr/include/linux/dvb/frontend.h
  HDRINST usr/include/linux/dvb/version.h
  HDRINST usr/include/linux/dvb/ca.h
  HDRINST usr/include/linux/dvb/net.h
  HDRINST usr/include/linux/netfilter_ipv4.h
  HDRINST usr/include/linux/audit.h
  HDRINST usr/include/linux/baycom.h
  HDRINST usr/include/linux/arm_sdei.h
  HDRINST usr/include/linux/virtio_ids.h
  HDRINST usr/include/linux/vfio_zdev.h
  HDRINST usr/include/linux/synclink.h
  HDRINST usr/include/linux/libc-compat.h
  HDRINST usr/include/linux/watchdog.h
  HDRINST usr/include/linux/posix_types.h
  HDRINST usr/include/linux/nfs_idmap.h
  HDRINST usr/include/linux/pktcdvd.h
  HDRINST usr/include/linux/times.h
  HDRINST usr/include/linux/capability.h
  HDRINST usr/include/linux/perf_event.h
  HDRINST usr/include/linux/atm_tcp.h
  HDRINST usr/include/linux/virtio_config.h
  HDRINST usr/include/linux/fs.h
  HDRINST usr/include/linux/qemu_fw_cfg.h
  HDRINST usr/include/linux/wait.h
  HDRINST usr/include/linux/ipmi.h
  HDRINST usr/include/linux/falloc.h
  HDRINST usr/include/linux/hid.h
  HDRINST usr/include/linux/virtio_scsi.h
  HDRINST usr/include/linux/seg6_genl.h
  HDRINST usr/include/linux/pr.h
  HDRINST usr/include/linux/wmi.h
  HDRINST usr/include/linux/elf-em.h
  HDRINST usr/include/linux/usbdevice_fs.h
  HDRINST usr/include/linux/coff.h
  HDRINST usr/include/linux/hidraw.h
  HDRINST usr/include/linux/membarrier.h
  HDRINST usr/include/linux/bpf_perf_event.h
  HDRINST usr/include/linux/smiapp.h
  HDRINST usr/include/linux/tls.h
  HDRINST usr/include/linux/if_team.h
  HDRINST usr/include/linux/misc/bcm_vk.h
  HDRINST usr/include/linux/sonet.h
  HDRINST usr/include/linux/if_ether.h
  HDRINST usr/include/linux/fb.h
  HDRINST usr/include/linux/i8k.h
  HDRINST usr/include/linux/tipc_config.h
  HDRINST usr/include/linux/rio_mport_cdev.h
  HDRINST usr/include/linux/netfilter_ipv6.h
  HDRINST usr/include/linux/bt-bmc.h
  HDRINST usr/include/linux/gsmmux.h
  HDRINST usr/include/linux/firewire-cdev.h
  HDRINST usr/include/linux/parport.h
  HDRINST usr/include/linux/aspeed-p2a-ctrl.h
  HDRINST usr/include/linux/input.h
  HDRINST usr/include/linux/nilfs2_ondisk.h
  HDRINST usr/include/linux/tty.h
  HDRINST usr/include/linux/unistd.h
  HDRINST usr/include/linux/if_cablemodem.h
  HDRINST usr/include/linux/ioctl.h
  HDRINST usr/include/linux/atmlec.h
  HDRINST usr/include/linux/filter.h
  HDRINST usr/include/linux/ivtvfb.h
  HDRINST usr/include/linux/vt.h
  HDRINST usr/include/linux/if.h
  HDRINST usr/include/linux/if_arp.h
  HDRINST usr/include/linux/if_plip.h
  HDRINST usr/include/linux/cryptouser.h
  HDRINST usr/include/linux/pcitest.h
  HDRINST usr/include/linux/kdev_t.h
  HDRINST usr/include/linux/media-bus-format.h
  HDRINST usr/include/linux/ipx.h
  HDRINST usr/include/linux/hyperv.h
  HDRINST usr/include/linux/snmp.h
  HDRINST usr/include/linux/igmp.h
  HDRINST usr/include/linux/ipv6_route.h
  HDRINST usr/include/linux/gfs2_ondisk.h
  HDRINST usr/include/linux/if_bridge.h
  HDRINST usr/include/linux/virtio_pci.h
  HDRINST usr/include/linux/llc.h
  HDRINST usr/include/linux/pci_regs.h
  HDRINST usr/include/linux/pfkeyv2.h
  HDRINST usr/include/linux/can.h
  HDRINST usr/include/linux/rds.h
  HDRINST usr/include/linux/seccomp.h
  HDRINST usr/include/linux/a.out.h
  HDRINST usr/include/linux/mqueue.h
  HDRINST usr/include/linux/auxvec.h
  HDRINST usr/include/linux/vmcore.h
  HDRINST usr/include/linux/fib_rules.h
  HDRINST usr/include/linux/kfd_ioctl.h
  HDRINST usr/include/linux/coresight-stm.h
  HDRINST usr/include/linux/patchkey.h
  HDRINST usr/include/linux/chio.h
  HDRINST usr/include/linux/prctl.h
  HDRINST usr/include/linux/cramfs_fs.h
  HDRINST usr/include/linux/android/binder.h
  HDRINST usr/include/linux/android/binderfs.h
  HDRINST usr/include/linux/resource.h
  HDRINST usr/include/linux/xdp_diag.h
  HDRINST usr/include/linux/dns_resolver.h
  HDRINST usr/include/linux/hsr_netlink.h
  HDRINST usr/include/linux/if_arcnet.h
  HDRINST usr/include/linux/auto_fs4.h
  HDRINST usr/include/linux/if_infiniband.h
  HDRINST usr/include/linux/sysctl.h
  HDRINST usr/include/linux/mroute6.h
  HDRINST usr/include/linux/dccp.h
  HDRINST usr/include/linux/pg.h
  HDRINST usr/include/linux/kcov.h
  HDRINST usr/include/linux/caif/caif_socket.h
  HDRINST usr/include/linux/caif/if_caif.h
  HDRINST usr/include/linux/errqueue.h
  HDRINST usr/include/linux/virtio_blk.h
  HDRINST usr/include/linux/dlm_netlink.h
  HDRINST usr/include/linux/limits.h
  HDRINST usr/include/linux/aspeed-lpc-ctrl.h
  HDRINST usr/include/linux/v4l2-subdev.h
  HDRINST usr/include/linux/fanotify.h
  HDRINST usr/include/linux/bpfilter.h
  HDRINST usr/include/linux/minix_fs.h
  HDRINST usr/include/linux/signal.h
  HDRINST usr/include/linux/stm.h
  HDRINST usr/include/linux/qnx4_fs.h
  HDRINST usr/include/linux/scc.h
  HDRINST usr/include/linux/devlink.h
  HDRINST usr/include/linux/f2fs.h
  HDRINST usr/include/linux/serial.h
  HDRINST usr/include/linux/ip.h
  HDRINST usr/include/linux/hw_breakpoint.h
  HDRINST usr/include/linux/ultrasound.h
  HDRINST usr/include/linux/netlink.h
  HDRINST usr/include/linux/vfio.h
  HDRINST usr/include/linux/hdlc/ioctl.h
  HDRINST usr/include/linux/virtio_pmem.h
  HDRINST usr/include/linux/bpf.h
  HDRINST usr/include/linux/screen_info.h
  HDRINST usr/include/linux/genetlink.h
  HDRINST usr/include/linux/gpio.h
  HDRINST usr/include/linux/nexthop.h
  HDRINST usr/include/linux/timerfd.h
  HDRINST usr/include/linux/adb.h
  HDRINST usr/include/linux/phonet.h
  HDRINST usr/include/linux/uio.h
  HDRINST usr/include/linux/atmbr2684.h
  HDRINST usr/include/linux/ncsi.h
  HDRINST usr/include/linux/sound.h
  HDRINST usr/include/linux/vhost.h
  HDRINST usr/include/linux/ipmi_bmc.h
  HDRINST usr/include/linux/netfilter_decnet.h
  HDRINST usr/include/linux/pidfd.h
  HDRINST usr/include/linux/fsl_hypervisor.h
  HDRINST usr/include/linux/serio.h
  HDRINST usr/include/linux/seg6.h
  HDRINST usr/include/linux/sync_file.h
  HDRINST usr/include/linux/jffs2.h
  HDRINST usr/include/linux/mroute.h
  HDRINST usr/include/linux/tc_act/tc_skbmod.h
  HDRINST usr/include/linux/tc_act/tc_defact.h
  HDRINST usr/include/linux/tc_act/tc_mpls.h
  HDRINST usr/include/linux/tc_act/tc_ipt.h
  HDRINST usr/include/linux/tc_act/tc_gact.h
  HDRINST usr/include/linux/tc_act/tc_ct.h
  HDRINST usr/include/linux/tc_act/tc_bpf.h
  HDRINST usr/include/linux/tc_act/tc_nat.h
  HDRINST usr/include/linux/tc_act/tc_ctinfo.h
  HDRINST usr/include/linux/tc_act/tc_vlan.h
  HDRINST usr/include/linux/tc_act/tc_tunnel_key.h
  HDRINST usr/include/linux/tc_act/tc_csum.h
  HDRINST usr/include/linux/tc_act/tc_connmark.h
  HDRINST usr/include/linux/tc_act/tc_sample.h
  HDRINST usr/include/linux/tc_act/tc_mirred.h
  HDRINST usr/include/linux/tc_act/tc_gate.h
  HDRINST usr/include/linux/tc_act/tc_ife.h
  HDRINST usr/include/linux/tc_act/tc_skbedit.h
  HDRINST usr/include/linux/tc_act/tc_pedit.h
  HDRINST usr/include/linux/sem.h
  HDRINST usr/include/linux/if_alg.h
  HDRINST usr/include/linux/soundcard.h
  HDRINST usr/include/linux/if_tun.h
  HDRINST usr/include/linux/kernel-page-flags.h
  HDRINST usr/include/linux/virtio_gpu.h
  HDRINST usr/include/linux/dqblk_xfs.h
  HDRINST usr/include/linux/btrfs.h
  HDRINST usr/include/linux/userio.h
  HDRINST usr/include/linux/nfs_mount.h
  HDRINST usr/include/linux/openvswitch.h
  HDRINST usr/include/linux/quota.h
  HDRINST usr/include/linux/icmp.h
  HDRINST usr/include/linux/selinux_netlink.h
  HDRINST usr/include/linux/dcbnl.h
  HDRINST usr/include/linux/in_route.h
  HDRINST usr/include/linux/pci.h
  HDRINST usr/include/linux/vbox_vmmdev_types.h
  HDRINST usr/include/linux/wireless.h
  HDRINST usr/include/linux/binfmts.h
  HDRINST usr/include/linux/rfkill.h
  HDRINST usr/include/linux/sockios.h
  HDRINST usr/include/linux/blktrace_api.h
  HDRINST usr/include/linux/posix_acl_xattr.h
  HDRINST usr/include/linux/btf.h
  HDRINST usr/include/linux/mtio.h
  HDRINST usr/include/linux/netrom.h
  HDRINST usr/include/linux/dm-ioctl.h
  HDRINST usr/include/linux/tty_flags.h
  HDRINST usr/include/linux/aio_abi.h
  HDRINST usr/include/linux/tipc_netlink.h
  HDRINST usr/include/linux/psci.h
  HDRINST usr/include/linux/ndctl.h
  HDRINST usr/include/linux/fpga-dfl.h
  HDRINST usr/include/linux/joystick.h
  HDRINST usr/include/linux/tee.h
  HDRINST usr/include/linux/veth.h
  HDRINST usr/include/linux/ethtool.h
  HDRINST usr/include/linux/vm_sockets_diag.h
  HDRINST usr/include/linux/omap3isp.h
  HDRINST usr/include/sound/sfnt_info.h
  HDRINST usr/include/sound/skl-tplg-interface.h
  HDRINST usr/include/sound/compress_offload.h
  HDRINST usr/include/sound/firewire.h
  HDRINST usr/include/sound/asequencer.h
  HDRINST usr/include/sound/hdsp.h
  HDRINST usr/include/sound/emu10k1.h
  HDRINST usr/include/sound/sb16_csp.h
  HDRINST usr/include/sound/snd_sst_tokens.h
  HDRINST usr/include/sound/asoc.h
  HDRINST usr/include/sound/asound.h
  HDRINST usr/include/sound/compress_params.h
  HDRINST usr/include/sound/usb_stream.h
  HDRINST usr/include/sound/tlv.h
  HDRINST usr/include/sound/hdspm.h
  HDRINST usr/include/sound/sof/abi.h
  HDRINST usr/include/sound/sof/header.h
  HDRINST usr/include/sound/sof/tokens.h
  HDRINST usr/include/sound/sof/fw.h
  HDRINST usr/include/sound/asound_fm.h
  HDRINST usr/include/scsi/scsi_netlink.h
  HDRINST usr/include/scsi/fc/fc_ns.h
  HDRINST usr/include/scsi/fc/fc_fs.h
  HDRINST usr/include/scsi/fc/fc_els.h
  HDRINST usr/include/scsi/fc/fc_gs.h
  HDRINST usr/include/scsi/scsi_netlink_fc.h
  HDRINST usr/include/scsi/scsi_bsg_ufs.h
  HDRINST usr/include/scsi/cxlflash_ioctl.h
  HDRINST usr/include/scsi/scsi_bsg_fc.h
  HDRINST usr/include/linux/version.h
  HDRINST usr/include/asm/mce.h
  HDRINST usr/include/asm/ist.h
  HDRINST usr/include/asm/sembuf.h
  HDRINST usr/include/asm/msgbuf.h
  HDRINST usr/include/asm/stat.h
  HDRINST usr/include/asm/processor-flags.h
  HDRINST usr/include/asm/boot.h
  HDRINST usr/include/asm/sgx.h
  HDRINST usr/include/asm/kvm_para.h
  HDRINST usr/include/asm/ldt.h
  HDRINST usr/include/asm/byteorder.h
  HDRINST usr/include/asm/hwcap2.h
  HDRINST usr/include/asm/debugreg.h
  HDRINST usr/include/asm/posix_types_x32.h
  HDRINST usr/include/asm/shmbuf.h
  HDRINST usr/include/asm/mman.h
  HDRINST usr/include/asm/perf_regs.h
  HDRINST usr/include/asm/ptrace.h
  HDRINST usr/include/asm/swab.h
  HDRINST usr/include/asm/vm86.h
  HDRINST usr/include/asm/kvm.h
  HDRINST usr/include/asm/siginfo.h
  HDRINST usr/include/asm/posix_types.h
  HDRINST usr/include/asm/sigcontext.h
  HDRINST usr/include/asm/ptrace-abi.h
  HDRINST usr/include/asm/vmx.h
  HDRINST usr/include/asm/unistd.h
  HDRINST usr/include/asm/setup.h
  HDRINST usr/include/asm/mtrr.h
  HDRINST usr/include/asm/svm.h
  HDRINST usr/include/asm/vsyscall.h
  HDRINST usr/include/asm/a.out.h
  HDRINST usr/include/asm/bootparam.h
  HDRINST usr/include/asm/e820.h
  HDRINST usr/include/asm/auxvec.h
  HDRINST usr/include/asm/posix_types_32.h
  HDRINST usr/include/asm/prctl.h
  HDRINST usr/include/asm/ucontext.h
  HDRINST usr/include/asm/sigcontext32.h
  HDRINST usr/include/asm/signal.h
  HDRINST usr/include/asm/posix_types_64.h
  HDRINST usr/include/asm/hw_breakpoint.h
  HDRINST usr/include/asm/kvm_perf.h
  HDRINST usr/include/asm/bitsperlong.h
  HDRINST usr/include/asm/msr.h
  HDRINST usr/include/asm/statfs.h
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
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867'
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867/tools/testing/selftests/net/mptcp'
2021-09-06 14:54:51 make run_tests -C net/mptcp
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867/tools/testing/selftests/net/mptcp'
make --no-builtin-rules ARCH=x86 -C ../../../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867'
  INSTALL ./usr/include
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867'
TAP version 13
1..6
# selftests: net/mptcp: mptcp_connect.sh
# INFO: set ns3-61362bbd-m5KpnS dev ns3eth2: ethtool -K tso off gso off
# Created /tmp/tmp.j9XKdVjbH4 (size 1268764	/tmp/tmp.j9XKdVjbH4) containing data sent by client
# Created /tmp/tmp.89p9h8oMQI (size 7760924	/tmp/tmp.89p9h8oMQI) containing data sent by server
# New MPTCP socket can be blocked via sysctl		[ OK ]
# setsockopt(..., TCP_ULP, "mptcp", ...) blocked	[ OK ]
# INFO: validating network environment with pings
# INFO: Using loss of 0.53% delay 18 ms reorder 95% 39% with delay 4ms on ns3eth4
# ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP	(duration   795ms) [ OK ]
# ns1 MPTCP -> ns1 (10.0.1.1:10001      ) TCP  	(duration   475ms) [ OK ]
# ns1 TCP   -> ns1 (10.0.1.1:10002      ) MPTCP	(duration   446ms) [ OK ]
# ns1 MPTCP -> ns1 (dead:beef:1::1:10003) MPTCP	(duration   480ms) [ OK ]
# ns1 MPTCP -> ns1 (dead:beef:1::1:10004) TCP  	(duration   450ms) [ OK ]
# ns1 TCP   -> ns1 (dead:beef:1::1:10005) MPTCP	(duration   432ms) [ OK ]
# ns1 MPTCP -> ns2 (10.0.1.2:10006      ) MPTCP	(duration   633ms) [ OK ]
# ns1 MPTCP -> ns2 (dead:beef:1::2:10007) MPTCP	(duration   629ms) [ OK ]
# ns1 MPTCP -> ns2 (10.0.2.1:10008      ) MPTCP	(duration   428ms) [ OK ]
# ns1 MPTCP -> ns2 (dead:beef:2::1:10009) MPTCP	(duration   482ms) [ OK ]
# ns1 MPTCP -> ns3 (10.0.2.2:10010      ) MPTCP	(duration  1152ms) [ OK ]
# ns1 MPTCP -> ns3 (dead:beef:2::2:10011) MPTCP	(duration  1304ms) [ OK ]
# ns1 MPTCP -> ns3 (10.0.3.2:10012      ) MPTCP	(duration  1173ms) [ OK ]
# ns1 MPTCP -> ns3 (dead:beef:3::2:10013) MPTCP	(duration  1323ms) [ OK ]
# ns1 MPTCP -> ns4 (10.0.3.1:10014      ) MPTCP	(duration  1292ms) [ OK ]
# ns1 MPTCP -> ns4 (dead:beef:3::1:10015) MPTCP	(duration  1621ms) [ OK ]
# ns2 MPTCP -> ns1 (10.0.1.1:10016      ) MPTCP	(duration   429ms) [ OK ]
# ns2 MPTCP -> ns1 (dead:beef:1::1:10017) MPTCP	(duration   482ms) [ OK ]
# ns2 MPTCP -> ns3 (10.0.2.2:10018      ) MPTCP	(duration   935ms) [ OK ]
# ns2 MPTCP -> ns3 (dead:beef:2::2:10019) MPTCP	(duration  1040ms) [ OK ]
# ns2 MPTCP -> ns3 (10.0.3.2:10020      ) MPTCP	(duration  1259ms) [ OK ]
# ns2 MPTCP -> ns3 (dead:beef:3::2:10021) MPTCP	(duration  1130ms) [ OK ]
# ns2 MPTCP -> ns4 (10.0.3.1:10022      ) MPTCP	(duration  1031ms) [ OK ]
# ns2 MPTCP -> ns4 (dead:beef:3::1:10023) MPTCP	(duration  1209ms) [ OK ]
# ns3 MPTCP -> ns1 (10.0.1.1:10024      ) MPTCP	(duration   479ms) [ OK ]
# ns3 MPTCP -> ns1 (dead:beef:1::1:10025) MPTCP	(duration   543ms) [ OK ]
# ns3 MPTCP -> ns2 (10.0.1.2:10026      ) MPTCP	(duration   454ms) [ OK ]
# ns3 MPTCP -> ns2 (dead:beef:1::2:10027) MPTCP	(duration  5182ms) [ OK ]
# ns3 MPTCP -> ns2 (10.0.2.1:10028      ) MPTCP	(duration   446ms) [ OK ]
# ns3 MPTCP -> ns2 (dead:beef:2::1:10029) MPTCP	(duration   950ms) [ OK ]
# ns3 MPTCP -> ns4 (10.0.3.1:10030      ) MPTCP	(duration   440ms) [ OK ]
# ns3 MPTCP -> ns4 (dead:beef:3::1:10031) MPTCP	(duration   492ms) [ OK ]
# ns4 MPTCP -> ns1 (10.0.1.1:10032      ) MPTCP	(duration   473ms) [ OK ]
# ns4 MPTCP -> ns1 (dead:beef:1::1:10033) MPTCP	(duration   761ms) [ OK ]
# ns4 MPTCP -> ns2 (10.0.1.2:10034      ) MPTCP	(duration   496ms) [ OK ]
# ns4 MPTCP -> ns2 (dead:beef:1::2:10035) MPTCP	(duration  4897ms) [ OK ]
# ns4 MPTCP -> ns2 (10.0.2.1:10036      ) MPTCP	(duration   532ms) [ OK ]
# ns4 MPTCP -> ns2 (dead:beef:2::1:10037) MPTCP	(duration  2560ms) [ OK ]
# ns4 MPTCP -> ns3 (10.0.2.2:10038      ) MPTCP	(duration   442ms) [ OK ]
# ns4 MPTCP -> ns3 (dead:beef:2::2:10039) MPTCP	(duration   491ms) [ OK ]
# ns4 MPTCP -> ns3 (10.0.3.2:10040      ) MPTCP	(duration   439ms) [ OK ]
# ns4 MPTCP -> ns3 (dead:beef:3::2:10041) MPTCP	(duration   532ms) [ OK ]
# INFO: with peek mode: saveWithPeek
# ns1 MPTCP -> ns1 (10.0.1.1:10042      ) MPTCP	(duration   503ms) [ OK ]
# ns1 MPTCP -> ns1 (10.0.1.1:10043      ) TCP  	(duration   293ms) [ OK ]
# ns1 TCP   -> ns1 (10.0.1.1:10044      ) MPTCP	(duration   281ms) [ OK ]
# ns1 MPTCP -> ns1 (dead:beef:1::1:10045) MPTCP	(duration   276ms) [ OK ]
# ns1 MPTCP -> ns1 (dead:beef:1::1:10046) TCP  	(duration   298ms) [ OK ]
# ns1 TCP   -> ns1 (dead:beef:1::1:10047) MPTCP	(duration   285ms) [ OK ]
# INFO: with peek mode: saveAfterPeek
# ns1 MPTCP -> ns1 (10.0.1.1:10048      ) MPTCP	(duration   279ms) [ OK ]
# ns1 MPTCP -> ns1 (10.0.1.1:10049      ) TCP  	(duration   292ms) [ OK ]
# ns1 TCP   -> ns1 (10.0.1.1:10050      ) MPTCP	(duration   276ms) [ OK ]
# ns1 MPTCP -> ns1 (dead:beef:1::1:10051) MPTCP	(duration   279ms) [ OK ]
# ns1 MPTCP -> ns1 (dead:beef:1::1:10052) TCP  	(duration   296ms) [ OK ]
# ns1 TCP   -> ns1 (dead:beef:1::1:10053) MPTCP	(duration   284ms) [ OK ]
# Time: 133 seconds
ok 1 selftests: net/mptcp: mptcp_connect.sh
# selftests: net/mptcp: pm_netlink.sh
# defaults addr list                                 [ OK ]
# defaults limits                                    [ OK ]
# simple add/get addr                                [ OK ]
# dump addrs                                         [ OK ]
# simple del addr                                    [ OK ]
# dump addrs after del                               [ OK ]
# duplicate addr                                     [ OK ]
# id addr increment                                  [ OK ]
# hard addr limit                                    [ OK ]
# above hard addr limit                              [ OK ]
# id limit                                           [ OK ]
# flush addrs                                        [ OK ]
# rcv addrs above hard limit                         [ OK ]
# subflows above hard limit                          [ OK ]
# set limits                                         [ OK ]
# set ids                                            [ OK ]
# wrap-around ids                                    [ OK ]
ok 2 selftests: net/mptcp: pm_netlink.sh
# selftests: net/mptcp: mptcp_join.sh
# Created /tmp/tmp.hmz5XarEJv (size 1 KB) containing data sent by client
# Created /tmp/tmp.GTVVohoN8T (size 1 KB) containing data sent by server
# 01 no JOIN                              syn[ ok ] - synack[ ok ] - ack[ ok ]
# 02 single subflow, limited by client    syn[ ok ] - synack[ ok ] - ack[ ok ]
# 03 single subflow, limited by server    syn[ ok ] - synack[ ok ] - ack[ ok ]
# 04 single subflow                       syn[ ok ] - synack[ ok ] - ack[ ok ]
# 05 multiple subflows                    syn[ ok ] - synack[ ok ] - ack[ ok ]
# 06 multiple subflows, limited by server syn[ ok ] - synack[ ok ] - ack[ ok ]
# 07 single subflow, dev                  syn[ ok ] - synack[ ok ] - ack[ ok ]
# 08 unused signal address                syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 09 signal address                       syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 10 subflow and signal                   syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 11 multiple subflows and signal         syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 12 signal addresses                     syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 13 signal invalid addresses             syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# Created /tmp/tmp.hmz5XarEJv (size 93440 KB) containing data sent by client
# 14 multiple flows, signal, link failure syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 15 signal address, ADD_ADDR timeout     syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 16 signal address, ADD_ADDR6 timeout    syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 17 signal addresses, ADD_ADDR timeout   syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 18 invalid address, ADD_ADDR timeout    syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 19 remove single subflow                syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 20 remove multiple subflows             syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 21 remove single address                syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 22 remove subflow and signal            syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 23 remove subflows and signal           syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 24 remove addresses                     syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 25 remove invalid addresses             syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 26 flush subflows and signal            syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 27 flush subflows                       syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 28 flush addresses                      syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 29 flush invalid addresses              syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 30 remove id 0 subflow                  syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 31 remove id 0 address                  syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 32 add single subflow                   syn[ ok ] - synack[ ok ] - ack[ ok ]
# 33 add signal address                   syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 34 add multiple subflows                syn[ ok ] - synack[ ok ] - ack[ ok ]
# 35 add multiple subflows IPv6           syn[ ok ] - synack[ ok ] - ack[ ok ]
# 36 add multiple addresses IPv6          syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [fail] got 1 ADD_ADDR echo[s] expected 2
# 
# Server ns stats
# MPTcpExtMPCapableSYNRX          1                  0.0
# MPTcpExtMPCapableACKRX          1                  0.0
# MPTcpExtMPJoinSynRx             2                  0.0
# MPTcpExtMPJoinAckRx             2                  0.0
# MPTcpExtEchoAdd                 1                  0.0
# Client ns stats
# MPTcpExtMPCapableSYNTX          1                  0.0
# MPTcpExtMPCapableSYNACKRX       1                  0.0
# MPTcpExtMPJoinSynAckRx          2                  0.0
# MPTcpExtAddAddr                 2                  0.0
# 37 single subflow IPv6                  syn[ ok ] - synack[ ok ] - ack[ ok ]
# 38 unused signal address IPv6           syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 39 single address IPv6                  syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 40 remove single address IPv6           syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 41 remove subflow and signal IPv6       syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 42 single subflow IPv4-mapped           syn[ ok ] - synack[ ok ] - ack[ ok ]
# 43 signal address IPv4-mapped           syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 44 single subflow v4-map-v6             syn[ ok ] - synack[ ok ] - ack[ ok ]
# 45 signal address v4-map-v6             syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 46 single subflow v6-map-v4             syn[ ok ] - synack[ ok ] - ack[ ok ]
# 47 signal address v6-map-v4             syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 48 no JOIN with diff families v4-v6     syn[ ok ] - synack[ ok ] - ack[ ok ]
# 49 no JOIN with diff families v4-v6-2   syn[ ok ] - synack[ ok ] - ack[ ok ]
# 50 no JOIN with diff families v6-v4     syn[ ok ] - synack[ ok ] - ack[ ok ]
# 51 single subflow, backup               syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         ptx[ ok ] - prx   [ ok ]
# 52 single address, backup               syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
#                                         ptx[ ok ] - prx   [ ok ]
# 53 signal address with port             syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ] - pt [ ok ]
#                                         syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         syn[ ok ] - ack   [ ok ]
# 54 subflow and signal with port         syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ] - pt [ ok ]
#                                         syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         syn[ ok ] - ack   [ ok ]
# 55 remove single address with port      syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ] - pt [ ok ]
#                                         syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         syn[ ok ] - ack   [ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 56 remove subflow and signal with port  syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ] - pt [ ok ]
#                                         syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         syn[ ok ] - ack   [ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 57 flush subflows and signal with port  syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
#                                         rm [ ok ] - sf    [ ok ]
# 58 multiple addresses with port         syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ] - pt [ ok ]
#                                         syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         syn[ ok ] - ack   [ ok ]
# 59 multiple addresses with ports        syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ] - pt [ ok ]
#                                         syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         syn[ ok ] - ack   [ ok ]
# 60 single subflow with syn cookies      syn[ ok ] - synack[ ok ] - ack[ ok ]
# 61 multiple subflows with syn cookies   syn[ ok ] - synack[ ok ] - ack[ ok ]
# 62 subflows limited by server w cookies syn[ ok ] - synack[ ok ] - ack[ ok ]
# 63 signal address with syn cookies      syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 64 subflow and signal w cookies         syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
# 65 subflows and signal w. cookies       syn[ ok ] - synack[ ok ] - ack[ ok ]
#                                         add[ ok ] - echo  [ ok ]
#
not ok 3 selftests: net/mptcp: mptcp_join.sh # TIMEOUT 600 seconds
# selftests: net/mptcp: diag.sh
# no msk on netns creation                          [  ok  ]
# after MPC handshake                               [  ok  ]
# ....chk remote_key                                [  ok  ]
# ....chk no fallback                               [  ok  ]
# check fallback                                    [  ok  ]
# many msk socket present                           [  ok  ]
ok 4 selftests: net/mptcp: diag.sh
# selftests: net/mptcp: simult_flows.sh
# balanced bwidth                                     4674 max 5005 [ OK ]
# balanced bwidth - reverse direction                 4642 max 5005 [ OK ]
# balanced bwidth with unbalanced delay               4643 max 5005 [ OK ]
# balanced bwidth with unbalanced delay - reverse direction  4645 max 5005 [ OK ]
# unbalanced bwidth                                   3024 max 3245 [ OK ]
# unbalanced bwidth - reverse direction               3095 max 3245 [ OK ]
# unbalanced bwidth with unbalanced delay             3199 max 3245 [ OK ]
# unbalanced bwidth with unbalanced delay - reverse direction  3026 max 3245 [ OK ]
# unbalanced bwidth with opposed, unbalanced delay    3115 max 3245 [ OK ]
# unbalanced bwidth with opposed, unbalanced delay - reverse direction  3056 max 3245 [ OK ]
ok 5 selftests: net/mptcp: simult_flows.sh
# selftests: net/mptcp: mptcp_sockopt.sh
# Created /tmp/tmp.lNuwYVM4uY (size 1 KB) containing data sent by client
# Created /tmp/tmp.WibeqPcNW6 (size 1 KB) containing data sent by server
# PASS: all packets had packet mark set
ok 6 selftests: net/mptcp: mptcp_sockopt.sh
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867/tools/testing/selftests/net/mptcp'

--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---
:#! jobs/kernel-selftests.yaml:
suite: kernel-selftests
testcase: kernel-selftests
category: functional
kconfig: x86_64-rhel-8.3-kselftests
need_memory: 3G
need_cpu: 2
kernel-selftests:
  group: mptcp
kernel_cmdline: sysctl.debug.test_sysctl.boot_int=1
job_origin: kernel-selftests.yaml
:#! queue options:
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-knm01
tbox_group: lkp-knm01
submit_id: 6135f92a20c7906fcaafd828
job_file: "/lkp/jobs/scheduled/lkp-knm01/kernel-selftests-mptcp-ucode=0x11-debian-10.4-x86_64-20200603.cgz-9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867-20210906-94154-p5h154-0.yaml"
id: dc6d5ddd40a997b59d0ee2623bf333720c5c65da
queuer_version: "/lkp-src"
:#! hosts/lkp-knm01:
model: Knights Mill
nr_node: 2
nr_cpu: 288
memory: 80G
nr_hdd_partitions: 2
nr_ssd_partitions: 2
hdd_partitions:
- "/dev/disk/by-id/ata-WDC_WD30EZRX-00SPEB0_WD-WCC4E4EK5J23-part2"
- "/dev/disk/by-id/ata-WDC_WD30EZRX-00SPEB0_WD-WCC4E4EK5J23-part3"
ssd_partitions:
- "/dev/disk/by-id/nvme-INTEL_SSDPECME016T4_CVF8709100031P6IGN-1-part1"
- "/dev/disk/by-id/nvme-INTEL_SSDPECME016T4_CVF8709100031P6IGN-2-part1"
swap_partitions: LABEL=SWAP
rootfs_partition: "/dev/disk/by-id/ata-WDC_WD30EZRX-00SPEB0_WD-WCC4E4EK5J23-part1"
brand: Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz
:#! include/category/functional:
kmsg:
heartbeat:
meminfo:
:#! include/queue/cyclic:
commit: 9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867
:#! include/testbox/lkp-knm01:
need_kconfig_hw:
- IGB: y
- SATA_AHCI
- BLK_DEV_NVME
ucode: '0x11'
bisect_dmesg: true
:# for sysctl:
:#! include/kernel-selftests:
need_kconfig:
- BLOCK: y
- BTRFS_FS: m
- EFI: y
- EFIVAR_FS
- FTRACE: y
- IP_ADVANCED_ROUTER: y
- IP_MULTIPLE_TABLES: y
- MEMORY_HOTPLUG_SPARSE: y
- MEMORY_NOTIFIER_ERROR_INJECT
- NOTIFIER_ERROR_INJECTION
- RC_CORE: m, v4.14-rc1
- RC_DECODERS: y
- RC_DEVICES: y
- RUNTIME_TESTING_MENU: y
- STAGING: y
- SYNC_FILE: y
- TEST_FIRMWARE
- TEST_KMOD: m
- TEST_LKM: m
- TEST_USER_COPY
- TUN: m
- XFS_FS: m
initrds:
- linux_headers
- linux_selftests
enqueue_time: 2021-09-06 19:19:06.394949820 +08:00
_id: 6135f92a20c7906fcaafd828
_rt: "/result/kernel-selftests/mptcp-ucode=0x11/lkp-knm01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867"
:#! schedule options:
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: 29414d6e109d1dd7d5c7002a4078b26f08a79c1a
base_commit: 7d2a07b769330c34b4deabeed939325c77a7ec2f
branch: linux-devel/devel-hourly-20210904-000148
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/kernel-selftests/mptcp-ucode=0x11/lkp-knm01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867/0"
scheduler_version: "/lkp/lkp/.src-20210906-182405"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-knm01/kernel-selftests-mptcp-ucode=0x11-debian-10.4-x86_64-20200603.cgz-9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867-20210906-94154-p5h154-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-kselftests
- branch=linux-devel/devel-hourly-20210904-000148
- commit=9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867/vmlinuz-5.14.0-rc1-00300-g9d3684c24a52
- sysctl.debug.test_sysctl.boot_int=1
- max_uptime=2100
- RESULT_ROOT=/result/kernel-selftests/mptcp-ucode=0x11/lkp-knm01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-kselftests/gcc-9/9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867/modules.cgz"
linux_headers_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867/linux-headers.cgz"
linux_selftests_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867/linux-selftests.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20210707.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/kernel-selftests_20210905.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/kernel-selftests-x86_64-fb843668-1_20210905.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20210222.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn
:#! /lkp/lkp/.src-20210903-234613/include/site/inn:
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
:#! runtime status:
last_kernel: 5.14.0-wt-ath-12269-g9517605f81f7
:#! user overrides:
kernel: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-9/9d3684c24a5232c2d7ea8f8a3e60fe235e6a9867/vmlinuz-5.14.0-rc1-00300-g9d3684c24a52"
dequeue_time: 2021-09-06 19:54:01.347244014 +08:00
:#! /lkp/lkp/.src-20210906-182405/include/site/inn:
job_state: finished
loadavg: 4.51 3.86 2.62 1/2382 25402
start_time: '1630929614'
end_time: '1630930459'
version: "/lkp/lkp/.src-20210906-182449:06287f43-dirty:685b99280"

--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

ln -sf /usr/bin/clang
ln -sf /usr/bin/llc
sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
make -j288 -C net/mptcp
make run_tests -C net/mptcp

--wLAMOaPNJ0fu1fTG--
