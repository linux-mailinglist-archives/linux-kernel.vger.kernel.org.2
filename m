Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B46410BC9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 15:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhISNkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 09:40:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:62057 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230520AbhISNj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 09:39:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10111"; a="219826333"
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; 
   d="gz'50?scan'50,208,50";a="219826333"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2021 06:38:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; 
   d="gz'50?scan'50,208,50";a="473026105"
Received: from lkp-server01.sh.intel.com (HELO 285e7b116627) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 19 Sep 2021 06:38:26 -0700
Received: from kbuild by 285e7b116627 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mRx1V-0005Uo-Gb; Sun, 19 Sep 2021 13:38:25 +0000
Date:   Sun, 19 Sep 2021 21:38:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Gross <mgross@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [linux-stable-rc:linux-4.9.y 9966/9999] htmldocs: warning: jobserver
 unavailable: using -j1. Add '+' to parent make rule.
Message-ID: <202109192104.bP1TrI4I-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
head:   6940a98776c9014fdcc806e39ab0ebc8316cf241
commit: 2808035ba55eb8aaaf5eb37421dbfff37c1f25a8 [9966/9999] x86/speculation: Add SRBDS vulnerability and mitigation documentation
reproduce: make htmldocs

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

warning: jobserver unavailable: using -j1. Add '+' to parent make rule.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--h31gzZEtNLTqOjlF
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
RCc/9wdWUeYYwVoAAA==

--h31gzZEtNLTqOjlF--
