Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D730445645D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 21:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbhKRUkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 15:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbhKRUkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 15:40:19 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C0FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 12:37:19 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so6834263pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 12:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UpKEU9gOqfvpEX1zLR0OD1H7EtCWXuiTrgjD+XT34I8=;
        b=R+1m1D6WSDAveSWf8mGH2LJwf3a5tDgWus88PZ10Eh7GwFNALR3iZZ1ojAD4Am6sFF
         gpM0qfFwkKaaqws+PRZjconRDSqpVv2fKcuu+kUZ+bOH2J9Tr/HYNMPupACtfkoA3aze
         w5+cd3vH8G1cfZUXZKrUE1OvAZlI0nd62jBPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UpKEU9gOqfvpEX1zLR0OD1H7EtCWXuiTrgjD+XT34I8=;
        b=2QIy+58d05yPZhEYSWmzsFj/NFlbbxliVHKepbsQvplcg2xgcpaOZavaizU478xIm4
         NmT589sW+Tsfvv9e+dmku1EjysQGdhLtnvyUHFmEC/8lYukD2HMmBeHP2EYG+scfI9uY
         zNi35/dpmrOqUKEqxj/kO9dfRaN5xBftz3UooUVAdwyBOU9zVDXDzr49XvMRBPHDiL5V
         C5ze3LCEG67mZ2LWl6GPv6sE/5NRZgd3s8RX1gDAVhKHh5B9qgzOiScXvXA4pIxVzybq
         8n82onCyBFFLmvU0Sz9j78pjUaQOYvtvJ9R5mMBmKU06enKl4timJi9kGa7HV5qDdnZC
         9/RA==
X-Gm-Message-State: AOAM531y4YKpFpSmMITYCpRoa1Ssnq5yyMn/cGwl7gjzcqCdMe+r5ffe
        jf82vMOZiuJjohT/T7nsJKR+IQ==
X-Google-Smtp-Source: ABdhPJyvr6dOBoCsdCLuznP18VaTSieGKyUbLiWPka5uyvKQ1sTcUsC8Axur06Ov496YBDH/0d3Z1A==
X-Received: by 2002:a17:902:b28a:b0:142:3e17:38d8 with SMTP id u10-20020a170902b28a00b001423e1738d8mr70551412plr.56.1637267838977;
        Thu, 18 Nov 2021 12:37:18 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y125sm392495pgy.84.2021.11.18.12.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 12:37:18 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Philipp Reisner <philipp.reisner@linbit.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] drbd: Use struct_group() to zero algs
Date:   Thu, 18 Nov 2021 12:37:12 -0800
Message-Id: <20211118203712.1288866-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2322; h=from:subject; bh=POb7PrfE8/q5lcxwV1OSdP+6fpGjaVyNi9ZgFcWFgnA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhlrl4OdEVtA0tl6G4Riz1e1Wo3tkR/aeBekUhqX4H EHW6oV+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYZa5eAAKCRCJcvTf3G3AJucnD/ 9i/p4zjPSQUtzrXfJjayE8yTZPj9lEIeSnKn+3HD+helAkDJxMYkOOAnoJHOFuxa1UNAW9a9tVI+Iv FBkhl7jz/TmufVRFgDpiyO2zGT49vUIPvEt5QccmtoAFL3+miUK0dThj8a4JO0jn3acArE2i2iaMVJ 9UG94frM2x1Xkl4xRGWPYEsBeJwahnjILwugNuMJeUgu4uuljeQgFAFk4hIA9dCK438hMCXKipxfz6 wEwp0lTHzskbg901uVzZ0J+gNmQ2d7vAwoTy5s97E6PI592mg1vqomdgb4Cu6tJnIrH7elmcfBiTtI Fu2SeBCOPyUOrdDfjvAqvRLry5bRmgWomKl/56vgXFF8TX/L/GNjZOu7dPLQqGd2hG8tlvwmKX2gtC e9x6vglpJYvG/GegTlicEetqpE0Wu9cWQnkw4Rff4AbSWOsur61x2oiYMpCuqqp2kzzzwfAt8gpJev lRljlKfOTucMbwUNtwm9IAzSXSye6KvVH9QXgv6awbRDRUrqgNMJ6vnazSiTfCt8SkY9v/XNTHzSxt wSZSFrunoycDaOQc9Is5BBGp6kWPdgAAS4KcK9qNwzrEhx4bQVh9tO3AqueROomYRqXhvGUejYf10O 8FgLzk4WntfMhPeDDOJGsvwg3B1wOd19HvdOLApPXuLYUcjeVU2kvom7DKNw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Add a struct_group() for the algs so that memset() can correctly reason
about the size.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/block/drbd/drbd_main.c     | 3 ++-
 drivers/block/drbd/drbd_protocol.h | 6 ++++--
 drivers/block/drbd/drbd_receiver.c | 3 ++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 53ba2dddba6e..feac72e323bd 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -729,7 +729,8 @@ int drbd_send_sync_param(struct drbd_peer_device *peer_device)
 	cmd = apv >= 89 ? P_SYNC_PARAM89 : P_SYNC_PARAM;
 
 	/* initialize verify_alg and csums_alg */
-	memset(p->verify_alg, 0, 2 * SHARED_SECRET_MAX);
+	BUILD_BUG_ON(sizeof(p->algs) != 2 * SHARED_SECRET_MAX);
+	memset(&p->algs, 0, sizeof(p->algs));
 
 	if (get_ldev(peer_device->device)) {
 		dc = rcu_dereference(peer_device->device->ldev->disk_conf);
diff --git a/drivers/block/drbd/drbd_protocol.h b/drivers/block/drbd/drbd_protocol.h
index dea59c92ecc1..a882b65ab5d2 100644
--- a/drivers/block/drbd/drbd_protocol.h
+++ b/drivers/block/drbd/drbd_protocol.h
@@ -283,8 +283,10 @@ struct p_rs_param_89 {
 
 struct p_rs_param_95 {
 	u32 resync_rate;
-	char verify_alg[SHARED_SECRET_MAX];
-	char csums_alg[SHARED_SECRET_MAX];
+	struct_group(algs,
+		char verify_alg[SHARED_SECRET_MAX];
+		char csums_alg[SHARED_SECRET_MAX];
+	);
 	u32 c_plan_ahead;
 	u32 c_delay_target;
 	u32 c_fill_target;
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 1f740e42e457..6df2539e215b 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3921,7 +3921,8 @@ static int receive_SyncParam(struct drbd_connection *connection, struct packet_i
 
 	/* initialize verify_alg and csums_alg */
 	p = pi->data;
-	memset(p->verify_alg, 0, 2 * SHARED_SECRET_MAX);
+	BUILD_BUG_ON(sizeof(p->algs) != 2 * SHARED_SECRET_MAX);
+	memset(&p->algs, 0, sizeof(p->algs));
 
 	err = drbd_recv_all(peer_device->connection, p, header_size);
 	if (err)
-- 
2.30.2

