Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41E541B907
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 23:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242895AbhI1VMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 17:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242856AbhI1VMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 17:12:18 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D847C061745
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:10:38 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d26so626976wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kv0t1Auy1prtbjToeeeh4MgCdkUuYCNU2y4LNr7aX9A=;
        b=SeqbIuHyKgxRvPvdXJ1zqiGuLVpGGgBZrI9s+Qbz0KfaKYN9b7jb2ZAqmLODZcypc7
         vDusEdZVSCCfj6bVm6xBEZUE+d4wjFZGECmzEoJ9KRBujgxOsZhnby9cvuLq7ZGOGMQf
         Xb+nEfSUEjxzKCLiWgWXhEuFxAx+UPz5ajATk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kv0t1Auy1prtbjToeeeh4MgCdkUuYCNU2y4LNr7aX9A=;
        b=qylzjzRyPRpBVfRbAoPkdO9jkd3mJWRXHIwhSaYd6ygnH4+ls39coxHiVAxFiqv5u/
         YB47sTpfo6w6UUn94zvnE3+fEFINsj+wXpQHkHfBUQPU06RqWWX7gAIiKzj3u+OwExKA
         B+o6D/w5rFrXp5WcTsMZtBANVN8VZrlcuZKESKjzzHOPkYPYpr+SnEQfCKMdIFJdp6WT
         Xq1MAf1wh8Zuya/eUR/nhBUTZ139snsyjUhcTm0wY3TbqoWNllAPoPNcZt/KQus6FJFb
         6Mw3f/Yyn4ZF3Hbsy5iUQRTxCN2uxV3EBotcypWyiho6HzKvyLf6d8TBe9Qy/QQr8YJ3
         vuNw==
X-Gm-Message-State: AOAM531Vdh1tJSImCRReNtUNvwTPaU5d67gDou/ZMyK8n1lFZDWL6flV
        kSgRSA0MyATjadsVn+Kagtt+Xlzjbevys/xzxM8=
X-Google-Smtp-Source: ABdhPJzbgjgBYQ2G8RkcX1zCKv4gaflSNamwDXnp2HouVOQ8NbZq5EP74vlLxGaZUJQNJIOI/JnFEA==
X-Received: by 2002:a5d:4310:: with SMTP id h16mr2659763wrq.424.1632863436735;
        Tue, 28 Sep 2021 14:10:36 -0700 (PDT)
Received: from beni.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id n68sm3885773wmn.13.2021.09.28.14.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 14:10:36 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 3/7] media: ipu3-cio2: imgu_fmt: Handle properly try
Date:   Tue, 28 Sep 2021 21:10:29 +0000
Message-Id: <20210928211033.2415162-4-ribalda@chromium.org>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210928211033.2415162-1-ribalda@chromium.org>
References: <20210928211033.2415162-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a try_fmt call, the node noes not need to be enabled.

Fixes v4l2-compliance

fail: v4l2-test-formats.cpp(717): Video Output Multiplanar is valid, but
				  no TRY_FMT was implemented
test VIDIOC_TRY_FMT: FAIL

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/staging/media/ipu3/ipu3-v4l2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c b/drivers/staging/media/ipu3/ipu3-v4l2.c
index fbb9eb2ba99e4..66995c6f15808 100644
--- a/drivers/staging/media/ipu3/ipu3-v4l2.c
+++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
@@ -696,7 +696,7 @@ static int imgu_fmt(struct imgu_device *imgu, unsigned int pipe, int node,
 
 		/* CSS expects some format on OUT queue */
 		if (i != IPU3_CSS_QUEUE_OUT &&
-		    !imgu_pipe->nodes[inode].enabled) {
+		    !imgu_pipe->nodes[inode].enabled && !try) {
 			fmts[i] = NULL;
 			continue;
 		}
-- 
2.33.0.685.g46640cef36-goog

