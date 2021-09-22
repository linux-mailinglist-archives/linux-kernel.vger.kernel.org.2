Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982C641511F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237872AbhIVUJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237588AbhIVUI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:08:26 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD02C0613E2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:06:04 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t7so10283310wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cCFk647b3swc/Nj2dT6rgUNhTuRmjvD9OAWxWGNOt9Y=;
        b=RwrOja/nhadm0rym81isZhB/kSbtRwgCDEG0SbHjaug/dlO9er7X2f8hvdAWFXrywO
         DfM81cYFV+NQ0LB56I+w5vaqFY2fKFVx2TeCOHO5nh8ARtnV25L1Ehr6z//RYQ1tU1D0
         qkr/yR437j8B0R2bZEKYDKEP41pad5Pb0e+qMb+puePQ74pItvC1WzUHBQt1nUbREoeL
         v26tFbtm3+8csC8yY+cPX3y6iSdhPeJi2tCh8TMVZM530JTRaSBPCtt8FYPMGkYybsxg
         yKNBJjCwKRhLKupW+NU97iEIjjcqrxAvJIpJN6ZqsRnj4UVbh5gxwzKTyBQi767PkQxh
         sZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cCFk647b3swc/Nj2dT6rgUNhTuRmjvD9OAWxWGNOt9Y=;
        b=evpX+BtJjcjwb0qc0HjnB8HqujpiGQ38cSAVrHMLaoP5NfePtkxU9ieAnPhUD9YYd4
         fME9D2+sUqM6u0QyTdeIgZD7m0yvCYTJnffq3DJ+k3NU6v4F7uqwXjB7pSXdfMgcV7xh
         cOELOEGGOD9U/aJ9GZxspFmb4XXOp6Y/aH+KTM0d5mkh44nrKqiYo2/w5OJiCObxotSF
         0I8PFOeKWceGAQkvIYW3fRBuWf/qQHw33Ub3E84SFOqdnCRXq4PAC1YoNsaqHMngGnxw
         CHDlBgIhZ+FueQi08OyG2069nAiTzLiVgVxkVpa91QymabsCiakf4JC5/L9CJudyjmRe
         CB8Q==
X-Gm-Message-State: AOAM531ITfzl/WYayeCXV4pkFi5kpQeOQcSyq+mIelI3eI9A4wLyXAa6
        1P52+Zfob2wZ+DkxjUQQEkM=
X-Google-Smtp-Source: ABdhPJzPq8zvpJvZx6yHB043c8nN2ri0M5bbGoHbuwrii09Fgosy5YHGL2I9FppwNVm4UU7YGAopag==
X-Received: by 2002:a1c:a505:: with SMTP id o5mr900504wme.32.1632341163414;
        Wed, 22 Sep 2021 13:06:03 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:06:03 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 44/47] staging: r8188eu: remove rtw_enqueue_recvbuf_to_head()
Date:   Wed, 22 Sep 2021 22:04:17 +0200
Message-Id: <20210922200420.9693-45-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_enqueue_recvbuf_to_head() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c    | 12 ------------
 drivers/staging/r8188eu/include/rtw_recv.h |  1 -
 2 files changed, 13 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 1e05437a1a8d..3f0c4d9d239d 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -257,18 +257,6 @@ u32 rtw_free_uc_swdec_pending_queue(struct adapter *adapter)
 	return cnt;
 }
 
-int rtw_enqueue_recvbuf_to_head(struct recv_buf *precvbuf, struct __queue *queue)
-{
-	spin_lock_bh(&queue->lock);
-
-	list_del_init(&precvbuf->list);
-	list_add(&precvbuf->list, get_list_head(queue));
-
-	spin_unlock_bh(&queue->lock);
-
-	return _SUCCESS;
-}
-
 static int recvframe_chkmic(struct adapter *adapter,  struct recv_frame *precvframe)
 {
 	int	i, res = _SUCCESS;
diff --git a/drivers/staging/r8188eu/include/rtw_recv.h b/drivers/staging/r8188eu/include/rtw_recv.h
index 065942e816c6..d35a9276350f 100644
--- a/drivers/staging/r8188eu/include/rtw_recv.h
+++ b/drivers/staging/r8188eu/include/rtw_recv.h
@@ -284,7 +284,6 @@ int rtw_enqueue_recvframe(struct recv_frame *precvframe, struct __queue *queue);
 void rtw_free_recvframe_queue(struct __queue *pframequeue,
 			      struct __queue *pfree_recv_queue);
 u32 rtw_free_uc_swdec_pending_queue(struct adapter *adapter);
-int rtw_enqueue_recvbuf_to_head(struct recv_buf *buf, struct __queue *queue);
 
 void rtw_reordering_ctrl_timeout_handler(void *pcontext);
 
-- 
2.33.0

