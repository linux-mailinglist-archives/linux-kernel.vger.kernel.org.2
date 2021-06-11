Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D183B3A4938
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 21:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhFKTH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 15:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhFKTHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 15:07:37 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30A0C0617AF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 12:05:38 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id a6so32330491ioe.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 12:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MUpvk546xJbxccrzYy1DJAE11qaWwvxoi2eLnJNWB58=;
        b=apDBUttal8iaipbAO980nf/x8zRkf3UuOXodhRiWve6B/zDaSBOQcforlzF8s3aTyP
         kJghjhImXbxvX3Ua1WhXJeSPy+WD6MQVfRhn8oLo5xwvWk6HsW8ePBBjzMvrKKIEygr4
         9PswGSNFdgp6iBWWyJU0NdKjoAD/4wlcySZ7rGKmY8zXhcVSDAU/Gt2ayZ23tQm7Lq2Q
         RJi04+snWlHihb6gQfXHLWnUN2o5288in0DW5h6O2f9ZSfsIhPeRJfAR/7M3D5WN+4DL
         P5i1B8b2E7z9c7aBhDr3w9TwW2Byx6BNvrC+JAeVyPvGvhqUjJcNl3Odc38AdVn1PVms
         3BvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MUpvk546xJbxccrzYy1DJAE11qaWwvxoi2eLnJNWB58=;
        b=A2qcFHElMMtaYN3BhkdwVPLcTrUoBeic/B/TZBL7geyR8SRUjVoSNugYf/atzLzX94
         F6UOKDBWN/ME6MByxme92nLcg7j7JiepSxS/hBtys0LQCTirkMri7ZLBMQ3kc6JdtPov
         cbDCwajLllo8wWuhSMCvC/7IYiBuLwzODE00t7agNE4Q/XASyXc+jmlWYL9b9BmgexCL
         nbQXPZvnTJmO/+lPV6B2X1/qVyj8ZgDwO9R6FdAq9GvpBi/jYDvKrpzeRJihk/0coTD/
         +uDnrVsjwFbMB1WGXkDgJLk8dH2gu7imvQpR07xSFu0L9n5URjOrhzlz7zX0WDAtnolY
         ZMCQ==
X-Gm-Message-State: AOAM5324tNMlY/AnRA4O5Mq4NCw7aW9zuTSWZfjZel/Hobb/t9DBO5ro
        F0Q24I5rlt4ytcNOloqqo7vWQQ==
X-Google-Smtp-Source: ABdhPJyQvSliUi32RR8b6i+pzFCO7ZkiFTgHuMIlmebLf2nnm4j2Bnc6AmiIPpz3FjnTDiyTC2UJrw==
X-Received: by 2002:a05:6602:22ca:: with SMTP id e10mr4202393ioe.57.1623438338290;
        Fri, 11 Jun 2021 12:05:38 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id p9sm3936566ilc.63.2021.06.11.12.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 12:05:37 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     subashab@codeaurora.org, stranche@codeaurora.org,
        davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/8] net: qualcomm: rmnet: simplify rmnet_map_get_csum_field()
Date:   Fri, 11 Jun 2021 14:05:25 -0500
Message-Id: <20210611190529.3085813-5-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210611190529.3085813-1-elder@linaro.org>
References: <20210611190529.3085813-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The checksum fields of the TCP and UDP header structures already
have type __sum16.  We don't support any other protocol headers, so
we can simplify rmnet_map_get_csum_field(), getting rid of the local
variable entirely and just returning the appropriate address.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 .../ethernet/qualcomm/rmnet/rmnet_map_data.c  | 20 +++++--------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
index ca07b87d7ed71..79f1d516b5cca 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
@@ -19,23 +19,13 @@
 static __sum16 *rmnet_map_get_csum_field(unsigned char protocol,
 					 const void *txporthdr)
 {
-	__sum16 *check = NULL;
+	if (protocol == IPPROTO_TCP)
+		return &((struct tcphdr *)txporthdr)->check;
 
-	switch (protocol) {
-	case IPPROTO_TCP:
-		check = &(((struct tcphdr *)txporthdr)->check);
-		break;
+	if (protocol == IPPROTO_UDP)
+		return &((struct udphdr *)txporthdr)->check;
 
-	case IPPROTO_UDP:
-		check = &(((struct udphdr *)txporthdr)->check);
-		break;
-
-	default:
-		check = NULL;
-		break;
-	}
-
-	return check;
+	return NULL;
 }
 
 static int
-- 
2.27.0

