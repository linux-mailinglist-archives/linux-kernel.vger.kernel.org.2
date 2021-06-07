Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0821D39DD1F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 14:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhFGM71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 08:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhFGM70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 08:59:26 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897E4C061787
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 05:57:20 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id s8-20020adff8080000b0290114e1eeb8c6so7805019wrp.23
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 05:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sD69zNYhvDJZj4XAjsuMed8nmTBfm3+Rx7K2iXla7Fw=;
        b=svdhpRXgX32L95lkinoM13DGGZ9Xn4139ZPhsbmIBBkAtZmO6AIcBJBZ9ZyBEJ1Kqe
         5f3v3ZFAbyefBSriJAeDvk11m6NLsfY8h/m/40sebUinfoK/7N4F5kPpPlQT/wZHVgNL
         WrQKDqgb8JzfpG+a7f5mZFrva0ADaEeu2ADGM+LPwnoYvSGsr7DprqP+q+f2NsXjZ4dC
         cV+MxoiTcg2AmlS6RJA9nvbO3+OBcOBmSJej/Wxuf6I0hetCvllsIUyI0vGvWlZfPVaX
         ErUhZ+99Q0nbZVBx8HWSSdhR0mn61nT5yyGxpoyKJ056HxDOmkEWjMxcOtl4gu5H4d8R
         cSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sD69zNYhvDJZj4XAjsuMed8nmTBfm3+Rx7K2iXla7Fw=;
        b=qIVxnqWd1H268cJjtD4F812uFGwCTctwy5RCTEYNRLjg1UqMrMDlbxUPYSvQ9HtlC7
         6odVa0B35KcqQPio9Abcb2i9cYxIVNxBjVrPF9TNKOGNqim/6OEEN9v4v6EvgdVGSSec
         xNRotokx6zZfmQqJALNYk1yA0fqjAHMhRDMk7bIyVF8QmGthHP5rTMrokGiDP63/Bt8v
         6b97YF0iUoPuuiJZr02twWuWw9kPeWNVqQ7L08M+X3qqXj4OFNmPuUD9iA0/7d9AI61w
         Il5+tE7lMU9h6kiubH1vHLr2EHTj8VRbxmWeWc5vcPC4rTGPGjYz7hjAGmt4ZlgUOQWv
         6WfQ==
X-Gm-Message-State: AOAM531p1xpA2Shryw+JhXQ3QPLLb2wtJTv86cvVfcsf0zvn9TgyhAED
        qdckf0zptXI9dxupKVvtpraNEKdtEA==
X-Google-Smtp-Source: ABdhPJwbsxWS6J+2yPT/tfcX++i6WfUjLdt9AdgXrkzxhpQVXMTjXdFtBT/5uXQ7uCIRElCNyPZG14qSCg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:2587:50:741c:6fde])
 (user=elver job=sendgmr) by 2002:a05:600c:2216:: with SMTP id
 z22mr13925816wml.66.1623070639129; Mon, 07 Jun 2021 05:57:19 -0700 (PDT)
Date:   Mon,  7 Jun 2021 14:56:52 +0200
In-Reply-To: <20210607125653.1388091-1-elver@google.com>
Message-Id: <20210607125653.1388091-7-elver@google.com>
Mime-Version: 1.0
References: <20210607125653.1388091-1-elver@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH 6/7] kcsan: Print if strict or non-strict during init
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     boqun.feng@gmail.com, mark.rutland@arm.com, will@kernel.org,
        glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show a brief message if KCSAN is strict or non-strict, and if non-strict
also say that CONFIG_KCSAN_STRICT=y can be used to see all data races.

This is to hint to users of KCSAN who blindly use the default config
that their configuration might miss data races of interest.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 439edb9dcbb1..76e67d1e02d4 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -656,6 +656,15 @@ void __init kcsan_init(void)
 		pr_info("enabled early\n");
 		WRITE_ONCE(kcsan_enabled, true);
 	}
+
+	if (IS_ENABLED(CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY) ||
+	    IS_ENABLED(CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC) ||
+	    IS_ENABLED(CONFIG_KCSAN_PERMISSIVE) ||
+	    IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {
+		pr_warn("non-strict mode configured - use CONFIG_KCSAN_STRICT=y to see all data races\n");
+	} else {
+		pr_info("strict mode configured\n");
+	}
 }
 
 /* === Exported interface =================================================== */
-- 
2.32.0.rc1.229.g3e70b5a671-goog

