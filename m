Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAB94347B4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 11:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhJTJSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 05:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhJTJSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:18:05 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AED6C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 02:15:52 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id om14so2020615pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 02:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D5vDGEJ62Z4JO00lvuB1As23CBJwvLLqMQytnK/GbMk=;
        b=I1gAJEUhFy6HEpHofSXh5hrUTtfKE4ATSMMvpgiSBOUjAKpHfgQXYNEJ17rPcIJETF
         8jcur3sqnRU3/kfI3gK08Gfdp8lhgRjjrkClv6iwZDooFQz9GtOfO2gtWmslDWCr9gTW
         F2CDB2b7tdHQTYjZ7hBEyJHHaITm0jMpPKzASj/zGfM+yZAOgPbnVt7Md3HmUdY3m4rY
         ttJthOiC5kOwCS0drz5H0jnp+YCDCg5zqUlfzN7oeP0cROi9yXFMUki7dJW6ntj8EmKo
         AOIK65Q0AAXtS4qqKq1TppjKtP+oM9dYZMXf/2IWRcqfBRmtTeXpenKirap63wu/Oo/g
         7/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D5vDGEJ62Z4JO00lvuB1As23CBJwvLLqMQytnK/GbMk=;
        b=Dt2rvWa0b8EOS1R3CxUD6g1UUaL8tDjawkLIPKMEY0Y6TSSRrtXn5TX/qloF3Z99oI
         j8VdEqlAAIt4VexXqyEiEAePUJb+e/eT+XalehYgiAMcfHbkgd6+jOn4vNOh24OcAVXz
         nbZD95YVtU0BYVpQ0vOadqtOR7trG+PM0zZy2fb4rvL0KD3F6smEXh3QyUk6aykaiiwL
         iI1N/DftFaAoNNYayopq9SjOYBXYaKCapYlhnowHlU9KZOVrk5UFpIL6+yp0qvpY5CFH
         JBxPkrgZoq352NNtUY9Ej816H+Za8zf41vOnrpigFYmZtDBmPIdj+kOZ1M6Gp3ec9Tsy
         xe9A==
X-Gm-Message-State: AOAM532a4vHwRq5p6ByyQb56rC4jXSBSjQ8qpcDKhdkq5KtFouu01QmC
        aJqvRzY1TdwqSGds+Xin1B8=
X-Google-Smtp-Source: ABdhPJwR2FUZ3VSIscKOCNN9opoy8logxzG3gwloUyB/Vwzo3IUxfcO0+wPa/lwu7/vZQfirgMIxQw==
X-Received: by 2002:a17:90a:414c:: with SMTP id m12mr6003410pjg.187.1634721351574;
        Wed, 20 Oct 2021 02:15:51 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i11sm1638459pgp.18.2021.10.20.02.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 02:15:51 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     longman@redhat.com
Cc:     mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] locking/test-ww_mutex: use swap()
Date:   Wed, 20 Oct 2021 09:15:45 +0000
Message-Id: <20211020091545.1039063-1-deng.changcheng@zte.com.cn>
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
 kernel/locking/test-ww_mutex.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 353004155d65..fa021b8a9edc 100644
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
@@ -400,11 +400,8 @@ static int *get_random_order(int count)
 
 	for (n = count - 1; n > 1; n--) {
 		r = get_random_int() % (n + 1);
-		if (r != n) {
-			tmp = order[n];
-			order[n] = order[r];
-			order[r] = tmp;
-		}
+		if (r != n)
+			swap(order[n], order[r]);
 	}
 
 	return order;
-- 
2.25.1

