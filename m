Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF2A38F432
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 22:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbhEXUUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 16:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbhEXUUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 16:20:42 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAA6C06138E
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:19:12 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q5so29778526wrs.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4MXjiIgolxG0EHNMAqJiqijuk387DhwBJkZiC7I208I=;
        b=Zr/EEaY06bNuzFqC3UqcgiGLa2INoNqG/zGgRoNc9tfba33BHERqJfDnjjVFhW07+9
         3TvANrSceKfLblv1W5PYG7+uept3ORxuhA+NpLlIx2YByPCe17uS7cklWqrJJA2354vG
         Uy2ImWrZUeZY68gH+XaaMIewCAJpIRgGmlOaJ6rc5rL3qCDlmjETE2B69N1pDBAYNlj7
         ljk+ZXMojWyO0hHr7f/WOtxCz1b9HIevto5dw6bBgA9qeXidV8h2/4xkJjCeN94MynSa
         PMGOBZdTAZhohDK610QcgcTpL7M7melNiz/iN3vUmpNJrCaSzbI7lkaryVE+ThM08hl7
         WC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4MXjiIgolxG0EHNMAqJiqijuk387DhwBJkZiC7I208I=;
        b=itWCy82nXMCTWrmcvysZzAMoNbUY80+sjpMM8pfS8trWPcz6fT00rr+sk0ougR1tK6
         DYV5yXmQncvIWgnez6zq0J2vWAwcsVzQlI14zOcNl0/lTGYxQGlMIN6v1A2cix18Nquo
         Nvb8wUjpyJUbBrF7WTmDav4jTcSaJzhDW879scvvVGhMOivR5MMNoqfc4bl7gcyNUARH
         VZdl6nHI8bxMb2fjHWA9a6PmjoqVibaLFNEIbNLazgFQAxf3yvPD8uj7fbq0BKr7Uox8
         6LdRmCe+e/HE26TMgxNPCJPME9VIoY6s6L1Lbt1Bt4tPybHW4QJeepTNtflKRDbLqpqr
         bmoA==
X-Gm-Message-State: AOAM533zROK0aqsFroovKBtsdjm9kXIsML21TVFxNdJD9At8vmq1P17g
        0Pml+Vout8N30zCmKiTqZFp0QqzwbDQ=
X-Google-Smtp-Source: ABdhPJzOPA/NRpY/RTLwDiRxWm/1V1xs18g+sY9xCAYyDnaBQLo7eCRkw0Dlh7wx148nsWTxL2CJxA==
X-Received: by 2002:a5d:5052:: with SMTP id h18mr23308901wrt.365.1621887550826;
        Mon, 24 May 2021 13:19:10 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:8954:39a5:6045:cd0c? (p200300ea8f384600895439a56045cd0c.dip0.t-ipconnect.de. [2003:ea:8f38:4600:8954:39a5:6045:cd0c])
        by smtp.googlemail.com with ESMTPSA id p6sm8788055wma.4.2021.05.24.13.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 13:19:10 -0700 (PDT)
Subject: [PATCH 11/13] eeprom: ee1004: Move call to ee1004_set_current_page to
 ee1004_eeprom_read
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <bd8439bc-3a6f-fd52-5fd1-bf9782061612@gmail.com>
Message-ID: <2829a131-51e3-8865-462a-564080158b0b@gmail.com>
Date:   Mon, 24 May 2021 22:16:51 +0200
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

Moving the call to ee1004_set_current_page() to ee1004_eeprom_read()
allows to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/misc/eeprom/ee1004.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index d18348ee4..65fe11d8f 100644
--- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -100,7 +100,14 @@ static int ee1004_set_current_page(struct device *dev, int page)
 static ssize_t ee1004_eeprom_read(struct i2c_client *client, char *buf,
 				  unsigned int offset, size_t count)
 {
-	int status;
+	int status, page;
+
+	page = offset >> EE1004_PAGE_SHIFT;
+	offset &= (1 << EE1004_PAGE_SHIFT) - 1;
+
+	status = ee1004_set_current_page(&client->dev, page);
+	if (status)
+		return status;
 
 	/* Can't cross page boundaries */
 	if (offset + count > EE1004_PAGE_SIZE)
@@ -119,12 +126,7 @@ static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
 {
 	struct i2c_client *client = kobj_to_i2c_client(kobj);
 	size_t requested = count;
-	int page, ret = 0;
-
-	page = off >> EE1004_PAGE_SHIFT;
-	if (unlikely(page > 1))
-		return 0;
-	off &= (1 << EE1004_PAGE_SHIFT) - 1;
+	int ret = 0;
 
 	/*
 	 * Read data from chip, protecting against concurrent access to
@@ -133,11 +135,6 @@ static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
 	mutex_lock(&ee1004_bus_lock);
 
 	while (count) {
-		/* Select page */
-		ret = ee1004_set_current_page(dev, page);
-		if (ret)
-			goto out;
-
 		ret = ee1004_eeprom_read(client, buf, off, count);
 		if (ret < 0)
 			goto out;
@@ -145,11 +142,6 @@ static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
 		buf += ret;
 		off += ret;
 		count -= ret;
-
-		if (off == EE1004_PAGE_SIZE) {
-			page++;
-			off = 0;
-		}
 	}
 out:
 	mutex_unlock(&ee1004_bus_lock);
-- 
2.31.1


