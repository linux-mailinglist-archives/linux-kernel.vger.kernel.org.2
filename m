Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A1F444BEB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 01:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbhKDAVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 20:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbhKDAVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 20:21:36 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AC0C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 17:18:59 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id f8so4274508plo.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 17:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=33qNhl5KUuwhXlJviUqYHbcux36lTfw33Yai7JaEVzU=;
        b=hf2vpQU/6ADgAnCnk0/7qNm52+Lan3qr1ci0BA4nCmTuFgpP82yVkyi4tzH34s84J3
         Niyxn2MkFM6HXH874HklxPFUMKzyDYzieU3SyzczG7lJGzuT3xiwidelpQFQdlDujSKB
         p78gZzd/xq3wLoGhhne6tmmsrZHs06AA5W59FqGCPrDMkRHrxAo22O+MRMX0g4Ff5gtp
         XA14uH42/AON+DElCPSsLYjEVGM9oDL1j0mCOb30wEeSRat2loDj31nS8w2umJ75GtDm
         P0t9L4eLp03zJDwM0EkVh0EOp3VmR/dtkM5MjpaalCg8q0/kaJjpg+ZHrGmnXdPguHQM
         +t3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=33qNhl5KUuwhXlJviUqYHbcux36lTfw33Yai7JaEVzU=;
        b=GaoyVjohr8VZmfWdIKGoW8LQnv1EEqXxvSNjsP0cmFRs6nXQytx2UMUXTqjyHfnjdW
         eb8IOotgfPwmnw1rSGI5krtepmC5JajuwuHD280gDBKdTLOYYoIpGNwbPYna81G473LN
         oxYwhmc2U6YoAe799FZzpj4GTjy6Zpmh4+usQODfWaTYH7p3fnYmKagSHDaCBKFCdVi4
         2EcU7MpdsiSaCcAc9OGh/aY1WlJBYj2/i1nPFUzhXQ0w4X3NoagWLpCb+0QmXBaKrKdM
         v5Y3Gs28z4FiWARIQip5LZ3kGoj+ykC+NVMpJLtYx7+P4+CYtf0CQyFEsntVYKO/ql8M
         Dnqw==
X-Gm-Message-State: AOAM533Wce3z08tTxkxpO1QYHOGuNRe46S8CZ2jzAEJYhQIAAxsyuARA
        THY+cKeIwhcERFZ5Ccvrqx8=
X-Google-Smtp-Source: ABdhPJz+Go6ezTNJOTFJ9PSZdobRjI4XGjD//pKbkFIv2MQdc6Z3f4/N51DdH/Ra5LD0XPttq/MgEw==
X-Received: by 2002:a17:902:ab50:b0:13f:4c70:9322 with SMTP id ij16-20020a170902ab5000b0013f4c709322mr41299673plb.89.1635985139129;
        Wed, 03 Nov 2021 17:18:59 -0700 (PDT)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id nh21sm2734284pjb.30.2021.11.03.17.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 17:18:58 -0700 (PDT)
From:   davidcomponentone@gmail.com
X-Google-Original-From: yang.guang5@zte.com.cn
To:     peterz@infradead.org
Cc:     davidcomponentone@gmail.com, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] locking/ww-mutex: use swap() to make code cleaner
Date:   Thu,  4 Nov 2021 08:18:46 +0800
Message-Id: <20211104001847.694982-1-yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
Reported-by: Zeal Robot <zealci@zte.com.cn>
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
2.30.2

