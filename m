Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44414582E0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 11:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbhKUKQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 05:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbhKUKQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 05:16:29 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAC6C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 02:13:24 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id b13so11629780plg.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 02:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jz7G1X3noj7SdKT0BssmGxJwd6YdQwKy8J5O5kFPx/A=;
        b=hPjd7zP2W3VwO1Z4CBoUY6mieF4iT+nIUjE7tgeP2gy8/frGuaHMkBG/+mKnA2bC+j
         +jfZ7DMeKU1bArdHF1OTamHF/fVBElYmgMq/vRR/ocLZxsQ+oK0/E5Wi1h42zpRZnwC6
         yUeWyfrvpxYJ2XmhK8gR2ud97z85681CWEJJ5J9Ij0sGpu7paI3tQ6pUN4xsUQ4sXp0u
         Xo5Z3uKQtYAf8hL5gxePQozs1DiazIfX1McQc/PO0FDiWe1pK8SH5faQe99UQa1xxroc
         Maqe3KXuXrvsxCk3vo8XPs0S5bMKVmZbmFOe5FNlFwqTPG/VHoL+e34oAvngej0zo3gz
         t/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jz7G1X3noj7SdKT0BssmGxJwd6YdQwKy8J5O5kFPx/A=;
        b=bpox5sZhBvo+3E3B1GjWv1yvAQplARNiu2gtMacixhi7yEMYwPwApQxrL7p+Dj4D/S
         V+HqlmQMqXBro2KnR/1MIf0Fg1gN4KHhkrVqlZcRBuazvg3nHHa2wBgcnbw62FVqdkSH
         WyoTedqZRwWUeYmPTII2tf1a/V4k4HBDKSNE7ykjWq4UYyszVFdHMNHJvCN0dwfCAOXz
         G0OMqc/o3KhGLhOhPIHA6TK0uKOxygEw752GqKzaZs94Wg6NtwDxnNw7yCkQiN32ipVn
         ywgJh2dfGpaD1ICwETXorE5SdD1ohlLcVUe6PBsXrTWNtRSY05JmBKvQAos89TRIiAYB
         minw==
X-Gm-Message-State: AOAM530Hz7+DtYBjsw2C3VYV9D2aanFe4bF/0OV+ep5xmooqWHsKP3M7
        7hLYUNuMFfLxQr8l8ITb3jk=
X-Google-Smtp-Source: ABdhPJyQsqrMCoVLEZdQ+jQfLlJBDck3tb4ASoikt4GWJZqLMSci4BkU90KnfkyY3OtsEXKlj0LavQ==
X-Received: by 2002:a17:902:ab47:b0:141:95b2:7eaf with SMTP id ij7-20020a170902ab4700b0014195b27eafmr95815169plb.40.1637489603356;
        Sun, 21 Nov 2021 02:13:23 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id nl16sm16226182pjb.13.2021.11.21.02.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 02:13:22 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: yong.yiran@zte.com.cn
To:     jani.nikula@linux.intel.com
Cc:     joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        yong yiran <yong.yiran@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm/i915/request: Remove unused variables
Date:   Sun, 21 Nov 2021 10:13:09 +0000
Message-Id: <20211121101309.23577-1-yong.yiran@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yong yiran <yong.yiran@zte.com.cn>

The clang_analyzer complains as follows:
drivers/gpu/drm/i915/i915_request.c:2119:2 warning:
Value stored to 'x' is never read

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: yong yiran <yong.yiran@zte.com.cn>
---
 drivers/gpu/drm/i915/i915_request.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index 820a1f38b271..5e4420f461e9 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -2047,7 +2047,6 @@ void i915_request_show(struct drm_printer *m,
 {
 	const char *name = rq->fence.ops->get_timeline_name((struct dma_fence *)&rq->fence);
 	char buf[80] = "";
-	int x = 0;
 
 	/*
 	 * The prefix is used to show the queue status, for which we use
@@ -2079,8 +2078,6 @@ void i915_request_show(struct drm_printer *m,
 	 *      from the lists
 	 */
 
-	x = print_sched_attr(&rq->sched.attr, buf, x, sizeof(buf));
-
 	drm_printf(m, "%s%.*s%c %llx:%lld%s%s %s @ %dms: %s\n",
 		   prefix, indent, "                ",
 		   queue_status(rq),
-- 
2.25.1

