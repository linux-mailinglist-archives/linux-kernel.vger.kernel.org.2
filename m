Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69F140F066
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 05:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244008AbhIQDaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 23:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbhIQD3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 23:29:54 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E160C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 20:28:33 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id mv7-20020a17090b198700b0019c843e7233so2593195pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 20:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tu3a1Jctb+y1+7cxgmrLpvSnXHcTL/tz3Dc1kAZAv0Q=;
        b=giZQkmV4Kzeopwo0M5oTuJlcGAU7l4owc5drUG/GlrbB0pmiSt+SmyGfIhroFF6v7F
         cuQO36118jy4rxW3tjXuyx9Pkn8sjC5odSZVModBvy4CqK7JeKy39AbGkILrdLxQu4nX
         G28co+YDLcGWmyw8sAd/ZsBPDhyaaWkysrHGAy+Vw4LWQ9m39Aqebh6jsoNJt0wMvqgl
         YJumhGkX85KMPJawyznLHrDOMBRF9eomtTIBz7oEwcuNh5dUHbfm0QrGzvKOKhrWHu9X
         9eTcbUCCVgwjbtA7B9ypJebQ9E4M5xf5WrP8oCTmIfjGxSU4jCqgMaaoFGDmT51KhT5A
         ozDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tu3a1Jctb+y1+7cxgmrLpvSnXHcTL/tz3Dc1kAZAv0Q=;
        b=1GehWRPTQP0FRhpiwtppzzAh5REJxzCGOzXqvsqVCYyo1ayX0oUBCAeaJUEoMp59CW
         m5EzLPwefEUREPdMmVvzuz+m6WdFc8MsFBFf4HKfiC5/ll1Rov/j4yBoCafjcYBnNTVS
         pWi1Pktd7dLyg7XrnSHw0Wo8xW3vdoJ5gyiMgP+qrw4MZqE2tY1ewQevp7gCT6lVBDNy
         VXFgiAHPemV8Ur6MOUGbAi22EZ9jMzxGUhzr7xLd6cfFoaz3abD7D14jtUI3fkEPyDng
         SCvsJMwzQdIjBDkeKV/X281lby3BqCawRj9xHmDfSy8TRs5HUYi98Md0nX9gVhGKBDCt
         SvFg==
X-Gm-Message-State: AOAM5321Hvqyeu4Wwt/EX75EJK827n+xMNTjotoiK2CBfvH96CoG2K8R
        zgDoWcodBGSG7VwcZf6QqpA=
X-Google-Smtp-Source: ABdhPJz2bEGG6f7nr6dbKWY8Ybdsi/dwfvsT4DDF+mw1vZtbAFvZs4eqXGGsVKY6EdtEooWMFFDJaw==
X-Received: by 2002:a17:90a:cc02:: with SMTP id b2mr9871214pju.160.1631849312742;
        Thu, 16 Sep 2021 20:28:32 -0700 (PDT)
Received: from WRT-WX9.lan ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id n19sm4288047pfa.60.2021.09.16.20.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 20:28:32 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] tools/vm/page-types: remove dependency on opt_file for idle page tracking
Date:   Fri, 17 Sep 2021 11:28:26 +0800
Message-Id: <20210917032826.10669-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Idle page tracking can also be used for process address space, not only
file mappings.

Without this change, using with '-i' option for process address space
encounters below errors reported.

$ sudo ./page-types -p $(pidof bash) -i
mark page idle: Bad file descriptor
mark page idle: Bad file descriptor
mark page idle: Bad file descriptor
mark page idle: Bad file descriptor
mark page idle: Bad file descriptor
mark page idle: Bad file descriptor
....

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/vm/page-types.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/vm/page-types.c b/tools/vm/page-types.c
index 0517c744b04e..f62f10c988db 100644
--- a/tools/vm/page-types.c
+++ b/tools/vm/page-types.c
@@ -1331,7 +1331,7 @@ int main(int argc, char *argv[])
 	if (opt_list && opt_list_mapcnt)
 		kpagecount_fd = checked_open(PROC_KPAGECOUNT, O_RDONLY);
 
-	if (opt_mark_idle && opt_file)
+	if (opt_mark_idle)
 		page_idle_fd = checked_open(SYS_KERNEL_MM_PAGE_IDLE, O_RDWR);
 
 	if (opt_list && opt_pid)
-- 
2.32.0

