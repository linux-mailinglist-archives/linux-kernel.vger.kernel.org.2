Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019CD42ED81
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 11:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbhJOJ0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 05:26:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:5053 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234769AbhJOJ0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 05:26:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="227775279"
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="gz'50?scan'50,208,50";a="227775279"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 02:23:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,375,1624345200"; 
   d="gz'50?scan'50,208,50";a="442465280"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Oct 2021 02:23:26 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mbJQy-0007cu-OY; Fri, 15 Oct 2021 09:23:24 +0000
Date:   Fri, 15 Oct 2021 17:22:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: block/partitions/ldm.c:134:9: warning: 'strncpy' specified bound 16
 equals destination size
Message-ID: <202110151735.KhAIYD1r-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ec681c53f8d2d0ee362ff67f5b98dd8263c15002
commit: 334ef6ed06fa1a54e35296b77b693bcf6d63ee9e init/Kconfig: make COMPILE_TEST depend on !S390
date:   11 months ago
config: s390-randconfig-r044-20211015 (attached as .config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=334ef6ed06fa1a54e35296b77b693bcf6d63ee9e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 334ef6ed06fa1a54e35296b77b693bcf6d63ee9e
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In function 'ldm_parse_tocblock',
       inlined from 'ldm_validate_tocblocks' at block/partitions/ldm.c:386:7:
>> block/partitions/ldm.c:134:9: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]
     134 |         strncpy (toc->bitmap1_name, data + 0x24, sizeof (toc->bitmap1_name));
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   block/partitions/ldm.c:145:9: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]
     145 |         strncpy (toc->bitmap2_name, data + 0x46, sizeof (toc->bitmap2_name));
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   kernel/trace/blktrace.c: In function '__trace_note_message':
   kernel/trace/blktrace.c:148:63: warning: parameter 'blkcg' set but not used [-Wunused-but-set-parameter]
     148 | void __trace_note_message(struct blk_trace *bt, struct blkcg *blkcg,
         |                                                 ~~~~~~~~~~~~~~^~~~~
   kernel/trace/blktrace.c: In function 'do_blk_trace_setup':
>> kernel/trace/blktrace.c:491:9: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
     491 |         strncpy(buts->name, name, BLKTRACE_BDEV_SIZE);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/strncpy +134 block/partitions/ldm.c

^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  111  
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  112  /**
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  113   * ldm_parse_tocblock - Read the LDM Database TOCBLOCK structure
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  114   * @data:  Raw database TOCBLOCK structure loaded from the device
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  115   * @toc:   In-memory toc structure in which to return parsed information
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  116   *
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  117   * This parses the LDM Database TOCBLOCK (table of contents) structure supplied
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  118   * in @data and sets up the in-memory tocblock structure @toc with the obtained
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  119   * information.
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  120   *
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  121   * N.B.  The *_start and *_size values returned in @toc are not range-checked.
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  122   *
130c6b98984a05 fs/partitions/ldm.c Richard Knutsson 2006-09-30  123   * Return:  'true'   @toc contains the TOCBLOCK data
130c6b98984a05 fs/partitions/ldm.c Richard Knutsson 2006-09-30  124   *          'false'  @toc contents are undefined
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  125   */
130c6b98984a05 fs/partitions/ldm.c Richard Knutsson 2006-09-30  126  static bool ldm_parse_tocblock (const u8 *data, struct tocblock *toc)
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  127  {
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  128  	BUG_ON (!data || !toc);
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  129  
b7bbf8fa6ba329 fs/partitions/ldm.c Harvey Harrison  2008-07-25  130  	if (MAGIC_TOCBLOCK != get_unaligned_be64(data)) {
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  131  		ldm_crit ("Cannot find TOCBLOCK, database may be corrupt.");
130c6b98984a05 fs/partitions/ldm.c Richard Knutsson 2006-09-30  132  		return false;
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  133  	}
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16 @134  	strncpy (toc->bitmap1_name, data + 0x24, sizeof (toc->bitmap1_name));
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  135  	toc->bitmap1_name[sizeof (toc->bitmap1_name) - 1] = 0;
b7bbf8fa6ba329 fs/partitions/ldm.c Harvey Harrison  2008-07-25  136  	toc->bitmap1_start = get_unaligned_be64(data + 0x2E);
b7bbf8fa6ba329 fs/partitions/ldm.c Harvey Harrison  2008-07-25  137  	toc->bitmap1_size  = get_unaligned_be64(data + 0x36);
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  138  
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  139  	if (strncmp (toc->bitmap1_name, TOC_BITMAP1,
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  140  			sizeof (toc->bitmap1_name)) != 0) {
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  141  		ldm_crit ("TOCBLOCK's first bitmap is '%s', should be '%s'.",
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  142  				TOC_BITMAP1, toc->bitmap1_name);
130c6b98984a05 fs/partitions/ldm.c Richard Knutsson 2006-09-30  143  		return false;
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  144  	}
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  145  	strncpy (toc->bitmap2_name, data + 0x46, sizeof (toc->bitmap2_name));
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  146  	toc->bitmap2_name[sizeof (toc->bitmap2_name) - 1] = 0;
b7bbf8fa6ba329 fs/partitions/ldm.c Harvey Harrison  2008-07-25  147  	toc->bitmap2_start = get_unaligned_be64(data + 0x50);
b7bbf8fa6ba329 fs/partitions/ldm.c Harvey Harrison  2008-07-25  148  	toc->bitmap2_size  = get_unaligned_be64(data + 0x58);
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  149  	if (strncmp (toc->bitmap2_name, TOC_BITMAP2,
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  150  			sizeof (toc->bitmap2_name)) != 0) {
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  151  		ldm_crit ("TOCBLOCK's second bitmap is '%s', should be '%s'.",
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  152  				TOC_BITMAP2, toc->bitmap2_name);
130c6b98984a05 fs/partitions/ldm.c Richard Knutsson 2006-09-30  153  		return false;
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  154  	}
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  155  	ldm_debug ("Parsed TOCBLOCK successfully.");
130c6b98984a05 fs/partitions/ldm.c Richard Knutsson 2006-09-30  156  	return true;
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  157  }
^1da177e4c3f41 fs/partitions/ldm.c Linus Torvalds   2005-04-16  158  

:::::: The code at line 134 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--lrZ03NoBR/3+SXJZ
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AA==

--lrZ03NoBR/3+SXJZ--
