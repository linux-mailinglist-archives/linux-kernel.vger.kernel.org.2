Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2398332C151
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838522AbhCCTAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 14:00:43 -0500
Received: from mga11.intel.com ([192.55.52.93]:1156 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1580275AbhCCSdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 13:33:42 -0500
IronPort-SDR: JT4NHxFBMCJs4fAguSFGnoWB5QZ88PpgufQBlGfwlRHBTyyzbzjxrWfQrKKVoR13l2OFBOLdfB
 7wt3Uodgelqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="183875254"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="gz'50?scan'50,208,50";a="183875254"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 10:32:58 -0800
IronPort-SDR: Rd9fZ8zwH1hALBIY3C5QbVY4MjmYJ7pNKfYjQ8/peqTWdYdKPX5y1ux7Pr7kaQ06gW2Y4SjUcU
 QLgJ8131TGMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="gz'50?scan'50,208,50";a="436073807"
Received: from lkp-server02.sh.intel.com (HELO 2482ff9f8ac0) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 03 Mar 2021 10:32:24 -0800
Received: from kbuild by 2482ff9f8ac0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lHWI9-0001fB-4Z; Wed, 03 Mar 2021 18:32:13 +0000
Date:   Thu, 4 Mar 2021 02:31:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/misc/altera-stapl/altera.c:2113:1: warning: the frame size
 of 4232 bytes is larger than 1024 bytes
Message-ID: <202103040218.QD7gYKSn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Guo,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f69d02e37a85645aa90d18cacfff36dba370f797
commit: 18c07d23da5a48525b2955aa269b8bb108c19300 csky: Fixup calltrace panic
date:   10 months ago
config: csky-randconfig-r035-20210303 (attached as .config)
compiler: csky-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=18c07d23da5a48525b2955aa269b8bb108c19300
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 18c07d23da5a48525b2955aa269b8bb108c19300
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=csky 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/misc/altera-stapl/altera.c: In function 'altera_execute':
>> drivers/misc/altera-stapl/altera.c:2113:1: warning: the frame size of 4232 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    2113 | }
         | ^


vim +2113 drivers/misc/altera-stapl/altera.c

fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   203  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   204  static int altera_execute(struct altera_state *astate,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   205  				u8 *p,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   206  				s32 program_size,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   207  				s32 *error_address,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   208  				int *exit_code,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   209  				int *format_version)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   210  {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   211  	struct altera_config *aconf = astate->config;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   212  	char *msg_buff = astate->msg_buff;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   213  	long *stack = astate->stack;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   214  	int status = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   215  	u32 first_word = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   216  	u32 action_table = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   217  	u32 proc_table = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   218  	u32 str_table = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   219  	u32 sym_table = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   220  	u32 data_sect = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   221  	u32 code_sect = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   222  	u32 debug_sect = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   223  	u32 action_count = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   224  	u32 proc_count = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   225  	u32 sym_count = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   226  	long *vars = NULL;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   227  	s32 *var_size = NULL;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   228  	char *attrs = NULL;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   229  	u8 *proc_attributes = NULL;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   230  	u32 pc;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   231  	u32 opcode_address;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   232  	u32 args[3];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   233  	u32 opcode;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   234  	u32 name_id;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   235  	u8 charbuf[4];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   236  	long long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   237  	u32 variable_id;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   238  	u8 *charptr_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   239  	u8 *charptr_tmp2;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   240  	long *longptr_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   241  	int version = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   242  	int delta = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   243  	int stack_ptr = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   244  	u32 arg_count;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   245  	int done = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   246  	int bad_opcode = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   247  	u32 count;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   248  	u32 index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   249  	u32 index2;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   250  	s32 long_count;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   251  	s32 long_idx;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   252  	s32 long_idx2;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   253  	u32 i;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   254  	u32 j;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   255  	u32 uncomp_size;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   256  	u32 offset;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   257  	u32 value;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   258  	int current_proc = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   259  	int reverse;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   260  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   261  	char *name;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   262  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   263  	dprintk("%s\n", __func__);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   264  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   265  	/* Read header information */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   266  	if (program_size > 52L) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   267  		first_word    = get_unaligned_be32(&p[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   268  		version = (first_word & 1L);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   269  		*format_version = version + 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   270  		delta = version * 8;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   271  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   272  		action_table  = get_unaligned_be32(&p[4]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   273  		proc_table    = get_unaligned_be32(&p[8]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   274  		str_table  = get_unaligned_be32(&p[4 + delta]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   275  		sym_table  = get_unaligned_be32(&p[16 + delta]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   276  		data_sect  = get_unaligned_be32(&p[20 + delta]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   277  		code_sect  = get_unaligned_be32(&p[24 + delta]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   278  		debug_sect = get_unaligned_be32(&p[28 + delta]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   279  		action_count  = get_unaligned_be32(&p[40 + delta]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   280  		proc_count    = get_unaligned_be32(&p[44 + delta]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   281  		sym_count  = get_unaligned_be32(&p[48 + (2 * delta)]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   282  	}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   283  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   284  	if ((first_word != 0x4A414D00L) && (first_word != 0x4A414D01L)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   285  		done = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   286  		status = -EIO;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   287  		goto exit_done;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   288  	}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   289  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   290  	if (sym_count <= 0)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   291  		goto exit_done;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   292  
6396bb221514d28 drivers/misc/altera-stapl/altera.c    Kees Cook         2018-06-12   293  	vars = kcalloc(sym_count, sizeof(long), GFP_KERNEL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   294  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   295  	if (vars == NULL)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   296  		status = -ENOMEM;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   297  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   298  	if (status == 0) {
6396bb221514d28 drivers/misc/altera-stapl/altera.c    Kees Cook         2018-06-12   299  		var_size = kcalloc(sym_count, sizeof(s32), GFP_KERNEL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   300  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   301  		if (var_size == NULL)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   302  			status = -ENOMEM;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   303  	}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   304  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   305  	if (status == 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   306  		attrs = kzalloc(sym_count, GFP_KERNEL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   307  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   308  		if (attrs == NULL)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   309  			status = -ENOMEM;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   310  	}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   311  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   312  	if ((status == 0) && (version > 0)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   313  		proc_attributes = kzalloc(proc_count, GFP_KERNEL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   314  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   315  		if (proc_attributes == NULL)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   316  			status = -ENOMEM;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   317  	}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   318  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   319  	if (status != 0)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   320  		goto exit_done;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   321  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   322  	delta = version * 2;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   323  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   324  	for (i = 0; i < sym_count; ++i) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   325  		offset = (sym_table + ((11 + delta) * i));
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   326  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   327  		value = get_unaligned_be32(&p[offset + 3 + delta]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   328  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   329  		attrs[i] = p[offset];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   330  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   331  		/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   332  		 * use bit 7 of attribute byte to indicate that
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   333  		 * this buffer was dynamically allocated
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   334  		 * and should be freed later
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   335  		 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   336  		attrs[i] &= 0x7f;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   337  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   338  		var_size[i] = get_unaligned_be32(&p[offset + 7 + delta]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   339  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   340  		/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   341  		 * Attribute bits:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   342  		 * bit 0: 0 = read-only, 1 = read-write
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   343  		 * bit 1: 0 = not compressed, 1 = compressed
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   344  		 * bit 2: 0 = not initialized, 1 = initialized
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   345  		 * bit 3: 0 = scalar, 1 = array
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   346  		 * bit 4: 0 = Boolean, 1 = integer
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   347  		 * bit 5: 0 = declared variable,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   348  		 *	1 = compiler created temporary variable
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   349  		 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   350  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   351  		if ((attrs[i] & 0x0c) == 0x04)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   352  			/* initialized scalar variable */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   353  			vars[i] = value;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   354  		else if ((attrs[i] & 0x1e) == 0x0e) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   355  			/* initialized compressed Boolean array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   356  			uncomp_size = get_unaligned_le32(&p[data_sect + value]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   357  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   358  			/* allocate a buffer for the uncompressed data */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   359  			vars[i] = (long)kzalloc(uncomp_size, GFP_KERNEL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   360  			if (vars[i] == 0L)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   361  				status = -ENOMEM;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   362  			else {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   363  				/* set flag so buffer will be freed later */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   364  				attrs[i] |= 0x80;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   365  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   366  				/* uncompress the data */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   367  				if (altera_shrink(&p[data_sect + value],
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   368  						var_size[i],
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   369  						(u8 *)vars[i],
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   370  						uncomp_size,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   371  						version) != uncomp_size)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   372  					/* decompression failed */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   373  					status = -EIO;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   374  				else
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   375  					var_size[i] = uncomp_size * 8L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   376  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   377  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   378  		} else if ((attrs[i] & 0x1e) == 0x0c) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   379  			/* initialized Boolean array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   380  			vars[i] = value + data_sect + (long)p;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   381  		} else if ((attrs[i] & 0x1c) == 0x1c) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   382  			/* initialized integer array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   383  			vars[i] = value + data_sect;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   384  		} else if ((attrs[i] & 0x0c) == 0x08) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   385  			/* uninitialized array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   386  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   387  			/* flag attrs so that memory is freed */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   388  			attrs[i] |= 0x80;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   389  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   390  			if (var_size[i] > 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   391  				u32 size;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   392  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   393  				if (attrs[i] & 0x10)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   394  					/* integer array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   395  					size = (var_size[i] * sizeof(s32));
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   396  				else
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   397  					/* Boolean array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   398  					size = ((var_size[i] + 7L) / 8L);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   399  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   400  				vars[i] = (long)kzalloc(size, GFP_KERNEL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   401  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   402  				if (vars[i] == 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   403  					status = -ENOMEM;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   404  				} else {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   405  					/* zero out memory */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   406  					for (j = 0; j < size; ++j)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   407  						((u8 *)(vars[i]))[j] = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   408  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   409  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   410  			} else
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   411  				vars[i] = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   412  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   413  		} else
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   414  			vars[i] = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   415  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   416  	}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   417  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   418  exit_done:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   419  	if (status != 0)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   420  		done = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   421  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   422  	altera_jinit(astate);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   423  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   424  	pc = code_sect;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   425  	msg_buff[0] = '\0';
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   426  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   427  	/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   428  	 * For JBC version 2, we will execute the procedures corresponding to
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   429  	 * the selected ACTION
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   430  	 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   431  	if (version > 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   432  		if (aconf->action == NULL) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   433  			status = -EINVAL;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   434  			done = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   435  		} else {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   436  			int action_found = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   437  			for (i = 0; (i < action_count) && !action_found; ++i) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   438  				name_id = get_unaligned_be32(&p[action_table +
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   439  								(12 * i)]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   440  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   441  				name = &p[str_table + name_id];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   442  
30614cf34105c5b drivers/misc/altera-stapl/altera.c    Rasmus Villemoes  2014-10-13   443  				if (strncasecmp(aconf->action, name, strlen(name)) == 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   444  					action_found = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   445  					current_proc =
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   446  						get_unaligned_be32(&p[action_table +
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   447  								(12 * i) + 8]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   448  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   449  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   450  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   451  			if (!action_found) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   452  				status = -EINVAL;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   453  				done = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   454  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   455  		}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   456  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   457  		if (status == 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   458  			int first_time = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   459  			i = current_proc;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   460  			while ((i != 0) || first_time) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   461  				first_time = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   462  				/* check procedure attribute byte */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   463  				proc_attributes[i] =
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   464  						(p[proc_table +
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   465  								(13 * i) + 8] &
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   466  									0x03);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   467  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   468  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   469  				 * BIT0 - OPTIONAL
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   470  				 * BIT1 - RECOMMENDED
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   471  				 * BIT6 - FORCED OFF
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   472  				 * BIT7 - FORCED ON
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   473  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   474  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   475  				i = get_unaligned_be32(&p[proc_table +
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   476  							(13 * i) + 4]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   477  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   478  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   479  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   480  			 * Set current_proc to the first procedure
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   481  			 * to be executed
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   482  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   483  			i = current_proc;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   484  			while ((i != 0) &&
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   485  				((proc_attributes[i] == 1) ||
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   486  				((proc_attributes[i] & 0xc0) == 0x40))) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   487  				i = get_unaligned_be32(&p[proc_table +
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   488  							(13 * i) + 4]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   489  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   490  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   491  			if ((i != 0) || ((i == 0) && (current_proc == 0) &&
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   492  				((proc_attributes[0] != 1) &&
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   493  				((proc_attributes[0] & 0xc0) != 0x40)))) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   494  				current_proc = i;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   495  				pc = code_sect +
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   496  					get_unaligned_be32(&p[proc_table +
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   497  								(13 * i) + 9]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   498  				if ((pc < code_sect) || (pc >= debug_sect))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   499  					status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   500  			} else
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   501  				/* there are no procedures to execute! */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   502  				done = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   503  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   504  		}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   505  	}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   506  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   507  	msg_buff[0] = '\0';
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   508  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   509  	while (!done) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   510  		opcode = (p[pc] & 0xff);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   511  		opcode_address = pc;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   512  		++pc;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   513  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   514  		if (debug > 1)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   515  			printk("opcode: %02x\n", opcode);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   516  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   517  		arg_count = (opcode >> 6) & 3;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   518  		for (i = 0; i < arg_count; ++i) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   519  			args[i] = get_unaligned_be32(&p[pc]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   520  			pc += 4;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   521  		}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   522  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   523  		switch (opcode) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   524  		case OP_NOP:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   525  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   526  		case OP_DUP:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   527  			if (altera_check_stack(stack_ptr, 1, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   528  				stack[stack_ptr] = stack[stack_ptr - 1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   529  				++stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   530  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   531  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   532  		case OP_SWP:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   533  			if (altera_check_stack(stack_ptr, 2, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   534  				long_tmp = stack[stack_ptr - 2];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   535  				stack[stack_ptr - 2] = stack[stack_ptr - 1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   536  				stack[stack_ptr - 1] = long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   537  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   538  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   539  		case OP_ADD:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   540  			if (altera_check_stack(stack_ptr, 2, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   541  				--stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   542  				stack[stack_ptr - 1] += stack[stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   543  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   544  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   545  		case OP_SUB:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   546  			if (altera_check_stack(stack_ptr, 2, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   547  				--stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   548  				stack[stack_ptr - 1] -= stack[stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   549  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   550  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   551  		case OP_MULT:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   552  			if (altera_check_stack(stack_ptr, 2, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   553  				--stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   554  				stack[stack_ptr - 1] *= stack[stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   555  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   556  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   557  		case OP_DIV:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   558  			if (altera_check_stack(stack_ptr, 2, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   559  				--stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   560  				stack[stack_ptr - 1] /= stack[stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   561  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   562  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   563  		case OP_MOD:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   564  			if (altera_check_stack(stack_ptr, 2, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   565  				--stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   566  				stack[stack_ptr - 1] %= stack[stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   567  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   568  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   569  		case OP_SHL:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   570  			if (altera_check_stack(stack_ptr, 2, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   571  				--stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   572  				stack[stack_ptr - 1] <<= stack[stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   573  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   574  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   575  		case OP_SHR:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   576  			if (altera_check_stack(stack_ptr, 2, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   577  				--stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   578  				stack[stack_ptr - 1] >>= stack[stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   579  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   580  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   581  		case OP_NOT:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   582  			if (altera_check_stack(stack_ptr, 1, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   583  				stack[stack_ptr - 1] ^= (-1L);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   584  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   585  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   586  		case OP_AND:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   587  			if (altera_check_stack(stack_ptr, 2, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   588  				--stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   589  				stack[stack_ptr - 1] &= stack[stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   590  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   591  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   592  		case OP_OR:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   593  			if (altera_check_stack(stack_ptr, 2, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   594  				--stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   595  				stack[stack_ptr - 1] |= stack[stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   596  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   597  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   598  		case OP_XOR:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   599  			if (altera_check_stack(stack_ptr, 2, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   600  				--stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   601  				stack[stack_ptr - 1] ^= stack[stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   602  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   603  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   604  		case OP_INV:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   605  			if (!altera_check_stack(stack_ptr, 1, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   606  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   607  			stack[stack_ptr - 1] = stack[stack_ptr - 1] ? 0L : 1L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   608  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   609  		case OP_GT:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   610  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   611  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   612  			--stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   613  			stack[stack_ptr - 1] =
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   614  				(stack[stack_ptr - 1] > stack[stack_ptr]) ?
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   615  									1L : 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   616  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   617  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   618  		case OP_LT:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   619  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   620  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   621  			--stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   622  			stack[stack_ptr - 1] =
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   623  				(stack[stack_ptr - 1] < stack[stack_ptr]) ?
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   624  									1L : 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   625  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   626  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   627  		case OP_RET:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   628  			if ((version > 0) && (stack_ptr == 0)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   629  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   630  				 * We completed one of the main procedures
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   631  				 * of an ACTION.
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   632  				 * Find the next procedure
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   633  				 * to be executed and jump to it.
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   634  				 * If there are no more procedures, then EXIT.
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   635  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   636  				i = get_unaligned_be32(&p[proc_table +
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   637  						(13 * current_proc) + 4]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   638  				while ((i != 0) &&
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   639  					((proc_attributes[i] == 1) ||
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   640  					((proc_attributes[i] & 0xc0) == 0x40)))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   641  					i = get_unaligned_be32(&p[proc_table +
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   642  								(13 * i) + 4]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   643  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   644  				if (i == 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   645  					/* no procedures to execute! */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   646  					done = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   647  					*exit_code = 0;	/* success */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   648  				} else {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   649  					current_proc = i;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   650  					pc = code_sect + get_unaligned_be32(
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   651  								&p[proc_table +
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   652  								(13 * i) + 9]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   653  					if ((pc < code_sect) ||
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   654  					    (pc >= debug_sect))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   655  						status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   656  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   657  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   658  			} else
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   659  				if (altera_check_stack(stack_ptr, 1, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   660  					pc = stack[--stack_ptr] + code_sect;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   661  					if ((pc <= code_sect) ||
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   662  					    (pc >= debug_sect))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   663  						status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   664  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   665  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   666  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   667  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   668  		case OP_CMPS:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   669  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   670  			 * Array short compare
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   671  			 * ...stack 0 is source 1 value
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   672  			 * ...stack 1 is source 2 value
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   673  			 * ...stack 2 is mask value
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   674  			 * ...stack 3 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   675  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   676  			if (altera_check_stack(stack_ptr, 4, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   677  				s32 a = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   678  				s32 b = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   679  				long_tmp = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   680  				count = stack[stack_ptr - 1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   681  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   682  				if ((count < 1) || (count > 32))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   683  					status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   684  				else {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   685  					long_tmp &= ((-1L) >> (32 - count));
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   686  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   687  					stack[stack_ptr - 1] =
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   688  					((a & long_tmp) == (b & long_tmp))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   689  								? 1L : 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   690  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   691  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   692  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   693  		case OP_PINT:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   694  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   695  			 * PRINT add integer
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   696  			 * ...stack 0 is integer value
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   697  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   698  			if (!altera_check_stack(stack_ptr, 1, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   699  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   700  			sprintf(&msg_buff[strlen(msg_buff)],
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   701  					"%ld", stack[--stack_ptr]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   702  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   703  		case OP_PRNT:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   704  			/* PRINT finish */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   705  			if (debug)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   706  				printk(msg_buff, "\n");
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   707  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   708  			msg_buff[0] = '\0';
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   709  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   710  		case OP_DSS:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   711  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   712  			 * DRSCAN short
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   713  			 * ...stack 0 is scan data
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   714  			 * ...stack 1 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   715  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   716  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   717  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   718  			long_tmp = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   719  			count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   720  			put_unaligned_le32(long_tmp, &charbuf[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   721  			status = altera_drscan(astate, count, charbuf, 0);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   722  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   723  		case OP_DSSC:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   724  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   725  			 * DRSCAN short with capture
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   726  			 * ...stack 0 is scan data
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   727  			 * ...stack 1 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   728  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   729  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   730  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   731  			long_tmp = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   732  			count = stack[stack_ptr - 1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   733  			put_unaligned_le32(long_tmp, &charbuf[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   734  			status = altera_swap_dr(astate, count, charbuf,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   735  							0, charbuf, 0);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   736  			stack[stack_ptr - 1] = get_unaligned_le32(&charbuf[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   737  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   738  		case OP_ISS:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   739  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   740  			 * IRSCAN short
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   741  			 * ...stack 0 is scan data
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   742  			 * ...stack 1 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   743  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   744  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   745  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   746  			long_tmp = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   747  			count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   748  			put_unaligned_le32(long_tmp, &charbuf[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   749  			status = altera_irscan(astate, count, charbuf, 0);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   750  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   751  		case OP_ISSC:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   752  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   753  			 * IRSCAN short with capture
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   754  			 * ...stack 0 is scan data
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   755  			 * ...stack 1 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   756  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   757  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   758  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   759  			long_tmp = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   760  			count = stack[stack_ptr - 1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   761  			put_unaligned_le32(long_tmp, &charbuf[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   762  			status = altera_swap_ir(astate, count, charbuf,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   763  							0, charbuf, 0);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   764  			stack[stack_ptr - 1] = get_unaligned_le32(&charbuf[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   765  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   766  		case OP_DPR:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   767  			if (!altera_check_stack(stack_ptr, 1, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   768  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   769  			count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   770  			status = altera_set_dr_pre(&astate->js, count, 0, NULL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   771  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   772  		case OP_DPRL:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   773  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   774  			 * DRPRE with literal data
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   775  			 * ...stack 0 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   776  			 * ...stack 1 is literal data
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   777  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   778  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   779  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   780  			count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   781  			long_tmp = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   782  			put_unaligned_le32(long_tmp, &charbuf[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   783  			status = altera_set_dr_pre(&astate->js, count, 0,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   784  						charbuf);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   785  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   786  		case OP_DPO:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   787  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   788  			 * DRPOST
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   789  			 * ...stack 0 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   790  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   791  			if (altera_check_stack(stack_ptr, 1, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   792  				count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   793  				status = altera_set_dr_post(&astate->js, count,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   794  								0, NULL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   795  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   796  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   797  		case OP_DPOL:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   798  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   799  			 * DRPOST with literal data
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   800  			 * ...stack 0 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   801  			 * ...stack 1 is literal data
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   802  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   803  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   804  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   805  			count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   806  			long_tmp = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   807  			put_unaligned_le32(long_tmp, &charbuf[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   808  			status = altera_set_dr_post(&astate->js, count, 0,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   809  							charbuf);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   810  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   811  		case OP_IPR:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   812  			if (altera_check_stack(stack_ptr, 1, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   813  				count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   814  				status = altera_set_ir_pre(&astate->js, count,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   815  								0, NULL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   816  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   817  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   818  		case OP_IPRL:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   819  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   820  			 * IRPRE with literal data
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   821  			 * ...stack 0 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   822  			 * ...stack 1 is literal data
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   823  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   824  			if (altera_check_stack(stack_ptr, 2, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   825  				count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   826  				long_tmp = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   827  				put_unaligned_le32(long_tmp, &charbuf[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   828  				status = altera_set_ir_pre(&astate->js, count,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   829  							0, charbuf);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   830  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   831  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   832  		case OP_IPO:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   833  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   834  			 * IRPOST
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   835  			 * ...stack 0 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   836  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   837  			if (altera_check_stack(stack_ptr, 1, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   838  				count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   839  				status = altera_set_ir_post(&astate->js, count,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   840  							0, NULL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   841  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   842  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   843  		case OP_IPOL:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   844  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   845  			 * IRPOST with literal data
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   846  			 * ...stack 0 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   847  			 * ...stack 1 is literal data
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   848  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   849  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   850  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   851  			count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   852  			long_tmp = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   853  			put_unaligned_le32(long_tmp, &charbuf[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   854  			status = altera_set_ir_post(&astate->js, count, 0,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   855  							charbuf);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   856  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   857  		case OP_PCHR:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   858  			if (altera_check_stack(stack_ptr, 1, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   859  				u8 ch;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   860  				count = strlen(msg_buff);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   861  				ch = (char) stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   862  				if ((ch < 1) || (ch > 127)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   863  					/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   864  					 * character code out of range
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   865  					 * instead of flagging an error,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   866  					 * force the value to 127
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   867  					 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   868  					ch = 127;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   869  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   870  				msg_buff[count] = ch;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   871  				msg_buff[count + 1] = '\0';
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   872  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   873  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   874  		case OP_EXIT:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   875  			if (altera_check_stack(stack_ptr, 1, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   876  				*exit_code = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   877  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   878  			done = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   879  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   880  		case OP_EQU:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   881  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   882  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   883  			--stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   884  			stack[stack_ptr - 1] =
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   885  				(stack[stack_ptr - 1] == stack[stack_ptr]) ?
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   886  									1L : 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   887  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   888  		case OP_POPT:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   889  			if (altera_check_stack(stack_ptr, 1, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   890  				--stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   891  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   892  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   893  		case OP_ABS:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   894  			if (!altera_check_stack(stack_ptr, 1, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   895  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   896  			if (stack[stack_ptr - 1] < 0)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   897  				stack[stack_ptr - 1] = 0 - stack[stack_ptr - 1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   898  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   899  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   900  		case OP_BCH0:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   901  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   902  			 * Batch operation 0
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   903  			 * SWP
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   904  			 * SWPN 7
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   905  			 * SWP
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   906  			 * SWPN 6
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   907  			 * DUPN 8
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   908  			 * SWPN 2
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   909  			 * SWP
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   910  			 * DUPN 6
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   911  			 * DUPN 6
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   912  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   913  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   914  			/* SWP  */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   915  			if (altera_check_stack(stack_ptr, 2, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   916  				long_tmp = stack[stack_ptr - 2];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   917  				stack[stack_ptr - 2] = stack[stack_ptr - 1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   918  				stack[stack_ptr - 1] = long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   919  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   920  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   921  			/* SWPN 7 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   922  			index = 7 + 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   923  			if (altera_check_stack(stack_ptr, index, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   924  				long_tmp = stack[stack_ptr - index];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   925  				stack[stack_ptr - index] = stack[stack_ptr - 1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   926  				stack[stack_ptr - 1] = long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   927  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   928  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   929  			/* SWP  */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   930  			if (altera_check_stack(stack_ptr, 2, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   931  				long_tmp = stack[stack_ptr - 2];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   932  				stack[stack_ptr - 2] = stack[stack_ptr - 1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   933  				stack[stack_ptr - 1] = long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   934  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   935  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   936  			/* SWPN 6 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   937  			index = 6 + 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   938  			if (altera_check_stack(stack_ptr, index, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   939  				long_tmp = stack[stack_ptr - index];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   940  				stack[stack_ptr - index] = stack[stack_ptr - 1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   941  				stack[stack_ptr - 1] = long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   942  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   943  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   944  			/* DUPN 8 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   945  			index = 8 + 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   946  			if (altera_check_stack(stack_ptr, index, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   947  				stack[stack_ptr] = stack[stack_ptr - index];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   948  				++stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   949  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   950  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   951  			/* SWPN 2 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   952  			index = 2 + 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   953  			if (altera_check_stack(stack_ptr, index, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   954  				long_tmp = stack[stack_ptr - index];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   955  				stack[stack_ptr - index] = stack[stack_ptr - 1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   956  				stack[stack_ptr - 1] = long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   957  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   958  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   959  			/* SWP  */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   960  			if (altera_check_stack(stack_ptr, 2, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   961  				long_tmp = stack[stack_ptr - 2];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   962  				stack[stack_ptr - 2] = stack[stack_ptr - 1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   963  				stack[stack_ptr - 1] = long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   964  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   965  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   966  			/* DUPN 6 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   967  			index = 6 + 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   968  			if (altera_check_stack(stack_ptr, index, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   969  				stack[stack_ptr] = stack[stack_ptr - index];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   970  				++stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   971  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   972  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   973  			/* DUPN 6 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   974  			index = 6 + 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   975  			if (altera_check_stack(stack_ptr, index, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   976  				stack[stack_ptr] = stack[stack_ptr - index];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   977  				++stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   978  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   979  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   980  		case OP_PSH0:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   981  			stack[stack_ptr++] = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   982  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   983  		case OP_PSHL:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   984  			stack[stack_ptr++] = (s32) args[0];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   985  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   986  		case OP_PSHV:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   987  			stack[stack_ptr++] = vars[args[0]];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   988  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   989  		case OP_JMP:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   990  			pc = args[0] + code_sect;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   991  			if ((pc < code_sect) || (pc >= debug_sect))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   992  				status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   993  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   994  		case OP_CALL:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   995  			stack[stack_ptr++] = pc;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   996  			pc = args[0] + code_sect;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   997  			if ((pc < code_sect) || (pc >= debug_sect))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   998  				status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25   999  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1000  		case OP_NEXT:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1001  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1002  			 * Process FOR / NEXT loop
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1003  			 * ...argument 0 is variable ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1004  			 * ...stack 0 is step value
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1005  			 * ...stack 1 is end value
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1006  			 * ...stack 2 is top address
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1007  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1008  			if (altera_check_stack(stack_ptr, 3, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1009  				s32 step = stack[stack_ptr - 1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1010  				s32 end = stack[stack_ptr - 2];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1011  				s32 top = stack[stack_ptr - 3];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1012  				s32 iterator = vars[args[0]];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1013  				int break_out = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1014  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1015  				if (step < 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1016  					if (iterator <= end)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1017  						break_out = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1018  				} else if (iterator >= end)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1019  					break_out = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1020  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1021  				if (break_out) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1022  					stack_ptr -= 3;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1023  				} else {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1024  					vars[args[0]] = iterator + step;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1025  					pc = top + code_sect;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1026  					if ((pc < code_sect) ||
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1027  					    (pc >= debug_sect))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1028  						status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1029  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1030  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1031  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1032  		case OP_PSTR:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1033  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1034  			 * PRINT add string
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1035  			 * ...argument 0 is string ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1036  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1037  			count = strlen(msg_buff);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1038  			strlcpy(&msg_buff[count],
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1039  				&p[str_table + args[0]],
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1040  				ALTERA_MESSAGE_LENGTH - count);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1041  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1042  		case OP_SINT:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1043  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1044  			 * STATE intermediate state
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1045  			 * ...argument 0 is state code
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1046  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1047  			status = altera_goto_jstate(astate, args[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1048  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1049  		case OP_ST:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1050  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1051  			 * STATE final state
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1052  			 * ...argument 0 is state code
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1053  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1054  			status = altera_goto_jstate(astate, args[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1055  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1056  		case OP_ISTP:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1057  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1058  			 * IRSTOP state
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1059  			 * ...argument 0 is state code
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1060  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1061  			status = altera_set_irstop(&astate->js, args[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1062  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1063  		case OP_DSTP:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1064  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1065  			 * DRSTOP state
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1066  			 * ...argument 0 is state code
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1067  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1068  			status = altera_set_drstop(&astate->js, args[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1069  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1070  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1071  		case OP_SWPN:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1072  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1073  			 * Exchange top with Nth stack value
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1074  			 * ...argument 0 is 0-based stack entry
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1075  			 * to swap with top element
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1076  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1077  			index = (args[0]) + 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1078  			if (altera_check_stack(stack_ptr, index, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1079  				long_tmp = stack[stack_ptr - index];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1080  				stack[stack_ptr - index] = stack[stack_ptr - 1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1081  				stack[stack_ptr - 1] = long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1082  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1083  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1084  		case OP_DUPN:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1085  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1086  			 * Duplicate Nth stack value
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1087  			 * ...argument 0 is 0-based stack entry to duplicate
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1088  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1089  			index = (args[0]) + 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1090  			if (altera_check_stack(stack_ptr, index, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1091  				stack[stack_ptr] = stack[stack_ptr - index];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1092  				++stack_ptr;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1093  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1094  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1095  		case OP_POPV:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1096  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1097  			 * Pop stack into scalar variable
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1098  			 * ...argument 0 is variable ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1099  			 * ...stack 0 is value
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1100  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1101  			if (altera_check_stack(stack_ptr, 1, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1102  				vars[args[0]] = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1103  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1104  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1105  		case OP_POPE:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1106  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1107  			 * Pop stack into integer array element
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1108  			 * ...argument 0 is variable ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1109  			 * ...stack 0 is array index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1110  			 * ...stack 1 is value
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1111  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1112  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1113  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1114  			variable_id = args[0];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1115  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1116  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1117  			 * If variable is read-only,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1118  			 * convert to writable array
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1119  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1120  			if ((version > 0) &&
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1121  				((attrs[variable_id] & 0x9c) == 0x1c)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1122  				/* Allocate a writable buffer for this array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1123  				count = var_size[variable_id];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1124  				long_tmp = vars[variable_id];
6396bb221514d28 drivers/misc/altera-stapl/altera.c    Kees Cook         2018-06-12  1125  				longptr_tmp = kcalloc(count, sizeof(long),
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1126  								GFP_KERNEL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1127  				vars[variable_id] = (long)longptr_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1128  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1129  				if (vars[variable_id] == 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1130  					status = -ENOMEM;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1131  					break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1132  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1133  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1134  				/* copy previous contents into buffer */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1135  				for (i = 0; i < count; ++i) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1136  					longptr_tmp[i] =
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1137  						get_unaligned_be32(&p[long_tmp]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1138  					long_tmp += sizeof(long);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1139  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1140  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1141  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1142  				 * set bit 7 - buffer was
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1143  				 * dynamically allocated
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1144  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1145  				attrs[variable_id] |= 0x80;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1146  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1147  				/* clear bit 2 - variable is writable */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1148  				attrs[variable_id] &= ~0x04;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1149  				attrs[variable_id] |= 0x01;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1150  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1151  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1152  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1153  			/* check that variable is a writable integer array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1154  			if ((attrs[variable_id] & 0x1c) != 0x18)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1155  				status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1156  			else {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1157  				longptr_tmp = (long *)vars[variable_id];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1158  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1159  				/* pop the array index */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1160  				index = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1161  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1162  				/* pop the value and store it into the array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1163  				longptr_tmp[index] = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1164  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1165  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1166  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1167  		case OP_POPA:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1168  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1169  			 * Pop stack into Boolean array
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1170  			 * ...argument 0 is variable ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1171  			 * ...stack 0 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1172  			 * ...stack 1 is array index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1173  			 * ...stack 2 is value
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1174  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1175  			if (!altera_check_stack(stack_ptr, 3, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1176  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1177  			variable_id = args[0];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1178  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1179  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1180  			 * If variable is read-only,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1181  			 * convert to writable array
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1182  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1183  			if ((version > 0) &&
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1184  				((attrs[variable_id] & 0x9c) == 0x0c)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1185  				/* Allocate a writable buffer for this array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1186  				long_tmp =
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1187  					(var_size[variable_id] + 7L) >> 3L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1188  				charptr_tmp2 = (u8 *)vars[variable_id];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1189  				charptr_tmp =
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1190  					kzalloc(long_tmp, GFP_KERNEL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1191  				vars[variable_id] = (long)charptr_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1192  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1193  				if (vars[variable_id] == 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1194  					status = -ENOMEM;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1195  					break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1196  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1197  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1198  				/* zero the buffer */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1199  				for (long_idx = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1200  					long_idx < long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1201  					++long_idx) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1202  					charptr_tmp[long_idx] = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1203  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1204  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1205  				/* copy previous contents into buffer */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1206  				for (long_idx = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1207  					long_idx < var_size[variable_id];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1208  					++long_idx) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1209  					long_idx2 = long_idx;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1210  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1211  					if (charptr_tmp2[long_idx2 >> 3] &
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1212  						(1 << (long_idx2 & 7))) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1213  						charptr_tmp[long_idx >> 3] |=
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1214  							(1 << (long_idx & 7));
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1215  					}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1216  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1217  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1218  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1219  				 * set bit 7 - buffer was
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1220  				 * dynamically allocated
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1221  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1222  				attrs[variable_id] |= 0x80;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1223  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1224  				/* clear bit 2 - variable is writable */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1225  				attrs[variable_id] &= ~0x04;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1226  				attrs[variable_id] |= 0x01;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1227  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1228  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1229  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1230  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1231  			 * check that variable is
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1232  			 * a writable Boolean array
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1233  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1234  			if ((attrs[variable_id] & 0x1c) != 0x08) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1235  				status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1236  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1237  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1238  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1239  			charptr_tmp = (u8 *)vars[variable_id];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1240  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1241  			/* pop the count (number of bits to copy) */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1242  			long_count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1243  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1244  			/* pop the array index */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1245  			long_idx = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1246  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1247  			reverse = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1248  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1249  			if (version > 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1250  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1251  				 * stack 0 = array right index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1252  				 * stack 1 = array left index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1253  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1254  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1255  				if (long_idx > long_count) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1256  					reverse = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1257  					long_tmp = long_count;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1258  					long_count = 1 + long_idx -
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1259  								long_count;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1260  					long_idx = long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1261  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1262  					/* reverse POPA is not supported */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1263  					status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1264  					break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1265  				} else
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1266  					long_count = 1 + long_count -
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1267  								long_idx;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1268  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1269  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1270  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1271  			/* pop the data */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1272  			long_tmp = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1273  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1274  			if (long_count < 1) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1275  				status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1276  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1277  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1278  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1279  			for (i = 0; i < long_count; ++i) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1280  				if (long_tmp & (1L << (s32) i))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1281  					charptr_tmp[long_idx >> 3L] |=
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1282  						(1L << (long_idx & 7L));
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1283  				else
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1284  					charptr_tmp[long_idx >> 3L] &=
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1285  						~(1L << (long_idx & 7L));
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1286  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1287  				++long_idx;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1288  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1289  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1290  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1291  		case OP_JMPZ:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1292  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1293  			 * Pop stack and branch if zero
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1294  			 * ...argument 0 is address
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1295  			 * ...stack 0 is condition value
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1296  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1297  			if (altera_check_stack(stack_ptr, 1, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1298  				if (stack[--stack_ptr] == 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1299  					pc = args[0] + code_sect;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1300  					if ((pc < code_sect) ||
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1301  					    (pc >= debug_sect))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1302  						status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1303  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1304  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1305  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1306  		case OP_DS:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1307  		case OP_IS:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1308  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1309  			 * DRSCAN
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1310  			 * IRSCAN
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1311  			 * ...argument 0 is scan data variable ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1312  			 * ...stack 0 is array index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1313  			 * ...stack 1 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1314  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1315  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1316  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1317  			long_idx = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1318  			long_count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1319  			reverse = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1320  			if (version > 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1321  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1322  				 * stack 0 = array right index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1323  				 * stack 1 = array left index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1324  				 * stack 2 = count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1325  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1326  				long_tmp = long_count;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1327  				long_count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1328  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1329  				if (long_idx > long_tmp) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1330  					reverse = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1331  					long_idx = long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1332  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1333  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1334  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1335  			charptr_tmp = (u8 *)vars[args[0]];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1336  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1337  			if (reverse) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1338  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1339  				 * allocate a buffer
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1340  				 * and reverse the data order
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1341  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1342  				charptr_tmp2 = charptr_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1343  				charptr_tmp = kzalloc((long_count >> 3) + 1,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1344  								GFP_KERNEL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1345  				if (charptr_tmp == NULL) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1346  					status = -ENOMEM;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1347  					break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1348  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1349  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1350  				long_tmp = long_idx + long_count - 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1351  				long_idx2 = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1352  				while (long_idx2 < long_count) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1353  					if (charptr_tmp2[long_tmp >> 3] &
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1354  							(1 << (long_tmp & 7)))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1355  						charptr_tmp[long_idx2 >> 3] |=
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1356  							(1 << (long_idx2 & 7));
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1357  					else
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1358  						charptr_tmp[long_idx2 >> 3] &=
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1359  							~(1 << (long_idx2 & 7));
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1360  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1361  					--long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1362  					++long_idx2;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1363  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1364  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1365  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1366  			if (opcode == 0x51) /* DS */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1367  				status = altera_drscan(astate, long_count,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1368  						charptr_tmp, long_idx);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1369  			else /* IS */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1370  				status = altera_irscan(astate, long_count,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1371  						charptr_tmp, long_idx);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1372  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1373  			if (reverse)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1374  				kfree(charptr_tmp);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1375  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1376  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1377  		case OP_DPRA:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1378  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1379  			 * DRPRE with array data
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1380  			 * ...argument 0 is variable ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1381  			 * ...stack 0 is array index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1382  			 * ...stack 1 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1383  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1384  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1385  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1386  			index = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1387  			count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1388  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1389  			if (version > 0)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1390  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1391  				 * stack 0 = array right index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1392  				 * stack 1 = array left index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1393  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1394  				count = 1 + count - index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1395  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1396  			charptr_tmp = (u8 *)vars[args[0]];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1397  			status = altera_set_dr_pre(&astate->js, count, index,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1398  							charptr_tmp);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1399  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1400  		case OP_DPOA:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1401  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1402  			 * DRPOST with array data
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1403  			 * ...argument 0 is variable ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1404  			 * ...stack 0 is array index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1405  			 * ...stack 1 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1406  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1407  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1408  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1409  			index = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1410  			count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1411  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1412  			if (version > 0)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1413  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1414  				 * stack 0 = array right index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1415  				 * stack 1 = array left index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1416  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1417  				count = 1 + count - index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1418  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1419  			charptr_tmp = (u8 *)vars[args[0]];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1420  			status = altera_set_dr_post(&astate->js, count, index,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1421  							charptr_tmp);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1422  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1423  		case OP_IPRA:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1424  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1425  			 * IRPRE with array data
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1426  			 * ...argument 0 is variable ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1427  			 * ...stack 0 is array index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1428  			 * ...stack 1 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1429  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1430  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1431  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1432  			index = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1433  			count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1434  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1435  			if (version > 0)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1436  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1437  				 * stack 0 = array right index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1438  				 * stack 1 = array left index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1439  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1440  				count = 1 + count - index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1441  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1442  			charptr_tmp = (u8 *)vars[args[0]];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1443  			status = altera_set_ir_pre(&astate->js, count, index,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1444  							charptr_tmp);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1445  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1446  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1447  		case OP_IPOA:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1448  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1449  			 * IRPOST with array data
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1450  			 * ...argument 0 is variable ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1451  			 * ...stack 0 is array index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1452  			 * ...stack 1 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1453  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1454  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1455  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1456  			index = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1457  			count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1458  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1459  			if (version > 0)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1460  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1461  				 * stack 0 = array right index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1462  				 * stack 1 = array left index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1463  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1464  				count = 1 + count - index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1465  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1466  			charptr_tmp = (u8 *)vars[args[0]];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1467  			status = altera_set_ir_post(&astate->js, count, index,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1468  							charptr_tmp);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1469  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1470  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1471  		case OP_EXPT:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1472  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1473  			 * EXPORT
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1474  			 * ...argument 0 is string ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1475  			 * ...stack 0 is integer expression
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1476  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1477  			if (altera_check_stack(stack_ptr, 1, &status)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1478  				name = &p[str_table + args[0]];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1479  				long_tmp = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1480  				altera_export_int(name, long_tmp);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1481  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1482  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1483  		case OP_PSHE:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1484  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1485  			 * Push integer array element
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1486  			 * ...argument 0 is variable ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1487  			 * ...stack 0 is array index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1488  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1489  			if (!altera_check_stack(stack_ptr, 1, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1490  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1491  			variable_id = args[0];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1492  			index = stack[stack_ptr - 1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1493  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1494  			/* check variable type */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1495  			if ((attrs[variable_id] & 0x1f) == 0x19) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1496  				/* writable integer array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1497  				longptr_tmp = (long *)vars[variable_id];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1498  				stack[stack_ptr - 1] = longptr_tmp[index];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1499  			} else if ((attrs[variable_id] & 0x1f) == 0x1c) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1500  				/* read-only integer array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1501  				long_tmp = vars[variable_id] +
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1502  						(index * sizeof(long));
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1503  				stack[stack_ptr - 1] =
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1504  					get_unaligned_be32(&p[long_tmp]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1505  			} else
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1506  				status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1507  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1508  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1509  		case OP_PSHA:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1510  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1511  			 * Push Boolean array
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1512  			 * ...argument 0 is variable ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1513  			 * ...stack 0 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1514  			 * ...stack 1 is array index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1515  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1516  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1517  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1518  			variable_id = args[0];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1519  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1520  			/* check that variable is a Boolean array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1521  			if ((attrs[variable_id] & 0x18) != 0x08) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1522  				status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1523  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1524  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1525  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1526  			charptr_tmp = (u8 *)vars[variable_id];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1527  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1528  			/* pop the count (number of bits to copy) */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1529  			count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1530  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1531  			/* pop the array index */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1532  			index = stack[stack_ptr - 1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1533  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1534  			if (version > 0)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1535  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1536  				 * stack 0 = array right index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1537  				 * stack 1 = array left index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1538  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1539  				count = 1 + count - index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1540  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1541  			if ((count < 1) || (count > 32)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1542  				status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1543  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1544  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1545  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1546  			long_tmp = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1547  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1548  			for (i = 0; i < count; ++i)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1549  				if (charptr_tmp[(i + index) >> 3] &
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1550  						(1 << ((i + index) & 7)))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1551  					long_tmp |= (1L << i);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1552  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1553  			stack[stack_ptr - 1] = long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1554  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1555  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1556  		case OP_DYNA:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1557  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1558  			 * Dynamically change size of array
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1559  			 * ...argument 0 is variable ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1560  			 * ...stack 0 is new size
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1561  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1562  			if (!altera_check_stack(stack_ptr, 1, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1563  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1564  			variable_id = args[0];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1565  			long_tmp = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1566  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1567  			if (long_tmp > var_size[variable_id]) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1568  				var_size[variable_id] = long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1569  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1570  				if (attrs[variable_id] & 0x10)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1571  					/* allocate integer array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1572  					long_tmp *= sizeof(long);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1573  				else
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1574  					/* allocate Boolean array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1575  					long_tmp = (long_tmp + 7) >> 3;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1576  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1577  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1578  				 * If the buffer was previously allocated,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1579  				 * free it
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1580  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1581  				if (attrs[variable_id] & 0x80) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1582  					kfree((void *)vars[variable_id]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1583  					vars[variable_id] = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1584  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1585  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1586  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1587  				 * Allocate a new buffer
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1588  				 * of the requested size
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1589  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1590  				vars[variable_id] = (long)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1591  					kzalloc(long_tmp, GFP_KERNEL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1592  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1593  				if (vars[variable_id] == 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1594  					status = -ENOMEM;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1595  					break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1596  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1597  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1598  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1599  				 * Set the attribute bit to indicate that
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1600  				 * this buffer was dynamically allocated and
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1601  				 * should be freed later
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1602  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1603  				attrs[variable_id] |= 0x80;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1604  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1605  				/* zero out memory */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1606  				count = ((var_size[variable_id] + 7L) /
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1607  									8L);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1608  				charptr_tmp = (u8 *)(vars[variable_id]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1609  				for (index = 0; index < count; ++index)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1610  					charptr_tmp[index] = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1611  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1612  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1613  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1614  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1615  		case OP_EXPV:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1616  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1617  			 * Export Boolean array
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1618  			 * ...argument 0 is string ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1619  			 * ...stack 0 is variable ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1620  			 * ...stack 1 is array right index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1621  			 * ...stack 2 is array left index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1622  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1623  			if (!altera_check_stack(stack_ptr, 3, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1624  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1625  			if (version == 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1626  				/* EXPV is not supported in JBC 1.0 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1627  				bad_opcode = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1628  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1629  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1630  			name = &p[str_table + args[0]];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1631  			variable_id = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1632  			long_idx = stack[--stack_ptr];/* right indx */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1633  			long_idx2 = stack[--stack_ptr];/* left indx */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1634  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1635  			if (long_idx > long_idx2) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1636  				/* reverse indices not supported */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1637  				status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1638  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1639  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1640  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1641  			long_count = 1 + long_idx2 - long_idx;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1642  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1643  			charptr_tmp = (u8 *)vars[variable_id];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1644  			charptr_tmp2 = NULL;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1645  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1646  			if ((long_idx & 7L) != 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1647  				s32 k = long_idx;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1648  				charptr_tmp2 =
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1649  					kzalloc(((long_count + 7L) / 8L),
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1650  							GFP_KERNEL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1651  				if (charptr_tmp2 == NULL) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1652  					status = -ENOMEM;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1653  					break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1654  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1655  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1656  				for (i = 0; i < long_count; ++i) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1657  					if (charptr_tmp[k >> 3] &
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1658  							(1 << (k & 7)))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1659  						charptr_tmp2[i >> 3] |=
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1660  								(1 << (i & 7));
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1661  					else
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1662  						charptr_tmp2[i >> 3] &=
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1663  								~(1 << (i & 7));
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1664  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1665  					++k;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1666  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1667  				charptr_tmp = charptr_tmp2;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1668  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1669  			} else if (long_idx != 0)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1670  				charptr_tmp = &charptr_tmp[long_idx >> 3];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1671  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1672  			altera_export_bool_array(name, charptr_tmp,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1673  							long_count);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1674  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1675  			/* free allocated buffer */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1676  			if ((long_idx & 7L) != 0)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1677  				kfree(charptr_tmp2);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1678  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1679  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1680  		case OP_COPY: {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1681  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1682  			 * Array copy
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1683  			 * ...argument 0 is dest ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1684  			 * ...argument 1 is source ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1685  			 * ...stack 0 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1686  			 * ...stack 1 is dest index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1687  			 * ...stack 2 is source index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1688  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1689  			s32 copy_count;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1690  			s32 copy_index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1691  			s32 copy_index2;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1692  			s32 destleft;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1693  			s32 src_count;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1694  			s32 dest_count;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1695  			int src_reverse = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1696  			int dest_reverse = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1697  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1698  			if (!altera_check_stack(stack_ptr, 3, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1699  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1700  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1701  			copy_count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1702  			copy_index = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1703  			copy_index2 = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1704  			reverse = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1705  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1706  			if (version > 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1707  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1708  				 * stack 0 = source right index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1709  				 * stack 1 = source left index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1710  				 * stack 2 = destination right index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1711  				 * stack 3 = destination left index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1712  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1713  				destleft = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1714  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1715  				if (copy_count > copy_index) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1716  					src_reverse = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1717  					reverse = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1718  					src_count = 1 + copy_count - copy_index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1719  					/* copy_index = source start index */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1720  				} else {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1721  					src_count = 1 + copy_index - copy_count;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1722  					/* source start index */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1723  					copy_index = copy_count;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1724  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1725  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1726  				if (copy_index2 > destleft) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1727  					dest_reverse = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1728  					reverse = !reverse;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1729  					dest_count = 1 + copy_index2 - destleft;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1730  					/* destination start index */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1731  					copy_index2 = destleft;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1732  				} else
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1733  					dest_count = 1 + destleft - copy_index2;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1734  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1735  				copy_count = (src_count < dest_count) ?
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1736  							src_count : dest_count;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1737  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1738  				if ((src_reverse || dest_reverse) &&
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1739  					(src_count != dest_count))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1740  					/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1741  					 * If either the source or destination
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1742  					 * is reversed, we can't tolerate
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1743  					 * a length mismatch, because we
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1744  					 * "left justify" arrays when copying.
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1745  					 * This won't work correctly
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1746  					 * with reversed arrays.
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1747  					 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1748  					status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1749  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1750  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1751  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1752  			count = copy_count;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1753  			index = copy_index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1754  			index2 = copy_index2;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1755  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1756  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1757  			 * If destination is a read-only array,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1758  			 * allocate a buffer and convert it to a writable array
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1759  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1760  			variable_id = args[1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1761  			if ((version > 0) &&
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1762  				((attrs[variable_id] & 0x9c) == 0x0c)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1763  				/* Allocate a writable buffer for this array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1764  				long_tmp =
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1765  					(var_size[variable_id] + 7L) >> 3L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1766  				charptr_tmp2 = (u8 *)vars[variable_id];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1767  				charptr_tmp =
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1768  					kzalloc(long_tmp, GFP_KERNEL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1769  				vars[variable_id] = (long)charptr_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1770  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1771  				if (vars[variable_id] == 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1772  					status = -ENOMEM;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1773  					break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1774  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1775  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1776  				/* zero the buffer */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1777  				for (long_idx = 0L; long_idx < long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1778  								++long_idx)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1779  					charptr_tmp[long_idx] = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1780  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1781  				/* copy previous contents into buffer */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1782  				for (long_idx = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1783  					long_idx < var_size[variable_id];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1784  								++long_idx) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1785  					long_idx2 = long_idx;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1786  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1787  					if (charptr_tmp2[long_idx2 >> 3] &
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1788  						(1 << (long_idx2 & 7)))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1789  						charptr_tmp[long_idx >> 3] |=
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1790  							(1 << (long_idx & 7));
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1791  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1792  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1793  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1794  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1795  				set bit 7 - buffer was dynamically allocated */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1796  				attrs[variable_id] |= 0x80;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1797  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1798  				/* clear bit 2 - variable is writable */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1799  				attrs[variable_id] &= ~0x04;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1800  				attrs[variable_id] |= 0x01;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1801  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1802  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1803  			charptr_tmp = (u8 *)vars[args[1]];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1804  			charptr_tmp2 = (u8 *)vars[args[0]];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1805  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1806  			/* check if destination is a writable Boolean array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1807  			if ((attrs[args[1]] & 0x1c) != 0x08) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1808  				status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1809  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1810  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1811  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1812  			if (count < 1) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1813  				status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1814  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1815  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1816  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1817  			if (reverse)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1818  				index2 += (count - 1);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1819  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1820  			for (i = 0; i < count; ++i) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1821  				if (charptr_tmp2[index >> 3] &
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1822  							(1 << (index & 7)))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1823  					charptr_tmp[index2 >> 3] |=
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1824  							(1 << (index2 & 7));
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1825  				else
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1826  					charptr_tmp[index2 >> 3] &=
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1827  						~(1 << (index2 & 7));
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1828  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1829  				++index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1830  				if (reverse)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1831  					--index2;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1832  				else
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1833  					++index2;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1834  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1835  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1836  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1837  		}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1838  		case OP_DSC:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1839  		case OP_ISC: {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1840  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1841  			 * DRSCAN with capture
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1842  			 * IRSCAN with capture
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1843  			 * ...argument 0 is scan data variable ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1844  			 * ...argument 1 is capture variable ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1845  			 * ...stack 0 is capture index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1846  			 * ...stack 1 is scan data index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1847  			 * ...stack 2 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1848  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1849  			s32 scan_right, scan_left;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1850  			s32 capture_count = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1851  			s32 scan_count = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1852  			s32 capture_index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1853  			s32 scan_index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1854  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1855  			if (!altera_check_stack(stack_ptr, 3, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1856  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1857  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1858  			capture_index = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1859  			scan_index = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1860  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1861  			if (version > 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1862  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1863  				 * stack 0 = capture right index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1864  				 * stack 1 = capture left index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1865  				 * stack 2 = scan right index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1866  				 * stack 3 = scan left index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1867  				 * stack 4 = count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1868  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1869  				scan_right = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1870  				scan_left = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1871  				capture_count = 1 + scan_index - capture_index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1872  				scan_count = 1 + scan_left - scan_right;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1873  				scan_index = scan_right;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1874  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1875  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1876  			long_count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1877  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1878  			 * If capture array is read-only, allocate a buffer
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1879  			 * and convert it to a writable array
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1880  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1881  			variable_id = args[1];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1882  			if ((version > 0) &&
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1883  				((attrs[variable_id] & 0x9c) == 0x0c)) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1884  				/* Allocate a writable buffer for this array */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1885  				long_tmp =
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1886  					(var_size[variable_id] + 7L) >> 3L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1887  				charptr_tmp2 = (u8 *)vars[variable_id];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1888  				charptr_tmp =
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1889  					kzalloc(long_tmp, GFP_KERNEL);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1890  				vars[variable_id] = (long)charptr_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1891  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1892  				if (vars[variable_id] == 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1893  					status = -ENOMEM;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1894  					break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1895  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1896  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1897  				/* zero the buffer */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1898  				for (long_idx = 0L; long_idx < long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1899  								++long_idx)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1900  					charptr_tmp[long_idx] = 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1901  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1902  				/* copy previous contents into buffer */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1903  				for (long_idx = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1904  					long_idx < var_size[variable_id];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1905  								++long_idx) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1906  					long_idx2 = long_idx;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1907  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1908  					if (charptr_tmp2[long_idx2 >> 3] &
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1909  						(1 << (long_idx2 & 7)))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1910  						charptr_tmp[long_idx >> 3] |=
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1911  							(1 << (long_idx & 7));
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1912  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1913  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1914  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1915  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1916  				 * set bit 7 - buffer was
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1917  				 * dynamically allocated
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1918  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1919  				attrs[variable_id] |= 0x80;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1920  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1921  				/* clear bit 2 - variable is writable */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1922  				attrs[variable_id] &= ~0x04;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1923  				attrs[variable_id] |= 0x01;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1924  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1925  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1926  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1927  			charptr_tmp = (u8 *)vars[args[0]];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1928  			charptr_tmp2 = (u8 *)vars[args[1]];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1929  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1930  			if ((version > 0) &&
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1931  					((long_count > capture_count) ||
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1932  					(long_count > scan_count))) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1933  				status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1934  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1935  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1936  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1937  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1938  			 * check that capture array
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1939  			 * is a writable Boolean array
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1940  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1941  			if ((attrs[args[1]] & 0x1c) != 0x08) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1942  				status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1943  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1944  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1945  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1946  			if (status == 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1947  				if (opcode == 0x82) /* DSC */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1948  					status = altera_swap_dr(astate,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1949  							long_count,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1950  							charptr_tmp,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1951  							scan_index,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1952  							charptr_tmp2,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1953  							capture_index);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1954  				else /* ISC */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1955  					status = altera_swap_ir(astate,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1956  							long_count,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1957  							charptr_tmp,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1958  							scan_index,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1959  							charptr_tmp2,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1960  							capture_index);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1961  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1962  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1963  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1964  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1965  		}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1966  		case OP_WAIT:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1967  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1968  			 * WAIT
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1969  			 * ...argument 0 is wait state
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1970  			 * ...argument 1 is end state
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1971  			 * ...stack 0 is cycles
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1972  			 * ...stack 1 is microseconds
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1973  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1974  			if (!altera_check_stack(stack_ptr, 2, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1975  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1976  			long_tmp = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1977  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1978  			if (long_tmp != 0L)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1979  				status = altera_wait_cycles(astate, long_tmp,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1980  								args[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1981  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1982  			long_tmp = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1983  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1984  			if ((status == 0) && (long_tmp != 0L))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1985  				status = altera_wait_msecs(astate,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1986  								long_tmp,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1987  								args[0]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1988  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1989  			if ((status == 0) && (args[1] != args[0]))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1990  				status = altera_goto_jstate(astate,
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1991  								args[1]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1992  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1993  			if (version > 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1994  				--stack_ptr; /* throw away MAX cycles */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1995  				--stack_ptr; /* throw away MAX microseconds */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1996  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1997  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1998  		case OP_CMPA: {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  1999  			/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2000  			 * Array compare
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2001  			 * ...argument 0 is source 1 ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2002  			 * ...argument 1 is source 2 ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2003  			 * ...argument 2 is mask ID
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2004  			 * ...stack 0 is source 1 index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2005  			 * ...stack 1 is source 2 index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2006  			 * ...stack 2 is mask index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2007  			 * ...stack 3 is count
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2008  			 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2009  			s32 a, b;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2010  			u8 *source1 = (u8 *)vars[args[0]];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2011  			u8 *source2 = (u8 *)vars[args[1]];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2012  			u8 *mask = (u8 *)vars[args[2]];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2013  			u32 index1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2014  			u32 index2;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2015  			u32 mask_index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2016  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2017  			if (!altera_check_stack(stack_ptr, 4, &status))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2018  				break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2019  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2020  			index1 = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2021  			index2 = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2022  			mask_index = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2023  			long_count = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2024  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2025  			if (version > 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2026  				/*
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2027  				 * stack 0 = source 1 right index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2028  				 * stack 1 = source 1 left index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2029  				 * stack 2 = source 2 right index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2030  				 * stack 3 = source 2 left index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2031  				 * stack 4 = mask right index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2032  				 * stack 5 = mask left index
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2033  				 */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2034  				s32 mask_right = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2035  				s32 mask_left = stack[--stack_ptr];
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2036  				/* source 1 count */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2037  				a = 1 + index2 - index1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2038  				/* source 2 count */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2039  				b = 1 + long_count - mask_index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2040  				a = (a < b) ? a : b;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2041  				/* mask count */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2042  				b = 1 + mask_left - mask_right;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2043  				a = (a < b) ? a : b;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2044  				/* source 2 start index */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2045  				index2 = mask_index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2046  				/* mask start index */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2047  				mask_index = mask_right;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2048  				long_count = a;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2049  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2050  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2051  			long_tmp = 1L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2052  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2053  			if (long_count < 1)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2054  				status = -ERANGE;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2055  			else {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2056  				count = long_count;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2057  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2058  				for (i = 0; i < count; ++i) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2059  					if (mask[mask_index >> 3] &
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2060  						(1 << (mask_index & 7))) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2061  						a = source1[index1 >> 3] &
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2062  							(1 << (index1 & 7))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2063  								? 1 : 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2064  						b = source2[index2 >> 3] &
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2065  							(1 << (index2 & 7))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2066  								? 1 : 0;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2067  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2068  						if (a != b) /* failure */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2069  							long_tmp = 0L;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2070  					}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2071  					++index1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2072  					++index2;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2073  					++mask_index;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2074  				}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2075  			}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2076  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2077  			stack[stack_ptr++] = long_tmp;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2078  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2079  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2080  		}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2081  		default:
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2082  			/* Unrecognized opcode -- ERROR! */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2083  			bad_opcode = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2084  			break;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2085  		}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2086  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2087  		if (bad_opcode)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2088  			status = -ENOSYS;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2089  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2090  		if ((stack_ptr < 0) || (stack_ptr >= ALTERA_STACK_SIZE))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2091  			status = -EOVERFLOW;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2092  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2093  		if (status != 0) {
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2094  			done = 1;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2095  			*error_address = (s32)(opcode_address - code_sect);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2096  		}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2097  	}
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2098  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2099  	altera_free_buffers(astate);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2100  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2101  	/* Free all dynamically allocated arrays */
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2102  	if ((attrs != NULL) && (vars != NULL))
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2103  		for (i = 0; i < sym_count; ++i)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2104  			if (attrs[i] & 0x80)
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2105  				kfree((void *)vars[i]);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2106  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2107  	kfree(vars);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2108  	kfree(var_size);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2109  	kfree(attrs);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2110  	kfree(proc_attributes);
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2111  
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2112  	return status;
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25 @2113  }
fa766c9be58bd87 drivers/staging/altera-stapl/altera.c Igor M. Liplianin 2011-01-25  2114  

:::::: The code at line 2113 was first introduced by commit
:::::: fa766c9be58bd872784b081074a7d15a3ce61c5f [media] Altera FPGA firmware download module

:::::: TO: Igor M. Liplianin <liplianin@me.by>
:::::: CC: Mauro Carvalho Chehab <mchehab@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--1yeeQ81UyVL57Vl7
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
F2ZrRgEA

--1yeeQ81UyVL57Vl7--
