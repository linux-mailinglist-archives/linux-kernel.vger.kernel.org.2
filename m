Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F23338F431
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 22:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbhEXUUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 16:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbhEXUUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 16:20:38 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5CAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:19:09 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id b7so14905704wmh.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oGBBCGmn2Pnq7/aNp28WU2vc3nuNQ9zWFfNc5lZEUDU=;
        b=XvV5eSlhciDjZpIUTN5M2Cdkul4Hs9ZeDu9xnhUaVO9o5BOjQB+n9/bP2srGpxPQFf
         mf5Z/9pUyW9iwGA0kChWvcwkhUHTn56EcARqm1rwC59yBYK10fvXEZJi5g3LYfFzkpku
         ZufFRYm3A2spBr2/gK4gn2C1V5k1OwE3Ukrt4OIYNnC/Ygz1Cjmvx+meE2n4ukrufZ7+
         sdorL3ZoA3xan+7mm2L0XHTrJvutvFGWsBR+Cw7BMsos04AVyJr8PMNf9zav9yj0kn5o
         TQGsbEZ8MBp3U3UX/N76Si0ilhlBHFweNCdUHfekob+UO3ea3fxIy1f9dH7qD6CKKGCM
         RzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oGBBCGmn2Pnq7/aNp28WU2vc3nuNQ9zWFfNc5lZEUDU=;
        b=pkzEoZz+3ENkKHx8Kxgnvl61IkSvSq03zZNOxobGkGRhLnMssReObADgvsZz+ZWbFg
         fpn6unj2sUubUT+Jlvbj3WAgu/TeGhOLsVoVDJacAbUKd2VuDoCi1lEMFIJdz6n2pUaD
         NkL1VVnacms4UEvEW0Bk5YbYA8P0kqkobnhqkmlnOp3q1clhT/MLKKzNy+zFGTS3zIaz
         LRukUADP9TH8MQnWrJBbmWh4viQ38AnadDwYpFLxy+RJwp4DDfT2AjQdWuT6Z5ksa4YN
         FDO7BEfF7QJG5+Dgb92hyl9H9QeuppPEKLJF6ul4wPHzzM8RxMTx2X3RNDN10WjIhM17
         GvIw==
X-Gm-Message-State: AOAM530f5nfiPWY8abb/FcsoTNj8uDfxe63rpLIICF7PUdfGxp1u9O5H
        pDkD/Bl8km6du/VWNiIo5pR2rOhCnkg=
X-Google-Smtp-Source: ABdhPJyKzAr0T2yshLJ3TEf/YrcXXZ+oLKob+ryFuoH28QCoT58ofGBBwhRx7umDxdeFC+yD2m3aEg==
X-Received: by 2002:a1c:3186:: with SMTP id x128mr20273604wmx.167.1621887547509;
        Mon, 24 May 2021 13:19:07 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:8954:39a5:6045:cd0c? (p200300ea8f384600895439a56045cd0c.dip0.t-ipconnect.de. [2003:ea:8f38:4600:8954:39a5:6045:cd0c])
        by smtp.googlemail.com with ESMTPSA id z17sm15567701wrt.81.2021.05.24.13.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 13:19:07 -0700 (PDT)
Subject: [PATCH 10/13] eeprom: ee1004: Improve error handling in ee1004_read
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <bd8439bc-3a6f-fd52-5fd1-bf9782061612@gmail.com>
Message-ID: <13ad7b39-e722-d70a-e25b-03d1fb1734a7@gmail.com>
Date:   Mon, 24 May 2021 22:16:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <bd8439bc-3a6f-fd52-5fd1-bf9782061612@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the error handling and make it better readable. No functional
change intended.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/misc/eeprom/ee1004.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index 33855e459..d18348ee4 100644
--- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -119,7 +119,7 @@ static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
 {
 	struct i2c_client *client = kobj_to_i2c_client(kobj);
 	size_t requested = count;
-	int page;
+	int page, ret = 0;
 
 	page = off >> EE1004_PAGE_SHIFT;
 	if (unlikely(page > 1))
@@ -133,33 +133,28 @@ static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
 	mutex_lock(&ee1004_bus_lock);
 
 	while (count) {
-		int status;
-
 		/* Select page */
-		status = ee1004_set_current_page(dev, page);
-		if (status) {
-			mutex_unlock(&ee1004_bus_lock);
-			return status;
-		}
+		ret = ee1004_set_current_page(dev, page);
+		if (ret)
+			goto out;
 
-		status = ee1004_eeprom_read(client, buf, off, count);
-		if (status < 0) {
-			mutex_unlock(&ee1004_bus_lock);
-			return status;
-		}
-		buf += status;
-		off += status;
-		count -= status;
+		ret = ee1004_eeprom_read(client, buf, off, count);
+		if (ret < 0)
+			goto out;
+
+		buf += ret;
+		off += ret;
+		count -= ret;
 
 		if (off == EE1004_PAGE_SIZE) {
 			page++;
 			off = 0;
 		}
 	}
-
+out:
 	mutex_unlock(&ee1004_bus_lock);
 
-	return requested;
+	return ret < 0 ? ret : requested;
 }
 
 static BIN_ATTR_RO(eeprom, EE1004_EEPROM_SIZE);
-- 
2.31.1


