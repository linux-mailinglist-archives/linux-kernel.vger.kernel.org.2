Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38D1402245
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 04:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbhIGCbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 22:31:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232888AbhIGCbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 22:31:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D68D6109F;
        Tue,  7 Sep 2021 02:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630981814;
        bh=C06lQGO377GWWGV9cs+hzMWWnLCluCxt2xHSUMKhDCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VNl2XwAQ5u/BFocwGAZWl+/43FYMQIqlfljFfWgnmaXa11dpHvjcfaw8JhKN9J3Ka
         qQGKm32050Bi+MmGyquJnkvzExnkT0LZwv86sKKs+39tFU/Pqyj6+N1uToN6P6yhnt
         FlNKXSl9Vh+XvUjYGK6o6tI6LR7Wsm3H8MirL3xzNSUgDJmhgGxe/umXlfHVf7OPiF
         9EbMN2dPzDpDGsUBMtfqPoJD6t6bbfbP3odAaElFwmxC7/b2LgXVLKsXYVAiuPPRLd
         6BjkKnKHmeixx2wR5kO735/u0l3cOfvff95LWqJF7Rc1T+xluh1wMpJTiBnQLG6hfK
         2cU0kqFGYUiew==
Date:   Mon, 6 Sep 2021 19:30:11 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
Message-ID: <YTbOs13waorzamZ6@Ryzen-9-3900X.localdomain>
References: <20210906142615.GA1917503@roeck-us.net>
 <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2021 at 09:12:12AM -0700, Linus Torvalds wrote:
