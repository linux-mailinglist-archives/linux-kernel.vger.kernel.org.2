Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B6E3574FD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 21:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355635AbhDGTcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 15:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345202AbhDGTc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 15:32:28 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3427C06175F;
        Wed,  7 Apr 2021 12:32:18 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 184so22077790ljf.9;
        Wed, 07 Apr 2021 12:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=BGJNbfrqvXQ7YZKTbOhkcicRAhCvNB362hxy1D5Wp7I=;
        b=eCGFsHJjM1Kn/fofJc5xWmawS6hTP0oJMLC1Ju0X6LDktS0MBvv5rZcrmmLQxsTecL
         xDjpn+zcJrZriI42/ajIRrlsYaX8FUeSGVnah/xvVNm34KCIaQGieyCpTDjHmESojj94
         gvc80nOUVMl+6q9pF8WKOCodnCEdH0Mfec+pPjJDR9G5aO54HZYEnWXogCn7T2Lk1Eo0
         cZGLNlpp/Px98tLR+5yG1GSVddos1cX1lFulrnXNm9DTRk9yGsAoOJF7JFZhP/ZAxG3z
         eyiCuuiZSQVkEyQEh9/znW18PD0yzWHwbWvdc0gDFkVb+kVLUVBjW0Zpk0+v7WpDxluq
         f3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=BGJNbfrqvXQ7YZKTbOhkcicRAhCvNB362hxy1D5Wp7I=;
        b=pdQ5YI3/8sOHl8PhS8WzJmKNJw9MjLZjXcnuwR+GqQbL27CwlvLVjPYc1E2lF6fw3w
         uynX63zn3kj3g5DMt2tLdMeoqOrUF+3VXnir0VhaMr4iYIlAiGxYjSYpPZ/ljLrfU14Z
         pQAVc2oEQZZb1KNLTkhkngbNGZPUKoPq3JGa1ilRhN+wa67jKC/IZrhGfwxXxPQq3A/4
         labzhgc6Xpm6h0kj9MkyiaiY/vLvXYEwyp0t4T6x+4NxPZaH38t9sk1EndA9N87JQq4K
         UnAaTcg1qskE4y5IDsRZ1dLNAB2kfXKPupCyHM22+aNxc/3NR1Og4YnPVZqWKl+iVFgT
         Kr8g==
X-Gm-Message-State: AOAM533K2rX/GtkXwx8Vpjc+5oTzUbSKnsEHeSuIS28zb0ENGSVimL8j
        Mz/3sECKm6diuW7ZR8BGzik=
X-Google-Smtp-Source: ABdhPJwQG4d5XvB4QyfkaW3I4rf6tge4vYmGDkdNtaK8ULajoegD4824Yb3YDClxehK30p1DtUkXEg==
X-Received: by 2002:a2e:3913:: with SMTP id g19mr3146110lja.294.1617823937326;
        Wed, 07 Apr 2021 12:32:17 -0700 (PDT)
Received: from test-VirtualBox ([87.116.183.186])
        by smtp.gmail.com with ESMTPSA id f16sm2500686lfm.155.2021.04.07.12.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 12:32:17 -0700 (PDT)
Date:   Wed, 7 Apr 2021 21:32:14 +0200
From:   Sergei Krainov <sergei.krainov.lkd@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] staging: rtl8712: remove unused variable from rtl871x_mlme.c
Message-ID: <20210407193214.GA284402@test-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable from rtl871x_mlme.c

Signed-off-by: Sergei Krainov <sergei.krainov.lkd@gmail.com>
---
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

