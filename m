Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B749F3FC185
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 05:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239500AbhHaDd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 23:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239419AbhHaDd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 23:33:56 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB12C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 20:33:01 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id y144so18131031qkb.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 20:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F+XY9o2o2BjI8NsCXol5HC0zdB96dwzv/iViiaTxKvA=;
        b=U1SNr70f+gjp0hrXgo0u2eC3+EpKRG9XhWIn3H35PINzBAYwSQY8daRR4ccliS8c3J
         EHhLkL078ne1kUCNAAtnijXvyFsrRJr7d5pl+R/GoWRR+OkWrD6J6hcX/yn6qZ9EVuQW
         +jbm/eofsLobkw170vCgEG/cV3cyIbsat94SA150XkMt2lWWev1Xl3/j3DAOPm+7cSZI
         B4X/7S7V7GFyJ6B3BMYJc4iLHzKHorBwoCAUHJCZ5zhwD8xesYSDirzDuqUDFWE7XcDJ
         /PlD12DMHiCReCEgleyNtNXc510Opme5rRXUYBftcN3TDeGoQYujSHedyawytKRW68NO
         7yQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F+XY9o2o2BjI8NsCXol5HC0zdB96dwzv/iViiaTxKvA=;
        b=teQRcwNKDNh1VzTnQ1dCePFa+dGBHRlaUX9fMhDzIV80JLYW3ehreTJC8Px0BbjU8+
         xndGOgehoakrLejfMC2K18CWniG5nyuYhMNxr3ghzXSrhWIn6+fWmvS01qprxuk1e62i
         tgVJTgYZdnfav8vwBYlKbm/Pc9wqNCn0lzOISw/LdQ8qsk1bG5i1OveYAaLeShR3qm4z
         0j8WPkk5sOGPIMMaTP8pOfN/yRkoufLAgWT4/Gn3BSl93I1DqAw2nMyuVGivkXQP267B
         RC84+cu0hKSIyh1IhWfl+YOL5hek7L7VFEY1zP/H5mBzfHzojZLlycq86XuqA0BlogwN
         4Ejg==
X-Gm-Message-State: AOAM530yqsm4Q243ur+SGjfol/JHyBmwYUMNVBfjcJ0ebhjY4QYBZPIt
        9OH+YicZhpYoy7QPij49gSpe36LoOfkk9w==
X-Google-Smtp-Source: ABdhPJyVt0/HzUg0WTpHmLpyLVm+994nneoifIHlunkE6MoaFDjiP+AjtjDqi9sDjTC92+u73vX9FA==
X-Received: by 2002:a05:620a:1354:: with SMTP id c20mr971205qkl.335.1630380780393;
        Mon, 30 Aug 2021 20:33:00 -0700 (PDT)
Received: from julio.local ([2804:4ec:1200:4f00:fcb8:8bf6:3b5:ca53])
        by smtp.gmail.com with ESMTPSA id u13sm12949530qki.38.2021.08.30.20.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 20:32:59 -0700 (PDT)
From:   Julio Faracco <jcfaracco@gmail.com>
To:     mhiramat@kernel.org
Cc:     rostedt@goodmis.org, mingo@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bootconfig: Fix missing return check of xbc_node_compose_key function
Date:   Tue, 31 Aug 2021 00:32:56 -0300
Message-Id: <20210831033256.5973-1-jcfaracco@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function `xbc_show_list should` handle the keys during the
composition. Even the errors returned by the compose function. Instead
of removing the `ret` variable, it should save the value and show the
exact error. This missing variable is causing a compilation issue also.

Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
---
 tools/bootconfig/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index f45fa992e01d..fd67496a947f 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -111,9 +111,11 @@ static void xbc_show_list(void)
 	char key[XBC_KEYLEN_MAX];
 	struct xbc_node *leaf;
 	const char *val;
+	int ret;
 
 	xbc_for_each_key_value(leaf, val) {
-		if (xbc_node_compose_key(leaf, key, XBC_KEYLEN_MAX) < 0) {
+		ret = xbc_node_compose_key(leaf, key, XBC_KEYLEN_MAX);
+		if (ret < 0) {
 			fprintf(stderr, "Failed to compose key %d\n", ret);
 			break;
 		}
-- 
2.31.1

