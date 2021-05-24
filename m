Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02DD38F434
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 22:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbhEXUUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 16:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbhEXUUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 16:20:47 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0DAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:19:19 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q5so29778746wrs.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+n2dpT6IUqkBPkmCGuGyykptbH+YIBRKkSdVdL36/50=;
        b=ImpWS6qz92LIiBkSfsLk1lY47pYJa9kricQIoRctET5Z3V3xA5KR2mh1ZgyHlwBMmd
         dimTnyo9fReNV5rExRSsQhu0od6Id9AsLEgBrTCZcEhCQG5h9VLNl8YPrlh6ard+t6iy
         S6KGF87xr0S+dSs2xcnhNqRpofb/DbBDoV94dsCrIg/B/ytAJI56Pfoidb4DF6eeL4+e
         7ExcCuUErROEeVyZUXCPKh4n0fBKRMkknQnQd+zSsLrSF5NCmCDXEuUHS4xjNKMMdeIM
         BsiuqrJs/Cr8s91+utkTXCO+QxKc+TTrJtCDLNw9uCl+c80W9/dzvtT3BD5L6vcpaEys
         yfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+n2dpT6IUqkBPkmCGuGyykptbH+YIBRKkSdVdL36/50=;
        b=Lm1EHVwACOaxm0VywnYMVFSVHgYvQ8cvE3jVjnBzhZRCFbdc4efPN3PuMpLuRDJqoP
         j8lVHA/yAd0l0WmjjhGTIIiiC9UPo+yNfnHU2kDHQNRA1tF/qSVqmEK/ITsWQqTuL032
         7+NOR5PmjU75US64WJdtraCI/6Cv0i8ZR2jO/wHMuS2I4eJwJD5GQsS0bh9k7NmX95p6
         8NZzVHV+WhKD349ITGFCxXq+pY6azc9CUKhnhRdHtqorRW7ggwHpT7lNfxCBhC2nu4qB
         6kYsHBs2P2x4L1tup7XWht5K7IZYkdyBW7QBZjc5y4rKu1W79X1OUgeY/GoUz/LzyFJs
         0crw==
X-Gm-Message-State: AOAM531/mNJYE39fJJXT+2WDPfkqNhPA89MqQE+Lv8pRbt83LFkgXgIy
        oIrDHfhGwBKsy8X54mRXedSaBI9RP6s=
X-Google-Smtp-Source: ABdhPJw/XIzNIE9o5pw76JkEWjtXH7N3LgZZYh5REKRFccg3ryggLxtn9AvTfTLlxpCfa/nmCg37sg==
X-Received: by 2002:a5d:6b09:: with SMTP id v9mr23524234wrw.297.1621887557428;
        Mon, 24 May 2021 13:19:17 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:8954:39a5:6045:cd0c? (p200300ea8f384600895439a56045cd0c.dip0.t-ipconnect.de. [2003:ea:8f38:4600:8954:39a5:6045:cd0c])
        by smtp.googlemail.com with ESMTPSA id y2sm13403645wrl.92.2021.05.24.13.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 13:19:17 -0700 (PDT)
Subject: [PATCH 13/13] eeprom: ee1004: Add helper ee1004_cleanup
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <bd8439bc-3a6f-fd52-5fd1-bf9782061612@gmail.com>
Message-ID: <9738cbc7-458d-276f-4012-66551f105d90@gmail.com>
Date:   Mon, 24 May 2021 22:18:23 +0200
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

Factor out the cleanup code to a new helper ee1004_cleanup().

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/misc/eeprom/ee1004.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index 5173d040c..00f61a83d 100644
--- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -159,6 +159,15 @@ static struct bin_attribute *ee1004_attrs[] = {
 
 BIN_ATTRIBUTE_GROUPS(ee1004);
 
+static void ee1004_cleanup(int idx)
+{
+	if (--ee1004_dev_count == 0)
+		while (--idx >= 0) {
+			i2c_unregister_device(ee1004_set_page[idx]);
+			ee1004_set_page[idx] = NULL;
+		}
+}
+
 static int ee1004_probe(struct i2c_client *client)
 {
 	int err, cnr = 0;
@@ -205,12 +214,7 @@ static int ee1004_probe(struct i2c_client *client)
 	return 0;
 
  err_clients:
-	if (--ee1004_dev_count == 0) {
-		for (cnr--; cnr >= 0; cnr--) {
-			i2c_unregister_device(ee1004_set_page[cnr]);
-			ee1004_set_page[cnr] = NULL;
-		}
-	}
+	ee1004_cleanup(cnr);
 	mutex_unlock(&ee1004_bus_lock);
 
 	return err;
@@ -218,16 +222,9 @@ static int ee1004_probe(struct i2c_client *client)
 
 static int ee1004_remove(struct i2c_client *client)
 {
-	int i;
-
 	/* Remove page select clients if this is the last device */
 	mutex_lock(&ee1004_bus_lock);
-	if (--ee1004_dev_count == 0) {
-		for (i = 0; i < EE1004_NUM_PAGES; i++) {
-			i2c_unregister_device(ee1004_set_page[i]);
-			ee1004_set_page[i] = NULL;
-		}
-	}
+	ee1004_cleanup(EE1004_NUM_PAGES);
 	mutex_unlock(&ee1004_bus_lock);
 
 	return 0;
-- 
2.31.1


