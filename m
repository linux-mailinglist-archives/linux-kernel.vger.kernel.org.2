Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544DE35237D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 01:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbhDAXX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 19:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbhDAXXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 19:23:52 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0167C061793
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 16:23:52 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x26so2550415pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 16:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ijlYcKqhmRnIjh3GfaZu6VzSGgGwccaBk76YZfh88U=;
        b=WKcAnIleO2ypEZLKdHh37aVTO4tnIydkC5OCyMTVr+JpikHZ2/ZMU3FugvxEly10iU
         XSYN4IoCMfmYa9AiUhoVcjinurr136nmz9lf7q3gbfnnfDCOVEDSAGVTeituYbklhN9Y
         yq+0k7ScK7oeFnBPFOBIMf0UvJV0M6vj4GtgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ijlYcKqhmRnIjh3GfaZu6VzSGgGwccaBk76YZfh88U=;
        b=ClrEOWoYZjyRX6eQ7YhI4cT9MeNgejX32dveDhc/bTWfN4f7r3upOG7QspOTMf4Z9/
         eRm77hDZfO2U1XSWYLqqOEsCTyVWJfSU99pxNMTVzokSWPAJK1aH7nO4vg5Hm1loZKug
         eU1X8QncYwDF/6TuGu0x4xb5FXNyhDdQhZcb6MgcvQ+NIfPiRl6v3QteIRiq/Q72+EO0
         Hu26WQvrG6LrFosXc35UX81joQdRPXP13AJAJPbTvpXDLNBNrnGujDIvNXk5MnEJr9mD
         3JWoAj7YymwPLBYW2+gSFeMBD+rC+ZeGTXwvbzSZ6YbL8GUjSCNsRRpqYff4TEmWFQXT
         /5fQ==
X-Gm-Message-State: AOAM532cLenu7mTVTNCYP10ZL5Tz08YVLFhru9qAwL1Ck2is2gWRFOJy
        1yudPb0s9/IgHt/Vwi1IWEsxQw==
X-Google-Smtp-Source: ABdhPJwcYRMQryh7JJASN23+Q3HQF6uWuabr3WsRHjWCDIRpgK6DJhS0r2tl16IIlvy5t61K9IC1DA==
X-Received: by 2002:a62:7b83:0:b029:1f1:5ef3:b4d9 with SMTP id w125-20020a627b830000b02901f15ef3b4d9mr9608204pfc.65.1617319432493;
        Thu, 01 Apr 2021 16:23:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k64sm6606207pgk.23.2021.04.01.16.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 16:23:51 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 1/6] jump_label: Provide CONFIG-driven build state defaults
Date:   Thu,  1 Apr 2021 16:23:42 -0700
Message-Id: <20210401232347.2791257-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401232347.2791257-1-keescook@chromium.org>
References: <20210401232347.2791257-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=aa54c44d1d71b9550d6015efc734f667917094a1; i=Vishx6UyAXwYzcnoSyP+eBB3iQyx+/i5smsbQfc0cnA=; m=vc4sSYlf+uaSlLSFP5TpbQv56VaSRpBLpRuMltXaB4Q=; p=mNH2Bo/K9vrGz9sBtTDV8UFO0eJ8yv8BbR/DeIaO1es=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmBmVgEACgkQiXL039xtwCbiEBAArOm /EtpeLQvJQ16Bi0gBHOl/CblUQyhrscVrs8xNm/lKfSaeaGIDJaNfx0EZ4L7n2IVkpGYSodLxZlwj ve4GueMybGaAPJWYFy3L+jAe9eYTp3zyYwvQsSRg55iW5msvqK3ZUeJqC/CxPrDdwT05noLV9mDub lAzrVY/pLiXE0HTK9ogAdyiNFQY2yA44UmGTIkmgZ30jl0d4aSVtwsViZeMS8pCrK22xkiccq/bRY 72ASLPxyOBOL00UWKeUmbmdUfNW+BkNlK7IaN+w5QBfiKuQWTf/WdZ+8c5tQWjLE3kJ4DRx8mrBcy 1vYJ1m1ZKfAOe8uV8waSURiUMzfgB/uL5on3W1e6s8SkChf0KGAZMyDGuIflDnvFUy8OIfM8Ak/fg hoYQ2dUXkKa50EdvadntVka+XmxokcSERzN0e9tOQlYfeLiL5TINkkDQFAallIMnHy6ImGd9Yd23F zSvCmvv0683j96kJXsEcfl0wH3LYYCyRS0fIK1ssPxPAViuN0vY1jlIeDn734NiR4+itDg8pTepIM h8ozYc9GPgYBTzXQPG29KmXRHc4es7o4enMoBQ1Gj0PZ5f9c0fr6AUpoe7c1jVtsL4wJD6tUuC9do T40yZwF6fDGX1jsVc/mbC1ug6gurwbG+Xo1xiQ2I1YUyr1MimqrfE4LvelISHwZM=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As shown in jump_label.h[1], choosing the initial state of static
branches changes the assembly layout. If the condition is expected to
be likely it's inline, and if unlikely it is out of line via a jump. A
few places in the kernel use (or could be using) a CONFIG to choose the
default state, which would give a small performance benefit to their
compile-time declared default. Provide the infrastructure to do this.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/jump_label.h?h=v5.11#n398

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/20200324220641.GT2452@worktop.programming.kicks-ass.net/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/jump_label.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index d92691262f51..05f5554d860f 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -382,6 +382,21 @@ struct static_key_false {
 		[0 ... (count) - 1] = STATIC_KEY_FALSE_INIT,	\
 	}
 
+#define _DEFINE_STATIC_KEY_1(name)	DEFINE_STATIC_KEY_TRUE(name)
+#define _DEFINE_STATIC_KEY_0(name)	DEFINE_STATIC_KEY_FALSE(name)
+#define DEFINE_STATIC_KEY_MAYBE(cfg, name)			\
+	__PASTE(_DEFINE_STATIC_KEY_, IS_ENABLED(cfg))(name)
+
+#define _DEFINE_STATIC_KEY_RO_1(name)	DEFINE_STATIC_KEY_TRUE_RO(name)
+#define _DEFINE_STATIC_KEY_RO_0(name)	DEFINE_STATIC_KEY_FALSE_RO(name)
+#define DEFINE_STATIC_KEY_MAYBE_RO(cfg, name)			\
+	__PASTE(_DEFINE_STATIC_KEY_RO_, IS_ENABLED(cfg))(name)
+
+#define _DECLARE_STATIC_KEY_1(name)	DECLARE_STATIC_KEY_TRUE(name)
+#define _DECLARE_STATIC_KEY_0(name)	DECLARE_STATIC_KEY_FALSE(name)
+#define DECLARE_STATIC_KEY_MAYBE(cfg, name)			\
+	__PASTE(_DECLARE_STATIC_KEY_, IS_ENABLED(cfg))(name)
+
 extern bool ____wrong_branch_error(void);
 
 #define static_key_enabled(x)							\
@@ -482,6 +497,10 @@ extern bool ____wrong_branch_error(void);
 
 #endif /* CONFIG_JUMP_LABEL */
 
+#define static_branch_maybe(config, x)					\
+	(IS_ENABLED(config) ? static_branch_likely(x)			\
+			    : static_branch_unlikely(x))
+
 /*
  * Advanced usage; refcount, branch is enabled when: count != 0
  */
-- 
2.25.1

