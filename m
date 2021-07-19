Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181BC3CCD72
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 07:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbhGSFjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 01:39:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:7698 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229577AbhGSFi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 01:38:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10049"; a="198196722"
X-IronPort-AV: E=Sophos;i="5.84,251,1620716400"; 
   d="scan'208";a="198196722"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2021 22:36:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,251,1620716400"; 
   d="scan'208";a="493875420"
Received: from lkp-server01.sh.intel.com (HELO a467b34d8c10) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 18 Jul 2021 22:35:58 -0700
Received: from kbuild by a467b34d8c10 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m5Lwc-0000ZR-94; Mon, 19 Jul 2021 05:35:58 +0000
Date:   Mon, 19 Jul 2021 13:35:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Allison Henderson <allison.henderson@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>
Subject: [RFC PATCH allisonhenderson-xfs_work] xfs:
 xfs_calc_namespace_reservations can be static
Message-ID: <20210719053536.GA4772@67baee1309a0>
References: <202107191319.2fxl9QwZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202107191319.2fxl9QwZ-lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fs/xfs/libxfs/xfs_trans_resv.c:854:1: warning: symbol 'xfs_calc_namespace_reservations' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 xfs_trans_resv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
index 9cc18a9354525..f307275eb6368 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.c
+++ b/fs/xfs/libxfs/xfs_trans_resv.c
@@ -850,7 +850,7 @@ xfs_calc_sb_reservation(
  * addressed later when modifications are made to ensure parent attribute
  * modifications can be done atomically with the rename operation.
  */
-void
+static void
 xfs_calc_namespace_reservations(
 	struct xfs_mount	*mp,
 	struct xfs_trans_resv	*resp)
