Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205453FAE76
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 22:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhH2UeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 16:34:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:44761 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235868AbhH2UeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 16:34:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10091"; a="205309611"
X-IronPort-AV: E=Sophos;i="5.84,362,1620716400"; 
   d="gz'50?scan'50,208,50";a="205309611"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2021 13:33:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,362,1620716400"; 
   d="gz'50?scan'50,208,50";a="518517393"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 29 Aug 2021 13:33:05 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mKRUG-0004Z0-Of; Sun, 29 Aug 2021 20:33:04 +0000
Date:   Mon, 30 Aug 2021 04:32:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [intel-tdx:guest 94/113] drivers/net/vmxnet3/vmxnet3_drv.c:3413:29:
 warning: shift count >= width of type
Message-ID: <202108300417.UBoKwFkM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://github.com/intel/tdx.git guest
head:   44e41606b85b08fad5378c876547f8557f835cf6
commit: eb26b8afd9b6c065a6cd81ca1fa48b3d6e11c5a5 [94/113] x86/tdx: Make RDRAND/RDSEED loop forever
config: i386-randconfig-a004-20210829 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 510e106fa8635e7f9c51c896180b971de6309b2f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/eb26b8afd9b6c065a6cd81ca1fa48b3d6e11c5a5
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest
        git checkout eb26b8afd9b6c065a6cd81ca1fa48b3d6e11c5a5
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/net/vmxnet3/vmxnet3_drv.c:28:
   In file included from include/net/ip6_checksum.h:27:
   In file included from include/net/ip.h:22:
   In file included from include/linux/ip.h:16:
   In file included from include/linux/skbuff.h:26:
   In file included from include/linux/net.h:18:
   In file included from include/linux/random.h:121:
   In file included from arch/x86/include/asm/archrandom.h:13:
   include/linux/protected_guest.h:57:12: error: incomplete definition of type 'struct device'
           return dev->authorized;
                  ~~~^
   include/linux/dynamic_debug.h:70:8: note: forward declaration of 'struct device'
   struct device;
          ^
