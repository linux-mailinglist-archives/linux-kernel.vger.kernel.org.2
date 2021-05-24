Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D5738F42B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 22:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbhEXUUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 16:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbhEXUUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 16:20:21 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228EEC06138A
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:18:52 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n2so29884528wrm.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=etJ65wR/7ffFEDDLcvPy/Qu07Bl710LAOIdAHtkuCeM=;
        b=gq6JiE1im0HebYBrEyuy/3pKFXTyttPtSdXr9DHY71r3RuFzjtZe3CbE791EI4K3nV
         w/R99jRsllQK10eTM/38aAjYVhW2eWAbb05JaJxnBV/B4opYLC88rxp31JSTGYro9XMJ
         Mf+6813quo7nSJB+AV0gwKx1rijrmGM2ko/0IyxJLmwCzp08UkT6jOipR4K3/2vfFe+u
         AMqL3cAuHX00I8I3u1jbOyAWgSK8mIMM0Jea0EQvaAThpLXPtwSyalzHq+yaM1xi/zs/
         yec4yOHL3Xanh7JwlgFrpncRkVEcQFeJQE47mhR9N0dkmMJGpWRcmwmAF8IlNO7nljml
         WXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=etJ65wR/7ffFEDDLcvPy/Qu07Bl710LAOIdAHtkuCeM=;
        b=XXpe7SlknLAcf3iZ5NbT94+p1IWg4YRLUIhhAM0R+htLlEZiRPj85R2m77yqYYrXnZ
         kUXP3HqnOZYqE5B1mR6W1ybceHyGb35DbttN2sSDdPbt4Z79xoNeXQ3Ed95dspKsGuER
         6plysFS96cqQxOBpDCMFNgeYAdpyn1+lhZ0v/in83142zlKasGFJS3WwVXVpqG4c4Qhw
         7lYfubtvnVYVqvTsTjDGEE2T/pIX0wPVrmettlHbvTZiwltgsGJx59omS1d1f1YTPtGx
         XGECAxpVbzcjy/nswx6AuJfkNuP5PgWyI9PKDNJYDNu+jOQkenhci/RNuJcKu6uhAw32
         SqNA==
X-Gm-Message-State: AOAM532YRoVpw19vEi6JQhhSjxLzR2nVmFecCGGbzuRYarLnWyi//zW5
        xj8pjo5QyxZLfbnEnvBJY+yPyiNG7vs=
X-Google-Smtp-Source: ABdhPJwXn6Pb8nTqHuEVejxkVdL21lCAfqbMavJwMBJBrVy/g0I9i1At7zdRHwrY0nJcdzOo/lC3zQ==
X-Received: by 2002:a05:6000:508:: with SMTP id a8mr23699201wrf.315.1621887530463;
        Mon, 24 May 2021 13:18:50 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:8954:39a5:6045:cd0c? (p200300ea8f384600895439a56045cd0c.dip0.t-ipconnect.de. [2003:ea:8f38:4600:8954:39a5:6045:cd0c])
        by smtp.googlemail.com with ESMTPSA id h1sm505474wmq.0.2021.05.24.13.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 13:18:50 -0700 (PDT)
Subject: [PATCH 05/13] eeprom: ee1004: Improve check for SMBUS features
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <bd8439bc-3a6f-fd52-5fd1-bf9782061612@gmail.com>
Message-ID: <840c668e-6310-e933-e50e-5abeaecfb39c@gmail.com>
Date:   Mon, 24 May 2021 22:12:22 +0200
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

We have to read 512 bytes only, therefore read performance isn't really
a concern. Don't bother the user if i2c block read isn't supported.

For i2c_smbus_read_i2c_block_data_or_emulated() to work it's sufficient
if I2C_FUNC_SMBUS_READ_I2C_BLOCK or I2C_FUNC_SMBUS_READ_BYTE_DATA is
supported. Therefore remove the check for I2C_FUNC_SMBUS_READ_WORD_DATA.

In addition check for I2C_FUNC_SMBUS_WRITE_BYTE (included in
I2C_FUNC_SMBUS_BYTE) which is needed for setting the page.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/misc/eeprom/ee1004.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index b991ab250..0d497e0e4 100644
--- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -167,23 +167,13 @@ static int ee1004_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	int err, cnr = 0;
-	const char *slow = NULL;
 
 	/* Make sure we can operate on this adapter */
 	if (!i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_READ_BYTE |
-				     I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
-		if (i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_READ_BYTE |
-				     I2C_FUNC_SMBUS_READ_WORD_DATA))
-			slow = "word";
-		else if (i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_READ_BYTE |
-				     I2C_FUNC_SMBUS_READ_BYTE_DATA))
-			slow = "byte";
-		else
-			return -EPFNOSUPPORT;
-	}
+				     I2C_FUNC_SMBUS_BYTE | I2C_FUNC_SMBUS_READ_I2C_BLOCK) &&
+	    !i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_BYTE | I2C_FUNC_SMBUS_READ_BYTE_DATA))
+		return -EPFNOSUPPORT;
 
 	/* Use 2 dummy devices for page select command */
 	mutex_lock(&ee1004_bus_lock);
@@ -218,10 +208,6 @@ static int ee1004_probe(struct i2c_client *client,
 	dev_info(&client->dev,
 		 "%u byte EE1004-compliant SPD EEPROM, read-only\n",
 		 EE1004_EEPROM_SIZE);
-	if (slow)
-		dev_notice(&client->dev,
-			   "Falling back to %s reads, performance will suffer\n",
-			   slow);
 
 	return 0;
 
-- 
2.31.1


