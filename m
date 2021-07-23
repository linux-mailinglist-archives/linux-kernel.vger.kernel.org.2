Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B0B3D4385
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 01:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbhGWXRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 19:17:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:45481 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233064AbhGWXRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 19:17:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10054"; a="211690695"
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="211690695"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 16:58:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; 
   d="scan'208";a="463310963"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 23 Jul 2021 16:58:04 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m753L-0002Vf-AD; Fri, 23 Jul 2021 23:58:03 +0000
Date:   Sat, 24 Jul 2021 07:57:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:vectorized-scrub 131/306] fs/xfs/scrub/repair.c:
 xfs_attr.h is included more than once.
Message-ID: <202107240758.jYzJos7S-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git vectorized-scrub
head:   a2c23a2a858e9b051820071d6411c151656328e4
commit: 25c7e7491838fb83bd474ef59a4d5abfa92f4f98 [131/306] xfs: repair extended attributes
compiler: gcc-10 (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> fs/xfs/scrub/repair.c: xfs_attr.h is included more than once.

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
