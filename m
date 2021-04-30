Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92EE36F4E2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 06:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhD3EXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 00:23:11 -0400
Received: from rcdn-iport-2.cisco.com ([173.37.86.73]:6970 "EHLO
        rcdn-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbhD3EXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 00:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1687; q=dns/txt; s=iport;
  t=1619756543; x=1620966143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TkQgQOtm5mZuEq1qK8DidKTwwGyVW3o6m8nKOrtHYls=;
  b=HHseR5yJVCcefXTi7hoSlAWnhyUTBzFyxkZJfdupOTYrE/Isc7cRZZat
   yDf0u3BY0+Q77qcmVlZk/l8KS8xhCkYMECm283RfguhY2ROJw55mdhTvI
   RnXUixaEVnw9x51iNp2bvzgiSvmXRqlZCoSTSrNVhrmzCNnjgpdQ9wzHK
   E=;
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AmM+Zj6N7o1EybMBcT5z155DYdL4zR+YMi2?=
 =?us-ascii?q?QD/UoZc3BoW+afkN2jm+le6AT9jywfVGpltdeLPqSBRn20z+8Q3aA9NaqvNT?=
 =?us-ascii?q?OJhEKGN4dnhLGJ/xTBHGnE+vdZxeNcdcFFeb7NJHxbqeq/3wWiCdYnx7C8gc?=
 =?us-ascii?q?WVrMPT1W1kQw0vS6wI1WZEIz2WGEF3WwVKbKBRfPGhz/FKqDa6dXMcYt7TPA?=
 =?us-ascii?q?hmY8H4u9bJmJj6CCRoOzcb7mC14A+A2frTDwWfmiwTSSpIxq0vtVLYihXj6r?=
 =?us-ascii?q?+42svLrSP05iv255RSlMCJ8Lt+Lf3JrNQJITPxjQvtQ4JtV9S5zUkIidDqzk?=
 =?us-ascii?q?o2m9/RpBplBeBP0jf6e2G4pgaF4XiH7AoT?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BVAADbhItg/4cNJK1aHAEBAQEBAQc?=
 =?us-ascii?q?BARIBAQQEAQGCAwcBAQsBAYIpgU0BOTGMaKRRgXwLAQEBDzQEAQGEUAKBewI?=
 =?us-ascii?q?lNAkOAgQBAQwBAQUBAQECAQYEcROFXUMWAYVrBjIBRhBRVwYBEoJxgwioVII?=
 =?us-ascii?q?sgQGIMoFEFIEmAYhsdIN2ByAcgUlChHWIB4IzBIJHgQ+CcpQKinKcPYMagSe?=
 =?us-ascii?q?bcxAmpR2VKp9UhDA1gR86gVkzGggbFYMkUBkOjisWjkshAy84AgYKAQEDCYl?=
 =?us-ascii?q?Og0EBAQ?=
X-IronPort-AV: E=Sophos;i="5.82,260,1613433600"; 
   d="scan'208";a="892827651"
Received: from alln-core-2.cisco.com ([173.36.13.135])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 30 Apr 2021 04:22:21 +0000
Received: from zorba.cisco.com ([10.24.18.92])
        by alln-core-2.cisco.com (8.15.2/8.15.2) with ESMTP id 13U4MHxw023118;
        Fri, 30 Apr 2021 04:22:20 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        xe-linux-external@cisco.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] x86: switch amd mem encrypt to early string functions
Date:   Thu, 29 Apr 2021 21:22:16 -0700
Message-Id: <20210430042217.1198052-3-danielwa@cisco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210430042217.1198052-1-danielwa@cisco.com>
References: <20210430042217.1198052-1-danielwa@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.24.18.92, [10.24.18.92]
X-Outbound-Node: alln-core-2.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This switched x86 early string users to use the early string variants
and re-enabled KASAN on general string functions use thru out the rest
of the system.

Cc: xe-linux-external@cisco.com
Signed-off-by: Daniel Walker <danielwa@cisco.com>
---
 arch/x86/mm/mem_encrypt_identity.c | 4 ++--
 lib/Makefile                       | 7 -------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 6c5eb6f3f14f..212fe90cf5e2 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -575,9 +575,9 @@ void __init sme_enable(struct boot_params *bp)
 
 	cmdline_find_option(cmdline_ptr, cmdline_arg, buffer, sizeof(buffer));
 
-	if (!strncmp(buffer, cmdline_on, sizeof(buffer)))
+	if (!early_strncmp(buffer, cmdline_on, sizeof(buffer)))
 		sme_me_mask = me_mask;
-	else if (!strncmp(buffer, cmdline_off, sizeof(buffer)))
+	else if (!early_strncmp(buffer, cmdline_off, sizeof(buffer)))
 		sme_me_mask = 0;
 	else
 		sme_me_mask = active_by_default ? me_mask : 0;
diff --git a/lib/Makefile b/lib/Makefile
index 25cc664f027e..314db12c0e98 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -28,13 +28,6 @@ KASAN_SANITIZE_early_string.nosan.o := n
 
 CFLAGS_early_string.nosan.o += -fno-stack-protector
 
-# Early boot use of cmdline, don't instrument it
-ifdef CONFIG_AMD_MEM_ENCRYPT
-KASAN_SANITIZE_string.o := n
-
-CFLAGS_string.o += -fno-stack-protector
-endif
-
 $(obj)/early_string.nosan.o: $(src)/early_string.c $(recordmcount_source) $(objtool_dep) FORCE
 	$(call if_changed_rule,cc_o_c)
 	$(call cmd,force_checksrc)
-- 
2.25.1

