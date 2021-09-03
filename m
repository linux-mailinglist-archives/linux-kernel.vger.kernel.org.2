Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C02D4005A3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 21:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350670AbhICTRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 15:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350625AbhICTQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 15:16:56 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F769C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 12:15:56 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so197752wms.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 12:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZX+m9eRP3G6qa3o26UuCwjfzdvb0rxacvbcUwg9LjVM=;
        b=Ns2hVXrhoznNB3oQH1t3+j6ATt0VKG0o6PldIrMPznDbonpNc1JD3nxHMg2SOs8UB8
         BEJjTrpy4wiOEyUr11OotV8A6rA4sifBneYuht28Gc5LpQI9C+bPdJBSE6ikH5bmDNGw
         cqzxmpIGpbK7/VhLW70smCjFmbueWXY/fc7MfM+Yo1sG39GmR9+QMyasxlMaKklG5Fa9
         YKT09M1sYE4rW2rJLeVh/AkKNItUQk636prFyQ7ozincLTr+iQbEo9cuWtfCqbFvC++B
         trzuWRKuU4MdJ04uS0RxcaGjecHNZL6OGlx33M5+rYVeDG0ngluExiFl0ZClBTh/zNXG
         0hMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZX+m9eRP3G6qa3o26UuCwjfzdvb0rxacvbcUwg9LjVM=;
        b=op9RFzbpIRd1ttkrQMohBVPBEeoqJOjmhZCOxv196o8wX2jPfDL4rJB90AkOVLFsEf
         CHI99pLyXG8Gv5J2Cfvj0XUIK32HP7Hmo7TyyNxlQx4oS35eY3d9dP5Ukt+o4uN+WeWk
         IU0CdiUx13NQr/0gyzd+I/1AU584HiSAyWHkgu4YZZqdhxNtA4yQHYiD7uV3NInuMDDE
         Cpt3S6d8gXmCsEuTvizI6dUKRnrZEM9/+2Z/y4uNIENfeZL3PCNMh+I7WxINfKIS7RhH
         46w8zS3v3EYVqyaCJEAH6xm03fnUKvfA+8uU1uu/PKSgnMDC4Pa4Ot6p7ytuYcEpqin7
         +3mg==
X-Gm-Message-State: AOAM530iktZWxdHQ30Wj4HlnPdwaDvOJuArVpNAybZ3XRZFP7jfJCwkr
        3LPF9mgnovIlB0lUMrt3JP35xA==
X-Google-Smtp-Source: ABdhPJxE0dUX5u4RNf/Wx18X+2EXKv90xIdKm7MsrBaO5GUKwN6yqejEQKaf0pkgyJ7eVksRjDUa2Q==
X-Received: by 2002:a05:600c:acd:: with SMTP id c13mr327456wmr.28.1630696555125;
        Fri, 03 Sep 2021 12:15:55 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a133sm253397wme.5.2021.09.03.12.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 12:15:54 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mjpeg-users@lists.sourceforge.net,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 2/8] staging: media: zoran: use module_pci_driver
Date:   Fri,  3 Sep 2021 19:15:34 +0000
Message-Id: <20210903191540.3052775-3-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210903191540.3052775-1-clabbe@baylibre.com>
References: <20210903191540.3052775-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify code by using module_pci_driver()

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/staging/media/zoran/zoran_card.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/staging/media/zoran/zoran_card.c b/drivers/staging/media/zoran/zoran_card.c
index 3bc0e64f1007..f1465fbf98af 100644
--- a/drivers/staging/media/zoran/zoran_card.c
+++ b/drivers/staging/media/zoran/zoran_card.c
@@ -1314,23 +1314,4 @@ static struct pci_driver zoran_driver = {
 	.remove = zoran_remove,
 };
 
-static int __init zoran_init(void)
-{
-	int res;
-
-	res = pci_register_driver(&zoran_driver);
-	if (res) {
-		pr_err("Unable to register ZR36057 driver\n");
-		return res;
-	}
-
-	return 0;
-}
-
-static void __exit zoran_exit(void)
-{
-	pci_unregister_driver(&zoran_driver);
-}
-
-module_init(zoran_init);
-module_exit(zoran_exit);
+module_pci_driver(zoran_driver);
-- 
2.32.0

