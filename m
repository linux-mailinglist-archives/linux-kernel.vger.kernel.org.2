Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEDE40ECAE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 23:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240588AbhIPVdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 17:33:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:30586 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240568AbhIPVdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 17:33:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="245049146"
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="245049146"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 14:31:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="610823273"
Received: from lkp-server01.sh.intel.com (HELO 285e7b116627) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 16 Sep 2021 14:31:56 -0700
Received: from kbuild by 285e7b116627 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mQyz5-0001Rj-Nt; Thu, 16 Sep 2021 21:31:55 +0000
Date:   Fri, 17 Sep 2021 05:31:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, dan.j.williams@intel.com,
        Luca Coelho <luciano.coelho@intel.com>
Subject: drivers/net/wireless/intel/iwlwifi/fw/notif-wait.c:1:0: warning:
 dual license is used, are you sure you want to do this.
Message-ID: <202109170547.aahNWXFL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b60cee5bae733f49ba33840804c159a8e474cfda
commit: 8e99ea8d09a159d46069faef10721a3f8436d2fd iwlwifi: use SPDX tags
date:   9 months ago

While copyright holders are free to license their software any
way they see fit, the kernel community prefers GPL-2.0-only or
GPL-2.0-or-later for kernel contributions.

If you are sure you want to submit with a dual license, please
ensure that your commit message calls out the practical reasons
for which you want to do this, including the specific other
projects you expect to make use of this code.

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


dualliccheck warnings: (new ones prefixed by >>)
>> drivers/net/wireless/intel/iwlwifi/fw/notif-wait.c:1:0: warning: dual license is used, are you sure you want to do this.
--
>> drivers/net/wireless/intel/iwlwifi/pcie/tx.c:1:0: warning: dual license is used, are you sure you want to do this.
--
>> drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c:1:0: warning: dual license is used, are you sure you want to do this.

vim +1 drivers/net/wireless/intel/iwlwifi/fw/notif-wait.c

   > 1	// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
     2	/*
     3	 * Copyright (C) 2005-2014 Intel Corporation
     4	 * Copyright (C) 2015-2017 Intel Deutschland GmbH
     5	 */
     6	#include <linux/sched.h>
     7	#include <linux/export.h>
     8	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
