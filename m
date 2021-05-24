Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C2F38F429
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 22:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbhEXUUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 16:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbhEXUUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 16:20:15 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1ABC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:18:45 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id n2so29884301wrm.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=23rteGegUlHTggOe+XdQ3mFcbGkqC9/JU3+UkJ+AdDw=;
        b=AKBTYirM+lU3E/J3fIOit0ayAjArUGEyuj/tDdc33A8qpLUK4NsskX2z3AuH/m3HXB
         wa/kDyx0DjrEgGhx+/Sr5TzdKl3BSZ24l8aXPb8ntXsg40NQmgMaHndfhhDP59MNlMze
         OqseXy/xT38w/14HFNf5iRUjJF1OFUypoXdIRgslw7ChgWjn/z3/KxIOpsUee2GCbGcj
         lAF2QF81Lur2AZ9Gm3bXM3eCU4pXKY7LIkzwiYiruAYvO3CW3OlW9RKsBphPWSi3eed7
         p16CSzt4vVEBY/OhWYz2OA+MTHlSRaZpCfOtJ1mcMbsNGZYtykoUYDI0zP+H9yEdqWue
         4MJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=23rteGegUlHTggOe+XdQ3mFcbGkqC9/JU3+UkJ+AdDw=;
        b=rqyIV7aO4DT0OZti1XMSpS8EtqwKLmpCC+HqpcafF7qZb2vnD01PIi0H4MycyL5iB/
         Zr6+adM9m3maFO2coHub+RnAsBiIdEuWIFsqJVL0+1+h+Esz5sYkJvBhSY9vXcpitIhV
         kZpCb9uDIwMFy66zd7WTHz/Jd3YpcVGTkl4zei2uXiRMalIXbE4FarBPvuRwW9D4dYhI
         t/MgjjH7A0wKejyQGnDcKbqd6B19rYsytGz3wOYpVcw4GXTqUr8E0SZa6MQmsufTbepA
         89exaeI9obscI2PQKMuwHKSkwTT0WFtVx2uzWh55aU2JeuSX+gqUxvMG1Ugyxj2v/wTH
         AfGw==
X-Gm-Message-State: AOAM533t8ldaJFd1MUK1P22zjf2dZg1r2cknO18elkSZY/S+B61HndzL
        lC08HP+P6/Nr3x9Qoqx0P/2lyW0OCtw=
X-Google-Smtp-Source: ABdhPJw1GAQcr+9sT2mGivqoJfXEu2/vwLgT8bUbeO4d7oUbVLKLY8uEzjacoM2P8iu8IKiKTmMnsw==
X-Received: by 2002:a05:6000:184a:: with SMTP id c10mr25090633wri.244.1621887523900;
        Mon, 24 May 2021 13:18:43 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:8954:39a5:6045:cd0c? (p200300ea8f384600895439a56045cd0c.dip0.t-ipconnect.de. [2003:ea:8f38:4600:8954:39a5:6045:cd0c])
        by smtp.googlemail.com with ESMTPSA id r17sm481913wmh.25.2021.05.24.13.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 13:18:43 -0700 (PDT)
Subject: [PATCH 03/13] eeprom: ee1004: Remove not needed check in
 ee1004_eeprom_read
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <bd8439bc-3a6f-fd52-5fd1-bf9782061612@gmail.com>
Message-ID: <eb2a8bff-43ec-c763-a417-9d741e6f0034@gmail.com>
Date:   Mon, 24 May 2021 22:10:47 +0200
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

i2c_smbus_read_i2c_block_data_or_emulated() checks its length argument,
so we don't have to do it. In addition remove the unlikely hint from
the checks, we do i2c reads and therefore are in a slow path.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/misc/eeprom/ee1004.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index 6aff333ff..2824dba76 100644
--- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -76,10 +76,8 @@ static ssize_t ee1004_eeprom_read(struct i2c_client *client, char *buf,
 {
 	int status;
 
-	if (count > I2C_SMBUS_BLOCK_MAX)
-		count = I2C_SMBUS_BLOCK_MAX;
 	/* Can't cross page boundaries */
-	if (unlikely(offset + count > EE1004_PAGE_SIZE))
+	if (offset + count > EE1004_PAGE_SIZE)
 		count = EE1004_PAGE_SIZE - offset;
 
 	status = i2c_smbus_read_i2c_block_data_or_emulated(client, offset,
-- 
2.31.1


