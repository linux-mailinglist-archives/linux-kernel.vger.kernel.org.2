Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7D33B884B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 20:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbhF3SYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 14:24:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:43686 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232992AbhF3SYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 14:24:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10031"; a="294042746"
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="294042746"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 11:22:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="457356778"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 30 Jun 2021 11:22:01 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lyeqW-0009w2-SU; Wed, 30 Jun 2021 18:22:00 +0000
Date:   Thu, 1 Jul 2021 02:21:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>, axboe@kernel.dk
Cc:     kbuild-all@lists.01.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
Subject: [RFC PATCH] block: print_disk_stats() can be static
Message-ID: <20210630182114.GA45709@e2f15dc0397a>
References: <20210630081028.161284-1-abd.masalkhi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630081028.161284-1-abd.masalkhi@gmail.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

block/genhd.c:1110:6: warning: symbol 'print_disk_stats' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 genhd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 5d393b2bc62c3..803c3448f09ae 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1107,8 +1107,8 @@ const struct device_type disk_type = {
 
 #ifdef CONFIG_PROC_FS
 
-void print_disk_stats(struct seq_file *seqf,
-		      unsigned int inflight, struct disk_stats *stat)
+static void print_disk_stats(struct seq_file *seqf,
+			     unsigned int inflight, struct disk_stats *stat)
 {
 	seq_printf(seqf, "%lu %lu %lu %u "
 		   "%lu %lu %lu %u "
