Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B603A43A490
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 22:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbhJYU0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 16:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238131AbhJYU02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:26:28 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464BDC04F584
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 13:11:47 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id mv23-20020a17090b199700b001a20f0fb7d0so204332pjb.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 13:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=kE3Nv1lKwT793xJwq+iC3RoCHqpYdQS3Tip3semgyOw=;
        b=jT9hL/u1NDVN8zR7XKWAcsKCnfrWgrjG5UI5cJQnv1KhEb9MBx3ekh/Z7RCbqnTgLW
         R5aN9TfzGZzqZc0QenFl6+Ar37BPVJ2L1WvdSeaA4WXT3GuM4umVUCgkIC3FWLrshtre
         955z0qFElgDGpho9GqY+box4Yjy619K0mUiylpcdbifZ8WO5LL0hKiM/rhkeeFPbI3/J
         sAby+jo00xUuZx1RXFD4rh9BdO4G5j18EPfStl0l+oMpjCxz81MbMhS/GLMcppZtta26
         54fKEJrvYVyg7GR/d3k5wjJVgaJ45UekfB2u8WRjT6oCWuM+6VVUDDkf9Irst4eA/y7D
         L8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=kE3Nv1lKwT793xJwq+iC3RoCHqpYdQS3Tip3semgyOw=;
        b=dWeqR4a3f3tgj8KEczXvecYzQYcATMbfs7gLddtJ8t3adjHYQdIYoVNUybcfjrUo3q
         RMVZG0bVblBoV3nrb4/GmLlz5ETk7+jRPOf/v/vO+s2LHvBDQs1g/PdAbM7RroQEXN37
         Oee6iF859vJBgMqPxaYzgPf4pv302O5IfYN1+KQvGMQwfJo+K54yOinSnDtYQRlvmgZy
         XOTpyn6lvPitBvPIPPqTWJymMU8REoHtNMJdF0jYC2/He/AJfpl8oAdN3f0KvJ8adUNk
         0acoGSTeKHLcJnNGG7NU3ZJPNpT5gf0ArqHtPklM9zsu6Ojo3pINmeqCf2aAN25QSbx/
         /Pzw==
X-Gm-Message-State: AOAM530tCdxPp8bl6UhqrkGyGk8uQLX5XYbW5WaO9TXlohTkpsSJBjwH
        Wxy/sZyBwqvSinrkunj1oaHePS3QUPQxrWuYPw==
X-Google-Smtp-Source: ABdhPJyxeUk13DvsXj5SiV0ksnk9J/ASzWXo2Es+NAai4ecZLq/5zSPwEEXxxFBhfDpQ+mVUqZiJVhiahzjS5xrZcA==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:b783:5702:523e:d435])
 (user=kaleshsingh job=sendgmr) by 2002:a17:902:a3c1:b0:140:5de3:9c95 with
 SMTP id q1-20020a170902a3c100b001405de39c95mr5367547plb.75.1635192706759;
 Mon, 25 Oct 2021 13:11:46 -0700 (PDT)
Date:   Mon, 25 Oct 2021 13:08:40 -0700
In-Reply-To: <20211025200852.3002369-1-kaleshsingh@google.com>
Message-Id: <20211025200852.3002369-9-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20211025200852.3002369-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v4 8/8] tracing/histogram: Document expression arithmetic and constants
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Histogram expressions now support division, and multiplication in
addition to the already supported subtraction and addition operators.

Numeric constants can also be used in a hist trigger expressions
or assigned to a variable and used by refernce in an expression.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
---

Changes in v2:
  - Add Namhyung's Reviewed-by

 Documentation/trace/histogram.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 533415644c54..e12699abaee8 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -1763,6 +1763,20 @@ using the same key and variable from yet another event::
 
   # echo 'hist:key=pid:wakeupswitch_lat=$wakeup_lat+$switchtime_lat ...' >> event3/trigger
 
+Expressions support the use of addition, subtraction, multiplication and
+division operators (+-*/).
+
+Note that division by zero always returns -1.
+
+Numeric constants can also be used directly in an expression::
+
+  # echo 'hist:keys=next_pid:timestamp_secs=common_timestamp/1000000 ...' >> event/trigger
+
+or assigned to a variable and referenced in a subsequent expression::
+
+  # echo 'hist:keys=next_pid:us_per_sec=1000000 ...' >> event/trigger
+  # echo 'hist:keys=next_pid:timestamp_secs=common_timestamp/$us_per_sec ...' >> event/trigger
+
 2.2.2 Synthetic Events
 ----------------------
 
-- 
2.33.0.1079.g6e70778dc9-goog

