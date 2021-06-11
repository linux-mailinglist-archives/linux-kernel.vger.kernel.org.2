Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D94E3A46B3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhFKQn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:43:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:18254 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231166AbhFKQn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:43:57 -0400
IronPort-SDR: 7Q45vBrva1qvq4b6t0MCRkjoms+yVZRgQ9RRKJj+Vj5YrNO0+y/FoSwQ+NSOhr1fX6FwjNJwma
 mdQkjnw61IgQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="269410294"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="269410294"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 09:41:59 -0700
IronPort-SDR: NGXCGd65aHXP1eWWzOdd+o+XLlDI9Az4nz+l4W8gWmXHs5ouLVCoQvIjX8mYTnm+TVbAz1FQoL
 o13WAem5nPZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="470684657"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jun 2021 09:41:58 -0700
Subject: [PATCH 2/4] selftests/vm/pkeys: Handle negative sys_pkey_alloc() return code
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>, tglx@linutronix.de,
        linuxram@us.ibm.com, sandipan@linux.ibm.com,
        akpm@linux-foundation.org, fweimer@redhat.com,
        desnesn@linux.vnet.ibm.com, mingo@kernel.org,
        bauerman@linux.ibm.com, aneesh.kumar@linux.ibm.com,
        mpe@ellerman.id.au, mhocko@kernel.org, msuchanek@suse.de,
        shuah@kernel.org, x86@kernel.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri, 11 Jun 2021 09:41:57 -0700
References: <20210611164153.91B76FB8@viggo.jf.intel.com>
In-Reply-To: <20210611164153.91B76FB8@viggo.jf.intel.com>
Message-Id: <20210611164157.87AB4246@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

The alloc_pkey() sefltest function wraps the sys_pkey_alloc() system
call.  On success, it updates its "shadow" register value because
sys_pkey_alloc() updates the real register.

But, the success check is wrong.  pkey_alloc() considers any
non-zero return code to indicate success where the pkey register
will be modified.  This fails to take negative return codes into
account.

Consider only a positive return value as a successful call.

Fixes: 5f23f6d082a9 ("x86/pkeys: Add self-tests")
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Sandipan Das <sandipan@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: "Desnes A. Nunes do Rosario" <desnesn@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Michal Suchanek <msuchanek@suse.de>
Cc: Shuah Khan <shuah@kernel.org>
Cc: x86@kernel.org
---

 b/tools/testing/selftests/vm/protection_keys.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN tools/testing/selftests/vm/protection_keys.c~selftests_vm_pkeys_ret-code tools/testing/selftests/vm/protection_keys.c
--- a/tools/testing/selftests/vm/protection_keys.c~selftests_vm_pkeys_ret-code	2021-06-11 09:41:32.448468063 -0700
+++ b/tools/testing/selftests/vm/protection_keys.c	2021-06-11 09:41:32.453468063 -0700
@@ -510,7 +510,7 @@ int alloc_pkey(void)
 			" shadow: 0x%016llx\n",
 			__func__, __LINE__, ret, __read_pkey_reg(),
 			shadow_pkey_reg);
-	if (ret) {
+	if (ret > 0) {
 		/* clear both the bits: */
 		shadow_pkey_reg = set_pkey_bits(shadow_pkey_reg, ret,
 						~PKEY_MASK);
_
