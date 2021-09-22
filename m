Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01BEE41511E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237865AbhIVUJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237516AbhIVUIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:08:24 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C28FC061764
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:06:03 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u15so10388683wru.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GmoAy3e5/CVdHHAV9AKEPsWaIgJY7kKflhBKLoESyAg=;
        b=TJOSMnNrp8BF4LpL8xf/xAkvZXRTjSuxZ3eGR2/dZlUbIgSXKEN7VD1Q4ECtD+Ad7X
         EGexA5NaMDeejmywrt7aUyDBOxHJsXBmxHfBIjve68kSWab9nhVWTqrbHOSZZBgXCEZo
         V+933m9N2pb5j2lYTk8Gg4pe9PrwXNiH0Rk7a6a6xn6TBtSScLRBo1FXyKstFjjgJrGg
         z/tg10idjeo8GzhMPe2xesCqcQpnMa9LflyRwfjXegw5yzHtUYAm1jTYdJsVzNvgmwIN
         R9dRAy2mRk7LgwxqoG1GGLAszZim4sn4Ivi1RG0jbo2I8sOsnz1HPnSStKFapSfTHrAU
         iuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GmoAy3e5/CVdHHAV9AKEPsWaIgJY7kKflhBKLoESyAg=;
        b=kVS331YasQDiE7MQPiAa3oH8v6Ze4fhUXjG9+u+xrrNnKqhA4QOLg9ICnhuh94Pce5
         RTqycL5Bka+faHOTElsqrw/SA7SB745pI61ThG1QN05zXhFxWy9ySz4bfLZ6FAPkQwVV
         Lh3/gRBZ+Yzw1JMoGmpL/tNaBJekt0EEJk2sorzhGDu6fEEOiCXVg29k27eXG1Jvdl9E
         zg42+G9/BqCFEJ9RV4ewDtgQEHwSpjbM30ck5L9g56kAw/UeJSihVZ8jy5yDd2/usDj6
         wr0nm0r647rzzgWFC6M28aEXmZeasUH+UaPuHzFkzTPLtY0cw/8yChm5VTcFKwClhf36
         ejhw==
X-Gm-Message-State: AOAM533Bg+e1uMdHyb/W0rvZl3XJHQn01bvTylRX4YV5YMhojRN4y/fe
        JCYX34mqn2IN1Jm9KJASkgo=
X-Google-Smtp-Source: ABdhPJw+fPNp78azA1VfcX5Bh0lCf1M8c5PqBtk2+bdNDGOFgIJCTE9Y1iadzlI0E/uWlkwqAT4hNw==
X-Received: by 2002:a7b:c453:: with SMTP id l19mr845306wmi.7.1632341161781;
        Wed, 22 Sep 2021 13:06:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:06:01 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 42/47] staging: r8188eu: remove rtw_dequeue_recvbuf()
Date:   Wed, 22 Sep 2021 22:04:15 +0200
Message-Id: <20210922200420.9693-43-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_dequeue_recvbuf() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c    | 25 ----------------------
 drivers/staging/r8188eu/include/rtw_recv.h |  1 -
 2 files changed, 26 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 983505aac213..ad60967943c2 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -282,31 +282,6 @@ int rtw_enqueue_recvbuf(struct recv_buf *precvbuf, struct __queue *queue)
 	return _SUCCESS;
 }
 
-struct recv_buf *rtw_dequeue_recvbuf(struct __queue *queue)
-{
-	struct recv_buf *precvbuf;
-	struct list_head *plist, *phead;
-	unsigned long flags;
-
-	spin_lock_irqsave(&queue->lock, flags);
-
-	if (list_empty(&queue->queue)) {
-		precvbuf = NULL;
-	} else {
-		phead = get_list_head(queue);
-
-		plist = phead->next;
-
-		precvbuf = container_of(plist, struct recv_buf, list);
-
-		list_del_init(&precvbuf->list);
-	}
-
-	spin_unlock_irqrestore(&queue->lock, flags);
-
-	return precvbuf;
-}
-
 static int recvframe_chkmic(struct adapter *adapter,  struct recv_frame *precvframe)
 {
 	int	i, res = _SUCCESS;
diff --git a/drivers/staging/r8188eu/include/rtw_recv.h b/drivers/staging/r8188eu/include/rtw_recv.h
index d1d1ca0e56d6..67042c7a781c 100644
--- a/drivers/staging/r8188eu/include/rtw_recv.h
+++ b/drivers/staging/r8188eu/include/rtw_recv.h
@@ -286,7 +286,6 @@ void rtw_free_recvframe_queue(struct __queue *pframequeue,
 u32 rtw_free_uc_swdec_pending_queue(struct adapter *adapter);
 int rtw_enqueue_recvbuf_to_head(struct recv_buf *buf, struct __queue *queue);
 int rtw_enqueue_recvbuf(struct recv_buf *precvbuf, struct __queue *queue);
-struct recv_buf *rtw_dequeue_recvbuf(struct __queue *queue);
 
 void rtw_reordering_ctrl_timeout_handler(void *pcontext);
 
-- 
2.33.0

