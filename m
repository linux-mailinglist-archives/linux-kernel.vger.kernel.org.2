Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCBD8444CE6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 02:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhKDBON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 21:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhKDBOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 21:14:12 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27750C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 18:11:35 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id p18so4453737plf.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 18:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TP1hwCW+njqVoxdMPYK11dRBZdomjWtVnigfuLPzlfE=;
        b=I4ujB1PLmXUwDIhEnrgqJmxi/IIaAHdCQOLUqJ5moGoYMWiuhu/i0x6/84OCmXts55
         pz17N2KX34guaCBydWLUt4oSavXAvNtwPY/3WPAI90UMX/nb/9qOv4HbdP81GCZ8+h44
         buP3ISK3vDaGgNND/42q68FwoJahX25azGVW1kyAz4kZZ9d66r4c1ZTxTSEQL6bU2001
         6+i7oVanH+4nvbl84ILE3zyLGnNAtHDHqWl0hixVaNlVzMiQLjNT3eOHWhVTWHac4gjZ
         ib7LZdDraw1DSjdTCwRVWxySILFZz7y5D6+6tH2RWd/jC11P4GLxQ2CdEr4C+vk/zIS3
         kpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TP1hwCW+njqVoxdMPYK11dRBZdomjWtVnigfuLPzlfE=;
        b=GQ8lpDkJgIwPAToE7Xj1///7juHDbUYckWuAY44OJy/msjkPwm76vua5phIK5BEfy6
         B1sBTpxnvYN9/+qHQ1JDVFGwfGefMliX8iMuOtR1NlBsCMi+6EiUwHNfypvj1mzjdrPl
         cWplXExO7Q7PLiN4Zu/CY2DUX3zF56e5gxlIalZ/UGoLCM1VEOI6OE619xQMRYxrcvF5
         1zbR9TIbS1ewEIFKiTQYzGy41lNPQKuh8vm7iSs1GZBkCmwziIAFWcrwa3DG15vABjZb
         kTZ/FcHSm5QEHgCsN2jys7QjKKAtcEK76kVVKwDrNCoim26lft9pY2O1cBlrBKQJ4bvT
         v6Kg==
X-Gm-Message-State: AOAM5338ys5yJPLDpADhb39AX5ygsXLV1Qh+Bo11AQJ3oWCvTQduj4n0
        sEtig2eWn73HC50/Jk+w4GQCaAWVyZo=
X-Google-Smtp-Source: ABdhPJx18CAGa6c0aCYalq525CrBteh7xeX+5AEH5gQfpIZ848hmw5AkMEeLc7ao49X8IrH30pZaUg==
X-Received: by 2002:a17:90a:7845:: with SMTP id y5mr18613384pjl.48.1635988294795;
        Wed, 03 Nov 2021 18:11:34 -0700 (PDT)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id y32sm3979759pfa.145.2021.11.03.18.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 18:11:34 -0700 (PDT)
From:   davidcomponentone@gmail.com
X-Google-Original-From: yang.guang5@zte.com.cn
To:     zbr@ioremap.net
Cc:     davidcomponentone@gmail.com, gregkh@linuxfoundation.org,
        ivan.zaentsev@wirenboard.ru, yangyingliang@huawei.com,
        unixbhaskar@gmail.com, dan.carpenter@oracle.com,
        yang.guang5@zte.com.cn, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] w1: w1_therm: use swap() to make code cleaner
Date:   Thu,  4 Nov 2021 09:11:23 +0800
Message-Id: <20211104011123.1027524-1-yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 drivers/w1/slaves/w1_therm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index ca70c5f03206..c743cb3d277a 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -1785,7 +1785,7 @@ static ssize_t alarms_store(struct device *device,
 	u8 new_config_register[3];	/* array of data to be written */
 	int temp, ret;
 	char *token = NULL;
-	s8 tl, th, tt;	/* 1 byte per value + temp ring order */
+	s8 tl, th;	/* 1 byte per value + temp ring order */
 	char *p_args, *orig;
 
 	p_args = orig = kmalloc(size, GFP_KERNEL);
@@ -1837,7 +1837,7 @@ static ssize_t alarms_store(struct device *device,
 
 	/* Reorder if required th and tl */
 	if (tl > th) {
-		tt = tl; tl = th; th = tt;
+		swap(tl, th);
 	}
 
 	/*
-- 
2.30.2

