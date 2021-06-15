Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED313A74D5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 05:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhFODR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 23:17:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:55852 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229868AbhFODRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 23:17:23 -0400
IronPort-SDR: MLdSC1U8GHFv4yz4xk0VUy2hyDjzzZjSNmpLG0VfMywiC2PvkOs90NM/8F0DFOjJdrs2esoKNN
 YoMJCHmTrE6A==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="193019194"
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="193019194"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 18:07:08 -0700
IronPort-SDR: yODB0jA+zWPc9TGxtcVoaRMzg7sDW3UvRpBCLr18sOl3n6v4CPR1cVJ3LLMONGSC1LiRMtdLG5
 sjatvp7YO8QQ==
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="554283648"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.11])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 18:07:05 -0700
Date:   Tue, 15 Jun 2021 09:07:03 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Wengang Wang <wen.gang.wang@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [tip:tmp.tmp2 290/364] fs/ocfs2/dlm/dlmrecovery.c:
 linux/stringhash.h is included more than once.
Message-ID: <20210615010703.GK237458@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tmp.tmp2
head:   adcceb5eb7aee38e4a9c15bdf599655f0e1b1324
commit: b6aa10593ad119b8d92047471b69297bcdf70684 [290/364] sched/headers, fs: Optimize <linux/fs.h> header dependencies
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> fs/ocfs2/dlm/dlmrecovery.c: linux/stringhash.h is included more than once.

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
