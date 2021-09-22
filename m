Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CFC4150FC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237514AbhIVUHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237377AbhIVUHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:07:06 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4649C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:35 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t18so10517996wrb.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yrZZLrnVOgRrYALPGlkh+83vDXKkpyOY2tdzLQVMI+0=;
        b=jV+pg65qnbEKWGlv3ZCRx/OPHglc2YZxrmQs9LYshc4nSYh+1ps0Xi6fTUPU31cHWa
         27LS7X01YvBmnMtg9VZmv/yZ1Ypl5/dYF0aNIa9nbCAteF9lQZ8hD9ClGaydPYwi8sm1
         YsNR7vVr+86iAAZ44/zkZiZmbcPQoMLwo4S2GtE7OU+JsNB0aclDNofe8J4ue0oK+zpY
         vSZrB2zY+05M8479F/wHL5q+9TZRk9DFdFL7PF0cB9ElS4Ic9IioreVg+KWulV6xPUIn
         SUtiAVbFpB3ehmXlKlPdnexLPusgQTmgAKW3VUY33xw6ImvtXziXiRYK21kuPapGyenf
         IPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yrZZLrnVOgRrYALPGlkh+83vDXKkpyOY2tdzLQVMI+0=;
        b=pWrEl+N5TSW5xM1bEre5OTySbShGXbbVcrVyYe9ZxoK7jbP76hiO6aOXE6RrtzOi3T
         sNaJbvMsfoiJh3UOHF5w3ftmmWKxMK6p1ZD37hIMKVLMPaku+Y0L8c18cOsFdylOObkd
         uxSQNpcDVnFIosrXoSLj4Boibeg9pRvz3XywHZ0giMLxKvRHLL7nVNvSQaelGUJNiYs5
         bLsN4g1H15Y+XzlRRe0yc09Yyc3dlez43L2qObWLlsWsoVED9HUj+Kg2xIU7imtYwovn
         I0NA8YJxDtsKARNhW+foD1P31Alxd9pRXcnC+phoOCGVxXvriYz0Fjr3GPQfbgPvkvsS
         /uIQ==
X-Gm-Message-State: AOAM5336eT+1WpVj7S7VnM7dj8IO9mYFJFDemfUmP1m7mzqOX3LseFND
        f99i3O10M/hiYYIrquDrapo=
X-Google-Smtp-Source: ABdhPJze0hcl+iYrvbLopj48rQspg0bvuP9b23AzvOKkWIya4/rwwQH6FBaUjM3nzMsAsUpc6upxTA==
X-Received: by 2002:adf:a3c3:: with SMTP id m3mr871548wrb.237.1632341134440;
        Wed, 22 Sep 2021 13:05:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:05:34 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 10/47] staging: r8188eu: remove _rtw_enqueue_network()
Date:   Wed, 22 Sep 2021 22:03:43 +0200
Message-Id: <20210922200420.9693-11-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function _rtw_enqueue_network() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c    | 17 -----------------
 drivers/staging/r8188eu/include/rtw_mlme.h |  2 --
 2 files changed, 19 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index eae3f8a55a58..fb5952d5f1e4 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -125,23 +125,6 @@ void _rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
 
 }
 
-int	_rtw_enqueue_network(struct __queue *queue, struct wlan_network *pnetwork)
-{
-
-	if (!pnetwork)
-		goto exit;
-
-	spin_lock_bh(&queue->lock);
-
-	list_add_tail(&pnetwork->list, &queue->queue);
-
-	spin_unlock_bh(&queue->lock);
-
-exit:
-
-	return _SUCCESS;
-}
-
 struct	wlan_network *_rtw_alloc_network(struct	mlme_priv *pmlmepriv)/* _queue *free_queue) */
 {
 	struct	wlan_network	*pnetwork;
diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
index fcd700c79af7..e0fec3ac55de 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme.h
@@ -584,8 +584,6 @@ void rtw_free_mlme_priv_ie_data(struct mlme_priv *pmlmepriv);
 
 void _rtw_free_mlme_priv(struct mlme_priv *pmlmepriv);
 
-int _rtw_enqueue_network(struct __queue *queue, struct wlan_network *pnetwork);
-
  struct wlan_network *_rtw_alloc_network(struct mlme_priv *pmlmepriv);
 
 void _rtw_free_network(struct mlme_priv *pmlmepriv,
-- 
2.33.0

