Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778B33496F1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 17:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhCYQiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 12:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbhCYQh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 12:37:56 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08B7C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 09:37:56 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so2955284pjh.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 09:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j1pZAvYAVzsZZHp5KG97j4wvqJJqp/GZGQpxZqyCZkU=;
        b=BsSAhpPMJzxPlpEJmhErAxRen8+OVU/RHJ8REDjIz0DB6TQ/Jkz4O+370avLr5UDVc
         NmBlde+ypDu0ck6udR7USi6swGM/BPzpVgrxE/M+xGPWWvgEviY0DQXUc1LhIpqtc3dw
         mXvxNgkru6tOr5rpSwaT4jpDu/qBaiVg19IuPo/XMfo6moY8qhm0iMO5z4xIie9jwEKc
         2ke76QWEJSDYSQgrAbvPTTW/yyvplDw3sZQAsuobvuuBn6ffYm48fn4vk3bVU/m3v9eb
         dBSqUWKHsZJeSzPA9QMlB+Ip1fZEuEkV0W90AzHadzG1RI/sjz7r89BuixDXYQxZqtJS
         iEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j1pZAvYAVzsZZHp5KG97j4wvqJJqp/GZGQpxZqyCZkU=;
        b=VzDWpBXtKr+2nIyls4GJJzXDMbgyAfWYCkK+c0IOw+vyY1YHBWBXCKG3phAd5gYzxp
         szoEb3kRr+JOIIm7RfeXexKDSZjsYNExFuER+8BJ/gxolbKo6lTBdQrgUdTMQVi2Vy7O
         CUZFMCQIT/dtaNNQe88WEBjGJGUyim7BbrEqGameR3FOq2W+rM3LNKZajE2h37Q+OwvM
         Y5VTi8948AIVH2EtELZk0NV+ZwWKxdctdZMVjnxdWwsDp/xsJqLZUvJYbJCAJXLzFRAI
         25AF+NFDLTO7NzN9b6wRVCXZGux1hPP+eNL66lZH95LKCiOQqdKI8Mto11e2bmTBZQIW
         a6ZQ==
X-Gm-Message-State: AOAM530Y1yugi9F/AWGkRg1fa2xM57xzzVOKD+CQu4fHxr6m5C/DcZhX
        2t8OOm8JaAYLe4JaRqxvcsA=
X-Google-Smtp-Source: ABdhPJwhluULfw4IngVOapNHkaDeImTPjLtclujWSATtfPPty2e9n8r/vn7LjKPPIw3nyeJk1+egLw==
X-Received: by 2002:a17:90a:c981:: with SMTP id w1mr10001536pjt.176.1616690276201;
        Thu, 25 Mar 2021 09:37:56 -0700 (PDT)
Received: from localhost (li1758-18.members.linode.com. [172.104.167.18])
        by smtp.gmail.com with ESMTPSA id t12sm5804940pga.85.2021.03.25.09.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 09:37:55 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] tracing: A minor cleanup for create_system_filter()
Date:   Thu, 25 Mar 2021 16:37:52 +0000
Message-Id: <20210325163752.128407-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first two parameters should be reduced to one, as @tr is simply
@dir->tr.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 kernel/trace/trace_events_filter.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index e6efb5dfec5d..cf7fc61f71f7 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1751,7 +1751,6 @@ int create_event_filter(struct trace_array *tr,
  * and always remembers @filter_str.
  */
 static int create_system_filter(struct trace_subsystem_dir *dir,
-				struct trace_array *tr,
 				char *filter_str, struct event_filter **filterp)
 {
 	struct filter_parse_error *pe = NULL;
@@ -1759,13 +1758,13 @@ static int create_system_filter(struct trace_subsystem_dir *dir,
 
 	err = create_filter_start(filter_str, true, &pe, filterp);
 	if (!err) {
-		err = process_system_preds(dir, tr, pe, filter_str);
+		err = process_system_preds(dir, dir->tr, pe, filter_str);
 		if (!err) {
 			/* System filters just show a default message */
 			kfree((*filterp)->filter_string);
 			(*filterp)->filter_string = NULL;
 		} else {
-			append_filter_err(tr, pe, *filterp);
+			append_filter_err(dir->tr, pe, *filterp);
 		}
 	}
 	create_filter_finish(pe);
@@ -1853,7 +1852,7 @@ int apply_subsystem_event_filter(struct trace_subsystem_dir *dir,
 		goto out_unlock;
 	}
 
-	err = create_system_filter(dir, tr, filter_string, &filter);
+	err = create_system_filter(dir, filter_string, &filter);
 	if (filter) {
 		/*
 		 * No event actually uses the system filter
-- 
2.25.1

