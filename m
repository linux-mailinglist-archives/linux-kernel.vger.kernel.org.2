Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE2C32CF99
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 10:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237571AbhCDJZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 04:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237560AbhCDJYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 04:24:55 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65CFC061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 01:24:14 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id v13so17386891edw.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 01:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JebE8TY928/TYrhiI1PZtztecVetWhEGTVhpa+X2Das=;
        b=k41QvMldGbj46kYV8i5S8N5KLPY7fSnL8qTdMCSMYo3PCr4n/C1v24bEm2bFzvausk
         VJedmjAnuUJLgb/7cDqo6CKpy76JykVtOEhO5q1FQyxNpxxDgBanNBiaGBvCuvdWi+xt
         COs5ogUqlZryy4BGekg+bCyJ/aY0Jpv7otJkXDXzLTugZrCxsRnnvJhh1O+nvQpPm413
         7vImEo3DUc6EoJ7Faddlpck7UdUPLDmZ/n3oyIBjjv/DqS66zxJbbmcr3ANmnVgeaFm3
         uIcd9TcydDaR/zYh0ifCSfO0VrocldPHtHjSmF29+ZMK9DV4M1arhF3yO7YJUFgq2wrv
         Ajmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JebE8TY928/TYrhiI1PZtztecVetWhEGTVhpa+X2Das=;
        b=aV0cHnSH52Id3QQsw2O0SP1ceG4qItVU/6F7m38juyxY0c5hAan1Gq7g8mSzQow9m7
         yHuBFzt+VxoT62I7iGf3OZogIuVyDx37Uv9lFPkVtOdsFTtDIgzMy53BMZ0pqssChcks
         gMUNqG4UT5oRlm1PpNskbGi/Hg9xafYXCmYyYv5lla6Bkv+2aOFhAHkjFc9wM6M0VK8q
         AJI6N/STyIQGqbYMX1hYZrv80iQxcUZKwwv0FLfJeiUg6Dc/PuDwNYXogrui5UkjvM/r
         2fZzQLDmkW7t0t7dGAiXlDWewXT8vJ0Hnt+W4y0gnKSzAX4qFhnLsHJTJfeuPJhPpUAO
         VMhQ==
X-Gm-Message-State: AOAM530TVoXp50LnLn0sMOyvNjR0xadGGUW7m5WV1nfYej4AuMUaLm45
        Qvl9wBApduXi7TIOp7m+hrxDGEraMJNB8w==
X-Google-Smtp-Source: ABdhPJyWCqQcQKYdHuJu9mkxP34suqvDhdjCF4yryRfZMFGWXTzZcVOnohFdsJ53UnhFd8M2O5FzaA==
X-Received: by 2002:a05:6402:50ce:: with SMTP id h14mr2975039edb.279.1614849853435;
        Thu, 04 Mar 2021 01:24:13 -0800 (PST)
Received: from localhost.localdomain ([95.87.199.88])
        by smtp.gmail.com with ESMTPSA id d5sm23758032edu.12.2021.03.04.01.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 01:24:13 -0800 (PST)
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [PATCH] tracing: Remove duplicate declaration from trace.h
Date:   Thu,  4 Mar 2021 11:23:48 +0200
Message-Id: <20210304092348.208033-1-y.karadz@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A declaration of function "int trace_empty(struct trace_iterator *iter)"
shows up twice in the header file kernel/trace/trace.h

Signed-off-by: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
---
 kernel/trace/trace.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index dec13ff66077..a6446c03cfbc 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -605,7 +605,6 @@ void trace_graph_function(struct trace_array *tr,
 void trace_latency_header(struct seq_file *m);
 void trace_default_header(struct seq_file *m);
 void print_trace_header(struct seq_file *m, struct trace_iterator *iter);
-int trace_empty(struct trace_iterator *iter);
 
 void trace_graph_return(struct ftrace_graph_ret *trace);
 int trace_graph_entry(struct ftrace_graph_ent *trace);
-- 
2.25.1

