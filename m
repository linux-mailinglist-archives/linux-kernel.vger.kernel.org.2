Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95117454EC1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 21:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbhKQUwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 15:52:13 -0500
Received: from mga17.intel.com ([192.55.52.151]:32204 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235365AbhKQUwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 15:52:04 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="214770540"
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="214770540"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 12:46:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="454786618"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 17 Nov 2021 12:46:15 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mnRos-0002Da-SZ; Wed, 17 Nov 2021 20:46:14 +0000
Date:   Thu, 18 Nov 2021 04:45:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Roth <michael.roth@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [RFC PATCH joro] x86/compressed/64: sev_prep_identity_maps() can be
 static
Message-ID: <20211117204520.GA26242@6d6ae136a407>
References: <202111180417.9qVNN9Gn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202111180417.9qVNN9Gn-lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/x86/boot/compressed/ident_map_64.c:111:6: warning: symbol 'sev_prep_identity_maps' was not declared. Should it be static?

Fixes: 3ef653bfccaa ("x86/compressed/64: add identity mapping for Confidential Computing blob")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 ident_map_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 10ecbc53f8bc2..7087c3e27a6f0 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -108,7 +108,7 @@ static void add_identity_map(unsigned long start, unsigned long end)
 		error("Error: kernel_ident_mapping_init() failed\n");
 }
 
-void sev_prep_identity_maps(void)
+static void sev_prep_identity_maps(void)
 {
 	/*
 	 * The ConfidentialComputing blob is used very early in uncompressed
