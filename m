Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46F7455ADD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 12:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344165AbhKRLtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 06:49:35 -0500
Received: from mga03.intel.com ([134.134.136.65]:58622 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344204AbhKRLry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 06:47:54 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="234116568"
X-IronPort-AV: E=Sophos;i="5.87,244,1631602800"; 
   d="gz'50?scan'50,208,50";a="234116568"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 03:44:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,244,1631602800"; 
   d="gz'50?scan'50,208,50";a="455287412"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 18 Nov 2021 03:44:52 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mnfqV-00031D-Eg; Thu, 18 Nov 2021 11:44:51 +0000
Date:   Thu, 18 Nov 2021 19:43:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: block/partitions/ldm.c:134:9: warning: 'strncpy' specified bound 16
 equals destination size
Message-ID: <202111181939.WU5QGhzq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Heiko,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   42eb8fdac2fc5d62392dcfcf0253753e821a97b0
commit: 334ef6ed06fa1a54e35296b77b693bcf6d63ee9e init/Kconfig: make COMPILE_TEST depend on !S390
date:   12 months ago
config: s390-buildonly-randconfig-r006-20211118 (attached as .config)
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

--3MwIy2ne0vdjdPXF
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--3MwIy2ne0vdjdPXF--
