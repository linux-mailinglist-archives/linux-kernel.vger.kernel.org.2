Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDAA638C0BF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 09:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbhEUHcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 03:32:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:64357 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231915AbhEUHcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 03:32:11 -0400
IronPort-SDR: +qSbFxLhmhhFTufd8wuzKI6QAOZsJPqdVqYL3ScBh4eMKKrYo5oh5zneentjY+Pv9akzHTd/MD
 9RJzWLk9h2sA==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="181037125"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="181037125"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 00:30:48 -0700
IronPort-SDR: w94Dsw6lZXRIUoFh6sil634yi24Bn3gEe2s3VAtD4+Vbe22Abde9UGe40QNQ3wpVCGkGSU6ReI
 ckCLfPvlly9A==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="474408644"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.11])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 00:30:45 -0700
Date:   Fri, 21 May 2021 15:29:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kbuild-all@lists.01.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: [wagi-linux-stable-rt:v4.19-rt 43/48] include/linux/blk-cgroup.h:
 linux/kthread.h is included more than once.
Message-ID: <20210521072932.GZ2687475@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/wagi/linux-stable-rt.git v4.19-rt
head:   bd81dbe40b89ec503144c58b7ea8cf8d5ff67f83
commit: 827b6f6962daf2e13170c0185c0f7b51cf74a0ed [43/48] workqueue: rework
:::::: branch date: 1 year, 7 months ago
:::::: commit date: 1 year, 8 months ago
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> include/linux/blk-cgroup.h: linux/kthread.h is included more than once.

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
