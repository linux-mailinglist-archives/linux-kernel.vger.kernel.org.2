Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1079357E20
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 10:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhDHIda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 04:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhDHId3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 04:33:29 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4ABC061760;
        Thu,  8 Apr 2021 01:33:16 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id w3so1617679ejc.4;
        Thu, 08 Apr 2021 01:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Exo3uKERlOorL8sYR7oV52Cn5+SfGTGaWwxNlmktpDQ=;
        b=VhpWVORxuid4K2b27HoDl2AYyP69gLKfqeNvy19T7oyNBS0eLlKVj1HTdtekZCvjGM
         dCYX+7+7jy/QXBf2u+EDQli+MC2A6TRt26EKjtJWzudSucQ9kt77PgcGtJESRzabL+0p
         MA1p0T2+l0pwVaeVrllSeWnBkorqTxSgRlIUFkkvzyOM3W6rcKTa/qlW7zUCx1nn6jXB
         cqYqHae4nsnlcJqkvdm92QUOSm/fnVwvqVC3GW7qKgf6n/HZO5CpcOzQ9UzvTO2OinRa
         Vg1RdBvD+nznzH0x8qYaPr0kvVFQgGJSYRLPDRvyOnf6NDyGm8I02w7LWWSMqFD/4lr0
         SdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Exo3uKERlOorL8sYR7oV52Cn5+SfGTGaWwxNlmktpDQ=;
        b=Q0GWDaE0UhRFTTk52KAMHcigLH/XF3b6XUVtPGoYBFuAMxwnTIKYbpagS1E+Q5U4j4
         ltrxdz7Ai0sZfuVczXeD5Ip/oXzASEw1+paYWtDYrP71YPsmClHHNBGC64o9WwgapsIP
         27zpZWpUJu6DOcQ8Cs+/urbQOqT+Q+TSacLRICxHZw8MOilma6FNPkxlZnCTtPWA2dRs
         K55yQEYG4bXYgJ/VmfZPfBM+v5KNpLSn+mNbLTqj63FZ739gjI6eIDb8kVYyZmTO0hPk
         iXQw6UmEw3yOgIHXSuUSs2AOD+Np5BYW4/iEZK7Mz+Y/tCdkDKbS75aNLWgc+ceDPHuG
         lSvg==
X-Gm-Message-State: AOAM532zo4k1YQj+us0n6wqmMzwlff5qO+7yX06uV/gj8lOwgQvvW1Wb
        I7m3uQJsxKlrSZ9+u2LYj3Q=
X-Google-Smtp-Source: ABdhPJwR95/4pR3u/U+9Z5ks/A7/FkmTTdsgUE0MbZDz3MHwSAkNlKNcvoE0ArY+CCCyDTeU8owpyQ==
X-Received: by 2002:a17:906:27c9:: with SMTP id k9mr8563485ejc.26.1617870795620;
        Thu, 08 Apr 2021 01:33:15 -0700 (PDT)
Received: from test-VirtualBox ([87.116.165.76])
        by smtp.gmail.com with ESMTPSA id t15sm155883ejd.7.2021.04.08.01.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 01:33:15 -0700 (PDT)
Date:   Thu, 8 Apr 2021 10:33:12 +0200
From:   Sergei Krainov <sergei.krainov.lkd@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] staging: rtl8712: remove unused variable from rtl871x_mlme.c
Message-ID: <20210408083312.GA3118@test-VirtualBox>
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

