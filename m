Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21E833C15D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhCOQN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbhCOQNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:13:00 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AC0C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=+6eGNAxCCzsinN613dBMc6kAMFAKurkVTuSRV93npR0=; b=qCgL+p+XAMigWTVPPgTX5urLQr
        Rag0TjvQJqm0DsVz0EgYoxmViqiPZt2ql39zh+lYctQuZiJ26MCKKKV27/ZSwPrhWB+l86bzC791Q
        KPES6F47Pu+PGQ3OrrHpARZLcB1W8nR3/dBod2iOPylxc8aJ5rcxPu5RVlTevnAeyqmGI+Eth+3xP
        ci7KUuC0raXqtgNWPvbYx4VfYX+luKm5r7cWJvLea2uBBZZhTrDZlUhtc9SAG9Y+CofJBvaO+lLpZ
        0Zhd4sS1enNetXo3WPAvKJupaOv5eFSiK6pTA6bfZRCQv6xUCrsUPD8qPYh798P6DpcNJrtam/K4f
        it0hwPCQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lLppu-00GKNt-8l; Mon, 15 Mar 2021 16:12:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BBE3830700B;
        Mon, 15 Mar 2021 17:12:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7AF412D8B225F; Mon, 15 Mar 2021 17:12:53 +0100 (CET)
Date:   Mon, 15 Mar 2021 17:12:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, tony.luck@intel.com
Cc:     "Liang, Kan" <kan.liang@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/cpu: Resort and comment Intel models
Message-ID: <YE+HhS8i0gshHD3W@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The INTEL_FAM6 list has become a mess again. Try and bring some sanity
back into it.

Where previously we had one microarch per year and a number of SKUs
within that, this no longer seems to be the case. We now get dfferent
uarch names that share a 'core' design.

Add the core name starting at skylake and reorder to keep the cores in
chronological order. Furthermore, Intel marketed the names {Amber,
Coffee, Whiskey} Lake, but those are in fact steppings of Kaby Lake, add
comments for them.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
Note: we don't seem to have CANNONLAKE perf support.

 arch/x86/include/asm/intel-family.h | 50 +++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 9abe842dbd84..b15262f1f645 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -32,7 +32,9 @@
  *		_EP	- 2 socket server parts
  *		_EX	- 4+ socket server parts
  *
- * The #define line may optionally include a comment including platform names.
+ * The #define line may optionally include a comment including platform or core
+ * names. An exception is made for kabylake where steppings seem to have gotten
+ * their own names :-(
  */
 
 /* Wildcard match for FAM6 so X86_MATCH_INTEL_FAM6_MODEL(ANY) works */
@@ -69,35 +71,39 @@
 #define INTEL_FAM6_BROADWELL_X		0x4F
 #define INTEL_FAM6_BROADWELL_D		0x56
 
-#define INTEL_FAM6_SKYLAKE_L		0x4E
-#define INTEL_FAM6_SKYLAKE		0x5E
-#define INTEL_FAM6_SKYLAKE_X		0x55
-#define INTEL_FAM6_KABYLAKE_L		0x8E
-#define INTEL_FAM6_KABYLAKE		0x9E
+#define INTEL_FAM6_SKYLAKE_L		0x4E	/* Sky Lake             */
+#define INTEL_FAM6_SKYLAKE		0x5E	/* Sky Lake             */
+#define INTEL_FAM6_SKYLAKE_X		0x55	/* Sky Lake             */
 
-#define INTEL_FAM6_CANNONLAKE_L		0x66
+#define INTEL_FAM6_KABYLAKE_L		0x8E	/* Sky Lake             */
+/*                 AMBERLAKE_L		0x8E	   Sky Lake -- s: 9     */
+/*                 COFFEELAKE_L		0x8E	   Sky Lake -- s: 10    */
+/*                 WHISKEYLAKE_L	0x8E       Sky Lake -- s: 11,12 */
 
-#define INTEL_FAM6_ICELAKE_X		0x6A
-#define INTEL_FAM6_ICELAKE_D		0x6C
-#define INTEL_FAM6_ICELAKE		0x7D
-#define INTEL_FAM6_ICELAKE_L		0x7E
-#define INTEL_FAM6_ICELAKE_NNPI		0x9D
+#define INTEL_FAM6_KABYLAKE		0x9E	/* Sky Lake             */
+/*                 COFFEELAKE		0x9E	   Sky Lake -- s: 10-13 */
 
-#define INTEL_FAM6_TIGERLAKE_L		0x8C
-#define INTEL_FAM6_TIGERLAKE		0x8D
+#define INTEL_FAM6_COMETLAKE		0xA5	/* Sky Lake             */
+#define INTEL_FAM6_COMETLAKE_L		0xA6	/* Sky Lake             */
 
-#define INTEL_FAM6_COMETLAKE		0xA5
-#define INTEL_FAM6_COMETLAKE_L		0xA6
+#define INTEL_FAM6_CANNONLAKE_L		0x66	/* Palm Cove */
 
-#define INTEL_FAM6_ROCKETLAKE		0xA7
+#define INTEL_FAM6_ICELAKE_X		0x6A	/* Sunny Cove */
+#define INTEL_FAM6_ICELAKE_D		0x6C	/* Sunny Cove */
+#define INTEL_FAM6_ICELAKE		0x7D	/* Sunny Cove */
+#define INTEL_FAM6_ICELAKE_L		0x7E	/* Sunny Cove */
+#define INTEL_FAM6_ICELAKE_NNPI		0x9D	/* Sunny Cove */
 
-#define INTEL_FAM6_SAPPHIRERAPIDS_X	0x8F
+#define INTEL_FAM6_LAKEFIELD		0x8A	/* Sunny Cove / Tremont */
 
-/* Hybrid Core/Atom Processors */
+#define INTEL_FAM6_ROCKETLAKE		0xA7	/* Cypress Cove */
 
-#define	INTEL_FAM6_LAKEFIELD		0x8A
-#define INTEL_FAM6_ALDERLAKE		0x97
-#define INTEL_FAM6_ALDERLAKE_L		0x9A
+#define INTEL_FAM6_TIGERLAKE_L		0x8C	/* Willow Cove */
+#define INTEL_FAM6_TIGERLAKE		0x8D	/* Willow Cove */
+#define INTEL_FAM6_SAPPHIRERAPIDS_X	0x8F	/* Willow Cove */
+
+#define INTEL_FAM6_ALDERLAKE		0x97	/* Golden Cove / Gracemont */
+#define INTEL_FAM6_ALDERLAKE_L		0x9A	/* Golden Cove / Gracemont */
 
 /* "Small Core" Processors (Atom) */
 
