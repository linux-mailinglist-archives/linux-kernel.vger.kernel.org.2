Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4F3422481
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 13:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbhJELFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 07:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbhJELDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 07:03:42 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8F3C061368
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 04:00:37 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id d19-20020ac85ad3000000b002a74d0626bcso2314779qtd.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 04:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GVi87uCC9iTMZ0tahcA01mPlZX23fhUUuaenbQ1/OXU=;
        b=eBKhKFS4x1q99vUTWlhpytTALPtvi3mgku2eaV9j+J7rB3DErHSPoLRonHHdXa8PGK
         6HibdPdPZNy+o32rjdkB5tY0E11xrK9Ac3m5LDrgA2eA7J4HLKzrEbZQKgIw1AY8VNHy
         cAXItLXIxr8LebyG5GXhJ5+H92uEdXLdYsxLq82kMDMHBfWpeoLyU9FKZpfWRWKR30/e
         40g9aYJKuuWKDqCwSD6vrOeXjAUAmFMMNRQ8Wu7WwLiT+hOd27rLzpsYzEuWPDXPx3F4
         L1BPhdtoHS1Yj0ZHU4Y3K79zG6ebY4E4kLEZBtO7noFlNeKlrDewmFrRbhHEejhMl+79
         /MaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GVi87uCC9iTMZ0tahcA01mPlZX23fhUUuaenbQ1/OXU=;
        b=3hKflY233jkXwEFc+W8kgn41XIWiph7FIA6vTxMMHou1jiACpKLlN1dsgrPphoF6Xn
         CBUlPaO88D2CR7ZnNeMGCO4UvmIq1yJI23RYDoJF7QXHx8YrUn+H1V5BuGIcRAVZ/+0k
         QJNllK2Pb5dFT/cbYDg6f7tIw1OngvQHa9Qgkgso2FRUgdTeA/5rXNC1ZjpvYWkgaUdX
         /d01cHgdBZQt7If15sCGT79BZvoDLT4UEGd/jAO2bamWMKApKvXKVPNRy0aYcdJn1Dcn
         Rgn4gbstqiQ3+i2bBus800Xx7uosfI94JwUdXeoC2evrDhFROYTCex1NA+WLttokV/dX
         b1mA==
X-Gm-Message-State: AOAM533U45TziiYGvzG6wHtIY9JYAUv84IrQFXrJNPkRbjnxkJV26AyJ
        McTRbj4O7Q+EY3CJk5CgK1hzrgt+Aw==
X-Google-Smtp-Source: ABdhPJyqnmEQmSHt6KCacfuyURYDmMa093deSnQHXsO3BMcqzTTUKZjrrxibP+T5sEG2RF9gpTkjLb8Zvw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e44f:5054:55f8:fcb8])
 (user=elver job=sendgmr) by 2002:a05:6214:1305:: with SMTP id
 a5mr21006975qvv.64.1633431636934; Tue, 05 Oct 2021 04:00:36 -0700 (PDT)
Date:   Tue,  5 Oct 2021 12:59:05 +0200
In-Reply-To: <20211005105905.1994700-1-elver@google.com>
Message-Id: <20211005105905.1994700-24-elver@google.com>
Mime-Version: 1.0
References: <20211005105905.1994700-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH -rcu/kcsan 23/23] objtool, kcsan: Remove memory barrier
 instrumentation from noinstr
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Teach objtool to turn instrumentation required for memory barrier
modeling into nops in noinstr text.

The __tsan_func_entry/exit calls are still emitted by compilers even
with the __no_sanitize_thread attribute. The memory barrier
instrumentation will be inserted explicitly (without compiler help), and
thus needs to also explicitly be removed.

Signed-off-by: Marco Elver <elver@google.com>
---
 tools/objtool/check.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7e8cd3ba5482..7b694e639164 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -965,6 +965,31 @@ static struct symbol *find_call_destination(struct section *sec, unsigned long o
 	return call_dest;
 }
 
+static bool should_remove_if_noinstr(const char *name)
+{
+	/*
+	 * Many compilers cannot disable KCOV with a function attribute so they
+	 * need a little help, NOP out any KCOV calls from noinstr text.
+	 */
+	if (!strncmp(name, "__sanitizer_cov_", 16))
+		return true;
+
+	/*
+	 * Compilers currently do not remove __tsan_func_entry/exit with the
+	 * __no_sanitize_thread attribute, remove them. Memory barrier
+	 * instrumentation is not emitted by the compiler, but inserted
+	 * explicitly, so we need to also remove them.
+	 */
+	if (!strncmp(name, "__tsan_func_", 12) ||
+	    !strcmp(name, "__kcsan_mb") ||
+	    !strcmp(name, "__kcsan_wmb") ||
+	    !strcmp(name, "__kcsan_rmb") ||
+	    !strcmp(name, "__kcsan_release"))
+		return true;
+
+	return false;
+}
+
 /*
  * Find the destination instructions for all calls.
  */
@@ -1031,13 +1056,8 @@ static int add_call_destinations(struct objtool_file *file)
 				      &file->static_call_list);
 		}
 
-		/*
-		 * Many compilers cannot disable KCOV with a function attribute
-		 * so they need a little help, NOP out any KCOV calls from noinstr
-		 * text.
-		 */
 		if (insn->sec->noinstr &&
-		    !strncmp(insn->call_dest->name, "__sanitizer_cov_", 16)) {
+		    should_remove_if_noinstr(insn->call_dest->name)) {
 			if (reloc) {
 				reloc->type = R_NONE;
 				elf_write_reloc(file->elf, reloc);
-- 
2.33.0.800.g4c38ced690-goog

