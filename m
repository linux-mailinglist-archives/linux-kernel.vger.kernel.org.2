Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEB63D88CB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 09:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbhG1H1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 03:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbhG1H1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 03:27:31 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844A2C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 00:27:30 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso2932259pjo.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 00:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YVR9sbQLb33YOGzYRf2bTmTHvepvD/Q+vwxljUmG580=;
        b=AzGozxQcXtMP6nGNYlOkyz2xleTj/6ZP01vllEseoHzXDNx5oFdpQHeS94rQP3HjhX
         TfFEQO5ylNuGiT4G0HAvGj8D9Q944JRT3sdR3XKSq3cE68vGCuSsFTRGjbz01LS+ol3Y
         3OwVhT0FQxc1FpnmOl9tZGfCzZM3c32EwI7zrXMoCfOD6TD1BaVSXnSP3KQzRnifbR36
         xxG/8UKa85qblQtWQhKHakVP1db/a+cPyrTpL+JFl/+cqBXngDnwzQPNID9A8tLYLT/y
         6YwQdsmfUBWD0qR45RY9fKZWKJ7pgBZU3PytRMNjLF6GZs6MW7oBQ5CfcHbh4rmtfIS0
         umWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YVR9sbQLb33YOGzYRf2bTmTHvepvD/Q+vwxljUmG580=;
        b=eJ06bz+mc+MU96KP9iLfDWQUTEMCtGh4ar4Udq7ovNkWSMt54scxec2ZmNYYqMbn0h
         +KmEzxz6UHSrXffz2JOPHDiQYGqUrz4QCwgu3FQOvvU5K9s+oe7LdaQlOfAiF8NDglfu
         Hf5KCzY+pLQq0P+5hAVPScTnwwNwakbBjJkD+D03lWv+GwdRuizK3KMyQLMgz/Up0FTx
         vKeqe3OrbBRXLVfD2PGtPlsp/eNfmbq+cTvXJi7XNJLjh7gdpGulf5Rqq9RB5mUcd44L
         6pQGXyGCI+gDVoG7JYf3jlShpBxqEKa13C7I92wC/5fJ831fcnVOFh/jDKIQd7hTY7cp
         worA==
X-Gm-Message-State: AOAM5304YK2fHoXbZxRXIhUj0SqWQARcI3FZxNB82ahbxVuMZD/k/CXg
        Ko41NgvXGJnH+umHL7beTE87i0zE+WTtoA==
X-Google-Smtp-Source: ABdhPJyuPq0JFcSW8rSajJ356qD3eYgmicw56o5wQsqeDSl4K1FXVrNn2kEa8m9BgvTg79jqb1+hBg==
X-Received: by 2002:a17:902:e28a:b029:12c:13e9:1166 with SMTP id o10-20020a170902e28ab029012c13e91166mr13740837plc.47.1627457250124;
        Wed, 28 Jul 2021 00:27:30 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id v31sm6389910pgl.49.2021.07.28.00.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 00:27:29 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.xiaokai@zte.com.cn
To:     christian.brauner@ubuntu.com, peterz@infradead.org,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: [PATCH] set_user: add capability check when rlimit(RLIMIT_NPROC) exceeds
Date:   Wed, 28 Jul 2021 00:26:29 -0700
Message-Id: <20210728072629.530435-1-ran.xiaokai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

in copy_process(): non root users but with capability CAP_SYS_RESOURCE
or CAP_SYS_ADMIN will clean PF_NPROC_EXCEEDED flag even
rlimit(RLIMIT_NPROC) exceeds. Add the same capability check logic here.

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 kernel/sys.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index ef1a78f5d71c..72c7639e3c98 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -480,7 +480,8 @@ static int set_user(struct cred *new)
 	 * failure to the execve() stage.
 	 */
 	if (is_ucounts_overlimit(new->ucounts, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC)) &&
-			new_user != INIT_USER)
+			new_user != INIT_USER &&
+			!capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
 		current->flags |= PF_NPROC_EXCEEDED;
 	else
 		current->flags &= ~PF_NPROC_EXCEEDED;
-- 
2.25.1

