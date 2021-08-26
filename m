Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A443F7F3B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 02:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbhHZAKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 20:10:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:9947 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231535AbhHZAKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 20:10:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10087"; a="214510333"
X-IronPort-AV: E=Sophos;i="5.84,352,1620716400"; 
   d="scan'208";a="214510333"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 17:09:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,352,1620716400"; 
   d="scan'208";a="684693185"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 25 Aug 2021 17:09:34 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mJ2xZ-0000cc-MQ; Thu, 26 Aug 2021 00:09:33 +0000
Date:   Thu, 26 Aug 2021 08:09:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [agd5f:audio-for-next 152/153]
 sound/soc/amd/vangogh/acp5x-nu8821-cs35l41.c: linux/module.h is included
 more than once.
Message-ID: <202108260818.OklsIKp1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git audio-for-next
head:   b50aaad40c792ec71a1d51622bc50aca608e8b55
commit: e9922f67385913c3d2a318b4b92f6a5ea19c0b65 [152/153] ASoC: amd: add machine driver for VG platform
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> sound/soc/amd/vangogh/acp5x-nu8821-cs35l41.c: linux/module.h is included more than once.
>> /kbuild/src/consumer/sound/soc/amd/vangogh/acp5x-nu8821-cs35l41.c: linux/io.h is included more than once.

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
