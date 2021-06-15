Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996B03A7332
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 03:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhFOBFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 21:05:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:27306 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230396AbhFOBFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 21:05:38 -0400
IronPort-SDR: kdLTTB5UeE4eYAWQ+nBmWdtx9+Ga7+7kGbuvtC+X/Xa+SoaUh6OVfKhTOObEwnNtgiWncT7t8C
 so7/5KeGR50g==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="205862049"
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="205862049"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 18:03:34 -0700
IronPort-SDR: VYYbI4GAqTKFXa3ENScfhPbay8UDKy2pqoirUVgkiaEXf/JUf95F7yE6E2ISWeWFxTiNV95xxQ
 1hNgz3l/wqcQ==
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="554283036"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.11])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 18:03:32 -0700
Date:   Tue, 15 Jun 2021 09:03:31 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [tip:tmp.tmp2 176/364] fs/ocfs2/dir.c: linux/iversion.h is included
 more than once.
Message-ID: <20210615010331.GG237458@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tmp.tmp2
head:   adcceb5eb7aee38e4a9c15bdf599655f0e1b1324
commit: be65473fb5b77d57d8955beffd5aa370cfdae467 [176/364] sched/headers, rcu: Remove <linux/sched/signal.h> dependency from <linux/rcuwait.h>
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> fs/ocfs2/dir.c: linux/iversion.h is included more than once.

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
