Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1E8381F63
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 16:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbhEPO6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 10:58:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40428 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhEPO6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 10:58:54 -0400
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1liID4-0006x8-Cw
        for linux-kernel@vger.kernel.org; Sun, 16 May 2021 14:57:38 +0000
Received: by mail-ed1-f72.google.com with SMTP id d4-20020aa7ce040000b029038d1d0524d0so1647382edv.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 07:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XTCfpt/56FbqDOoQ8sUsaMXNebh06g9CZvsUJW9+jNY=;
        b=ZUZfNd/O66r+Bxl+sAjxicxVdPy0oYV8pDn3Mxcy5gVb6bZDinKEuZRO3wvSanrupQ
         FfPdlqZ22UR12064M7Si7eMbVeoNxKLTbAJoFc3/Xj/gDBCO4ekC7m1KKxsYIQstEZEb
         Iwtc5wdH51X+WsZDmt+4PqJ6WzVCocWh1lbXpCkylmRG+JPbIOPRRVQKhjedXxwdZ/8N
         cxiXJDkQuV0svwaBcOXFQNg29h2ffEwZEqR/DN934277QvapL8Tg1aJQkZkhCXP11Pzh
         D/XWIrCYqaPgNIrVnoxP4squKrTup8DyBL0O0X1rIn9nXbS+a9sFfkPSyDjAJvc7h+E9
         NZcg==
X-Gm-Message-State: AOAM533/LVaOce6qFE1xpwOPJcKoUj+LlfdPdgnfmJSnmBjqWUmLVkVn
        Pga7moAS3X5Q+dNNWPK1crf0FYCwWc4WiHKMh/jNc4CiuXvgY8qefEh4zml3ND/EJMxTH8C95DC
        gGESrCuC9QTGgXEk3+6A42YUmrzCn4d0Do6QsW2j7+g==
X-Received: by 2002:aa7:c781:: with SMTP id n1mr30536212eds.108.1621177058174;
        Sun, 16 May 2021 07:57:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgjPgNxbUF7hm+COhC/ooKGZrl9JgiTHUHstCcL7r40Cj4zYM5f1bEMCKhdjiXTEnIoj121A==
X-Received: by 2002:aa7:c781:: with SMTP id n1mr30536192eds.108.1621177057984;
        Sun, 16 May 2021 07:57:37 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id q26sm7164708ejc.3.2021.05.16.07.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 07:57:37 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     tj@kernel.org, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH] init/Kconfig: Fix BLK_CGROUP help text indentation
Date:   Sun, 16 May 2021 16:57:31 +0200
Message-Id: <20210516145731.61253-1-juergh@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The convention for help text indentation seems to be tab + 2 spaces.
Do that for BLK_CGROUP which currently only uses a single tab.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 init/Kconfig | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 9f1cde503739..5beaa0249071 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -926,22 +926,23 @@ config BLK_CGROUP
 	depends on BLOCK
 	default n
 	help
-	Generic block IO controller cgroup interface. This is the common
-	cgroup interface which should be used by various IO controlling
-	policies.
-
-	Currently, CFQ IO scheduler uses it to recognize task groups and
-	control disk bandwidth allocation (proportional time slice allocation)
-	to such task groups. It is also used by bio throttling logic in
-	block layer to implement upper limit in IO rates on a device.
-
-	This option only enables generic Block IO controller infrastructure.
-	One needs to also enable actual IO controlling logic/policy. For
-	enabling proportional weight division of disk bandwidth in CFQ, set
-	CONFIG_BFQ_GROUP_IOSCHED=y; for enabling throttling policy, set
-	CONFIG_BLK_DEV_THROTTLING=y.
-
-	See Documentation/admin-guide/cgroup-v1/blkio-controller.rst for more information.
+	  Generic block IO controller cgroup interface. This is the common
+	  cgroup interface which should be used by various IO controlling
+	  policies.
+
+	  Currently, CFQ IO scheduler uses it to recognize task groups and
+	  control disk bandwidth allocation (proportional time slice allocation)
+	  to such task groups. It is also used by bio throttling logic in
+	  block layer to implement upper limit in IO rates on a device.
+
+	  This option only enables generic Block IO controller infrastructure.
+	  One needs to also enable actual IO controlling logic/policy. For
+	  enabling proportional weight division of disk bandwidth in CFQ, set
+	  CONFIG_BFQ_GROUP_IOSCHED=y; for enabling throttling policy, set
+	  CONFIG_BLK_DEV_THROTTLING=y.
+
+	  See Documentation/admin-guide/cgroup-v1/blkio-controller.rst for more
+	  information.
 
 config CGROUP_WRITEBACK
 	bool
-- 
2.27.0

