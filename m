Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E53F3A46B2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhFKQn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:43:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:45506 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230469AbhFKQn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:43:56 -0400
IronPort-SDR: 9Ihj0pBvveyWhdD0hJqBhiL+M2lBDIaSdhCIvzjAcO1QozvVgXdIwEeeiDkVe4z1BxejhoR9ZZ
 gMITm2IW33LQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="192670773"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="192670773"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 09:41:56 -0700
IronPort-SDR: lUbd/cezG/WIoeYhLWfpKT7TAWTnR53Ta8JFebAxza+auFaTWefdJRvLcFLUEX09wp+JBQJF5w
 nHDtT76H4G8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="420122331"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga002.jf.intel.com with ESMTP; 11 Jun 2021 09:41:56 -0700
Subject: [PATCH 1/4] selftests/vm/pkeys: Fix alloc_random_pkey() to make it really, really random
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
Date:   Fri, 11 Jun 2021 09:41:55 -0700
References: <20210611164153.91B76FB8@viggo.jf.intel.com>
In-Reply-To: <20210611164153.91B76FB8@viggo.jf.intel.com>
Message-Id: <20210611164155.192D00FF@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

The "random" pkey allocation code currently does the good old:

	srand((unsigned int)time(NULL));

*But*, it unfortunately does this on every random pkey allocation.

There may be thousands of these a second.  time() has a one second
resolution.  So, each time alloc_random_pkey() is called, the PRNG is
*RESET* to time().  This is nasty.  Normally, if you do:

	srand(<ANYTHING>);
	foo = rand();
	bar = rand();

You'll be quite guaranteed that 'foo' and 'bar' are different.
But, if you do:

	srand(1);
	foo = rand();
	srand(1);
	bar = rand();

You are quite guaranteed that 'foo' and 'bar' are the *SAME*.
The recent "fix" effectively forced the test case to use the
same "random" pkey for the whole test, unless the test run
crossed a second boundary.

Only run srand() once at program startup.

This explains some very odd and persistent test failures I've been
seeing.

Fixes: 6e373263ce07 ("selftests/vm/pkeys: fix alloc_random_pkey() to make it really random")
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

 b/tools/testing/selftests/vm/protection_keys.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -puN tools/testing/selftests/vm/protection_keys.c~selftests_vm_pkeys_Fix_alloc_random_pkey_to_make_it_really_really_random-1 tools/testing/selftests/vm/protection_keys.c
--- a/tools/testing/selftests/vm/protection_keys.c~selftests_vm_pkeys_Fix_alloc_random_pkey_to_make_it_really_really_random-1	2021-06-11 09:41:31.385468066 -0700
+++ b/tools/testing/selftests/vm/protection_keys.c	2021-06-11 09:41:31.389468066 -0700
@@ -561,7 +561,6 @@ int alloc_random_pkey(void)
 	int nr_alloced = 0;
 	int random_index;
 	memset(alloced_pkeys, 0, sizeof(alloced_pkeys));
-	srand((unsigned int)time(NULL));
 
 	/* allocate every possible key and make a note of which ones we got */
 	max_nr_pkey_allocs = NR_PKEYS;
@@ -1552,6 +1551,8 @@ int main(void)
 	int nr_iterations = 22;
 	int pkeys_supported = is_pkeys_supported();
 
+	srand((unsigned int)time(NULL));
+
 	setup_handlers();
 
 	printf("has pkeys: %d\n", pkeys_supported);
_
