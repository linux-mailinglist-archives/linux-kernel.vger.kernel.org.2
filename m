Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540AF3582E8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhDHMJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhDHMJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:09:44 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F327DC061760;
        Thu,  8 Apr 2021 05:09:32 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r9so2635864ejj.3;
        Thu, 08 Apr 2021 05:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=8ZtYAi9FD6ywNvbsUUiDVD+PFNAmOjD53yMF0tYBZu4=;
        b=mzL/BAgawHqdfoadRdvf17seAPRRIB95QbrSL2ZRyxn54+oyrqdw78IyMvTVGP4woy
         CPBnj4m4Iceo9Rry6RPUpFcim8p2DBDE/oowiJbwYwGROuFGzDLGstN+QqN4IeCQPWz0
         B6NsAWlTglDo5GeA85HpPRWRd8gzkLnqBP+g66EgsvbJMM0UeIcYU/3venfanDiQq+iq
         gVtOUt99ubWvi8AWK8P4Jrun3TKAJSZ0uUZdpgVHeSEPV+w53W2MPQ6Z0J+RnS1qUa2s
         ij5AbPgXu1sUsNXJapgdntyLqD0IsXyBwZvxwnPh4Gjlj3w7VtpVRZvUf0Z4rma95QVO
         9xww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=8ZtYAi9FD6ywNvbsUUiDVD+PFNAmOjD53yMF0tYBZu4=;
        b=lueOKT9zxnZG8j11FQnQds+30UQs8VSj8BxcjIRg0t8MFK0E13D8T3PWopJ5T0sUQi
         Ptepp7Xkg7kFZvcQhLIRpLcjZPICIkyZRSsgFO0DItrxBB9Xzxh27326fDT6ly9j3flq
         bdgJyb1FGQ3mkeXIjmr/ZxFDaXaBB6t8yLfFBYahJnAMsxuokLmVCCmwCB+zqMLX1SwC
         fHlqgzszLpaOleP+JF6VKd8xgKWrO8NqjDfJJ1cohsOu3FGrI8i7Nbn7qfkaIJ4vZZf9
         N9Ms7zP34SAUQyex1RRMGpAFlaamuD0mfc9U2Co+7/taR+PC6gonKS29HVumGulOectw
         ELwA==
X-Gm-Message-State: AOAM531mDXURc+sajRzJUbNvrVVz7fhYQvwNgY2EI6Up9pYI1xa/WNn7
        4dilmwFSaqKKWLkP+MM2w18=
X-Google-Smtp-Source: ABdhPJxKRKK4zNATm5BLnmA+LjKN/dkZARAozw/DoelagCQevUZOwMSLk4P+F00BDJnTZh+CYNxerA==
X-Received: by 2002:a17:906:9381:: with SMTP id l1mr9906077ejx.129.1617883771739;
        Thu, 08 Apr 2021 05:09:31 -0700 (PDT)
Received: from test-VirtualBox ([87.116.165.76])
        by smtp.gmail.com with ESMTPSA id w13sm10970111edc.81.2021.04.08.05.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 05:09:31 -0700 (PDT)
Date:   Thu, 8 Apr 2021 14:09:29 +0200
From:   Sergei Krainov <sergei.krainov.lkd@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2] staging: rtl8712: remove unused variable from
 rtl871x_mlme.c
Message-ID: <20210408120929.GA4346@test-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable from rtl871x_mlme.c.

No side effects can be seen locally or in r8712_find_network()

Signed-off-by: Sergei Krainov <sergei.krainov.lkd@gmail.com>
---
Changes from v1: Rechecked if deleted code doesn't have any
side effects and added description that no observable
side effects were found
 drivers/staging/rtl8712/rtl871x_mlme.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
index 8a97307fbbd6..4f41e321ea63 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -656,7 +656,7 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
 	struct sta_priv	*pstapriv = &adapter->stapriv;
 	struct mlme_priv	*pmlmepriv = &adapter->mlmepriv;
 	struct wlan_network	*cur_network = &pmlmepriv->cur_network;
-	struct wlan_network	*pcur_wlan = NULL, *ptarget_wlan = NULL;
+	struct wlan_network	*ptarget_wlan = NULL;
 	unsigned int		the_same_macaddr = false;
 	struct wlan_network *pnetwork;
 
@@ -721,13 +721,6 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
 					    scanned_queue,
 					    cur_network->network.MacAddress);
 				} else {
-					pcur_wlan =
-					     r8712_find_network(&pmlmepriv->
-					     scanned_queue,
-					     cur_network->network.MacAddress);
-					if (pcur_wlan)
-						pcur_wlan->fixed = false;
-
 					pcur_sta = r8712_get_stainfo(pstapriv,
 					     cur_network->network.MacAddress);
 					spin_lock_irqsave(&pstapriv->
-- 
2.25.1

