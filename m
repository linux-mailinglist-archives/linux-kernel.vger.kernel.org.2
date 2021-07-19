Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DDC3CCCCC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 05:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbhGSDr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 23:47:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:8224 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234268AbhGSDr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 23:47:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10049"; a="274813880"
X-IronPort-AV: E=Sophos;i="5.84,251,1620716400"; 
   d="scan'208";a="274813880"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2021 20:44:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,251,1620716400"; 
   d="scan'208";a="430499117"
Received: from lkp-server01.sh.intel.com (HELO a467b34d8c10) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jul 2021 20:44:56 -0700
Received: from kbuild by a467b34d8c10 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m5KD9-0000Y9-Vw; Mon, 19 Jul 2021 03:44:55 +0000
Date:   Mon, 19 Jul 2021 11:44:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Allison Henderson <allison.henderson@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH allisonhenderson-xfs_work] xfs:
 xfs_trans_attr_finish_update can be static
Message-ID: <20210719034442.GA51111@67baee1309a0>
References: <202107191127.kQqGprKw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202107191127.kQqGprKw-lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fs/xfs/xfs_attr_item.c:292:1: warning: symbol 'xfs_trans_attr_finish_update' was not declared. Should it be static?
fs/xfs/xfs_attr_item.c:496:27: warning: symbol 'xfs_trans_get_attrd' was not declared. Should it be static?

Fixes: ba1114fc490c ("xfs: Implement attr logging and replay")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 xfs_attr_item.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_attr_item.c b/fs/xfs/xfs_attr_item.c
index eda6ae3a39880..7d77de9e12781 100644
--- a/fs/xfs/xfs_attr_item.c
+++ b/fs/xfs/xfs_attr_item.c
@@ -288,7 +288,7 @@ xfs_attrd_item_release(
  * transaction is marked dirty regardless of whether the operation succeeds or
  * fails to support the ATTRI/ATTRD lifecycle rules.
  */
-int
+static int
 xfs_trans_attr_finish_update(
 	struct xfs_delattr_context	*dac,
 	struct xfs_attrd_log_item	*attrdp,
@@ -493,7 +493,7 @@ xfs_attri_item_match(
 /*
  * This routine is called to allocate an "attr free done" log item.
  */
-struct xfs_attrd_log_item *
+static struct xfs_attrd_log_item *
 xfs_trans_get_attrd(struct xfs_trans		*tp,
 		  struct xfs_attri_log_item	*attrip)
 {
