Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3828348604
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 01:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239372AbhCYApn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 20:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239360AbhCYApU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 20:45:20 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C020DC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 17:45:19 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id w3so164909ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 17:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lv3UurVlQJhS7u4wSNnZyaLnwGLNqkzWmNUq14Yzcn4=;
        b=K+mSBcBO/ruZLDzHAdcQt834WPzV3u6GfdjyMB5OtLVjXxby1fHu9aXkPDeMfaquC6
         A8vPHX6smaCzk2M+gJwFlLBGile+EUBaNydd8Y0IokoiWOHFoN8/LWmSSBMFt5BdI4aA
         mph4qTMLDD2TlMXSyG/UrXEP8dmfMmMfY3MWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lv3UurVlQJhS7u4wSNnZyaLnwGLNqkzWmNUq14Yzcn4=;
        b=qp6xloScigBqASfvNnKZGNmK8DJg+UiThVMaty/6NnXkDvnMicm3EilnTNqUCQALhk
         UvfCiADUEm+XuEsl4iJhK9K+NAc4XSzRgK3/V8pdxDZAbLbJnaguPKeRmIOAYLRWeolT
         eeBPYQjV2OMATBsDoLXTBuZB0DvQ2wDkQqgqK2pJz3ZxPlw0ZYmhjeZ0166lvragWNVD
         EUPmNWlXiQFXBhcfRVYtV80MNVJ+jld/vma7HR8uUDX2FB7cQWSfYNak17M2o09WKfJU
         DEX2gH4kUwYjqqbs8wFf4LkG5OwvhAmHQ84unosMzVLbw83trdQ8iZFcqnnm8+yIPXWi
         fRLA==
X-Gm-Message-State: AOAM531QOsLQlaA7Y596djf/yHoQ6FbkcCe2rQAwaDGYDt6EkFKmzvUO
        McTHyIyLFjBFAWyiswhFW4dOYBdugOSIJe9f
X-Google-Smtp-Source: ABdhPJyItnzG/cy25jw9peNgSlRjwU4J/S9rMH3boDA8QNflGhrzjHN/rA476WIX3Iu70vEGpK+BXA==
X-Received: by 2002:a17:907:162b:: with SMTP id hb43mr6645409ejc.41.1616633118535;
        Wed, 24 Mar 2021 17:45:18 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id jx22sm1657623ejc.105.2021.03.24.17.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 17:45:18 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 2/2] sched: use -EINVAL in sched_dynamic_mode
Date:   Thu, 25 Mar 2021 01:45:15 +0100
Message-Id: <20210325004515.531631-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210325004515.531631-1-linux@rasmusvillemoes.dk>
References: <20210325004515.531631-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-1 is -EPERM which is a somewhat odd error to return from
sched_dynamic_write(). No other callers care about which negative
value is used.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3959481261bb..5b29261668a6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5378,7 +5378,7 @@ static int sched_dynamic_mode(const char *str)
 	if (!strcmp(str, "full"))
 		return preempt_dynamic_full;
 
-	return -1;
+	return -EINVAL;
 }
 
 static void sched_dynamic_update(int mode)
-- 
2.29.2

