Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277623D05BE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 01:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbhGTW5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 18:57:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:35779 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237366AbhGTWzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 18:55:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="275164033"
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; 
   d="scan'208";a="275164033"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 16:35:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; 
   d="scan'208";a="495074165"
Received: from lkp-server02.sh.intel.com (HELO 1b5a72ed9419) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jul 2021 16:35:40 -0700
Received: from kbuild by 1b5a72ed9419 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m5zH1-0000SF-OW; Tue, 20 Jul 2021 23:35:39 +0000
Date:   Wed, 21 Jul 2021 07:34:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:vectorized-scrub 131/306] fs/xfs/scrub/repair.c:
 xfs_attr.h is included more than once.
Message-ID: <202107210749.wUgH8E0i-lkp@intel.com>
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
