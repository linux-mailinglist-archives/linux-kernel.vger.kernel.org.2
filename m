Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194E4396E38
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 09:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbhFAHw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 03:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbhFAHw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 03:52:26 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E611C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 00:50:45 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v23so10853989wrd.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 00:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=XKr3H3uJkyV5LuKghpeNT7gOFS0pnfy9hiDo8gxhRAQ=;
        b=L2UZ9yeKIq86kO9Z99i+GQ1Oy8kKXp65USmrYkQKg0r5gZ5q1Rkd/BLtHT0aw/8FrW
         fEO0Uy7LTD0thOlhUYqGo7hgfggQwvsmMsAvynq0dY+jgfAi2khEddTm4bNBzqpRjiuK
         3psbuLAbqh1K67SQHosFGAKZ0LXr15pmWe9MIYFfEzYMSQq1HhmxGAUb6zhSQbEdlLLe
         AuFRYcZ6XPltlasUw7/oNvA5aJEPRj3U+0mz3go7U8oRUF3vPKsMB6dOnfeJ2J8wsOJS
         wU4y/lyrlo3IGn7Te8R3dqjtgY1+43nUfi4LK1MLlOuDRnIjccQMyWJecFsGKg98MsWs
         JmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=XKr3H3uJkyV5LuKghpeNT7gOFS0pnfy9hiDo8gxhRAQ=;
        b=J5LD/9U1dx508xjKR0Gs3xyxVpaf7fSRSoC6q2jeGYfTXuQF3MppIy4qno9WvbtqHx
         zBxy2bkTr4/ghPfhC2lD5NTNBXV4p5O3hp3zWxdBG/blFpycSz34cHoRMHNfh0OvX0eX
         Vam/Dhwd4d+reBUGxs5xJ3m9jpvoGc5PNsqdwtcQjKWfUwqHCTKJlFEnRjbNzw47Ug65
         2gaLc9/uaFAgpQ7UV8C/QdGayRWapfTiLztIl159H4AILKJ0eM13I90lr4y29zXHYqw5
         VWSlP7tFrimPgoGPSVv1j5F9eSwQPa9fGjdEHRL83ewbfNLtr0RIr9iVxalu8E7UgjeE
         3qvg==
X-Gm-Message-State: AOAM533Q536fq9aGQ4vcvtPnm4EvmWO+K5QFi56BEvy/AUGmYS19k8H8
        acyWd0E7OnVpSizRJCmnOXy4ocYvh1Y=
X-Google-Smtp-Source: ABdhPJywEXF48GKsPcWm/7j1E2lkNfq1mdhy6btUYxN3qn9MnW9PWf1zdW7w49WV6zYpaP04mJuYKg==
X-Received: by 2002:adf:efca:: with SMTP id i10mr12390028wrp.139.1622533843667;
        Tue, 01 Jun 2021 00:50:43 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f2f:c00:7413:c444:b8f3:1878? (p200300ea8f2f0c007413c444b8f31878.dip0.t-ipconnect.de. [2003:ea:8f2f:c00:7413:c444:b8f3:1878])
        by smtp.googlemail.com with ESMTPSA id h13sm18111785wml.26.2021.06.01.00.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 00:50:43 -0700 (PDT)
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] eeprom: ee1004: Remove not needed debug message
Message-ID: <6169f52e-6ede-d7cc-7f8b-cced55b693d0@gmail.com>
Date:   Tue, 1 Jun 2021 09:50:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a user is interested in such transfer statistics he can simply
switch on smbus tracing.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/misc/eeprom/ee1004.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index 00f61a83d..bb9c4512c 100644
--- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -114,11 +114,7 @@ static ssize_t ee1004_eeprom_read(struct i2c_client *client, char *buf,
 	if (offset + count > EE1004_PAGE_SIZE)
 		count = EE1004_PAGE_SIZE - offset;
 
-	status = i2c_smbus_read_i2c_block_data_or_emulated(client, offset,
-							   count, buf);
-	dev_dbg(&client->dev, "read %zu@%d --> %d\n", count, offset, status);
-
-	return status;
+	return i2c_smbus_read_i2c_block_data_or_emulated(client, offset, count, buf);
 }
 
 static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
-- 
2.31.1

