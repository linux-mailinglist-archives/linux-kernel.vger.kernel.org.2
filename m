Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4584E44BA53
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 03:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhKJCdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 21:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhKJCdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 21:33:42 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43223C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 18:30:56 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id t21so1748954plr.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 18:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q8lqcfseykKATmhHCWq2pArMBCPPmzVWy08PgtrSdsI=;
        b=aimbETNZFP1SpyShjP2S/ek7l5wrG2X3WwRsHJoz3EJpSYIQh0CL8X5rp8GsWJ+rAP
         ixex/QaTImzriyJ2h6V58iiRNKOuxmHRb8daYvh8THiLEvhjA13yv5UOj7fBZ0RlDON7
         iffAgbQyRaBJX8WYCcuVJeGnpYjIg1vwGG6CYa9BsWmxMZDAWp6IWysnZFncbJw9PEJZ
         nL7Um8hE0ebos3dbHRA7LEtsT6GPqDKpkuE6EWVQanaKpYuQey7Gdxh5BQESnytr6JwR
         dnJhy39yba1v5xxEt9n0wJEEopeHw9reg6XWZD2gN+7aYmJlSGLAVLO7II/PZQBfgnwr
         sU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q8lqcfseykKATmhHCWq2pArMBCPPmzVWy08PgtrSdsI=;
        b=ytAQ09TFtQo/Es0p+IojXJCzrSDwjJ4MUwM882g/cQb13800hl438mOXGtLhuLOL6q
         djqhzq4vhZMdXioK2YN/x7WP4UAv2ZaXFoS4WrWBglnfy7VXkgVXqZhwCfBthedYAyW7
         ro+J6p6UEgginq95hwqb5blnbZsS5QNXK/xxsHKtq/vYWs7Q2ZyyI8NrByhnz4FcU1UH
         RSQw3LFzGmWbScGHPrW+sAHGfDl93WKC/O2Hie0iWMaGaIWULG98kzsXgMJOHQPIlzEi
         oYCYoTvjCrvaojhFqAKP4DO8ZD9VUcqxDH1XQaK2sWspEF1Rbq78CK8uxSBx2ct0FNGF
         YDZg==
X-Gm-Message-State: AOAM533XxHw/mPskicqUKT5B+le2AQkLnHX/wjsYcJPK3FZZQB6lvlZQ
        fYXFo49MPH0EpBHl+mqbu8RG1cobfb8=
X-Google-Smtp-Source: ABdhPJyCKhtqaaSbMJ7luEwYSeVxxIJJhnmohGR53u1QLRcfhpTRvR5e5eEE+2GjVRPkt7/jfouk+A==
X-Received: by 2002:a17:90a:be0c:: with SMTP id a12mr12738589pjs.204.1636511455658;
        Tue, 09 Nov 2021 18:30:55 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id fs21sm3743033pjb.1.2021.11.09.18.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 18:30:55 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: yao.jing2@zte.com.cn
To:     TheSven73@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jing Yao <yao.jing2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] staging: fieldbus: Replace snprintf in show functions with  sysfs_emit
Date:   Wed, 10 Nov 2021 02:30:48 +0000
Message-Id: <20211110023048.135535-1-yao.jing2@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jing Yao <yao.jing2@zte.com.cn>

coccicheck complains about the use of snprintf() in sysfs show
functions:
WARNING use scnprintf or sprintf

Use sysfs_emit instead of scnprintf, snprintf or sprintf makes more
sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jing Yao <yao.jing2@zte.com.cn>
---
 drivers/staging/fieldbus/dev_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fieldbus/dev_core.c b/drivers/staging/fieldbus/dev_core.c
index 5aab734606ea..01862fe8e4cc 100644
--- a/drivers/staging/fieldbus/dev_core.c
+++ b/drivers/staging/fieldbus/dev_core.c
@@ -70,7 +70,7 @@ static ssize_t card_name_show(struct device *dev, struct device_attribute *attr,
 	 * card_name was provided by child driver, could potentially be long.
 	 * protect against buffer overrun.
 	 */
-	return snprintf(buf, PAGE_SIZE, "%s\n", fb->card_name);
+	return sysfs_emit(buf, "%s\n", fb->card_name);
 }
 static DEVICE_ATTR_RO(card_name);
 
-- 
2.25.1

