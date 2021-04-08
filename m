Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F6E357F13
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhDHJYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhDHJYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:24:49 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97213C061760;
        Thu,  8 Apr 2021 02:24:38 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id mh7so1814176ejb.12;
        Thu, 08 Apr 2021 02:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=3lbUPpJurXJokmph9WoNmMs1fe6ThVm1fd93joLn2Gk=;
        b=jF/NCrUw5IxSYu/zRC5hVftqtDXEwXbRsFnXPReraR8naNX5NCFI/zqNrp7DvMc0oz
         IJYNvNeglJkWskPOMhGSRo8A6USzjQMiohfjvmVR9wyuqG/WIkkBpIvTTIO/zFF2zoSw
         X1U4TEk5H+075lNLfvV04Gc64Wh7vpPF8tfRuE3zx2wJMM7NhqfzjEROGEqtJ6EHovAR
         Pp/cVcUrYvJdT6h6D8lZyTrxYZ2AScANZL6B/7ADwPMFyMx9RxcENbmwle2vsD8rT1nZ
         pgs6vAUYXsdhE1DHqZFYgYBUCi/aio/NihSlp2CvaybwG1la7N7S/GoXVUn4izUhufNY
         3dsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3lbUPpJurXJokmph9WoNmMs1fe6ThVm1fd93joLn2Gk=;
        b=JxsFWUjnT06Dje7jxjduFfayjN7uoRtdiRNBKEmOWK4DocHlxUxNVa5v8ct5o6Wy8N
         +6ywTknYnJSsb6qcIG5Ltkk0doqr9/6rayqGlFV1pKih+MHsaE4OaphU2HLrATy/ZYIc
         h8cAT6QrsZUdt1DFYR8NuRLEZcgeZLaM6eoRiOHmG9wsS1/ikYnAou5s7JJmsjORRnJ4
         SqLq1x8vlHuCRGIkzc9sXzwDo+8rJIowapF8zawnBwunQN1LotTqCyq17BsFqQEWeTcJ
         r6tKBiU11cdVZUWVpnZQPTnmXVFpenmmHk9WcsBLjrYcTjqd6EAiyq2fM/pLk3D23pNK
         +gXw==
X-Gm-Message-State: AOAM5323+7PqifDoK6tXBJdQSnN6u1XZq9ZwZ7JEcGif8Qvis7HDmHu0
        pLNDivYS2J/dEd9UYJbBvUg=
X-Google-Smtp-Source: ABdhPJzfmCVbJAtKQ3Q84d94CylAYCPtANdcTodmCR7IviUqvYzsypN85SQkgNAJHTb54r8Vm9BReA==
X-Received: by 2002:a17:906:64f:: with SMTP id t15mr6115377ejb.411.1617873877383;
        Thu, 08 Apr 2021 02:24:37 -0700 (PDT)
Received: from test-VirtualBox ([87.116.181.227])
        by smtp.gmail.com with ESMTPSA id d15sm453497ejj.42.2021.04.08.02.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 02:24:37 -0700 (PDT)
Date:   Thu, 8 Apr 2021 11:24:35 +0200
From:   Sergei Krainov <sergei.krainov.lkd@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] staging: rtl8712: remove unused variable from rtl871x_mlme.c
Message-ID: <20210408092435.GA4096@test-VirtualBox>
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
Mention in the description that no observable side effects were found

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

