Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99477457EC7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 15:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbhKTPAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 10:00:13 -0500
Received: from mga17.intel.com ([192.55.52.151]:14856 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237479AbhKTPAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 10:00:13 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="215290257"
X-IronPort-AV: E=Sophos;i="5.87,250,1631602800"; 
   d="scan'208";a="215290257"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2021 06:57:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,250,1631602800"; 
   d="scan'208";a="455764456"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 20 Nov 2021 06:57:08 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1moRnf-0005u4-Ge; Sat, 20 Nov 2021 14:57:07 +0000
Date:   Sat, 20 Nov 2021 22:56:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:vectorized-scrub 34/312] fs/xfs/scrub/rtsummary.c:
 xfs_inode.h is included more than once.
Message-ID: <202111202253.encHPxhN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git vectorized-scrub
head:   1804f4671b76293a8a792e5be4e514cefc0f012f
commit: 74f1ca8e2db20002fb187c0900f29b222c603a74 [34/312] xfs: move the realtime summary file scrubber to a separate source file
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> fs/xfs/scrub/rtsummary.c: xfs_inode.h is included more than once.

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
