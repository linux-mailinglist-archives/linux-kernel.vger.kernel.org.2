Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1FEA3BF56A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 08:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhGHGTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 02:19:08 -0400
Received: from mga06.intel.com ([134.134.136.31]:11254 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229658AbhGHGTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 02:19:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10038"; a="270563986"
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="270563986"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 23:16:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="648276238"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 07 Jul 2021 23:16:25 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m1NKi-000E7p-HA; Thu, 08 Jul 2021 06:16:24 +0000
Date:   Thu, 8 Jul 2021 14:15:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH joro] x86/sev: sev_jumptable_ap_park() can be static
Message-ID: <20210708061557.GA46859@4fc2f788f564>
References: <202107081415.O6XWbobR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202107081415.O6XWbobR-lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/x86/kernel/sev.c:698:17: warning: symbol 'sev_jumptable_ap_park' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 sev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index bac9bb4fa54e0..3afddbd831b7a 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -695,7 +695,7 @@ static bool __init sev_es_setup_ghcb(void)
 	return true;
 }
 
-void __noreturn sev_jumptable_ap_park(void)
+static void __noreturn sev_jumptable_ap_park(void)
 {
 	local_irq_disable();
 