>> drivers/net/vmxnet3/vmxnet3_drv.c:3413:29: warning: shift count >= width of type [-Wshift-count-overflow]
           if (pci_set_dma_mask(pdev, DMA_BIT_MASK(64)) == 0) {
                                      ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   drivers/net/vmxnet3/vmxnet3_drv.c:3414:41: warning: shift count >= width of type [-Wshift-count-overflow]
                   if (pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64)) != 0) {
                                                         ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   2 warnings and 1 error generated.
--
   In file included from drivers/net/ethernet/marvell/sky2.c:18:
   In file included from include/linux/netdevice.h:37:
   In file included from include/net/net_namespace.h:39:
   In file included from include/linux/skbuff.h:26:
   In file included from include/linux/net.h:18:
   In file included from include/linux/random.h:121:
   In file included from arch/x86/include/asm/archrandom.h:13:
   include/linux/protected_guest.h:57:12: error: incomplete definition of type 'struct device'
           return dev->authorized;
                  ~~~^
   include/linux/dynamic_debug.h:70:8: note: forward declaration of 'struct device'
   struct device;
          ^
>> drivers/net/ethernet/marvell/sky2.c:4988:39: warning: shift count >= width of type [-Wshift-count-overflow]
               !(err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64)))) {
                                                ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   drivers/net/ethernet/marvell/sky2.c:4990:43: warning: shift count >= width of type [-Wshift-count-overflow]
                   err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
                                                           ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   2 warnings and 1 error generated.
--
   In file included from drivers/net/ethernet/realtek/8139cp.c:60:
   In file included from include/linux/netdevice.h:37:
   In file included from include/net/net_namespace.h:39:
   In file included from include/linux/skbuff.h:26:
   In file included from include/linux/net.h:18:
   In file included from include/linux/random.h:121:
   In file included from arch/x86/include/asm/archrandom.h:13:
   include/linux/protected_guest.h:57:12: error: incomplete definition of type 'struct device'
           return dev->authorized;
                  ~~~^
   include/linux/dynamic_debug.h:70:8: note: forward declaration of 'struct device'
   struct device;
          ^
>> drivers/net/ethernet/realtek/8139cp.c:1948:41: warning: shift count >= width of type [-Wshift-count-overflow]
               !pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64)) &&
                                                  ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   drivers/net/ethernet/realtek/8139cp.c:1949:30: warning: shift count >= width of type [-Wshift-count-overflow]
               !pci_set_dma_mask(pdev, DMA_BIT_MASK(64))) {
                                       ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   2 warnings and 1 error generated.
--
   In file included from drivers/net/ethernet/intel/fm10k/fm10k_main.c:6:
   In file included from include/net/ipv6.h:12:
   In file included from include/linux/ipv6.h:88:
   In file included from include/linux/tcp.h:17:
   In file included from include/linux/skbuff.h:26:
   In file included from include/linux/net.h:18:
   In file included from include/linux/random.h:121:
   In file included from arch/x86/include/asm/archrandom.h:13:
   include/linux/protected_guest.h:57:12: error: incomplete definition of type 'struct device'
           return dev->authorized;
                  ~~~^
   include/linux/dynamic_debug.h:70:8: note: forward declaration of 'struct device'
   struct device;
          ^
>> drivers/net/ethernet/intel/fm10k/fm10k_main.c:878:16: warning: division by zero is undefined [-Wdivision-by-zero]
           desc_flags |= FM10K_SET_FLAG(tx_flags, FM10K_TX_FLAGS_CSUM,
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/fm10k/fm10k_main.c:870:26: note: expanded from macro 'FM10K_SET_FLAG'
            ((u32)(_input & _flag) / (_flag / _result)))
                                   ^ ~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.
--
   In file included from drivers/net/ethernet/intel/igb/igb_main.c:12:
   In file included from include/linux/netdevice.h:37:
   In file included from include/net/net_namespace.h:39:
   In file included from include/linux/skbuff.h:26:
   In file included from include/linux/net.h:18:
   In file included from include/linux/random.h:121:
   In file included from arch/x86/include/asm/archrandom.h:13:
   include/linux/protected_guest.h:57:12: error: incomplete definition of type 'struct device'
           return dev->authorized;
                  ~~~^
   include/linux/dynamic_debug.h:70:8: note: forward declaration of 'struct device'
   struct device;
          ^
>> drivers/net/ethernet/intel/igb/igb_main.c:3177:46: warning: shift count >= width of type [-Wshift-count-overflow]
           err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
                                                       ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
>> drivers/net/ethernet/intel/igb/igb_main.c:6028:14: warning: division by zero is undefined [-Wdivision-by-zero]
           cmd_type |= IGB_SET_FLAG(tx_flags, IGB_TX_FLAGS_VLAN,
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/igb/igb_main.c:6018:26: note: expanded from macro 'IGB_SET_FLAG'
            ((u32)(_input & _flag) / (_flag / _result)))
                                   ^ ~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/igb/igb_main.c:6032:14: warning: division by zero is undefined [-Wdivision-by-zero]
           cmd_type |= IGB_SET_FLAG(tx_flags, IGB_TX_FLAGS_TSO,
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/igb/igb_main.c:6018:26: note: expanded from macro 'IGB_SET_FLAG'
            ((u32)(_input & _flag) / (_flag / _result)))
                                   ^ ~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/igb/igb_main.c:6036:14: warning: division by zero is undefined [-Wdivision-by-zero]
           cmd_type |= IGB_SET_FLAG(tx_flags, IGB_TX_FLAGS_TSTAMP,
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/igb/igb_main.c:6018:26: note: expanded from macro 'IGB_SET_FLAG'
            ((u32)(_input & _flag) / (_flag / _result)))
                                   ^ ~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/igb/igb_main.c:6040:14: warning: division by zero is undefined [-Wdivision-by-zero]
           cmd_type ^= IGB_SET_FLAG(skb->no_fcs, 1, E1000_ADVTXD_DCMD_IFCS);
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/igb/igb_main.c:6018:26: note: expanded from macro 'IGB_SET_FLAG'
            ((u32)(_input & _flag) / (_flag / _result)))
                                   ^ ~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/igb/igb_main.c:6056:19: warning: division by zero is undefined [-Wdivision-by-zero]
           olinfo_status |= IGB_SET_FLAG(tx_flags,
                            ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/igb/igb_main.c:6018:26: note: expanded from macro 'IGB_SET_FLAG'
            ((u32)(_input & _flag) / (_flag / _result)))
                                   ^ ~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/igb/igb_main.c:6061:19: warning: division by zero is undefined [-Wdivision-by-zero]
           olinfo_status |= IGB_SET_FLAG(tx_flags,
                            ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/igb/igb_main.c:6018:26: note: expanded from macro 'IGB_SET_FLAG'
            ((u32)(_input & _flag) / (_flag / _result)))
                                   ^ ~~~~~~~~~~~~~~~~~
   7 warnings and 1 error generated.
