Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD2C35A555
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 20:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbhDISLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 14:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbhDISLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 14:11:00 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79785C061761
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 11:10:46 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u21so10017009ejo.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 11:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5CNBQKIGe8uXpriUZJHtU/NHWRKcPCBs0Xp0mmWQC1o=;
        b=MMa2FaUd96cdQJ86rg9WFKDx6meq5+7rehW0AaK15x2icSaIKPxp/2g4gDovCNVRb+
         ixzRn5HjeRT6uAbGetA558fTcbiDMub0AOnwBaxrTDjebdaQ7maKpa9JYkbQOLttgCK2
         /Kbuf8rNUDMonuu+2oRZgql3+k9ydCbhODdCArOEuyPV2d5U5Hug369hC9WyyUiTQyc4
         3wNNMr7h59sKmPZ6uQ+c3BWcXth8PeUr5oa3NpWl94zusdlb7W7FVmjYkGjv7vfIrMve
         v0a/k8XhFmP5Z2BwMb436oB3IfhefjXQWfAg+zbzlhk4EVu1QvlNCxP+gxPUmfN+nIt2
         M4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5CNBQKIGe8uXpriUZJHtU/NHWRKcPCBs0Xp0mmWQC1o=;
        b=ST+wEiQe7XLZIQHNJcvbjh6KKL7kx1FxGhwStmLCfPGfUuJ0x/r/qJ7MovpTlJrk2V
         bl77mpZppbfSJ/pTyu105gbEBpj5gXhyu/ZpM1Foubg+cBjD3b6evFeDc/eBTQ4qiAOd
         MHNUv9Wb1CYebWjc1+O1N1jT5Tcpi9d0Z7oexRRNemFV96CbmKOvaPPZbWozSVKTpy5b
         mOBlSt/brjfaus/f0yUxi/OESa+5YxKYEDQ9pabGJOKU4DOdYXSyDm45MNi8f5lhOdsV
         q/oElSe7WiwUPSLRBD/6qUnOWnKdNvUWqfgpDU3WBHi7Wbgr8MMnTo944bTAHWirJQbb
         dQ+Q==
X-Gm-Message-State: AOAM5334qN3gzdy4qRF9IiYgwiJ9zf6GNTeyi3uduLDr9CdMJmqNVVco
        Ivqp65r81WLQR1eExAQgUz1SW+4306ALYA==
X-Google-Smtp-Source: ABdhPJxnyAfzXARNpDOrH0t4qDW1WS/TK3A7MUQRNFpC51n7Y2sWEcoHysT0+olrbEeliyzErrlUtA==
X-Received: by 2002:a17:906:f9c3:: with SMTP id lj3mr6466491ejb.134.1617991845057;
        Fri, 09 Apr 2021 11:10:45 -0700 (PDT)
Received: from localhost.localdomain ([95.87.199.133])
        by smtp.gmail.com with ESMTPSA id s20sm1806303edu.93.2021.04.09.11.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:10:44 -0700 (PDT)
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, peterz@infradead.org,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [PATCH v3 0/5]  Add "func_no_repete" tracing option
Date:   Fri,  9 Apr 2021 21:10:26 +0300
Message-Id: <20210409181031.26772-1-y.karadz@gmail.com>
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


Yordan Karadzhov (VMware) (5):
  tracing: Define new ftrace event "func_repeats"
  tracing: Add "last_func_repeats" to struct trace_array
  tracing: Add method for recording "func_repeats" events
  tracing: Unify the logic for function tracing options
  tracing: Add "func_no_repeats" option for function tracing

 kernel/trace/trace.c           |  27 ++++
 kernel/trace/trace.h           |  25 ++++
 kernel/trace/trace_entries.h   |  28 +++++
 kernel/trace/trace_functions.c | 222 ++++++++++++++++++++++++++++-----
 kernel/trace/trace_output.c    |  47 +++++++
 5 files changed, 321 insertions(+), 28 deletions(-)

-- 
2.25.1

