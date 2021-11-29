Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8FE460B8F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 01:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376480AbhK2A0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 19:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238722AbhK2AYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 19:24:12 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B6BC061759
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 16:20:55 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id gu12so12797451qvb.6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 16:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EPmUBGthEhAXBl7E5PN7Ogq4bY2BAt5Q0BB0Vh1NhcM=;
        b=prGI3iWcoQiOwWQvkqLuxlNAkncfrqOWy/UXZR21tXudPxUvsOB3wHcpOeOf5HnQov
         17EoX8vQSUF1mSkNglPEF4EVo/9Kikmkc/8LVxRVP1Z2f0YDe4+L4wItgXFrHGuDjdP5
         f7a2AKmzt3dIwsCdlnVAf+dmcIL6JE4LB2B+W3A2zARbtCsefLiWtWH7yK4czRdIUXDf
         5AacrUtOhzvERt7Jt2btKTgTqF7OvW2NL9mNxg+NQqBqSmXuKR0UHqFrqzfLYcmLxxXU
         hX+tTGPzBJXyoWC9W0t9OcMWXqNrrkMWuWAADRpRTzGBUmEqHLCKbbvAMdpBVZafZt8O
         q+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EPmUBGthEhAXBl7E5PN7Ogq4bY2BAt5Q0BB0Vh1NhcM=;
        b=WK4p4KqwQokOrRsrOg3QJUXJ6jdd7wkoCfv2JxOtWiu08aJgy8vtISfLMFU9z9lNhh
         oghnzvXvxGoGBO+mj6WFK1xvPKbHRXHIE32xDcSGtXm3zAIlbh+7JM9NUFA/GqV7dNvd
         Tv4rx5BkATEh2zxPo2ZweWDn3/SL6x96KMUro/0vHBUTY05CoSY8l2fKvI9yV3KwSz/f
         s2SDaWG3dck46y+ElABClnsGLq5E7caTKiEu3x7gciz0ZzVdBMA3J3lZrI3ycCj/yJlb
         tToIu3nUppebDMicv5BVhcz3ML6h/oKrJcLDkBXwoIkAv350w0hFYJNuhWtEM2z0EGgl
         17EQ==
X-Gm-Message-State: AOAM53058jALB/50QWRrLkV136HfNssqxm5BiMbubVX9aZtTFROJVMkI
        /GGlfltLjjaeVX/0/R8MtKbAa2hJFJgAsg==
X-Google-Smtp-Source: ABdhPJwHYPeHjgVg7jSsVmC74XZJOW13LP6zIp/zBgetAH6y/fWUlDiBKwCDrDgut89ojFr9vDteTQ==
X-Received: by 2002:a05:6214:13d1:: with SMTP id cg17mr26290469qvb.131.1638145254611;
        Sun, 28 Nov 2021 16:20:54 -0800 (PST)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id n74sm5681022qkn.83.2021.11.28.16.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 16:20:54 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] staging: r8188eu: convert DBG_88E_LEVEL calls in os_dep/ioctl_linux.c
Date:   Mon, 29 Nov 2021 00:20:40 +0000
Message-Id: <20211129002041.865-7-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211129002041.865-1-phil@philpotter.co.uk>
References: <20211129002041.865-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert all DBG_88E_LEVEL macro calls in os_dep/ioctl_linux.c to plain
netdev_dbg calls, as although the information is potentially useful,
we should be exposing it using standard kernel debugging functionality.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 52d42e576443..90fcb74ef828 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -60,7 +60,7 @@ void rtw_indicate_wx_assoc_event(struct adapter *padapter)
 
 	memcpy(wrqu.ap_addr.sa_data, pmlmepriv->cur_network.network.MacAddress, ETH_ALEN);
 
-	DBG_88E_LEVEL(_drv_always_, "assoc success\n");
+	netdev_dbg(padapter->pnetdev, "assoc success\n");
 	wireless_send_event(padapter->pnetdev, SIOCGIWAP, &wrqu, NULL);
 }
 
@@ -73,7 +73,7 @@ void rtw_indicate_wx_disassoc_event(struct adapter *padapter)
 	wrqu.ap_addr.sa_family = ARPHRD_ETHER;
 	memset(wrqu.ap_addr.sa_data, 0, ETH_ALEN);
 
-	DBG_88E_LEVEL(_drv_always_, "indicate disassoc\n");
+	netdev_dbg(padapter->pnetdev, "indicate disassoc\n");
 	wireless_send_event(padapter->pnetdev, SIOCGIWAP, &wrqu, NULL);
 }
 
-- 
2.33.1

