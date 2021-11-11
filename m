Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53AB44DCD6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 22:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbhKKVCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 16:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbhKKVCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 16:02:46 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9B4C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 12:59:56 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id q17so6671365plr.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 12:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xH9gjV2+nQ3ZXVAA9ckgRKISikhIh7VE5b1rKD4RA9g=;
        b=VZief8gcJTmN0bmEvM6HlCarwCctVeWuXDa/Q1OxX+EVMMuR2THVmXorf1kkYqerkT
         FTXoYsmHBoACjvraBff4jM53N13P7vEHzkixEz7AKhRF6hHE6jSHzAl81rv5UoS623LO
         DUwErdudOfmXzSGt9FADOYVPBotlvFn8pDJLfd2DMOi+K6Had75UaZJGcinWoePnqbJ9
         NtDU3O0EASpsnGU81cC4Eoxv8Db2jd+CECuhaG6nnYu5dH87DPLkMqm8ct8gSHXrRyjs
         ebS0kJOrMoQ4f2mzCfe0IbgiMTErg2qKya6UrwiQk0n6ip3ILVAx9AyhDEO8XE0gM2Ol
         BjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xH9gjV2+nQ3ZXVAA9ckgRKISikhIh7VE5b1rKD4RA9g=;
        b=iRlCUqjbmReJWQFxcHvwqgrZfSuSxQVCYSoOKS1embv5wiw24DwEJBCMN9rRY2YmRh
         US7yVXQlGSN5Lp/2j+SxTzVTrHIDyUiOSHYLNdC5uSgStFWTdw2TbGzs1r6P0dJfpGBa
         nRyJSavThwX+Rgs0bSS77JG/7IUvIQYzFwjpzI2pksQWhuAWX6ru19bmGhX8nUeCEGvZ
         SsQwIXkPszoSKkCvFPEzaoMHy0Fg3g1dBP3Teev31/6YCpCEye5Nmn48mFWDc7l/bfFC
         Q5Nkz8MVvF+FY/2uWJq3odhZ339WVSFpgUP3N8F+BHl1Lo4+ycP7G8NMZeOZ2OPsZaso
         td8A==
X-Gm-Message-State: AOAM530IC86znyktIkoj7nsiJAg4krxXnYL/gp3uFPycpqHV/Lepkq24
        eE+muwNtuotoRhDr26lDcZCzNg==
X-Google-Smtp-Source: ABdhPJxJgGDJhD/qRjDkTQlUfFiPDPb7oHTykdnit2GbfWLFhdP0O62YHtRsH2DMJcMjM5zFRpgKJQ==
X-Received: by 2002:a17:902:b907:b0:13f:ccaf:9ed8 with SMTP id bf7-20020a170902b90700b0013fccaf9ed8mr2289398plb.46.1636664396407;
        Thu, 11 Nov 2021 12:59:56 -0800 (PST)
Received: from localhost.localdomain ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id g5sm9134575pjt.15.2021.11.11.12.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 12:59:56 -0800 (PST)
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
To:     jmaloy@redhat.com
Cc:     Tadeusz Struk <tadeusz.struk@linaro.org>,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] tipc: use consistent GFP flags
Date:   Thu, 11 Nov 2021 12:59:16 -0800
Message-Id: <20211111205916.37899-2-tadeusz.struk@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211111205916.37899-1-tadeusz.struk@linaro.org>
References: <20211111205916.37899-1-tadeusz.struk@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some functions, like tipc_crypto_start use inconsisten GFP flags
when allocating memory. The mentioned function use GFP_ATOMIC to
to alloc a crypto instance, and then calls alloc_ordered_workqueue()
which allocates memory with GFP_KERNEL. tipc_aead_init() function
even uses GFP_KERNEL and GFP_ATOMIC interchangeably.
No doc comment specifies what context a function is designed to
work in, but the flags should at least be consistent within a function.

Cc: Jon Maloy <jmaloy@redhat.com>
Cc: Ying Xue <ying.xue@windriver.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Cc: tipc-discussion@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Tadeusz Struk <tadeusz.struk@linaro.org>
---
 net/tipc/crypto.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index 988a343f9fd5..a59c4eece5db 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -524,7 +524,7 @@ static int tipc_aead_init(struct tipc_aead **aead, struct tipc_aead_key *ukey,
 		return -EEXIST;
 
 	/* Allocate a new AEAD */
-	tmp = kzalloc(sizeof(*tmp), GFP_ATOMIC);
+	tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
 	if (unlikely(!tmp))
 		return -ENOMEM;
 
@@ -1475,7 +1475,7 @@ int tipc_crypto_start(struct tipc_crypto **crypto, struct net *net,
 		return -EEXIST;
 
 	/* Allocate crypto */
-	c = kzalloc(sizeof(*c), GFP_ATOMIC);
+	c = kzalloc(sizeof(*c), GFP_KERNEL);
 	if (!c)
 		return -ENOMEM;
 
@@ -1489,7 +1489,7 @@ int tipc_crypto_start(struct tipc_crypto **crypto, struct net *net,
 	}
 
 	/* Allocate statistic structure */
-	c->stats = alloc_percpu_gfp(struct tipc_crypto_stats, GFP_ATOMIC);
+	c->stats = alloc_percpu(struct tipc_crypto_stats);
 	if (!c->stats) {
 		if (c->wq)
 			destroy_workqueue(c->wq);
@@ -2462,7 +2462,7 @@ static void tipc_crypto_work_tx(struct work_struct *work)
 	}
 
 	/* Lets duplicate it first */
-	skey = kmemdup(aead->key, tipc_aead_key_size(aead->key), GFP_ATOMIC);
+	skey = kmemdup(aead->key, tipc_aead_key_size(aead->key), GFP_KERNEL);
 	rcu_read_unlock();
 
 	/* Now, generate new key, initiate & distribute it */
-- 
2.33.1

