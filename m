Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0AB74150FB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237425AbhIVUHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237360AbhIVUHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:07:05 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33ECC061764
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:34 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t18so10517880wrb.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7erf4Xe2Z/5TXAdP5f9t8imcOXiXIj2gdThseCHGVaA=;
        b=cwKyrjhCyWyThKL33FY8pG3w2AmObFQeSCxrIqfIffj/OOrzIEkLOxtgQ3XpXDMpDD
         W6jCLY8ruBNgC+0GN7ujspMGB5Km6dCo0l/De9EVgnCQOdigYTj2tIOH/wAIJo2jsjSE
         oETEbY3Rs9fTktBi68KTN62rmtIoNbZo75OY+RdEez5aqaRLDSTWcXfI7fGpgowGgmEt
         7YsKLvxxnkO5uIiZn8Sz5FRPGy9a2TJFfmaXOT/kLu3sBtCHP4KyNj/PWOxEWMy9yUhE
         tbUp6DU0Rvl3aWbSIYZGSm66Uqm/Z5UfmBs+iJM3ci/T/jG/Cb8FuhckT+tiF/O8a0Uh
         jygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7erf4Xe2Z/5TXAdP5f9t8imcOXiXIj2gdThseCHGVaA=;
        b=mLkALuwxTcRkP7lKWuslJ8Bd4L+VUrKLurXjwNdTIiczaZ8rR0JnjcknsISYjMz7uZ
         QeTSanjTTq8uE9JC0+B/4qEEg5PgKAKpx9a7vPjyOwG3ldDLFSFKJIFCdMUiDWlcqc4e
         2k1B2sM2lQPPTL7fPGU9cyXUvNKrVMhEkOIOuvCFcKQtxvH9yBbY+/w9xWsX4OYMhMHp
         jpYlXx8P8x3fdPfudK0/aP71de5z92bdT3u9YhLa5DiLdjujndDGOSCS6+Ax51bBZwz7
         lS0CNrz9qVhK+kFEq4CvQaF6jlFXjrHKjX2ERZLLqdc0kW5xbO0Qb7xV2iCeXDlpaviL
         bZ9g==
X-Gm-Message-State: AOAM533ND3nikb0ggYfWb9uupDmSZiTljUWYGQMqg9L8QsHknyTYG5Ta
        +qLncyscHzQzl8Z22hWaPmY=
X-Google-Smtp-Source: ABdhPJz2ASQcX6Ff6SoaCbSp/gB/5Ngfu5igmoAWcznlGo0ow0l61ErN74VhASVx0t8cRmqJ7l3b6Q==
X-Received: by 2002:a7b:cc8d:: with SMTP id p13mr884216wma.10.1632341133507;
        Wed, 22 Sep 2021 13:05:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:05:32 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 09/47] staging: r8188eu: remove _rtw_dequeue_network()
Date:   Wed, 22 Sep 2021 22:03:42 +0200
Message-Id: <20210922200420.9693-10-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function _rtw_dequeue_network() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c    | 19 -------------------
 drivers/staging/r8188eu/include/rtw_mlme.h |  2 --
 2 files changed, 21 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 179bddc1e54c..eae3f8a55a58 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -142,25 +142,6 @@ int	_rtw_enqueue_network(struct __queue *queue, struct wlan_network *pnetwork)
 	return _SUCCESS;
 }
 
-struct	wlan_network *_rtw_dequeue_network(struct __queue *queue)
-{
-	struct wlan_network *pnetwork;
-
-	spin_lock_bh(&queue->lock);
-
-	if (list_empty(&queue->queue)) {
-		pnetwork = NULL;
-	} else {
-		pnetwork = container_of((&queue->queue)->next, struct wlan_network, list);
-
-		list_del_init(&pnetwork->list);
-	}
-
-	spin_unlock_bh(&queue->lock);
-
-	return pnetwork;
-}
-
 struct	wlan_network *_rtw_alloc_network(struct	mlme_priv *pmlmepriv)/* _queue *free_queue) */
 {
 	struct	wlan_network	*pnetwork;
diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
index 3e583748df74..fcd700c79af7 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme.h
@@ -586,8 +586,6 @@ void _rtw_free_mlme_priv(struct mlme_priv *pmlmepriv);
 
 int _rtw_enqueue_network(struct __queue *queue, struct wlan_network *pnetwork);
 
-struct wlan_network *_rtw_dequeue_network(struct __queue *queue);
-
  struct wlan_network *_rtw_alloc_network(struct mlme_priv *pmlmepriv);
 
 void _rtw_free_network(struct mlme_priv *pmlmepriv,
-- 
2.33.0

