Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0763B4A21
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 23:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhFYV27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 17:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhFYV24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 17:28:56 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACB7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 14:26:33 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id a11so18495680lfg.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 14:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7t7D/1J/bOKgBQ+E9q4Uy0N2GZHjAbWkoMyygvcYg8Y=;
        b=X7p8RIA2xPal9jCN6NmRKzdl1VHHJFNPhLAFX0APZphiwG/aMwD704fy688xj/3cUm
         ae/VP1vEl4Uxh1Z0R+27u31XVSGL1dSYDyR1vecv2hnLmxHTocNYVUblMBaCZitENkC9
         ODliPZAmuUesicpdUPmRt1FL12g+y7BOVzw7jla1JjeY7BVNJb13oB88mMoeSxRwEWS/
         fhCOm8U5PLn10k7L/CxUE/xBgS+Xol707SQHcj5Fi+cOi6vX3k9jBXHhgTTRnoVtNlQu
         133/sAJkefCob8PomQIq8STX24PxKNAt9XlGUUb36XQvphmsMoKGzyZ0kDEogz6n3JHw
         rQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7t7D/1J/bOKgBQ+E9q4Uy0N2GZHjAbWkoMyygvcYg8Y=;
        b=r4xvAbZ/KwrQu/Wv66GvxmTEfiW1QgtnC01jGPWNOFyT3Xn2Hc7Wp9+MdIrEqw8xo3
         o3ckIY0AM+yuWE9v3ae07cEz++m5le0ivRCwqVxD3EAxoK1tOBSAP80tvI5X/Eau4ZbL
         beW4NNOhgxx8qR9BP5eWrO8K8E3abStiO0pkEm3juWOiVaFnX/21KwY+uqrL0Sa0q7rX
         yWES18+z+45dI5xnDKQX0coRc6+gwRooGHYJUhKxkCH+GCtztzuhCcWNP03ZHSEY2HTZ
         NXmzO+dl8ztEPujbbZPmo64AiUTuS5SIFkL6poEZguL0hU0b/NxXFS3bqfea6j65XyBm
         WKzw==
X-Gm-Message-State: AOAM5315xHh6Ig0tfc8DMdCnW5yBKqFHgloLyleTvoq5F0YswCVUdfsN
        z8do3dO+YS9i1W5Kfl5Ca8ZjgVxnLfr+sw==
X-Google-Smtp-Source: ABdhPJzyJsmvcyRKSkjbbb0IYNhkZj+n4BR7pYe1DCLl6o1t/q+vPZOxQ7EOWGKdCGqRpU/qWKl72A==
X-Received: by 2002:ac2:48b1:: with SMTP id u17mr9549252lfg.646.1624656391311;
        Fri, 25 Jun 2021 14:26:31 -0700 (PDT)
Received: from localhost.localdomain ([94.103.225.155])
        by smtp.gmail.com with ESMTPSA id t30sm605776lfg.289.2021.06.25.14.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 14:26:30 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH] net: ethernet: fix UAF in ltq_etop_init
Date:   Sat, 26 Jun 2021 00:26:28 +0300
Message-Id: <20210625212628.14514-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ltq_etop_init() netdev was used after free_netdev():

err_netdev:
	unregister_netdev(dev);
	free_netdev(dev);
err_hw:
	ltq_etop_hw_exit(dev);
	return err;

It causes use-after-free read/write in ltq_etop_hw_exit().
Fix it by rewriting error handling path in this function. No logic
changes, only small refactoring.

Fixes: ("MIPS: Lantiq: Add ethernet driver")
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/net/ethernet/lantiq_etop.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 2d0c52f7106b..807a671ebcf8 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -553,8 +553,10 @@ ltq_etop_init(struct net_device *dev)
 
 	dev->watchdog_timeo = 10 * HZ;
 	err = ltq_etop_hw_init(dev);
-	if (err)
-		goto err_hw;
+	if (err) {
+		ltq_etop_hw_exit(dev);
+		return err;
+	}
 	ltq_etop_change_mtu(dev, 1500);
 
 	memcpy(&mac, &priv->pldata->mac, sizeof(struct sockaddr));
@@ -580,9 +582,8 @@ ltq_etop_init(struct net_device *dev)
 
 err_netdev:
 	unregister_netdev(dev);
-	free_netdev(dev);
-err_hw:
 	ltq_etop_hw_exit(dev);
+	free_netdev(dev);
 	return err;
 }
 
-- 
2.32.0