--
   In file included from drivers/net/ethernet/intel/igc/igc_main.c:6:
   In file included from include/linux/if_vlan.h:10:
   In file included from include/linux/netdevice.h:37:
   In file included from include/net/net_namespace.h:39:
   In file included from include/linux/skbuff.h:26:
   In file included from include/linux/net.h:18:
   In file included from include/linux/random.h:121:
   In file included from arch/x86/include/asm/archrandom.h:13:
   include/linux/protected_guest.h:57:12: error: incomplete definition of type 'struct device'
           return dev->authorized;
                  ~~~^
   include/linux/dynamic_debug.h:70:8: note: forward declaration of 'struct device'
   struct device;
          ^
>> drivers/net/ethernet/intel/igc/igc_main.c:1138:14: warning: division by zero is undefined [-Wdivision-by-zero]
           cmd_type |= IGC_SET_FLAG(tx_flags, IGC_TX_FLAGS_VLAN,
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/igc/igc_main.c:1128:30: note: expanded from macro 'IGC_SET_FLAG'
            ((u32)((_input) & (_flag)) / ((_flag) / (_result))))
                                       ^ ~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/igc/igc_main.c:1142:14: warning: division by zero is undefined [-Wdivision-by-zero]
           cmd_type |= IGC_SET_FLAG(tx_flags, IGC_TX_FLAGS_TSO,
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/igc/igc_main.c:1128:30: note: expanded from macro 'IGC_SET_FLAG'
            ((u32)((_input) & (_flag)) / ((_flag) / (_result))))
                                       ^ ~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/igc/igc_main.c:1146:14: warning: division by zero is undefined [-Wdivision-by-zero]
           cmd_type |= IGC_SET_FLAG(tx_flags, IGC_TX_FLAGS_TSTAMP,
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/igc/igc_main.c:1128:30: note: expanded from macro 'IGC_SET_FLAG'
            ((u32)((_input) & (_flag)) / ((_flag) / (_result))))
                                       ^ ~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/igc/igc_main.c:1150:14: warning: division by zero is undefined [-Wdivision-by-zero]
           cmd_type ^= IGC_SET_FLAG(skb->no_fcs, 1, IGC_ADVTXD_DCMD_IFCS);
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/igc/igc_main.c:1128:30: note: expanded from macro 'IGC_SET_FLAG'
            ((u32)((_input) & (_flag)) / ((_flag) / (_result))))
                                       ^ ~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/igc/igc_main.c:5844:46: warning: shift count >= width of type [-Wshift-count-overflow]
           err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
                                                       ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   5 warnings and 1 error generated.


vim +3413 drivers/net/vmxnet3/vmxnet3_drv.c

