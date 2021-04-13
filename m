Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBC335D7D6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 08:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344927AbhDMGPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 02:15:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:61621 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242204AbhDMGPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 02:15:39 -0400
IronPort-SDR: /W11ztF5uXnlSrC/oJS1d0ZrxXTIK/hY8gzkBdfOPLiK6B5a5oPOlf0Rk93IkpTlrJaySclsiB
 6IUhoAECxp1Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="194379759"
X-IronPort-AV: E=Sophos;i="5.82,218,1613462400"; 
   d="scan'208";a="194379759"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 23:15:20 -0700
IronPort-SDR: VbpwQjH0nfseXLn5YEhVhx8Z3sDRQzgkb0CmVtgQF/tIG0jtwXswx96eSJhktd3Vns/QkBBLUR
 87gci0jZxFog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,218,1613462400"; 
   d="scan'208";a="460467534"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 12 Apr 2021 23:15:18 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lWCKU-0000rb-05; Tue, 13 Apr 2021 06:15:18 +0000
Date:   Tue, 13 Apr 2021 14:14:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     brookxu <brookxu.cn@gmail.com>, adobriyan@gmail.com,
        bsingharora@gmail.com, akpm@linux-foundation.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: [RFC PATCH] delayacct: delayacct_stats[] can be static
Message-ID: <20210413061422.GA20444@5a950bd79ae1>
References: <99fd223ec19a6bc17fa5b39aaf6aed6cbdbea722.1618275619.git.brookxu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99fd223ec19a6bc17fa5b39aaf6aed6cbdbea722.1618275619.git.brookxu@tencent.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 delayacct.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index b8d719fbfc404..2505aa9f87f61 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -32,7 +32,7 @@ struct delayacct_stat {
 	unsigned int idx;
 };
 
-struct delayacct_stat delayacct_stats[] = {
+static struct delayacct_stat delayacct_stats[] = {
 	{"blkio", DELAYACCT_BLKIO},
 	{"swapin", DELAYACCT_SWAPIN},
 	{"pagecache_thrashing", DELAYACCT_THRASHING},
