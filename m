Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B081394E11
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhE2UEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhE2UEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:04:13 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72C1C06138D
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:36 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id i14-20020a9d624e0000b029033683c71999so7001507otk.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NA6nCcDiKaBAVEhaNQMS5x+7QLLkLDBgcvXqmtlBud0=;
        b=dQ0edA3wcWy9aptwtzz/zkNMXK7zZzXc+hugzT4J8E9hWuOYvQAgBtoThwVnrI1VAn
         vTacepwNxUIjNnehCnuJAbA/uCKF9RuNKz5cq7kqBBrbEunBBW8bWIhyAJogDMAkeb6h
         ajyohPZlTbrktizkFma4jmEM8Pe0pa5FISHKIMbR9B9mwjEgAMW+3DCo8sZMcsmZVH25
         QoQNa5uuBWSGypHgYE5QEAeprPMBOoZ9mkJCdUeZ1CNcX557pwGxrxxu7ZhrVVfgE3mo
         hGewyYpNTI1PKg1rhFwTeyyne/gxoLwDWo7wagQN62dlIcxqi4pBoyYgVritCjiMe/Re
         UdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NA6nCcDiKaBAVEhaNQMS5x+7QLLkLDBgcvXqmtlBud0=;
        b=cWVUm7GKJLihFCitrYWW4i5NuJg+4W4Wyb4J0OX5PFGcaY7VT9rz8Zx2lPbusKlk3A
         TnYgrOQoYRxOowi14TlrQ7TrsJ+szDjucB8/Ox/n/0nM8hymJyof0Lcud6uosvYaXtHY
         qoHHis0Gvc/9dE2T0Byu5yVr3XCNGFRjk/oblZqjhW5gEVA5+A/+y3g+pTLTwpaviTu5
         JUgm7i2deYvOi5au/NwnGLu6vXjv6RhUw/YcjpS3bh6kDoaAs6zqRaqo8eAt6jyA5MjN
         TkdqzLcSctxLtwnfM6uecQAhh1eGI99Mzs6B6iSObb9etidLrxKy+aZbD9gxdVyZaM5j
         zTkw==
X-Gm-Message-State: AOAM533dr1ijy2ec1qzNf7VmXrJqxyGZ7h1sHKXG/edQZspJ3s6YEksB
        gvZE3eaCJDienypxbqGWogY=
X-Google-Smtp-Source: ABdhPJyqXkOggwq0UHeuhvGAmayu1zM/uovWcaTlyZAQugTh+taewK62UsZ9/2z7NPr7h06o8vtRFg==
X-Received: by 2002:a9d:27a4:: with SMTP id c33mr10571224otb.281.1622318556323;
        Sat, 29 May 2021 13:02:36 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:35 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v6 22/34] dyndbg: validate ddebug_site_get invariants
Date:   Sat, 29 May 2021 14:00:17 -0600
Message-Id: <20210529200029.205306-23-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds several BUG_ONs to assert all the invariants needed
to support the reliance on the "back-N-to-header-overto-site-out-N"
use of the 2 __dyndbg* vectors (with their included headers).

RFC: I don't think we want this permanently; BUG_ON/panic seems kinda
overkill, but its useful to know if it survives lkp auto-testing.

- dp is (struct _ddebug*) to the callsite, passed in.
- dh is (struct _ddebug*) to the header. derived from dp & _index.
  known by BUG_ON(!is_dyndbg_header(dh))
  this is the "up-N-to-header" from dp.
- dh has good site pointer, to __dyndbg_sites[]
  by BUG_ON(!is_dyndbg_header_pair())

There are 2 main cases to validate: builtin and loadable modules.

For loadable modules, we will depend upon the headers presence, and
its site pointer to the vector of _ddebug_sites[], expressed as:

  BUG_ON(&dh->site[dp->_index] != dp->site);

Builtin pr-debugs have the additional property:

  !!(&__start___dyndbg <= dp < __stop___dyndbg),

We could use this property directly to return site, but since builtin
modules also have a header record, we can use that instead.  So the
1st BUG_ON is hoisted out of the !builtin branch, and asserted just
before return.  Also hoist dh derivation, making it a declaration +
initialization + BUG_ON instead.

NB: grep -- '->site' will confirm that site is now used just for
BUG_ON assertions, so we are close to the drop.

NEXT

To drop site pointer from struct _ddebug, we need:

- recast header as a different struct, unionized with _ddebug.
- preserve site pointer there.
- drop from struct _ddebug.
- fix and fold back any fallout from size reduction.

OR defer that, and proceed with compressing __dyndbg_sites[], then
replacing ddebug_site_get's guts (with all the BUG_ONs) with a
decompress and _index.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index ad9971ded09a..014e3a79d8e9 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -123,6 +123,8 @@ do {								\
 #define vpr_info(fmt, ...)	vnpr_info(1, fmt, ##__VA_ARGS__)
 #define v2pr_info(fmt, ...)	vnpr_info(2, fmt, ##__VA_ARGS__)
 #define v3pr_info(fmt, ...)	vnpr_info(3, fmt, ##__VA_ARGS__)
+#define v4pr_info(fmt, ...)	vnpr_info(4, fmt, ##__VA_ARGS__)
+#define v5pr_info(fmt, ...)	vnpr_info(5, fmt, ##__VA_ARGS__)
 
 static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 {
@@ -146,7 +148,34 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 
 static struct _ddebug_site *ddebug_site_get(struct _ddebug *dp)
 {
-	return dp->site; /* passthru abstraction */
+	struct _ddebug *dh = dp - (dp->_index);
+
+	WARN_ON(!is_dyndbg_header_pair(dh, dh->site));
+
+	if (dp >= __start___dyndbg && dp < __stop___dyndbg) {
+
+		v5pr_info("get: %s is builtin: %d %d %s:%s:%d\n",
+			  dp->site->modname, dp->_index, (int)(dp - dh),
+			  dh->site[dp->_index].filename,
+			  dh->site[dp->_index].function, dp->lineno);
+
+		WARN_ON(dp != &__start___dyndbg[dp->_index]);
+
+		WARN_ON(!(dp->_index == (dp - dh) &&
+			 dp->_index == (dp - __start___dyndbg) &&
+			 dp->_index == (&__start___dyndbg_sites[dp->_index]
+					- &__start___dyndbg_sites[0])));
+
+		WARN_ON(&__start___dyndbg_sites[dp->_index] != dp->site);
+	} else {
+		v4pr_info("get: %s is loaded: %d %s:%s:%d\n",
+			  dp->site->modname, dp->_index,
+			  dh->site[dp->_index].filename,
+			  dh->site[dp->_index].function, dp->lineno);
+	}
+	WARN_ON(&dh->site[dp->_index] != dp->site);
+
+	return dp->site;
 }
 static inline void ddebug_site_put(struct _ddebug *dp)
 {
-- 
2.31.1

