Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5291D38F42C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 22:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbhEXUU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 16:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbhEXUUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 16:20:25 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB25C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:18:55 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id z85-20020a1c7e580000b029017a76f3afbaso9044537wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xQlc8tARVgn3BkxKZGvc/b0C4fgQxiWTAh4JJvHHt0A=;
        b=R6jjatkjFZKspc3t/iaxMysJGwlu6wKpSLM6MqNe5TRMr9RYX41xfIvNf9ycVcZc9q
         WY41ZsJ9cHLe7GWKYj1FL7uheMPKrAIM1I1kU6HBpDRUjAU8k42uQ8j7Lx0G6Bl7h+/K
         NHQHli782YMrQHLov9nMjPwr2WrmCBS2E8gVjy84UWOj/qaxOoTw1xonfkWviCCi7NVF
         /xmMkS+y9ZgvgD3hzdurcYWTHhKh30mupuzJJG/CX8+IlzvwApuNQajylS5s9rAlODgS
         ITON0l9aYIulg4sIetnSLi9vLvqB13rUcHNDo6lru2M5qiezdJr4sZhrMeLPYbN1Oz7N
         5aFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xQlc8tARVgn3BkxKZGvc/b0C4fgQxiWTAh4JJvHHt0A=;
        b=KKqWQLjhqn5CXf/mIbpXcKppXEHK56ouiza77tc/cVBu7NqoyQsCQaKK/5+6rY3yGq
         XOTU3exxpVAwoOvXupQBhfzJ6OgAhGL735LYJxMZolzEwWtAjPGONv1SgjzQlLIqqQy0
         HZXJhwn0M4QdXcDa5akgyUy520t/aqw8hn+86l9iW7ou9rVU6F94aqQqzvTjL3lcQMh4
         2YgTRoxnAzxqR+gvLlugxJxXMve7dzCp2PsnJczwTQ9Cne+3o7zI7G4DTi6QPTEU3fHT
         rysYsanIhAYNjBggJ9hnHDB8saApnuXyEzmi09iJXKBBXPxU3rHaoS0CGhB9xrdR1zby
         mDVw==
X-Gm-Message-State: AOAM533auGgUOSQjVOQVas9vf6z3FsUwZO9FeHJ+9Grp2bvnT4eoPtuz
        4+0Q9k9vNntw/Q4vJ+gyYby/MRsGnxQ=
X-Google-Smtp-Source: ABdhPJyXKfexgFE50m0vHVbT+iAuJdoMwq+CumYZvxMD5yyPJCvsa0z3FHEqxufeyPikD7yyuvoTIQ==
X-Received: by 2002:a1c:a706:: with SMTP id q6mr617249wme.71.1621887533956;
        Mon, 24 May 2021 13:18:53 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:8954:39a5:6045:cd0c? (p200300ea8f384600895439a56045cd0c.dip0.t-ipconnect.de. [2003:ea:8f38:4600:8954:39a5:6045:cd0c])
        by smtp.googlemail.com with ESMTPSA id a129sm459750wmh.20.2021.05.24.13.18.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 13:18:53 -0700 (PDT)
Subject: [PATCH 06/13] eeprom: ee1004: Improve creating dummy devices
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <bd8439bc-3a6f-fd52-5fd1-bf9782061612@gmail.com>
Message-ID: <d38df5ac-6ecb-7d5f-b5c3-39bfc6a1e8a1@gmail.com>
Date:   Mon, 24 May 2021 22:13:12 +0200
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

i2c_new_dummy_device() calls i2c_new_client_device() that complains
if it fails to create the device. Therefore we don't have to emit an
error message in case of failure. In addition ensure that
ee1004_set_page is only set if creating the device succeeded.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/misc/eeprom/ee1004.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index 0d497e0e4..4b2c60a18 100644
--- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -179,15 +179,14 @@ static int ee1004_probe(struct i2c_client *client,
 	mutex_lock(&ee1004_bus_lock);
 	if (++ee1004_dev_count == 1) {
 		for (cnr = 0; cnr < 2; cnr++) {
-			ee1004_set_page[cnr] = i2c_new_dummy_device(client->adapter,
-						EE1004_ADDR_SET_PAGE + cnr);
-			if (IS_ERR(ee1004_set_page[cnr])) {
-				dev_err(&client->dev,
-					"address 0x%02x unavailable\n",
-					EE1004_ADDR_SET_PAGE + cnr);
-				err = PTR_ERR(ee1004_set_page[cnr]);
+			struct i2c_client *cl;
+
+			cl = i2c_new_dummy_device(client->adapter, EE1004_ADDR_SET_PAGE + cnr);
+			if (IS_ERR(cl)) {
+				err = PTR_ERR(cl);
 				goto err_clients;
 			}
+			ee1004_set_page[cnr] = cl;
 		}
 	} else if (client->adapter != ee1004_set_page[0]->adapter) {
 		dev_err(&client->dev,
-- 
2.31.1


