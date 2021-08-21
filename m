Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0458D3F385D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 05:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240955AbhHUDsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 23:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhHUDsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 23:48:53 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B234C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 20:48:15 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 22so13032797qkg.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 20:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u7pzcohT7MFojURJ557pfhdoI5wPdCafRY0VOXTA9gw=;
        b=t40m/Si6KToKKsEw62jYKvdYs9FSJBKzbJBdh3HgcbhWobZACZWiqXo6/uUNDU4Qnj
         /Yz1ucIV+IwZYUHKpTRvMlphx5elsFW9kTG4/cgsFkrLXlYtns5sVMxx48OGvxx89o5L
         NbhMVH3aJdY5UBdya+zMaKMTEfnLpiRzOHes+aLngmGmBJkmY8+DnbUTM3Ged5+ijssW
         pPiTgJDZclif+zWJt4Odzpdi4Hs8mxDGefSQ3BOAHdNNmEo+VVKgrHjMMAdqMgB57uFF
         N6F1uvCwSRJoRdTsLi8cbGlgpVenashsupFsMrmavClfEmyQcWy32YN0vK3atzLkebCZ
         w57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u7pzcohT7MFojURJ557pfhdoI5wPdCafRY0VOXTA9gw=;
        b=OWZNIGEMO9wfGtUb2U9btvUUXLDa+80TEJSQF15DWDi65iS9pYwnbc/nEhpOV6Hmxc
         d13grvjCWA/C6RMjZVxy65KGBwhzchgz12+Kp+ERtynWZAVrQxb0aNvbVmsgiBF4lxTW
         VRFMAzkWpNuTHezzHmQ5XgjwmpK436YpOk/UUYRXiH09XXHvgVqv8ge6YzbwxgJska0F
         41198IMqj3ParVfo+UsfSv1cW8H9u1dXrxkqLkO7Ch4Qufa+gC0+TRyr4QTjuV0sl39l
         6ZE7tpIWT6QFg2klCbG+fuNDYtmkOUl/TBAueAB4azC6cRlu6UbGIhdxiqazMRAapYRq
         Ekig==
X-Gm-Message-State: AOAM5315imtGv+7psl/4jUnk3tEJ3SkEcsiL2+9UB5S4wraHBx/fyNxN
        bxut9mTxndfPnu3d0k49Zvs=
X-Google-Smtp-Source: ABdhPJwRkxstOLboCI422ZH6d9nfmjZL2mZkRQGp/GhyfEPN86vsnW+9NO88JRo5YUQPVHXx/gDfsA==
X-Received: by 2002:a05:620a:2008:: with SMTP id c8mr8092411qka.493.1629517693882;
        Fri, 20 Aug 2021 20:48:13 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id l4sm4331121qkd.77.2021.08.20.20.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 20:48:13 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <jing.yangyang@zte.com.cn>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] lib:fault-inject: replace DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE
Date:   Fri, 20 Aug 2021 20:48:08 -0700
Message-Id: <20210821034808.28130-1-jing.yangyang@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jing yangyang <jing.yangyang@zte.com.cn>

Fix the following coccicheck warning:
./lib/fault-inject.c:187:0-23:WARNING:
fops_stacktrace_depth should be defined with DEFINE_DEBUGFS_ATTRIBUTE

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
---
 lib/fault-inject.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/fault-inject.c b/lib/fault-inject.c
index ce12621..689234b 100644
--- a/lib/fault-inject.c
+++ b/lib/fault-inject.c
@@ -166,7 +166,7 @@ static int debugfs_ul_get(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(fops_ul, debugfs_ul_get, debugfs_ul_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_ul, debugfs_ul_get, debugfs_ul_set, "%llu\n");
 
 static void debugfs_create_ul(const char *name, umode_t mode,
 			      struct dentry *parent, unsigned long *value)
@@ -184,7 +184,7 @@ static int debugfs_stacktrace_depth_set(void *data, u64 val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(fops_stacktrace_depth, debugfs_ul_get,
+DEFINE_DEBUGFS_ATTRIBUTE(fops_stacktrace_depth, debugfs_ul_get,
 			debugfs_stacktrace_depth_set, "%llu\n");
 
 static void debugfs_create_stacktrace_depth(const char *name, umode_t mode,
-- 
1.8.3.1


