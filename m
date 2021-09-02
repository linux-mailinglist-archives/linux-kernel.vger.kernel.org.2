Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA4B3FE856
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 06:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhIBETQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 00:19:16 -0400
Received: from mga12.intel.com ([192.55.52.136]:29881 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231298AbhIBETO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 00:19:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="198514701"
X-IronPort-AV: E=Sophos;i="5.84,371,1620716400"; 
   d="scan'208";a="198514701"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 21:18:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,371,1620716400"; 
   d="scan'208";a="542336836"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 01 Sep 2021 21:18:15 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mLeB4-0008bB-Ei; Thu, 02 Sep 2021 04:18:14 +0000
Date:   Thu, 2 Sep 2021 12:17:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC PATCH intel-tdx] x86/tdx: x86_disable_prot can be static
Message-ID: <20210902041720.GA47763@e994d071fa58>
References: <202109021222.Ayz3RnA1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109021222.Ayz3RnA1-lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/x86/kernel/cpu/intel.c:66:14: warning: symbol 'x86_disable_prot' was not declared. Should it be static?

Fixes: 88ae938a9403 ("x86/tdx: Add option to override prot values")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 intel.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index d2b3527b2c71a..187bea52363b7 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -63,7 +63,7 @@ static bool cpu_model_supports_sld __ro_after_init;
 
 #ifdef CONFIG_ARCH_HAS_PROTECTED_GUEST
 
-unsigned int x86_disable_prot = -1;
+static unsigned int x86_disable_prot = -1;
 
 static int __init x86_prot_clear_setup(char *arg)
 {
