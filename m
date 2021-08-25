Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110323F6EE6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 07:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbhHYFpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 01:45:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:47616 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231816AbhHYFpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 01:45:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="204653390"
X-IronPort-AV: E=Sophos;i="5.84,349,1620716400"; 
   d="scan'208";a="204653390"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 22:44:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,349,1620716400"; 
   d="scan'208";a="685941192"
Received: from lkp-server02.sh.intel.com (HELO 181e7be6f509) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 24 Aug 2021 22:44:26 -0700
Received: from kbuild by 181e7be6f509 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mIli5-0001Do-MV; Wed, 25 Aug 2021 05:44:25 +0000
Date:   Wed, 25 Aug 2021 13:44:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Allison Collins <allison.henderson@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [allisonhenderson-xfs_work:delayed_attrs_v24_extended 6/27]
 fs/xfs/libxfs/xfs_attr.c: xfs_attr.h is included more than once.
Message-ID: <202108251318.k75imb22-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/allisonhenderson/xfs_work.git delayed_attrs_v24_extended
head:   65b46be2f965591671441cfd63f02f38befbec24
commit: 466619b962947151034f21a865f127a3bedcb101 [6/27] xfs: Add xfs_attr_set_deferred and xfs_attr_remove_deferred
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> fs/xfs/libxfs/xfs_attr.c: xfs_attr.h is included more than once.

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
