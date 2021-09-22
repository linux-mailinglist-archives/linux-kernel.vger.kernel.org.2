Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A333415120
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237763AbhIVUJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237576AbhIVUIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:08:25 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AE4C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:06:03 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id g16so10447077wrb.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zz583mKg39OMIjdW9MlMH1eFwgfjWbPSSiAOX79z9to=;
        b=hqQzyCX7ixuRy74O2dhW8c5h1jhCEmapquy5SMTOJXtOXfSEtZdZizNp2DoVbnmZFx
         JiD0drwF02TBqjU7Gk0ShVMAdpqbjZs6ckUsTjzW1whjW0ofmO2Lz1jL1g17zD9LAaIZ
         cfB6SPLAvrw9tt7qvediuyBHAPDdRr+NDKde17krXiPKdiQto83eiR931xMRkVQEDTU4
         mLBCLo0+4GX2mrNlF6m9ADx6XtISXLFCwFsYDPbCvE3eJaVjV9lPdXc8ZRgjmkiVShGB
         XrQVOXm482c9foJuJpOv9/g7fjpiTbIHLdMymZDTn0HdotcnNS1Fge7JPeGCQ5JHxxZ5
         hy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zz583mKg39OMIjdW9MlMH1eFwgfjWbPSSiAOX79z9to=;
        b=jOg8MVnyotv50XI+NVwQLJDcse9+s/+QfkQwNbrcGEvO5nN5hog4+cqdsMeu81u+tp
         nTqm2Z1SVBX2vJBSqRPfwgBGyn/55oacbzxF0tmUH0mF6ztSpDzG+FXyPMT6GE50xLNs
         L9VVfxxE/JuH0NKtMUK6iNfQDR5kzrTpe8/m75ESlwJxpTGc2bp79INGhKExPYxXoOi0
         VlolLQFzUrGrAFfCKc4ZrUa29rDff8M1LsblbwxLhhk9UJhpptjpKr5TW135FkDfgq8n
         vLEHsrYBfwzZw5pPokDr0MayUt2scFa66iskqEq08BT/2MMSJhK8ObO5iVD9CX9q8tRL
         9/oA==
X-Gm-Message-State: AOAM531SbbSpsx5z3Y2RgjyHxMEvB0+laQmWb8bPKdk8GgQuswSVEBd/
        O/Plz+2JoOGhQnfD/IO4dDc=
X-Google-Smtp-Source: ABdhPJxSjNwDMhpmNxUWYUqqwWF9aDaeyueBsImgtxltXrqRx9E3ndg9dv8OkcqZ9iJRPMTWYEIAhg==
X-Received: by 2002:a7b:cd90:: with SMTP id y16mr12448722wmj.84.1632341162665;
        Wed, 22 Sep 2021 13:06:02 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:06:02 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 43/47] staging: r8188eu: remove rtw_enqueue_recvbuf()
Date:   Wed, 22 Sep 2021 22:04:16 +0200
Message-Id: <20210922200420.9693-44-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_enqueue_recvbuf() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c    | 13 -------------
 drivers/staging/r8188eu/include/rtw_recv.h |  1 -
 2 files changed, 14 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index ad60967943c2..1e05437a1a8d 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -269,19 +269,6 @@ int rtw_enqueue_recvbuf_to_head(struct recv_buf *precvbuf, struct __queue *queue
 	return _SUCCESS;
 }
 
-int rtw_enqueue_recvbuf(struct recv_buf *precvbuf, struct __queue *queue)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&queue->lock, flags);
-
-	list_del_init(&precvbuf->list);
-
-	list_add_tail(&precvbuf->list, get_list_head(queue));
-	spin_unlock_irqrestore(&queue->lock, flags);
-	return _SUCCESS;
-}
-
 static int recvframe_chkmic(struct adapter *adapter,  struct recv_frame *precvframe)
 {
 	int	i, res = _SUCCESS;
diff --git a/drivers/staging/r8188eu/include/rtw_recv.h b/drivers/staging/r8188eu/include/rtw_recv.h
index 67042c7a781c..065942e816c6 100644
--- a/drivers/staging/r8188eu/include/rtw_recv.h
+++ b/drivers/staging/r8188eu/include/rtw_recv.h
@@ -285,7 +285,6 @@ void rtw_free_recvframe_queue(struct __queue *pframequeue,
 			      struct __queue *pfree_recv_queue);
 u32 rtw_free_uc_swdec_pending_queue(struct adapter *adapter);
 int rtw_enqueue_recvbuf_to_head(struct recv_buf *buf, struct __queue *queue);
-int rtw_enqueue_recvbuf(struct recv_buf *precvbuf, struct __queue *queue);
 
 void rtw_reordering_ctrl_timeout_handler(void *pcontext);
 
-- 
2.33.0

