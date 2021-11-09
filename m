Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41FFD44B176
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 17:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239801AbhKIQtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 11:49:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:60010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240128AbhKIQtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 11:49:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59BAD613B3;
        Tue,  9 Nov 2021 16:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636476385;
        bh=mY8bQKVatIszIv/ojyP72DOn1RLYXG4EALo/OHrynUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lHyJTqTQkDngAJxRYvXD0JlehrGzG7P4ullWuV9cAqOooyTPo/zOWU+3vIG986wIp
         YSIisS8p3TOhYHdgRk4+Vm+F0Y+2Ffq4uG/pqbPOoOwhpvqZ9NBKcaLgMTgEagAbrW
         0HRpBeJjbKZR/phmVNfEqTpIct8wMp0oQ7RKO4k5i1pdK9WKbVUpt0tSCyWpgve7tA
         nmel1ezTYxKVX3XP+Rz6iFNxpiwt2zuVFmwwZKOoAfpZNMXyvjb9JiyPbaZws2AfFf
         xIROEoIfEk3pdoJhVNVXI8wi3zgvrMIZmjlpE3c+ZmGsGb+dT3yGk7wub6OtfCvkwW
         a4N2XyHnxNG8A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: [RFC PATCH 7/7] static_call: add generic support for non-exported keys
Date:   Tue,  9 Nov 2021 17:45:49 +0100
Message-Id: <20211109164549.1724710-8-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211109164549.1724710-1-ardb@kernel.org>
References: <20211109164549.1724710-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2665; h=from:subject; bh=mY8bQKVatIszIv/ojyP72DOn1RLYXG4EALo/OHrynUw=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBhiqW8pjJ/R8foOMwerUWPrX3XzSKG+oHwtotvxgmD jlbTXE6JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYYqlvAAKCRDDTyI5ktmPJCMDC/ 9FwatngAQAnYKGvkkmD2MYoewjSD6/wA1JeRJcQMIaFhEk+0OOTV+45/5AmTWB3HtJ7GSirV3jE5Cz lzX5wx2O3Ng74NQ6oJUiwjCwfPOQfxpUxq+p+q/btb4/xTOFm6SgPnrosF9Su4onhUUNUuGNp5oMbp pM9qJp0OgYlpaG339kRtmeUo2eD/LCBClHdEpfiep5Sh9Zny+nXMaaVnPRc7X4BqLpIDjNuRmuMhs/ ttqDVai/4NOgNVdPKZGOZR/ghLycKbHGnfLHS0wK4ot8Eyq9l7cR4HjezL/4sMzZV+vgq5sbb7zYR5 TD5762B+LZX0LAcKJ3tG1oIwxf1nnPcg3PJlL/NODmvPc579nb/RBQ/od2i0D4gKw54p7rkk4Ub172 VUprcR8Tjj62klNJctpJbfZU0xTUBTlaLN2nwTHMpuCQwr6P94wzEUa1ScmX9OSy7jNehNvWIOjhbP kU8rLW5w0LWRXTFdsXq6zdcxpUQROXv1soj3rsp2AAimI=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static_call feature where only the static call target is exposed to
modules while access to the key is withheld is only implemented for the
inline and out-of-line varieties, but not for the generic indirect call
based variety.

Let's use static_call_query() to obtain the call target address if the
key is not exported. Note that this means we can do the converse as
well, i.e., implement static_call_query() in terms of the key struct if
the key is exported, so we only need to export one of the two.

Note that this adds an additional load and potentially a direct call to
the instantiations of static_call residing in module code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/static_call.h             | 4 ++--
 include/linux/static_call_types.h       | 3 +--
 tools/include/linux/static_call_types.h | 3 +--
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 21929147879a..d88fd613f06d 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -302,8 +302,8 @@ static inline int static_call_text_reserved(void *start, void *end)
 	return 0;
 }
 
-#define EXPORT_STATIC_CALL(name)	EXPORT_SYMBOL(STATIC_CALL_KEY(name))
-#define EXPORT_STATIC_CALL_GPL(name)	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name))
+#define EXPORT_STATIC_CALL(name)	EXPORT_STATIC_CALL_QUERY(name,)
+#define EXPORT_STATIC_CALL_GPL(name)	EXPORT_STATIC_CALL_QUERY(name, _GPL)
 
 #define EXPORT_STATIC_CALL_FOR_UPDATE(name)	EXPORT_SYMBOL(STATIC_CALL_KEY(name))
 #define EXPORT_STATIC_CALL_FOR_UPDATE_GPL(name)	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name))
diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
index eae11c5b015d..920828ad1d69 100644
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -106,8 +106,7 @@ struct static_call_key {
 	void *func;
 };
 
-#define static_call(name)						\
-	((typeof(STATIC_CALL_QUERY(name)()))(STATIC_CALL_KEY(name).func))
+#define static_call(name)	static_call_query(name)
 
 #endif /* CONFIG_HAVE_STATIC_CALL */
 
diff --git a/tools/include/linux/static_call_types.h b/tools/include/linux/static_call_types.h
index eae11c5b015d..920828ad1d69 100644
--- a/tools/include/linux/static_call_types.h
+++ b/tools/include/linux/static_call_types.h
@@ -106,8 +106,7 @@ struct static_call_key {
 	void *func;
 };
 
-#define static_call(name)						\
-	((typeof(STATIC_CALL_QUERY(name)()))(STATIC_CALL_KEY(name).func))
+#define static_call(name)	static_call_query(name)
 
 #endif /* CONFIG_HAVE_STATIC_CALL */
 
-- 
2.30.2

