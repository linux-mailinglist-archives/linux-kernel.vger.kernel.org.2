Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C3D45A5A2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 15:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238161AbhKWObP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 09:31:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24216 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238149AbhKWObO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:31:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637677685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OkMbDX9GTboIaSHWV4LPSGeMWqDixN9bchoMZuhZ4DI=;
        b=aUNikzzdnUJYLdHQr0BUtMa5MERM58MlXGX1gUUnMciGJVS6pa6PHlV6JF28PwlbobyzBu
        Uvp0qPNEFPxFdTE/qSZT4cYFv00tK/YpvBLZOow/rfrgRt+ssL8j2stRzqpztAIUXdDed8
        l5GzIkecbHvU6n2dMSIOpf/b0DCWvJ8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-f-UXGBYgPFS1J7S7b8-Wfw-1; Tue, 23 Nov 2021 09:28:04 -0500
X-MC-Unique: f-UXGBYgPFS1J7S7b8-Wfw-1
Received: by mail-wm1-f72.google.com with SMTP id m18-20020a05600c3b1200b0033283ea5facso761248wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 06:28:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OkMbDX9GTboIaSHWV4LPSGeMWqDixN9bchoMZuhZ4DI=;
        b=QtMfqaY/wcPjWwgLp0Sv/k6OqXmgHg1JVzafQLZb5S3RYZRekUYkbZbUkoMI3MKUm+
         gTRTfBafur2Qre59uasKtAk8zOLBFuWwbJQOtYG1Q31Q0u8503CdcthsX4egflCYtHh2
         xPSUZg8qCq0gFsQ9CUqXdzKV7nbhPgLf9D8/aMxA/7SVmJj5aa7GTOK5i2oe0snVSeXy
         7s4NxzTtC5+8qIsuaNxyadow04hvNRnP74kOMWDoiuAk80hUsGxobHLIAcd5TUN4HMlm
         mQlTbeIcuKWdHc7ZIQPsxp7zKICgkkJ4GhRMz0YsIH8UaCX2Lza2c3RnQjwKW/KAjoQg
         Hhfw==
X-Gm-Message-State: AOAM5337ELsWRPXbIRXEyhedesajSTyWdbxo11aF7xRNSVsSC0IwYHVv
        vN51NjlkIwQoq3zJdBHqwtrKvkZTfoCJYdZayMKgcFB1PRWCj5iEFmgSGrCf0NpqXRPKZHXFyjf
        HJLJ6fFCzQZS+RseDWCuaHQfN
X-Received: by 2002:a05:600c:378b:: with SMTP id o11mr3644877wmr.157.1637677683196;
        Tue, 23 Nov 2021 06:28:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzsQus4sLThzJcZoOngd706opPmVC9MmRrFgtMwe3zaHvulHBduoYt1l6B3Ux2uK/yowd3E0w==
X-Received: by 2002:a05:600c:378b:: with SMTP id o11mr3644847wmr.157.1637677683048;
        Tue, 23 Nov 2021 06:28:03 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id c11sm2513122wmq.27.2021.11.23.06.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 06:28:02 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] tracing/uprobe: Fix uprobe_perf_open probes iteration
Date:   Tue, 23 Nov 2021 15:28:01 +0100
Message-Id: <20211123142801.182530-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing 'tu' variable initialization in the probes loop,
otherwise the head 'tu' is used instead of added probes.

Fixes: 99c9a923e97a ("tracing/uprobe: Fix double perf_event linking on multiprobe uprobe")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/trace_uprobe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 0a5c0db3137e..f5f0039d31e5 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1313,6 +1313,7 @@ static int uprobe_perf_open(struct trace_event_call *call,
 		return 0;
 
 	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
+		tu = container_of(pos, struct trace_uprobe, tp);
 		err = uprobe_apply(tu->inode, tu->offset, &tu->consumer, true);
 		if (err) {
 			uprobe_perf_close(call, event);
-- 
2.32.0

