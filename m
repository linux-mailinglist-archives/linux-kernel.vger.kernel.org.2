Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05ED23D6732
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 21:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbhGZSVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 14:21:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:64744 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233455AbhGZSUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 14:20:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="191894024"
X-IronPort-AV: E=Sophos;i="5.84,270,1620716400"; 
   d="scan'208";a="191894024"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 12:01:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,270,1620716400"; 
   d="scan'208";a="664768246"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 26 Jul 2021 12:01:12 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m85qh-00060a-Ev; Mon, 26 Jul 2021 19:01:11 +0000
Date:   Tue, 27 Jul 2021 03:00:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Allison Henderson <allison.henderson@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [allisonhenderson-xfs_work:delayed_attrs_v22_extended 8/32]
 fs/xfs/xfs_ioctl.c: xfs_da_btree.h is included more than once.
Message-ID: <202107270318.zbRtTc5a-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/allisonhenderson/xfs_work.git delayed_attrs_v22_extended
head:   43a95c4600b7c80ac410a00ac245ccf85b150d26
commit: 544e13d377a138d4bfe1ae8139a2e391c454ff88 [8/32] xfs: Set up infrastructure for deferred attribute operations
compiler: gcc-10 (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> fs/xfs/xfs_ioctl.c: xfs_da_btree.h is included more than once.
>> /kbuild/src/consumer/fs/xfs/xfs_ioctl.c: xfs_da_format.h is included more than once.
--
>> fs/xfs/xfs_acl.c: xfs_da_format.h is included more than once.
>> /kbuild/src/consumer/fs/xfs/xfs_acl.c: xfs_da_btree.h is included more than once.
--
>> fs/xfs/xfs_attr_item.c: xfs_shared.h is included more than once.
>> /kbuild/src/consumer/fs/xfs/xfs_attr_item.c: xfs_log_format.h is included more than once.
>> /kbuild/src/consumer/fs/xfs/xfs_attr_item.c: xfs_da_format.h is included more than once.
>> /kbuild/src/consumer/fs/xfs/xfs_attr_item.c: xfs_inode.h is included more than once.
>> /kbuild/src/consumer/fs/xfs/xfs_attr_item.c: xfs_attr_item.h is included more than once.
>> /kbuild/src/consumer/fs/xfs/xfs_attr_item.c: xfs_bmap.h is included more than once.
--
>> fs/xfs/xfs_xattr.c: xfs_da_btree.h is included more than once.

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
