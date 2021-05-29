Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B78394E05
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhE2UEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhE2UEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:04:02 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE60C061761
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:25 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so7005089otg.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4FphgqFErW0u2I7OqG/s+zxrWEtrI/oXO1p258v43Ag=;
        b=n55O3oUL67115DySLu3bR8N2ipzKbkp5AMEbL2zGQSzsU2SCz9NnacVuqYt0s1Tm2Y
         kai018ghAOhIUh9fM7QmYEaD0kiyJCq+L6NbXJeO9Lx8uTA4lSkQ3VZA+2w+iuTG0iN5
         iXT4lfqH8Vg0luqwzPwaig6BeR7vT2Ro7wNYOnX4SHD/1JzhHtjzKvX1Dy865g1wyTxk
         6aVrHCMQ2wJwwOFnRfvNtws8yDIDNcvxJIcyVuPUMTfRjDaCJRU72M2RCkO1huZBKnAj
         RsGbffTt/dBLg7aLs4RE43cUWeY3aDLDdpXXsz7mGeJ6D2bV0+OPKc5tgAyexCgXBUNJ
         7O0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4FphgqFErW0u2I7OqG/s+zxrWEtrI/oXO1p258v43Ag=;
        b=QTgxJ0dk7qct666bJgSmyRoVmqfbvitz68um1K6i+OrFOy+p+8tWLhf/HQklBn5f7d
         V6b+JYrQXsn9jiPvGArDiw8rpMfbuDwMp9gPVo9HpqfcgaJHl8zAz7D2AqCdeGk3prQ/
         v3CDzUPj7XFhepqXiL9CpRhHaoY395F8Ch0MQ2WdhzB+NDPjk+DAkngzRZAreuglRBk6
         aKSgB5axCwfsCV0J8YSJC3Qb2lISlaMLTSXuq6iLbTxOnj1x15FjBYOe5SwCeFRS6YOf
         Ma8UZs+3WcZ6zpTLh3uGNQHM/sRkEwHFcVT3+CA7eAd93H5rUuBCdGtVABMV4kXRtMT3
         wvUg==
X-Gm-Message-State: AOAM532gBmDFgQ8M+FNmxTyTkoz0FyoT9CeDcwdzNopCIOkvl83//Q7Q
        2gZkDjurSS2x8DwZqdN5gjEKFrdRtYnNdA==
X-Google-Smtp-Source: ABdhPJwKqSkcrt+/Kaqpljm8bdOV6cmPOZzibdwiReoPfuhes/76eHVa+3H3kphSNcvWwAA1TTEfNw==
X-Received: by 2002:a9d:8c2:: with SMTP id 60mr12168888otf.217.1622318544504;
        Sat, 29 May 2021 13:02:24 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:24 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v6 11/34] dyndbg: accept null site in dynamic_emit_prefix
Date:   Sat, 29 May 2021 14:00:06 -0600
Message-Id: <20210529200029.205306-12-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2 prints use site->member, protect them with if site.

no functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index b2fd7c181bd5..868f56edf831 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -630,15 +630,19 @@ static char *__dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
 					task_pid_vnr(current));
 	}
 	pos_after_tid = pos;
-	if (dp->flags & _DPRINTK_FLAGS_INCL_MODNAME)
-		pos += snprintf(buf + pos, remaining(pos), "%s:",
-				desc->modname);
-	if (dp->flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
-		pos += snprintf(buf + pos, remaining(pos), "%s:",
-				desc->function);
+
+	if (desc) {
+		if (dp->flags & _DPRINTK_FLAGS_INCL_MODNAME)
+			pos += snprintf(buf + pos, remaining(pos), "%s:",
+					desc->modname);
+		if (dp->flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
+			pos += snprintf(buf + pos, remaining(pos), "%s:",
+					desc->function);
+	}
 	if (dp->flags & _DPRINTK_FLAGS_INCL_LINENO)
 		pos += snprintf(buf + pos, remaining(pos), "%d:",
 				dp->lineno);
+
 	if (pos - pos_after_tid)
 		pos += snprintf(buf + pos, remaining(pos), " ");
 	if (pos >= PREFIX_SIZE)
-- 
2.31.1

