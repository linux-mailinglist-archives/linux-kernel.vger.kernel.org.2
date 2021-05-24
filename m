Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED4538F42E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 22:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbhEXUUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 16:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbhEXUUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 16:20:31 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE28C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:19:02 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m18so98810wrv.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JwtZW8eRduJOspdLgGY11jgEppqb/6/Mn7iOiLIV/10=;
        b=U9dCYLo7KDVCZVV4hrkivZa/cgLf6p5e3hnUOdm+KkJiZkJExhz2KLT+EXuT4pFa9H
         vOEGFrr0u32lmavSSNtmuLyXkoU54EjZuDAPj10qJTueP4T91JqrhASHFylcTf2zqV/y
         u6+kCV6wtY8ivOtyj1xQn6Y/HFElOny0JD0dQ6fvZEV2GB2HJ8KxPiFUWq8w+FT7crPM
         Prl0sYU6iiBwBMOhcMf8mIsa055gs9KPy9NXVxH0Sia1E9QRbAGka3fFF5k83Kk7350t
         0i4SFFhVnJsoD82EyuUYSHM8S+mYVwlxf50l83BrAzPHfmrdlGO7w2CyOQvgye7htdk1
         EmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JwtZW8eRduJOspdLgGY11jgEppqb/6/Mn7iOiLIV/10=;
        b=Ls7kGd3cD9a/Uu32758I9R9VLtXaBqQ7y1fc28OBdCojMwtkgE/AdkN2H6JYcGNvU8
         Tahd0Ib/4P2HIGsJZDsOQQmB6vzxBni2/4V/ZtK3alEchHTbyBaZpNym1NoVU9evvfWD
         xbFS4OhZH9krdrdhczPSsQq1o6CFyplFuXJEoLMNUqAhxidI8I6ZGjHnC5qxjGaP99XB
         BIJnN6yDpHTmz2Hzn8Djwz4RJ/izQEkvdpaJWhv3DfanfhORoRfFE99Rqe7TWJ3dKx5E
         7VQDY6+/UtxUF3sm7iig/Zh3/0hX+9IQr1Xz3IjephvYHHK4XYLFMfQSqhw6g8Cuck0q
         rFxw==
X-Gm-Message-State: AOAM533/fkJjSn3Zer7ROdMGks6TMZG31sPqWaqyAFdIpZdQDidWztz/
        k/D+nidBtT0rmUBy2oIQlHXYXEEcq+8=
X-Google-Smtp-Source: ABdhPJyOXP8yxtVSlZ5aKpa9Oc3RQprmiS0IQKTNZK+xEZxXUEeXYHgKvbiZhT4vkoUgnnlCDRt8Aw==
X-Received: by 2002:a5d:62d0:: with SMTP id o16mr24508888wrv.164.1621887540667;
        Mon, 24 May 2021 13:19:00 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:8954:39a5:6045:cd0c? (p200300ea8f384600895439a56045cd0c.dip0.t-ipconnect.de. [2003:ea:8f38:4600:8954:39a5:6045:cd0c])
        by smtp.googlemail.com with ESMTPSA id h8sm13375733wrw.85.2021.05.24.13.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 13:19:00 -0700 (PDT)
Subject: [PATCH 08/13] eeprom: ee1004: Cache current page at initialization of
 first device only
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <bd8439bc-3a6f-fd52-5fd1-bf9782061612@gmail.com>
Message-ID: <b9240e58-08bb-3d71-7a9c-9a323b470ab6@gmail.com>
Date:   Mon, 24 May 2021 22:14:43 +0200
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

The value of ee1004_current_page applies to all SPD eeproms connected
to the adapter. Therefore it's sufficient if we set ee1004_current_page
when the first device is added.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/misc/eeprom/ee1004.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index 460cc22ea..d7c693b26 100644
--- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -187,20 +187,19 @@ static int ee1004_probe(struct i2c_client *client)
 			}
 			ee1004_set_page[cnr] = cl;
 		}
+
+		/* Remember current page to avoid unneeded page select */
+		err = ee1004_get_current_page();
+		if (err < 0)
+			goto err_clients;
+		dev_dbg(&client->dev, "Currently selected page: %d\n", err);
+		ee1004_current_page = err;
 	} else if (client->adapter != ee1004_set_page[0]->adapter) {
 		dev_err(&client->dev,
 			"Driver only supports devices on a single I2C bus\n");
 		err = -EOPNOTSUPP;
 		goto err_clients;
 	}
-
-	/* Remember current page to avoid unneeded page select */
-	err = ee1004_get_current_page();
-	if (err < 0)
-		goto err_clients;
-	ee1004_current_page = err;
-	dev_dbg(&client->dev, "Currently selected page: %d\n",
-		ee1004_current_page);
 	mutex_unlock(&ee1004_bus_lock);
 
 	dev_info(&client->dev,
-- 
2.31.1


