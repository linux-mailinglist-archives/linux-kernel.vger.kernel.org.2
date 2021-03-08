Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA26330D88
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 13:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbhCHM2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 07:28:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:40206 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229672AbhCHM2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 07:28:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615206530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kuZklKgnYa6USpuMOuRhMmMWaIjF31okmqD4U9eV8KM=;
        b=W1rg7I4mSnI7bxqhI9Vz7U6qCMv1HNnLgVfzWQwSnkCWkj5KpdmCPBZPnCOiGrIFi2I7Xl
        w/M0vn+sH6R9Mu5mGQmuNqvC/B/dSPaOeHHDN/27UtBhAzfVTGjUA2/q0bVe8fDx5OHa3p
        uieCC9CvFKcOShPtLPvHPGBNhy+llaE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4C7CCAD57;
        Mon,  8 Mar 2021 12:28:50 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v5 03/12] x86/alternative: drop feature parameter from ALTINSTR_REPLACEMENT()
Date:   Mon,  8 Mar 2021 13:28:35 +0100
Message-Id: <20210308122844.30488-4-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210308122844.30488-1-jgross@suse.com>
References: <20210308122844.30488-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro ALTINSTR_REPLACEMENT() doesn't make use of the feature
parameter, so drop it.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V5:
- new patch
---
 arch/x86/include/asm/alternative.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 13adca37c99a..5753fb2ac489 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -150,7 +150,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	" .byte " alt_rlen(num) "\n"			/* replacement len */ \
 	" .byte " alt_pad_len "\n"			/* pad len */
 
-#define ALTINSTR_REPLACEMENT(newinstr, feature, num)	/* replacement */	\
+#define ALTINSTR_REPLACEMENT(newinstr, num)		/* replacement */	\
 	"# ALT: replacement " #num "\n"						\
 	b_replacement(num)":\n\t" newinstr "\n" e_replacement(num) ":\n"
 
@@ -161,7 +161,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	ALTINSTR_ENTRY(feature, 1)					\
 	".popsection\n"							\
 	".pushsection .altinstr_replacement, \"ax\"\n"			\
-	ALTINSTR_REPLACEMENT(newinstr, feature, 1)			\
+	ALTINSTR_REPLACEMENT(newinstr, 1)				\
 	".popsection\n"
 
 #define ALTERNATIVE_2(oldinstr, newinstr1, feature1, newinstr2, feature2)\
@@ -171,8 +171,8 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	ALTINSTR_ENTRY(feature2, 2)					\
 	".popsection\n"							\
 	".pushsection .altinstr_replacement, \"ax\"\n"			\
-	ALTINSTR_REPLACEMENT(newinstr1, feature1, 1)			\
-	ALTINSTR_REPLACEMENT(newinstr2, feature2, 2)			\
+	ALTINSTR_REPLACEMENT(newinstr1, 1)				\
+	ALTINSTR_REPLACEMENT(newinstr2, 2)				\
 	".popsection\n"
 
 #define ALTERNATIVE_3(oldinsn, newinsn1, feat1, newinsn2, feat2, newinsn3, feat3) \
@@ -183,9 +183,9 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	ALTINSTR_ENTRY(feat3, 3)						\
 	".popsection\n"								\
 	".pushsection .altinstr_replacement, \"ax\"\n"				\
-	ALTINSTR_REPLACEMENT(newinsn1, feat1, 1)				\
-	ALTINSTR_REPLACEMENT(newinsn2, feat2, 2)				\
-	ALTINSTR_REPLACEMENT(newinsn3, feat3, 3)				\
+	ALTINSTR_REPLACEMENT(newinsn1, 1)					\
+	ALTINSTR_REPLACEMENT(newinsn2, 2)					\
+	ALTINSTR_REPLACEMENT(newinsn3, 3)					\
 	".popsection\n"
 
 /*
-- 
2.26.2

