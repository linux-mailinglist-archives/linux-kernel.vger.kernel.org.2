Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7410433EA49
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 07:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhCQGza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 02:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhCQGyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 02:54:38 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D0AC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 23:54:27 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id u20so39847862iot.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 23:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6StBCK2sKeNyTuk1kSCbfyJqQXg2zhDg9WydesT4oWo=;
        b=I1gXoty4bpgjbP2ZEZm9H6EAUrPKdKkl2gSknimrwHmki5SfjXRzZLTPexCxbO21TO
         rmdeOI2qWiImrgnZZsOvCSR8FikrxqiFz7fOoGPEPd3iJXu3RzMR40TrCE+nlhER3J6K
         ItguXcxhzMKymbFFQ+hOFzJI7wvmYlG7r6L0vIt0CJIX0LLjlZJEYu6FrES3sD5fOzwn
         wCYQ1Bac3n4RfdLsTvTX0oVm2VyvmPeNe2KUUlN5aGwNff/wE86yn6JZHsv1vuye4BFG
         pxwiK/ESHGtGNvOWWYIA42m0u2hZNXUlSr1jbUgBirWkeyjHsXM8Yy/wRvF/pwagqrvm
         2GMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6StBCK2sKeNyTuk1kSCbfyJqQXg2zhDg9WydesT4oWo=;
        b=fA8xic85bpdKqqoU3K5Yn0Ofh6eZ2uUWxqqHA48Jv8S32Kdmp+h7O+pJXkBPeXhKB9
         EarWx9zc5IVrYbkCqocv+naaOs2QNQh1u3JFpPMhIZd64DrhlG1GTCYYf5csMYdHia4k
         +mh+saH+38wrd4wFU5yzHPnLXR7H61L9Q85dXzpbiDl39s4nq/4BxaV6DlvcWSjAU9/a
         kebJ1xwNlvfBVs2Ale6HvJ8EIFNpWNsyIU2yFOo+2NAnOdQ3dNhicMpTlOf6nJNLUt9G
         ahqCPFUD1y7OkoPnGtKNjP4ImqWVYY4nMoIDojiH/RmtvdYvUaLt2Z7y5rE8yD4hLG4U
         ydcA==
X-Gm-Message-State: AOAM533ab5AcSpx/yvlzixK/8Pq5V7Plvh2IcUV1wEHuQM3NzK7S6KD5
        kM2TXWU621M99hNh1LRXudE=
X-Google-Smtp-Source: ABdhPJy4wZ8oX/979W+Wup05NwM+WJ4yGuyu4yLahrVFWaJQFz2E6+JvALhuaPBVoblczMT9Fh09pg==
X-Received: by 2002:a05:6638:381c:: with SMTP id i28mr1742630jav.60.1615964066683;
        Tue, 16 Mar 2021 23:54:26 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id w13sm10583057ilg.48.2021.03.16.23.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 23:54:26 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v4 06/19] dyndbg: accept null site in ddebug_change
Date:   Wed, 17 Mar 2021 00:53:59 -0600
Message-Id: <20210317065412.2890414-7-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210317065412.2890414-1-jim.cromie@gmail.com>
References: <20210317065412.2890414-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix a debug-print that includes site info, by adding an alternate
debug message that does not.

no functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index abe3382aabd5..151e55ab6bb5 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -235,10 +235,17 @@ static int ddebug_change(const struct ddebug_query *query,
 				static_branch_enable(&dp->key.dd_key_true);
 #endif
 			dp->flags = newflags;
-			v2pr_info("changed %s:%d [%s]%s =%s\n",
-				 trim_prefix(dc->filename), dp->lineno,
-				 dt->mod_name, dc->function,
-				 ddebug_describe_flags(dp->flags, &fbuf));
+
+			if (dc)
+				v2pr_info("changed %s:%d [%s]%s =%s\n",
+					  trim_prefix(dc->filename), dp->lineno,
+					  dt->mod_name, dc->function,
+					  ddebug_describe_flags(dp->flags, &fbuf));
+			else
+				v2pr_info("changed %s:%d =%s \"%s\"\n",
+					  dt->mod_name, dp->lineno,
+					  ddebug_describe_flags(dp->flags, &fbuf),
+					  dp->format);
 		}
 	}
 	mutex_unlock(&ddebug_lock);
-- 
2.29.2

