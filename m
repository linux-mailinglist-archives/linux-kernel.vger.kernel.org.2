Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A536F447E0E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238238AbhKHKjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:39:08 -0500
Received: from mga05.intel.com ([192.55.52.43]:3547 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236895AbhKHKjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:39:04 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10161"; a="318401899"
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="318401899"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 02:36:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="601368940"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 08 Nov 2021 02:36:16 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mk20e-000Bus-1D; Mon, 08 Nov 2021 10:36:16 +0000
Date:   Mon, 8 Nov 2021 18:35:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Schnelle <svens@stackframe.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Helge Deller <deller@gmx.de>
Subject: [RFC PATCH deller-parisc] hpmc_addr can be static
Message-ID: <20211108103546.GA42682@0ee8734adabc>
References: <202111081813.jnmMVQMT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202111081813.jnmMVQMT-lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/tty/sysrq.c:150:15: warning: symbol 'hpmc_addr' was not declared. Should it be static?

Fixes: c743202c8e5c ("hpmc trigger")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 sysrq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index b8a982f12ba9f..c95b22fe3cd26 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -147,7 +147,7 @@ static const struct sysrq_key_op sysrq_unraw_op = {
 #define sysrq_unraw_op (*(const struct sysrq_key_op *)NULL)
 #endif /* CONFIG_VT */
 
-unsigned long *hpmc_addr;
+static unsigned long *hpmc_addr;
 static void sysrq_handle_crash(int key)
 {
 	/* release the RCU read lock before crashing */
