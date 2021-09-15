Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4479040CD96
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 21:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhIOT53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 15:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhIOT52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 15:57:28 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE63C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 12:56:08 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id ci14-20020a056214054e00b0037a75ff56f9so7919470qvb.23
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 12:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=1D42zcUJP7Yd1OBpScfym6RyYgwjdXqxQ6ExRKg2hiA=;
        b=Qh0v9EKYh48K68psvZw/Otnu1Zajri6jZtVWAmAzRMbjKkXMNn7aUytL84TkGc35Zi
         jQkaUW8s37BO+r9+CjdYmuoh7FtOt1xKAj8a1JzrU3AwROGOoFkD8kB6uemU5my+CBSO
         0OL2auP8TMx/9JFv4TCUyGCUqlM7LRyrHLCDbLHqtr+LLHQvR35GljwU1glAgjF0S83c
         wEoOzRecOUU9v83n0SU2CvxBeDGyTpjnoGaT/ZxSz5gXOEMEpq87pPp5df5kR6VR8dnt
         XyGdFE3sQ8LTIgxkHbltYDGsQ7scPikxhX1P8WIz5ihyIriym9+y4KmX/yrWgllYIoYC
         vjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=1D42zcUJP7Yd1OBpScfym6RyYgwjdXqxQ6ExRKg2hiA=;
        b=ytkfZ5Cb8Z5fc/xN1vmRFCSk9BO3TMLciuOwj9uXc+GjxvyRM+mqKKujXxeGhBDSan
         2zSi7mzPM8pI9KA8CJSkNHHle1pK74pqRbezfvsN/6jbBoD9h2LuHH7PwIQjKAsatxm2
         f38Md240+yRbrCr9agFhfVu5A+pNu1pM379FJ6OQk8kFWZBI7B9wim/GThzIOMd8O91Z
         EFDS9Q+c11Nf5IwX1gwbLEuF+CZW7hAlfPKWUiPRoTgq/rOB0tQ72h8cbebRgyAM12dW
         AC7AM6F8r5eQz8pTL/grLFvVk/docG6JMPrOhr0rV0NdBYEE28Wh1Zz5MyTHna4pk+Pz
         7hLg==
X-Gm-Message-State: AOAM533STyRKT6AErv31tOctieP9hkqy7dvxcHqL+DZYfgdEEv1DtWHY
        VwZZwaoVgUiNumEu6OzaEURRlhIzy9Dq4gLbig==
X-Google-Smtp-Source: ABdhPJwstirmxKy545qmG+7yGZJ8nD+HM/bCVTLS993GeQPljENqko1YZQK4YfHdcV2F9a4mLCkNhctIjasPMFiD3w==
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6214:1142:: with SMTP id
 b2mr1799508qvt.0.1631735768059; Wed, 15 Sep 2021 12:56:08 -0700 (PDT)
Date:   Wed, 15 Sep 2021 19:52:49 +0000
In-Reply-To: <20210915195306.612966-1-kaleshsingh@google.com>
Message-Id: <20210915195306.612966-6-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20210915195306.612966-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 5/5] tracing/histogram: Document expression arithmetic and constants
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        Kalesh Singh <kaleshsingh@google.com>,
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
---
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
2.33.0.309.g3052b89438-goog

