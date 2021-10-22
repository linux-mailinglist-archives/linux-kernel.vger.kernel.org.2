Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423CF4380D1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 01:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhJWAAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 20:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbhJWAAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 20:00:45 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CD9C061348
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 16:58:27 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id o184so7434216iof.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 16:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=squareup.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HDS7qDHjHOaWOFZwMpIbasUAJZB8YLyW4e2fBz6JHaQ=;
        b=YSzqSWMAubbhHAheo3UGfbnP6ZHGIfBUiuOKXaagQp/0NGVfyeIXSPBYRLy8DyfSB9
         n73i7f6FAdN6aqM2VmycTp6+BhhlQwB+xM5c4cKl98FYC2nyc0qsf70FYQNVzlMxDF+N
         /MPSzk9Mv3VAPlAZOgQ2SIH56zImPqoLfgvfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HDS7qDHjHOaWOFZwMpIbasUAJZB8YLyW4e2fBz6JHaQ=;
        b=En0LZuM8Kft82XpctskDD0qIH15oTflTDOPqe+vDw2PhKdtSJfLOtrEcO7PtSh4Du5
         kt7sTdgxormti+skljOGkcPlURfvRGgEHOwSeJs+QTuayiuHYAzZTPsTQrXbcNxYdsr/
         S83p2Ll7nEL4HpKgq2ypFzL2S8jY2modwwg+En9HhoIFlsgas4Dfc2JTz4wAeYz2OZcX
         8XK2dRQUhGVUHUO//V4o2iCwiSLZaiMHkYvR3tFxh4bYlYQ6pAYaZm505TwRgxw7dZIw
         voWNb4HQLDe5qHoNpl6aVjydh/8qRF1o/UFhOprwIXU1SIHSXTVzlcpZpUe8p+vXDqbB
         pwrA==
X-Gm-Message-State: AOAM532nEzCYByb+kbKQ6QXb1Kuzl8+WeeeKiBGNbDpzmQNR2JxpfwBD
        OuEsE55LLlemcZvoWZAhkZd2yA==
X-Google-Smtp-Source: ABdhPJwlcG4U/fvs7GLKW6fhpUoafn85mCdtXLVaK6ElzfOmSbH/J7pgw/ag96lYFBXBh4KjZPu1lg==
X-Received: by 2002:a6b:ce03:: with SMTP id p3mr1672879iob.163.1634947106513;
        Fri, 22 Oct 2021 16:58:26 -0700 (PDT)
Received: from localhost ([2600:6c50:4d00:cd01::382])
        by smtp.gmail.com with ESMTPSA id o1sm4993337ilj.41.2021.10.22.16.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 16:58:25 -0700 (PDT)
From:   Benjamin Li <benl@squareup.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, Benjamin Li <benl@squareup.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] wcn36xx: Switch on Antenna diversity feature bit
Date:   Fri, 22 Oct 2021 16:57:37 -0700
Message-Id: <20211022235738.2970167-2-benl@squareup.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211022235738.2970167-1-benl@squareup.com>
References: <20211022235738.2970167-1-benl@squareup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Switches on Antenna diversity feature bit.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Benjamin Li <benl@squareup.com>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 3979171c92dd..be6442b3c80b 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2394,8 +2394,10 @@ int wcn36xx_smd_feature_caps_exchange(struct wcn36xx *wcn)
 	INIT_HAL_MSG(msg_body, WCN36XX_HAL_FEATURE_CAPS_EXCHANGE_REQ);
 
 	set_feat_caps(msg_body.feat_caps, STA_POWERSAVE);
-	if (wcn->rf_id == RF_IRIS_WCN3680)
+	if (wcn->rf_id == RF_IRIS_WCN3680) {
 		set_feat_caps(msg_body.feat_caps, DOT11AC);
+		set_feat_caps(msg_body.feat_caps, ANTENNA_DIVERSITY_SELECTION);
+	}
 
 	PREPARE_HAL_BUF(wcn->hal_buf, msg_body);
 
-- 
2.25.1

