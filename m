Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139C3437034
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 04:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhJVCxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 22:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbhJVCxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 22:53:17 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA708C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 19:51:00 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gn3so1934512pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 19:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ITT8WFbH6v/m4W4m1F5isVWCJcMpG8vLUaedk3t279E=;
        b=Re+5vIOuhdqcWgD+3/wdcNJkyaWZ69J2ILnTCXWiwT4BoOez2wt7v2Tfic0k3KbY+F
         BN3o/3BALTwOGLcT8lCOYP1rUQW53T7XnEG+EnSCxb+LD7smlE5xdP8hJakiLI/VNjpO
         /aS/3c5/FdrBfVdTBD/M/Cb02TFIK4T3zsBY2rTPR8CyH9VinIpyEm5FHi3jvTw8UvLU
         uaQ90uytLM68Z2+q9MYA1ZwviSyiTg2jfmWF0CSlowplp1+qp8ehgbjJZ/446hN1oCY9
         +sAPuhmo9Tv5/zob1k16v+XHS/WQNAdh2DEwWWqTMmLQsMUxjxJTe1dKB7tMD2VOfXz5
         /fXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ITT8WFbH6v/m4W4m1F5isVWCJcMpG8vLUaedk3t279E=;
        b=mSjQdVkCC4yKdd/6hO7LI5c8ACp2kdl72Xt+b7/djhkXFKggwXqopWo65aOVKL2Cu6
         7vI0KC2fWawluTMpVFM/a4wkF0Xk0Lmo3Fvm56km0KQiCBL28AXXFkZzECV/Nv9Iv81N
         uQvTRnpoUwPPH4I1G1yzYHDuP2HnQ0xmWCzVnCAetrZoIhEwQPJ2dKGmddsOTmRwdq3v
         dXBWREx46R7ofIzIkovv/OjPtqmQKRKg8/yjNLDjDyN79xoAEqARMm/BJ4TbddkL0IxL
         9x5yjJaWcbJcWmnpni7i6Duo3Um/U06UfrssliCtdJEUZnAKbxSgyouLX4TT05sO+09v
         s6Vw==
X-Gm-Message-State: AOAM533wQFL3WnPciwRfxAlUiAY9QeafhNUd4lGmOMo+7B5cHNTfajVD
        kGu+JInSQJ1tCGgZ5+0/PX3b9wqCrXg=
X-Google-Smtp-Source: ABdhPJxNvTaC6qILH2cCRf6i1cALOiHbtEPaweQu+wCi7WyE86XMIMSyEjbfuvJyIIuWAlDipIlNEQ==
X-Received: by 2002:a17:90b:3809:: with SMTP id mq9mr11264359pjb.7.1634871059929;
        Thu, 21 Oct 2021 19:50:59 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id bp19sm6997961pjb.46.2021.10.21.19.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 19:50:59 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.guojin@zte.com.cn
To:     jk@ozlabs.org
Cc:     joel@jms.id.au, alistair@popple.id.au, eajames@linux.ibm.com,
        linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Ye Guojin <ye.guojin@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] fsi: master: replace snprintf in show functions with sysfs_emit
Date:   Fri, 22 Oct 2021 02:50:52 +0000
Message-Id: <20211022025052.1063370-1-ye.guojin@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Guojin <ye.guojin@zte.com.cn>

coccicheck complains about the use of snprintf() in sysfs show
functions:
WARNING  use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
---
 drivers/fsi/fsi-master-ast-cf.c | 3 +--
 drivers/fsi/fsi-master-gpio.c   | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
index 24292acdbaf8..1725785128f9 100644
--- a/drivers/fsi/fsi-master-ast-cf.c
+++ b/drivers/fsi/fsi-master-ast-cf.c
@@ -1083,8 +1083,7 @@ static ssize_t external_mode_show(struct device *dev,
 {
 	struct fsi_master_acf *master = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE - 1, "%u\n",
-			master->external_mode ? 1 : 0);
+	return sysfs_emit(buf, "%u\n", master->external_mode ? 1 : 0);
 }
 
 static ssize_t external_mode_store(struct device *dev,
diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index 7d5f29b4b595..865acb37e0ee 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -718,8 +718,7 @@ static ssize_t external_mode_show(struct device *dev,
 {
 	struct fsi_master_gpio *master = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE - 1, "%u\n",
-			master->external_mode ? 1 : 0);
+	return sysfs_emit(buf, "%u\n", master->external_mode ? 1 : 0);
 }
 
 static ssize_t external_mode_store(struct device *dev,
-- 
2.25.1

