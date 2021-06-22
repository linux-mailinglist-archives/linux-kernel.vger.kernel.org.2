Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591223B0593
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 15:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhFVNNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 09:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbhFVNMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 09:12:44 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0008C0613A4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:10:28 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id h21-20020a1ccc150000b02901d4d33c5ca0so2222200wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gNOemOTras9F985BUt7jkfUSz/FQKfSLHckmy+4u2+Q=;
        b=r8zjWNsHJfYUG4XaG7ALHwWZMS/mKG9J1P3WEpUSGpX5FACY+XGFb3AEYmdK5jgmAD
         u/NvpBC5WHno0T3q4+LtfD8Qo7NVyS8dzEgtxqOhgOLwetITuqPKS4B+pUv5PRMaPpd3
         fPwjXVy0j9weYjUHE2IIkePjkQba2DtbXzWNo/84NDJ2BNqvsGfwGUBsy0eV0613iGKV
         FT/GfRTxIcaDu6fgOojFdoUMEgPSxVAxpS38PHfRMy4QoUtsoY4ZonIRN+861DdgYRUD
         kj8UJQoTqlWpDHBd0N6C7//4N08iPRYJCa1Nq+GYKFgY078nqARmdfIhGEoiqZId3Q7S
         x6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gNOemOTras9F985BUt7jkfUSz/FQKfSLHckmy+4u2+Q=;
        b=bigJ9VnGQH0SISQsX0SLFkt2Wd7koaMSbQ6PoKqCDlnwkVkUv7Mt80U8k6g+DFeMmo
         reA2mmVDPSw9ktDrLMwiyaVYdOWDX105kQFQrw1g3MaYLhn0tIg9k1i7cMMA9IzarDxG
         ebjWqGHdNiib0Mw1Ahlak3gAEwAHxVT8TJTT4GGiYUqQ5S2QiIPiqKBA9Nf90iSu89Qq
         ll+hfZ+wp3Dz5ArmYTmiwsVUmydv47L9EBaO2P0RxjI82nHz14WT0Qi6er8zk47nNAp6
         qQml75mtgE7GNjpzs1TFFnsKE+5TfX/+iOTnSIU2tsSkwWZXm35A+7U5vvr3Yhv0spaV
         ksig==
X-Gm-Message-State: AOAM5334BoJFcRWLSdPv+Kv4xaVYKpoYn6KZIOEbYng13HC+sAXkrB8f
        rTA/fGcz9dvszalrFtj14Zg7+pCwrjvH5Q==
X-Google-Smtp-Source: ABdhPJy4kfR2MSJThX/eqf8Vo8Iwo3WLxSsS4tIhf+wA84PFtB0S328inGr01cwVQnA52yLXGpuPTA==
X-Received: by 2002:a05:600c:354d:: with SMTP id i13mr4253325wmq.67.1624367427221;
        Tue, 22 Jun 2021 06:10:27 -0700 (PDT)
Received: from agape ([5.171.73.108])
        by smtp.gmail.com with ESMTPSA id e3sm11234726wro.26.2021.06.22.06.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 06:10:27 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 16/17] staging: rtl8723bs: fix check allowing 5Ghz settings
Date:   Tue, 22 Jun 2021 15:10:00 +0200
Message-Id: <df7d0ecc02ac7a27e568768523dd7b3f34acd551.1624367072.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624367071.git.fabioaiuto83@gmail.com>
References: <cover.1624367071.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix check allowing 5Ghz settings, only disabled and
2.4Ghz enabled states are allowed. Fix comment
accordingly.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index afefc2c8a2ac..e73fb13f8968 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2572,10 +2572,9 @@ static int rtw_dbg_port(struct net_device *dev,
 				case 0x12: /* set rx_stbc */
 				{
 					struct registry_priv *pregpriv = &padapter->registrypriv;
-					/*  0: disable, bit(0):enable 2.4g, bit(1):enable 5g, 0x3: enable both 2.4g and 5g */
-					/* default is set to enable 2.4GHZ for IOT issue with bufflao's AP at 5GHZ */
-					if (extra_arg == 0 || extra_arg == 1 ||
-					    extra_arg == 2 || extra_arg == 3)
+					/*  0: disable, bit(0):enable 2.4g */
+					/* default is set to enable 2.4GHZ */
+					if (extra_arg == 0 || extra_arg == 1)
 						pregpriv->rx_stbc = extra_arg;
 				}
 				break;
-- 
2.20.1

