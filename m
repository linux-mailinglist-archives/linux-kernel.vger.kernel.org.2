Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705CA3C6398
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 21:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbhGLTXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 15:23:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:22184 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236394AbhGLTXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:23:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="190422884"
X-IronPort-AV: E=Sophos;i="5.84,234,1620716400"; 
   d="scan'208";a="190422884"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 12:20:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,234,1620716400"; 
   d="scan'208";a="648355969"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 12 Jul 2021 12:19:59 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m31TC-000HCR-DH; Mon, 12 Jul 2021 19:19:58 +0000
Date:   Tue, 13 Jul 2021 03:19:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: mm/sparse.c:145:2: warning: int result is returned as long value. If
 the return value is long to avoid loss of information, then you have loss of
 information. [truncLongCastReturn]
Message-ID: <202107130348.6LsVT9Nc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e73f0f0ee7541171d89f2e2491130c7771ba58d3
commit: 36d40290c8f71daf1ba5567ab14574f36b9b8d6a alpha: switch from DISCONTIGMEM to SPARSEMEM
date:   7 months ago
compiler: alpha-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)
>> mm/sparse.c:145:2: warning: int result is returned as long value. If the return value is long to avoid loss of information, then you have loss of information. [truncLongCastReturn]
    return (nid << SECTION_NID_SHIFT);
    ^

vim +145 mm/sparse.c

4ca644d970bf25 Dave Hansen    2005-10-29  136  
30c253e6da655d Andy Whitcroft 2006-06-23  137  /*
30c253e6da655d Andy Whitcroft 2006-06-23  138   * During early boot, before section_mem_map is used for an actual
30c253e6da655d Andy Whitcroft 2006-06-23  139   * mem_map, we use section_mem_map to store the section's NUMA
30c253e6da655d Andy Whitcroft 2006-06-23  140   * node.  This keeps us from having to use another data structure.  The
30c253e6da655d Andy Whitcroft 2006-06-23  141   * node information is cleared just before we store the real mem_map.
30c253e6da655d Andy Whitcroft 2006-06-23  142   */
30c253e6da655d Andy Whitcroft 2006-06-23  143  static inline unsigned long sparse_encode_early_nid(int nid)
30c253e6da655d Andy Whitcroft 2006-06-23  144  {
30c253e6da655d Andy Whitcroft 2006-06-23 @145  	return (nid << SECTION_NID_SHIFT);
30c253e6da655d Andy Whitcroft 2006-06-23  146  }
30c253e6da655d Andy Whitcroft 2006-06-23  147  

:::::: The code at line 145 was first introduced by commit
:::::: 30c253e6da655d73eb8bfe2adca9b8f4d82fb81e [PATCH] sparsemem: record nid during memory present

:::::: TO: Andy Whitcroft <apw@shadowen.org>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
