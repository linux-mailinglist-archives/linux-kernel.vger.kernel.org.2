Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8E2347748
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 12:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbhCXL01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 07:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbhCXLZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 07:25:37 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB991C0613E2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 04:25:36 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id m8so952645qtp.14
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 04:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yTQtN+ZnokJzpQVm2BawzGlkCzsy9LGpOuPbrdojTxI=;
        b=eB0ckdgLY/9Mw7+c6wAMy4us/PB/YzfvC+tjuW6EEFemR43arcp3phQ/zVb+Cjf3L6
         kaphLRablv22cVVyXqwnAgfsL9bHsNK/McsF8kXgkjWGDCkqlD2LviOVeeYxSD4Cgc7S
         N5QTatiiBWUzZRX1RBYVDomafcyIzAFl6YiABcQwfd9FKnW2tS+3QnWAsic68aFgZrwx
         Hp4jWqv0Sva60F0SWTWBJvvSt3G30DxVxVY67PD02YygcoZYEP3JvuOMz+L0sinSO/+5
         hf2OhTpcNPGhFyAwcHDpY3+eJjZ9fXfzrNcD5PY/7rtTrNahBK8qDRBr3OagakKe6U5A
         XoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yTQtN+ZnokJzpQVm2BawzGlkCzsy9LGpOuPbrdojTxI=;
        b=dpnAAHHyGbAsstzKPq8Jzdkoj6D5P3thWpYD2/suW5NhCbqkpTJkhVVTX3nWMv7EX2
         m1Pze2v1u9y0NHmBMQfdzSNpdGYWQC4+bK+NjPEwkANiFHKtfLYp0uQ6GXczt5XIvLKF
         gdmVEtphaerRrcgwUz60eAJsfI1jjdOp5Ihv21LyjGFOB/cmXhU4jEUsB9nt4668xNOO
         C7etDJOhSAh05Lk6oSTZgsmhRYGbsV07ulv4kCe5CuIeDRkq+RNTxJ2OQ0fno4YvyqDi
         t0uJ3EDqvbvSTiDm4V+Owwt4N1ukwVO4ddutXGrhSZB/cQYOaVQ0pQqbCspv2jQsvske
         e6LQ==
X-Gm-Message-State: AOAM532cXsMWDky+NbmKNvDaIjl9AQpOBEs1v1kxH9oLnmcPDJpHxfun
        pdo0xcEAqHGuVeNPrxCf8BE1uCCdxg==
X-Google-Smtp-Source: ABdhPJzRVukCVxBGVmxIhQ60T0lTvl+h5lsKxkFEL8Sjs6BBC73DCi1y8PZi7hM+RtQxq4YiLP1oMmBNWg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:6489:b3f0:4af:af0])
 (user=elver job=sendgmr) by 2002:ad4:50d0:: with SMTP id e16mr2718629qvq.37.1616585136104;
 Wed, 24 Mar 2021 04:25:36 -0700 (PDT)
Date:   Wed, 24 Mar 2021 12:24:59 +0100
In-Reply-To: <20210324112503.623833-1-elver@google.com>
Message-Id: <20210324112503.623833-8-elver@google.com>
Mime-Version: 1.0
References: <20210324112503.623833-1-elver@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v3 07/11] perf: Add breakpoint information to siginfo on SIGTRAP
From:   Marco Elver <elver@google.com>
To:     elver@google.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, acme@kernel.org,
        mingo@redhat.com, jolsa@redhat.com, mark.rutland@arm.com,
        namhyung@kernel.org, tglx@linutronix.de
Cc:     glider@google.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
        christian@brauner.io, dvyukov@google.com, jannh@google.com,
        axboe@kernel.dk, mascasa@google.com, pcc@google.com,
        irogers@google.com, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Encode information from breakpoint attributes into siginfo_t, which
helps disambiguate which breakpoint fired.

Note, providing the event fd may be unreliable, since the event may have
been modified (via PERF_EVENT_IOC_MODIFY_ATTRIBUTES) between the event
triggering and the signal being delivered to user space.

Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Add comment about si_perf==0.
---
 kernel/events/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1e4c949bf75f..0316d39e8c8f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6399,6 +6399,22 @@ static void perf_sigtrap(struct perf_event *event)
 	info.si_signo = SIGTRAP;
 	info.si_code = TRAP_PERF;
 	info.si_errno = event->attr.type;
+
+	switch (event->attr.type) {
+	case PERF_TYPE_BREAKPOINT:
+		info.si_addr = (void *)(unsigned long)event->attr.bp_addr;
+		info.si_perf = (event->attr.bp_len << 16) | (u64)event->attr.bp_type;
+		break;
+	default:
+		/*
+		 * No additional info set (si_perf == 0).
+		 *
+		 * Adding new cases for event types to set si_perf to a
+		 * non-constant value must ensure that si_perf != 0.
+		 */
+		break;
+	}
+
 	force_sig_info(&info);
 }
 
-- 
2.31.0.291.g576ba9dcdaf-goog

