Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8B24040A1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 23:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbhIHVob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 17:44:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:60814 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235208AbhIHVoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 17:44:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="200806691"
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="gz'50?scan'50,208,50";a="200806691"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 14:43:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="gz'50?scan'50,208,50";a="695774692"
Received: from lkp-server01.sh.intel.com (HELO 730d49888f40) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 08 Sep 2021 14:43:18 -0700
Received: from kbuild by 730d49888f40 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mO5Lh-0002dN-K7; Wed, 08 Sep 2021 21:43:17 +0000
Date:   Thu, 9 Sep 2021 05:42:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: block/partitions/ldm.c:134:9: warning: 'strncpy' specified bound 16
 equals destination size
Message-ID: <202109090516.eB9KGzKy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2d338201d5311bcd79d42f66df4cecbcbc5f4f2c
commit: 334ef6ed06fa1a54e35296b77b693bcf6d63ee9e init/Kconfig: make COMPILE_TEST depend on !S390
date:   10 months ago
config: s390-buildonly-randconfig-r005-20210909 (attached as .config)
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

--VbJkn9YxBvnuCH5J
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
CYG5vZc8k5zovC+Rdz7/B5mzSc4PBQEA

--VbJkn9YxBvnuCH5J--
