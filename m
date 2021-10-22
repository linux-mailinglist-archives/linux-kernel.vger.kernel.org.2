Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A5043743A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 11:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhJVJFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 05:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbhJVJFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:05:12 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC950C061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 02:02:55 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y7so3040403pfg.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 02:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=msbDcleCepniN71Jbfw+vut9V5dOaKH1ffaAk/GfhN8=;
        b=E1G3WDLtdrx5dbmY+vSfucTmKfMrg5MxQhvbBTKQ6bM4w6mkqg0PG+tuPvVjmK1bKV
         c8XblbLaxCRPdVrGzbnR7lgfNQouMTaCBnht++H7vUh8oCisE6tkA1xjXbiGCGcGxx65
         U9td/htxkQDL6Jn7j1cfMKmJcnjzANmZGmsT6WrQ3xlnU9xS2GqUdVSlIBkmmUAHyZIY
         QSN/tao3ubRqw8A/nbrwpVY80zEyryVq5hLuDDEx5FqKihnw69TxFWbkAi1blAe3IrSd
         wmc8BY2ahPOkzBIYQahhbzp4RkEDYnCQQc8gq9NTVuzMfSwsqweV5NGiHKni4YuXovi8
         i8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=msbDcleCepniN71Jbfw+vut9V5dOaKH1ffaAk/GfhN8=;
        b=uAtYgTUwyeQZo4BVK2zfyZNeiMHlT5m1TZSIUl+3sc06KLkI4wHFfsmBd25INFo0hA
         52Ydm5S0bY9uZYVF/cqoToQeluj/6uW0enqTd+qB5ShwcqD0UlnEjgtCxdbZpEhdjkrM
         IsNOdTrcsX1FRDi1uHr2z5L5qCCPZkVZNLvZdFjWZCQbjgcmW5Pv3YmGrSyPqigJ0MbF
         q5Gi/g4eqvGwTonq74rWvHyzF5kaTiA1H4kD9u4A2z4ZjZ6tAEA+WMUWSgdrp48qYNSw
         1rH5jVQOIbdOLNjcmNdjuvUzSxhklSK+wndV0PLSZTrHHi4idfY4BcVXughm2t4zo+sH
         TqOQ==
X-Gm-Message-State: AOAM532uNWug6+/0ybYidIov/rN8kKOZQW9Smhl3aPHm8WAOzyWfpRfY
        cM9gHTkxKlsptJx+nrkmejk=
X-Google-Smtp-Source: ABdhPJyUZiwUpwKIodA4Cnad8fN4HiPuttYHQzbicyC6mZFiSw9GIk4Sd+qUfVqsuOYQKnZ1xDyRsQ==
X-Received: by 2002:a63:2a88:: with SMTP id q130mr6099149pgq.169.1634893375500;
        Fri, 22 Oct 2021 02:02:55 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e9sm9843411pfv.189.2021.10.22.02.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 02:02:54 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.guojin@zte.com.cn
To:     joe@perches.com
Cc:     alistair@popple.id.au, cgel.zte@gmail.com, eajames@linux.ibm.com,
        jk@ozlabs.org, joel@jms.id.au, linux-fsi@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, ye.guojin@zte.com.cn,
        zealci@zte.com.cn
Subject: [PATCH v2] fsi: master: replace snprintf in show functions with sysfs_emit
Date:   Fri, 22 Oct 2021 09:02:48 +0000
Message-Id: <20211022090248.1065217-1-ye.guojin@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ccb3ab4d533de55260b98c7168bfa4460c5f3fcc.camel@perches.com>
References: <ccb3ab4d533de55260b98c7168bfa4460c5f3fcc.camel@perches.com>
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

Changes since v1:
 - remove unnecessary ?: since external_mode is already bool.

 drivers/fsi/fsi-master-ast-cf.c | 3 +--
 drivers/fsi/fsi-master-gpio.c   | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
index 24292acdbaf8..7f3303854e23 100644
--- a/drivers/fsi/fsi-master-ast-cf.c
+++ b/drivers/fsi/fsi-master-ast-cf.c
@@ -1083,8 +1083,7 @@ static ssize_t external_mode_show(struct device *dev,
 {
 	struct fsi_master_acf *master = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE - 1, "%u\n",
-			master->external_mode ? 1 : 0);
+	return sysfs_emit(buf, "%u\n", master->external_mode);
 }
 
 static ssize_t external_mode_store(struct device *dev,
diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index 7d5f29b4b595..b8538a851675 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -718,8 +718,7 @@ static ssize_t external_mode_show(struct device *dev,
 {
 	struct fsi_master_gpio *master = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE - 1, "%u\n",
-			master->external_mode ? 1 : 0);
+	return sysfs_emit(buf, "%u\n", master->external_mode);
 }
 
 static ssize_t external_mode_store(struct device *dev,
-- 
2.25.1

