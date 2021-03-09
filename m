Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A06332796
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 14:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhCINsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 08:48:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:51270 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231151AbhCINsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:48:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615297699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lLz8EEkgsQbQc5zK5shQUpeWBQPCbxXPv1CJD4/GY5s=;
        b=V9rLewRZsFpBl1/XMebrWwmjaGkfsV2llhnmLZXMNrI974R7XYC90NkWaxfzuPQahHLRV7
        QYcLm6Y0TKWTsGJlbD4nAR0d1uWxj00iAlUqO1DXdmT043Yz6a/Kj/cH22/KXJwces9Oac
        2m1T/gsMz7tida4po0YgsnFuzklP0Qk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 329F5AC17;
        Tue,  9 Mar 2021 13:48:19 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v6 01/12] static_call: move struct static_call_key definition to static_call_types.h
Date:   Tue,  9 Mar 2021 14:48:02 +0100
Message-Id: <20210309134813.23912-2-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210309134813.23912-1-jgross@suse.com>
References: <20210309134813.23912-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having the definition of static_call() in static_call_types.h makes
no sense as long struct static_call_key isn't defined there, as the
generic implementation of static_call() is referencing this structure.

So move the definition of struct static_call_key to static_call_types.h.

Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
V5:
- new patch
---
 include/linux/static_call.h             | 18 ------------------
 include/linux/static_call_types.h       | 18 ++++++++++++++++++
 tools/include/linux/static_call_types.h | 18 ++++++++++++++++++
 3 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 85ecc789f4ff..76b881259144 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -128,16 +128,6 @@ struct static_call_mod {
 	struct static_call_site *sites;
 };
 
-struct static_call_key {
-	void *func;
-	union {
-		/* bit 0: 0 = mods, 1 = sites */
-		unsigned long type;
-		struct static_call_mod *mods;
-		struct static_call_site *sites;
-	};
-};
-
 /* For finding the key associated with a trampoline */
 struct static_call_tramp_key {
 	s32 tramp;
@@ -187,10 +177,6 @@ extern long __static_call_return0(void);
 
 static inline int static_call_init(void) { return 0; }
 
-struct static_call_key {
-	void *func;
-};
-
 #define __DEFINE_STATIC_CALL(name, _func, _func_init)			\
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
@@ -243,10 +229,6 @@ static inline long __static_call_return0(void)
 
 static inline int static_call_init(void) { return 0; }
 
-struct static_call_key {
-	void *func;
-};
-
 static inline long __static_call_return0(void)
 {
 	return 0;
diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
index ae5662d368b9..5a00b8b2cf9f 100644
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -58,11 +58,25 @@ struct static_call_site {
 	__raw_static_call(name);					\
 })
 
+struct static_call_key {
+	void *func;
+	union {
+		/* bit 0: 0 = mods, 1 = sites */
+		unsigned long type;
+		struct static_call_mod *mods;
+		struct static_call_site *sites;
+	};
+};
+
 #else /* !CONFIG_HAVE_STATIC_CALL_INLINE */
 
 #define __STATIC_CALL_ADDRESSABLE(name)
 #define __static_call(name)	__raw_static_call(name)
 
+struct static_call_key {
+	void *func;
+};
+
 #endif /* CONFIG_HAVE_STATIC_CALL_INLINE */
 
 #ifdef MODULE
@@ -77,6 +91,10 @@ struct static_call_site {
 
 #else
 
+struct static_call_key {
+	void *func;
+};
+
 #define static_call(name)						\
 	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))
 
diff --git a/tools/include/linux/static_call_types.h b/tools/include/linux/static_call_types.h
index ae5662d368b9..5a00b8b2cf9f 100644
--- a/tools/include/linux/static_call_types.h
+++ b/tools/include/linux/static_call_types.h
@@ -58,11 +58,25 @@ struct static_call_site {
 	__raw_static_call(name);					\
 })
 
+struct static_call_key {
+	void *func;
+	union {
+		/* bit 0: 0 = mods, 1 = sites */
+		unsigned long type;
+		struct static_call_mod *mods;
+		struct static_call_site *sites;
+	};
+};
+
 #else /* !CONFIG_HAVE_STATIC_CALL_INLINE */
 
 #define __STATIC_CALL_ADDRESSABLE(name)
 #define __static_call(name)	__raw_static_call(name)
 
+struct static_call_key {
+	void *func;
+};
+
 #endif /* CONFIG_HAVE_STATIC_CALL_INLINE */
 
 #ifdef MODULE
@@ -77,6 +91,10 @@ struct static_call_site {
 
 #else
 
+struct static_call_key {
+	void *func;
+};
+
 #define static_call(name)						\
 	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))
 
-- 
2.26.2

