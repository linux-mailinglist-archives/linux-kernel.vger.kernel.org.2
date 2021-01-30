Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8BD30978C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 19:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhA3Sbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 13:31:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229468AbhA3Sbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 13:31:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B9BF64E11;
        Sat, 30 Jan 2021 18:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612031465;
        bh=TbgAbGeixEqY6DER7wM2+Rm8ZQohtsuYknK+dwJwqjs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BAAPOwZGbjPLYbm0oYY5ZQioUZHStCVj9v0s/LEfhx1IBD6dp80aK/NFTf51ExvJA
         n2gEy5zG8TlilslliAZBa1wKlv2KDdQjlY0bukty2/IMtTN09OC0pdHJiC5I4yG4S5
         mCwCRfhHHJ9acs+ThO8a2FoTuDTsdBiDTOgh77ZxbTzX7J7kR/wDo56ZPsp4WzZgK7
         z1ZnJ5jhZDsRYc8aL2CL3xCRM92128C1UhYciXP7yT5eDlnyUx6fWv9ovomrp6sxzU
         XGMxTZT8iNfCYDIwXd8d/DEVuBw4CjF4KIEWdTOQqj0VRLPfxJn/aWq+nlf7zTTj2p
         pAv4IXx05864A==
Date:   Sat, 30 Jan 2021 10:31:04 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@kernel.org>
Subject: Re: bnx2x_main.c:undefined reference to `synchronize_net'
Message-ID: <20210130103104.28a4ed6b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <202101301843.jB5QqizS-lkp@intel.com>
References: <202101301843.jB5QqizS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't understand how this one happens and don't have a PPC build
setup :S So many things seem to depend on NET here that "this should
never happen". Must be some rogue "select" pulling BNX2 without its
dependencies?

On Sat, 30 Jan 2021 18:23:47 +0800 kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   0e9bcda5d286f4a26a5407bb38f55c55b453ecfb
> commit: 5198d545dba8ad893f5e5a029ca8d43ee7bcf011 net: remove napi_hash_del() from driver-facing API
> date:   5 months ago
> config: powerpc64-randconfig-r033-20210130 (attached as .config)
> compiler: powerpc-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5198d545dba8ad893f5e5a029ca8d43ee7bcf011
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 5198d545dba8ad893f5e5a029ca8d43ee7bcf011
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    powerpc-linux-ld: bnx2.c:(.text+0xc4c4): undefined reference to `eth_type_trans'
>    powerpc-linux-ld: bnx2.c:(.text+0xc508): undefined reference to `consume_skb'
>    powerpc-linux-ld: bnx2.c:(.text+0xc5ec): undefined reference to `napi_gro_receive'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2.o: in function `bnx2_poll_msix':
>    bnx2.c:(.text+0xc830): undefined reference to `napi_complete_done'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2.o: in function `bnx2_report_link':
>    bnx2.c:(.text+0xccfc): undefined reference to `netif_carrier_on'
>    powerpc-linux-ld: bnx2.c:(.text+0xcd5c): undefined reference to `netdev_info'
>    powerpc-linux-ld: bnx2.c:(.text+0xce50): undefined reference to `netif_carrier_off'
>    powerpc-linux-ld: bnx2.c:(.text+0xce90): undefined reference to `netdev_err'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2.o: in function `bnx2_setup_serdes_phy':
>    bnx2.c:(.text+0xd4c8): undefined reference to `netif_carrier_off'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2.o: in function `bnx2_shutdown':
>    bnx2.c:(.text+0xda40): undefined reference to `rtnl_lock'
>    powerpc-linux-ld: bnx2.c:(.text+0xda60): undefined reference to `dev_close'
>    powerpc-linux-ld: bnx2.c:(.text+0xdb0c): undefined reference to `rtnl_unlock'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2.o: in function `bnx2_suspend':
>    bnx2.c:(.text+0xdbf0): undefined reference to `netif_device_detach'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2.o: in function `bnx2_set_link_ksettings':
>    bnx2.c:(.text+0xe818): undefined reference to `ethtool_convert_link_mode_to_legacy_u32'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2.o: in function `bnx2_poll':
>    bnx2.c:(.text+0xff4c): undefined reference to `napi_complete_done'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2.o: in function `bnx2_io_slot_reset':
>    bnx2.c:(.text+0x10394): undefined reference to `rtnl_lock'
>    powerpc-linux-ld: bnx2.c:(.text+0x103f0): undefined reference to `dev_close'
>    powerpc-linux-ld: bnx2.c:(.text+0x103f4): undefined reference to `rtnl_unlock'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2.o: in function `bnx2_reset_task':
>    bnx2.c:(.text+0x104f0): undefined reference to `rtnl_lock'
>    powerpc-linux-ld: bnx2.c:(.text+0x10510): undefined reference to `rtnl_unlock'
>    powerpc-linux-ld: bnx2.c:(.text+0x105ac): undefined reference to `netdev_err'
>    powerpc-linux-ld: bnx2.c:(.text+0x105bc): undefined reference to `dev_close'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2.o: in function `bnx2_change_ring_size':
>    bnx2.c:(.text+0x108a4): undefined reference to `dev_close'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2.o: in function `bnx2_open':
>    bnx2.c:(.text+0x1136c): undefined reference to `netif_carrier_off'
>    powerpc-linux-ld: bnx2.c:(.text+0x114ec): undefined reference to `netdev_warn'
>    powerpc-linux-ld: bnx2.c:(.text+0x11588): undefined reference to `netdev_info'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2.o: in function `bnx2_start_xmit':
>    bnx2.c:(.text+0x11704): undefined reference to `netdev_err'
>    powerpc-linux-ld: bnx2.c:(.text+0x118b8): undefined reference to `__dev_kfree_skb_any'
>    powerpc-linux-ld: bnx2.c:(.text+0x11aa8): undefined reference to `netif_tx_wake_queue'
>    powerpc-linux-ld: bnx2.c:(.text+0x11ba8): undefined reference to `__dev_kfree_skb_any'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2.o: in function `bnx2_resume':
>    bnx2.c:(.text+0x11d2c): undefined reference to `netif_device_attach'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2.o: in function `bnx2_dump_mcp_state':
>    bnx2.c:(.text.unlikely+0x30): undefined reference to `netdev_err'
>    powerpc-linux-ld: bnx2.c:(.text.unlikely+0x98): undefined reference to `netdev_err'
>    powerpc-linux-ld: bnx2.c:(.text.unlikely+0xec): undefined reference to `netdev_err'
>    powerpc-linux-ld: bnx2.c:(.text.unlikely+0x140): undefined reference to `netdev_err'
>    powerpc-linux-ld: bnx2.c:(.text.unlikely+0x150): undefined reference to `netdev_err'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2.o:bnx2.c:(.text.unlikely+0x198): more undefined references to `netdev_err' follow
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2.o:(.rodata+0xdb0): undefined reference to `eth_validate_addr'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/cnic.o: in function `cnic_register_driver':
>    (.text+0x1680): undefined reference to `rtnl_lock'
>    powerpc-linux-ld: (.text+0x1698): undefined reference to `rtnl_unlock'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/cnic.o: in function `cnic_shutdown_rings':
>    cnic.c:(.text+0x2810): undefined reference to `netdev_err'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/cnic.o: in function `cnic_bnx2x_delete_wait':
>    cnic.c:(.text+0x3244): undefined reference to `netdev_warn'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/cnic.o: in function `cnic_cm_stop_bnx2x_hw':
>    cnic.c:(.text+0x336c): undefined reference to `netdev_warn'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/cnic.o: in function `service_kcqes':
>    cnic.c:(.text+0x44d8): undefined reference to `netdev_err'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/cnic.o: in function `cnic_cm_process_kcqe':
>    cnic.c:(.text+0x502c): undefined reference to `netdev_warn'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/cnic.o: in function `cnic_unregister_device':
>    cnic.c:(.text+0x542c): undefined reference to `netdev_warn'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/cnic.o: in function `cnic_cm_connect':
>    cnic.c:(.text+0x57e0): undefined reference to `dst_release'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/cnic.o: in function `cnic_alloc_dev.isra.0':
>    cnic.c:(.text+0x593c): undefined reference to `netdev_info'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/cnic.o: in function `cnic_start_hw':
>    cnic.c:(.text+0x83e4): undefined reference to `netdev_err'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/cnic.o: in function `cnic_netdev_event':
>    cnic.c:(.text+0x8d5c): undefined reference to `netdev_err'
>    powerpc-linux-ld: cnic.c:(.text+0x8ea8): undefined reference to `netdev_err'
>    powerpc-linux-ld: cnic.c:(.text+0x8eb8): undefined reference to `netdev_info'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/cnic.o: in function `cnic_init_rings':
>    cnic.c:(.text+0x96d0): undefined reference to `netdev_err'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/cnic.o: in function `cnic_uio_open':
>    cnic.c:(.text+0x9a84): undefined reference to `rtnl_lock'
>    powerpc-linux-ld: cnic.c:(.text+0x9aac): undefined reference to `rtnl_unlock'
>    powerpc-linux-ld: cnic.c:(.text+0x9ae0): undefined reference to `rtnl_unlock'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/cnic.o: in function `cnic_start_bnx2_hw':
>    cnic.c:(.text+0xa1f8): undefined reference to `netdev_err'
>    powerpc-linux-ld: cnic.c:(.text+0xa294): undefined reference to `netdev_err'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/cnic.o: in function `cnic_submit_bnx2x_fcoe_kwqes':
>    cnic.c:(.text+0xa518): undefined reference to `netdev_err'
>    powerpc-linux-ld: cnic.c:(.text+0xaf30): undefined reference to `netdev_err'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/cnic.o: in function `cnic_submit_bnx2x_iscsi_kwqes':
>    cnic.c:(.text+0xb200): undefined reference to `netdev_err'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/cnic.o:cnic.c:(.text+0xb408): more undefined references to `netdev_err' follow
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/cnic.o: in function `cnic_exit':
>    cnic.c:(.exit.text+0x18): undefined reference to `unregister_netdevice_notifier'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/cnic.o: in function `cnic_init':
>    cnic.c:(.init.text+0x48): undefined reference to `register_netdevice_notifier'
>    powerpc-linux-ld: cnic.c:(.init.text+0xf4): undefined reference to `unregister_netdevice_notifier'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.o: in function `bnx2x_parity_attn':
>    bnx2x_main.c:(.text+0x510c): undefined reference to `netdev_err'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.o: in function `bnx2x_del_all_napi':
> >> bnx2x_main.c:(.text+0x65c0): undefined reference to `synchronize_net'
> >> powerpc-linux-ld: bnx2x_main.c:(.text+0x65d8): undefined reference to `__netif_napi_del'  
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.o: in function `bnx2x_del_all_napi_cnic':
>    bnx2x_main.c:(.text+0x6624): undefined reference to `synchronize_net'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x6674): undefined reference to `__netif_napi_del'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.o: in function `bnx2x_io_resume':
>    bnx2x_main.c:(.text+0x74bc): undefined reference to `netdev_err'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x74cc): undefined reference to `rtnl_lock'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x7550): undefined reference to `netif_device_attach'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x7568): undefined reference to `rtnl_unlock'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.o: in function `bnx2x_features_check':
>    bnx2x_main.c:(.text+0x9150): undefined reference to `skb_gso_validate_mac_len'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x9314): undefined reference to `__pskb_pull_tail'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.o: in function `bnx2x_ptp_task':
>    bnx2x_main.c:(.text+0xa274): undefined reference to `skb_tstamp_tx'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0xa3d0): undefined reference to `__dev_kfree_skb_any'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.o: in function `bnx2x_init_block':
>    bnx2x_main.c:(.text+0xba90): undefined reference to `netdev_err'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0xbac8): undefined reference to `netdev_err'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.o: in function `bnx2x_attn_int_deasserted0':
>    bnx2x_main.c:(.text+0xdd40): undefined reference to `netdev_err'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.o: in function `bnx2x_interrupt':
>    bnx2x_main.c:(.text+0x10900): undefined reference to `napi_schedule_prep'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x1091c): undefined reference to `__napi_schedule_irqoff'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.o: in function `__bnx2x_remove':
>    bnx2x_main.c:(.text+0x1387c): undefined reference to `rtnl_lock'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x1388c): undefined reference to `dev_addr_del'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x13890): undefined reference to `rtnl_unlock'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x138e4): undefined reference to `unregister_netdev'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x139f8): undefined reference to `free_netdev'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x13a7c): undefined reference to `rtnl_lock'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x13a84): undefined reference to `dev_close'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x13a88): undefined reference to `rtnl_unlock'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.o: in function `bnx2x_shutdown':
>    bnx2x_main.c:(.text+0x13bac): undefined reference to `rtnl_lock'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x13bb4): undefined reference to `netif_device_detach'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x13bb8): undefined reference to `rtnl_unlock'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.o: in function `bnx2x_oem_event':
>    bnx2x_main.c:(.text+0x14528): undefined reference to `netif_carrier_off'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x14628): undefined reference to `netif_tx_wake_queue'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.o: in function `bnx2x_open':
>    bnx2x_main.c:(.text+0x1708c): undefined reference to `netif_carrier_off'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x1720c): undefined reference to `netdev_info'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.o: in function `bnx2x_parity_recover':
>    bnx2x_main.c:(.text+0x17648): undefined reference to `netdev_err'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x17650): undefined reference to `netif_device_detach'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x17738): undefined reference to `netdev_err'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x17744): undefined reference to `netif_device_detach'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.o: in function `bnx2x_chip_cleanup':
>    bnx2x_main.c:(.text+0x1df3c): undefined reference to `__dev_kfree_skb_any'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.o: in function `bnx2x_io_slot_reset':
>    bnx2x_main.c:(.text+0x1e354): undefined reference to `rtnl_lock'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x1e3c4): undefined reference to `rtnl_unlock'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x1e4a0): undefined reference to `rtnl_unlock'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.o: in function `bnx2x_init_one':
>    bnx2x_main.c:(.text+0x1ea20): undefined reference to `alloc_etherdev_mqs'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x1eacc): undefined reference to `free_netdev'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x1ecb0): undefined reference to `free_netdev'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x1f014): undefined reference to `register_netdev'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x1f0b4): undefined reference to `rtnl_lock'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x1f0c4): undefined reference to `dev_addr_add'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x1f0c8): undefined reference to `rtnl_unlock'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.o: in function `bnx2x_sp_rtnl_task':
>    bnx2x_main.c:(.text+0x20a40): undefined reference to `rtnl_lock'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x20a60): undefined reference to `rtnl_unlock'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x20b24): undefined reference to `netif_carrier_off'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x20db8): undefined reference to `netif_device_detach'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x20e18): undefined reference to `netif_carrier_off'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x211f8): undefined reference to `rtnl_unlock'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.o: in function `bnx2x_sp_task':
>    bnx2x_main.c:(.text+0x23034): undefined reference to `napi_schedule_prep'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x23050): undefined reference to `__napi_schedule'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.o: in function `bnx2x_io_error_detected':
>    bnx2x_main.c:(.text+0x23138): undefined reference to `rtnl_lock'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x23174): undefined reference to `netif_device_detach'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x23194): undefined reference to `rtnl_unlock'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x2320c): undefined reference to `netif_carrier_off'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x23240): undefined reference to `netdev_reset_tc'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x23294): undefined reference to `netif_carrier_off'
>    powerpc-linux-ld: bnx2x_main.c:(.text+0x232f8): undefined reference to `rtnl_unlock'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.o: in function `bnx2x_fw_dump_lvl':
>    bnx2x_main.c:(.text.unlikely+0x458c): undefined reference to `netdev_printk'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.o: in function `bnx2x_cl45_read':
>    bnx2x_link.c:(.text+0x6f60): undefined reference to `netdev_err'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.o: in function `bnx2x_cl45_write':
>    bnx2x_link.c:(.text+0x876c): undefined reference to `netdev_err'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.o: in function `bnx2x_wait_reset_complete.isra.0':
>    bnx2x_link.c:(.text+0x13a40): undefined reference to `netdev_err'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.o: in function `bnx2x_prepare_xgxs':
>    bnx2x_link.c:(.text+0x15fd4): undefined reference to `netdev_err'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.o: in function `bnx2x_get_edc_mode':
>    bnx2x_link.c:(.text+0x1d59c): undefined reference to `netdev_err'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_link.o:bnx2x_link.c:(.text+0x1dbf8): more undefined references to `netdev_err' follow
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.o: in function `bnx2x_frag_alloc':
>    bnx2x_cmn.c:(.text+0x690): undefined reference to `napi_alloc_frag'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.o: in function `bnx2x_napi_disable_cnic':
>    bnx2x_cmn.c:(.text+0x9a4): undefined reference to `napi_disable'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.o: in function `bnx2x_set_real_num_queues':
>    bnx2x_cmn.c:(.text+0xa10): undefined reference to `netif_set_real_num_tx_queues'
>    powerpc-linux-ld: bnx2x_cmn.c:(.text+0xaa0): undefined reference to `netif_set_real_num_rx_queues'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.o: in function `bnx2x_del_all_napi':
> >> bnx2x_cmn.c:(.text+0xbbc): undefined reference to `synchronize_net'
> >> powerpc-linux-ld: bnx2x_cmn.c:(.text+0xbd4): undefined reference to `__netif_napi_del'  
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.o: in function `bnx2x_msix_fp_int':
>    bnx2x_cmn.c:(.text+0x1434): undefined reference to `napi_schedule_prep'
>    powerpc-linux-ld: bnx2x_cmn.c:(.text+0x1450): undefined reference to `__napi_schedule_irqoff'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.o: in function `bnx2x_setup_irqs':
>    bnx2x_cmn.c:(.text+0x205c): undefined reference to `netdev_info'
>    powerpc-linux-ld: bnx2x_cmn.c:(.text+0x2254): undefined reference to `netdev_info'
>    powerpc-linux-ld: bnx2x_cmn.c:(.text+0x2290): undefined reference to `netdev_info'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.o: in function `bnx2x_free_tx_pkt':
>    bnx2x_cmn.c:(.text+0x3324): undefined reference to `__dev_kfree_skb_any'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.o: in function `bnx2x_tpa_stop.isra.0':
>    bnx2x_cmn.c:(.text+0x355c): undefined reference to `build_skb'
>    powerpc-linux-ld: bnx2x_cmn.c:(.text+0x35b4): undefined reference to `skb_put'
>    powerpc-linux-ld: bnx2x_cmn.c:(.text+0x35ec): undefined reference to `eth_type_trans'
>    powerpc-linux-ld: bnx2x_cmn.c:(.text+0x3738): undefined reference to `napi_gro_receive'
>    powerpc-linux-ld: bnx2x_cmn.c:(.text+0x3764): undefined reference to `__dev_kfree_skb_any'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.o: in function `bnx2x_rx_int':
>    bnx2x_cmn.c:(.text+0x4344): undefined reference to `__napi_alloc_skb'
>    powerpc-linux-ld: bnx2x_cmn.c:(.text+0x43ec): undefined reference to `skb_put'
>    powerpc-linux-ld: bnx2x_cmn.c:(.text+0x43f8): undefined reference to `eth_type_trans'
>    powerpc-linux-ld: bnx2x_cmn.c:(.text+0x44dc): undefined reference to `build_skb'
>    powerpc-linux-ld: bnx2x_cmn.c:(.text+0x4610): undefined reference to `napi_gro_receive'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.o: in function `bnx2x_tx_int':
>    bnx2x_cmn.c:(.text+0x6208): undefined reference to `netif_tx_wake_queue'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.o: in function `bnx2x_poll':
>    bnx2x_cmn.c:(.text+0x62e0): undefined reference to `napi_complete_done'
>    powerpc-linux-ld: bnx2x_cmn.c:(.text+0x6408): undefined reference to `napi_complete_done'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.o: in function `__bnx2x_link_report':
>    bnx2x_cmn.c:(.text+0x68a0): undefined reference to `netif_carrier_off'
>    powerpc-linux-ld: bnx2x_cmn.c:(.text+0x68b0): undefined reference to `netdev_err'
>    powerpc-linux-ld: bnx2x_cmn.c:(.text+0x68c4): undefined reference to `netif_carrier_on'
>    powerpc-linux-ld: bnx2x_cmn.c:(.text+0x6994): undefined reference to `netdev_info'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.o: in function `bnx2x_netif_start':
>    bnx2x_cmn.c:(.text+0x7840): undefined reference to `netif_tx_wake_queue'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.o: in function `bnx2x_netif_stop':
>    bnx2x_cmn.c:(.text+0x78dc): undefined reference to `napi_disable'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.o: in function `bnx2x_select_queue':
>    bnx2x_cmn.c:(.text+0x79c8): undefined reference to `netdev_pick_tx'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.o: in function `bnx2x_set_num_queues':
>    bnx2x_cmn.c:(.text+0x7a3c): undefined reference to `netif_get_num_default_rss_queues'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.o: in function `bnx2x_rss':
>    bnx2x_cmn.c:(.text+0x7c70): undefined reference to `netdev_rss_key_fill'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.o: in function `bnx2x_load_cnic':
>    bnx2x_cmn.c:(.text+0x86b0): undefined reference to `netif_napi_add'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.o: in function `bnx2x_start_xmit':
>    bnx2x_cmn.c:(.text+0x8ebc): undefined reference to `consume_skb'
>    powerpc-linux-ld: bnx2x_cmn.c:(.text+0x93f8): undefined reference to `__pskb_pull_tail'
>    powerpc-linux-ld: bnx2x_cmn.c:(.text+0x949c): undefined reference to `__dev_kfree_skb_any'
>    powerpc-linux-ld: bnx2x_cmn.c:(.text+0x972c): undefined reference to `netdev_printk'
>    powerpc-linux-ld: bnx2x_cmn.c:(.text+0xac78): undefined reference to `skb_tstamp_tx'
>    powerpc-linux-ld: bnx2x_cmn.c:(.text+0xad88): undefined reference to `netif_tx_wake_queue'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.o: in function `bnx2x_setup_tc':
>    bnx2x_cmn.c:(.text+0xb2a8): undefined reference to `rtnl_is_locked'
>    powerpc-linux-ld: bnx2x_cmn.c:(.text+0xb390): undefined reference to `netdev_reset_tc'
>    powerpc-linux-ld: bnx2x_cmn.c:(.text+0xb434): undefined reference to `netdev_set_num_tc'
>    powerpc-linux-ld: bnx2x_cmn.c:(.text+0xb5ec): undefined reference to `netdev_set_tc_queue'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.o: in function `bnx2x_nic_unload':
>    bnx2x_cmn.c:(.text+0xbd4c): undefined reference to `netif_carrier_off'
>    powerpc-linux-ld: bnx2x_cmn.c:(.text+0xbd54): undefined reference to `netdev_reset_tc'
> >> powerpc-linux-ld: bnx2x_cmn.c:(.text+0xbf74): undefined reference to `synchronize_net'  
>    powerpc-linux-ld: bnx2x_cmn.c:(.text+0xbffc): undefined reference to `__netif_napi_del'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.o: in function `bnx2x_suspend':
>    bnx2x_cmn.c:(.text+0xc348): undefined reference to `rtnl_lock'
>    powerpc-linux-ld: bnx2x_cmn.c:(.text+0xc364): undefined reference to `rtnl_unlock'
>    powerpc-linux-ld: bnx2x_cmn.c:(.text+0xc380): undefined reference to `netif_device_detach'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.o: in function `bnx2x_nic_load':
>    bnx2x_cmn.c:(.text+0xd720): undefined reference to `netif_napi_add'
>    powerpc-linux-ld: bnx2x_cmn.c:(.text+0xe638): undefined reference to `netif_tx_wake_queue'
>    powerpc-linux-ld: bnx2x_cmn.c:(.text+0xeb24): undefined reference to `napi_disable'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.o: in function `bnx2x_resume':
>    bnx2x_cmn.c:(.text+0xf03c): undefined reference to `rtnl_lock'
>    powerpc-linux-ld: bnx2x_cmn.c:(.text+0xf058): undefined reference to `rtnl_unlock'
>    powerpc-linux-ld: bnx2x_cmn.c:(.text+0xf074): undefined reference to `netif_device_attach'
>    powerpc-linux-ld: bnx2x_cmn.c:(.text+0xf088): undefined reference to `rtnl_unlock'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.o: in function `bnx2x_set_link_ksettings':
>    bnx2x_ethtool.c:(.text+0x1b3c): undefined reference to `ethtool_convert_link_mode_to_legacy_u32'
>    powerpc-linux-ld: bnx2x_ethtool.c:(.text+0x1b48): undefined reference to `ethtool_convert_link_mode_to_legacy_u32'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.o: in function `bnx2x_get_link_ksettings':
>    bnx2x_ethtool.c:(.text+0x328c): undefined reference to `ethtool_convert_link_mode_to_legacy_u32'
>    powerpc-linux-ld: bnx2x_ethtool.c:(.text+0x3444): undefined reference to `ethtool_convert_legacy_u32_to_link_mode'
>    powerpc-linux-ld: bnx2x_ethtool.c:(.text+0x3450): undefined reference to `ethtool_convert_legacy_u32_to_link_mode'
>    powerpc-linux-ld: bnx2x_ethtool.c:(.text+0x345c): undefined reference to `ethtool_convert_legacy_u32_to_link_mode'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.o: in function `bnx2x_get_ts_info':
>    bnx2x_ethtool.c:(.text+0x4674): undefined reference to `ethtool_op_get_ts_info'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.o: in function `bnx2x_run_loopback':
>    bnx2x_ethtool.c:(.text+0x8a08): undefined reference to `__netdev_alloc_skb'
>    powerpc-linux-ld: bnx2x_ethtool.c:(.text+0x8c44): undefined reference to `skb_put'
>    powerpc-linux-ld: bnx2x_ethtool.c:(.text+0x8e00): undefined reference to `consume_skb'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.o: in function `bnx2x_self_test':
>    bnx2x_ethtool.c:(.text+0xa374): undefined reference to `netdev_err'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bcmsysport.o: in function `rdma_enable_set':
>    bcmsysport.c:(.text+0x834): undefined reference to `netdev_err'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bcmsysport.o: in function `bcm_sysport_remove':
>    bcmsysport.c:(.text+0xa50): undefined reference to `unregister_netdev'
>    powerpc-linux-ld: bcmsysport.c:(.text+0xa84): undefined reference to `free_netdev'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bcmsysport.o: in function `bcm_sysport_dsa_notifier':
>    bcmsysport.c:(.text+0xba0): undefined reference to `netif_set_real_num_tx_queues'
>    powerpc-linux-ld: bcmsysport.c:(.text+0xbd4): undefined reference to `netdev_warn'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bcmsysport.o: in function `bcm_sysport_select_queue':
>    bcmsysport.c:(.text+0xea0): undefined reference to `netdev_pick_tx'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bcmsysport.o: in function `tdma_enable_set':
>    bcmsysport.c:(.text+0x1700): undefined reference to `netdev_err'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bcmsysport.o: in function `bcm_sysport_probe':
>    bcmsysport.c:(.text+0x1d58): undefined reference to `alloc_etherdev_mqs'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x1e24): undefined reference to `free_netdev'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x205c): undefined reference to `netif_napi_add'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x21a4): undefined reference to `netif_carrier_off'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x21c4): undefined reference to `register_netdev'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bcmsysport.o: in function `bcm_sysport_get_stats64':
>    bcmsysport.c:(.text+0x23b4): undefined reference to `netdev_stats_to_stats64'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bcmsysport.o: in function `bcm_sysport_netif_stop':
>    bcmsysport.c:(.text+0x2d10): undefined reference to `napi_disable'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bcmsysport.o: in function `bcm_sysport_init_tx_ring':
>    bcmsysport.c:(.text+0x307c): undefined reference to `netif_napi_add'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x3140): undefined reference to `netdev_err'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bcmsysport.o: in function `bcm_sysport_tx_isr':
>    bcmsysport.c:(.text+0x3344): undefined reference to `netdev_warn'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x33c0): undefined reference to `napi_schedule_prep'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x3418): undefined reference to `__napi_schedule_irqoff'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bcmsysport.o: in function `__bcm_sysport_tx_reclaim':
>    bcmsysport.c:(.text+0x35e8): undefined reference to `__dev_kfree_skb_any'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bcmsysport.o: in function `bcm_sysport_tx_reclaim':
>    bcmsysport.c:(.text+0x3724): undefined reference to `netif_tx_wake_queue'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bcmsysport.o: in function `bcm_sysport_rx_isr':
>    bcmsysport.c:(.text+0x37f4): undefined reference to `netdev_warn'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x383c): undefined reference to `napi_schedule_prep'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x38e0): undefined reference to `__napi_schedule_irqoff'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x3980): undefined reference to `napi_schedule_prep'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x39c0): undefined reference to `__napi_schedule'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bcmsysport.o: in function `bcm_sysport_tx_poll':
>    bcmsysport.c:(.text+0x3a2c): undefined reference to `napi_complete_done'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bcmsysport.o: in function `bcm_sysport_fini_tx_ring':
>    bcmsysport.c:(.text+0x3b28): undefined reference to `netdev_warn'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x3b70): undefined reference to `napi_disable'
> >> powerpc-linux-ld: bcmsysport.c:(.text+0x3b78): undefined reference to `__netif_napi_del'
> >> powerpc-linux-ld: bcmsysport.c:(.text+0x3b7c): undefined reference to `synchronize_net'  
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bcmsysport.o: in function `bcm_sysport_fini_rx_ring':
>    bcmsysport.c:(.text+0x3c10): undefined reference to `netdev_warn'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x3ca0): undefined reference to `__dev_kfree_skb_any'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bcmsysport.o: in function `bcm_sysport_suspend':
>    bcmsysport.c:(.text+0x3d2c): undefined reference to `netif_device_detach'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x3d80): undefined reference to `netdev_err'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x4120): undefined reference to `netdev_err'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bcmsysport.o: in function `bcm_sysport_stop':
>    bcmsysport.c:(.text+0x41a8): undefined reference to `netdev_err'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bcmsysport.o: in function `bcm_sysport_rx_refill':
>    bcmsysport.c:(.text+0x4670): undefined reference to `__netdev_alloc_skb'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x4718): undefined reference to `__dev_kfree_skb_any'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x4750): undefined reference to `netdev_err'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x47c0): undefined reference to `netdev_err'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bcmsysport.o: in function `bcm_sysport_init_rx_ring':
>    bcmsysport.c:(.text+0x4920): undefined reference to `netdev_err'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x4960): undefined reference to `consume_skb'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bcmsysport.o: in function `bcm_sysport_resume':
>    bcmsysport.c:(.text+0x4bac): undefined reference to `netdev_info'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x4be0): undefined reference to `netdev_info'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x4c30): undefined reference to `netdev_err'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x4cf4): undefined reference to `netdev_err'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x4e64): undefined reference to `netif_device_attach'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bcmsysport.o: in function `bcm_sysport_open':
>    bcmsysport.c:(.text+0x4fac): undefined reference to `netdev_err'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x5038): undefined reference to `netdev_err'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x50fc): undefined reference to `netdev_err'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x5124): undefined reference to `netdev_err'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x5168): undefined reference to `netdev_err'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bcmsysport.o:bcmsysport.c:(.text+0x5484): more undefined references to `netdev_err' follow
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bcmsysport.o: in function `bcm_sysport_desc_rx':
>    bcmsysport.c:(.text+0x5570): undefined reference to `__dev_kfree_skb_any'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x55ec): undefined reference to `netdev_err'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x5614): undefined reference to `skb_put'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x5664): undefined reference to `netdev_err'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x56c0): undefined reference to `skb_pull'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x56f4): undefined reference to `skb_trim'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x5704): undefined reference to `eth_type_trans'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x5794): undefined reference to `napi_gro_receive'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bcmsysport.o: in function `bcm_sysport_poll':
>    bcmsysport.c:(.text+0x585c): undefined reference to `napi_complete_done'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bcmsysport.o: in function `bcm_sysport_xmit':
>    bcmsysport.c:(.text+0x59d8): undefined reference to `netdev_err'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x5a60): undefined reference to `skb_realloc_headroom'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x5a80): undefined reference to `__dev_kfree_skb_any'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x5b4c): undefined reference to `skb_push'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x5c70): undefined reference to `__dev_kfree_skb_any'
>    powerpc-linux-ld: bcmsysport.c:(.text+0x5e58): undefined reference to `netdev_err'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bcmsysport.o: in function `bcm_sysport_tx_timeout':
>    bcmsysport.c:(.text.unlikely+0x28): undefined reference to `netdev_warn'
>    powerpc-linux-ld: bcmsysport.c:(.text.unlikely+0xa4): undefined reference to `netif_tx_wake_queue'
>    powerpc-linux-ld: drivers/net/ethernet/broadcom/bcmsysport.o:(.rodata+0x464): undefined reference to `ethtool_op_get_link'
>    powerpc-linux-ld: drivers/net/ethernet/chelsio/cxgb/cxgb2.o: in function `remove_one':
>    cxgb2.c:(.text+0x82c): undefined reference to `unregister_netdev'
>    powerpc-linux-ld: cxgb2.c:(.text+0x864): undefined reference to `free_netdev'
>    powerpc-linux-ld: drivers/net/ethernet/chelsio/cxgb/cxgb2.o: in function `set_link_ksettings':
>    cxgb2.c:(.text+0x8bc): undefined reference to `ethtool_convert_link_mode_to_legacy_u32'
>    powerpc-linux-ld: drivers/net/ethernet/chelsio/cxgb/cxgb2.o: in function `init_one':
>    cxgb2.c:(.text+0x1870): undefined reference to `alloc_etherdev_mqs'
>    powerpc-linux-ld: cxgb2.c:(.text+0x1948): undefined reference to `netif_carrier_off'
>    powerpc-linux-ld: cxgb2.c:(.text+0x1a14): undefined reference to `netif_napi_add'
>    powerpc-linux-ld: cxgb2.c:(.text+0x1c2c): undefined reference to `register_netdev'
>    powerpc-linux-ld: cxgb2.c:(.text+0x1dc8): undefined reference to `free_netdev'
>    powerpc-linux-ld: drivers/net/ethernet/chelsio/cxgb/cxgb2.o: in function `cxgb_close':
>    cxgb2.c:(.text+0x1e3c): undefined reference to `napi_disable'
>    powerpc-linux-ld: cxgb2.c:(.text+0x1e5c): undefined reference to `netif_carrier_off'
>    powerpc-linux-ld: drivers/net/ethernet/chelsio/cxgb/cxgb2.o: in function `get_link_ksettings':
>    cxgb2.c:(.text+0x2000): undefined reference to `ethtool_convert_legacy_u32_to_link_mode'
>    powerpc-linux-ld: cxgb2.c:(.text+0x200c): undefined reference to `ethtool_convert_legacy_u32_to_link_mode'
>    powerpc-linux-ld: drivers/net/ethernet/chelsio/cxgb/cxgb2.o: in function `cxgb_open':
>    cxgb2.c:(.text+0x21ec): undefined reference to `napi_disable'
>    powerpc-linux-ld: drivers/net/ethernet/chelsio/cxgb/cxgb2.o: in function `t1_link_negotiated':
>    cxgb2.c:(.text+0x24f8): undefined reference to `netif_carrier_off'
>    powerpc-linux-ld: cxgb2.c:(.text+0x2520): undefined reference to `netif_carrier_on'
>    powerpc-linux-ld: cxgb2.c:(.text+0x2548): undefined reference to `netdev_info'
>    powerpc-linux-ld: cxgb2.c:(.text+0x2618): undefined reference to `netdev_info'
>    powerpc-linux-ld: drivers/net/ethernet/chelsio/cxgb/cxgb2.o:(.rodata+0x768): undefined reference to `eth_validate_addr'
>    powerpc-linux-ld: drivers/net/ethernet/chelsio/cxgb/cxgb2.o:(.rodata+0x874): undefined reference to `ethtool_op_get_link'
>    powerpc-linux-ld: drivers/net/ethernet/chelsio/cxgb/sge.o: in function `sge_rx':
>    sge.c:(.text+0x490): undefined reference to `__napi_alloc_skb'
>    powerpc-linux-ld: sge.c:(.text+0x4f8): undefined reference to `skb_put'
>    powerpc-linux-ld: sge.c:(.text+0x5d0): undefined reference to `skb_put'
>    powerpc-linux-ld: sge.c:(.text+0x640): undefined reference to `kfree_skb'
>    powerpc-linux-ld: sge.c:(.text+0x6b8): undefined reference to `eth_type_trans'
>    powerpc-linux-ld: sge.c:(.text+0x7bc): undefined reference to `netif_receive_skb'
>    powerpc-linux-ld: drivers/net/ethernet/chelsio/cxgb/sge.o: in function `refill_free_list':
>    sge.c:(.text+0xf58): undefined reference to `__netdev_alloc_skb'
>    powerpc-linux-ld: drivers/net/ethernet/chelsio/cxgb/sge.o: in function `free_cmdQ_buffers':
>    sge.c:(.text+0x1178): undefined reference to `__dev_kfree_skb_any'
>    powerpc-linux-ld: drivers/net/ethernet/chelsio/cxgb/sge.o: in function `free_rx_resources':
>    sge.c:(.text+0x15bc): undefined reference to `consume_skb'
>    powerpc-linux-ld: drivers/net/ethernet/chelsio/cxgb/sge.o: in function `update_tx_info':
>    sge.c:(.text+0x1980): undefined reference to `netif_tx_wake_queue'
>    powerpc-linux-ld: drivers/net/ethernet/chelsio/cxgb/sge.o: in function `t1_poll':
>    sge.c:(.text+0x3288): undefined reference to `napi_complete_done'
>    powerpc-linux-ld: drivers/net/ethernet/chelsio/cxgb/sge.o: in function `t1_interrupt':
>    sge.c:(.text+0x3358): undefined reference to `napi_schedule_prep'
>    powerpc-linux-ld: sge.c:(.text+0x33d0): undefined reference to `__napi_schedule'
>    powerpc-linux-ld: drivers/net/ethernet/chelsio/cxgb/sge.o: in function `t1_start_xmit':
>    sge.c:(.text+0x3738): undefined reference to `skb_realloc_headroom'
> ..
> 
> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for NETDEVICES
>    Depends on NET
>    Selected by
>    - AKEBONO && PPC_47x
>    WARNING: unmet direct dependencies detected for ETHERNET
>    Depends on NETDEVICES && NET
>    Selected by
>    - AKEBONO && PPC_47x
>    WARNING: unmet direct dependencies detected for HOTPLUG_CPU
>    Depends on SMP && (PPC_PSERIES || PPC_PMAC || PPC_POWERNV || FSL_SOC_BOOKE
>    Selected by
>    - PM_SLEEP_SMP && SMP && (ARCH_SUSPEND_POSSIBLE || ARCH_HIBERNATION_POSSIBLE && PM_SLEEP
>    WARNING: unmet direct dependencies detected for NET_DEVLINK
>    Depends on NET
>    Selected by
>    - QED && NETDEVICES && ETHERNET && NET_VENDOR_QLOGIC && PCI
>    WARNING: unmet direct dependencies detected for GRO_CELLS
>    Depends on NET
>    Selected by
>    - MACSEC && NETDEVICES && NET_CORE
>    WARNING: unmet direct dependencies detected for FAILOVER
>    Depends on NET
>    Selected by
>    - NET_FAILOVER && NETDEVICES
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

