Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A71370915
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 23:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhEAVcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 17:32:25 -0400
Received: from mga12.intel.com ([192.55.52.136]:23208 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231739AbhEAVcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 17:32:25 -0400
IronPort-SDR: FVfwNorAUlGjFvTf0R8ywPjwtNiFNu8ARp7CbW+e62jqavz1jSWed/+J3qZrcsIra4wksvqGPb
 CblJK5jr5zpw==
X-IronPort-AV: E=McAfee;i="6200,9189,9971"; a="177014476"
X-IronPort-AV: E=Sophos;i="5.82,266,1613462400"; 
   d="gz'50?scan'50,208,50";a="177014476"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2021 14:31:34 -0700
IronPort-SDR: rpfOxHrQYksGFVYsI6JNRaPGhxgvlEN17kuqDT88nd990IssINGqe6SoE1+/husDTPsQPGdzOW
 4L/lgfBWkDWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,266,1613462400"; 
   d="gz'50?scan'50,208,50";a="456606570"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 01 May 2021 14:31:32 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lcxD1-0008iU-Ty; Sat, 01 May 2021 21:31:31 +0000
Date:   Sun, 2 May 2021 05:30:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: arch/mips/sibyte/common/sb_tbprof.c:515:23: sparse: sparse:
 incorrect type in initializer (different address spaces)
Message-ID: <202105020537.b0b59fJH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   10a3efd0fee5e881b1866cf45950808575cb0f24
commit: ddb002d6d6af12c45dd9d565cadf0f40b36b7c25 MIPS: uaccess: Reduce number of nested macros
date:   3 weeks ago
config: mips-randconfig-s032-20210502 (attached as .config)
compiler: mips-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-341-g8af24329-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ddb002d6d6af12c45dd9d565cadf0f40b36b7c25
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ddb002d6d6af12c45dd9d565cadf0f40b36b7c25
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' W=1 ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   arch/mips/sibyte/common/sb_tbprof.c:449:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __user *p @@     got char *buf @@
   arch/mips/sibyte/common/sb_tbprof.c:449:14: sparse:     expected void const [noderef] __user *p
   arch/mips/sibyte/common/sb_tbprof.c:449:14: sparse:     got char *buf
   arch/mips/sibyte/common/sb_tbprof.c:464:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got char *dest @@
   arch/mips/sibyte/common/sb_tbprof.c:464:38: sparse:     expected void [noderef] __user *to
   arch/mips/sibyte/common/sb_tbprof.c:464:38: sparse:     got char *dest
>> arch/mips/sibyte/common/sb_tbprof.c:515:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__p @@     got int * @@
   arch/mips/sibyte/common/sb_tbprof.c:515:23: sparse:     expected int [noderef] __user *__p
   arch/mips/sibyte/common/sb_tbprof.c:515:23: sparse:     got int *
   arch/mips/sibyte/common/sb_tbprof.c:531:27: sparse: sparse: incorrect type in initializer (incompatible argument 2 (different address spaces)) @@     expected int ( *read )( ... ) @@     got int ( * )( ... ) @@
   arch/mips/sibyte/common/sb_tbprof.c:531:27: sparse:     expected int ( *read )( ... )
   arch/mips/sibyte/common/sb_tbprof.c:531:27: sparse:     got int ( * )( ... )

vim +515 arch/mips/sibyte/common/sb_tbprof.c

^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  439  
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  440  static ssize_t sbprof_tb_read(struct file *filp, char *buf,
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  441  			      size_t size, loff_t *offp)
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  442  {
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  443  	int cur_sample, sample_off, cur_count, sample_left;
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  444  	char *src;
d619f38fdacb5c arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  445  	int   count   =	 0;
d619f38fdacb5c arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  446  	char *dest    =	 buf;
d619f38fdacb5c arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  447  	long  cur_off = *offp;
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  448  
96d4f267e40f95 arch/mips/sibyte/common/sb_tbprof.c      Linus Torvalds 2019-01-03 @449  	if (!access_ok(buf, size))
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  450  		return -EFAULT;
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  451  
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  452  	mutex_lock(&sbp.lock);
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  453  
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  454  	count = 0;
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  455  	cur_sample = cur_off / TB_SAMPLE_SIZE;
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  456  	sample_off = cur_off % TB_SAMPLE_SIZE;
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  457  	sample_left = TB_SAMPLE_SIZE - sample_off;
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  458  
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  459  	while (size && (cur_sample < sbp.next_tb_sample)) {
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  460  		int err;
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  461  
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  462  		cur_count = size < sample_left ? size : sample_left;
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  463  		src = (char *)(((long)sbp.sbprof_tbbuf[cur_sample])+sample_off);
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  464  		err = __copy_to_user(dest, src, cur_count);
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  465  		if (err) {
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  466  			*offp = cur_off + cur_count - err;
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  467  			mutex_unlock(&sbp.lock);
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  468  			return err;
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  469  		}
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  470  		pr_debug(DEVNAME ": read from sample %d, %d bytes\n",
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  471  			 cur_sample, cur_count);
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  472  		size -= cur_count;
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  473  		sample_left -= cur_count;
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  474  		if (!sample_left) {
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  475  			cur_sample++;
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  476  			sample_off = 0;
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  477  			sample_left = TB_SAMPLE_SIZE;
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  478  		} else {
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  479  			sample_off += cur_count;
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  480  		}
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  481  		cur_off += cur_count;
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  482  		dest += cur_count;
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  483  		count += cur_count;
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  484  	}
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  485  	*offp = cur_off;
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  486  	mutex_unlock(&sbp.lock);
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  487  
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  488  	return count;
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  489  }
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  490  
d619f38fdacb5c arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  491  static long sbprof_tb_ioctl(struct file *filp,
d619f38fdacb5c arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  492  			    unsigned int command,
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  493  			    unsigned long arg)
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  494  {
d619f38fdacb5c arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  495  	int err = 0;
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  496  
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  497  	switch (command) {
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  498  	case SBPROF_ZBSTART:
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  499  		mutex_lock(&sbp.lock);
d619f38fdacb5c arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  500  		err = sbprof_zbprof_start(filp);
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  501  		mutex_unlock(&sbp.lock);
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  502  		break;
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  503  
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  504  	case SBPROF_ZBSTOP:
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  505  		mutex_lock(&sbp.lock);
d619f38fdacb5c arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  506  		err = sbprof_zbprof_stop();
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  507  		mutex_unlock(&sbp.lock);
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  508  		break;
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  509  
d619f38fdacb5c arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  510  	case SBPROF_ZBWAITFULL: {
d619f38fdacb5c arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  511  		err = wait_event_interruptible(sbp.tb_read, TB_FULL);
d619f38fdacb5c arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  512  		if (err)
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  513  			break;
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  514  
d619f38fdacb5c arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29 @515  		err = put_user(TB_FULL, (int *) arg);
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  516  		break;
d619f38fdacb5c arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  517  	}
bb9b813bb665cd arch/mips/sibyte/sb1250/bcm1250_tbprof.c Ralf Baechle   2007-03-09  518  
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  519  	default:
d619f38fdacb5c arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  520  		err = -EINVAL;
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  521  		break;
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  522  	}
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  523  
d619f38fdacb5c arch/mips/sibyte/common/sb_tbprof.c      Mark Mason     2007-03-29  524  	return err;
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  525  }
^1da177e4c3f41 arch/mips/sibyte/sb1250/bcm1250_tbprof.c Linus Torvalds 2005-04-16  526  

:::::: The code at line 515 was first introduced by commit
:::::: d619f38fdacb5cec0c841798bbadeaf903868852 [MIPS] Add bcm1480 ZBus trace support, fix wait related bugs

:::::: TO: Mark Mason <mmason@upwardaccess.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--PNTmBPCT7hxwcZjr
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
0UnJ61ixqmua/wPmnFEpv0UBAA==

--PNTmBPCT7hxwcZjr--
