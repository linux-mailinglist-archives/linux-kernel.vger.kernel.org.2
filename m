Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5F244E6C9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 13:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbhKLMxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 07:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhKLMxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 07:53:53 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4E8C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 04:51:03 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id u17so8282411plg.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 04:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=onB2LJWOsSh+B7IgRdNdlYoprjy5uOJkOVOxx3cJvt4=;
        b=K9PfN0U75gPsG2NmizoDgC7ZE+rYv5hNXMPm6Vy7ASpJr8b/2xXtui5mXjONKTlEKU
         X7hi0luGoiFNDmXYzziRLJ4hSNdT6vTDv+pynM8n0PWEvmffGnw+lLQACYOp51d/LNmZ
         KfvORXSlYHrTOHuTMeLn63iJVKiB5Jce8X5tWD/eyZemzENDGqjG/1XQG4b6Q5CgDUMF
         5+h1aHBeLzXEN8iDIeedYH4KqhHjtQLFjg/4D1CyE3Wtk/3mERNAs1K4cvEn0OJNxe9M
         chY+VM2f0FZjwcD/js6IVIVmlFfaNrZ+yVbc2r8W0jgbn59cSwGOkrRHVPyCIG2spe80
         KA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=onB2LJWOsSh+B7IgRdNdlYoprjy5uOJkOVOxx3cJvt4=;
        b=wV0YYsR8VF0zCeY+pcqSnc0GkaN7GAuGFd3XWxAqmEBYFLcL3YmPPruzDUyhNiH323
         qPahWIA2Tu9LqxQXSZlLDZFcnYXHRIYxMAdw/7JxZGCse46z4VNr2VAEwb82tehRUvjr
         PMsY7aaEDFfoniUEa/YZ9EY1gazMek1+vGG56hwJwt2yrvch6R+0Tfp5YLTATfIYOCnY
         tFxpMDmzHrIAS7dJULNxyiJa2bpbaprjkBvL1PhWVxAiWBa0Bh80HHe4W8Z9Pi2oAKtg
         4wvY0gBKis9S1ZDHlyt2NzyuQso2HpUwaw5yQUEwYVHKpyqXwNkdFyJS1abWB9huQ1Y9
         SRQQ==
X-Gm-Message-State: AOAM533ZpFuo8xpfxxcQb9DzdbQ01zPyyFRLwUEndWvhBmFZ9X5vJgm+
        PCEelDf1irhBqIximR1eNAl2mXvehNw=
X-Google-Smtp-Source: ABdhPJwd8T3YwTg5bdMJXrBuSSrxWuDd5CMyHIWpmyPfD6p67Vhagtkz2MbsCaGl443T87Pq8zNW6A==
X-Received: by 2002:a17:90b:1c06:: with SMTP id oc6mr35850673pjb.126.1636721460282;
        Fri, 12 Nov 2021 04:51:00 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i6sm6305342pfu.173.2021.11.12.04.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 04:50:59 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     linux-kernel@vger.kernel.org
Cc:     deng.changcheng@zte.com.cn, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drivers/virt: remove unneeded variable
Date:   Fri, 12 Nov 2021 12:50:53 +0000
Message-Id: <20211112125053.10265-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Fix the following coccicheck review:
./drivers/virt/fsl_hypervisor.c: 690: 5-8: Unneeded variable

Remove unneeded variable used to store return value.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/virt/fsl_hypervisor.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/virt/fsl_hypervisor.c b/drivers/virt/fsl_hypervisor.c
index 46ee0a0998b6..e49bec8bc8a4 100644
--- a/drivers/virt/fsl_hypervisor.c
+++ b/drivers/virt/fsl_hypervisor.c
@@ -687,15 +687,13 @@ static int fsl_hv_close(struct inode *inode, struct file *filp)
 	struct doorbell_queue *dbq = filp->private_data;
 	unsigned long flags;
 
-	int ret = 0;
-
 	spin_lock_irqsave(&db_list_lock, flags);
 	list_del(&dbq->list);
 	spin_unlock_irqrestore(&db_list_lock, flags);
 
 	kfree(dbq);
 
-	return ret;
+	return 0;
 }
 
 static const struct file_operations fsl_hv_fops = {
-- 
2.25.1

