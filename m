Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB24A3F03F2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 14:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbhHRMsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 08:48:19 -0400
Received: from mga09.intel.com ([134.134.136.24]:28446 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235222AbhHRMsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 08:48:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="216312007"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="gz'50?scan'50,208,50";a="216312007"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 05:47:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="gz'50?scan'50,208,50";a="680964684"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 18 Aug 2021 05:47:40 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mGKyp-000SuD-Lh; Wed, 18 Aug 2021 12:47:39 +0000
Date:   Wed, 18 Aug 2021 20:47:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [kees:kspp/array-bounds/next-20210816/v1 9/10]
 drivers/scsi/megaraid.c:211:13: warning: array subscript 'mbox_t[0]' is
 partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'}
Message-ID: <202108182023.5Y6tUTR8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git kspp/array-bounds/next-20210816/v1
head:   b07d5e8190ca172b1ffddd1412b921296000b379
commit: ecc23a9ee765008e439113eea38fb1cbbd3d7c83 [9/10] Makefile: Enable -Warray-bounds
config: arc-randconfig-r043-20210818 (attached as .config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=ecc23a9ee765008e439113eea38fb1cbbd3d7c83
        git remote add kees https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
        git fetch --no-tags kees kspp/array-bounds/next-20210816/v1
        git checkout ecc23a9ee765008e439113eea38fb1cbbd3d7c83
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=arc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/scsi/megaraid.c: In function 'mega_query_adapter':
>> drivers/scsi/megaraid.c:211:13: warning: array subscript 'mbox_t[0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Warray-bounds]
     211 |         mbox->m_out.xferaddr = (u32)adapter->buf_dma_handle;
         |             ^~
   drivers/scsi/megaraid.c:195:17: note: while referencing 'raw_mbox'
     195 |         u8      raw_mbox[sizeof(struct mbox_out)];
         |                 ^~~~~~~~
   drivers/scsi/megaraid.c:265:21: warning: array subscript 'mbox_t[0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Warray-bounds]
     265 |                 mbox->m_out.xferaddr = prod_info_dma_handle;
         |                     ^~
   drivers/scsi/megaraid.c:195:17: note: while referencing 'raw_mbox'
     195 |         u8      raw_mbox[sizeof(struct mbox_out)];
         |                 ^~~~~~~~
   drivers/scsi/megaraid.c:235:21: warning: array subscript 'mbox_t[0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Warray-bounds]
     235 |                 mbox->m_out.xferaddr = (u32)dma_handle;
         |                     ^~
   drivers/scsi/megaraid.c:195:17: note: while referencing 'raw_mbox'
     195 |         u8      raw_mbox[sizeof(struct mbox_out)];
         |                 ^~~~~~~~
   drivers/scsi/megaraid.c:238:21: warning: array subscript 'mbox_t[0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned char[15]'} [-Warray-bounds]
     238 |                 mbox->m_out.cmd = MEGA_MBOXCMD_ADPEXTINQ;
         |                     ^~
   drivers/scsi/megaraid.c:195:17: note: while referencing 'raw_mbox'
     195 |         u8      raw_mbox[sizeof(struct mbox_out)];
         |                 ^~~~~~~~
>> drivers/scsi/megaraid.c:3881:30: warning: array subscript 'mbox_t[0]' is partly outside array bounds of 'unsigned char[15]' [-Warray-bounds]
    3881 |         mbox->m_out.xferaddr = (u32)adapter->buf_dma_handle;
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/megaraid.c:3872:25: note: while referencing 'raw_mbox'
    3872 |         unsigned char   raw_mbox[sizeof(struct mbox_out)];
         |                         ^~~~~~~~
   drivers/scsi/megaraid.c: In function 'megaraid_probe_one':
   drivers/scsi/megaraid.c:3585:30: warning: array subscript 'mbox_t[0]' is partly outside array bounds of 'unsigned char[15]' [-Warray-bounds]
    3585 |         mbox->m_out.xferaddr = (u32)adapter->buf_dma_handle;
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/megaraid.c:3576:25: note: while referencing 'raw_mbox'
    3576 |         unsigned char   raw_mbox[sizeof(struct mbox_out)];
         |                         ^~~~~~~~
   drivers/scsi/megaraid.c:3623:30: warning: array subscript 'mbox_t[0]' is partly outside array bounds of 'unsigned char[15]' [-Warray-bounds]
    3623 |         mbox->m_out.xferaddr = (u32)adapter->buf_dma_handle;
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/megaraid.c:3607:23: note: while referencing 'raw_mbox'
    3607 |         unsigned char raw_mbox[sizeof(struct mbox_out)];
         |                       ^~~~~~~~
   drivers/scsi/megaraid.c:3678:30: warning: array subscript 'mbox_t[0]' is partly outside array bounds of 'unsigned char[15]' [-Warray-bounds]
    3678 |         mbox->m_out.xferaddr = (u32)adapter->buf_dma_handle;
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/megaraid.c:3662:25: note: while referencing 'raw_mbox'
    3662 |         unsigned char   raw_mbox[sizeof(struct mbox_out)];
         |                         ^~~~~~~~
   drivers/scsi/megaraid.c:3926:30: warning: array subscript 'mbox_t[0]' is partly outside array bounds of 'unsigned char[15]' [-Warray-bounds]
    3926 |         mbox->m_out.xferaddr = (u32)adapter->buf_dma_handle;
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/megaraid.c:3917:25: note: while referencing 'raw_mbox'
    3917 |         unsigned char   raw_mbox[sizeof(struct mbox_out)];
         |                         ^~~~~~~~
--
   drivers/thunderbolt/xdomain.c: In function 'tb_xdomain_properties_changed':
>> drivers/thunderbolt/xdomain.c:226:22: warning: array subscript 'const struct tb_xdp_error_response[0]' is partly outside array bounds of 'struct tb_xdp_properties_changed_response[1]' [-Warray-bounds]
     226 |         switch (error->error) {
         |                 ~~~~~^~~~~~~
   drivers/thunderbolt/xdomain.c:448:51: note: while referencing 'res'
     448 |         struct tb_xdp_properties_changed_response res;
         |                                                   ^~~
--
   drivers/gpu/drm/drm_dp_helper.c: In function 'drm_dp_get_adjust_request_post_cursor':
>> drivers/gpu/drm/drm_dp_helper.c:59:27: warning: array subscript 10 is outside array bounds of 'const u8[6]' {aka 'const unsigned char[6]'} [-Warray-bounds]
      59 |         return link_status[r - DP_LANE0_1_STATUS];
         |                ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/drm_dp_helper.c:133:51: note: while referencing 'link_status'
     133 | u8 drm_dp_get_adjust_request_post_cursor(const u8 link_status[DP_LINK_STATUS_SIZE],
         |                                          ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/drm_dp_helper.c: In function 'drm_dp_pcon_dsc_bpp_incr':
   drivers/gpu/drm/drm_dp_helper.c:2981:28: warning: array subscript 12 is outside array bounds of 'const u8[12]' {aka 'const unsigned char[12]'} [-Warray-bounds]
    2981 |         buf = pcon_dsc_dpcd[DP_PCON_DSC_BPP_INCR - DP_PCON_DSC_ENCODER];
         |               ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/drm_dp_helper.c:2977:39: note: while referencing 'pcon_dsc_dpcd'
    2977 | int drm_dp_pcon_dsc_bpp_incr(const u8 pcon_dsc_dpcd[DP_PCON_DSC_ENCODER_CAP_SIZE])
         |                              ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from net/mac80211/tx.c:15:
   net/mac80211/tx.c: In function 'ieee80211_xmit_fast':
>> include/linux/skbuff.h:2048:9: warning: array subscript 'struct sk_buff[0]' is partly outside array bounds of 'struct ieee80211_tx_data[1]' [-Warray-bounds]
    2048 |         __skb_insert(newsk, next->prev, next, list);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/mac80211/tx.c:3506:34: note: while referencing 'tx'
    3506 |         struct ieee80211_tx_data tx;
         |                                  ^~
--
   In file included from include/linux/if_ether.h:19,
                    from net/mac80211/ieee80211_i.h:16,
                    from net/mac80211/mesh.h:13,
                    from net/mac80211/mesh_ps.c:7:
   net/mac80211/mesh_ps.c: In function 'mps_frame_deliver':
>> include/linux/skbuff.h:2048:9: warning: array subscript 'struct sk_buff[0]' is partly outside array bounds of 'struct sk_buff_head[1]' [-Warray-bounds]
    2048 |         __skb_insert(newsk, next->prev, next, list);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/mac80211/mesh_ps.c:454:29: note: while referencing 'frames'
     454 |         struct sk_buff_head frames;
         |                             ^~~~~~
   In file included from include/linux/if_ether.h:19,
                    from net/mac80211/ieee80211_i.h:16,
                    from net/mac80211/mesh.h:13,
                    from net/mac80211/mesh_ps.c:7:
>> include/linux/skbuff.h:2048:9: warning: array subscript 'struct sk_buff[0]' is partly outside array bounds of 'struct sk_buff_head[1]' [-Warray-bounds]
    2048 |         __skb_insert(newsk, next->prev, next, list);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/mac80211/mesh_ps.c:454:29: note: while referencing 'frames'
     454 |         struct sk_buff_head frames;
         |                             ^~~~~~
--
   In file included from include/linux/if_ether.h:19,
                    from include/linux/etherdevice.h:20,
                    from net/mac80211/sta_info.c:12:
   net/mac80211/sta_info.c: In function 'ieee80211_sta_ps_deliver_response':
>> include/linux/skbuff.h:2048:9: warning: array subscript 'struct sk_buff[0]' is partly outside array bounds of 'struct sk_buff_head[1]' [-Warray-bounds]
    2048 |         __skb_insert(newsk, next->prev, next, list);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/mac80211/sta_info.c:1577:29: note: while referencing 'frames'
    1577 |         struct sk_buff_head frames;
         |                             ^~~~~~
   In file included from include/linux/if_ether.h:19,
                    from include/linux/etherdevice.h:20,
                    from net/mac80211/sta_info.c:12:
>> include/linux/skbuff.h:2048:9: warning: array subscript 'struct sk_buff[0]' is partly outside array bounds of 'struct sk_buff_head[1]' [-Warray-bounds]
    2048 |         __skb_insert(newsk, next->prev, next, list);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/mac80211/sta_info.c:1620:37: note: while referencing 'pending'
    1620 |                 struct sk_buff_head pending;
         |                                     ^~~~~~~


vim +211 drivers/scsi/megaraid.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  181  
^1da177e4c3f41 Linus Torvalds 2005-04-16  182  
^1da177e4c3f41 Linus Torvalds 2005-04-16  183  /*
^1da177e4c3f41 Linus Torvalds 2005-04-16  184   * mega_query_adapter()
^1da177e4c3f41 Linus Torvalds 2005-04-16  185   * @adapter - pointer to our soft state
^1da177e4c3f41 Linus Torvalds 2005-04-16  186   *
^1da177e4c3f41 Linus Torvalds 2005-04-16  187   * Issue the adapter inquiry commands to the controller and find out
^1da177e4c3f41 Linus Torvalds 2005-04-16  188   * information and parameter about the devices attached
^1da177e4c3f41 Linus Torvalds 2005-04-16  189   */
^1da177e4c3f41 Linus Torvalds 2005-04-16  190  static int
^1da177e4c3f41 Linus Torvalds 2005-04-16  191  mega_query_adapter(adapter_t *adapter)
^1da177e4c3f41 Linus Torvalds 2005-04-16  192  {
^1da177e4c3f41 Linus Torvalds 2005-04-16  193  	dma_addr_t	prod_info_dma_handle;
^1da177e4c3f41 Linus Torvalds 2005-04-16  194  	mega_inquiry3	*inquiry3;
^1da177e4c3f41 Linus Torvalds 2005-04-16  195  	u8	raw_mbox[sizeof(struct mbox_out)];
^1da177e4c3f41 Linus Torvalds 2005-04-16  196  	mbox_t	*mbox;
^1da177e4c3f41 Linus Torvalds 2005-04-16  197  	int	retval;
^1da177e4c3f41 Linus Torvalds 2005-04-16  198  
^1da177e4c3f41 Linus Torvalds 2005-04-16  199  	/* Initialize adapter inquiry mailbox */
^1da177e4c3f41 Linus Torvalds 2005-04-16  200  
^1da177e4c3f41 Linus Torvalds 2005-04-16  201  	mbox = (mbox_t *)raw_mbox;
^1da177e4c3f41 Linus Torvalds 2005-04-16  202  
^1da177e4c3f41 Linus Torvalds 2005-04-16  203  	memset((void *)adapter->mega_buffer, 0, MEGA_BUFFER_SIZE);
^1da177e4c3f41 Linus Torvalds 2005-04-16  204  	memset(&mbox->m_out, 0, sizeof(raw_mbox));
^1da177e4c3f41 Linus Torvalds 2005-04-16  205  
^1da177e4c3f41 Linus Torvalds 2005-04-16  206  	/*
^1da177e4c3f41 Linus Torvalds 2005-04-16  207  	 * Try to issue Inquiry3 command
^1da177e4c3f41 Linus Torvalds 2005-04-16  208  	 * if not succeeded, then issue MEGA_MBOXCMD_ADAPTERINQ command and
^1da177e4c3f41 Linus Torvalds 2005-04-16  209  	 * update enquiry3 structure
^1da177e4c3f41 Linus Torvalds 2005-04-16  210  	 */
^1da177e4c3f41 Linus Torvalds 2005-04-16 @211  	mbox->m_out.xferaddr = (u32)adapter->buf_dma_handle;
^1da177e4c3f41 Linus Torvalds 2005-04-16  212  
^1da177e4c3f41 Linus Torvalds 2005-04-16  213  	inquiry3 = (mega_inquiry3 *)adapter->mega_buffer;
^1da177e4c3f41 Linus Torvalds 2005-04-16  214  
^1da177e4c3f41 Linus Torvalds 2005-04-16  215  	raw_mbox[0] = FC_NEW_CONFIG;		/* i.e. mbox->cmd=0xA1 */
^1da177e4c3f41 Linus Torvalds 2005-04-16  216  	raw_mbox[2] = NC_SUBOP_ENQUIRY3;	/* i.e. 0x0F */
^1da177e4c3f41 Linus Torvalds 2005-04-16  217  	raw_mbox[3] = ENQ3_GET_SOLICITED_FULL;	/* i.e. 0x02 */
^1da177e4c3f41 Linus Torvalds 2005-04-16  218  
^1da177e4c3f41 Linus Torvalds 2005-04-16  219  	/* Issue a blocking command to the card */
^1da177e4c3f41 Linus Torvalds 2005-04-16  220  	if ((retval = issue_scb_block(adapter, raw_mbox))) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  221  		/* the adapter does not support 40ld */
^1da177e4c3f41 Linus Torvalds 2005-04-16  222  
^1da177e4c3f41 Linus Torvalds 2005-04-16  223  		mraid_ext_inquiry	*ext_inq;
^1da177e4c3f41 Linus Torvalds 2005-04-16  224  		mraid_inquiry		*inq;
^1da177e4c3f41 Linus Torvalds 2005-04-16  225  		dma_addr_t		dma_handle;
^1da177e4c3f41 Linus Torvalds 2005-04-16  226  
ec090ef8cd1c23 Suraj Upadhyay 2020-07-29  227  		ext_inq = dma_alloc_coherent(&adapter->dev->dev,
ec090ef8cd1c23 Suraj Upadhyay 2020-07-29  228  					     sizeof(mraid_ext_inquiry),
ec090ef8cd1c23 Suraj Upadhyay 2020-07-29  229  					     &dma_handle, GFP_KERNEL);
^1da177e4c3f41 Linus Torvalds 2005-04-16  230  
^1da177e4c3f41 Linus Torvalds 2005-04-16  231  		if( ext_inq == NULL ) return -1;
^1da177e4c3f41 Linus Torvalds 2005-04-16  232  
^1da177e4c3f41 Linus Torvalds 2005-04-16  233  		inq = &ext_inq->raid_inq;
^1da177e4c3f41 Linus Torvalds 2005-04-16  234  
^1da177e4c3f41 Linus Torvalds 2005-04-16  235  		mbox->m_out.xferaddr = (u32)dma_handle;
^1da177e4c3f41 Linus Torvalds 2005-04-16  236  
^1da177e4c3f41 Linus Torvalds 2005-04-16  237  		/*issue old 0x04 command to adapter */
^1da177e4c3f41 Linus Torvalds 2005-04-16  238  		mbox->m_out.cmd = MEGA_MBOXCMD_ADPEXTINQ;
^1da177e4c3f41 Linus Torvalds 2005-04-16  239  
^1da177e4c3f41 Linus Torvalds 2005-04-16  240  		issue_scb_block(adapter, raw_mbox);
^1da177e4c3f41 Linus Torvalds 2005-04-16  241  
^1da177e4c3f41 Linus Torvalds 2005-04-16  242  		/*
^1da177e4c3f41 Linus Torvalds 2005-04-16  243  		 * update Enquiry3 and ProductInfo structures with
^1da177e4c3f41 Linus Torvalds 2005-04-16  244  		 * mraid_inquiry structure
^1da177e4c3f41 Linus Torvalds 2005-04-16  245  		 */
^1da177e4c3f41 Linus Torvalds 2005-04-16  246  		mega_8_to_40ld(inq, inquiry3,
^1da177e4c3f41 Linus Torvalds 2005-04-16  247  				(mega_product_info *)&adapter->product_info);
^1da177e4c3f41 Linus Torvalds 2005-04-16  248  
ec090ef8cd1c23 Suraj Upadhyay 2020-07-29  249  		dma_free_coherent(&adapter->dev->dev,
ec090ef8cd1c23 Suraj Upadhyay 2020-07-29  250  				  sizeof(mraid_ext_inquiry), ext_inq,
ec090ef8cd1c23 Suraj Upadhyay 2020-07-29  251  				  dma_handle);
^1da177e4c3f41 Linus Torvalds 2005-04-16  252  
^1da177e4c3f41 Linus Torvalds 2005-04-16  253  	} else {		/*adapter supports 40ld */
^1da177e4c3f41 Linus Torvalds 2005-04-16  254  		adapter->flag |= BOARD_40LD;
^1da177e4c3f41 Linus Torvalds 2005-04-16  255  
^1da177e4c3f41 Linus Torvalds 2005-04-16  256  		/*
^1da177e4c3f41 Linus Torvalds 2005-04-16  257  		 * get product_info, which is static information and will be
^1da177e4c3f41 Linus Torvalds 2005-04-16  258  		 * unchanged
^1da177e4c3f41 Linus Torvalds 2005-04-16  259  		 */
ec090ef8cd1c23 Suraj Upadhyay 2020-07-29  260  		prod_info_dma_handle = dma_map_single(&adapter->dev->dev,
ec090ef8cd1c23 Suraj Upadhyay 2020-07-29  261  						      (void *)&adapter->product_info,
ec090ef8cd1c23 Suraj Upadhyay 2020-07-29  262  						      sizeof(mega_product_info),
ec090ef8cd1c23 Suraj Upadhyay 2020-07-29  263  						      DMA_FROM_DEVICE);
^1da177e4c3f41 Linus Torvalds 2005-04-16  264  
^1da177e4c3f41 Linus Torvalds 2005-04-16  265  		mbox->m_out.xferaddr = prod_info_dma_handle;
^1da177e4c3f41 Linus Torvalds 2005-04-16  266  
^1da177e4c3f41 Linus Torvalds 2005-04-16  267  		raw_mbox[0] = FC_NEW_CONFIG;	/* i.e. mbox->cmd=0xA1 */
^1da177e4c3f41 Linus Torvalds 2005-04-16  268  		raw_mbox[2] = NC_SUBOP_PRODUCT_INFO;	/* i.e. 0x0E */
^1da177e4c3f41 Linus Torvalds 2005-04-16  269  
^1da177e4c3f41 Linus Torvalds 2005-04-16  270  		if ((retval = issue_scb_block(adapter, raw_mbox)))
3b8a1ba378b750 Bjorn Helgaas  2015-07-07  271  			dev_warn(&adapter->dev->dev,
3b8a1ba378b750 Bjorn Helgaas  2015-07-07  272  				"Product_info cmd failed with error: %d\n",
^1da177e4c3f41 Linus Torvalds 2005-04-16  273  				retval);
^1da177e4c3f41 Linus Torvalds 2005-04-16  274  
ec090ef8cd1c23 Suraj Upadhyay 2020-07-29  275  		dma_unmap_single(&adapter->dev->dev, prod_info_dma_handle,
ec090ef8cd1c23 Suraj Upadhyay 2020-07-29  276  				 sizeof(mega_product_info), DMA_FROM_DEVICE);
^1da177e4c3f41 Linus Torvalds 2005-04-16  277  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  278  
^1da177e4c3f41 Linus Torvalds 2005-04-16  279  
^1da177e4c3f41 Linus Torvalds 2005-04-16  280  	/*
^1da177e4c3f41 Linus Torvalds 2005-04-16  281  	 * kernel scans the channels from 0 to <= max_channel
^1da177e4c3f41 Linus Torvalds 2005-04-16  282  	 */
^1da177e4c3f41 Linus Torvalds 2005-04-16  283  	adapter->host->max_channel =
^1da177e4c3f41 Linus Torvalds 2005-04-16  284  		adapter->product_info.nchannels + NVIRT_CHAN -1;
^1da177e4c3f41 Linus Torvalds 2005-04-16  285  
^1da177e4c3f41 Linus Torvalds 2005-04-16  286  	adapter->host->max_id = 16;	/* max targets per channel */
^1da177e4c3f41 Linus Torvalds 2005-04-16  287  
^1da177e4c3f41 Linus Torvalds 2005-04-16  288  	adapter->host->max_lun = 7;	/* Up to 7 luns for non disk devices */
^1da177e4c3f41 Linus Torvalds 2005-04-16  289  
^1da177e4c3f41 Linus Torvalds 2005-04-16  290  	adapter->host->cmd_per_lun = max_cmd_per_lun;
^1da177e4c3f41 Linus Torvalds 2005-04-16  291  
^1da177e4c3f41 Linus Torvalds 2005-04-16  292  	adapter->numldrv = inquiry3->num_ldrv;
^1da177e4c3f41 Linus Torvalds 2005-04-16  293  
^1da177e4c3f41 Linus Torvalds 2005-04-16  294  	adapter->max_cmds = adapter->product_info.max_commands;
^1da177e4c3f41 Linus Torvalds 2005-04-16  295  
^1da177e4c3f41 Linus Torvalds 2005-04-16  296  	if(adapter->max_cmds > MAX_COMMANDS)
^1da177e4c3f41 Linus Torvalds 2005-04-16  297  		adapter->max_cmds = MAX_COMMANDS;
^1da177e4c3f41 Linus Torvalds 2005-04-16  298  
^1da177e4c3f41 Linus Torvalds 2005-04-16  299  	adapter->host->can_queue = adapter->max_cmds - 1;
^1da177e4c3f41 Linus Torvalds 2005-04-16  300  
^1da177e4c3f41 Linus Torvalds 2005-04-16  301  	/*
^1da177e4c3f41 Linus Torvalds 2005-04-16  302  	 * Get the maximum number of scatter-gather elements supported by this
^1da177e4c3f41 Linus Torvalds 2005-04-16  303  	 * firmware
^1da177e4c3f41 Linus Torvalds 2005-04-16  304  	 */
^1da177e4c3f41 Linus Torvalds 2005-04-16  305  	mega_get_max_sgl(adapter);
^1da177e4c3f41 Linus Torvalds 2005-04-16  306  
^1da177e4c3f41 Linus Torvalds 2005-04-16  307  	adapter->host->sg_tablesize = adapter->sglen;
^1da177e4c3f41 Linus Torvalds 2005-04-16  308  
124dd90f6525ee Adam Radford   2012-01-10  309  	/* use HP firmware and bios version encoding
124dd90f6525ee Adam Radford   2012-01-10  310  	   Note: fw_version[0|1] and bios_version[0|1] were originally shifted
124dd90f6525ee Adam Radford   2012-01-10  311  	   right 8 bits making them zero. This 0 value was hardcoded to fix
124dd90f6525ee Adam Radford   2012-01-10  312  	   sparse warnings. */
54ebfd57813ada Jon Mason      2012-07-10  313  	if (adapter->product_info.subsysvid == PCI_VENDOR_ID_HP) {
875826a71c8b5e Arnd Bergmann  2017-07-14  314  		snprintf(adapter->fw_version, sizeof(adapter->fw_version),
875826a71c8b5e Arnd Bergmann  2017-07-14  315  			 "%c%d%d.%d%d",
^1da177e4c3f41 Linus Torvalds 2005-04-16  316  			 adapter->product_info.fw_version[2],
124dd90f6525ee Adam Radford   2012-01-10  317  			 0,
^1da177e4c3f41 Linus Torvalds 2005-04-16  318  			 adapter->product_info.fw_version[1] & 0x0f,
124dd90f6525ee Adam Radford   2012-01-10  319  			 0,
^1da177e4c3f41 Linus Torvalds 2005-04-16  320  			 adapter->product_info.fw_version[0] & 0x0f);
875826a71c8b5e Arnd Bergmann  2017-07-14  321  		snprintf(adapter->bios_version, sizeof(adapter->fw_version),
875826a71c8b5e Arnd Bergmann  2017-07-14  322  			 "%c%d%d.%d%d",
^1da177e4c3f41 Linus Torvalds 2005-04-16  323  			 adapter->product_info.bios_version[2],
124dd90f6525ee Adam Radford   2012-01-10  324  			 0,
^1da177e4c3f41 Linus Torvalds 2005-04-16  325  			 adapter->product_info.bios_version[1] & 0x0f,
124dd90f6525ee Adam Radford   2012-01-10  326  			 0,
^1da177e4c3f41 Linus Torvalds 2005-04-16  327  			 adapter->product_info.bios_version[0] & 0x0f);
^1da177e4c3f41 Linus Torvalds 2005-04-16  328  	} else {
^1da177e4c3f41 Linus Torvalds 2005-04-16  329  		memcpy(adapter->fw_version,
^1da177e4c3f41 Linus Torvalds 2005-04-16  330  				(char *)adapter->product_info.fw_version, 4);
^1da177e4c3f41 Linus Torvalds 2005-04-16  331  		adapter->fw_version[4] = 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  332  
^1da177e4c3f41 Linus Torvalds 2005-04-16  333  		memcpy(adapter->bios_version,
^1da177e4c3f41 Linus Torvalds 2005-04-16  334  				(char *)adapter->product_info.bios_version, 4);
^1da177e4c3f41 Linus Torvalds 2005-04-16  335  
^1da177e4c3f41 Linus Torvalds 2005-04-16  336  		adapter->bios_version[4] = 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  337  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  338  
3b8a1ba378b750 Bjorn Helgaas  2015-07-07  339  	dev_notice(&adapter->dev->dev, "[%s:%s] detected %d logical drives\n",
^1da177e4c3f41 Linus Torvalds 2005-04-16  340  		adapter->fw_version, adapter->bios_version, adapter->numldrv);
^1da177e4c3f41 Linus Torvalds 2005-04-16  341  
^1da177e4c3f41 Linus Torvalds 2005-04-16  342  	/*
^1da177e4c3f41 Linus Torvalds 2005-04-16  343  	 * Do we support extended (>10 bytes) cdbs
^1da177e4c3f41 Linus Torvalds 2005-04-16  344  	 */
^1da177e4c3f41 Linus Torvalds 2005-04-16  345  	adapter->support_ext_cdb = mega_support_ext_cdb(adapter);
^1da177e4c3f41 Linus Torvalds 2005-04-16  346  	if (adapter->support_ext_cdb)
3b8a1ba378b750 Bjorn Helgaas  2015-07-07  347  		dev_notice(&adapter->dev->dev, "supports extended CDBs\n");
^1da177e4c3f41 Linus Torvalds 2005-04-16  348  
^1da177e4c3f41 Linus Torvalds 2005-04-16  349  
^1da177e4c3f41 Linus Torvalds 2005-04-16  350  	return 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  351  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  352  

:::::: The code at line 211 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--envbJBWh7q8WU6mo
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICG/vHGEAAy5jb25maWcAjDxbc9s2s+/9FZz0pX1Iatm5zhk/gCAooiIJGgAl2S8cRVZS
TR0pnyy3zb8/u+ANIEG1nU4S7i4WC2CxNwD6+aefA/JyPn7bnPfbzdPTj+Dr7rA7bc67x+DL
/mn3f0EkglzogEVcvwHidH94+ee3zWkbvHsze/vm6vVp+y5Y7E6H3VNAj4cv+68v0Hp/PPz0
809U5DGfV5RWSyYVF3ml2VrfvoLWu8+vd09fXn/dboNf5pT+Gsxmb67fXL2y2nBVAeb2Rwua
93xuZ7Or66urjjgl+bzDdWCiDI+87HkAqCW7vvnQc0gjJA3jqCcFkJ/UQlxZ4ibAm6ismgst
ei4DRCVKXZTai+d5ynM2QuWiKqSIecqqOK+I1rIn4fKuWgm56CFhydNI84xVmoTQRAmJvcFi
/BzMzco+Bc+788v3fnlCKRYsr2B1VFZYvHOuK5YvKyJh0Dzj+vbmupNNZAVKpJmyBpMKStJ2
bl69cmSqFEm1BUzIklULJnOWVvMHbnVsY9KHjPQYl/znwAUjbbB/Dg7HMw6xbRSxmJSpNuOx
+m/BiVA6Jxm7ffXL4XjY/doRqBVxelH3askL6umhEIqvq+yuZKW1fCuiaVINgFQKpaqMZULe
41oSmvTIUrGUh5aylrDn2sWDpQ6eXz4//3g+7771izdnOZOcGk1QiVhZ28XC8Px3RjWuihdN
E3v+ERKJjPDchSme+YiqhDNJJE3u7SXMI9COhgBo/f1GLCznsTKzvDs8Bscvg2EOG1HQsAVb
slwre2mMvi9KVFhUSHuJzNzp/bfd6dk3fclDVQBnEXFqM4Q9BxgOY7B5uWgvJuHzpJJMGZGk
cmmaIY6k6fZJEberDf/0iQtg1EPYZam15QFY5oXky06pRRzbk+py69RWMpYVGkZjrE43hha+
FGmZayLvvSNtqHzboWlPBTRvB0SL8je9ef4zOMPogw3I9XzenJ+DzXZ7fDmc94ev/Sg1p4sK
GlSEGh48n9vyhSpCi0gZ7CSg8ImgiVooTYyWWCCYn5Tcm0YDxNoD42JCgEJx78L+hzF2dgBG
x5VISbMpzRxJWgZqvOjQ/X0FOFsE+KzYGlTXN3pVE9vNByCcHsOj2Vge1AhURswH15JQ1onX
zIQ7ks5mLOp/WFZkkTASwUaxfQg6DFDzhMf6dvah1yqe6wV4kZgNaW5srTRUPI/Y2jMzrR1R
NGFRbU3ayVfbP3aPL0+7U/Bltzm/nHbPBtwMyIPtlnIuRVlYIyjInNXKzyxXDTafzgefrY9x
YAv4y1H3dNH04RlQjajH0zOKCZeVi+nY0RjiHDDPKx7pxLuzpbbbTnda8Mixwg1YRq4bHuJj
MA8PTF4iidiSUzbdM+yeZr8OW6Klu8A444pe7hgckm9HCbroaIgmjq+A4EEVsAmUn3PC6KIQ
oJboF7SQvnHV+khKLUwf/UqCsYf1ihjYVEq0u5JDXLW89q8nGj1Pp6hYMNMmMJKW9phvkgFv
JUpJGQZNPbPIhF/+jqIqBNyEFNEoQLNx6wePhKaNFUyb77fO94PSluihEOh3XCMDcbQowB/z
B4ighUSHD39lJKeO27tAVokb/9oOmij4h2cYtaG29jm4aA7BnnRWc850hm6n8e/eDusl91C0
G78OvBxnZYLTcTjiGEw7f3BcHUtjmE/pD4NComDcpV+SElI9yyLhJ1iMQZRfg2lWrGni9lsI
L1vF5zlJ7TTNjMwGmPDQBqiktqhtVM2F3RN4+RLmwLfrSbTkMMJmupVjqEMiJbft+wJJ7jM1
hlROtNZBzezh3tR86awYaoYJ42Kf8V1QO0kDQVgU2bbfzCvqbtXFye1S09nV29bdNRl7sTt9
OZ6+bQ7bXcD+2h0gWiHg8SjGKxCk1qFb07zn6Y1+/iPHVpplVjNrPaUlqErLsDbFzv6ElJNo
yFYX/q2RktCnMMDL2Wap8JOREJZVguduYmi3EWDRb6VcgRmHPSayKSYdWUJkBOGGo4hlHENa
ZAIEUAPIlsEfOMZes8w4GKww8JjTNj60AhwsBQz0tVsDN8Pv9FjaAZ6J1yDNilMyB1tSFoWQ
bg6/AJ8yRtQ+SmSQZMXgHmAY6NTsLdBlaaq09xukhhV0pmHXVCzHqoS1kzIroIS0igvstMrs
sKhjSyA7luDp6jB+TJCsGKRftsiQXy/qAffDMToNQgXktP1jf95tMZwbla46quJpc0aF/k0d
6W/hcXN67CNzwFcFjKzS4exq7Qy5hpO1chH4PbMj5YkuOl+sCHJD1XfjnQbhuvxOaAiQpopx
KBtmHx8+XLkC6zJnVQYoq0iChCGamTzixNFDlfnCUcOcgKK4rA2owupWE7K/7xkhHstc3BB5
t3ZLEo1IRjyoq3gGUqmH2/dvfeyobxcjGtSyWt7Y4zVLivsWfXz1cTHRsCeZvV9Mt3/rt2Fm
ruq1NvWRFCxk6g8rkTSG1VFo7qcDy3as4HOoOzMIxfSDDbVxrDudaeB5ucY/F8Z53V798/Gq
/s+lAOswInAqJGAJJmRdLEkU1YHU7fW7gZrQUkqITmG488k5YRBcVSXECBAoeJOX5OF21gts
FptpsiKSVQkObbhoUegNDQCDZU1IrqtIh1VdQXzlzuQFA9PFRQICbDB36+pB5EyAx5C3s1nn
sS1tLrLOJfYQiFAwPo2GqAhwpv4YiQmoiZtECdnz9ZXFkKYLp4PWtNaVPMtHr+7A/q+YrFgM
boqjI+8d52T7SnQVrtZVbaxJev24+w7zB0FDcPyO8/Tc2y3FwO9YApg4h4PWg69Ar6gHqAXA
QjZssJBMexHGSxlXkQixGPsWsHemHljpRDIS3bru7eY65KbqVtlhPhiRlDzcVzoNQWfjth7W
7hUt2tKbLUgmopqnKhjFEMBiKKIyZQoDRBOYY/Bozfa8rvjXRuO2L9Wn0AnsR7oAJY+scTcB
VS07qoOFAssC3rhf2zh2Un0MEuzwTY280JyK5evPm+fdY/BnHRh+Px2/7J/qQl/HCMma+r0/
oLnEZhj1/IsqdVkjxBeYd9g6YIJxlWGkPuulaybcmzvXpaPus06lQ2WmNbML7Rauru47lZ06
AddsLrm+lKSjeYiGjVehr/xXNwF74OwXG9pxs3AKg7uCpC60PpMC/0/lfeEeIHjRVQxTiLrW
bvNiczrvcf4D/eP7ztrPBZGamyatEXMsLySdeU/js8CQ1XZ4u6lQsb9hzzzjc3KZuSaS+9ln
hP4L+0xFQl1kn0aZw9wCDwy5mnMfJZhZOTV+VU5MXH9eRmR2efws9naLR2DvP/owNIuMJrgS
NftzqAO2BmXgRyh3tQpgSw58hAs23rA+CxN9QdZSKWjHRZ2mRGCj3dNUC7m4D93aS4sI4zuv
FXL765RE5TNrSfJmM6gCYoIydw1EbdHrHESBekEaRSuZrdoRsX9225fz5vPTzpy6ByaFPjv5
d8jzONNo+H17vkYqKnlh+ZgGjGVP2+5LFpVZYS/RVP9GgGz37Xj6EWSbw+br7pvXOzf5nVMi
wSNO+4yjVaIiBX9TaONDwNGo27eDRiHmxq5SN1GxX1tNXC0Zzm19UtOy43M56Bz+0rgcmHy7
njoXGrytqxcL5YtT20O2DCOPjKMBi+Tt26tP77tEloEyFRAcoR9dONV8mjIwdhN5TCxBPPdM
gGZOsRk+x0XqMTb2+SzEmgKiwx1UkxF1+6Hn8oASeNo/FEJY7uEhLC0X8nATi9T+Ns7UnuQW
glm5k8qa5TOxFZYk/MF2YvIVO4/EDKGPnLIMVkJKu5oC84/T3x4D9iFHWYxOiYcdFZrV8Zfx
h2YTRJvzJiDb7e75OciOh/35eBrEMhHJhga32V1TbVv89AbrNcouayzCiq01y/GehWoFzHfn
v4+nP4GxtT2tSaYL5hsz2K21Y8XWYEXsLDqugUI4sYuBRZz4FXEdFebMhA1rha3Bzb2yABRv
s0AsAopp32oBBKxJgRd9lOLxvYMxTYrk3sSwsNxZMTivBZoYUrWJMycwXL5anrY2YSh5NHdq
tDWkWqYEQh7De1SScykz6T8zadA09glh2H+8up7d2X330Gq+nGBr0WRTNBGj/mVIU2vbwse1
E5lpkvqrF+vrd154SgpfybVIRK3VvVYwxlDmd2/9utEdZhrFvnvZvexA239rXLNzhaChrmh4
N9AEA060T6IOGyvqa1VICASmm5ljnTtXaREu3dC2Bav4kgwq9gqu2Z3vWKRDh/G4fxoqHyvY
FJc4ERztmNlc2olDC43UeL8iHP52D7O7BlJemsk7f+dg+BrEiCFNxMLnUlv8XexZGSoilvq4
xXc1zn/7p21NLvboX8Ak8R9QdzrGJ64cNXgwM5Ipn3vvOKTl0Po1632p1ah400Y57jBa6PTs
tBRqGEsP8EXMYwHpotcRt0SNdLevvvzvVXOP6Gnz/Lz/st8OytpISe0zugaAmT0f7WZEaDp1
S6SliFdjduWNYw0bkDkc84dkDQHujwtdSbUsfEIi/P0lEVPhEZIObhF0c1HEYyCysE9xWniG
lULn6BIxzIB9sPq0xbojaqGcM0sLnof3mg3H3eBg1iYG3hBg3dbL1Vwy9jOlJOe+qnA7aGLf
AkMgluILkXI6EhMxc+K9ftaiMSQdmkuEK4hRUi/DnFziV7D6QuiQHR9Or4EuQj859D1yCAjH
mGHS9iDB1OUaq8dMTM2uOdOI2VgcXeZ4e3fB7v0zrKcNIvAznU7vrYZi7E4aRGMEXJymbYg9
dhlotSwjSa3rulGu8CRG4A1ou7KoM2KKXD5Y+08/MncMl4WYuqe0bILunlsLMbG6BwyJdtHU
61qUKb34WLmIUaETpsicDTU99fWwIp3yPLlKbMpE+aKCO2lfecevSmXRAAJaZKW19U0tkzU4
K28h6lRisDnlugpLdY873i6E3nVZYJNkBefd87lN/5okboQaIOzErMtbSSZJZCRsqqXbP3fn
QG4e90esdJ+P2+OTVWYhEGM7wTh8Y95J8O7BcnKjSO91BSkUazsm6zcQvR+aITzu/tpvd8Hj
af+XU2ALizumE1e770ENIGGTVRytvfDEAy/ImAcrHA94TzJ3OO3B2iVJu3V2D6vhs5Jk5XfQ
gAtpNombrzxTh4jfZ59uPlmqBSCuhEkb60gFrGlUixcNJxKJlx4hl2tKfBUuxEVsOSSnJKVV
yDVeQZtIP5GM6E+zSWScsgudzmUtpT1ukj/gaX1+MxRnsSS44AXlzL265FCpMn/LJ7FrvNwy
FKivYtQufEJY6lt3AzS3MfA236WWbiHagKlzS6ID4e0LH7jtZSgDjzn+fWFSsgvDKhhZNJPq
dqp+J7Orq4GALFPjgdTAjHIyFC3+OHt/Na0d/ZJOkrTiTUmfrht5XC2oZceZnGjYUliTamNF
PLyWb4ErOj6RxAlWBYiJ99C+bLa7wX5M+M1stnZ7yWhx/c4A3dWqwcP1bJ8BjDvqBChV6Arg
8P2IJ32GZGKucR0HeBurIsReD8WFOFkB8t3H9bSVG/H1qcF01xkNCaLd6TOqMYKW7S615msw
L67dw0PL+kq4GrYbGFgrWNLewWRU+0rbKy5ZCml1L+gKoj9zUmLJHs+xOjVzwtTUgExBGWJf
vwduG+IgWCrwYGBFZA566i3Tt9SUSd3dAaxEXqqxLBBw3pUgvLkYyyK8GhM5ddqOEC8NNA/l
DBEG3Be7hwmQpKeNuLQvhvX9wwdL0zIl4Or54GGWQ4bXFdbmkt/E5f9+mpoSwcSN+p5u8qij
m0MZkfFVxg69cmL8jNDRArewCi8K8VxpyXwFOJusLaW8akoW6vhtF/y9P+2esP7fhCrBafe/
F4AFmwAf2wbb4+F8Oj4Fm6evx9P+/If1/qfjnTGVjKWtUmbf6ujA9uM6DyeFpy544cV/99ll
Aw3y0sspF/Wx5yUWkA+FEGsOz7Z7adJsGqk0mcQlenxNuEMKGk7mSR0RD5WaZF+oC+whq7lw
EmeREZ38uxxZssqKS73B0lfqPqf/gRWSUkX+jVs7uku8dJRemoNaN9oL3JcY4SomBHrFq27m
7K67dSbjBbezrfq71equ0wbM86L0m/aGYF5MFuk/jUpsn4omq50sMXzyPAqyXCP31tBj6/wE
PiAjnnNtX61BYG4HaQ0ALw84MgI4cUOrJg3dnIJ4v3vCi/Xfvr0cmnpo8Au0+LXJiqz4Bvlo
GX/49OGKuJ3Wj3qdDtFWQuTlH5iZr5KkY/HjqBgBKn49mIoif3dz4wE1YYIriEEAC//qNBTX
VUm8zyCRIJPLwbQjxI1JOmgtrNOBgZtgzste6WYenEY1dCj4mMCz2Pm6QNRUu5t4JfN3o/5q
8KUODcXHeqoGCqA/vUuc18L/UblaJkVXzbS2jVPpS1d1ja+HzKUwUcOgXm+e2WVq7kIhamou
5jbAmPBUOEU2phMtRNqWoNoUfCr9rt/I2Ao8/LBeWVvJJzd3TMLS+5AKsEQ5N3YbiO9FSYcz
l2jVVO3GJcNA5j8R9y/XJgStCp0NxIF59+d4iMMYczEx6rF/MPOnS++hL6CI+yiJV4ySkTRc
LCelKaRvgxgMqUt6zpxgSa9+3SBifwG7o2pWamrWkAQfIHt7mJh1HyGT1/iHp5tEaDy/G2bM
FriiU8m4TaQS95cq6uoiNGziTHzJPCrvYcNYw58zu6iAUPyRjFG9t0P0j8jdwda1HBDYX13D
9mtsO4ld3lSKZdNqiT81AtnRxK80GBkI3s3wvzrt5NdJmUdY5WDTgjqEqLCj2Y12z/uvh9UG
YnqcaHqEf6iX79+Pp7NdJr5EVt+2O36Gddk/IXo3yeYCVV1V2Dzu8AmeQfeLjj870fKyp4mS
iNXvYT1QM/gJFFZnLqDaps5c/v7helYz9ddP/lX07mKpX6E7ZWeHx+/H/eHsXIRCg5NH5vGa
t3unYcfq+e/9efuHf/u4hm8F/3NNE83oJP9pbl2Kuk7RWDjJNID8L2cKSon9gntc6qshVSpI
VFE+kVcDj4Fva4b/ers5PQafT/vHr27R6p7l2le/K6L3H66t4jj/eH316doWEDvD5w94Pc81
HZIUPHIj8v7ByH7bePNADK+gkhLtDcH7o+68lfVDhYSlxcQVMIgwdFbE/mkBCfOI4CMK30Bl
zTzmMjNviMxvHbXxR7w/ffsbd/rTEXT6ZF2XXZmlsEOYDmTuQ0b4+xZWfGNqMW0nVh2mb1Wa
sxYzRh9TC23f0e9G2VPiVdvhFZNOeYcj6splxDwAWrqXi9uVSVOxcrDeKx+mzCf50r2D25X/
pPchRo3G8lvTtpIsE0vbkmXVnVDWzwP1qKZFwbxYyebOO9T6201pGphKeRba9bkWbr94b2BZ
Zp9Itkztn0hqG0NeHWFlchpTZaHVLsJzwAQUxGhPbCsComJjlc0bJzvcn9hX9c8QvTxbyWS/
oDJrHq3gA+Yq9bvNUM+qwdU/F7f2e/ZMrDXz5/gJV7DH4aNKC39WiGJBJrcu3q7XFfN3fmeO
G0Puu1+CdynwiXY2tCJZwquBdex/X8maps6AC0h5aP2+uzfDUlDPG/o2K8qVe1M5x98Kwx+9
gfDq/zm7tma3bST9V07N00zVpEakbtRDHiAQkuBDkDwEJVF+YXmdszuu8Tgp25lN/v2iAZJC
gw0d16bKjtXdxP3SaHR/YLS7lZXRsjm8KXTed49kVEt5buStN9irg/9vcAFuhxkzpWLIZrZD
SCRVQcOFQIG2EQKlJFhT3GjWc7V/hwj5rWRKolJZB3xkvTc0NKPMb+RBXUHwnGmMi5kqKGzB
McCFA9HgtIlCzmvWYJPyQDCDOsu2u82ckaTZak4tq9Zshnf6EO41I/Tl2TTrviBizkZOP8Lc
zaDeeN5UM0gh+BTUNa1NE7SyXqYd5Qv3vsFnM/gNxyS7TQA6SxPRvkPB1Q9JUaY7LJOtPD0C
sX7+i+H9JUj72shWwGYXz36IOoGF8Zk2ho/tBc4y8w4Aqo0DcQGeWci3sXHV8K07KjT7/OmX
T98g3sboVa8fP/z+zei7sDgYJeTXr0/WP94V4vPrx++vHubA1O37fF4U3WVzouvBOXEob7Kh
eNZG68e02EHU188tzy95MLZG8rDt6HsbYPY1xAZomZ1aYL+5Uwc/I3KwN7rrxlYsL0p4R6NB
EqjBxd3UZBc/xtUKWp9tMNEH9NNV4QAkSz2Q9rWLBdtsjtiZ3SODWUK3p+ZM2zE9QRgkj7Po
DxzZ6vw2cMfHT98+zg3AWpS6anRfSL0sLovUD2DO1+m6682JCJXfI0dNsL4MbSQ1yp664bW4
PhldsfKGZCsPKugxS9p2nRdfJ7neLVO9WqDrOYg6K3qtqY4x6k5R6TNcjpqVfro9HvdEceK9
GY7UlyejkBXIzdyqDNycGcFqGVcqwJ25ITFCWZ3rXbZImW/zlLpId4vFMqSkCz/vse9aw1uv
Kbv8KLE/Jc5hZfatzX63oFb4k+Kb5dpbVHOdbDLkRABuN/WJNOjBnm2athe8Xs6Qt3SweeTX
vrPoNrDxREx449k8UMYHW5LOD8IP3JOa902rkYcGKInmr2dxizkspD4UjBA1+MfN7CKObkZY
6u3bdyKywg/kQhwZp6K4B75i3SbbrmfJ7Za82xDp7ZZdt6Lcvwe+zNs+251qgRtg4AqRLBYr
UmEN6jw1zH6bLMapeLcLWGrsrtDj9maZM4e71o9Ka1//+PDtSX759v3r7/+2aFDf/mnOj788
ff/64cs3yP3p86cvr7Abfvz0G/zTt3L9P76mVjx8DkMcdJpzxkI48dfI8i/4ib4htOOPFbyK
u0hNQzTiI3Xno0upE9uzkvUMmYEB9TBi67zUrJS0wQntCM4jgWs5uk7Oxj0wAfnAO3UymVvg
aR+jC6RCizAQA5Hcxq/ecx2ye/r+52+vT381/favvz99//Db69+feP6TGZN/m2s6GuNXnhpH
jUMfGGZDfhKJ0LsDNFDje/zYj3qwVZv2F7TgunYBuxZ9yLMCRXU8Bt5rlq6tuybc88/MX7b1
2nHYfwv6ywzwqYdwkgfuGLGiSPs31bsacMkj9ELuzf/m5bef0Ob2ScCa0mn8KCfT1F5dRgDW
oPpBc14t6om/jwLdwkEGIc+OUXapk0HHIpFa2oOBtTQ7mPnPTokgzVOt2axBjPyu62i/u1HA
tEmcz8BQ+oDNOBQl1pRMcqNF+QBkjgB4DfbGavCr86J2Rgk4H7cDYLLSP689lKdRxC36IaQb
5gKk5c+zL8EdrG5E294cAOWs3UBw96jdjMBu9UjAagFB06IV7uIG8Iw2v8/0eIB5XJBBs4PQ
Wcl5ZQDgRJPedo7fcKWbcHUx2aUIP/jI7EJciutRlARDKYrIZLGvOoLjlBWCQbRL3S5Jagpt
Yl16juLnJM2orx7xUypVuVRhY0B4aVu/hJvL+aBPPJ+1tyNH9lskMXMtHrnm4FrqR/z8yiFO
iPL4nmRgCMYHKEi0w2XYg3LCtkSmLrpbWT1YOWwtrOnhscwpYqKdBAK70oMpB6pfdFlXt2Y/
n1W3+M6kS9/MN5F8bCOcWK66ZbJLHiyXh+FFggdDQ9bhiAQ8ZN9kPxKZuyYPNriWDCl1vJta
L3lm1r80rNfEAUP9YM4EP3bwKf45ickOfrItO2rPjBNIwfSzEj4GYiijSKe5oUHC2Wgo3jVC
yInc71j+i1F8TA+alWARpPlSsPmG7HqVL3frPx7sBFCJ3Za2L1qJUtdkLKllXvNtsuuC0oQo
TECrFSd2/VplC2ySsOQHXoVIYxkuZuOCeYDR7qtDgQbvWdW8QsJxO7i/B5ILGfKG+gA6ax11
BUZSAZYFKkTVtOd43NXujsi7sf/fT9//abhfftKHw9OXD98//ef17ubvqbCQFjv5PliWpKo9
PDJTWAeoQprdahEUAD4ig3vuFiKQkIqalJbFxcVrLkt6qRr5MqvrUZgWi6znwDdMnmxScvbb
otorb6KWWha+icGSDhNOIrTcx7BJP/7+7fuv/36ySPvz5qxzo/PnKhwFLzq4jXK5dxTaBnD2
yj+8gVpPlsWKedfwMCyk7GYZAfCnOdNG0Jttd19ibVdegrqA+ULq+YBsTCPHMzAt/YgZ2Uwt
80KFAVrWuQg79CLDpr/I1izoU7Rl/aONaacqK9Ci6GiK0vkdq2n9WwpHa02PzIl1ttl2AdWc
DDarbpYh1+t1uiAbaOIv3+JvHvBvM6cDn212uiYoqNE2lpsNQZxVCYhdWlLU5ayijtzn5FtS
VkK2WZosg9Qscd5s75TkTQS0DEY8a8wmUMw+K0UbNTQ7AaOOMXJTc2ydbVfJOihjVeThzHR0
o7fFHu2wAmZBSRfpllraRn6P0L8sFSKbzaknpOZ8VgDNk5R0OB+4pyANe3PbAO5TmLqZ4Zts
Mc8gMrfdVljpk9w/qH7bSIiSjZUPTXdLucpyX5WTG1Atq59+/fL5z3DKB/PczrxF6PrpRpfz
Z+AR91U7lKBrH4+HRTgeTL8HpMlzDBGJQ45L4PB473Ud/h7COKPuXP/94fPn//rw8V9P/3j6
/Po/Hz7+STnWuf3XepnGqjgdZ++WV2qJHG7RQht3y1UvLagr9Y1hwvt7GHkIqHXEXAQ88LhC
tygj1MJQBmo/2dfETeLhrINjlwPBFEI8Jcvd6umvh09fX6/mz9/m1tyDbMTgQ3RPcKD11Yk8
B018U56U/NAcPINXwUakzEeFGtM3q9s9nHPsLIljIYY+olSThiNfDvfbnCkWyZy4WOPrQkcO
sAAwk/s+XyOtUrvFH3/E6P7pcMxCmgFFyZuFLl1EGTgQIWRyr8EsEANqCJXPobEuosyrpl9y
EgHCk2A5q1uBluaBBNchDfQ8fXvtJXEUZIf5IgXj4JCBbOng0KWDSJBJvhX+BYM5c5bYW9RR
3LMUrTxWZU+N6OFip9WCzkax98F1v8+kDQogEndfn7jBq0xE+i9nVrb+osteQkxfX7whnRA8
ARgYFTrZFQGCX5FQbWTIyDejSNDVWEc23b6pWM796/z9aoV+uJiPs9llRSF8eKWBB9P8ER9Z
6Lla7RZZL2jgQsOGJvfTKDvP1sKDwWMHzJJKyHyG9KT90eI+P9rs3OstcLNM3zKVXQza6d6U
4DqPsi0pLdT7Zua3b4q5x7/CNnRrXNGJnJkRaiTemtecXeT5jeWDn0Sh8fIzkPqWGmwTc0V+
sgJkJbJcd5FLBHBtEBjQmOcWUKLwUnNvBQ+XGF/SQgxHnrfrIC6E7vzcbBOkgpuj0erllItZ
GVpz0qSRPP3vIP7tLSF4JCOKfDfKvB9ehb3fgltKX9Zg0i/Naq/A8z0yFb2UzNHNbCVINTu0
ZtwFMaYe8zjnEsk2QkCMHlZtwqCLka6L/qAiqDLArF/s/hnl25kSFzlKVh4ipgf4HFqJ91I0
9Ki+i4Q5EPU+v5Ot9p5NGmI7DuryLsnoVfpYVccwRHNgTS7VfjOeZLc+5WkfXR7s7dpBxNn1
YgUqCs0tdZ9rRs9fYIZjymfSL/H5FTqzq6DtdJ6UzNI16fDqy4AvubcuBPZ+EZ5rMIfWC+SR
8kgy1IvnXC27I7oqgd+UZiVXCzT64Xd05ZTHN1d6a6wACB1S8J2iq/RcNbE10U/bmToet7gy
EqxE15VFtw6cAy0JPGGKgHaoj+gGfiLCpY6g1CYjoa+zw+Cd6vxAH37Yg7qlWDFPIOLvY3nI
7ciRwLqsGK6TRSD1k90fzFJzfFMVh458gF7rdzes6W90ih0VQnkHk4NgRdlFNsmStdGoTV9M
AGo22bpYqqnKStGLV+ljENho0nBripXxIvPItUtR8/gC5CVRPVPda9a8KqY9OAx2k/jRaCa0
QcqXFqWGlwbfknN3ao9b0RwxCnDWurfWC2fbBV7PBlLEk3fkDggC3lfgahhsBAOvUTH1JrAC
NpvF6o3tvhFwiPNcwrNkueM1/t1WSAUdSH0d2bVHvg0Ob69SxzDiR8EsSXdRATCBAoKk9Zyh
WiNLNju6Ncx4C92pTtHts2GXGHL4mB4gdDaRUaiZ0mcyzMEXEmIGXz2yqoI1B/PnzVXIKBYP
EGUnoRg46CigMBq7VnyXkJZOpwdZPvejTUUteXhXD0JkKpDdDgHBWcrKN9qg1uBmDQsAh7VZ
i2IoDcAz3+uIouon3dqV902x89ttfCurmnZA8qRacTq36KjoKG98hb+QfW6Oi4BuElUOPZmI
ttsCygHsoKebGYlFkAGw6IR/YLhdIqu+J3KV739g+XcO6Y/bppMNrwJoCztGgZFG4M0OeU7C
W5xuGAXFEryzvr4aCrI3ixyuLo5HCHE9UW7pB9nBQzUnzwtMH6YoJSXlE3w3Q4O9W5JUHqZ8
V1aErsr+2BVRCZaDJ06MOVjFIiUfwuz2uPCjMaoPWmLP1XqVwN1KJDcjsFl2XSQzw7Veizgv
rrJVliVz6pYQdVjEY4/dbQaSm6NxJNvB2BBWBubOUEdaz+d1ASgjZJpF1+KyuXjZ7spumF6A
C2KbLJKEY8agx9PEZHEMizuysqxLzX/x8cI6MNgwc1ili66E0diMBtAbJS/Mw6q7kSpPWm5Q
5IncJgQHNNiAXLUVTGeFyaWFZ2RFWCZAcuKrdd++Y2Y3iQ0tkPIkfPNrtlh2YaIvY7Eo9cIp
SDiZQbMI0wEFYWySyB4YLAutOdN2Nd4cGmZGteSxsZbX2TJzPX5PCIgtz5JkTjbTiSButrMJ
YMm7SK6DqwVOaYgeOpolLW2O7q4Jj51nne12a99nBvam0T0aE1Gk/+FaVrkYL18GYnUICGNi
DQ5Cs+Q4ILJlx+8YLJvpWpAP3bqiynbPcKCBo8N9JwScRj+EG0w4kPKgEoCvF5DuxqCAgU+5
QFEXFOXiaJoDtiYGonOcqmMRc7rlVxyuh2JVkPXLapHswjLVL9lis5o2OdBA1O+fv3/67fPr
H/g5waGve3Xu5g3o6OM2l6S0WoFk7S6zyX5I8I3eGQSHzogUzca2FqIjkaawqIKXdI9jo9Rc
RzHgDa/vao6CMwj5SbyQvt8Rxng3P/u9hh2bMkEANxeACiBQCsODW2FCqq7JmEJgQUsE2lNd
V16yujh5Q9WMUYc8Z/FBNGZw1qLzCNCe2TU4rXnMWhyZDiBpDLlpiywhwznv3BRnbfTbbeaH
cwDR/AnsHGPxQUlKSK8dLLHrk23G5tXnOQ/g/j1OL3zcBJ9RcoLhrLIef1ZaYKm9pC6apv5Q
u41/yz/SdbPb+pBlHj3D576JYxadLW0A9kV267C1gXMsNumCaK8SFKaMKAcoZPs5WXG9zZaE
fFPmUgdeu34z6fNeW0MSjryZi4RVZ4U5c603pOOY5ZfpNp012F4Uz5JaZu0njbKvvuNiiNos
i2mWZZj8zNNkR3bIe3ZuSFzFqVJdli6TBYYKGJnPrFCS6JEXoy1dr/hRgJFnNN910tHQ93ae
53x4oy4qIutTfNprKZqGYdyRqTKnXUoNWPbCkyQY4G4lWPYCT5trQT4YEFT2lBf0IRy8Lvpc
p5t1igaDXf+vI1i1Se2+8g8N6f3qT1eHHzuqlbXSA4e3TeFvEShJ/6jsgXnejzA6J/ydvvz2
+/do1KrFBfaPNeZngIztaIcDAH4MYO/3HC1P16zR4lmRz586EcXg5eVnBwxly3X+9vr18wdT
SxrXf/isOmth9L9ouu+qG8J9cVRxIYkuOMFrlRjQqfvgWdz2FQKIGynmDM5Jag3evjGOP6sD
zo7itM97Ku8Xs1qu0WKAWFtqa/Qk0mRDf8yLWm9p494kkw8vFTWbbE0UrXh2RZ4nLmoIyqfv
wUaZEIKalrCPDAnat2gSbDnbrBIKAsAXyVYJ1SVurFLVU9kyXZL1A9aSvmP10u22y/XuUaGU
76p2p9ZNkiZkvrq8mHPktTGEx5nToRwTuxTXFt9lT6yqFiXc2FG7zL0czjpOJnCsivwgwTIf
Q/C6J9NWV3bFTg8e0z6+QL/4cpc6l7FBaIpgE3ijpV40HY5ybxGzjK2Ifmr50kxlauS0Ku3b
6sxP7rm2GftarBZLauHo2lhlOKvB/PG4LsELTfO11bfTwFMXtU4JklGA/PC+O31/yykyXK2Z
/+NTy52tbyWrwQJCH+nmckappNGj77JDIASdocWomkGXzsSE0Q2wk+Wc54pCSWgBNkHsA+UV
wfa+jJzKJ7FDxcEcxSntyMuKKoMDqQuprDZHWZt5yAHr7m67Csn8xmo2rwPUP4KU7gQuuus6
xsLkZkdtV9apZ2MYSaEcDUkzKQHaCHnH1JFiNHNmBiPFWKJpdafnVBU9tiQS49W+YQT9eEif
yVyOTcQlDUn05Pn+LnKWZidUGH9q4oKFugne2ZxLaZmLK7zlSF/gTnKtetwucgx0pBkYpCVk
pvhx2Il9ZU0jK8oKM4kodrS+L0TiRivlosLB05i5Z6RjzV0I3sTyz/H35rjK3Pwgk35/EqU5
tj9KON/v6GHBlOCkZe6e87nZV8eGHTpqUOv1Ar/DM7FAUaYjjCeRrmb0nABGf6Ce7MAi+Nww
8WptuQhMiGD2hwOZe92RrtsT/+Uq/YD3iX7Qkm28UefWihbO/t6Jx/12R3IuOG4BnynrVpBR
LneZEyuvzmo85z3vzY9I2oOlK564W9rNfOCVWs1qBIu75o3w0S08Yp9ltco2i47mslxvsxWC
0cLsbbbdUkULhXYPk9hFNg9CEA0UzOfRPJpkkSY/kodFvlP++1WIfQa3l47LJpbT/pwmi4Ty
fp9J+VDePhOukKpS9JKX2dI/giChW8ZbxZLVIlYSJ3FMEurEhwXbVtchVuBcIHjIhZAIfJwe
iK5icUi+KIDS1k1FF+rEVK1PMlZmIdrIMDGzqWCR0e54M10JiXR8iZ6H9Jl3L2Ky7seqyiWt
k6OqmV1X0AoAErsZovl7tSEtrr6oLKQZcJFKG6ZzASNzid2Y+DJ6o2/bTUInfzyX72Od9Nwe
0iTdxvIWtDUOi0TGh10N++uAIxEVQJdpPtscx5Mki31sTuLrwNEPsZVOEgoBAAmJ4gBAPtI/
LSIBfUw3y8gCoAKtHfWZ6jbnom91pG6yFF0Qdumn/LxN0jdHnzn2K0C6fat/8rY/tOtuEd1C
lDySSpwvY//dyOMpsi7bfxtFNZaHW7PfyOSat9bLJDokrsqsx5FJZG3blaorLdvIaFc8WW6z
Zfz7RyuTVQRY+U5GWgD4SxWrvzWrt3SE1awUVof8IVE7tX9IMlcchmNCe/bPitpYyhv9ZSXz
yYE1XkoIcTb60SzN+BdVSyIuhXLvmA6iO2eNWZCeeKFUGtmrgPn+Br7aMjImXY8ZNY+v1sFj
b6GYnfQ/Uhqmbw8WF/tv2TqwBjKzVq8yMs4IC3G7z0aXISOQzpBWo3LrH5R7S1dtVO8/pIV2
OVkIlsd4Or5u6DYJzrCYqw4tbetCYqE/CynTHMwxZRnXkXWXbdaR7aat9Wa92EYWoPei3aRp
tM/f27P6W5pmVch9I/vLYR1RoJrqpAbtOJqVfNH0HTMqj8UXQx4mg11TkrDWjZKrQAW2JPwu
CVDw6yOWovYB5eCjT4+Uabj79DQfkHNDef/CcqCkIcW3CQ+U1YyCrHWOtkazxd54nT58/cU+
QSP/UT2FWKi43PYnvLUQ2J4HOgfbLuX+ZtlmADgjcvAZDR7geEOcOfmdISr6bbnh24Zjq/VA
ruliVBCnwmpNa99Oxs7E/lEl3UUUTv9sWcQnYNUZkLMn4ZHWl3q9zh581Bdeh09Eoc7J4jn5
P8q+rDluHFn3r+jpRE/cmBjuZD30A4tkVdHiJpJVRfmFobHV3Y6RLYfsPtN9f/1FAlywZLJ0
H2xJmR+xI5EAEpkI51BGk1+16QYZ6/fF7QR2NyxuYf94env69BMibJlxbPoetX4UhxTcJbBq
tsN9laLWVE0jLmrXKdyUOZyjpAVxIins9sZ7ODoG7L4kHgQ03Pr4NnBKcN+jsLVY+8moURys
HmL5tPN0ZcO7SuXn/AsJXMbBwFDipazcfey5NsYQvmswjnCSh35TDmNbHROMx1Yh18EY3BQP
ZfT3GFk40MQ40OYYHS7d+rrCGmxMkr6Vj8xWzgBmIq0i3OAyI9d8ckyWd9wd4Cdk1E6fghe5
Mq5GT9nar1RP8azYOpMvr8VSj0h/LRsbHXiUOcZQY970CfvXKKq8NFqIqI/8I8Id08QjXqDN
XLbQjUmrWg7IPH4yduP7nFEqxbWIzK3Ol7rXmZce3BC29fBoftT1rvuxcTysSDOPOtPTYcqq
PeRF8QhWmkkRq5eCMwdJkrNmFXsOqrjR43OPteeu5z6zRSQ40wKHVcA0vJHVDmg8fmHL2ldR
l3mf1RAMHRNKwDyxrxRbF0YUhrfCTnc10eXlSP748h0tDFtH92JZY0kWRVYdMyNRzYh5pWqW
vjOjYHsW18KsMGZEk8Q737PNNAXjLyzVJq/ASmojVWGSKxHTTPrQzKwshqQpUrnfN9tN/n6K
DQiOWNSEtTta3sTFsd7L+/uZyGo7dxhktizZECBt7axJ0t2xlBn9j9cfPzfD0orEc9t3fT1H
RgxchDjoxDIN/cCgRbZ6ycTbQbg+IHoljyzjC6amYwcAwAKfbJ6Or/gGhMpBvExmY/GsdUPO
FKydryfGyIGL7WAn5i4Y1HQUb3UTQRxdr3P87x8/n7/e/Rui2onOuPvlK+ull7/vnr/++/nz
5+fPd/+aUP98/fbPT2xM/UOxeeP9QAbe5Wzj2YLK7ne4ZSZnDgPxio/Ln6R0IhffZU9886jY
QNzXqOsdzgZ37f3eEG8gpknTLz57xatHmp91+bHiYUQ3PQ3p2K0k8yPTM4oa10EBkR0dixLK
WZldHL2eQm3yiU9MycplsexDXHVCK+bc8VTE5OW9gBC+1PkMLPHIHoLH5HdDWWdwRN1QJn3A
/vDRCyNqht1n5SxwJSrbmjm4Ex4uqUFPpbl94G+UpuzDwKGnRnkJPCreBOcPuObFJY/YaZD8
2jCeU9ma2azKvFLrHFsyUAeTnFeymUYn2lR0YZuBlhAimNfGrGnzHN08AeveNVSEzk0cjzgw
5vzT5MmaFNOldjjLqQ0R+IMzcXMYwWL7owN+GrnyQ5p/roJ8bJwr3T7dY/VwZhtHerry2LDb
3HGveQ9XIOeK7ZryjRxmwIi7EeIr22Z4eEBcS7odzQfeKrugyzYUDRW8hI8hzUm1CEP2F1PO
vz29wAr8L6EZPX1++v6T0ojSvAZLtrOufqdFZYjspHECm5LYayhTtZD1vu4P548fx7rLMZMZ
3pF59aiaRAmNogFH8sLinFeu/vmH0D+nmkmqha43TDos2XgHfR2Yj4AofVOZaUV80bYDnDSF
TMM4EIYOIt3q7SOiUBC2ASsAtGJdhwf6fLIklX49t1rycTExJDaI61Ffk5PB2YBXwtWPHMIB
aPwMRzh2Z3vt8ukHjLPVc7/0kkDJZ0OpW9lGo2CY9EC4YgdIu3M9IrQPj3N1CnEvLOLjEp7U
uyHhm0ukUBLekRYuuMxJ8XMIjhlEzC3hy0fvji0VVOLHZ7qSk0eCW/zx1FGmLBNqfKBrsb4O
lonnHs4Fi0eVvHqaVHKYyFhzqTj6UYYYwLM6awztq+6LXWdT+u/E1mOb6Pw96qCSMzVRyjvc
eP8hMQ+dMTPBsx+r+kbLAOJW6/EX1vfnqskqXNNdQN2ByV+6hOBvAHyZIzKE3LoAk2nY7OeB
LqH2LEPhfSCkJPCKMrTGomj00hRNFHn22PaEBBQNq/g/mYhI1YC82b7iFTf7LSFey8mYwwaG
Vt4Fm1TeBft+rIitGu+8hjsix8MIL4DNwQbG//mDHjBXgdRiWaf5TM93yNBrDNDnhswxEhht
yyIigQBC9wuncFkvubjVz8IduwdK5rGNgSNfR6w01fc20Gc3Gfp4areq93AmruQYj+0UAo+c
nF1iR3kXWIbQgQ1El9e4pisAGyy2RpArAFPt8oshc8mtx8yE5wM0ADYY29ztAQLhIbuECOgE
fNJhxsQNNrjY1kWeg4P68IUPaNiuOLbFxTQ97AGl2dIhyVhMRBfxRoctMNKTL0fVTVLkhwPE
ZiZB2CZKYg+qS0BO4psevQHYfobMY+jBTyH7AY42SdRH1uzbnQ6IshmPmyDNF/uqwEqn3Os5
sypcVWVr+bR5e/35+un1ZVKCDZWX/cPf7fJeKLLAGSxj/hSa9zdZqXis4lIfY4S3zBMaXKKR
n7CxP8yAlVXfAMOoL9A+vXwRgZT1uxNIiQ0pcJx5z696lZvvlTntF/GCzaDpGHDJ9XeI9vH0
8/XNvAfoG1am10//QUrEqmH7UcQSZYKYhysBT0vKfabx9fKxfkkyxQ+ZGeOxrc9KS+ZVKbsx
kPBwt3I4V8kc2VrKgv2GZyEYSwOKXR995TOXKh4ax1JeICycfmezVsXlywIighXM/H1pRxER
pmmCpHHkW2NzbtAIUwtoZwUOVsyiYasYusTNiDJpHLezIvXq0OAq96A6F8t5Xq03soaYirLH
jIU+2L41YIk2edfHLFVcNV6+78vDZpXjIWSqn4XlAE+zjNDdGqZOsqLGj6qWLBZ/Zh2pyS/J
XYnQUvMoEqYkxxtjbULh+1wdRcT+mscl7IipV8AKiNhWS5jAtXEfSwrGeQfGfwcmwFUdFfOe
8twA8SsrepM2w5LHYyWcOm3CKiIe1sJubmdVdc478mluYuLODbdF0j5rmVoy7o8e8Qx0yW7j
CmOZ0UzZ929Dwm1I2REhryY+v2Pouj1ECL0xuYsm7jq4ozLW65atmj+eftx9//Lt08+3F+zI
dBF+wtHfdrUO05XeTVQbxWG4221PtRW4LSekBLe7eQESx3tmgu9Mb+e/G4jvzs0Sbk/WNUHc
lYaJe2e+u+C9fRK8t8rBe7N+77C5oV+swBuzfgXG7wR678O58faAbT/G223CANuN0X48OttL
7Frm97aC986e997ZT947h6b3ztntJe+tSPbOEefd6IYVuL/VX9XtlLpT6Fi32wRgwe0m4bDb
YozBQiqsqg673a8Ac99VttDHL4B1WHR70HHYtnY3wdx3zGNe03f1Qui8p6aDlta0b6RWVjMZ
Ye6yrf3D/f8NrQM5+TMxcLLWJbvohuyebviJUAQa6sYgnKwBvO0OnFDvSet0S7BwVNnYNxT5
GXZjoPb5mNdpVsSYJf8Mms/BsO3XYkdQpNvjaQEyRfydyK5It/UEOc3t5liRQ7ctCKQKBXgk
IARpb8tHCXlDWsnlVMaBsOJ9/vzlqX/+z5ZGm+VVD1ch2+p374TWdpn5Zcv2UOSQ7TFd9tGt
kQoQZ3uUQnGJl8orJAhvKHcAuaEaA2R3qyys0rfKEtnBrVQiO7zVupEd3Ybc0Cs55GYHuDeb
LvLtbRnHms7Vm242oqaGrS5oijo5VfFRiVW+HAGlmexbadmwd15Y7NCjtL5sLmGIB8aeIXsb
P7fKHs45f8KIRm6Evb1yeToRxkPc9U3cn8YiL/P+V992ZkR90Gw750/y9mG6I5sY4qhT95fF
zUC7x+6AvVgQ9vqK/f9CGi+2Rp2OWTUq90porQ8Gnr++vv199/Xp+/fnz3f8MMOwo+LfhRBZ
G4wEjNJuWLsIPm3DLPE3zuMEijRn4eyWpbLP2vYRjA8G/B6GAzGrZRMxHLsN62cBE/bNNGCy
+dgA0MYenJ9e42ZvNHeWbxg9CgR+5iIsjHv4YaE+ZORRIxubKuwWHbG63bHCK66p8UFeb/QR
D9V12Wh75PTcALjOFqDcR0GHOv0W7Kz6qPkxEfQmiSjDYQGgbRcEf9ioFmV2LJ6flqxXbnc+
ZdErZklCBN8U3BSz5RcSKS5jP3WY3Kz3Z1Ne8etx8ttcjlQoSBAdNRHvdrSkNivHpC4PwkJm
9dgl8oM0TjSEv6CSprcr2yY2bAJhOEVQ+ZumuRxxgYC6VY9fagrEEPn4is3ZInJ2tyGDNqxz
Bb/A7oGEwC3T8cB9RmgzN+1dx3O1RBcVgFxOlncznPr81/enb5/NZWb1nKyJf0GHZXRjjUir
DalyvI6axay5LlrYaumYo2ei68VRJiI8aXP1kT9R4UOME1pGVk1yiHzimF0MxCZPnIgwrJ+H
6k4fqpJFrdYhQi84pO/oKMcsbtzmH/FHQWLVTEPLdyKt7oxqR7aPUQ0s3Kn6vpEvWCFSmX6I
q49j3xfGR+JdCvVZ0bg7z9WyL5oo9AO9qLraugyS6TrTJPtm07WJ3/vEVkCIt8KJSKtv0dPC
JTFVI+4RxLH1JuXkne2YQlI4KqaS0/0nLURfrzMj7nae8uLSHGDTg8fcHHia5tVvrv1lwbQL
3NpnmlCbzJxJOPYL6k18hmQC43haNduUqR229pTcqM9iVLM5wZjCbQceJnlcG4/sKMkxfS9Q
Jq4bRYhwybu6wwyfxOrQgj9CV64OUmzh3p+tQpvVUV47LMkhn/HkLl/efv759LK1IYmPR6ZA
xL3saUXUtU7uz42cC5ra/M1Veal6tcekNqMq2P/875fpwcRqALV+Ih4PcE/y9aAlN/HSzvGI
izgVFOEbfSmXATP2lROxr5LavjLUjelK74653FpIXeU26F6e/vdZrf70BAQiPCvpC3qnuMJY
yFBXy9caS2LhR4IKxsZlpZoOrsIpGOL8S8ZEFvYwSElFdt6jMmyK4ZIMph0nFDPCGb7sD1Jm
hBFRsjDSx/5a34zw1KWCbPwkSB0qy2lMfc1aEfdXOuBZiWyPnziBdlAjsWHHTW7ddSC1NZdx
xwyiiQtSjTo8VtDK9NE58GuvBX2WMWCmygA9ZbItY4UdkxkhGQXzx/PvrUPBWnjnO1QhmUA9
FyBSbyRzo66zA5gbqSy7NTQRwUUrhpedfDzaZuCtg60LqRzKTCSv8vCCJA5lLFOBDxg5DbLG
3blpikczC0EnX6YpoNO1lDe3DYREBb6yqk/HN3GajPsYniihwT7jIdo5/vL5PLe5Pse+mxZQ
lWzkJTQ9QUcygSeBeg5TkWQf1Uty4NsEgvDCzsIizC3m7+Okj3aej20zZkjCNlSNmXNydSx5
pzHTQRyqkXJkDvqyXQHYeJKRgyVZZMd6zC74sjODuj12Bjy3EuOuOZZxFRvEOZ39A4zfASvH
xCJ87uioUyrtWbkF7kD1LzjbDRUnSxoHbRbOc1DddoZMOxLYcEnr49wopuvz+bt28G0Tr42R
mZx3DZTRZPB5Y7nYqKW3SjMCdo78SFGjq+vKmhXvUpNR9G6A1QW879iBU2CFg4b1/BC/q5pB
adZztxMCHfi44iQlyXex7wDtMO/pSpPuIqzUwjiw3GORQGYMG5ue7Q9mc3CGGkRPZjk+5jhU
RoSuT3zs24RhpIyJdltjARC7iCqdjzsAX6Z+uXc9ZCAJf587ZNId4/MxE4u/Z2Mzb47ZtDHz
2t63XHTotz0Txfgx5VJktoa6uEg/nLNiKuDGSjsndE4627Kwk56l/dLdbie7RNWWTf4n246m
Oml6qi4u6fiOp3r6yfaK5v5TOPjsIICBa0s5SXTPVrbuCgff2ayQEmIbvAOD7UhURICVrZwi
FeCpuugzXwlhhyHx8c7xsDG/IvpwsC2sSD1rRwtPtQ8pnyEqZrvYDBE4ZAaEbaGK2WztU49W
DEy20Vy7RL8m0hFDPh4gQGRd9W1dYGnDrSmaeD8028NnD7HcL7iPVYFI2H9xDgtkW2N5zPym
O2+kwgMD91nZmMVPO+VgdCWzJcxG6POhr0bP/fsxLvdYESFK5bDVaYfQZrv6A/YtsCLnQDwi
X0C+G/r4jd2MmVzEE2GmZtSx8O2oK7GSMJZjdZhxwoJgamtstgwjOwiV3wGrwU9n3ik/Bba7
PRVyuM8FablRoLyPQjPnD4mHlIepj63tYCOB7ZezWHZKuDBM45GFxRc4H6ucYIVk/DEdRz6v
lHHEeZ6KId74rhimv2xJAkA4NjL2OcNBGpUzyGbwnGBLSgsEMgV5/AybYDjomgCcwAq2JiGH
2OhyxFnqcx8EsUPGGj8jDx1U4AseqqhLkACVQpzh7ggGNr45w0eGN2fQZd+hy0aZNK61uWz0
ifAGb3zKdEPHjYKtb8usOjj2vkwWjcksQBv6mvW3sVYm6lZzGVdlsPUdOLhARnIZunhiIeE2
ZgVg+r3EjvB00Y2+xHaxQkbY7CwxKViUeM8y+g05URJvZCSA77hYiBoF4SHDWjCQOjRJFLoB
0i/A8BykflWfiHuAvFMuZhZ+0rMpjTQiMMIQKQNjhJGFTuWtZ2wLpotdwhZ3gXwc+vG+je+z
arsP6iQZm+jmEsJhu7HbE96dljY8RP4Om5CN6kp2+aDU/KzLWrkTYPeVCgJr3X0GLwAyLNV9
E49tF6B2lYsK1DWj+4h9ne/LMTkcmm31KG26nWPF2AZ/SajqmnM75k3XIG2St67vYKKaMQKL
YERWgMrIvG063yPspRdQVwQRU+o2J5rjWwGy9+IKASF5BGvzBF7CusJaAl0zffdGFaZleUtW
iLVXdeIr8RwrvKEoCtCmYiNWOkx2AsfzPHzZjAI5sPrCaJyIoO+wgd/kpec6yAdNGYSB1yOy
qxkypqqg4vvB97oPthXF2MHEsiHpmzRNMHHKFmfP8jBVjnF8NwgRleOcpDvFt73McDDGkDaZ
jWXysWDVwqT8taT2CrK5rbEfMLdiiN2KDtn3mlewhdGWqFuemc+23kj/MjI2+xnZ/Qslezg5
QafA5GV6W7aVGdMz8SPXGZOx/aG3qU8xhGNbyILJGAFcZSClLrvEC0u84BNvtzlQOWjvYupp
1/dd6BNpl8Gmrs90Q9uJ0shGph0PS4rNR84IkWrGrAEiVMJXsfANgtBx3ZRxXOeGXh0i53z9
qUww5b4vG9vCZjPQkb7kdKTujO7hMhg42wUuG99GdedLHgdRgN2cLYjedmw020sfOZsHhNfI
DUP3aFYFGJGd4oydjR5kcZazJTU4AmlQTkekgqCDUIPXH0SeBVuTeuzqTcUEFV7NwAlPB4qT
oSzNjE6mK3G1QLFWwpgKwlhlPZgXmAxucADhkTuTl5VZe8yq5HG5Yh/5A8Gx7H61dLB2hj6T
a+X0bKZe25wHMh77NicUwBmaZsLl+bG+sMJmzXjNOyIAIfLFAY4gu1OMB55FPoCYTSIWOFZu
OkkU+r7yAhK8h/L/NoppFG/iJ81Z6vgl+TS7HNrsYWZtFiErQaXM0UO7GTO97Jmo3Ecmkit4
id/KkfGjstyE3Lub7NlmdhP0ULf5dtW7JovbbcS5ivJNxOwoaRuU3MiHA9g82672fd7eX+s6
3QSl9WxlRwAmp76baXCPVBhk7oD+Xup5YbT/7efzyx34pv76JL9F5cw4afK7vOpdzxoQzGIS
to1bI5RhWfF09m+vT58/vX5FM5kKD66PQtvebIHJPdI2RhiQ3UpnrLqbkI4YHlOFyVrxavXP
fz39YI3y4+fbn1+5P7qNyvf52NXJZm630xO2yU9ff/z57fetzMR7/83MqFTE1SqP38IK9Pvb
02aluA98Vi+eEy7mFjf529IQYC4TLGJ5RYu8Wao1KdnICsmSl//hz6cX1q/4cJ2yIzFrVstD
8W1p125LjmvcJ6e0Rn2fQxziuuvyvezxrZOd1QOkUx2/86+S/FRzEy/k65mrEyGumv7VWg8F
QhS2S/N6M4UZQHzPLyVbKB/4WyZKr4L0HCau/mB1nfUxWjhgGOOE++T87c9vn35+ef02x2Y0
LA7KQzrqJQEaZgenAERsy2OjXUCqiXRuSHg2mNkOtl/kLxLXd0DyJ3HvRKGFF7nf2UzTiVHf
mAIAjuXB/XZSl+bXwDwVCXqhCgjWyv7OUjd6nJ7u/NAur5iTUp4yN2jT6iGM3BQPjEDXn/us
tAmr5DxxqCtF3rfwvN3GDxQWPuFgYeETXmgWPmqRtHIdo627PCEcE0DPgyqhPwOUvuZX9s5m
rScIbn24AHy1nU2fmgsVL+zEtn2q+roDe6DBw8r7vbsjjjk5RCyB3C8dCTrGfXat2/tuPKJh
ivn4SGx3GLShNxFV/54yAxtojUM56uDsgZW23ZIE5eAwxajDrRUAcMoDz7F5/+uZM5bvD4Yf
v3lH0UMIFRhQ8ndAZfWgnrRB7N4cjRoHnE4OaA4lgEitBStAr5EfusDRWpe/CEzKOpV3PcBY
IlVJNG5ValkY0UeIgS5FZutLg6q9DlypPkqNAowqn38s1MgzqdHOMosAZuCmvAKTTOyGY+VG
xkd94BIOmWY2neR88ywnmn3kYSGx98lcZqmmu0BSnphJ9KofMk2At1l/1mvQJAefyRBaiLC+
HVDDTJ7i8vRPJvZeJL/+EbTJjlKmiZefeona+8jC7B84r/L7wDa6ocsSKtoOZ+deGAzouowd
0quA0rewsz/Ou3+M2Bg3xKiw6KSde8b7wbcsOhQOT6MvG7I+IgpXKwci5nTjaQlQe3CN7rpM
SvVdQgu55d2v8jGYb0e46eaUdlHiMSf42ImLMsYOFcFo17Z8RV0RhryE2aNgEg/CeUk4IMLu
g1e2aoaw0B39QZdWQ9YGLjUDJr7yOFpK2BiqnB4FNyqyQ12VSGwHyY1RsfVx4eGRHiYIE/Xy
nJ1fHGBzZubF55TwXcMQgeWZI1xK5FrYTujO6csjrnR91xiHfV7uszaN0adOHCDegBvfPZQD
4c+CC0/d1YRcENPkjuuH4qk/SjR15plhKDRc+5SfUvNGKX3bMsQJUIlpIdj6umWyKXnKmJ6+
xusH8ysNG10Thx5b+nn+SjNbS3owr4jCqxeh72P4klCfSuE0QVcmZ47qekH9huCwTdNQng9m
SSA+SdHwEAhbopuhOAaTfQICi4ONpH+gJcM1SfXYZ/JIW56RmkSs4+5PcRqDdR0tviEUyhjD
UpVRqwZ/rcIVRakhW/4AukGFh1BXS9sameZD5tx25Zk0OVoAxi5LjmtNnS4shZxtTuQSLkTy
beKKOORDxiRIXfTCYhdJ5JK3/TkuwJ69O5foe8EVDPcg/BpkgeOJMnX7qC0gGGZS3vEEQF/H
RcYKg1OWCL3aljCp76pascSr2A9MkZUg4sREGjkraxKcRVrbRPoTgk0keCq6nZE+OSSWdgKy
cqQzFZO3+G5BSjZJls0SGRJLZq3ix2BqOwBpwGqnBipHNotXOLZsTKBwHBvtGM5BvznEle/6
eBk4L4rQFNWngCtdbLtpzsV30fTyrti5FloMsGNzQjvG+21Z8Td7DhTlkBiTnIfbU8qgKHRw
Ma+CUNVEgwRoPQuhDhGFZMwgxJWiFbX5elKF+ajarWCMCCc6l3hTqcCiwMPPeTQUauqvYqKd
S5YGjgxuJiBOEHCWuiPUmCFm+KRhdhGRtnYeovM2KhWCPfHtXoocPPnp+E1V11V+KFs4q6xo
h4qfMmls1vE4r/E9Gy9LE0X+juIEqEgtm4dw56DSAs5obGI6N/sc3b5KiCTeeT6acHOIBmoJ
bg7nj5mNWhlLoAsTmAGVAjCJaAoainiwI6Gu+B3jiuBqXtuUuA8pDUeGLNNw524/Xvbn7QaW
bS77+pycuqTNsoqt6BCIEmv39VjJZC3HRyaLKf4ovfciixge4qBru/jauZfMCewAHTiMoz1k
knkPjo0+eJAx5YUStuz7IPRvrVCdUzYxYU+tojriCk1C+WUUEg6jJZTxVNqErKdtJq84sp0z
NdvEhmxf1+D46VZBOPbSZof9GXe/omOb6+00+W7vJopvc8dLWWK7LQnI2sEKCB2GMSMH3SRq
mLDCEwDjaztwt9cK7PxO5TrujVVYnMg5xIqFnfcRoB06iTjPdomVeD6du508a0syeeUYTuHN
p2lY1qbLDAS16UdV2mCCRedmJZbTHORrcQxz63OPmlbitOY9kr6I9/ke90zVkif3yXSovzYx
UKq6zw+57CKkzNI85jzYBtZtr36QnEJXfRQJVBGwOcaPL1fA0XbiLRTpvZsXJy67c3VkEhD3
z8oxhCNcwaNi5QLXcOWrNMfaFOuxicwYD3nRowcSM2yftpcxPvd1lxVZAimtURrmM5Wff3+X
neJNPRGX/OJf7wzBjau4qI9jf6EAaX7M+7jYQLQxuKEkmF3aUqzZuTfF566b5IaTPfyrVZaa
4tPr2zMWV/aSp1k94uFhp4aquZeDQh7M6WW/Hpsp+Sv5KPl/+/n2+vLy/Hb3+h0OvBRLMj0n
yAA/M6MS46mlX37/8vPp5a6/SJlIRWZ7hzFO44YNqe5XO1jzB+YU1XYs86pGT0Q5KINAql3G
46iynThEvasVT9mAOheZeTK31AEppTxmTTs70Tqgh07djp83itGT5BhKa+cSfKqIYLTdPGXA
2A3OIXn+Zvt1JTytiat6LNP+Itf44hXroBXmV7jNBTTNFnDOic0NHbbM6zL5F9iQ3cEAefr8
9F1198kLCdOOSQW9U/i8QXLl6R6+vD1fwS3iL3mWZXe2u/P+cRev6SspHfI2Y22wMUAVc0pB
evr26cvLy9Pb37qRrmDDIXFs1CcZUodtjUTU5alKSkbKZ5qcOFd8yorS//nj5+vXL//3GUbd
zz+/qQZsK551cdmolnEyt09jO3JwYx0VFjmywmMww4FksgzkJ0UadxfJT7cVZhb7YUB9yZnE
l2XvKOenOk/d3BpcwihBhWlvgCmYTThikmEPvY3HiJBBQ+JYyq2RwvOV14kqzyN55VCwD/1u
ixua65XgJp7H9E2X4MaDYwf+9rBD9WAZdkgsyyYGAOc5GzyiZFPWxJdlFPFn2BZR6/4c7yyL
KFKXO7YfUnXO+52NX+dLoDZyqKxZd7iW3R5w7kNppzartkdUjPP3rGKKX3BMisji5cczl8uH
N7Y+s09WEQc3XT9+Pn37/PT2+e6XH08/n19evvx8/sfdbxJUkbFdv7eY3k4sw4yrPosVxAvb
Zf2FEG0TGdg2h2qZAh2fgVx/YEMcNTLizChKO1e8IcRq/enp3y/Pd//njonqt+cfP9++PL1s
1D9th3sio1lGJk6aavXK9VnEC1ZFkUcc9698M9IZ4/2zI3tL1gQHx7P1NuZEdd/MM+tdIooY
cD8WrFdd7Jh+5e60Ovsn21PPkeZ+dyJMYszjx8LGj7PTkxdDBUveCNug9lFkEeEC5j60cDug
+XPF0Q8QL1lnD7JFIUdOwiK1jfoIlugc/Sue/qDXiomrAD/uXbs5QLrZDvWURO/T7QMjlZxJ
fcfWLq0ybGoZFYQ4QTEvENK2oY0O6P7uF3ICyuVrmJ4xGFV1Qr0MgugY4wNGJXo6NU1ubeYW
gae4qV3r4Rm9VA09DF56PvcucXQ6TyLXx253eMnyPbRzuddafyInBjkEMkpt9HIz+s4iR9dU
20j/Kj7sLJsqbpagq4AbIAOSadKOhZ9ULQDPRg8bgN/2hRO5WmaC6PxqSmGjHh9Tm63HsIGs
sVfTSxH45fMyXJNp3SAHKgiFSJ8soi0ddDw5Lib1wjnTuO9YnhXbvf9xF399fvvy6enbv+7Z
pv7p212/Tpx/JXw1Y7sgsmRsmDqWpc2huvVt5V5+Jtp6K+6T0vX1RaU4pr3r6olOVGPhm+jo
e3rBd5S7jWXiWtoiEJ8j33Ew2ij2wnoC6k3dpDoEqmMH8XyzS98vk3aOkSybUxE9p7iAdKxl
98xzU5f0//n/KkKfwKMQrSW4/uC5S9jC+XxDSvDu9dvL35PG+K+mKHRth5EoscAXMVZNJtHR
9Y2zdsuk6bJkPh6azsJ+3P32+iaUGbUyTAq7u+HxgzFsqv3JwZ/rLGxKMWXMxuwlTqVFMph7
eGgMi4Wrz2VB1KYybLpdfWp00bFAZgYjk+tv3O+ZMusaSg8TIEHg/0XXY3B8y8dOEif9uGUL
u2UkCxLepST8qW7PnRtrFe2SuncylXjKiqzKlgMPcZoFb5bffnv69Hz3S1b5luPY/5BPD423
fLMYtgw9sHGQnZCx4REvg19fX37c/XyFAfj88vr97tvzf6kZlZ7L8nE8ICep5oERT/z49vT9
jy+ffkiHuVNyl2M8xq20ck8Efux5bM7qkSe4C8ib88WlLjZSOWAM+2MscziF2ucYtdOoacME
5DAqvtIkOviDFqFS15EAXO7lucSv+VdAlxUHOM3DCz3elx0Mhka1TFw/Z2Uou37s66Yu6uPj
2GYH4rySfXLYQ/zWLS8NgCrqOB3Z9jmFs8HyGsvXQVO1E/mZC9D6XmvfSxuXa8FVJEo/ZuUI
71kxHjQCxYPvuhNEx8C4XXLivouXmIDP3z69foYj4be7P55fvrPfPv3x5bu6Y2XfMSjcYllE
UJ8Z0uWFHeDXcTOkGhp+1LeLUAmlo6ZobVLQPKrEQsNpy3ll0KtwSosEf2PDR3pcsJGedw0e
qZ23el1maSwXR85NRrZxmqmPYFYqt7FtelQTZaC4TNls1j8V1LHDL+okRJKjBwsrYMp90QiT
5u6X+M/PX16ZUG3eXllNfry+/YP98e23L7//+fYEFwWSUBMJjewzpR3elcqkP/z4/vL09132
7fcv355v5ZMmSEswKuvMBL/QlDBoYFwhJe6ztsqKOfnl6majaHLJqvp8yWKlkyYSxBeJk8cx
6YeNi5oZzMvyq4+SZ+85v7pmJrMkxTyAqxi2Lpz0FpwREGymyI8n/MJJiJk9NiUUzOVIBD3m
TCaoSKZ4xUuM1nNaGD1PrgnlMT4qjvf4bAP3L+mVjZQyRzjFJe30HB4GVFGFiuRtD4FM+cyU
6E3MhtGqGovx0zx9e34xxA+HjvG+Hx8ttskZrCDEnQdIYMg5azu2OBX4Kz0J25278aNlsaWv
9Bt/rHrX93foEdTyzb7OxlMO1p5OuEuRmnFEf7Et+3pmA6cIMAxTD8ak1NtS8KCVbxRc3Elt
ljMr8jQe71PX723ZkG1FHLJ8yKvxnpWU6T7OPtYObWTgI/iEOjyyHYfjpbkTxK6F7tmXb/Ii
77N79mOnGXEgkHznesQRMwaOIht/XyKhq6oumFaVfWDDhgjBZqIbK9x9TG6hP6T5WPSsJcrM
8omd5gKeHuv0neVbWB/c59Vxkhasr6xdmMqBfKQxkcUp1L/o71lKJ9f2gusNHCvbKbUjZ4fh
ZhOXIt0pcY+klBhzb7n+AzUqAHD0/JA40l1wFRj/FJHlRaeCuklYwfUlhvLzmUi8nUPRQRA6
6KkGBt5Z2hnpAirjqs+HsSzig+WH18y/VeC6yMtsGJmWBL9WZzajMC8r0gdt3kHootNY9/DU
ZxdjrV93KfxjU7N3/Cgcfbc3JK9Asv/jrq7yZLxcBts6WK5XUUehy0eEce5mwdv4Mc2ZRGvL
ILR3Nl4aCRQ5N+ZGW1f7emz3bCql2tbaGKdxX8WuC1e4tyTj9EG6Dz3Ubb4J7YLUDlJ0EqyQ
zD3Fzg1I4H6wBguVtQqqvFHZCUQ6I6G/SHH1DcNHUWwxpa/zfCc7WER3yvg4fmdz1geWIFXF
LL+vR8+9Xg429kpPQrINcTMWD2wKtHY3yFfGBqiz3PASpleyGjPMc3u7yFC/APLi2rOhyaRA
14chka8CcYlcZVC0Q0+BVnBdQZzAwXO8+L5B85wQfuDH94Tq0Kf12BdsQl27E2GqKoEbBk4t
J+qZONpukgnquWWfxWiLcERz1C8GV357Lh4nBSscrw/DcVtaX/Iur6t6AEmyE3eQSKrXPM3A
6WE3XiF47nYlmGhuMjZAh6axfD9xQuX8SlNE5c/3bZ4eM6zWC0fRZdcjtv3bl8+/m7vqJK26
jbkKNaqrbMyTKlCvBjiTDSp4igsnC64x9JK27ka24sbVEAaEAwh+/jIpHYxU8Th65DkOWxCZ
QC/6aGc7ez27lb0L0KBWJug8GPtTptqxf0Fgo06CeRJMJ2ZlTfUjoxK2jnwAdH3aDPDU6ZiN
+8i3Lu54uBrbuGuxHM8ROcEhStNXrhcYKwKcRYxNFwWOsRIsLM8Y/10OoiBnX1Hyk3F3luzz
ZyY6rqcTQe9fh52SUX/KK/C4mQQuay6baepk7/d1d8r3sXC+EAborawJ84wcVT7+VgQBokYI
Bkx2hM+5TFc5NJ4pYcCVZBX4rE8j9NBchQRmqk1qO50SZ5XvnbnFM5PfbC4FrrfBDZUHwQo3
bTY+CxwtUTjFi9NL6NvGSiaxNhx46MgEdQCwyKDylDaR72lNorDGD6Fj64e32AnBRBzj014U
0DhrngC505k1QHDifNgQ0KZ01apfHTOmDtPnKy59oHlJsBda/OCFKaCX/KJWeSKiHo9BOA3d
AX88wUdCmzRH7DSKLzk108kN2Z637bkbHzLCcw9gjqXtnN0NUQMCJG0V/QEe5AHzNESuH2L7
+hkB229HdcEls7RtPILw5Ok3M8qcKSHuQ48l22ZN3OABmycE0658LFXQulzfuPFoCtKeDaTB
JXM2dk9ss0cfD4gYh+OR8ATCa5qk9JlUn6cddbR3PKd6RcSp6a29ZlaJKO7jwzlv75d778Pb
09fnu3//+dtvz2936XL2P6Vw2I9JmUJMu7VZGY0/4XmUSdLv0y0Pv/NRvkrl0Mfsbx59/JJ1
yEsTyPcA1uRF0YqnKyojqZtHlkdsMFi3HLN9kaufdI8dnhYw0LSAgad1qNssP1ZjVqW5GmSE
V6k/TRy0dwHCfpiIlc/y69nKviSv1aKWwwlBo2YHtn1no032wADgyzEu8r3a4POZtUKF+O/T
bZeaNJybQvXZPDqiw+WPp7fP/316e8YeZkB/cCmF17IpHa3pGIX10aEGhXTSRakmTIqmC20b
n118EGCXY/Dh4z5rHcVYTqZOI1ROislmshQ1f5KD5xQzZY/1X68ll5ddT1brDHOBYh6JsFzQ
cpcWN6BgvJptdOASm+iGzk5nH55KrcFbLf6FcDWtSgNOUn1BrWRxTaOmP7G271AYrs0v2OYQ
GjL01E4sY9YZA0Jii0pRMD3gXGqFmNmPXZ8/nLEz9BV0xBLWXDJJScYX9AgNajTfbeoko/km
sjxnlaYRbMrJEe/ER9uJjJ4FIt7yCsr8bkxo9Hg0h9Dj7f7t8CNj4MQXJnyJQZurcor9Pbra
nOY01bsPo15yYjhVWc2Efa735/1ji+mmjOOmB3WwAWGMkyQrTLLetZe6TmvVKRJQe7YzxLYt
IIrZPi+rVLkdt/fK303pqmItbkt94Z5oTDOImdJ6UTVVhZmcu77G7yZZOteSbaxxOzAoyRDb
AX7iAN/ahF4F3XZiy9GerTuj7ilbRvUlsenhQwrb5wCj7JKz1mnaPSnIlT1TsYbe8+kyYjHn
ZX4aR6j5GB9/3JuYLjUyOB6sS0oE7dm4GDTRJmj8SeNRU6tmnime9m0dp90py4iJ3HVgiBtq
X3VlSDxLgPWljBucWZYNP1tSmdMWDtU6RbiMp0//efny+x8/7/7nDixOpke7hkUX3LMkRdx1
8EA3lyPPAKfwDpbleE4vH8JzRtmxHcbxoFrEck5/cX3rATucBbbY8AxqanyrI1sYA7FPa8cr
VdrleHQ814k9lTw/5dTLEpedG+wOR8JeaKqIb9n3BzQKGwDEHk7Nr4b36I4vLd+LiCYac+Xf
96njK6eMK094/EQKskKaa4mlirhyXpnc88CV7VI3U16cFSMpCN8Jm5+vgQCQ7xkzilA3GBpG
NsBdWZJfbSxx4TsP7WKlbQPXwtYtDbPDSlA0ke8T+bOtYVqjHghWjOmyZeWpXt+kPC+sPcOi
wXj7NLBld95Sa7TJkFQVxpq8URJjL0tREXNDkMy5sG0SRBuThjx/9o9viqazrnUi1scazdyw
RJ1T6OpzJUeTgz9HeCpvxOtQOGPDtq5FnJdIZ3VKghU4BC8NwpgVJmrMs2TnRyo9LeOsOoIe
YKRzuqZZo5La+FoyXV4lfmCdY1LGvGrO/ShsWyUeqyPYkKrEMh+yFlhmoSkik6ZnVm411PDE
pt298iqT7g0U2Ox4g63/Y0zcyALuAt7cO+izvOoxg0Kep74tWojz92T6SV+MTHXLU8rsVmrx
D5M7BjS7LmP7nipBD9V4JzRnz7LHcywfzfByLp4HZCKYa+tZxEWNehDlyfdNrI2Fsu+0GMe8
mG0eF+PZDnz0ef1aVG1csM4q48oZjBSZ2iSnwxWPU/pPboMpBzpaaMosSGOYjnFR1GAl+TH7
NfC0Am8MjnOHRo2uuHl0ds1l82iZOorDHHW4sKWaSKwe1DsvoP0/xq6tuXEbWf8V1T4lD1sr
kqIuOZUHiKQkxLwNAcrUvKicGWXiWo+dY3tqN/9+0QBJ4dKgXJXKWP01cW00bo1uyjw7vjGf
Sh0MauRttq2cfMcygaeX+dwTyVxn5IQlBN9NGHxFxbGD8IFnZ0VA7Id3gm7rZE9UiVkfiDQ2
hMGa0HTARmy11hPPpJNXF36Q1SndIfBo+osAyWfwNLdcxGJJlBycYSTDBwlebxMO4eEgPVE4
vxITeHLal62fRSS1jOQGgp3vD5TxfEJ3ZvUGeK2iGTpNiF0pT4SdRtMw1QXqndJLMlPm0PA6
afd6ubx9eXi6zJK6HZ/N929Yrqy9Uxbkk180Hyh9A+wYmHw2iaNpeowR/wAev2/FYsAv+mNS
6P2ywYFLC0CZKAiOiOlqR3PPV33VEKhLjo2v0qJC4YFji2Wdq6kLtncThycz0CJt52idwpGO
a6i9qZ7WswBRPNBlGMx7ITKy+O3zYrWY3xT9MVilX1hVVdD67WUhaOnHqpbjIFgF5Dlcw/g4
pAx4E1eoP3kxRMH2oZKu2ZsSgscSRACU43am3vfk2THLMVFQXHdZVmzRtxwmH6asrqgMDLuD
u6c0P4H1x/4sVlroYfTwIcTx3PLkyMZ3NgSkpF9HSzkh359evj1+mf319PAufn837h3kYkC5
hqP45ajG0e1F6dLUr92ufLz6IJ/QCp6o8jaf6NAPMKqNQEIa/LLaYgZJ+WC6wPqhotapf+bu
nex1Hy+mdMjHKyJteD7GC9suPq1qFT/fzO1gdMMbm9tCZBWgY5Pzbd1BVPZJFigXHGFMMgzR
eieZeotKZ8161Z961ZrL8+Xt4Q1QZ2jI1A4LocqnZzh45THN8PmGRveWCClQtRtV0nQ71BPi
JRm4u7BnvHj88vpyebp8eX99eYZdufLLCH33oJcVbSzpIfbWgkBx3Vp39WnBwGs6vPk+Xlal
G5+e/vP4/Hx5dRveqYyMqDk96lRw6Q/z9DZMU6zx/OO8CzrdgpJDth4+xCfawu0Lx/mmak9H
dN3Qw/2w8gQ6ToWkaN//gslUSo60TCjYiUzKy8BXJB/lPCZ241iMcF4vNj50WmtJriLZ3si1
Z7PmB09D/v7y8Pr1bfafx/c//Y2KZhFNetw1CgMzxSSXtGE7Z8cCF6GPdr+bMObu12LpaE7L
Dt869pi0hgMTk4Jwrr8+tvg8e4aO7+o9wXOQxoDqcGJYWamBjhhvjBvTPFejd1qvkWSzcrWG
szkm7bnlNEc3zqQNolXoR8w7VAc1gnMZ6Mo+FboinRdZBtiadsA8gV8dNm+hVvO5p6qrIFj7
kfPhfgLEW+huEczdE7UeQd0GagyLeO35NI4x+0iNYRlEnk+XC8zK+MoQR7oRn0aP7aNqJaJJ
vAzRvLZp6LlRHzn4mSUV9m1ih/B0OVgU5x7vziYPbuRg8ky1puKI3borAGmshC3CfBGiFQMo
viXDigsRUgUsvSmjsVF0Dt2QXacv0fotQv1izaCjQ1QhH6jcahieaBJdt/bGLtP4ogB9WKZz
LBAdI+kbPO84ym/Mc0kXzn3Bh8ZZTh2I3FjI9YxhvP0g5/KjSa4QRmfFImbiyG2cVIVotqjK
DNx89TFgGVsFmFQJeog1f8bWUYAMGqCHiIZRdFy99phHlPa8WHpicFzPScrq3NxFuGfHgWsM
ayXUlVuIgnSb9XyNFF0iUbwiHiieI+0mEd0fsAFsQh8SrZDuHBC8+UaUpcjMptANogBUEedY
mxesWG+CJYRavLnlsNh7v/UT/VAnRbBco5oHoNV6c0P1SK5N59aoB2yjHRvGg3TqXOulcwKr
QR8oHnChKxcBRvMl0hs9MFF2Cd8suxiVa0RSBwQXoRH1jEGBQ0TWiQsixRL+F00bAG/GEkTb
SoxoVJc0uViQoPLTcDGZrGEgTJQUmISwqtGCJBEvgyk1AgwRohHlxRPSsepCCqfH6AQGyDq8
WQvDVahBxjWBgAK03II88YWAEuLH0ZoJ8sQXeoru8U56fy6q5K69cZi357nHXcTIQvcFSRly
VTgguEyOaJOJP9DP5bNBIv5vxWCxOJCLHInapy82zorQ8japQ/HkhgM4ltjOqAd8Q3yAp3Wb
4FrEpvPTEeIkCqcuvoAhRkSWwWtC4txHAcQJC+N4aqcjOZZIdQFYIWYQA7SaEh3BAUHU0VTj
VYBMPRII0clUQGK3NrU34WIdtwg2SKo7slmvfMAGlS6eH6NwTmgSRjeX3zrv9MwyckZBh1V/
hBFDEYfhhpCZvOjUcGWZboPo1mStc07llCZdsMC7l0UkDFc+GxLFovZD+OcCmzwHaFMSRNja
XAbCxra0sA4rtgdEt8lP1kgH9gCutcFQPUBGLtBDZL0q6ViBBX2Np4NOTUDHFgBAx6ZgSUeV
EyDoa0qdIUb7VyJTG3JgWHk/9QSY1VnWUwpOMKyxDYai4zNYj6HyDNHK5nifbTz5bLD1qqSj
hyOArPDH8gYL/rZBZ1ljLmtHBkbWa0wVf84jO16ovuVZxZhv3ZGDL6MYXVtKZLrMggUPujsw
lKRdWw9qdCheTJ9aAM/a48bJ4AmnJEpx4Fq6JkuxgibTB3J5DUbuov3BcAF922NyHntGLEfF
0XQfTIp3WlKDq1zjAN74Ti3D4D4dPTS/wiagLhD2DakPCKoc8f3aH/8faOq+qzjoj3bFj/NW
3kScxFqnyco9N6w9BN4QbKnfOsn0RndD3uyvyxdwfg1lcDwNAz9ZgGssMw2SJK10UmWTG3O1
OhLPO2yxKuFahXKySbRxEmIeUzkJtmAI6sljm+V3ukmPovGqFsWyqHS/zUpFNtJPDuCby5N+
cqDi18lMKqkaRmhjE9s9sWhCGEmen+wc66ZK6V12wmx0ZFIyFI6VvGgETsFGfzuP9Y2kBE91
kzFm5yMEZ1+V4ALN27hZwfwdmOXEaloIclgVdj5Zjg1NiXwW1bSFtNjSxpbcne7tWVLyqqGV
7r8ZqIcq55lm965+O319pEeSp9Qu554v1xFucgGwKKqUfD/DCVvGAdIm4GcksTO8JzlHTbNV
IbN76UvOKeapcazODQaakNRXEsozO73fyBZ9gQIYv6flwe7lu6xkVOihyqLnSV3dZ5aM51lq
E8rqWNmFgPYBbeOtlHwbWoge99WsEI3Z2EUqyGmXE2ZpqyZTom8XoqDgsana4bZbkqMC877M
pw6KNucUUY8ld4St5A3FXg0DVjWmFINOICU4NhFSb/ie0Mj+cVpnpWg48yG8onOSn0ps1y1h
odryxOq9nmi4m9DpiH8DHVbpmaUYoCz1KbxaKBrpvi2xxjt4zWLKp8YV0IiIOq8b8BfryaiB
Z6CpM0KaKkmIXyiEshf95Umytxuzk2RZMfWRMadIZ3O2DpP+TXJaWnLCeEYKh5Tl8IAjc2YA
UbI6R/1DyGrrXoWk5gG/lITpc89IQpqaFaThv1WniSzElFWZeQiFyLLMkRLwp7XHnl4psGkZ
LwjjplN9nW4NDyPxFpZQ55ph+zSJh7vPWePorHtiWRbqGKVFxa3lTUfFQDRJkC60j572QJsq
8udTCitZ/yTAhJKumvOhxd66yHVTXlujqUjqMOzDgwzGcMgaUS4e4Q0NuniFOLDOyrOmRof2
PFZY3zFTO+3R1T+aIRjVSKWpDZAr7byvxGKq0+tkp2R/1D8DVLk+v1+eZvDS3Mz7mhjKoOyv
inTGdgpgrkEgvDgRMGSJG0Jhn4+vopDyQ6tWh4T63NdoEXpNogq4a9KENgaPB3uT2uY1NaNm
qO/L0nqJCmTSJKJ2hJ0P+iQiEFsUrKdgBkbKUkxdSXYus/v+ZbQbHrd4fPtyeXp6eL68/HiT
4uPEB4a0eof0Z3hQSpnVCDuRPi0pl3OAUpX6p8bzRBOr+N6ukSDJVXyb8JwyfOYY+FLKyBa6
q+sfDlhD1vlgxzCl03cak722F/pOENyulqHIWzF3lPDyR0yUv4Y6rMTgOsBf3t4hisAQjya1
d4my95erbj53OvncgSjiVHCZIHaymTq3d1DkRf41QdGc/uaRLIX54BNhOGZb/F3CyOK1vQaO
bZMUVik0NEPrLakNeNsS3XvmHEE5ByEf4pvY6I7ldoMMOZ3LOilWHW6PYjDCngmfMgw2IR8T
1b+ycf+4HZkI3+DmFyOXx43HiLthFlye4ujFk5KBeyXJd6PLdNHTB13XhsH8ULu9SlkdBMuu
B4xsAYqWIUCeXHdiMMNrKidVsT6NFmHgAtVVtEyt8LGOqz7ScVemKAkXaCBngy2v4aKl8xZp
sv9HLmljfJutt7G+VSbmzjHVDUmrPiBpgyRVfkmqEEky0miDaEomWL4OAqyLR0AIFnaacuVJ
LJ3arCEs2mblipOnqYAso9GDAwZnroV5QXmLmSVPD29v7tGhnNIb+Q7OzO8+tQYWL8bDyFIs
ln+ZyVrwqgG/U18vf0E8shk8MU0Ynf3+4322ze9gEXBm6ez7w9/DC4CHp7eX2e+X2fPl8vXy
9f9EWS9GSofL01/Skvz7y+tl9vj8x4tZ2J7PWikpovtqXwfh5BHfxRlJEE52ZIunvxMbKHVm
hoCUpUZYGB0TfxOOQyxNGz1IpI3Fsa9Cv7VFzQ4V9kJdZyM5aVOCZ1CVmXUCoqN3pCk8H/an
lEJjkMTTWGLNcG63yzC22qQlozNNkE/6/eHb4/M3LY6Wrl3TZG16xJdUOPrxdiWtHecginrs
x7tPZwiWQ+VfAArY5z1OKhzw/XtdspvKSGB+jVnwFtvMSkiO8VR/nnwlV3JZLBuy7l/lzfZP
Py6z/OHvy6u+fRm/SVntV5mSo+0sV15q0S41SUHEqPx60VOW34jdhJCkHDtok5neJ5FZfqDI
/QlC9ldLrWi17Zn9aWXY8IxkNVMgABzb86rMEOj6nhIBxU5VXSghmL1VkcRPjtKQZFp068It
cehSjFbZP3z9dnn/V/rj4emfYrF/kZ0ye738/4/H14vaUimW8WXOu1S5l2cItPvVabhw1Js2
vfesYouzxHgDHlMKylgGZ2CeuIdmFrCbo2KLj5lpyHFyoDVNM6vNB+rQCObQGsCC4Q9HDSbL
0ynO1F+93WZ03sRZS8rV0lJ9PRFfm0pA1FDsPPJM15CyC9GZu2VMWSKNvObuGv0oK+jSEjFB
CpcmiaQtb52VIsuOLPNpwDzbV9y8VJBkd4E0zB7JaZUsfbovOUnv4FZDpfJawToO4Cm1Lrhk
FeCCsg/XcEUk9VzsxC6NMA7RQ53VBBW77u1xT+xi576VoBgLZZId6bYhYvKzSlzdk0ZIvUWG
RZu9c2QZV4u5He1422S2jMBR/e7epJ4EX2cl9Fk2Shfa5YfdrPg3jIPOtyE+MJrAH1E8t3T2
gCyW5vso2TC0vDuLVs6asyeYqho3pGLqDnH8GrbnahFKy8J8QTTKdP3n32+PXx6e1LzmWcMe
jGTLqpbkLsko5qEQMDgEOx+NAzJODscKQONgeiCq0bk9DWdTEyM/MgPqqA4XygLK6dUrMCGi
YP9ExPlWO4L1tJGZwZ6k+wxf3/BTjT4/kZsSoY/O7J5yfZ1YFNqapL5vWPZJqBGEaM+Ugue8
zSvd49lIGo7s1toCo0gcmTLApDnVvHJXLEXyL5aK/2h1+2gM0rHmQCCxVKwYEZIY09J1LWPq
fNEoj+Ko0V2nhud8V2BJi7UFaQjTdZkJyrskPNMRnm6xK7Nvu29wZfDXZGUEk5jjC3ZIvOVi
NWk6zMbrygUX4aXpr0oD1Xb+RmllUb2T/JUvrY64GcWVxZnbER7Ldy4mBh054gt/k8fnEnbM
yXtWdOXZJhA0uMQWJFemHfxrxoy7ggXNtxnxeEPRpL9uPF48gGfwcHKDAbwcWXLl4/I4L5Zc
VUeaW+WdGArqETy+dNXaxbO0lLqJ7go44vDh/lMwmb5poS9JqENmVRixKq0O6tAIFRKPtw9Z
Tp8P6P57fOYBcOKlvtS/21XgyNORwqsP8ZfnI930WP3GNKKgbvM221HDGWeP2Lu6nnyg0Wqz
To7GUUyP3UV2OSFfz4WWbJcD/ONxESHr2W4jj+dr2XRsQsJbaPWlmFyxY1tg6A+s7PWILFhb
dj6ZSj45s9aBfTIJQ7yoOnHkr3eM50m84HfYxNRlZYXPWMaW/EonxTJe2FlX95hpYJEVjFO5
Xrhy9zT3REZN/pfvL69/s/fHL/92l4vjt23JyA7OBVlbmNOOGEmVWpFg5WHj+sXJ7PZKY8hc
6o2CoZX6TR5wledo7dGiA2MTbzwzx8hxlSGkKnBPC/eQ1x6St5LStbVesiv1LC200Dw1Jmla
lVQ5GhxP8m0b2MyUsAk83MPOoNxnowczcFHsdJv8THMQrZNJGc3DeEOcMpOGooE5FHgfzvUn
1apg4MzRDANxpcfYcyxVb/B/YDdjM58HiyBYWPQsD+JwHhlhVSQg3YKjxNApj+tC3MFxxxEj
ugk7J1V5j+RZZqk6VVshUOdPrSe8is7UkE++/EVrbbBa9XS5N/OnP43mdbRZYK9sRjRGmrOO
52gUggGNu86xvRixMMASjFFfGiOqH8L0xHU8x1LyuFS/tljs9mRPv9FWwLWMvPVW7uDhOR9v
bSUBmPmMRpJTkgThgs3XeLQLles9ZhQhoSbbt7l5iKKGXxqu506D8Sje2AP46p9epxZJEK3W
Nm/J7CTLjHdb3ZJGmWkkZBmbgR4UPU/iTeCXm4J0q9UyxoZ0/F8ntYrjgZ9VUlm5C4OtvsGW
dMqiYJdHwcYVgR4KzfJZGlb5mnp6fP73T8HP8iih2W9nvZP4H89f4cDdtSub/XS18/vZ0tFb
OA0qXNVygjBV3urlneh6q27gDtMiMbBpOum2eqojqGjU1jNAQdet7A9qtgzmyLihtcefiEpr
77ru2j09vP05e3j+OuMvr1/+tGavsbn56+O3b+6M1lsAudPtYBrkd8VusFViLsXvAg22lLI7
b1YHscnkYgd4MxXEcNjAk7r1ICTh9Ej5yQObhmlmyXuDsKvV0+Nf73Ch8TZ7V017ldjy8v7H
49O7+OvLy/Mfj99mP0EPvD+8fru8/6xfX5kt3ZCSQdy/W9VPiOgS4ilnTaxnAAYq9ItlSYmn
AW+IbEEe29COEarOouiW5qJlUVFpeKKWZiiaFsRnrSegbbtzTfTYqUwgRKDuff1eUrVTY/Wx
XlJFEdv2Y9YHRfQVCNh81609zLJ8Bwdd2szUI0KQa4bkK3TQjsnpDA0XqX0MrDxTWmwIo2o2
xXif0HbOHQPcKpjW+OlisVrPHQXV068E8E9MWELp2fyeB8u7yIzNozutq0kjQy3UEL1SJ0Mw
yx78dW6Rm0p2YGyS1Voczl+YYWehUBmDcsD+8Y9rC/dVFtr/XHlMoXUWbCLQcOsdiFWt1hR/
8fOcoG4WAKnT5ghXerT5ZKQgujsrUIDoXpOAIKahpGKRSZShpMZHekZhYBGBn/LDd02LBisF
rNgt9cfUspQ7reLHHVxZiALvUpNosZQVFYLWWtRaPxYYKGLjrW9cRjItuTE5KqA3lEKKL/HC
CFYiyinmavmYsyClEBjD3h/eVg6BMbD0hqeXxm9YBrV2KqrEaIP38DGtsWPRHt1CaAp9VPZ0
GX/FLUGBFasAGVSRXwfLZ4dJKJAzEzKeCRFvdzt9bQMFNH/BvYlLAdFCqPZ9St7FVpIjyUpB
XmnRiudbm9ioKKY6zWbpO8OgIcmDRZhNOzKjxD3RbAVJg0derDeP7yP3jgcv4Pr37eWP99nh
778ur/88zr79uLy9Y5b/t1iHPPdNdtqaDzx60jlj2G5aKPTMfJyoKN65a4TVakbOSvRzdr7b
/hrOF+sJNrGZ0DnnFmtBWeIGmunBbaUHPeqJ5hV0TxwmC7dGjB3PaYn76ulZKCMTQ3rIAS5g
POVch3Fs6qkeIKn43z3hySGt9jhKIOFgHoVTcKwfuiCw7ugOgU0vMy7DEt0LOnzhdCnDcLKU
URBOwrHuwtWFrfC1I0MODb8M57jjA5Nt1aGHBibTOlgukIJIbBMEWCEHbI1gR8AC67LBRtH4
7Q5T5E8+xIrcY0us2Y9KoM0lyYAWdZ4AJjrUcyVscNZJGC1x+R/wZWQf2lscNEQdEDlckVsZ
8YtniVYfSxkRNl+jpUu5eZo5kE+lvGII5rojoR7cC3V1qFHdKZZB3UQdaFKrE2akhJ+2FWnS
ECvNb02EFv4ug/f+pgX00CDyvVP6P8qeZLtxXcdfyfK9xeurWfJSlmRbFclWRNnxrY1POvFN
+XRi52Q4p6q/vgmSsgkKlNObqhgAB3EAQRBDysh9f8bau6pIdPNbhKnzdMgEexRRqi4C6tNq
sFu+G4CX5S4K9fiTOpyYEoAb2Rc1TGxJXHUhqdJpk42v86Xg/9TqkpiawLRdHhIcj0XekFnX
pa4bulTN5S8ung1PO5EMy3ocZZCdlrkRstNHuwG/xV7a49Oxg/B82cjiUGTAHgJrRXJMLQHF
L2RC/hwlulun4LMPTTaj3RImm5YBybtJ4g6PrqUoFRna60t9+XrktJB4MMYb1CtRIkrfALep
bxOKr3ARYsjCQa6ghQ02rPlW/i8TyFnZNL0gLGuPArerdYdkbE0sG468gO6KbYqtqRBWVYpd
x1mXzsslHdV1NDVztmh55ec7n8VIoqiqdLnaklfDM9Wq4mt4u3Jj6ll5AdlKs0r3jVcQSBvI
5VH8ufVqiakvMPVe0d8PspfT+f1X5rDh3Wv3/+zf98fH/c3T/uPwfERx/MuMNF6EqlmTKMmj
j0X0vdq18eS1LFhO+ztW9S2X6X3LFaP/PvmekETkx0PEqyAJjR3YYxdlFIZWBt5TscySDwLR
kOEDdYoyRIG8DVRoRbnmMavhyCc9TBKbomGPm9ZuktBqfY0qy7MitqSQNsgmHrWSdSIGMsgu
ayw9gtRws6rY2lJfGqS2fDoa2byoy+VVKmkfeHWKvbphLm0bqFe2LeH/eUG7qQLJ3aot76zY
irmOl3AZsarykmZRWnNbULddIzqH/h6fH5lem6pgtV3aJLqeZJPZdlldN57Uz1/r5zSP3cTy
0q5PfrktcqFesg5iKjLWWs5+aCktb9Nq11mmEyiy2oPwv/nGcrtXNIZZkInfQRbMqwS7OZdD
RqlMI8YBwUg+zp5k0dKGMT1+aUnVc8GPl2f0kxygW77HphCG7PrWXpScGUbZxmZDZpJOvkMV
Tiyjh8iM6IU2Kku6dUzVG9xdJ408j6ZqC3B+WJS2NGvdenqtCo3mO183XYHvFy3UbOG1jD6o
oajw26IlnTPazhKl19c4GrFMFdzkeX88PIp0SlQKIi7iFcuS93u+VuksyBZMMi+kAzSYdJbx
NMksy8Uks5zFOtnWdSwLClMlluf6nqrL1sO5PMeDIcaUXCy9pyDZFAS1FsYNZkO0FFrvnw4P
3f5/oFl9BvVjpPNiSyIMg8q1sCmdKoojC9/GVPFV9gJUk/g6VRx53+gXp/pGi4lrO3UwVfSN
fiVuTJvMGVTJt6gstpeYKnQjcu2NLwtt5VzP5Ipq/G7OzprfC1v+b+a7/o7fKelEkrrE1GfN
vUZoTeF5nnW7JKICzVyVT4f5PS/HgAyFoZGPkHnfIgv8a2TyAjIrLW4lgq/LbMKrDFLO0W01
bW5pSG8GTL+1C1QP4n+tMj0d/QXTgJMd/zMiy/XYZBQ7wakEZIsZHZlHm6kOVOTW1VXdkt4F
+I4wr4HVk3iV3W9zvR8//17eWQ7dxT2/hC1NY29tB7LT1zvc6E2LZGGZhUKZSUjTrqbInrzP
NW835erF3hGSPmXlCEU5l0bXYzT3u7SZjhDMuq5uHb5/7CTltgm4HG8nEL470QjB6r4awbb5
2DjItKaj+LDcLZidQnpi2vEbzrWdsQFQIZxGKJQv267rshGqlNUTLxpriS9d1ma7fApRGcRe
tKz0qmH8Bjc6KVs29kl8D7TF2KQvxbB1fHWlzfUeXzktJBFnDr5nZahAITMAV1ZpGWjqhnyZ
T1s19EgbeoHuomBa0p5haVurrcyaxKHj23OaTVwLM7Eyo78h7Wows7I1IrAW37T+8+U5ZxpM
XzYraJG6emyngTZj1zZjcw8p5Ef2E5xKV+f7B4RcsX4rW6jxzOorBHW3pqUqJRns+K3NkiC8
r6Kz7JHiPKmWiFrqU+DhI+3KynqUi/W9pc/wBb+P8A1dt/Qr+hltSoUY39BfILtfglPk32yX
daMzwjoI92VZehmfKXeUx53vT1cpeF9sUXN6Ehte+DlBOA1YOXw/jkjKxiF8tmtKy2q6Qk+W
MD41h5Et9s8Uu3pBjzGEPOLnjw/8vb3ne8taVZ+J3k4Brlf8pLHipaJiDA/KjgEef3pvxnP5
xFWVtjPg5jIPhqAi6wdJHYxCwOqdXikglzR5Zu+iSuTeZBY/R85asjq/G6kAxFJ+D5lbCYD/
WIuLTzCb7xcC2EDyfzfaE5+EpXrkIQm6RG6SMXb2x/07vzoJ5E3z8LwXtuZUbNi+mV0z70Rw
UHE0MHItX6sW90nYkM3Q+dUjVHDUlLFu0a7W8wXx/avZrjcDvZwH4PAsWx9d03YSlaR+hMCf
8NtXdn+NZLQjsHBGysOaGKDFpLT719Pn/u399DgU2NsCwjyD97o+JBfoLhtEOTYY2aZZ88PU
6v7eidcxcuaJfsn+vr1+PBNdbfiWuKxR8VMYSKOeC+iSeq2QKLE75jjwuIkBwLBSabJKfwnq
cV8tW62X+X15icbMGfbx6f7wvlcRCHHC9J56oC2QZfkA/4v9+fjcv96sjjfZr8Pbv28+wA3p
H7558qH2Ey4UTb3L+fIul0Mvhl4Rwk5k+nYZayBLlxuL6kERgP6iSNm6tQSPUJEPgO+Wy5nF
3b4nortr0BXF9+hqS6N9eGri++XAyOdAy7ioYCLweM+FDfoOr9Gw5WpFS+qKqPHSqxWNfsaw
t7pQM3HFiWeG6DbxbNYOFsj0/fTw9Hh6tY1Ef4MXOTNolrTKpI+w5QlM4IexiPFJW9MSENk7
GYlz2/w1e9/vPx4f+Clyd3ov72yfcLcus2xXLOflksrKkTdpCtqwJZPRx86NX2tCumL9V721
NQzy2LzJNt61pSwmD14/yEEYNCGfRbZN8Pu3tWmpqbir56OajGVTkE0SlYvaCxFI76Y6fO5l
l6ZfhxfwOzuzKKIvVdkVYpcKM8t2VVXmSlKtfr92FX7gojcmmZsSwawnFj/zUov4J07h5axN
sxmtbAWCBmKt37cpvfXVmcj+trCvM/oqo+vgeX1QT2/gT42CGIa7r4cXvnesW1sKweBkYFMQ
CgrQJaYQiJ3evvI85TLCzpKgSRKwKX31FNiqskjRAsvPZdpOS2BZnQOFneA+WzJm577qKkCv
SHII8b4dU9yfhcp5SzuGaVKnXAHjVN9gI6MPBJD9DnRZ/Gq1WVWdCGe7WjeD/WjS+6P0OjXS
lYuIqsTJJBbh9vByOA75lxp4CnvO9vEtGanvFoxZsZm1xV0vn6mfN/MTJzyedOFToXbz1abP
nLda5gWs/4scqRM1RQuX6lSG76II4Nxk6caCBkdv1qTW0vyaU24Ks+eEHAiaOxkYCDJf9JVY
lXxwNH2HTmqMx6gu47srNrQLcbHtsovzcvH78/F07KNzD+LESOJdyu/eP1LdU0ohZiydBAmy
d1MYM+ADxtbp1g3COCYKQiR7P6Ts2i4EcRzpARd0RBIMEU23DN2Q6qVkWvzoEH5L9jbbLpnE
fjqomdVhqMeDUOA+riOF4PsSAlvqluQ1v/q1KHCk0srmbVrbdGdAUFj4uJLwuDQ1o4+Baefu
Ki5ndTQbhueyorYEnOJIK07c6+eNpdPw5AiepPbyIs0GLOGpxbAKVM2g410W3S6j6wCSckb3
QFp97JaFpYdCDrDYnuZpwoW0PG9to9brhtvGFqtLqqlmdeZZp67XtZMxyyQD0INv9CdIMQD6
FND1AgW9TKeowRXUlPZKX8UluKkaPqMX2E4Pwa6Bc91sHsPlPQBpli54iMjELwLrmjzhgPB2
Vs4EOa5fRSggHFwBK/+cMbLMgFQ0z+BoOZN4OgnrUwzhkhxM1njpmuDPPRtOHx/3L/v30+v+
E/HfNC+ZG3m6J10PmuigbeUH4QCAczX3QJSkWQBjbwAgqVR9Fy5Sp67FhoqjPNIJjiMC3XVI
/sY9VTDUhWmdcRYuYkxUNNSsQ8MY8Q2ndekkicRZtrpn+a489S0GyXw1t7nFbFviqCzQAqNn
Op9tKwZ5rtMZBcPfqMHRWN1uWT4xfhIUuLLbbfbj1kWRyOrMR/55/OoRB7oHiwLginogahCA
UYTrSoLQQ4BJGLo7lTQBQ02A3sltxhdLiACRh9NVsCz1HTKoEWB8nNqBdbeJbzFoA9w0DY21
0euF8CaWG/v48HJ6hsj3T4fnw+fDC4SC4TKWuc13wrsI8mt1KHxcmsfOxG0pcYijXJxUGyAT
8hE6j70o0vdz7E1co6hnMSQTKPodkaMCnG7+gogc3CD/zY9lLlyDb3daVfo2RmiD83BZLzJ6
GkfJzqVbRVFM4PfENX77RmVJEtNVTXT/XPgdTIyik4nlwQ1ctLZgcmQR3qSO0YoGFeEokgsJ
aZh7dqJt4zlbE60hgfvlmJdntYyoa600y8AWdtCzHguRB1WlPW+rlh6GFMtNUa0aiE3RFZkM
r6aJ5OLCRFe/KLlgj/b0YhtbOHH/SmL7EH7diu2jXzUZeESM4SGWmR3fZV4QU8tTYLBnlABN
qB0kMZrTLFyZHM8AuC7mXRJGhYcEjBe4JrEf0Tam4MUVudRX1FnDLy+awyMAAg/FMgTQxDI7
IhE5xAKtu4jfACFwET3ldbHc/XSHK1U+NTDORMhiy3Qdyxh95xJgKGWdL0jbB/mxV3aKZdhF
bmLH9xqhYZ+0E8iLRxaNCKxtWfpMrFXIrHUOSWhcKAANx+bInSOfsbz+HhHdC2FBmTmJq18p
FAxH0OyhAXM8agFJvOu5fmJW5ToJuGINwF7CnJBoxI1ccL+23mFzXptLnZ0SGU/0mIgSlvhB
MGiIJVFCbSrVhgg0OSzk+m5hCWPBCboqC8KA3iOA5ivGCSjO0N1XgcNvdzVirRwaAXTeIPBm
FvGrHQaVDeTT4XInhisr1m2/3XqpZkyC0WWc2fvp+HlTHJ/w2we/9LQFF7NMQyZcvVZYPZW+
vRz+OZh6tTzxI2pMFnUWeCHq9qUCWcPD28Mj7z44xV6VxuJeW9Tb/lwtLNv4tX8V2S/Y/viB
VJlpV6X8ErlQKZY1uUIgip+rAWZaF1HimL/NS46AIYkpy1jiIj5fpnfWjd/ULHYc+gxgWe47
A57RI3l3S0gNumPzBkfyRyiLAxBrmC8+ZgQL+cdTKmzy5mcyQemZBwMvpmNxeFKAG74Kb7LT
6+vpqOu1aQL9ul4zNS9MDbx87ePEwkX5Ms+XxzoTJy0JWNO3dO6G1gxHn9uR1uKGduJCsFhP
9S8fVoyKdUb3aRxaPwZOz2ydq3XPt8CD3Lb09gkdPeIO/+1HDv6NpfQw8IzLSBiQrE8gkOIj
DCceBALVczEpqAHwW6OJ0GZSm4eRF4DRLeVfDtjEuJAAZIR8EpmKmDAOQ+N3gn9H5oDEkbW3
MckSARE7eBTM25DvoCtOkuDIGXmz6iCSMq3TYEHg0X3qRWij6EWydaUqAInBERl1oI48H4sX
XDINXerKBojE01UFWQOehRgwwZKqEnzIjnYQTIMLMh6EkTaOd44IQ1LKl8jY1wNLKVikxyyR
JzMH69t5dIedec/T1+vrH/UUZzAS+UyWr+savSeYOKl9pCy2BpRnFSpicagLMv4wZP7bHx//
3LA/x89f+4/D/0KE5jxnfzVV1Ycglla0wv7w4fP0/ld++Ph8P/z3FwQz1VnIJPR8xOHHyskk
jb8ePvb/qTjZ/ummOp3ebv7F2/33zT/nfn1o/dLbmgV+iPgRB8Su3vr/t+6+3JUxQUz1+c/7
6ePx9Lbns2FKD0Ll62CmCSDXJ0CRCfIw9922zJs4mL1wWBDS6tq5GyEpBH6bUoiAoVNktk2Z
xy+nWF3Zw0w15hmOdYbN2nf0mVEA8iwTNzg/3ZbmyalQvMwYGgJ6m+hu7nuOQ23P4VxJgWP/
8PL5S5MKeuj750378Lm/qU/Hw+fJkGlnRRBgCQxhtJMUnkYdF2WUkRBP7yTZnobUuyg7+PV6
eDp8/iEWXu35LmJ9+aIjtQILuLzpWgEO8Bxdsb3omKdzZ/kbz6WCoVWw6NZYOmAll1hpX1xA
mW75/YebH6nc2TlvhaDyr/uHj6/3/eue30K++KANdh96tFCgaAiKQ7yxBDChd1Zp7KyS2Fkl
sbNWLIkdZwgxn2fOcFt0l9t6G1GTWS43uzKrA8449JjQGtTYgjoGC5Mcw3dtJHYteknUEWZd
PYKSSytWRznb2uAkb+hx/TPQ2e/eOvl6BTCJOxSFS4dezkcZYv/w/OtT20jaUviR75hPbp40
X4NuT19NlY82D//NeRF+GWhyNvHJRw2BmqDVyWLfw7fC6cKNaZbPEdikI+MykptQPQcMiiFa
83766Hekv83A70h/zpk3Xto4uspHQvjHOg6K2V7esYjzhrSipJbzLYdV/GxzkTIG4zxKjyNQ
ri4q/mCp6+niWtu0jpFgpa94mAPnLNa2ZiaVDZ/WgAx7x1l5gKMqKgh6dViuUn7oUyqtVQPR
L7WhbfgXiPw+GoyVrqvHb4ff+sMx6259X194fPesNyXzQgKE99oFjLZtlzE/wAG1BCimpP1+
RDs+H2Gk9VMAEvR0I0ATUgLnmFh/0+aAIPS1YViz0E08lL5yky2rgH4jlCj8+rApaqFvI/mq
RFqCkGyqyPZo/pPPIZ8ylzzAMGeRNrcPz8f9p3xvJA7v22QS6/dw+K1fO2+dyUS/pagn8zqd
L0kg+cAuEFhsS+eczeG0d37oBYilKM4sSgu5iz7P1XpY1FmYBL5dX2TQ0XfxnqqtfSREYbix
qjEOfejfaZ0uUv4fC30kJpLzImfs6+Xz8Pay/42uIELTtEYaLUSoRJXHl8NxMNnaaUbg9RZk
SmewjzybnfTJYG7+c/Px+XB84jfO4x73a9Eqd1bKmgW8sdt23XQa2phi6TiN6qAf5c7U36Pt
IO9LtVo1FKVep8i1oXdPjRf97eoQP3IZWuTSeTg+f73wv99OHwe4aw63mTiXgl2zYnrt36kC
Xf/eTp9c/DhcLIB0DY9HcsuccUaiW0Kk2zDQT2MBSMw3Pw4i1SdZEzh6xGsAuL6hT5FsVH/o
C1x+pFFcuKnMm4nlW8lx4HOiC+FV3Uxch76N4SJSGfC+/wCRjuCK08aJnHqORKG6sdr7VAvO
yqmE63nDfBwEfNGQ17gya1zj1tZUrhuav03xXUFpXsaRPq6DhREW8CTE5JkYaSZ+5VCfWhyK
XTdtwYYXaAElBW+JwfJAGOhrdtF4TqQV/NmkXKCMBgBcfQ80BPrBrF9E8uPh+EwsBuZP/BDv
W5NYrafT78MrXB9hRz8dPuRb0JAZgCCJAt9XZZ62wutmt8F6zKnr+bTFTWMLlNvO8jgOHFJ0
amcOkrLYduKTG5MjUPoBKKlte5B2fHkZ0WSW0K+c7fD8PQ/86PAoj9iP0wtEmbr6+uYxUz3l
MXcQ1+/s0DparTzm9q9voDckGYLg307Kj7Ci1lNndpk3wRIn551lvesWRVuvpOcFtbGq7cSJ
9GSbEmK8kdf80kM+7gIiNkhdUt/d8aNNX2nit6dnKE63vpuEETr1iKHQbhcdlZ51Uxc7mY1E
jCb/eTN9Pzw9E/4CQNrxS0WAbmAAnaW3aLguVZ0e3p8oJ4pNXUJBfhcNyYI2nwUZU/XyQ4oA
GCRc2vUuAlDY1BPff8bxm8vULHS2m6J3sqKwxhJVBNaYpgJftJXFGUmgR9w5Ad8H5bES5Pf2
zhfNxOZKCmgV+cWKX5TTDR1zA7BlTbM5idvSthEK6dFx9hSWSx/2TskQaEYORR0vOQJeMSKd
q2/Ofv/SxTL7VyqDsRE8Y9bMUReCscDmQCXMouxY8LAsLdFmZXFplmUn2FJaC8Asu22RmSMj
PEHyehC3RSMRWV/xy5oAW2LaAE4LasslbotJA9BlKX11EEjlp2GLbyNolE2XlWDMtU/g7WH4
BLrykqypaB9xQQAWYSPYdqSoJbCQxNU2oaPH2uJcCQKIembFClcSO7YsMot3rkIvWjolr0Df
V3hDcgDkozRXz6aEEKgjIyDDqg1OlLK9u3n8dXjT0nb1AkJ7BysBSSSc65WUWK3i2pVZV+nn
cA7xd2SCv3MdP0SoqrS02BSqNcp5VQYlG5s3ak/HOzlK0P5MXTtVvxxFe5SsMXVB/OPFsQou
SEBh0tLOiHrsWxtN371FwgZtXypq784BGvmI5YUlzFMtusi6wqY3AIJlV69pZqwMkKG1bFVP
y6Ut4e1qtZyDDWqTLbisbjED1olqSzzpGrLemSPT63PMBXlej02a3SqBrL/ACmu+DvIp6ZK9
jGYN20H6+etzJ3Fpt4gptxSF3TIX5+GRcBFgIqAFFkVhF1kUwYjQgiiU8eAIoTWZhUSDtfcY
WggD8/sRklvPpZUDEl2lnN3YVrcgkEKCdZjrbNFwjp622/D/Kruy5rZxZf1XXHm6tyozx7Ll
7SEPEAlJiLgZJGXZLyzHVhLXJHbKyzln7q+/3QBBYmnQmZc46v6IHY3uBtAI2zq+rFt8Heu/
Y3KqQfEU9AR7OlSixgxBCt7DVLGj0goib1ZHGd6FrdbX8VgAGus/BeIyRf8Mjf/RRHjbHoGR
Yyf4QzDtCcxkzFgX0q2yllYGNA7jwpLsPnasiUv/XkR5g/Oj02snxvr6oH778qIu64/rW/96
bAdsaxduJHa5AG0r1exxKQWG0X7xunPZRHQhwA1DC5FRVPxdDUwf4+9iBQjtAAcRK/S72QnH
F6P8gupgrVOZ9/HfTE2ncBfvpoSByfCOdxSjJu35AkERZcyAutUu+y3Y7Ij9E5x6gy6ing5g
tlv9Lky1HGI7VrCsjI8F75PJxu4DGWF56ZgjquvVKxzT5dRPZfjdZhZPE/QYm68jhrl+iGO6
dUdMvNeL+mi6mAjQz55FlHvMSAXCZk1EzzaIqRHat8ZkUYbIwaWUdBwJG0UJB8OrQfzFrAIb
xrItFTACMepGv3qPAuvlZ5SLHazg74+mPozlVMv0kTDfg5y9B0G9BVXI6eLU+Lx1UU4PLKNE
T2WoNZBuK3f9A5/xfu2hElTyaLY69ujx2YkKV5G1oFBLX/a6A0ppe++MSo2hp6DqRhX6AbKF
KrRNLoJu7vnnO2zaqeJoZFLNZjqlSIbVjnVH50UOCqT7drrDnOwcRE11TJ5Xx+8DMP84AqMi
T9YWAO2S1sgMf1e/l8I6jUS9MAA9vyJ2jFr3lAKLlzZSTnqKcLKrS6J6Dtvps6palwXv8jQ/
PXVvNCK/THhWNtNJK0uGEg99aNbL+eHsYrIvtOIKkyfe3woSi881Avwx4wNQxq9rsqDIqouq
7pY8b8pu+05ZdEoTw8dCqfH8PjCi3NtNeX54upse1up5jbhTEyCSqaifU6nom5m8OJ5eVofr
l6n6taMVZAepxO7kkHehk0LAhSa1mFyFXHT6u+hJoT6gmuuKx8dC799Iq24rUk7beRZOzfjf
Qk4WzgS0mZJRAyY+cXRWakkC9cifO4OdNdlTNio+ngbUZLVGf9R6YpTjRSp05M6OYS2CBp2y
LAbo/H2oWM8Pz6bNEOXK1TZ2fEjooEAX8646ivjCAaQDH01llubns3dEAstPT+aECHdAn8+O
Zry7EjckQm0pJNqbFdVHwHCvRMXj3YvRt2Yxj47WuNAjtOE8XzAYd3kkVFQInar+sOek9ML4
jBpxkxn3d3Wp52TMlrxj7FtfYwg8zw/fs3J3dzPXD4DTQLT9LUej/Xw4NINzEAF/mxji3ZUU
DbVtrkAbmFRNEEhef58zxQicGuzx/vnp4d46P1CkshTWNnhP6BaiSPHdArvgLs/eJfa+0jGe
6k8fvjw83u+fP37/T/+ffz/e6/99iOcHwz5bDtUaLj7rgg9bB8w61F5sc557P4d97KFlNFl5
tQW9so+IMikbWm/pY6LxZRuJGaoTMc4ejjHKp3IzwFh+GoXvwMTLhBrnewUqcK4UaRnNSCtj
y2hxh2UzntMAma4MWtTxyvS9pwQyvmVNl2ZYUN6rt744ONF2JhT3ewnVxbaG3lpV1AatxMev
66rvbudgkQ5lEU9dhcUP2E7WUg9vvxnRc1FsJQtDsa+vDl6fb+/Uwazw7QPvMZaeqmVps7aO
pfUUlGsEdUViQTWhUnCjqw50JehIiUxUwaSKzmo7NRUoMV/JSUe2D+pYZFHr3/+oUBbFrvMP
iRlw7Z8N9BFJ5JXeAYeLU+eX3gf1C1ksL5C58+D+kg/KWbLelV7IOsVdSJGu7JvhuuhLyfkN
D7h9WSqU9n1kXS89yVeitA7Hl0uabgJdBnXC4JdsSataA6AQZd0PqIolXeGHLgu/iBlaTl/k
VdAbIVC9OpRFu612u6kWXcFVAMSuKFNaGiAoZ8qHFIkJayF0dIOQriNm+XnX3qMNNmvBMTak
m1iZeJEvyQN8bdYI6PvdeKnLOowfPpGRtxjWZ3V2ceRM4Z5cz+aREDAIiDQIsvCt7ciFgODR
iwpWn8o6u1iLcuf+UuGF3Yi0dSZyZxMZCX2Q8UZmrsiT8P+CJ40v8gwdVQyylg5IJV7WoCLQ
6rkDJg7Y9DCYmwj0SqiuISSFU0T7QkFSRN78cq4oxFAY9PaSRyRegz4flqacPGk9PC7VgNoM
mnfTSh4uHV7i5uNSKY3WL+3MSXOPik/GeKS6SJ3T8u5xSX1n/+HH/kCbCO7RS4bHlhsOswaj
9dXkES7gCTTJ7LrwXXPURQx94B1P8OYez+ghXNSomXe2cj4QkzW3o1Jb4G7HmsY78TAyq7IW
MD8T6rinjat50oLFYm2MfjZFGfXnd9L77KbjfBdoC/Y3DWsEPutnVXwX5I6U/tGobjsnkkLA
ZVs2zE1lKLGfmKQ2e5BRFrA8gk6YSFtIWxzJKyakn94Vk/Qm+o6q/8AFY9EfST1n0cigFQxt
siMGkBo1/VOSTucOCNnidgZYo9fK6qx9SHB+WJNZDSOHar8xYb7ENVYsrVwLkenKOuvbkfqA
SOumLLg3H7BEtvno9e8wyXCUuNkYWrfAl2dhGYmE3RYZ7xAhSIkM3/MikdcgRJUaZK3SFgNa
XI0T9TuiK6jGaaht/mVdlI1utwGfalJkMVE8FdSfSo4NyRlzsZ8ko/2IBFBwGuWpVosMBiil
nTIS+P0XOOLpdtJ8M3gcYgM6qZP5MocJTV1v1ZwjLwHnxCFrm3JZz50xomn+KIPWoUdZCR2R
sWsPP1JhJKdC4kINf2h3HYFl2RW7hkKUWVbSR66sr9B/QmsVFijnUPeycsZAH/Dt7vve0tOg
H0dRaU+VBMwH7g5aRYoKZ8XFGWG/cj3QLNkwRI9TJdGlSv8Ac/pf6TZVi++49ppRW5cXuAVt
99znMhPcKvINgGx+my5NN5kc6Vz0Rbuy/teSNf/iO/wX1B2yHMBzypDX8J03GLYaRE6uZngc
MAHDoGJgZ82Pz6w2BsTo7iOSUMVziqApJllR4jN0NbTLh7fXr+eD961ogkGuSLHOVEx55eND
TcWoUVPNp49Zvezf7p8OvjrNagmKMolpQfrxv7XIUskLoqwbLgu7RbyLLU1euRVXBHpJ9DBK
WaL0T54vUxDYHJRBa7CrP2M7G5dzWPFRCa4TtYjgQ8U8twpdSlaseNBnLA2Wv5G3jC2NXC0t
7qgxJPSL1WwFgtnOZx1LChhV1gZ6Bo/hF96S7C/RiWR5+Fsvu47uXoMpUa+dbu4pehUOxJXL
1oKWtnQMEN0beQWGYbGKPC/sQ5VRTNSaxOFjCUnVkmWMDbQBcONEWhnI2c2cTC+7oQzoMbsb
Iq2buknJxObqFbJFtoGmuSGDXhokzxcc7L2U6iTJVjkHZUAvIpjSp2NLaO7iAzsXBcxUejnO
vfG0roI5c1ns5rHhCbxTL4We5GkjMshJUxYs2eCDGtd6yPps0O48elU3TiR//XuQ3xt83nNx
DdL/0+zwaH4YwjI0QHFUuZeOewB0/BRzbjNHATuw18kAoEWxRp7Pj34Lh0OKBLqwaIH96ppm
IgtfBrCpotltQeHpEg4F+HC///rj9nX/IUg40Y80xtNy347tiSD2nLl3XW/pEdt6w1D/1huI
dgrtxOLOZemL5Z4SWnADJyaiBsCNexkIFMurUm7s5Y3SMzKrFPBjbOCHl6fz85OLP2ZWEyPA
KE7dnLyS70DOjp07wy7vjAoX5EDO7Sh7HucoyjmJZnl+8m6Jz90IoB6PvvrpgeiDHh6I9jR6
IMpv4kEmKntKByD3QBfvgy6OqSvhLiTaUxfHsZ7yHq5wy3VGh3BFEJgZODA72n/tJDM78t9E
iaAogxYxrE6EcMtvsp/5hTeMeP8bRLzzDeL92scmj+Gf0qU+o8kXkToeR+jzWOXJsPYI2JTi
vJNucorWurScJbh2s8LPARkJBz2OfF1hABQNb2VJfixL1ghGWTAD5FqKLBNJWKQV4zRdcr4J
yQJK6rwHOTCKVjSRGgtWhJymlRtRr11G2yyt0Bhgr+JYdlYfTeoKjKuUiRumHF3mvAdpQTpO
dx0dfH/39ozRM55+YYAgywzf8Gtr2cBfneSXLUZyMnaAWV65rAUsPqB4AkyCau+aghKPcacq
CWpt0066HuDk2KXrroTUVc2cNJGpnGgi0UzalOhd310KBpi679RIEbNQeiylevcsRwfGMwpr
JlNeQMnR0YeeoI5loIn2L2UMSA80weqWkMBCv3Y52okBCiVaXTHat61894kC5zA81jyrSC+k
0YbHRmLW2M/q/NOHH7eP9xj8+CP+c//0n8ePf9/+vIVft/e/Hh4/vtx+3UOCD/cfHx5f999w
GH388uvrBz2yNvvnx/2Pg++3z/d7FdVmHGH9q80/n57/Pnh4fMBAmA//d+vGYRbooMG7Wxvo
6MJ+4g4ZeI8Hm3qohev7NRjcbbcglEMtgfYFvQo0LBjWGV54gpaW3B3CBJucX5E6GXa8SYaY
+v50HPY6SqmtHMeOh3mDYlA7eZ7//vX6dHD39Lw/eHo++L7/8UuF6B4qoeGgK1bUNOy5LFsx
50kHm3wU0jlLSWIIrTeJqNb23qnHCD+BnlmTxBAqixVFI4GWheMVPFoSFiv8pqpC9MbeETcp
oHkTQmFJYCsi3Z4efoDz2h6aLh4DbbBFxvXWESkfvA/4rpEshLvg1XJ2dJ63WVCaos1oYlhw
9YcYLG2zhiUgoPdnFl3i8Gan9na+ffnxcPfHX/u/D+7U4P/2fPvr+9+jDDFdXrMgpTQcWDwJ
S8ETEpgSKfJEUuQ6J5qilVt+dHIyuzBVYW+v3zGQ3B2Yu/cH/FHVBwP2/efh9fsBe3l5untQ
rPT29TaoYJLkQR4rgpasYeFmR4dVmV1jKFdi5q5EDV0d1oJfii1R5TUDUbs1tVioSPk/n+7t
zQ+T9yIhhm2ypO5kGWYTzoukCQQgFGNBJJ1JepenZ5dTOVe6tC5xR2QNesiVZOFsL9bxNk5B
B2zanCgyx0e+w/OHty/fY42as7Cca4q4o2q01UgTBHH/8hrmIJPjo/BLRQ4z2ZESe5GxDT9a
ROhho0LizewwFctwUJPpR5s6T+cEjcAJGMjqImdYU5mnTqx0MyHWbEYRj05OKfLJjFgQ1+w4
JOYEDTdoF2W4wF1VOl29yj/8+u6cDhvmdNjCQOvcQ6RDl5RXSzBFJiYlyzmYT6GgSxhaBioW
AMk7IbJDOu3BMGKavHRnNBn1NyrliPxg7azoK8VD84cjprkql4IYdj19rLPuhqefvzAWpKPM
DrVRrtYgpeymDGjn83DEeDsRI3UdeTZTA9BDHEgVCbr908+D4u3nl/2zed2EKjQratElFaVg
pXKh3kpsaU4viII+VTw2NcgUhBL/yAiIn0XTcLwqLh3rylKYOkqnNQyjZvrlHPhGQY2Xd4BS
rWQzYcRvw9ViQPTqdLQkvFDKXblA73dD758NQoNNaXRYZzCTlr758OPhy/MtmDDPT2+vD4/E
koPvDlAiRdFlEk4f9VCBlvQmtMcUhuTpKT35uYbQrEHdslIIZpEDjDcc4tJI/c1CBBonbr3N
piDTJTGwqR4eaz1qdNPljqxPikUIvvUVNXv5Fk3vK1HEYlRZwDo7Ppm9I+C33Vosi+7s4oQ+
cGMB+zufMhL7zs74hD4va1dChdVkkSuBAbCJXR4MkNDKE5JtgAlCrRq5lDHiZHF0OGeR7rmM
HBRzIGX+O+0o8lXDk0BaU9D+nP9vNGiy5lkdCfZkwbZCNuQZdbuf2ZLvEh7aoCqfxDvY5ow5
PKlPnpq2WzvPypVIMBJObCqMiIkTpU6Jj1r6OIwFMtc6y6RWuhrMzn/yyTppiXqx+jrPOXpA
lfsUL2yPzWYxq3aR9Zi6Xbiw3cnhRZdw2XteeX9E226capPU53gocYt8TCV6jBuhZ/3hmFhS
Z/rxAEiH9naKFbpGK66PoKjzrb1PODyWh2/ufFU29svB16fng5eHb486HvHd9/3dXw+P38bl
Tm+n2s5rKezFPeTXnz588LjauWK1V/B9gNCnNuaHF6eOb7osUiav/eLQTaJThvU02WSibmiw
Oa73G21iirwQBZZBnTddfhpeHYopDJKJ9LSrnMiThtYteJGAfig3xLDAk7pMdup0ln1egakz
wCNhIcAwwltDVrOa4GFgMxUJOtSlii1he9hsSMaLCLfAEGqNsLfODWspihT+kdC0C+Gck0hK
mYrI1Wkpct4Vbb6AAhOV1pscLAuzqxIx3HYY5n0C0g3UXoc0O3URoRGddKJpO/cr146Hn+6V
YZcDgoEvruldWQcSk1cKwuQVI69ia/5CuCU8dVQTV8VMrM1O0GNCd0ViObN8/wSGLmwoTQyG
XlrmVlMQZbXP54xJIlUfSHPpeLYM9W3X/rvR2qRHpc8XIZVK2TtwZFHJctinhTwyhd/dINlu
G03pdufUgYGeqW7625fde7pgdl/2RCZzitasYa4EDAz1E6a7SD4HNNeBPNbNtbYd+pyk92f2
vFlJ7PSBtpF2YJmVjgvEpuJm53mEBTnaj9LDwlCDFEzWFK3b2O8FWPRFTpKXtUVXtwm2LDPn
/gcNoC4TAVJoy6H5JXP2KdV9KzssAJLS3LK3MEpCWdkHjbBySMXQGWiNchcM9c2YOsu1Vsa7
VRIsMmZQ86atwpRH/nWRKPayNGES3kPpw6E+BLnQ2ZVdmGHAI9NsHaOqUZbUDR9EFWVhEuhy
R2Ajd2BhCi5L8gDd31ogOOgI8E5OOuSu9jjYAcN6a2kgq0yPYktcqttJqFOx/qqgSebSXpiy
cuH+spcM0/1ZfwnOnzdNmQtXpGc3XcPsNw7lJRrAdhjrSjhnc1ORO7/hxzK1MscYGHgxGjrt
2q6w1/Q1rDTeLcIKI9DRG+vl4jNb0VpUoAS5O+BGtVTUX88Pj69/6ddKfu5f7H1xW1koMPga
qAzxKz8btSNNKtZq3xwUywRfzxAYW9veeNOHJzswXDJQn7JhO/Qsirhs8RbIfOiOXmMPUpiP
RVyUZWPKmfKM0ep7el0wGA7RU5QO3zwIb2m6+aJEW4VLCThO9k20vQd37cOP/R+vDz97jfdF
Qe80/Tk8F7OUkJO6aKVOD49NLgVYvzXGSsmdwwOSs1S57YBJNsKaY5R2vHQE/ZaRwkXPaxAI
eMQnF3XOGntl8DmqeHg30hr9Og2QgTAolm2hP2AZzPXudG7NpS1MrQJvgTtyx/r4irMNnvnp
zEF7Y0r8blOqhlce54c7M0nS/Ze3b9/wTIR4fHl9fsMHUZ0pkTM0s8G2cWOWu+WrgxLXSsRd
4b+OTDdc3C9XgBxvdtNj1E0JT6NQlzaYWjdxbV6lVnOGv/xrnSNNHWWHeUPy1ITCUQYm0Ift
bDk7PLRO7SrgJqWjQLWLmjwSp8oMNjYrlEooMveZut/qIre98ZqQ7Y3RVLyCY+zF/ojMkJj1
eA6KFNBZeFF7Vzl1KshX6xUtEvHr8qqgHQ3Kv1CKuiwcC1InDIKdO/vKDplY21z+0vMyuVx1
t592iblAPMgdHdkGhMFT194mgYvQF2BMoIJ3E+x3FIwAH1zWddYuDNTpC8WIbS6oAdWPBFAX
M5AUYUkNZ6JN9LmvFhcZanUDNSXtMRxMce8m/qjVqbS2eVetGqxlWJQtFcOD+MwdzTwv5bU6
Y2brw0PNVcHwmugSxEWYp8OOn0jD4QBjFcSNugwubkC6pOlwq8Q9cDbOJm/FWOuXP/QOP4IO
yqdfLx8Psqe7v95+afm8vn38Zr9hxTDmL0ii0lG6HTJGaWitDQ7NxKFets2n4UINnldDBZ43
MNZsS6kul03IdHQHUMRYbgNVHtTttyi4L+Wh3QOYWbfGgI8Nq6n5dnUJiycsoWnpXKSdbjx9
lBbWvPs3XOgI4abHbL/hNh73Iz7xxwu26oZz/2E+7XzD8zajXP6fl18Pj3gGBwr58+11/989
/Gf/evfnn3/+r/WeJd62V2njjUTrWrKlXsL4nLhzr1JAGeBPDQl2Twt2Jw+EaQ3ldy9p9ZNp
gHvVvrrSPBA45VXFGnr/oc/2qqZvvmi2Kq5n6ei7j1VAQOdT/Wl24pPVSae65576XC2LeoVb
QS6mIGrzVePmQUYCZDwYxqBz89akduTXuEdHq6ytLGg7zquwbfue1Zvb/epGNZ9qOJibaAt6
/pSxe4LVsU6W/kejofQPBqxbIxBky4yt7Lupg5Fj11BpvuqkblFznuJpXeXMmxg+G70YBrNL
z/m/tPZzf/t6e4Bqzx06xx3VtG9UQboJe90FucRaQNo8iqVPt4Pq4AhGtRx3KWvQnaDiDgn/
nRBHYEUK72aVSGinohEsGx5ahDFISTF6LKBSgg/lUPT4FxiOJPpV36sWiV8S4Q3cYgYi5LK3
WKSyVSZGgI5AAronepGoXtTzNnElGBIjEnSpPqC3Zxg+HBO5sKCcTFgIL1Sj6pTb5zunU7xK
MJEqF1d9fbMoqUrMTjdqzjgahJuo7bdo9i+vOElxmUue/r1/vv1mPdCtIihYhooKqNCHWvXJ
/maCpvKdaokgCoMHw7kcE1BmkqADAGouis/aEHYWs5yGEcmVSxiVU0nb3s1Gh56bRPXxIqhi
LZnI6ozRBhsytdESGDx0yvblEjeVnG24ubhDpgMY9aa51t38z5co5CNldEtgzOS4SguKbFJu
+7nkxPAFWwV3x7CbcUK5R8qyTdo4p2XVhrDa2axLGYmZhpBcFGgsUauk4tdONBZFSsXWdk0u
BjcaLnO+oFqgAz0Y3I5TP7J35LjgvWSNg5RYWVUR13yXtrb7X/sEYvCeq68B1SGzTuwzc3qv
HciNHcZPUYdtXyeBhBU+bXCq2sS2tV2QirTzdhkUkbKbFEOi0qTssVh3+sf4FFGkZDBJ3MGF
clJucfXZUsgcNAlrDQI0TPQs9QUfWGRli4uMI+pM11zXSZORLL0zTzKs3e9gdCV5qgJZTQaw
QaXRLwma7VR2Zt+ZZOquU+7boGVhhUoYDIv4/FOLDZrJsR6DJFwrWrc9zgl1xc1ep6YWJa2y
vL28Wr72UUew6Z6emIsaI5F0aZm0GDiDXpW1SrkQWsjTN788X///A3u1o9pG0QIA

--envbJBWh7q8WU6mo--
