Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEB141CEB4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 00:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347054AbhI2WF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 18:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346891AbhI2WEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 18:04:05 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A88C061769
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 15:02:23 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id k23-20020a17090a591700b001976d2db364so3138662pji.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 15:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nyOyOlsEKGoiL/2uVNNvOLt4uOk9SOe6cJyNtLyvzOQ=;
        b=kRo9hk0UyGdTkqt77Dr046kgIcuTjrjw5oEmWNDGmgIBl3aWShjXYNka6SUmRqg4y+
         ihdhFSMkv2SnJUrLFS5OtchqcINVW6hlSfuhT6JTuwYPaUP7/gcp/aGWaSEgDV5Agd5c
         4o7rqV3x3NbwkCbiBVPZcUHUEl95/qr1hSJWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nyOyOlsEKGoiL/2uVNNvOLt4uOk9SOe6cJyNtLyvzOQ=;
        b=HHHCuhpP+xSbvIuJWdWarHhYbmtqQSK+B4LE2iPybYB39ybRVsJNPNJ8k8I5tL2QbI
         onsjnqNsedANl9Zz7IphyHvYnscb2IcdiQ46X59UVePwxm1TdIR+14N8+Y4lWrmr53Jv
         pLJgA4YO1k7KxLgKI7bKVz3lkTBjTiaD1/ZyGbJTVeBwpmsUhVtLbHkSQXgYDHN0THMA
         6R+7uEpYfERx/nL3mclj9FvkfEGb7+njm9h6H54D5OCYH2xk1mMDf924sppFERN4p/nc
         b/o3CaGFIyqzOABFROOtwYbSKhEj2M9QApI7/IudKl8e0Gk2O/hA313os7qVmqmQLfGN
         nAIw==
X-Gm-Message-State: AOAM531AtZOIM3xutR1Pf1y5pJGfPsUPWpl1RQebZOEhmVa1eWIe4Nkf
        gYzIgh859qUDzbbqq694pCqAww==
X-Google-Smtp-Source: ABdhPJwINc9gT+N/bpklJl0wNNp4lZVB77p5Vn7pgqDHE6xW6YcFnaW+8mOWThyWIb0j2VFrVYZYEA==
X-Received: by 2002:a17:903:1103:b0:13a:1dd7:485f with SMTP id n3-20020a170903110300b0013a1dd7485fmr2107982plh.6.1632952943592;
        Wed, 29 Sep 2021 15:02:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u6sm574131pgc.68.2021.09.29.15.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 15:02:20 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jann Horn <jannh@google.com>, Michal Hocko <mhocko@suse.com>,
        Helge Deller <deller@gmx.de>, linux-fsdevel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Anand K Mistry <amistry@google.com>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Alexey Gladkov <legion@kernel.org>,
        =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        Tycho Andersen <tycho@tycho.pizza>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Stefan Metzmacher <metze@samba.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH v2 4/6] proc: Only report /proc/$pid/wchan when process is blocked
Date:   Wed, 29 Sep 2021 15:02:16 -0700
Message-Id: <20210929220218.691419-5-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210929220218.691419-1-keescook@chromium.org>
References: <20210929220218.691419-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1207; h=from:subject; bh=xZsf3ZWiO9WXhoaOn6NNrzDXL4l3Q1Xs8ZxRNuqWhk4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhVOJp63g3iVewdohBr8uE9oIrIG7jiG9FYdaSRwEy c4fWtEWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYVTiaQAKCRCJcvTf3G3AJmhgEA CsnKYCJhMFtSI3AqsLX3bsDhyI7wOq0Saq/NYAqYCvCq9g4cXqSuOflggSmlTaoSXDpv5t2Dnlnhxz 6XhgODSU2KL6AIV7Fy+jvK5l62k1IiRhgq3BqvyxsGpcRiYVsik6JhDflr4NwuluohTHRgNvdj38Si 5mFYBHWH4qTJwB6j56IeldFcHhathjBQfoPmJJioTFrWmpd5rIzMf5I2GoUMT+H6tNXwXxOra6BmFD ZdM0yd/sVsTdUdSxsachoBzbrgmPtwk4vl7z8IE0G2LAWSh6xkKSVjoVBypZdqnOOkTme2MYotGxoi ImPZ7Pv9Q6scFffQJwaGyBmbH/cXII2T3lvZLSr+nzHEPxFLzj+RVn3vJdi14HncieRnjPFs/9deMO go4JYUKHkUkM0qn5j4CCvHytqWpNicubvOZ27WM+3YDzkbv47vJXP7/zdmEmSEBYIPiU2jcXjT3ZUL uhTd39ED9JDUa3X45f4Er/ROKGL4/6zNlt/COxx5+qJoEl4Kw3PLizNaC4avTg2x1dSW6a75b55M0k kPRNhOeU/1Xgz1usdvtu7DsJzoi1qzdutOczBLNrztztGqom8ClQZdA3Pwe8hV775H0zRNTYN4IgtG xmBgZw4AbucsLG+w1ab8oxXU9KpajHNUz/12TEuUah+9CYyT3/qTBz2zURQg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current get_wchan() implementations do their best to avoid problems
when walking a stack given a process in an unknown state, but this is
fragile and unnecessary. It's only useful to report wchan if a process
is actually blocked, so use the new sched_task_get_wchan() instead.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Jann Horn <jannh@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/proc/base.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 1f394095eb88..7853592778b2 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -392,7 +392,8 @@ static int proc_pid_wchan(struct seq_file *m, struct pid_namespace *ns,
 	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
 		goto print0;
 
-	wchan = get_wchan(task);
+	wchan = sched_task_get_wchan(task);
+	/* Must only report symbolized addresses and never raw pointers. */
 	if (wchan && !lookup_symbol_name(wchan, symname)) {
 		seq_puts(m, symname);
 		return 0;
-- 
2.30.2

