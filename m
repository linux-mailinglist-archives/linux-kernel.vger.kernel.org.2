Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062A23F6F52
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 08:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238814AbhHYGTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 02:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238555AbhHYGTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 02:19:32 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6553C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 23:18:46 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id e3so12770145qth.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 23:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RH75lEDDDtdHGfWOp59zoFXd45mrorIx2kgTRLpTbwg=;
        b=nAWtbhlDL430J8B/4kvp6bShpNDqABPji9ShP0MSsnf2wbEeYbQm0b9oUmHiuJrflY
         WRXf5+AIR3HPESJliYuDLkcCXsGB0Oy5ZvLRl+dHxR74uq41vbJawQta7/PVvhUyozGg
         eCdC89A0G47F0lytna7M9271XA6BzdlpGZds0wGY0Slehz9FlnPGRbMa4lU9OJIKDNsL
         1tC8gZLd/s6HxbLSbpLoGZ/Kqq+CbZJAEAXQJn6hZj+p6EyKJVxTVRKQVbxJ19aXlshI
         qd1iOrWmyBl+a2TwikYOf2iRM+EdSG4sCq1xukfYmb3j3dvBkNaQ7yzx+lupWkjThZr/
         6aSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RH75lEDDDtdHGfWOp59zoFXd45mrorIx2kgTRLpTbwg=;
        b=Zw1Mfe7zz8eVufCjXCA9D+ZplZwb/aeYTOoOfKDI6MwJp6PCn2Dwanlpq2BSpsifEl
         mTAzv8GYYs3CVyCd5gCg1MUszKMIBETpZ9pWxyck1ZHhaSlLJkppIQhUBTmanPVhVhOL
         GRadFlAZEsLlOwkqc5CmtYE/v6rlUcu4pyTwQGqNomyaJ7Dt11mxa3FS9mFUkB4XZlUf
         dKQFBGey/axlhFlTzFh0C5LGNzD0uoODw7oWl1zwE80BWuk4R82/L14bys3HeXgUw0sw
         FWxWGXjzMPcnkdusRH4V1OLjsTvr7myb4ZSPt8B/P21X1BJNlz/8P8Cwn0rW6SdbCmd9
         AuTQ==
X-Gm-Message-State: AOAM5301prQfjVOkGZBuWd9BsnwOlDc3TMPbQOCIoIyIhuLiWri4U/dD
        MJPeetfKad7Y2cYtHLNBkFwd0Imil3g=
X-Google-Smtp-Source: ABdhPJwmzEBWa+zihl+e6mx3w/fX3IuWaWfFvusi0wr+NcVEl+S9m9UKjOKLNiP63XIdPDzTf1L2/g==
X-Received: by 2002:ac8:4e96:: with SMTP id 22mr31192996qtp.242.1629872326050;
        Tue, 24 Aug 2021 23:18:46 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id k9sm9532555qtj.12.2021.08.24.23.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 23:18:45 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <deng.changcheng@zte.com.cn>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Wang Wensheng <wangwensheng4@huawei.com>,
        Qinglang Miao <miaoqinglang@huawei.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drivers:smu: fix warning comparing pointer to 0
Date:   Tue, 24 Aug 2021 23:18:38 -0700
Message-Id: <20210825061838.69746-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jing Yangyang <jing.yangyang@zte.com.cn>

Fix the following coccicheck warning:
./drivers/macintosh/smu.c:1089: 11-12:
 WARNING comparing pointer to 0, suggest !E
./drivers/macintosh/smu.c:1256:11-12:
WARNING comparing pointer to 0

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jing Yangyang <jing.yangyang@zte.com.cn>
---
 drivers/macintosh/smu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
index 94fb63a..6cd0fef 100644
--- a/drivers/macintosh/smu.c
+++ b/drivers/macintosh/smu.c
@@ -1086,7 +1086,7 @@ static int smu_open(struct inode *inode, struct file *file)
 	unsigned long flags;
 
 	pp = kzalloc(sizeof(struct smu_private), GFP_KERNEL);
-	if (pp == 0)
+	if (!pp)
 		return -ENOMEM;
 	spin_lock_init(&pp->lock);
 	pp->mode = smu_file_commands;
@@ -1253,7 +1253,7 @@ static __poll_t smu_fpoll(struct file *file, poll_table *wait)
 	__poll_t mask = 0;
 	unsigned long flags;
 
-	if (pp == 0)
+	if (!pp)
 		return 0;
 
 	if (pp->mode == smu_file_commands) {
@@ -1276,7 +1276,7 @@ static int smu_release(struct inode *inode, struct file *file)
 	unsigned long flags;
 	unsigned int busy;
 
-	if (pp == 0)
+	if (!pp)
 		return 0;
 
 	file->private_data = NULL;
-- 
1.8.3.1