d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3342  
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3343  
3a4751a3bb2704 Bill Pemberton     2012-12-03  3344  static int
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3345  vmxnet3_probe_device(struct pci_dev *pdev,
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3346  		     const struct pci_device_id *id)
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3347  {
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3348  	static const struct net_device_ops vmxnet3_netdev_ops = {
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3349  		.ndo_open = vmxnet3_open,
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3350  		.ndo_stop = vmxnet3_close,
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3351  		.ndo_start_xmit = vmxnet3_xmit_frame,
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3352  		.ndo_set_mac_address = vmxnet3_set_mac_addr,
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3353  		.ndo_change_mtu = vmxnet3_change_mtu,
3dd7400b419409 Ronak Doshi        2019-06-03  3354  		.ndo_fix_features = vmxnet3_fix_features,
a0d2730c9571ae Michał Mirosław    2011-04-18  3355  		.ndo_set_features = vmxnet3_set_features,
1dac3b1bc66dc6 Ronak Doshi        2020-09-24  3356  		.ndo_features_check = vmxnet3_features_check,
95305f6c3b4e8c stephen hemminger  2011-06-08  3357  		.ndo_get_stats64 = vmxnet3_get_stats64,
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3358  		.ndo_tx_timeout = vmxnet3_tx_timeout,
afc4b13df14312 Jiri Pirko         2011-08-16  3359  		.ndo_set_rx_mode = vmxnet3_set_mc,
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3360  		.ndo_vlan_rx_add_vid = vmxnet3_vlan_rx_add_vid,
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3361  		.ndo_vlan_rx_kill_vid = vmxnet3_vlan_rx_kill_vid,
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3362  #ifdef CONFIG_NET_POLL_CONTROLLER
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3363  		.ndo_poll_controller = vmxnet3_netpoll,
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3364  #endif
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3365  	};
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3366  	int err;
61aeecea40afb2 hpreg@vmware.com   2018-05-14  3367  	bool dma64;
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3368  	u32 ver;
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3369  	struct net_device *netdev;
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3370  	struct vmxnet3_adapter *adapter;
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3371  	u8 mac[ETH_ALEN];
09c5088e5c5993 Shreyas Bhatewara  2010-11-19  3372  	int size;
09c5088e5c5993 Shreyas Bhatewara  2010-11-19  3373  	int num_tx_queues;
09c5088e5c5993 Shreyas Bhatewara  2010-11-19  3374  	int num_rx_queues;
09c5088e5c5993 Shreyas Bhatewara  2010-11-19  3375  
e154b639bbe53d Shreyas Bhatewara  2011-05-10  3376  	if (!pci_msi_enabled())
e154b639bbe53d Shreyas Bhatewara  2011-05-10  3377  		enable_mq = 0;
e154b639bbe53d Shreyas Bhatewara  2011-05-10  3378  
09c5088e5c5993 Shreyas Bhatewara  2010-11-19  3379  #ifdef VMXNET3_RSS
09c5088e5c5993 Shreyas Bhatewara  2010-11-19  3380  	if (enable_mq)
09c5088e5c5993 Shreyas Bhatewara  2010-11-19  3381  		num_rx_queues = min(VMXNET3_DEVICE_MAX_RX_QUEUES,
09c5088e5c5993 Shreyas Bhatewara  2010-11-19  3382  				    (int)num_online_cpus());
09c5088e5c5993 Shreyas Bhatewara  2010-11-19  3383  	else
09c5088e5c5993 Shreyas Bhatewara  2010-11-19  3384  #endif
09c5088e5c5993 Shreyas Bhatewara  2010-11-19  3385  		num_rx_queues = 1;
eebb02b1f03b37 Shreyas Bhatewara  2011-07-07  3386  	num_rx_queues = rounddown_pow_of_two(num_rx_queues);
09c5088e5c5993 Shreyas Bhatewara  2010-11-19  3387  
09c5088e5c5993 Shreyas Bhatewara  2010-11-19  3388  	if (enable_mq)
09c5088e5c5993 Shreyas Bhatewara  2010-11-19  3389  		num_tx_queues = min(VMXNET3_DEVICE_MAX_TX_QUEUES,
09c5088e5c5993 Shreyas Bhatewara  2010-11-19  3390  				    (int)num_online_cpus());
09c5088e5c5993 Shreyas Bhatewara  2010-11-19  3391  	else
09c5088e5c5993 Shreyas Bhatewara  2010-11-19  3392  		num_tx_queues = 1;
09c5088e5c5993 Shreyas Bhatewara  2010-11-19  3393  
eebb02b1f03b37 Shreyas Bhatewara  2011-07-07  3394  	num_tx_queues = rounddown_pow_of_two(num_tx_queues);
09c5088e5c5993 Shreyas Bhatewara  2010-11-19  3395  	netdev = alloc_etherdev_mq(sizeof(struct vmxnet3_adapter),
09c5088e5c5993 Shreyas Bhatewara  2010-11-19  3396  				   max(num_tx_queues, num_rx_queues));
204a6e659439b7 Stephen Hemminger  2013-01-15  3397  	dev_info(&pdev->dev,
204a6e659439b7 Stephen Hemminger  2013-01-15  3398  		 "# of Tx queues : %d, # of Rx queues : %d\n",
09c5088e5c5993 Shreyas Bhatewara  2010-11-19  3399  		 num_tx_queues, num_rx_queues);
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3400  
41de8d4cff21a2 Joe Perches        2012-01-29  3401  	if (!netdev)
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3402  		return -ENOMEM;
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3403  
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3404  	pci_set_drvdata(pdev, netdev);
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3405  	adapter = netdev_priv(netdev);
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3406  	adapter->netdev = netdev;
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3407  	adapter->pdev = pdev;
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3408  
f00e2b0ac3ae25 Neil Horman        2014-06-13  3409  	adapter->tx_ring_size = VMXNET3_DEF_TX_RING_SIZE;
f00e2b0ac3ae25 Neil Horman        2014-06-13  3410  	adapter->rx_ring_size = VMXNET3_DEF_RX_RING_SIZE;
53831aa12538f8 Shrikrishna Khare  2015-01-06  3411  	adapter->rx_ring2_size = VMXNET3_DEF_RX_RING2_SIZE;
f00e2b0ac3ae25 Neil Horman        2014-06-13  3412  
61aeecea40afb2 hpreg@vmware.com   2018-05-14 @3413  	if (pci_set_dma_mask(pdev, DMA_BIT_MASK(64)) == 0) {
61aeecea40afb2 hpreg@vmware.com   2018-05-14  3414  		if (pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64)) != 0) {
61aeecea40afb2 hpreg@vmware.com   2018-05-14  3415  			dev_err(&pdev->dev,
61aeecea40afb2 hpreg@vmware.com   2018-05-14  3416  				"pci_set_consistent_dma_mask failed\n");
61aeecea40afb2 hpreg@vmware.com   2018-05-14  3417  			err = -EIO;
61aeecea40afb2 hpreg@vmware.com   2018-05-14  3418  			goto err_set_mask;
61aeecea40afb2 hpreg@vmware.com   2018-05-14  3419  		}
61aeecea40afb2 hpreg@vmware.com   2018-05-14  3420  		dma64 = true;
61aeecea40afb2 hpreg@vmware.com   2018-05-14  3421  	} else {
61aeecea40afb2 hpreg@vmware.com   2018-05-14  3422  		if (pci_set_dma_mask(pdev, DMA_BIT_MASK(32)) != 0) {
61aeecea40afb2 hpreg@vmware.com   2018-05-14  3423  			dev_err(&pdev->dev,
61aeecea40afb2 hpreg@vmware.com   2018-05-14  3424  				"pci_set_dma_mask failed\n");
61aeecea40afb2 hpreg@vmware.com   2018-05-14  3425  			err = -EIO;
61aeecea40afb2 hpreg@vmware.com   2018-05-14  3426  			goto err_set_mask;
61aeecea40afb2 hpreg@vmware.com   2018-05-14  3427  		}
61aeecea40afb2 hpreg@vmware.com   2018-05-14  3428  		dma64 = false;
61aeecea40afb2 hpreg@vmware.com   2018-05-14  3429  	}
61aeecea40afb2 hpreg@vmware.com   2018-05-14  3430  
83d0feffc5695d Shreyas Bhatewara  2011-01-14  3431  	spin_lock_init(&adapter->cmd_lock);
b0eb57cb97e783 Andy King          2013-08-23  3432  	adapter->adapter_pa = dma_map_single(&adapter->pdev->dev, adapter,
b0eb57cb97e783 Andy King          2013-08-23  3433  					     sizeof(struct vmxnet3_adapter),
b0eb57cb97e783 Andy King          2013-08-23  3434  					     PCI_DMA_TODEVICE);
5738a09d58d5ad Alexey Khoroshilov 2015-11-28  3435  	if (dma_mapping_error(&adapter->pdev->dev, adapter->adapter_pa)) {
5738a09d58d5ad Alexey Khoroshilov 2015-11-28  3436  		dev_err(&pdev->dev, "Failed to map dma\n");
5738a09d58d5ad Alexey Khoroshilov 2015-11-28  3437  		err = -EFAULT;
61aeecea40afb2 hpreg@vmware.com   2018-05-14  3438  		goto err_set_mask;
5738a09d58d5ad Alexey Khoroshilov 2015-11-28  3439  	}
b0eb57cb97e783 Andy King          2013-08-23  3440  	adapter->shared = dma_alloc_coherent(
b0eb57cb97e783 Andy King          2013-08-23  3441  				&adapter->pdev->dev,
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3442  				sizeof(struct Vmxnet3_DriverShared),
b0eb57cb97e783 Andy King          2013-08-23  3443  				&adapter->shared_pa, GFP_KERNEL);
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3444  	if (!adapter->shared) {
204a6e659439b7 Stephen Hemminger  2013-01-15  3445  		dev_err(&pdev->dev, "Failed to allocate memory\n");
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3446  		err = -ENOMEM;
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3447  		goto err_alloc_shared;
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3448  	}
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3449  
09c5088e5c5993 Shreyas Bhatewara  2010-11-19  3450  	adapter->num_rx_queues = num_rx_queues;
09c5088e5c5993 Shreyas Bhatewara  2010-11-19  3451  	adapter->num_tx_queues = num_tx_queues;
e4fabf2b6e6d75 Bhavesh Davda      2013-03-06  3452  	adapter->rx_buf_per_pkt = 1;
09c5088e5c5993 Shreyas Bhatewara  2010-11-19  3453  
09c5088e5c5993 Shreyas Bhatewara  2010-11-19  3454  	size = sizeof(struct Vmxnet3_TxQueueDesc) * adapter->num_tx_queues;
09c5088e5c5993 Shreyas Bhatewara  2010-11-19  3455  	size += sizeof(struct Vmxnet3_RxQueueDesc) * adapter->num_rx_queues;
b0eb57cb97e783 Andy King          2013-08-23  3456  	adapter->tqd_start = dma_alloc_coherent(&adapter->pdev->dev, size,
b0eb57cb97e783 Andy King          2013-08-23  3457  						&adapter->queue_desc_pa,
b0eb57cb97e783 Andy King          2013-08-23  3458  						GFP_KERNEL);
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3459  
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3460  	if (!adapter->tqd_start) {
204a6e659439b7 Stephen Hemminger  2013-01-15  3461  		dev_err(&pdev->dev, "Failed to allocate memory\n");
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3462  		err = -ENOMEM;
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3463  		goto err_alloc_queue_desc;
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3464  	}
09c5088e5c5993 Shreyas Bhatewara  2010-11-19  3465  	adapter->rqd_start = (struct Vmxnet3_RxQueueDesc *)(adapter->tqd_start +
09c5088e5c5993 Shreyas Bhatewara  2010-11-19  3466  							    adapter->num_tx_queues);
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3467  
b0eb57cb97e783 Andy King          2013-08-23  3468  	adapter->pm_conf = dma_alloc_coherent(&adapter->pdev->dev,
b0eb57cb97e783 Andy King          2013-08-23  3469  					      sizeof(struct Vmxnet3_PMConf),
b0eb57cb97e783 Andy King          2013-08-23  3470  					      &adapter->pm_conf_pa,
b0eb57cb97e783 Andy King          2013-08-23  3471  					      GFP_KERNEL);
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3472  	if (adapter->pm_conf == NULL) {
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3473  		err = -ENOMEM;
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3474  		goto err_alloc_pm;
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3475  	}
d1a890fa37f27d Shreyas Bhatewara  2009-10-13  3476  

:::::: The code at line 3413 was first introduced by commit
:::::: 61aeecea40afb2b89933e27cd4adb10fc2e75cfd vmxnet3: set the DMA mask before the first DMA map operation

:::::: TO: hpreg@vmware.com <hpreg@vmware.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--xHFwDpU9dbj6ez1V
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
rLi+1v0/dpaQc4BIAgA=

--xHFwDpU9dbj6ez1V--
