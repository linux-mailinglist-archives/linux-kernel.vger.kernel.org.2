Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04FC734D0E7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 15:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhC2NF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 09:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhC2NFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 09:05:47 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDA0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 06:05:47 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r12so19336926ejr.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 06:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oGh1InaqHkyqlrBvAthXPphuDhfQU9tuh4tsQmC6JYs=;
        b=aeqLA8XhKBBeXpaIQN/lfiyNiutw2uuTeWpS6/mFySdmUUxg0qaJlhUFvzo6zZPz/P
         D9wkTFtUwN1SWa3KnXQrgI9EfMVCYrMBERh+vOh5Df533prRthYyCcg3QbKBwuxvh31/
         bMdqfCLOz7C+P8RLSFOcNI2Sdf3rAPNj5VNIj7/oSKZkm+JjAZss0fQB2raw9J7nvxJF
         eOM+HfmGXDQ5nI9HcSDZnTla/HTeno/HUOtiOibwaWUW3K1axi1eiJnN4h3FiC8sJhHs
         OiAmP9ktXymGhifKLl27/MPDVqhCV0uqxP33fIhbymp9zoa7wP210HLCvqVIP9GigAzo
         nhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oGh1InaqHkyqlrBvAthXPphuDhfQU9tuh4tsQmC6JYs=;
        b=STthMf0+iVpuKhYz+odATU+GdF4lSHBoG0ingaH4lPDZPRdmrG3SazrNlM+BGiH16T
         KMRIRQou13LvhN0gjI/yyTgdoeM00UimUrJCoB5AmOk+Xm7juHbpwLmM/cR/vSvvx7FF
         l+ZaFpwOGG3bjvze21Ylu16XHt4Pd72+M5nOcPEIIUyebcQKRpngRmpzfRZsxqQ9aSK6
         SgwDJqc/+WG828/tdfHuDeb+6TtvAtUroDTDP5yLoqZ1EYufwt2EkWF9Yip5p7Khiae9
         CtR5Lr83U7tdho1NU5MoUK8vpoAJBGCSTXvAtSCno9I/rQFGPGcb3Yy9VTun9Ebzv+r1
         iqYQ==
X-Gm-Message-State: AOAM531fO7IsqsmJRoliohnnU8cPjnrmmErhj1gEgSukCoTYJzKcNJRh
        otsuFbbc4uGVSnfv4QveQw4SZ8lh9+Qj5w==
X-Google-Smtp-Source: ABdhPJw8L2RdgWR4wBjmr7/hUnqETUxe+oYkH5f1h+ly65MPlWIr+EIDCD0sovytUmI+a2oPNtnx7A==
X-Received: by 2002:a17:906:9b2:: with SMTP id q18mr1525732eje.147.1617023145893;
        Mon, 29 Mar 2021 06:05:45 -0700 (PDT)
Received: from localhost.localdomain ([95.87.199.133])
        by smtp.gmail.com with ESMTPSA id gt37sm8123905ejc.12.2021.03.29.06.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 06:05:45 -0700 (PDT)
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, peterz@infradead.org,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [PATCH v2 0/5] Add "func_no_repete" tracing option
Date:   Mon, 29 Mar 2021 16:05:28 +0300
Message-Id: <20210329130533.199507-1-y.karadz@gmail.com>
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

 kernel/trace/trace.c           |  29 +++++
 kernel/trace/trace.h           |  25 ++++
 kernel/trace/trace_entries.h   |  28 +++++
 kernel/trace/trace_functions.c | 222 +++++++++++++++++++++++++++++----
 kernel/trace/trace_output.c    |  47 +++++++
 5 files changed, 324 insertions(+), 27 deletions(-)

-- 
2.25.1

