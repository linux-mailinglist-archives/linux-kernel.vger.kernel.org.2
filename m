Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE9838F430
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 22:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbhEXUUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 16:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbhEXUUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 16:20:35 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6772C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:19:05 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id t206so15519201wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sTZpYseXy602wLsTm2BMEC+/YBqFY1Dhqv7/G9VFzQw=;
        b=h7rpw8gu02FT4v9I+hQ5IWpqDXI4P1GbmmG/pt9Tl/x+2d3i+9RJK7smThrkjZFfLk
         tXq9l3B3rCShmJNDLQo5VFmB1XQ6En2eoNEFHbS1LmaezASU+gNIewqZ+RpnGfIdZO/n
         d1KDn2WfaeM8XETTVkNyGCPRi8MihaRbOOdo6J+5h3g+FAxEREapKX3ErJxoRd9GfjQX
         OOcR6WVmK2fGg1V7EdR/mu1kFsmcA0nsUQTVpP8cnGAgO011Pyq47lUqQNlM6PSDnkrS
         zHxiPPw1ziPubH4g/Y+ReY8qYsK/2eVo4gJtXdxHdnLomistbvGOgB05nSUfrZVZrQYB
         Zttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sTZpYseXy602wLsTm2BMEC+/YBqFY1Dhqv7/G9VFzQw=;
        b=s+JQ+1GJXgMbOhTKn5Gyg2DR9gEgoapBWXJbKdsihSNrodjOzCV3KzJmZZCQYY4oer
         WGaDCcjV4wRowtvuz3M9SPcAdxa+3JxNsDYdAIJvJkGIcngP5VmFO/lZ+rnN4n6qVMcU
         3YLidbyMFmHtz24NAqN7Pd9uslWy35JkTRi+fIuHLzsRaXOsXT808sgzIn/7HO1X4ZmF
         IVAt7evAkwRnwlsDpT2M0lRMY+AnNh9bLi8Mgw9utkB744IYBwLUTVEAWEplHIMNzSJF
         FgMulYnxoK0VimL03QpOY4RXjY8walhiHSkaUv3zpAtFenCD3is5jw2s6+MhDm9jsZsd
         Mfpw==
X-Gm-Message-State: AOAM531eIO+YMwy/KGmIonipWe+fBSmYnpFo0sg5HmoI6gvH9bP32xgy
        IkSt2pejhonYEteK89c/2laditOh+F0=
X-Google-Smtp-Source: ABdhPJxN50pv0768Xs1YOotE4TNN0TJ2opfYYU4nzpw5XJJh9vvsN8oLnWRAIsWVJgDgg59YlsmifA==
X-Received: by 2002:a05:600c:2054:: with SMTP id p20mr632997wmg.165.1621887544083;
        Mon, 24 May 2021 13:19:04 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:8954:39a5:6045:cd0c? (p200300ea8f384600895439a56045cd0c.dip0.t-ipconnect.de. [2003:ea:8f38:4600:8954:39a5:6045:cd0c])
        by smtp.googlemail.com with ESMTPSA id f20sm10001125wmh.41.2021.05.24.13.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 13:19:03 -0700 (PDT)
Subject: [PATCH 09/13] eeprom: ee1004: Factor out setting page to
 ee1004_set_current_page
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <bd8439bc-3a6f-fd52-5fd1-bf9782061612@gmail.com>
Message-ID: <21e0966f-e6c9-045f-b130-bd9fb071f0d7@gmail.com>
Date:   Mon, 24 May 2021 22:15:26 +0200
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

Factor out setting the page, this makes the code better readable.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/misc/eeprom/ee1004.c | 52 +++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index d7c693b26..33855e459 100644
--- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -71,6 +71,32 @@ static int ee1004_get_current_page(void)
 	return 0;
 }
 
+static int ee1004_set_current_page(struct device *dev, int page)
+{
+	int ret;
+
+	if (page == ee1004_current_page)
+		return 0;
+
+	/* Data is ignored */
+	ret = i2c_smbus_write_byte(ee1004_set_page[page], 0x00);
+	/*
+	 * Don't give up just yet. Some memory modules will select the page
+	 * but not ack the command. Check which page is selected now.
+	 */
+	if (ret == -ENXIO && ee1004_get_current_page() == page)
+		ret = 0;
+	if (ret < 0) {
+		dev_err(dev, "Failed to select page %d (%d)\n", page, ret);
+		return ret;
+	}
+
+	dev_dbg(dev, "Selected page %d\n", page);
+	ee1004_current_page = page;
+
+	return 0;
+}
+
 static ssize_t ee1004_eeprom_read(struct i2c_client *client, char *buf,
 				  unsigned int offset, size_t count)
 {
@@ -110,28 +136,10 @@ static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
 		int status;
 
 		/* Select page */
-		if (page != ee1004_current_page) {
-			/* Data is ignored */
-			status = i2c_smbus_write_byte(ee1004_set_page[page],
-						      0x00);
-			if (status == -ENXIO) {
-				/*
-				 * Don't give up just yet. Some memory
-				 * modules will select the page but not
-				 * ack the command. Check which page is
-				 * selected now.
-				 */
-				if (ee1004_get_current_page() == page)
-					status = 0;
-			}
-			if (status < 0) {
-				dev_err(dev, "Failed to select page %d (%d)\n",
-					page, status);
-				mutex_unlock(&ee1004_bus_lock);
-				return status;
-			}
-			dev_dbg(dev, "Selected page %d\n", page);
-			ee1004_current_page = page;
+		status = ee1004_set_current_page(dev, page);
+		if (status) {
+			mutex_unlock(&ee1004_bus_lock);
+			return status;
 		}
 
 		status = ee1004_eeprom_read(client, buf, off, count);
-- 
2.31.1