> On Mon, Sep 6, 2021 at 7:26 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Build results:
> >         total: 153 pass: 89 fail: 64
> 
> Well, that sadly proves the point of that patch. x86-64 may be clean,
> because I have required it manually. Others not necessarily so much..
> 
> I've got at least one sparc64 fix in my inbox. It _might_ fix some
> other cases too (syscall checking), but I suspect it's one of those
> "death by a thousand cuts" situations, not just one or two issues that
> show up.
> 
> Do you end up exposing the errors anywhere where I can take a look?
> 
> If some of them are just because of bad tooling on certain
> architectures (ie fundamentally "this is unfixable, because we use
> gcc-XYZ that just always causes warnings") then those we could/should
> just disable -Werror for those and forget about them.
> 
> But hopefully most cases are just "people haven't cared enough" and
> easily fixed.

Our clang builds got bit pretty hard by this. From my local builds
(clang-14), the following ones failed (file name describes the config)
along with the errors plus some triage. -Wframe-larger-than= appears to
be the most common warning. I apologize if this email is too long or
convoluted, I can try to break it down better in the future.



arm32-allmodconfig.log: arch/arm/lib/xor-neon.c:30:2: error: This code requires at least version 4.6 of GCC [-Werror,-W#warnings]
arm32-alpine.log: arch/arm/lib/xor-neon.c:30:2: error: This code requires at least version 4.6 of GCC [-Werror,-W#warnings]
arm32-debian.log: arch/arm/lib/xor-neon.c:30:2: error: This code requires at least version 4.6 of GCC [-Werror,-W#warnings
arm32-fedora.log: arch/arm/lib/xor-neon.c:30:2: error: This code requires at least version 4.6 of GCC [-Werror,-W#warnings]
arm32-opensuse.log: arch/arm/lib/xor-neon.c:30:2: error: This code requires at least version 4.6 of GCC [-Werror,-W#warnings]
arm32-v7-archlinux.log:arch/arm/lib/xor-neon.c:30:2: error: This code requires at least version 4.6 of GCC [-Werror,-W#warnings]

This has been tracked for a while with no real resolution:

https://github.com/ClangBuiltLinux/linux/issues/496
https://github.com/ClangBuiltLinux/linux/issues/503
https://lore.kernel.org/r/20190528235742.105510-1-natechancellor@gmail.com/
https://lore.kernel.org/r/20201106051436.2384842-1-adrian.ratiu@collabora.com/
https://lore.kernel.org/r/20201112212457.2042105-1-adrian.ratiu@collabora.com/



arm32-allmodconfig.log: drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c:157:11: error: variable 'err' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
arm32-allmodconfig.log: drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c:257:7: error: variable 'err' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
arm32-allmodconfig.log: drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c:262:7: error: variable 'err' is used uninitialized whenever switch case is taken [-Werror,-Wsometimes-uninitialized]

This affected a great number of configs. It is known and is being fixed:

https://lore.kernel.org/r/CA+G9fYsV7sTfaefGj3bpkvVdRQUeiWCVRiu6ovjtM=qri-HJ8g@mail.gmail.com/
https://lore.kernel.org/r/20210902190554.211497-4-saeed@kernel.org/

Unfortunately, these uninitialized warnings will constantly plague us
because GCC does not warn due to -Wmaybe-uninitialized being disabled
because it is not as reliable as the clang warning.



arm32-allmodconfig.log: crypto/wp512.c:782:13: error: stack frame size (1176) exceeds limit (1024) in function 'wp512_process_buffer' [-Werror,-Wframe-larger-than]
arm32-allmodconfig.log: drivers/firmware/tegra/bpmp-debugfs.c:294:12: error: stack frame size (1256) exceeds limit (1024) in function 'bpmp_debug_show' [-Werror,-Wframe-larger-than]
arm32-allmodconfig.log: drivers/firmware/tegra/bpmp-debugfs.c:357:16: error: stack frame size (1264) exceeds limit (1024) in function 'bpmp_debug_store' [-Werror,-Wframe-larger-than]
arm32-allmodconfig.log: drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:3043:6: error: stack frame size (1384) exceeds limit (1024) in function 'bw_calcs' [-Werror,-Wframe-larger-than]
arm32-allmodconfig.log: drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:77:13: error: stack frame size (5560) exceeds limit (1024) in function 'calculate_bandwidth' [-Werror,-Wframe-larger-than]
arm32-allmodconfig.log: drivers/mtd/chips/cfi_cmdset_0001.c:1872:12: error: stack frame size (1064) exceeds limit (1024) in function 'cfi_intelext_writev' [-Werror,-Wframe-larger-than]
arm32-allmodconfig.log: drivers/ntb/hw/idt/ntb_hw_idt.c:1041:27: error: stack frame size (1032) exceeds limit (1024) in function 'idt_scan_mws' [-Werror,-Wframe-larger-than]
arm32-allmodconfig.log: drivers/staging/fbtft/fbtft-core.c:902:12: error: stack frame size (1072) exceeds limit (1024) in function 'fbtft_init_display_from_property' [-Werror,-Wframe-larger-than]
arm32-allmodconfig.log: drivers/staging/fbtft/fbtft-core.c:992:5: error: stack frame size (1064) exceeds limit (1024) in function 'fbtft_init_display' [-Werror,-Wframe-larger-than]
arm32-allmodconfig.log: drivers/staging/rtl8723bs/core/rtw_security.c:1288:5: error: stack frame size (1040) exceeds limit (1024) in function 'rtw_aes_decrypt' [-Werror,-Wframe-larger-than]
arm32-fedora.log: drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:3043:6: error: stack frame size (1376) exceeds limit (1024) in function 'bw_calcs' [-Werror,-Wframe-larger-than]
arm32-fedora.log: drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:77:13: error: stack frame size (5384) exceeds limit (1024) in function 'calculate_bandwidth' [-Werror,-Wframe-larger-than]

Aside from the dce_calcs.c warnings, these do not seem too bad. I
believe allmodconfig turns on UBSAN but it could also be aggressive
inlining by clang. I intend to look at all -Wframe-large-than warnings
closely later.



arm64-alpine.log:drivers/scsi/lpfc/lpfc_init.c:11608:48: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
arm64-alpine.log:drivers/scsi/lpfc/lpfc_init.c:8280:29: error: no member named 'c_stat' in 'struct lpfc_sli4_hba'
arm64-alpine.log:drivers/scsi/lpfc/lpfc_init.c:9092:48: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
arm64-alpine.log:drivers/scsi/lpfc/lpfc_nvme.c:1592:3: error: use of undeclared identifier 'start'
arm64-alpine.log:drivers/scsi/lpfc/lpfc_nvme.c:1639:28: error: use of undeclared identifier 'start'; did you mean 'cstat'?
arm64-alpine.log:drivers/scsi/lpfc/lpfc_scsi.c:5587:2: error: use of undeclared identifier 'start'
arm64-alpine.log:drivers/scsi/lpfc/lpfc_scsi.c:5670:27: error: use of undeclared identifier 'start'
x86_64-alpine.log:drivers/scsi/lpfc/lpfc_init.c:11608:48: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
x86_64-alpine.log:drivers/scsi/lpfc/lpfc_init.c:8280:29: error: no member named 'c_stat' in 'struct lpfc_sli4_hba'
x86_64-alpine.log:drivers/scsi/lpfc/lpfc_init.c:9092:48: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
x86_64-alpine.log:drivers/scsi/lpfc/lpfc_nvme.c:1592:3: error: use of undeclared identifier 'start'
x86_64-alpine.log:drivers/scsi/lpfc/lpfc_nvme.c:1639:28: error: use of undeclared identifier 'start'
x86_64-alpine.log:drivers/scsi/lpfc/lpfc_scsi.c:5587:2: error: use of undeclared identifier 'start'
x86_64-alpine.log:drivers/scsi/lpfc/lpfc_scsi.c:5670:27: error: use of undeclared identifier 'start'; did you mean 'stac'?

The -Wshift-count-overflow warnings only show because there are other
errors in this file. This appears to be because some variables or
members of a structure are defined when the lpfc debug config is
disabled. I'll send patches for these later.



arm64-archlinux.log: arch/arm64/crypto/aes-neonbs-glue.c:270:12: error: stack frame size (1056) exceeds limit (1024) in function 'aesbs_xts_setkey' [-Werror,-Wframe-larger-than]
arm64-archlinux.log: drivers/char/ipmi/ipmi_msghandler.c:4850:13: error: stack frame size (1072) exceeds limit (1024) in function 'ipmi_panic_request_and_wait' [-Werror,-Wframe-larger-than]
arm64-archlinux.log: drivers/crypto/ccp/ccp-ops.c:629:1: error: stack frame size (1072) exceeds limit (1024) in function 'ccp_run_aes_gcm_cmd' [-Werror,-Wframe-larger-than]
arm64-archlinux.log: drivers/firmware/tegra/bpmp-debugfs.c:294:12: error: stack frame size (1296) exceeds limit (1024) in function 'bpmp_debug_show' [-Werror,-Wframe-larger-than]
arm64-archlinux.log: drivers/firmware/tegra/bpmp-debugfs.c:357:16: error: stack frame size (1328) exceeds limit (1024) in function 'bpmp_debug_store' [-Werror,-Wframe-larger-than]
arm64-archlinux.log: drivers/gpu/drm/radeon/radeon_cs.c:661:5: error: stack frame size (1184) exceeds limit (1024) in function 'radeon_cs_ioctl' [-Werror,-Wframe-larger-than]
arm64-archlinux.log: drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1779:5: error: stack frame size (1152) exceeds limit (1024) in function 'arm_smmu_atc_inv_domain' [-Werror,-Wframe-larger-than]
arm64-archlinux.log: drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1851:13: error: stack frame size (1136) exceeds limit (1024) in function '__arm_smmu_tlb_inv_range' [-Werror,-Wframe-larger-than]
arm64-archlinux.log: drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:2295:13: error: stack frame size (1136) exceeds limit (1024) in function 'arm_smmu_disable_ats' [-Werror,-Wframe-larger-than]
arm64-archlinux.log: drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:952:13: error: stack frame size (1152) exceeds limit (1024) in function 'arm_smmu_sync_cd' [-Werror,-Wframe-larger-than]
arm64-archlinux.log: drivers/net/wireguard/allowedips.c:255:6: error: stack frame size (1120) exceeds limit (1024) in function 'wg_allowedips_free' [-Werror,-Wframe-larger-than]
arm64-archlinux.log: drivers/net/wireguard/allowedips.c:53:13: error: stack frame size (1088) exceeds limit (1024) in function 'root_free_rcu' [-Werror,-Wframe-larger-than]
arm64-archlinux.log: drivers/staging/fbtft/fb_hx8353d.c:20:12: error: stack frame size (1040) exceeds limit (1024) in function 'init_display' [-Werror,-Wframe-larger-than]
arm64-archlinux.log: drivers/staging/fbtft/fb_ssd1331.c:131:12: error: stack frame size (1360) exceeds limit (1024) in function 'set_gamma' [-Werror,-Wframe-larger-than]
arm64-archlinux.log: drivers/staging/fbtft/fb_ssd1351.c:120:12: error: stack frame size (1360) exceeds limit (1024) in function 'set_gamma' [-Werror,-Wframe-larger-than]
arm64-archlinux.log: drivers/staging/fbtft/fbtft-core.c:902:12: error: stack frame size (1040) exceeds limit (1024) in function 'fbtft_init_display_from_property' [-Werror,-Wframe-larger-than]
arm64-archlinux.log: drivers/vhost/scsi.c:1543:1: error: stack frame size (1152) exceeds limit (1024) in function 'vhost_scsi_set_endpoint' [-Werror,-Wframe-larger-than]
arm64-archlinux.log: drivers/vhost/scsi.c:1670:1: error: stack frame size (1136) exceeds limit (1024) in function 'vhost_scsi_clear_endpoint' [-Werror,-Wframe-larger-than]
arm64-archlinux.log: drivers/vhost/scsi.c:1831:12: error: stack frame size (1376) exceeds limit (1024) in function 'vhost_scsi_release' [-Werror,-Wframe-larger-than]
arm64-archlinux.log: fs/binfmt_elf.c:766:12: error: stack frame size (1072) exceeds limit (1024) in function 'parse_elf_properties' [-Werror,-Wframe-larger-than]
arm64-archlinux.log: fs/binfmt_elf.c:766:12: error: stack frame size (1088) exceeds limit (1024) in function 'parse_elf_properties' [-Werror,-Wframe-larger-than]
arm64-archlinux.log: fs/select.c:970:12: error: stack frame size (1040) exceeds limit (1024) in function 'do_sys_poll' [-Werror,-Wframe-larger-than]
arm64-archlinux.log: net/core/rtnetlink.c:3251:12: error: stack frame size (1088) exceeds limit (1024) in function '__rtnl_newlink' [-Werror,-Wframe-larger-than]
arm64-archlinux.log: net/sunrpc/auth_gss/gss_krb5_crypto.c:599:1: error: stack frame size (1152) exceeds limit (1024) in function 'gss_krb5_aes_encrypt' [-Werror,-Wframe-larger-than]
arm64-fedora.log: arch/arm64/crypto/aes-neonbs-glue.c:270:12: error: stack frame size (1040) exceeds limit (1024) in function 'aesbs_xts_setkey' [-Werror,-Wframe-larger-than]
arm64-fedora.log: drivers/block/drbd/drbd_main.c:2507:5: error: stack frame size (1088) exceeds limit (1024) in function 'set_resource_options' [-Werror,-Wframe-larger-than]
arm64-fedora.log: drivers/char/ipmi/ipmi_msghandler.c:4850:13: error: stack frame size (1072) exceeds limit (1024) in function 'ipmi_panic_request_and_wait' [-Werror,-Wframe-larger-than]
arm64-fedora.log: drivers/clk/zynqmp/clkc.c:768:12: error: stack frame size (1040) exceeds limit (1024) in function 'zynqmp_clock_probe' [-Werror,-Wframe-larger-than]
arm64-fedora.log: drivers/crypto/ccp/ccp-ops.c:629:1: error: stack frame size (1056) exceeds limit (1024) in function 'ccp_run_aes_gcm_cmd' [-Werror,-Wframe-larger-than]
arm64-fedora.log: drivers/firmware/tegra/bpmp-debugfs.c:294:12: error: stack frame size (1296) exceeds limit (1024) in function 'bpmp_debug_show' [-Werror,-Wframe-larger-than]
arm64-fedora.log: drivers/firmware/tegra/bpmp-debugfs.c:357:16: error: stack frame size (1328) exceeds limit (1024) in function 'bpmp_debug_store' [-Werror,-Wframe-larger-than]
arm64-fedora.log: drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1779:5: error: stack frame size (1152) exceeds limit (1024) in function 'arm_smmu_atc_inv_domain' [-Werror,-Wframe-larger-than]
arm64-fedora.log: drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1851:13: error: stack frame size (1136) exceeds limit (1024) in function '__arm_smmu_tlb_inv_range' [-Werror,-Wframe-larger-than]
arm64-fedora.log: drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:2295:13: error: stack frame size (1136) exceeds limit (1024) in function 'arm_smmu_disable_ats' [-Werror,-Wframe-larger-than]
arm64-fedora.log: drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:952:13: error: stack frame size (1152) exceeds limit (1024) in function 'arm_smmu_sync_cd' [-Werror,-Wframe-larger-than]
arm64-fedora.log: drivers/net/ethernet/freescale/dpaa/dpaa_eth.c:3308:12: error: stack frame size (8400) exceeds limit (1024) in function 'dpaa_eth_probe' [-Werror,-Wframe-larger-than]
arm64-fedora.log: drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c:534:12: error: stack frame size (4208) exceeds limit (1024) in function 'dpaa_set_coalesce' [-Werror,-Wframe-larger-than]
arm64-fedora.log: drivers/net/wireguard/allowedips.c:255:6: error: stack frame size (1120) exceeds limit (1024) in function 'wg_allowedips_free' [-Werror,-Wframe-larger-than]
arm64-fedora.log: drivers/net/wireguard/allowedips.c:53:13: error: stack frame size (1088) exceeds limit (1024) in function 'root_free_rcu' [-Werror,-Wframe-larger-than]
arm64-fedora.log: drivers/net/wireless/ath/ath11k/mac.c:2539:12: error: stack frame size (1040) exceeds limit (1024) in function 'ath11k_mac_op_hw_scan' [-Werror,-Wframe-larger-than]
arm64-fedora.log: drivers/vhost/scsi.c:1543:1: error: stack frame size (1152) exceeds limit (1024) in function 'vhost_scsi_set_endpoint' [-Werror,-Wframe-larger-than]
arm64-fedora.log: drivers/vhost/scsi.c:1670:1: error: stack frame size (1136) exceeds limit (1024) in function 'vhost_scsi_clear_endpoint' [-Werror,-Wframe-larger-than]
arm64-fedora.log: drivers/vhost/scsi.c:1831:12: error: stack frame size (1360) exceeds limit (1024) in function 'vhost_scsi_release' [-Werror,-Wframe-larger-than]
arm64-fedora.log: fs/binfmt_elf.c:766:12: error: stack frame size (1072) exceeds limit (1024) in function 'parse_elf_properties' [-Werror,-Wframe-larger-than]
arm64-fedora.log: fs/jffs2/xattr.c:775:6: error: stack frame size (1168) exceeds limit (1024) in function 'jffs2_build_xattr_subsystem' [-Werror,-Wframe-larger-than]
arm64-fedora.log: fs/select.c:970:12: error: stack frame size (1040) exceeds limit (1024) in function 'do_sys_poll' [-Werror,-Wframe-larger-than]
arm64-fedora.log: include/linux/module.h:76:12: error: stack frame size (1120) exceeds limit (1024) in function 'init_module' [-Werror,-Wframe-larger-than]
arm64-fedora.log: kernel/cgroup/cpuset.c:1536:12: error: stack frame size (1600) exceeds limit (1024) in function 'update_cpumask' [-Werror,-Wframe-larger-than]
arm64-fedora.log: kernel/cgroup/cpuset.c:1985:12: error: stack frame size (1712) exceeds limit (1024) in function 'update_prstate' [-Werror,-Wframe-larger-than]
arm64-fedora.log: kernel/cgroup/cpuset.c:3200:13: error: stack frame size (1632) exceeds limit (1024) in function 'cpuset_hotplug_workfn' [-Werror,-Wframe-larger-than]
arm64-fedora.log: kernel/irq/affinity.c:338:12: error: stack frame size (1136) exceeds limit (1024) in function 'irq_build_affinity_masks' [-Werror,-Wframe-larger-than]
arm64-fedora.log: kernel/sched/core.c:7934:1: error: stack frame size (1088) exceeds limit (1024) in function '__sched_setaffinity' [-Werror,-Wframe-larger-than]
arm64-fedora.log: kernel/sched/isolation.c:80:19: error: stack frame size (1088) exceeds limit (1024) in function 'housekeeping_setup' [-Werror,-Wframe-larger-than]
arm64-fedora.log: net/core/rtnetlink.c:3251:12: error: stack frame size (1088) exceeds limit (1024) in function '__rtnl_newlink' [-Werror,-Wframe-larger-than]
arm64-fedora.log: net/sunrpc/auth_gss/gss_krb5_crypto.c:599:1: error: stack frame size (1152) exceeds limit (1024) in function 'gss_krb5_aes_encrypt' [-Werror,-Wframe-larger-than]

It appears that both Arch Linux and Fedora define CONFIG_FRAME_WARN
as 1024, below its default of 2048. I am not sure these look particurly
scary (although there are some that are rather large that need to be
looked at).



i386-debian.log: drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:452:13: error: stack frame size (1628) exceeds limit (1024) in function 'dcn_bw_calc_rq_dlg_ttu' [-Werror,-Wframe-larger-than]
i386-debian.log: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20.c:1085:13: error: stack frame size (1356) exceeds limit (1024) in function 'dml20_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation' [-Werror,-Wframe-larger-than]
i386-debian.log: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20.c:3286:6: error: stack frame size (1484) exceeds limit (1024) in function 'dml20_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
i386-debian.log: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20v2.c:1145:13: error: stack frame size (1228) exceeds limit (1024) in function 'dml20v2_DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation' [-Werror,-Wframe-larger-than]
i386-debian.log: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_mode_vba_20v2.c:3393:6: error: stack frame size (1372) exceeds limit (1024) in function 'dml20v2_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
i386-debian.log: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.c:1466:13: error: stack frame size (1308) exceeds limit (1024) in function 'DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation' [-Werror,-Wframe-larger-than]
i386-debian.log: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.c:3397:6: error: stack frame size (1564) exceeds limit (1024) in function 'dml21_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
i386-debian.log: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_rq_dlg_calc_21.c:1657:6: error: stack frame size (1100) exceeds limit (1024) in function 'dml21_rq_dlg_get_dlg_reg' [-Werror,-Wframe-larger-than]
i386-debian.log: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_rq_dlg_calc_21.c:829:13: error: stack frame size (1084) exceeds limit (1024) in function 'dml_rq_dlg_get_dlg_params' [-Werror,-Wframe-larger-than]
i386-debian.log: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_rq_dlg_calc_30.c:1831:6: error: stack frame size (1108) exceeds limit (1024) in function 'dml30_rq_dlg_get_dlg_reg' [-Werror,-Wframe-larger-than]
i386-debian.log: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_rq_dlg_calc_30.c:981:13: error: stack frame size (1148) exceeds limit (1024) in function 'dml_rq_dlg_get_dlg_params' [-Werror,-Wframe-larger-than]
i386-debian.log: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31.c:939:13: error: stack frame size (1372) exceeds limit (1024) in function 'dml_rq_dlg_get_dlg_params' [-Werror,-Wframe-larger-than]
i386-debian.log: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dml1_display_rq_dlg_calc.c:997:6: error: stack frame size (1212) exceeds limit (1024) in function 'dml1_rq_dlg_get_dlg_params' [-Werror,-Wframe-larger-than]

I am guessing these are all excessive due to the floating point logic
and more inlining. I have investigated some of these previously due to
prior reports:

https://github.com/ClangBuiltLinux/linux/issues/693
https://github.com/ClangBuiltLinux/linux/issues/694
https://github.com/ClangBuiltLinux/linux/issues/695



powerpc64le-debian.log:drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:1918:13: error: stack frame size (2208) exceeds limit (2048) in function 'DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation' [-Werror,-Wframe-larger-than]
powerpc64le-debian.log:drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3644:6: error: stack frame size (2496) exceeds limit (2048) in function 'dml30_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
powerpc64le-debian.log:drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c:3956:6: error: stack frame size (2720) exceeds limit (2048) in function 'dml31_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
powerpc64le-fedora.log:drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:1918:13: error: stack frame size (2208) exceeds limit (2048) in function 'DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation' [-Werror,-Wframe-larger-than]
powerpc64le-fedora.log:drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3644:6: error: stack frame size (2496) exceeds limit (2048) in function 'dml30_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
powerpc64le-fedora.log:drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c:3956:6: error: stack frame size (2720) exceeds limit (2048) in function 'dml31_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
powerpc64le-opensuse.log:drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:1918:13: error: stack frame size (2208) exceeds limit (2048) in function 'DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation' [-Werror,-Wframe-larger-than]
powerpc64le-opensuse.log:drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3644:6: error: stack frame size (2496) exceeds limit (2048) in function 'dml30_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
powerpc64le-opensuse.log:drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c:3956:6: error: stack frame size (2720) exceeds limit (2048) in function 'dml31_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]


I suspect this is a backend problem because these do not really appear
in any other configurations (maybe with Altivec?)



powerpc64le-debian.log:drivers/net/ethernet/sfc/falcon/farch.c:994:10: error: shift count is negative [-Werror,-Wshift-count-negative]
powerpc64le-debian.log:drivers/net/ethernet/sfc/farch.c:985:10: error: shift count is negative [-Werror,-Wshift-count-negative]
powerpc64le-opensuse.log:drivers/net/ethernet/sfc/falcon/farch.c:994:10: error: shift count is negative [-Werror,-Wshift-count-negative]
powerpc64le-opensuse.log:drivers/net/ethernet/sfc/farch.c:985:10: error: shift count is negative [-Werror,-Wshift-count-negative]

I believe this is a false positive due to a bug with how clang models
asm goto in the control flow graph: https://bugs.llvm.org/show_bug.cgi?id=51682



riscv-allmodconfig.log:crypto/ecc.c:1276:13: error: stack frame size (3392) exceeds limit (2048) in function 'ecc_point_mult' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:crypto/ecc.c:1358:6: error: stack frame size (3168) exceeds limit (2048) in function 'ecc_point_mult_shamir' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/block/drbd/drbd_receiver.c:924:12: error: stack frame size (2080) exceeds limit (2048) in function 'conn_connect' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/block/loop.c:1818:12: error: stack frame size (2592) exceeds limit (2048) in function 'lo_ioctl' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/crypto/ccree/cc_hash.c:1882:5: error: stack frame size (2528) exceeds limit (2048) in function 'cc_init_hash_sram' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgf100.c:567:1: error: stack frame size (3520) exceeds limit (2048) in function 'gf100_ram_new_' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c:1521:1: error: stack frame size (5856) exceeds limit (2048) in function 'gk104_ram_new_' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgt215.c:940:1: error: stack frame size (2624) exceeds limit (2048) in function 'gt215_ram_new' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/gpu/drm/rockchip/cdn-dp-core.c:1126:12: error: unused function 'cdn_dp_resume' [-Werror,-Wunused-function]
riscv-allmodconfig.log:drivers/hwmon/occ/common.c:1150:5: error: stack frame size (3008) exceeds limit (2048) in function 'occ_setup' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/infiniband/hw/ocrdma/ocrdma_stats.c:686:16: error: stack frame size (20736) exceeds limit (2048) in function 'ocrdma_dbgfs_ops_read' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/media/common/cx2341x.c:1574:5: error: stack frame size (2944) exceeds limit (2048) in function 'cx2341x_handler_init' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/media/i2c/cx25840/cx25840-core.c:2294:12: error: stack frame size (2976) exceeds limit (2048) in function 'cx25840_reset' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/media/i2c/cx25840/cx25840-core.c:5651:13: error: stack frame size (2400) exceeds limit (2048) in function 'cx23888_std_setup' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/media/pci/cx23885/cx23885-dvb.c:1187:12: error: stack frame size (2688) exceeds limit (2048) in function 'dvb_register' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/media/pci/ddbridge/ddbridge-core.c:2365:6: error: stack frame size (2336) exceeds limit (2048) in function 'ddb_ports_init' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/media/usb/dvb-usb-v2/mxl111sf-i2c.c:799:5: error: stack frame size (2208) exceeds limit (2048) in function 'mxl111sf_i2c_xfer' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/media/usb/gspca/sn9c2028.c:802:12: error: stack frame size (3168) exceeds limit (2048) in function 'sd_start' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/mtd/chips/cfi_cmdset_0001.c:1872:12: error: stack frame size (2432) exceeds limit (2048) in function 'cfi_intelext_writev' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/net/ethernet/intel/i40e/i40e_ddp.c:264:5: error: stack frame size (2368) exceeds limit (2048) in function 'i40e_ddp_load' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/net/wan/slic_ds26522.c:203:12: error: stack frame size (15328) exceeds limit (2048) in function 'slic_ds26522_probe' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/net/wireless/ath/ath11k/qmi.c:2695:13: error: stack frame size (4384) exceeds limit (2048) in function 'ath11k_qmi_driver_event_work' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/net/wireless/atmel/atmel.c:1050:13: error: stack frame size (2656) exceeds limit (2048) in function 'rx_done_irq' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/net/wireless/atmel/atmel.c:1305:5: error: stack frame size (5152) exceeds limit (2048) in function 'atmel_open' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:15430:13: error: stack frame size (2400) exceeds limit (2048) in function 'wlc_phy_workarounds_nphy_gainctrl' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:17019:13: error: stack frame size (6272) exceeds limit (2048) in function 'wlc_phy_workarounds_nphy' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:25631:1: error: stack frame size (3136) exceeds limit (2048) in function 'wlc_phy_cal_txiqlo_nphy' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:28303:1: error: stack frame size (2464) exceeds limit (2048) in function 'wlc_phy_txpwr_index_nphy' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/net/wireless/intel/ipw2x00/ipw2100.c:5471:12: error: stack frame size (2880) exceeds limit (2048) in function 'ipw2100_configure_security' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c:855:5: error: stack frame size (4672) exceeds limit (2048) in function 'iwl_mvm_ftm_start' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/phy/ti/phy-j721e-wiz.c:1133:12: error: stack frame size (2336) exceeds limit (2048) in function 'wiz_probe' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/rtc/rtc-r9701.c:89:12: error: stack frame size (2400) exceeds limit (2048) in function 'r9701_set_datetime' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/scsi/pm8001/pm80xx_hwi.c:3537:12: error: stack frame size (2368) exceeds limit (2048) in function 'mpi_hw_event' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/scsi/qla2xxx/qla_bsg.c:2787:1: error: stack frame size (3296) exceeds limit (2048) in function 'qla2x00_process_vendor_specific' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/staging/media/hantro/hantro_g2_hevc_dec.c:536:5: error: stack frame size (3616) exceeds limit (2048) in function 'hantro_g2_hevc_dec_run' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/staging/rtl8723bs/core/rtw_security.c:1288:5: error: stack frame size (6976) exceeds limit (2048) in function 'rtw_aes_decrypt' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/staging/rtl8723bs/core/rtw_security.c:865:19: error: stack frame size (5536) exceeds limit (2048) in function 'aes_cipher' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/staging/wlan-ng/cfg80211.c:436:12: error: stack frame size (3904) exceeds limit (2048) in function 'prism2_connect' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/usb/misc/sisusbvga/sisusb.c:1878:12: error: stack frame size (3680) exceeds limit (2048) in function 'sisusb_init_gfxcore' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c:117:12: error: stack frame size (14400) exceeds limit (2048) in function 'lb035q02_connect' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:fs/io_uring.c:6578:12: error: stack frame size (2112) exceeds limit (2048) in function 'io_issue_sqe' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:fs/ocfs2/dlm/dlmdomain.c:1852:12: error: stack frame size (2272) exceeds limit (2048) in function 'dlm_join_domain' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:fs/ocfs2/dlm/dlmmaster.c:701:28: error: stack frame size (2208) exceeds limit (2048) in function 'dlm_get_lock_resource' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:fs/ocfs2/dlm/dlmrecovery.c:427:12: error: stack frame size (2976) exceeds limit (2048) in function 'dlm_do_recovery' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:include/linux/module.h:76:12: error: stack frame size (2848) exceeds limit (2048) in function 'init_module' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:lib/bitfield_kunit.c:60:20: error: stack frame size (11328) exceeds limit (10240) in function 'test_bitfields_constants' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:lib/test_kasan.c:946:13: error: stack frame size (3104) exceeds limit (2048) in function 'kasan_bitops_generic' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:lib/test_scanf.c:217:20: error: stack frame size (4640) exceeds limit (2048) in function 'numbers_simple' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:net/mac80211/mesh.c:1516:6: error: stack frame size (2272) exceeds limit (2048) in function 'ieee80211_mesh_rx_queued_mgmt' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:net/qrtr/ns.c:661:13: error: stack frame size (2144) exceeds limit (2048) in function 'qrtr_ns_worker' [-Werror,-Wframe-larger-than]
riscv-allmodconfig.log:sound/usb/mixer_s1810c.c:543:5: error: stack frame size (2208) exceeds limit (2048) in function 'snd_sc1810_init_mixer' [-Werror,-Wframe-larger-than]

I suspect this is a backend problem because these do not really appear
in any other configurations (might also be something with a sanitizer?)



s390x-defconfig.log: include/asm-generic/io.h:464:31: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
s390x-defconfig.log: include/asm-generic/io.h:477:61: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
s390x-defconfig.log: include/asm-generic/io.h:490:61: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
s390x-defconfig.log: include/asm-generic/io.h:501:33: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
s390x-defconfig.log: include/asm-generic/io.h:511:59: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
s390x-defconfig.log: include/asm-generic/io.h:521:59: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
s390x-defconfig.log: include/asm-generic/io.h:609:20: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
s390x-defconfig.log: include/asm-generic/io.h:617:20: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
s390x-defconfig.log: include/asm-generic/io.h:625:20: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
s390x-defconfig.log: include/asm-generic/io.h:634:21: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
s390x-defconfig.log: include/asm-generic/io.h:643:21: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
s390x-defconfig.log: include/asm-generic/io.h:652:21: error: performing pointer arithmetic on a null pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]

This affected all s390x configs I test. fs/btrfs force enables W=1 so we
get these. This is known and had a solution rejected at pull time:

https://github.com/ClangBuiltLinux/linux/issues/1285
https://lore.kernel.org/r/20210510145234.594814-1-schnelle@linux.ibm.com/
https://lore.kernel.org/r/CAK8P3a2oZ-+qd3Nhpy9VVXCJB3DU5N-y-ta2JpP0t6NHh=GVXw@mail.gmail.com/


s390x-allmodconfig.log:drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:77:13: error: stack frame size (5184) exceeds limit (2048) in function 'calculate_bandwidth' [-Werror,-Wframe-larger-than]

Same deal as the other dc_calcs.c warnings.



x86_64-allmodconfig-O3.log:drivers/net/ethernet/microchip/sparx5/sparx5_calendar.c:566:5: error: stack frame size (2504) exceeds limit (2048) in function 'sparx5_config_dsm_calendar' [-Werror,-Wframe-larger-than]

Probably aggressive inlining due to testing -O3.

x86_64-alpine.log:drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:452:13: error: stack frame size (1800) exceeds limit (1280) in function 'dcn_bw_calc_rq_dlg_ttu' [-Werror,-Wframe-larger-than]
x86_64-alpine.log:drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_rq_dlg_calc_21.c:1657:6: error: stack frame size (1336) exceeds limit (1280) in function 'dml21_rq_dlg_get_dlg_reg' [-Werror,-Wframe-larger-than]
x86_64-alpine.log:drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_rq_dlg_calc_30.c:1831:6: error: stack frame size (1352) exceeds limit (1280) in function 'dml30_rq_dlg_get_dlg_reg' [-Werror,-Wframe-larger-than]
x86_64-alpine.log:drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31.c:1676:6: error: stack frame size (1336) exceeds limit (1280) in function 'dml31_rq_dlg_get_dlg_reg' [-Werror,-Wframe-larger-than]
x86_64-alpine.log:drivers/vhost/scsi.c:1831:12: error: stack frame size (1320) exceeds limit (1280) in function 'vhost_scsi_release' [-Werror,-Wframe-larger-than]

Another instance where distros lower CONFIG_FRAME_WARN below the 2048
default. Again, none look particularly scary but should still probably
be dealt with.

Cheers,
Nathan
