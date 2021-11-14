Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9598C44F71D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 08:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbhKNHfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 02:35:50 -0500
Received: from mga12.intel.com ([192.55.52.136]:24727 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229908AbhKNHfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 02:35:39 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10167"; a="213339074"
X-IronPort-AV: E=Sophos;i="5.87,233,1631602800"; 
   d="gz'50?scan'50,208,50";a="213339074"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2021 23:32:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,233,1631602800"; 
   d="gz'50?scan'50,208,50";a="493567350"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 13 Nov 2021 23:32:30 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mmA05-000L4n-UL; Sun, 14 Nov 2021 07:32:29 +0000
Date:   Sun, 14 Nov 2021 15:32:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Kosina <jkosina@suse.cz>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/hid/hid-nintendo.c:196:45: error: unused variable
 'joycon_rumble_frequencies'
Message-ID: <202111141514.s63tieIl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c8c109546a19613d323a319d0c921cb1f317e629
commit: daf11ca2b9f45a1ac6f90af5a61ee4db915110b1 HID: nintendo: fix -Werror build
date:   13 days ago
config: i386-buildonly-randconfig-r003-20211114 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c3dddeeafb529e769cde87bd29ef6271ac6bfa5c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=daf11ca2b9f45a1ac6f90af5a61ee4db915110b1
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout daf11ca2b9f45a1ac6f90af5a61ee4db915110b1
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/hid/hid-nintendo.c:196:45: error: unused variable 'joycon_rumble_frequencies' [-Werror,-Wunused-const-variable]
   static const struct joycon_rumble_freq_data joycon_rumble_frequencies[] = {
                                               ^
>> drivers/hid/hid-nintendo.c:254:44: error: unused variable 'joycon_rumble_amplitudes' [-Werror,-Wunused-const-variable]
   static const struct joycon_rumble_amp_data joycon_rumble_amplitudes[] = {
                                              ^
>> drivers/hid/hid-nintendo.c:400:18: error: unused variable 'JC_RUMBLE_DFLT_LOW_FREQ' [-Werror,-Wunused-const-variable]
   static const u16 JC_RUMBLE_DFLT_LOW_FREQ = 160;
                    ^
>> drivers/hid/hid-nintendo.c:401:18: error: unused variable 'JC_RUMBLE_DFLT_HIGH_FREQ' [-Werror,-Wunused-const-variable]
   static const u16 JC_RUMBLE_DFLT_HIGH_FREQ = 320;
                    ^
>> drivers/hid/hid-nintendo.c:403:29: error: unused variable 'JC_RUMBLE_ZERO_AMP_PKT_CNT' [-Werror,-Wunused-const-variable]
   static const unsigned short JC_RUMBLE_ZERO_AMP_PKT_CNT = 5;
                               ^
   5 errors generated.


vim +/joycon_rumble_frequencies +196 drivers/hid/hid-nintendo.c

c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  191  
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  192  /*
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  193   * These tables are from
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  194   * https://github.com/dekuNukem/Nintendo_Switch_Reverse_Engineering/blob/master/rumble_data_table.md
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  195   */
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11 @196  static const struct joycon_rumble_freq_data joycon_rumble_frequencies[] = {
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  197  	/* high, low, freq */
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  198  	{ 0x0000, 0x01,   41 }, { 0x0000, 0x02,   42 }, { 0x0000, 0x03,   43 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  199  	{ 0x0000, 0x04,   44 }, { 0x0000, 0x05,   45 }, { 0x0000, 0x06,   46 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  200  	{ 0x0000, 0x07,   47 }, { 0x0000, 0x08,   48 }, { 0x0000, 0x09,   49 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  201  	{ 0x0000, 0x0A,   50 }, { 0x0000, 0x0B,   51 }, { 0x0000, 0x0C,   52 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  202  	{ 0x0000, 0x0D,   53 }, { 0x0000, 0x0E,   54 }, { 0x0000, 0x0F,   55 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  203  	{ 0x0000, 0x10,   57 }, { 0x0000, 0x11,   58 }, { 0x0000, 0x12,   59 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  204  	{ 0x0000, 0x13,   60 }, { 0x0000, 0x14,   62 }, { 0x0000, 0x15,   63 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  205  	{ 0x0000, 0x16,   64 }, { 0x0000, 0x17,   66 }, { 0x0000, 0x18,   67 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  206  	{ 0x0000, 0x19,   69 }, { 0x0000, 0x1A,   70 }, { 0x0000, 0x1B,   72 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  207  	{ 0x0000, 0x1C,   73 }, { 0x0000, 0x1D,   75 }, { 0x0000, 0x1e,   77 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  208  	{ 0x0000, 0x1f,   78 }, { 0x0000, 0x20,   80 }, { 0x0400, 0x21,   82 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  209  	{ 0x0800, 0x22,   84 }, { 0x0c00, 0x23,   85 }, { 0x1000, 0x24,   87 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  210  	{ 0x1400, 0x25,   89 }, { 0x1800, 0x26,   91 }, { 0x1c00, 0x27,   93 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  211  	{ 0x2000, 0x28,   95 }, { 0x2400, 0x29,   97 }, { 0x2800, 0x2a,   99 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  212  	{ 0x2c00, 0x2b,  102 }, { 0x3000, 0x2c,  104 }, { 0x3400, 0x2d,  106 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  213  	{ 0x3800, 0x2e,  108 }, { 0x3c00, 0x2f,  111 }, { 0x4000, 0x30,  113 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  214  	{ 0x4400, 0x31,  116 }, { 0x4800, 0x32,  118 }, { 0x4c00, 0x33,  121 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  215  	{ 0x5000, 0x34,  123 }, { 0x5400, 0x35,  126 }, { 0x5800, 0x36,  129 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  216  	{ 0x5c00, 0x37,  132 }, { 0x6000, 0x38,  135 }, { 0x6400, 0x39,  137 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  217  	{ 0x6800, 0x3a,  141 }, { 0x6c00, 0x3b,  144 }, { 0x7000, 0x3c,  147 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  218  	{ 0x7400, 0x3d,  150 }, { 0x7800, 0x3e,  153 }, { 0x7c00, 0x3f,  157 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  219  	{ 0x8000, 0x40,  160 }, { 0x8400, 0x41,  164 }, { 0x8800, 0x42,  167 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  220  	{ 0x8c00, 0x43,  171 }, { 0x9000, 0x44,  174 }, { 0x9400, 0x45,  178 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  221  	{ 0x9800, 0x46,  182 }, { 0x9c00, 0x47,  186 }, { 0xa000, 0x48,  190 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  222  	{ 0xa400, 0x49,  194 }, { 0xa800, 0x4a,  199 }, { 0xac00, 0x4b,  203 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  223  	{ 0xb000, 0x4c,  207 }, { 0xb400, 0x4d,  212 }, { 0xb800, 0x4e,  217 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  224  	{ 0xbc00, 0x4f,  221 }, { 0xc000, 0x50,  226 }, { 0xc400, 0x51,  231 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  225  	{ 0xc800, 0x52,  236 }, { 0xcc00, 0x53,  241 }, { 0xd000, 0x54,  247 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  226  	{ 0xd400, 0x55,  252 }, { 0xd800, 0x56,  258 }, { 0xdc00, 0x57,  263 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  227  	{ 0xe000, 0x58,  269 }, { 0xe400, 0x59,  275 }, { 0xe800, 0x5a,  281 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  228  	{ 0xec00, 0x5b,  287 }, { 0xf000, 0x5c,  293 }, { 0xf400, 0x5d,  300 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  229  	{ 0xf800, 0x5e,  306 }, { 0xfc00, 0x5f,  313 }, { 0x0001, 0x60,  320 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  230  	{ 0x0401, 0x61,  327 }, { 0x0801, 0x62,  334 }, { 0x0c01, 0x63,  341 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  231  	{ 0x1001, 0x64,  349 }, { 0x1401, 0x65,  357 }, { 0x1801, 0x66,  364 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  232  	{ 0x1c01, 0x67,  372 }, { 0x2001, 0x68,  381 }, { 0x2401, 0x69,  389 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  233  	{ 0x2801, 0x6a,  397 }, { 0x2c01, 0x6b,  406 }, { 0x3001, 0x6c,  415 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  234  	{ 0x3401, 0x6d,  424 }, { 0x3801, 0x6e,  433 }, { 0x3c01, 0x6f,  443 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  235  	{ 0x4001, 0x70,  453 }, { 0x4401, 0x71,  462 }, { 0x4801, 0x72,  473 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  236  	{ 0x4c01, 0x73,  483 }, { 0x5001, 0x74,  494 }, { 0x5401, 0x75,  504 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  237  	{ 0x5801, 0x76,  515 }, { 0x5c01, 0x77,  527 }, { 0x6001, 0x78,  538 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  238  	{ 0x6401, 0x79,  550 }, { 0x6801, 0x7a,  562 }, { 0x6c01, 0x7b,  574 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  239  	{ 0x7001, 0x7c,  587 }, { 0x7401, 0x7d,  600 }, { 0x7801, 0x7e,  613 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  240  	{ 0x7c01, 0x7f,  626 }, { 0x8001, 0x00,  640 }, { 0x8401, 0x00,  654 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  241  	{ 0x8801, 0x00,  668 }, { 0x8c01, 0x00,  683 }, { 0x9001, 0x00,  698 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  242  	{ 0x9401, 0x00,  713 }, { 0x9801, 0x00,  729 }, { 0x9c01, 0x00,  745 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  243  	{ 0xa001, 0x00,  761 }, { 0xa401, 0x00,  778 }, { 0xa801, 0x00,  795 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  244  	{ 0xac01, 0x00,  812 }, { 0xb001, 0x00,  830 }, { 0xb401, 0x00,  848 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  245  	{ 0xb801, 0x00,  867 }, { 0xbc01, 0x00,  886 }, { 0xc001, 0x00,  905 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  246  	{ 0xc401, 0x00,  925 }, { 0xc801, 0x00,  945 }, { 0xcc01, 0x00,  966 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  247  	{ 0xd001, 0x00,  987 }, { 0xd401, 0x00, 1009 }, { 0xd801, 0x00, 1031 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  248  	{ 0xdc01, 0x00, 1053 }, { 0xe001, 0x00, 1076 }, { 0xe401, 0x00, 1100 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  249  	{ 0xe801, 0x00, 1124 }, { 0xec01, 0x00, 1149 }, { 0xf001, 0x00, 1174 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  250  	{ 0xf401, 0x00, 1199 }, { 0xf801, 0x00, 1226 }, { 0xfc01, 0x00, 1253 }
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  251  };
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  252  
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  253  #define joycon_max_rumble_amp	(1003)
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11 @254  static const struct joycon_rumble_amp_data joycon_rumble_amplitudes[] = {
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  255  	/* high, low, amp */
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  256  	{ 0x00, 0x0040,    0 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  257  	{ 0x02, 0x8040,   10 }, { 0x04, 0x0041,   12 }, { 0x06, 0x8041,   14 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  258  	{ 0x08, 0x0042,   17 }, { 0x0a, 0x8042,   20 }, { 0x0c, 0x0043,   24 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  259  	{ 0x0e, 0x8043,   28 }, { 0x10, 0x0044,   33 }, { 0x12, 0x8044,   40 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  260  	{ 0x14, 0x0045,   47 }, { 0x16, 0x8045,   56 }, { 0x18, 0x0046,   67 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  261  	{ 0x1a, 0x8046,   80 }, { 0x1c, 0x0047,   95 }, { 0x1e, 0x8047,  112 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  262  	{ 0x20, 0x0048,  117 }, { 0x22, 0x8048,  123 }, { 0x24, 0x0049,  128 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  263  	{ 0x26, 0x8049,  134 }, { 0x28, 0x004a,  140 }, { 0x2a, 0x804a,  146 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  264  	{ 0x2c, 0x004b,  152 }, { 0x2e, 0x804b,  159 }, { 0x30, 0x004c,  166 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  265  	{ 0x32, 0x804c,  173 }, { 0x34, 0x004d,  181 }, { 0x36, 0x804d,  189 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  266  	{ 0x38, 0x004e,  198 }, { 0x3a, 0x804e,  206 }, { 0x3c, 0x004f,  215 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  267  	{ 0x3e, 0x804f,  225 }, { 0x40, 0x0050,  230 }, { 0x42, 0x8050,  235 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  268  	{ 0x44, 0x0051,  240 }, { 0x46, 0x8051,  245 }, { 0x48, 0x0052,  251 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  269  	{ 0x4a, 0x8052,  256 }, { 0x4c, 0x0053,  262 }, { 0x4e, 0x8053,  268 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  270  	{ 0x50, 0x0054,  273 }, { 0x52, 0x8054,  279 }, { 0x54, 0x0055,  286 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  271  	{ 0x56, 0x8055,  292 }, { 0x58, 0x0056,  298 }, { 0x5a, 0x8056,  305 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  272  	{ 0x5c, 0x0057,  311 }, { 0x5e, 0x8057,  318 }, { 0x60, 0x0058,  325 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  273  	{ 0x62, 0x8058,  332 }, { 0x64, 0x0059,  340 }, { 0x66, 0x8059,  347 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  274  	{ 0x68, 0x005a,  355 }, { 0x6a, 0x805a,  362 }, { 0x6c, 0x005b,  370 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  275  	{ 0x6e, 0x805b,  378 }, { 0x70, 0x005c,  387 }, { 0x72, 0x805c,  395 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  276  	{ 0x74, 0x005d,  404 }, { 0x76, 0x805d,  413 }, { 0x78, 0x005e,  422 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  277  	{ 0x7a, 0x805e,  431 }, { 0x7c, 0x005f,  440 }, { 0x7e, 0x805f,  450 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  278  	{ 0x80, 0x0060,  460 }, { 0x82, 0x8060,  470 }, { 0x84, 0x0061,  480 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  279  	{ 0x86, 0x8061,  491 }, { 0x88, 0x0062,  501 }, { 0x8a, 0x8062,  512 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  280  	{ 0x8c, 0x0063,  524 }, { 0x8e, 0x8063,  535 }, { 0x90, 0x0064,  547 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  281  	{ 0x92, 0x8064,  559 }, { 0x94, 0x0065,  571 }, { 0x96, 0x8065,  584 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  282  	{ 0x98, 0x0066,  596 }, { 0x9a, 0x8066,  609 }, { 0x9c, 0x0067,  623 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  283  	{ 0x9e, 0x8067,  636 }, { 0xa0, 0x0068,  650 }, { 0xa2, 0x8068,  665 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  284  	{ 0xa4, 0x0069,  679 }, { 0xa6, 0x8069,  694 }, { 0xa8, 0x006a,  709 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  285  	{ 0xaa, 0x806a,  725 }, { 0xac, 0x006b,  741 }, { 0xae, 0x806b,  757 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  286  	{ 0xb0, 0x006c,  773 }, { 0xb2, 0x806c,  790 }, { 0xb4, 0x006d,  808 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  287  	{ 0xb6, 0x806d,  825 }, { 0xb8, 0x006e,  843 }, { 0xba, 0x806e,  862 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  288  	{ 0xbc, 0x006f,  881 }, { 0xbe, 0x806f,  900 }, { 0xc0, 0x0070,  920 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  289  	{ 0xc2, 0x8070,  940 }, { 0xc4, 0x0071,  960 }, { 0xc6, 0x8071,  981 },
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  290  	{ 0xc8, 0x0072, joycon_max_rumble_amp }
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  291  };
c4eae84feff3e6 Daniel J. Ogorchock 2021-09-11  292  

:::::: The code at line 196 was first introduced by commit
:::::: c4eae84feff3e68c2f385aa10faea4a96791e7ad HID: nintendo: add rumble support

:::::: TO: Daniel J. Ogorchock <djogorchock@gmail.com>
:::::: CC: Jiri Kosina <jkosina@suse.cz>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--IS0zKkzwUGydFO0o
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
1qKdAgA=

--IS0zKkzwUGydFO0o--
