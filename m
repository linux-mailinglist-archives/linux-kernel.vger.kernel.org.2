Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEBB3F3855
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 05:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbhHUDno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 23:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhHUDnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 23:43:43 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C32C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 20:43:04 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id eh1so6625291qvb.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 20:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6m4yJM+RPlW4VzYVQJtczboQP1huDBgJlzyxLuLVY6I=;
        b=rrKEjudncsljrzy+/lvGllzXr4CXoSjxCW4fHeXqgFNOqC/gnGMxAiRTjslEiD8m1f
         jN2Q30li/26gFREpEN/BPGWN6nq/js8/zvbw8ppT54hEF3Rvsxm1iPLqJwmNrKkVKix5
         HSJAXslEa/ott2MP8L3ayYo9YnOa8y1eFZ2NsBdf25SjyzDcvq5h1IzVghhTCU2BKj3s
         AhrKhCj94VHlRAI7yutQlyRJ/jIY9koWC2IclCm2fBg2rgyGClRq2fb1l+H9Cq7+ReXR
         WyXfDSTq8nLWfU7pCT9OIu8egZmie3L6SspCVC/TKFWQnxsvBR4DfJNRmtUb//FY06AQ
         quGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6m4yJM+RPlW4VzYVQJtczboQP1huDBgJlzyxLuLVY6I=;
        b=HYecZefiPnJsLU61uoNK3N0PVvJuFoMAvAKVFWG6XaNWs1Ln2qOTvkY6wzPYwmoM1/
         0qughUstS7y99w3UkiEpv+TZnRblKm5UXxISzMTfQBPK1CyskQuUf6CucRVlhqsRWLNo
         zrFWl4LzLdq6HiSxBqTx47NO6Vqr/loRv8v5WE1RxE2WlmBsz1FuyatyT8KhGHQ46NU2
         shyRGRoGNBVZwm/7KjXhmV+1xJ9I9DvXKNhDCsyyCYjMsMF8uY9gkhtWN95+Wn63t/tp
         bRRvaDyK4J5OHwvmIfe7y591fiDFkBefPR1xBHcktx/rH+GxP8zk1UGcRHU96gyLikgF
         YH8g==
X-Gm-Message-State: AOAM5322kvaUNmZO1fovCr3JzPJJUjT4WOBR0nUeddkMtPxrVtwq5b+N
        mUxB63BJYJmLSfHFUOL0uUqsi2NwGE8=
X-Google-Smtp-Source: ABdhPJz/z8xi0plCzhGwuzdOUB09HHv/8JHgKVtKpseECV2wmMxFpOxDXYO2ke9qryFefQvvKzEGqA==
X-Received: by 2002:ad4:58a6:: with SMTP id ea6mr4358759qvb.41.1629517383942;
        Fri, 20 Aug 2021 20:43:03 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u22sm4291952qkj.123.2021.08.20.20.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 20:43:03 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <jing.yangyang@zte.com.cn>
To:     Jeremy Kerr <jk@ozlabs.org>
Cc:     Joel Stanley <joel@jms.id.au>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] fsi:(fsi-master-gpio)Convert sysfs sprintf/snprintf family to sysfs_emit
Date:   Fri, 20 Aug 2021 20:42:50 -0700
Message-Id: <20210821034250.27914-1-jing.yangyang@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jing yangyang <jing.yangyang@zte.com.cn>

Fix the following coccicheck warning:
./drivers/fsi/fsi-master-gpio.c:721:8-16:WARNING:use scnprintf or sprintf

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
---
 drivers/fsi/fsi-master-gpio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index 7d5f29b..865acb3 100644
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
1.8.3.1


