Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC82330D94
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 13:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhCHM3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 07:29:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:40272 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229753AbhCHM2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 07:28:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615206530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AmZ4aGz4K80se4EUVR17Db7xntpSeR5C5fS3BvWpgIw=;
        b=CH99PWZ6ZOyR+G56mFI3ckGT68QOmth2XBLqlfe/znAM4Wb0+aLF09fpeVepRlHbQarYYZ
        o4yVIMUg2zb+04V9sgrVLq25zJCu4+3PefC+WqkAi4Rlb5tOlCcpKYje4T7Xs74C7OwHcG
        WujYX2oZUDeIqS8/KmYx5I76ekDmLWE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C40CCAD87;
        Mon,  8 Mar 2021 12:28:50 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v5 05/12] x86/alternative: support ALTERNATIVE_TERNARY
Date:   Mon,  8 Mar 2021 13:28:37 +0100
Message-Id: <20210308122844.30488-6-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210308122844.30488-1-jgross@suse.com>
References: <20210308122844.30488-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ALTERNATIVE_TERNARY support for replacing an initial instruction
with either of two instructions depending on a feature:

  ALTERNATIVE_TERNARY "default_instr", FEATURE_NR,
                      "feature_on_instr", "feature_off_instr"

which will start with "default_instr" and at patch time will, depending
on FEATURE_NR being set or not, patch that with either
"feature_on_instr" or "feature_off_instr".

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V3:
- new patch
V4:
- use X86_FEATURE_ALWAYS instead of negated feature (Boris Petkov)
- unfortunately this isn't enough to get rid of the "not feature"
  support, as this is needed in the patch "x86/paravirt: switch
  functions with custom code to ALTERNATIVE", too
V5:
- carve out the "not feature" part
---
 arch/x86/include/asm/alternative-asm.h | 4 ++++
 arch/x86/include/asm/alternative.h     | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/x86/include/asm/alternative-asm.h b/arch/x86/include/asm/alternative-asm.h
index 9a1763550217..ba0aad81d3bb 100644
--- a/arch/x86/include/asm/alternative-asm.h
+++ b/arch/x86/include/asm/alternative-asm.h
@@ -115,6 +115,10 @@
 	.popsection
 .endm
 
+#define ALTERNATIVE_TERNARY(oldinstr, feature, newinstr1, newinstr2)	\
+	ALTERNATIVE_2 oldinstr, newinstr2, X86_FEATURE_ALWAYS,		\
+	newinstr1, feature
+
 #endif  /*  __ASSEMBLY__  */
 
 #endif /* _ASM_X86_ALTERNATIVE_ASM_H */
diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index b9749cf21ada..693991f8fe89 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -183,6 +183,9 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	ALTINSTR_REPLACEMENT(newinstr2, 2)				\
 	".popsection\n"
 
+#define ALTERNATIVE_TERNARY(oldinstr, feature, newinstr1, newinstr2)	\
+	ALTERNATIVE_2(oldinstr, newinstr2, X86_FEATURE_ALWAYS, newinstr1, feature)
+
 #define ALTERNATIVE_3(oldinsn, newinsn1, feat1, newinsn2, feat2, newinsn3, feat3) \
 	OLDINSTR_3(oldinsn, 1, 2, 3)						\
 	".pushsection .altinstructions,\"a\"\n"					\
@@ -214,6 +217,9 @@ static inline int alternatives_text_reserved(void *start, void *end)
 #define alternative_2(oldinstr, newinstr1, feature1, newinstr2, feature2) \
 	asm_inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, feature1, newinstr2, feature2) ::: "memory")
 
+#define alternative_ternary(oldinstr, feature, newinstr1, newinstr2)	\
+	asm_inline volatile(ALTERNATIVE_TERNARY(oldinstr, feature, newinstr1, newinstr2) ::: "memory")
+
 /*
  * Alternative inline assembly with input.
  *
-- 
2.26.2

