Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24AC532F42A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 20:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhCETmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 14:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhCETmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 14:42:12 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F044C06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 11:42:12 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id i11so2606817qkn.21
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 11:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=FC7MxNRGLasOl0AFHOn/4f0TFFn6brVrrzJWC80/CCI=;
        b=iGuP7JlrJUVkJlMVhnEdtuHAVUe03G3HY0riy3nPB4gQYwXkteBuwb7WCnAeVB70Jt
         lSajnXmsoMPk3EP71stCS7pslmh86GDl0sNa+0tPE/lsbWMgeY+5d2yFRkbyiKrb+Wgj
         HFQyC9fDIscxdziiDdqAQcbJVN71AolzbwNnKhn97RtlbhzUFhQzswp5HnwBZsgSydHx
         IO8lwseCUT5dhhmqyl346d8tGCoWsE00Re8fn9WYGO0ogR2tPTVR0WmHDGQLjYNN+jP8
         jIL9VX8mxSTqwuR7OobXv6sj+I2ZCQKMp6UoPUz/l4uQfnyBNsKFtPJnE5CmAPSGS3fo
         aHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FC7MxNRGLasOl0AFHOn/4f0TFFn6brVrrzJWC80/CCI=;
        b=Eku4289URx/f/YeX5cHakjWVfub4aMpC7tmlW+siTRPqNdujtyetJrFA+52gz2dUR4
         7XnBkHUkrC8hZeExgzNV0rJM0CrWvUfp9FagxKebxD/JvXkZwDVthBD7x2KqaP9eBj4I
         rDVOXVphgHj7fADUyst0uzCkFTCtlLJccmhVYI2xf6SO0iR/kpDENXrbJaxkLA/jJCVZ
         0NwoNZ2BPQsCNM7RPWLyUCDGzN7orVAOoLfqkgrVde5IGUBo2QdxznuHF1IT9k83haWx
         ovVc8nPDmiOXjUn8Fp3uhQ/Ln7L6FZ5U81yZ2KfbCbJXFOpGu6s5elKLkhOXy9cyjY99
         5MuQ==
X-Gm-Message-State: AOAM531qsuPb8K2WHlPH1mQWVjqjUNIY1DZqD/8GzP9FiFtYo8ajbCCW
        yOkFjKQpwujFzRz+wDPybaf9qt7/jg==
X-Google-Smtp-Source: ABdhPJzrhARDPtb3MAnTYyFg5RoigAt5c3HyDTgaudGbM1KVunCZr9S29Xyoa2nve1DPXVQD0/J/pLa7rQ==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e:611c:f54a:61d6])
 (user=elver job=sendgmr) by 2002:ad4:4904:: with SMTP id bh4mr10400872qvb.53.1614973331699;
 Fri, 05 Mar 2021 11:42:11 -0800 (PST)
Date:   Fri,  5 Mar 2021 20:42:06 +0100
In-Reply-To: <20210305194206.3165917-1-elver@google.com>
Message-Id: <20210305194206.3165917-2-elver@google.com>
Mime-Version: 1.0
References: <20210305194206.3165917-1-elver@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 2/2] lib/vsprintf: reduce space taken by no_hash_pointers warning
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     linux-kernel@vger.kernel.org, vbabka@suse.cz, timur@kernel.org,
        pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the no_hash_pointers warning string into __initconst section, so
that it is discarded after init. Remove common start/end characters.
Also remove repeated lines from the array, since the compiler can't
remove duplicate strings for us since the array must appear in
__initconst as defined.

Note, a similar message appears in kernel/trace/trace.c, but compiling
the feature is guarded by CONFIG_TRACING. It is not immediately obvious
if a space-concious kernel would prefer CONFIG_TRACING=n. Therefore, it
makes sense to keep the message for no_hash_pointers as __initconst, and
not move the NOTICE-printing to a common function.

Link: https://lkml.kernel.org/r/CAMuHMdULKZCJevVJcp7TxzLdWLjsQPhE8hqxhnztNi9bjT_cEw@mail.gmail.com
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 lib/vsprintf.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 4a14889ccb35..1095689c9c97 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2094,26 +2094,30 @@ char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
 bool no_hash_pointers __ro_after_init;
 EXPORT_SYMBOL_GPL(no_hash_pointers);
 
+static const char no_hash_pointers_warning[8][55] __initconst = {
+	"******************************************************",
+	"   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   ",
+	" This system shows unhashed kernel memory addresses   ",
+	" via the console, logs, and other interfaces. This    ",
+	" might reduce the security of your system.            ",
+	" If you see this message and you are not debugging    ",
+	" the kernel, report this immediately to your system   ",
+	" administrator!                                       ",
+};
+
 static int __init no_hash_pointers_enable(char *str)
 {
+	/* Indices into no_hash_pointers_warning; -1 is an empty line. */
+	const int lines[] = { 0, 1, -1, 2, 3, 4, -1, 5, 6, 7, -1, 1, 0 };
+	int i;
+
 	if (no_hash_pointers)
 		return 0;
 
 	no_hash_pointers = true;
 
-	pr_warn("**********************************************************\n");
-	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
-	pr_warn("**                                                      **\n");
-	pr_warn("** This system shows unhashed kernel memory addresses   **\n");
-	pr_warn("** via the console, logs, and other interfaces. This    **\n");
-	pr_warn("** might reduce the security of your system.            **\n");
-	pr_warn("**                                                      **\n");
-	pr_warn("** If you see this message and you are not debugging    **\n");
-	pr_warn("** the kernel, report this immediately to your system   **\n");
-	pr_warn("** administrator!                                       **\n");
-	pr_warn("**                                                      **\n");
-	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
-	pr_warn("**********************************************************\n");
+	for (i = 0; i < ARRAY_SIZE(lines); i++)
+		pr_warn("**%54s**\n", i == -1 ? "" : no_hash_pointers_warning[lines[i]]);
 
 	return 0;
 }
-- 
2.30.1.766.gb4fecdf3b7-goog

