Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8CA3E2709
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 11:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244427AbhHFJRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 05:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244093AbhHFJRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:17:03 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947D2C06179A
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 02:16:47 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m19so5177218wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 02:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8M4d0Uxz/0+0kMFPkk4zFO2m4csYlGTmBy9HzP7nwc4=;
        b=NDNa8CSxRoQ91d6lqFXRz3nSHq0My/Nma95MTVyL/jnxP7OT39/uNT6L1dG9frwSq5
         +f2Uq7dzvOStYq0NvabTdUdKo1fRcEFCXHuTOFyMWZzSUgvAHFAJhQfwUPNjFM7RYqfL
         wINr5PM2rr9TwV490Cx4asjLZipz77JOaZ2+rKgz7leMu1eXxXP2MeuQs3Ryqtko0mNl
         xhWS0YcT5FQ0EExhusaEvK7XWGD7Yc83dn8RS3aw2/oV2wn7nCzlMqvcjb0nGPf2KN+I
         5gys4Qoiv3pa+exlxkBGOzHaZfCDf8L5wwIFtF13JRY/LP3UDr83p51dd0I7fZvw4gAx
         GR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8M4d0Uxz/0+0kMFPkk4zFO2m4csYlGTmBy9HzP7nwc4=;
        b=VbDpGx8K3dCXxJx4qdZjUE5zPLC0D5bibS1iD9yVLhQjY2MpLo9Csp439hG5UReYB8
         iDaqgsKaIYnt5BB5uF+udM6dFXsG6Ah7fMbDCqOTt4RtjcCezHa+NtcqbBKemoK8+Ww/
         jULigeWGTv2MQHFri6vLEvJ2zKjTvd0G6I3jZ9oTLTsZJYeO80+uQd3Z31WFhU8dsAMN
         JVhFK4c/KqHWS8pM4JL5VxrAAW66W8SmR6zxyEkOQytuxVbqq0iM4FyyTJSCoSjoC4Y6
         tlfGnarilRtpP2PpiAeWFo4b/lV/1cEOv8oUOKeCAnIYvpwzBxKqoqOKVQzCLYg1uYsW
         zhyA==
X-Gm-Message-State: AOAM531pmwDHOSqrIymeRnO4Nh+Ni1z6ZIG2JYouresoKmJ/3wySbbIL
        gmzWWKsYdvHl/dYTs5azPTCXdA==
X-Google-Smtp-Source: ABdhPJzK8A9vVE9yxCV0esYXC43bE+RpDh4wjYLlYsLy8S1Wud3U1m77nqrN8wymnCb9Y1NxuCKCNA==
X-Received: by 2002:a05:600c:1906:: with SMTP id j6mr18507085wmq.108.1628241406206;
        Fri, 06 Aug 2021 02:16:46 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id w3sm7811760wmi.44.2021.08.06.02.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 02:16:45 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH 1/4] slimbus: messaging: start transaction ids from 1 instead of zero
Date:   Fri,  6 Aug 2021 10:16:36 +0100
Message-Id: <20210806091639.532-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210806091639.532-1-srinivas.kandagatla@linaro.org>
References: <20210806091639.532-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As tid is unsigned its hard to figure out if the tid is valid or
invalid. So Start the transaction ids from 1 instead of zero
so that we could differentiate between a valid tid and invalid tids

This is useful in cases where controller would add a tid for controller
specific transfers.

Fixes: d3062a210930 ("slimbus: messaging: add slim_alloc/free_txn_tid()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/messaging.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index f2b5d347d227..6097ddc43a35 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -66,7 +66,7 @@ int slim_alloc_txn_tid(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 	int ret = 0;
 
 	spin_lock_irqsave(&ctrl->txn_lock, flags);
-	ret = idr_alloc_cyclic(&ctrl->tid_idr, txn, 0,
+	ret = idr_alloc_cyclic(&ctrl->tid_idr, txn, 1,
 				SLIM_MAX_TIDS, GFP_ATOMIC);
 	if (ret < 0) {
 		spin_unlock_irqrestore(&ctrl->txn_lock, flags);
-- 
2.21.0

