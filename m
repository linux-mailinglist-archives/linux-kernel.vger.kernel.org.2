Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F48338AC7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 11:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbhCLK4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 05:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbhCLKzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 05:55:55 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18041C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:55:44 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id e10so4536077wro.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ra48pT9rfpiijjx5/hqCOGUdkD2PZ1gvyu+SmCrCjD4=;
        b=Oef+d4eRWh1sAVKLw1nPhinRKqgeXpg/GUlyB4VHS87v+IMN6D8TxBv1W64GWviozS
         VoIEf+MupbFHJFaNddKk1CGZfBGSchQpUsXuDWcwTdiJ3KRmd4gPqtLIfy29kogPBbgu
         hjixb95FG3Isvqs/BhAjWAm923IKAVF7M+mi70eSov3NFrbG0RwI7Zel83ln6I/2VszK
         f7bWbDXZZBKhU59Pnpnh3itv2dH5MchQgMwyJak0kjvEA4xUvZFS1C+XdkiXRX6tMfQw
         Ii+IuYZ74uJiRQHgtzit+eUkURgREtTUka8Xb1LXjJgnvNFtYqGapKdTzKmhD68hj71T
         pCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ra48pT9rfpiijjx5/hqCOGUdkD2PZ1gvyu+SmCrCjD4=;
        b=GeM0+zWDLUOS0zgK8yXALt3pSxOkUBig30nSoZoJgX4W4ahwa3OQ+Cct67ZEO14/Mk
         WfzO9rc8EnpgASBV0Pd7HbMSl10BWROhsMDeY8Y2GKP2jYGf4flZzG58mGxC09ra8PNB
         0tjuc7yetUt3x142A/my1QUNDkIV4yd58AGrK9ibIDaDJfz7N+wYqUVXV734ut/VJAME
         zBe3vTgcpQT0YRX4fJ9ZKd95Zrq2y3G3R2LPgBTjRrSNoMOrr9KeDPp6aHWfghvDcr56
         C29mp1tCFIqR6G05UtRAOXM7U0UmKt2s8OxGzi0yovuctqLDezmvUcIDhAUyAyLF4T6h
         F+SQ==
X-Gm-Message-State: AOAM532S92BVQKhsvUPj3zXGAVUg61UQop4ZUv4oTwHyJMikKbfYegWj
        5tHP+0v+Dfiu6tYvND71VkgPZQ==
X-Google-Smtp-Source: ABdhPJzMqLsZXEdmvMOw6kJWzAJoj5oRWwuNxlJb3z7y5Zj3s4CdlgUTzAeRsuGUgysF2Ux1mr9chQ==
X-Received: by 2002:adf:d1ce:: with SMTP id b14mr13284518wrd.126.1615546542769;
        Fri, 12 Mar 2021 02:55:42 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id q15sm7264962wrr.58.2021.03.12.02.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 02:55:42 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org
Subject: [PATCH 07/11] block: drbd: drbd_nl: Make conversion to 'enum drbd_ret_code' explicit
Date:   Fri, 12 Mar 2021 10:55:26 +0000
Message-Id: <20210312105530.2219008-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312105530.2219008-1-lee.jones@linaro.org>
References: <20210312105530.2219008-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 from drivers/block/drbd/drbd_nl.c:24:
 drivers/block/drbd/drbd_nl.c: In function ‘drbd_adm_set_role’:
 drivers/block/drbd/drbd_nl.c:793:11: warning: implicit conversion from ‘enum drbd_state_rv’ to ‘enum drbd_ret_code’ [-Wenum-conversion]
 drivers/block/drbd/drbd_nl.c:795:11: warning: implicit conversion from ‘enum drbd_state_rv’ to ‘enum drbd_ret_code’ [-Wenum-conversion]
 drivers/block/drbd/drbd_nl.c: In function ‘drbd_adm_attach’:
 drivers/block/drbd/drbd_nl.c:1965:10: warning: implicit conversion from ‘enum drbd_state_rv’ to ‘enum drbd_ret_code’ [-Wenum-conversion]
 drivers/block/drbd/drbd_nl.c: In function ‘drbd_adm_connect’:
 drivers/block/drbd/drbd_nl.c:2690:10: warning: implicit conversion from ‘enum drbd_state_rv’ to ‘enum drbd_ret_code’ [-Wenum-conversion]
 drivers/block/drbd/drbd_nl.c: In function ‘drbd_adm_disconnect’:
 drivers/block/drbd/drbd_nl.c:2803:11: warning: implicit conversion from ‘enum drbd_state_rv’ to ‘enum drbd_ret_code’ [-Wenum-conversion]

Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com
Cc: linux-block@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/block/drbd/drbd_nl.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index bf7de4c7b96c1..31902304ddac7 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -790,9 +790,11 @@ int drbd_adm_set_role(struct sk_buff *skb, struct genl_info *info)
 	mutex_lock(&adm_ctx.resource->adm_mutex);
 
 	if (info->genlhdr->cmd == DRBD_ADM_PRIMARY)
-		retcode = drbd_set_role(adm_ctx.device, R_PRIMARY, parms.assume_uptodate);
+		retcode = (enum drbd_ret_code)drbd_set_role(adm_ctx.device,
+						R_PRIMARY, parms.assume_uptodate);
 	else
-		retcode = drbd_set_role(adm_ctx.device, R_SECONDARY, 0);
+		retcode = (enum drbd_ret_code)drbd_set_role(adm_ctx.device,
+						R_SECONDARY, 0);
 
 	mutex_unlock(&adm_ctx.resource->adm_mutex);
 	genl_lock();
@@ -1962,7 +1964,7 @@ int drbd_adm_attach(struct sk_buff *skb, struct genl_info *info)
 	drbd_flush_workqueue(&connection->sender_work);
 
 	rv = _drbd_request_state(device, NS(disk, D_ATTACHING), CS_VERBOSE);
-	retcode = rv;  /* FIXME: Type mismatch. */
+	retcode = (enum drbd_ret_code)rv;
 	drbd_resume_io(device);
 	if (rv < SS_SUCCESS)
 		goto fail;
@@ -2687,7 +2689,8 @@ int drbd_adm_connect(struct sk_buff *skb, struct genl_info *info)
 	}
 	rcu_read_unlock();
 
-	retcode = conn_request_state(connection, NS(conn, C_UNCONNECTED), CS_VERBOSE);
+	retcode = (enum drbd_ret_code)conn_request_state(connection,
+					NS(conn, C_UNCONNECTED), CS_VERBOSE);
 
 	conn_reconfig_done(connection);
 	mutex_unlock(&adm_ctx.resource->adm_mutex);
@@ -2800,7 +2803,7 @@ int drbd_adm_disconnect(struct sk_buff *skb, struct genl_info *info)
 	mutex_lock(&adm_ctx.resource->adm_mutex);
 	rv = conn_try_disconnect(connection, parms.force_disconnect);
 	if (rv < SS_SUCCESS)
-		retcode = rv;  /* FIXME: Type mismatch. */
+		retcode = (enum drbd_ret_code)rv;
 	else
 		retcode = NO_ERROR;
 	mutex_unlock(&adm_ctx.resource->adm_mutex);
-- 
2.27.0

