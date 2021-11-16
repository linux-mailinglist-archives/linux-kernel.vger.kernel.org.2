Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF5E453B26
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 21:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhKPUpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 15:45:25 -0500
Received: from mga14.intel.com ([192.55.52.115]:41110 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229696AbhKPUpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 15:45:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="234061374"
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="gz'50?scan'50,208,50";a="234061374"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 12:42:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="gz'50?scan'50,208,50";a="672119803"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 16 Nov 2021 12:42:22 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mn5Ha-0000nx-1w; Tue, 16 Nov 2021 20:42:22 +0000
Date:   Wed, 17 Nov 2021 04:41:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: drivers/firmware/efi/sysfb_efi.c:190:35: warning: unused variable
 'efifb_dmi_system_table'
Message-ID: <202111170412.X7ERc8WG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8ab774587903771821b59471cc723bba6d893942
commit: 15d27b15de965043d6f8e23bc7f34386fcd1a772 efi: sysfb_efi: fix build when EFI is not set
date:   4 months ago
config: x86_64-randconfig-r005-20211116 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project fbe72e41b99dc7994daac300d208a955be3e4a0a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=15d27b15de965043d6f8e23bc7f34386fcd1a772
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 15d27b15de965043d6f8e23bc7f34386fcd1a772
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/firmware/efi/sysfb_efi.c:72:6: warning: no previous prototype for function 'efifb_setup_from_dmi' [-Wmissing-prototypes]
   void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
        ^
   drivers/firmware/efi/sysfb_efi.c:72:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
   ^
   static 
>> drivers/firmware/efi/sysfb_efi.c:190:35: warning: unused variable 'efifb_dmi_system_table' [-Wunused-const-variable]
   static const struct dmi_system_id efifb_dmi_system_table[] __initconst = {
                                     ^
>> drivers/firmware/efi/sysfb_efi.c:240:35: warning: unused variable 'efifb_dmi_swap_width_height' [-Wunused-const-variable]
   static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
                                     ^
>> drivers/firmware/efi/sysfb_efi.c:331:39: warning: unused variable 'efifb_fwnode_ops' [-Wunused-const-variable]
   static const struct fwnode_operations efifb_fwnode_ops = {
                                         ^
   4 warnings generated.


vim +/efifb_dmi_system_table +190 drivers/firmware/efi/sysfb_efi.c

2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  178  
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  179  #define EFIFB_DMI_SYSTEM_ID(vendor, name, enumid)		\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  180  	{							\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  181  		efifb_set_system,				\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  182  		name,						\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  183  		{						\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  184  			DMI_MATCH(DMI_BIOS_VENDOR, vendor),	\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  185  			DMI_MATCH(DMI_PRODUCT_NAME, name)	\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  186  		},						\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  187  		&efifb_dmi_list[enumid]				\
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  188  	}
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  189  
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02 @190  static const struct dmi_system_id efifb_dmi_system_table[] __initconst = {
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  191  	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "iMac4,1", M_I17),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  192  	/* At least one of these two will be right; maybe both? */
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  193  	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "iMac5,1", M_I20),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  194  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "iMac5,1", M_I20),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  195  	/* At least one of these two will be right; maybe both? */
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  196  	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "iMac6,1", M_I24),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  197  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "iMac6,1", M_I24),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  198  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "iMac7,1", M_I20_SR),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  199  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "iMac8,1", M_I24_8_1),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  200  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "iMac10,1", M_I24_10_1),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  201  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "iMac11,1", M_I27_11_1),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  202  	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "Macmini1,1", M_MINI),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  203  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "Macmini3,1", M_MINI_3_1),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  204  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "Macmini4,1", M_MINI_4_1),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  205  	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "MacBook1,1", M_MB),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  206  	/* At least one of these two will be right; maybe both? */
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  207  	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "MacBook2,1", M_MB),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  208  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBook2,1", M_MB),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  209  	/* At least one of these two will be right; maybe both? */
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  210  	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "MacBook3,1", M_MB),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  211  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBook3,1", M_MB),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  212  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBook4,1", M_MB),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  213  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBook5,1", M_MB_5_1),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  214  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBook6,1", M_MB_6_1),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  215  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBook7,1", M_MB_7_1),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  216  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookAir1,1", M_MBA),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  217  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookAir3,1", M_MBA_3),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  218  	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "MacBookPro1,1", M_MBP),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  219  	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "MacBookPro2,1", M_MBP_2),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  220  	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "MacBookPro2,2", M_MBP_2_2),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  221  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookPro2,1", M_MBP_2),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  222  	EFIFB_DMI_SYSTEM_ID("Apple Computer, Inc.", "MacBookPro3,1", M_MBP_SR),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  223  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookPro3,1", M_MBP_SR),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  224  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookPro4,1", M_MBP_4),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  225  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookPro5,1", M_MBP_5_1),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  226  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookPro5,2", M_MBP_5_2),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  227  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookPro5,3", M_MBP_5_3),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  228  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookPro6,1", M_MBP_6_1),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  229  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookPro6,2", M_MBP_6_2),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  230  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookPro7,1", M_MBP_7_1),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  231  	EFIFB_DMI_SYSTEM_ID("Apple Inc.", "MacBookPro8,2", M_MBP_8_2),
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  232  	{},
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  233  };
2995e506276bfd arch/x86/kernel/sysfb_efi.c      David Herrmann           2013-08-02  234  
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  235  /*
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  236   * Some devices have a portrait LCD but advertise a landscape resolution (and
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  237   * pitch). We simply swap width and height for these devices so that we can
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  238   * correctly deal with some of them coming with multiple resolutions.
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  239   */
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21 @240  static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  241  	{
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  242  		/*
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  243  		 * Lenovo MIIX310-10ICR, only some batches have the troublesome
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  244  		 * 800x1280 portrait screen. Luckily the portrait version has
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  245  		 * its own BIOS version, so we match on that.
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  246  		 */
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  247  		.matches = {
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  248  			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  249  			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "MIIX 310-10ICR"),
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  250  			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "1HCN44WW"),
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  251  		},
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  252  	},
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  253  	{
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  254  		/* Lenovo MIIX 320-10ICR with 800x1280 portrait screen */
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  255  		.matches = {
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  256  			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  257  			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION,
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  258  					"Lenovo MIIX 320-10ICR"),
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  259  		},
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  260  	},
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  261  	{
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  262  		/* Lenovo D330 with 800x1280 or 1200x1920 portrait screen */
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  263  		.matches = {
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  264  			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  265  			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION,
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  266  					"Lenovo ideapad D330-10IGM"),
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  267  		},
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  268  	},
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  269  	{},
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  270  };
d02f1aa39189e0 arch/x86/kernel/sysfb_efi.c      Hans de Goede            2019-07-21  271  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  272  static bool efifb_overlaps_pci_range(const struct of_pci_range *range)
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  273  {
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  274  	u64 fb_base = screen_info.lfb_base;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  275  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  276  	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  277  		fb_base |= (u64)(unsigned long)screen_info.ext_lfb_base << 32;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  278  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  279  	return fb_base >= range->cpu_addr &&
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  280  	       fb_base < (range->cpu_addr + range->size);
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  281  }
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  282  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  283  static struct device_node *find_pci_overlap_node(void)
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  284  {
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  285  	struct device_node *np;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  286  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  287  	for_each_node_by_type(np, "pci") {
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  288  		struct of_pci_range_parser parser;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  289  		struct of_pci_range range;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  290  		int err;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  291  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  292  		err = of_pci_range_parser_init(&parser, np);
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  293  		if (err) {
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  294  			pr_warn("of_pci_range_parser_init() failed: %d\n", err);
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  295  			continue;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  296  		}
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  297  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  298  		for_each_of_pci_range(&parser, &range)
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  299  			if (efifb_overlaps_pci_range(&range))
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  300  				return np;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  301  	}
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  302  	return NULL;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  303  }
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  304  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  305  /*
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  306   * If the efifb framebuffer is backed by a PCI graphics controller, we have
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  307   * to ensure that this relation is expressed using a device link when
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  308   * running in DT mode, or the probe order may be reversed, resulting in a
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  309   * resource reservation conflict on the memory window that the efifb
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  310   * framebuffer steals from the PCIe host bridge.
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  311   */
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  312  static int efifb_add_links(struct fwnode_handle *fwnode)
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  313  {
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  314  	struct device_node *sup_np;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  315  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  316  	sup_np = find_pci_overlap_node();
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  317  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  318  	/*
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  319  	 * If there's no PCI graphics controller backing the efifb, we are
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  320  	 * done here.
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  321  	 */
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  322  	if (!sup_np)
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  323  		return 0;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  324  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  325  	fwnode_link_add(fwnode, of_fwnode_handle(sup_np));
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  326  	of_node_put(sup_np);
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  327  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  328  	return 0;
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  329  }
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  330  
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25 @331  static const struct fwnode_operations efifb_fwnode_ops = {
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  332  	.add_links = efifb_add_links,
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  333  };
8633ef82f101c0 drivers/firmware/efi/sysfb_efi.c Javier Martinez Canillas 2021-06-25  334  

:::::: The code at line 190 was first introduced by commit
:::::: 2995e506276bfdc7311eb02db8b2aa1a61a4b849 x86: sysfb: move EFI quirks from efifb to sysfb

:::::: TO: David Herrmann <dh.herrmann@gmail.com>
:::::: CC: H. Peter Anvin <hpa@linux.intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ZPt4rx8FFjLCG7dd
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
P05YG9ykQOC9vqS8Mf8Pre+lnqYuAgA=

--ZPt4rx8FFjLCG7dd--
