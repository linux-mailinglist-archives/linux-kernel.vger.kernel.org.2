Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263283611F5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 20:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbhDOSTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 14:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbhDOSTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 14:19:34 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7610C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 11:19:10 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id o20so2939123edc.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 11:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jZc2AUCbTG/HxCmgVJd8gMY0LuI50FHIEGq64TXtsuQ=;
        b=AzvZPaPWIJjf5i3r+Ybo28R0fr7E71JakY7GOsT4YUj9AIMnBsFZjlFYfIdybQRliv
         oPrTAfkhUaWuLoIXZNE9OCk1eqO1bqVgwSwK8uvqZm2c41ppmjHa1qoIc3niH7vhWoOG
         mikvmsHb1dVaERICdi2LN5hraJpaF2CC8Yr5vcvvyzjZV7/rCmrooyqmgvr+wnDBLy0U
         GxQf6lVKcdToM5Uyc3O8zWmIFr865bDpWhRT6gpMirqki7PVhAROZhhxGxZel4e0bNzJ
         wQkQf70csdbJWrOFo99o2nvhJB2G3gf+eYL8CaVe+ueUpsdaBl1mRi0rHxxHkplkV6cR
         nQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jZc2AUCbTG/HxCmgVJd8gMY0LuI50FHIEGq64TXtsuQ=;
        b=WkyjzvM218+KQVRAY3Fnng1DXWQ0ZVLRDQXG4IujATOD1OrPV31eFIYfdHiQzVjx6i
         XMQ8/6kW5tyhDKneJezZY7quHR4wshtok+oJpwI3tjTNgSFuMW/+3wBVwyQDKwUF26Xj
         fWrhnAHhUOgYCSkdFHvZ9xQWCcITFx6gvMbHWfLKAKLQl1UlbOWiMvaPq4YMbkBDrjoD
         B1SbAfjY53md7p5CxmXuWVmJbnKeWKpEBodvpyruMxKISs4MY7nhcY0+b99/+x1Zak3f
         7pNrY5EShXv+uR7HL6fZlLnYKhS4BASvzizAfTbJjP94u+gzfLonmmoi2Tvl8hkaEPz8
         MWfA==
X-Gm-Message-State: AOAM532L4s4b1GznroRCXa7y99q7l5wu0jY9VB9llhUNgIuj+rpGqRt4
        ELroRjs3iynd6lhnTe+wH1UGUMyof5Y=
X-Google-Smtp-Source: ABdhPJzpQ/za6eeDQPq6SMSMWtD2AszvxpGGwnzeohcJNpYb0BxdgkT6bSogIgr1hoDSE9ItIHg32Q==
X-Received: by 2002:aa7:d699:: with SMTP id d25mr5704005edr.83.1618510749232;
        Thu, 15 Apr 2021 11:19:09 -0700 (PDT)
Received: from localhost.localdomain ([84.40.93.55])
        by smtp.gmail.com with ESMTPSA id h9sm1130903ejf.10.2021.04.15.11.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 11:19:08 -0700 (PDT)
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, peterz@infradead.org,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [PATCH v4 0/6] Add "func_no_repete" tracing option
Date:   Thu, 15 Apr 2021 21:18:48 +0300
Message-Id: <20210415181854.147448-1-y.karadz@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new option for function tracing aims to save space on the ring
buffer and to make it more readable in the case when a single function
is called number of times consecutively:

	while (cond)
		do_func();

Instead of having an identical records for each call of the function
we will record only the first call, followed by an event showing the
number of repeats.

v4 changes:
  * "[PATCH 1/5] Define static void trace_print_time()" is added to
    the patch-set. This patch simply applies the modification suggested
    by Steven Rostedt in his review of v3. My contribution to the code
    of this patch is really negligible.

  * FUNC_REPEATS_GET_DELTA_TS macro is improved.

  * The way we print the time of the last function repeat is improved.

  * "tracer_alloc_func_repeats(struct trace_array *tr)" is removed from
    trace.h.

  * FUNC_REPEATS_GET_DELTA_TS macro is replased by a static inline
    function

v3 changes:
  * FUNC_REPEATS_SET_DELTA_TS macro has been optimised.

  * Fixed bug in func_set_flag(): In the previous version the value
    of the "new_flags" variable was not properly calculated because
    I misinterpreted the meaning of the "bit" argument of the function.
    This bug in v2 had no real effect, because for the moment we have
    only two "function options" so the value of "new_flags" was correct,
    although its way of calculating was wrong.

v2 changes:
  * As suggested by Steven in his review, we now record not only the
    repetition count, but also the time elapsed between the last
    repetition of the function and the actual generation of the
    "func_repeats" event. 16 bits are used to record the repetition
    count. In the case of an overflow of the counter a second pair of
    "function" and "func_repeats" events will be generated. The time
    interval gets codded by using up to 48 (32 + 16) bits.


Yordan Karadzhov (VMware) (6):
  tracing: Define static void trace_print_time()
  tracing: Define new ftrace event "func_repeats"
  tracing: Add "last_func_repeats" to struct trace_array
  tracing: Add method for recording "func_repeats" events
  tracing: Unify the logic for function tracing options
  tracing: Add "func_no_repeats" option for function tracing

 kernel/trace/trace.c           |  35 ++++++
 kernel/trace/trace.h           |  19 +++
 kernel/trace/trace_entries.h   |  22 ++++
 kernel/trace/trace_functions.c | 223 ++++++++++++++++++++++++++++-----
 kernel/trace/trace_output.c    |  74 +++++++++--
 5 files changed, 336 insertions(+), 37 deletions(-)

-- 
2.25.1

