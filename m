Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CED330D8A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 13:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhCHM2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 07:28:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:40180 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229575AbhCHM2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 07:28:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615206529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lwxA20SDAEyST3opQlZ9hzTp/g3xcLqoUnJ7P0MzmB8=;
        b=kmRTs4o4dKYOCNahWofrTsHkMs5Gn8Terd0KSrZvSTOOBy7owvGGeZY807SznPlwAkR3a/
        a71lIVLaLdAEzRCGid6ouhfLLyJn/Vne51eTP0zd71MmLqVDYi/Dn4w8UzfXNSxpJ4DKBJ
        m7bLZGEGLx01xgYEampZFgNDLEk/k+c=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 74BD8AC54;
        Mon,  8 Mar 2021 12:28:49 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v5 01/12] staticcall: move struct static_call_key definition to static_call_types.h
Date:   Mon,  8 Mar 2021 13:28:33 +0100
Message-Id: <20210308122844.30488-2-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210308122844.30488-1-jgross@suse.com>
References: <20210308122844.30488-1-jgross@suse.com>
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

