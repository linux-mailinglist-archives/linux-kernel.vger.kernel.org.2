Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D501432C39
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 05:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbhJSDZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 23:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhJSDZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 23:25:15 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED13DC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 20:23:03 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id oa4so13653147pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 20:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BVN5xeuqFq0lTVkizM80YhZzkA/69tY6m4YTtcTyQN8=;
        b=nwvWBQkLFZa1BJzfjnwOShW2NglcjTLQHlQ6mQG5SCNHPwh3OrQ4J6NUPrSjqGf9oS
         x6IjwruBTm/IMQqvrvGcFP0DSJhTOvFG1kQBJb0NIq5cci0mPC5dH3C7xhJkXcsF1D6x
         xlz/XKf49OjKs6YmmtMmiBuSnIB/PXoOj7VAc5oRfKF07MqfpGvmIhaHyZfESpp/eeeT
         RpqUji1aVBD/IPpolTCscTc3ls9fvPgp+yqZii0XnvB8b0g3P8pTrm54YQgSimT9gVh8
         Lm1FZG7SwHbQ2JIm/1MyPthZb82BLo0zcgZl+nEHWFkc/Ed9eYqC05gowXq8wFNMZkui
         +jEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BVN5xeuqFq0lTVkizM80YhZzkA/69tY6m4YTtcTyQN8=;
        b=i1BIhRiPn0Z03XjwouoTbmT3vcjA2r9HiZoU2Z+z/raYQvU2plzZiJ6tauIJHn2DQl
         W+0g6O1Wn/4ogtghREQeFdFyDMdo1SiiBTtKihY7jSfOSGsHP+mVOelIadFd5WsU7nYA
         w2gW1E9A1OXuJzQd2PVVD/HQIYk95ewI0gU8PAfByKUvXBj7Fkf6ippN1KF5CEhd3NBM
         vy/SL0myP8PBmurN+2dGr0ehjxQs3l08F37eXTiyX49Dwask7oyviS8Vm7oSntzQPU4H
         PK0dtyEPs4sRW+r9H16lQWzpfbF7QyAB7U8L9vmMrnVeaug4L77OZ4Bc5OQx0k6xezZl
         PSxg==
X-Gm-Message-State: AOAM532fCC9qVf1GF/IfcvewhQGFfM6WbUAk4s7feI8s99SEL1pGVUPm
        xi0V4P2l3p1erVyniDkBS74=
X-Google-Smtp-Source: ABdhPJxeof47oga3uEXuZkZBG/pBIzQgLRngk1yktVpmMCHxKvjBbbuFyhjqubQfA90yUs5Vjv0Yng==
X-Received: by 2002:a17:90a:9291:: with SMTP id n17mr3466221pjo.243.1634613783343;
        Mon, 18 Oct 2021 20:23:03 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id r13sm6686587pgv.21.2021.10.18.20.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 20:23:02 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     mingo@redhat.com
Cc:     will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] locking/ww-mutex: use swap()
Date:   Tue, 19 Oct 2021 03:22:39 +0000
Message-Id: <20211019032239.974296-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Use swap() in order to make code cleaner. Issue found by coccinelle.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 kernel/locking/test-ww_mutex.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 353004155d65..daad819fcd16 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -389,7 +389,7 @@ struct stress {
 static int *get_random_order(int count)
 {
 	int *order;
-	int n, r, tmp;
+	int n, r;
 
 	order = kmalloc_array(count, sizeof(*order), GFP_KERNEL);
 	if (!order)
@@ -401,9 +401,7 @@ static int *get_random_order(int count)
 	for (n = count - 1; n > 1; n--) {
 		r = get_random_int() % (n + 1);
 		if (r != n) {
-			tmp = order[n];
-			order[n] = order[r];
-			order[r] = tmp;
+			swap(order[n], order[r]);
 		}
 	}
 
-- 
2.25.1

