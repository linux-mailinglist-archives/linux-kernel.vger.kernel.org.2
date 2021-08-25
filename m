Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBAF3F6D42
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 04:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237090AbhHYCBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 22:01:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:8688 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229800AbhHYCBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 22:01:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="278445588"
X-IronPort-AV: E=Sophos;i="5.84,349,1620716400"; 
   d="scan'208";a="278445588"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 19:00:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,349,1620716400"; 
   d="scan'208";a="515935484"
Received: from lkp-server02.sh.intel.com (HELO 181e7be6f509) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 24 Aug 2021 19:00:21 -0700
Received: from kbuild by 181e7be6f509 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mIiDE-00011x-GS; Wed, 25 Aug 2021 02:00:20 +0000
Date:   Wed, 25 Aug 2021 10:00:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Allison Henderson <allison.henderson@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [allisonhenderson-xfs_work:delayed_attrs_v24_extended 3/27]
 fs/xfs/xfs_attr_item.c: xfs_shared.h is included more than once.
Message-ID: <202108251000.9bcZ9XAN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/allisonhenderson/xfs_work.git delayed_attrs_v24_extended
head:   65b46be2f965591671441cfd63f02f38befbec24
commit: e6fffbbe5c47b7497dd0c8fe248bf8de4806ccc9 [3/27] xfs: Set up infrastructure for log atrribute replay
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> fs/xfs/xfs_attr_item.c: xfs_shared.h is included more than once.
>> /kbuild/src/consumer/fs/xfs/xfs_attr_item.c: xfs_inode.h is included more than once.

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
