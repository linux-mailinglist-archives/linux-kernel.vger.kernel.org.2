Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BF43A46B4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhFKQoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:44:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:30442 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231166AbhFKQoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:44:00 -0400
IronPort-SDR: gUb3Hl7rcA/3BNKAoNGkPfMF51AeE/w1T5MDsI33yNXejD9h9JMQXWHzqCRz7fj2DLY9NBcgXA
 Fiu8u8ec0y0Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="185935766"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="185935766"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 09:42:01 -0700
IronPort-SDR: wRPaDX1gGG8fOu6fJr+Iegl09SZ7B5jfVlVexaS3j0Vgf2plRYPCHLwQDi6zEETFVW7BHWpFGP
 pIIiago9GOCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="620429251"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga005.jf.intel.com with ESMTP; 11 Jun 2021 09:42:00 -0700
Subject: [PATCH 3/4] selftests/vm/pkeys: Refill shadow register after implicit kernel write
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
Date:   Fri, 11 Jun 2021 09:42:00 -0700
References: <20210611164153.91B76FB8@viggo.jf.intel.com>
In-Reply-To: <20210611164153.91B76FB8@viggo.jf.intel.com>
Message-Id: <20210611164200.EF76AB73@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

The pkey test code keeps a "shadow" of the pkey register around.  This
ensures that any bugs which might write to the register can be caught
more quickly.

Generally, userspace has a good idea when the kernel is going to write
to the register.  For instance, alloc_pkey() is passed a permission
mask.  The caller of alloc_pkey() can update the shadow based on the
return value and the mask.

But, the kernel can also modify the pkey register in a more sneaky
way.  For mprotect(PROT_EXEC) mappings, the kernel will allocate a
pkey and write the pkey register to create an execute-only mapping.
The kernel never tells userspace what key it uses for this.

This can cause the test to fail with messages like:

	protection_keys_64.2: pkey-helpers.h:132: _read_pkey_reg: Assertion `pkey_reg == shadow_pkey_reg' failed.

because the shadow was not updated with the new kernel-set value.

Forcibly update the shadow value immediately after an mprotect().

Fixes: 6af17cf89e99 ("x86/pkeys/selftests: Add PROT_EXEC test")
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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

 b/tools/testing/selftests/vm/protection_keys.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff -puN tools/testing/selftests/vm/protection_keys.c~selftests_vm_pkeys_Refill_shadow_register_after_implict_kernel_write-1 tools/testing/selftests/vm/protection_keys.c
--- a/tools/testing/selftests/vm/protection_keys.c~selftests_vm_pkeys_Refill_shadow_register_after_implict_kernel_write-1	2021-06-11 09:41:33.508468061 -0700
+++ b/tools/testing/selftests/vm/protection_keys.c	2021-06-11 09:41:33.517468061 -0700
@@ -1448,6 +1448,13 @@ void test_implicit_mprotect_exec_only_me
 	ret = mprotect(p1, PAGE_SIZE, PROT_EXEC);
 	pkey_assert(!ret);
 
+	/*
+	 * Reset the shadow, assuming that the above mprotect()
+	 * correctly changed PKRU, but to an unknown value since
+	 * the actual alllocated pkey is unknown.
+	 */
+	shadow_pkey_reg = __read_pkey_reg();
+
 	dprintf2("pkey_reg: %016llx\n", read_pkey_reg());
 
 	/* Make sure this is an *instruction* fault */
_
