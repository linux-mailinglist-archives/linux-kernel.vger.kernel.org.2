Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12119415122
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237878AbhIVUJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237606AbhIVUI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:08:27 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0699C0613E3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:06:05 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q11so10347757wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9m/+2Un0OBvIknGm4SYolaypNfoGqK/u6kNR2lrNStM=;
        b=PVkkwGySqduFv4hpYoTnrEmd1VJN3t46FsXcdtIUWB2PgZ0La2yZJU1SNepXRS+OG/
         mNLZa3DrT+WpGz8iITakYg0Q7cgsSLmZCCcUbo37G3yUHsiFwes8rHMz7+RqhuDlTbyC
         8DU7PLxlg3vjHxSl91HjALa2tXINCzrHGJjLg2t9KBM0LX2XgPXmWGTHen2hii/zqjcP
         3F1BvDztrnCK3uXHMez4S+swPw0H3g24XagHvqtBa4AI4ESypfcXmnvoZys9Lor4rEFA
         +Pgua+OOLMPaYdClI2kwuKasho+TdQxOrlJoPZXJepPasKn/4nDyClkBjCoaagMSj48A
         CTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9m/+2Un0OBvIknGm4SYolaypNfoGqK/u6kNR2lrNStM=;
        b=hLoUld+TEAFnnpU4lq/EIO1FlGeCrCugdvmecP6HQKziw0Nc/xRq8/egONrPxGgkw1
         QQq8Iupff47g15P77BFXLmsvVLjHwtPZTFEB89k3BMxLit/5Irokee4D33yoFZSretSA
         JnjCZ5UEHJkQUnO8guZTKaocc+kGt2Bt0nLi1tVG8PGNVZ3JG02I8Voj/9liFtktZy/H
         +uWYn2FKvisOVhPpazi847/ZMJ5hKpSJSOiqpQ2ZG+KTPzKg8T4WZQ4veigJmNSuRDtB
         GoVseIVi7FHkFtEF/woeD3mPXkkRlLad7P0Enr/JsoKJu/psnTon0t+LHPaBE3pWe062
         iGkA==
X-Gm-Message-State: AOAM533V0qPWMjYflJbwlVmwxxJsXI1K6zDSIH32d6ectPX17oNtT+nU
        6v2UY43so01qlBTH1SifAFQ=
X-Google-Smtp-Source: ABdhPJwps2hEh7ZbEJcwOdalt5L3+RMWUDc1Fpsw3pcaCcEsVx0QHrRwrAP2ibAmLSKvL/f3ys+8eg==
X-Received: by 2002:a05:600c:3506:: with SMTP id h6mr882602wmq.62.1632341164289;
        Wed, 22 Sep 2021 13:06:04 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:06:03 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 45/47] staging: r8188eu: remove rtw_init_recvframe()
Date:   Wed, 22 Sep 2021 22:04:18 +0200
Message-Id: <20210922200420.9693-46-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_init_recvframe() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c    | 8 --------
 drivers/staging/r8188eu/include/rtw_recv.h | 2 --
 2 files changed, 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 3f0c4d9d239d..5ac63bd6dd8e 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -147,14 +147,6 @@ struct recv_frame *rtw_alloc_recvframe(struct __queue *pfree_recv_queue)
 	return precvframe;
 }
 
-void rtw_init_recvframe(struct recv_frame *precvframe, struct recv_priv *precvpriv)
-{
-	/* Perry: This can be removed */
-	INIT_LIST_HEAD(&precvframe->list);
-
-	precvframe->len = 0;
-}
-
 int rtw_free_recvframe(struct recv_frame *precvframe, struct __queue *pfree_recv_queue)
 {
 	struct adapter *padapter;
diff --git a/drivers/staging/r8188eu/include/rtw_recv.h b/drivers/staging/r8188eu/include/rtw_recv.h
index d35a9276350f..0b1fc752b0c1 100644
--- a/drivers/staging/r8188eu/include/rtw_recv.h
+++ b/drivers/staging/r8188eu/include/rtw_recv.h
@@ -274,8 +274,6 @@ struct recv_frame {
 
 struct recv_frame *_rtw_alloc_recvframe(struct __queue *pfree_recv_queue);
 struct recv_frame *rtw_alloc_recvframe(struct __queue *pfree_recv_queue);
-void rtw_init_recvframe(struct recv_frame *precvframe,
-			struct recv_priv *precvpriv);
 int  rtw_free_recvframe(struct recv_frame *precvframe,
 			struct __queue *pfree_recv_queue);
 #define rtw_dequeue_recvframe(queue) rtw_alloc_recvframe(queue)
-- 
2.33.0

