Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641B238F433
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 22:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbhEXUUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 16:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbhEXUUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 16:20:45 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C17C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:19:15 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v12so29799835wrq.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=314BWT6ReNpX64xfzwPOPzsOErzWYGwuyaDMK6UxMAY=;
        b=cinWk0xSikm/i5HkG2ZeHASnCECXUJ3AnO1xXCvUXfkvbh5smk0Iu792OEtAUspHY6
         VK0wH2AhxDW6Ret0kzu5In4B19fh5wsaENh8NWgEOGZeur5S4mtLOCzN4Lm7+24wHq8n
         y5RUeAUmMn9Yc+4FwOgkC6KfdvPo/agHmycpUIX7lfYvXLZ4BeO9astbaVh1IiZZqhql
         H8WlnevjJN3cJmrA4i9fo0it78lIK2hXZ5o93OD6o8rOdefned0TKl60IllBvqQCKmXb
         1rks3yrd2VQKVoRBnXxKrWUghtoJ4WAFpHrpd3H8VsFj1nIx3g5kZIug+H86SZYfWlv1
         1FAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=314BWT6ReNpX64xfzwPOPzsOErzWYGwuyaDMK6UxMAY=;
        b=L/l/5S0Iidi0IwkqxAb/+6ZqDFuJOS9v6PliXL01bca4XeT1qoe0I1xhKDESXsLy6n
         Hay1C8oxvjpAlfWvtK9zj7CxqkFtXDOPpfeFlHCGv6jD/wgV991h9B47hKOXRdsght6k
         ENnN0v8vRmKdYWc8Eb0hpP1lFmKMnQU9OFJoHECT0b8dlXuF0oM0IA3cKZLofIMZBPoy
         jM1OmorIcCnIUsl6Mxk5xZAFurVDr9OC5w/I3K9BVJdpctQmto1Ryln+8y79dk174ilv
         LJWALQgiTVhAxeSo25mpfugB3IYeK6A1ZWKuBDqtOVl5vAxC7nsrh+qRMb9N0nIh6Ibp
         Faxg==
X-Gm-Message-State: AOAM531EfPD2vonF3ifZmyHwJ7a93XtG2jKBpaaV/3yn4MwZ7W4ezrKl
        VMsm5pHQdltgUmaLqLnwrTjVWwQvsgU=
X-Google-Smtp-Source: ABdhPJy2FxGflgxYUXHcbbcgUBUegjDdHMHILH05tqArGixyy5tlPLOTChif17aWfHV0/3CtBkeLpg==
X-Received: by 2002:a5d:59ae:: with SMTP id p14mr23594198wrr.214.1621887554101;
        Mon, 24 May 2021 13:19:14 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:8954:39a5:6045:cd0c? (p200300ea8f384600895439a56045cd0c.dip0.t-ipconnect.de. [2003:ea:8f38:4600:8954:39a5:6045:cd0c])
        by smtp.googlemail.com with ESMTPSA id d9sm12993764wrx.11.2021.05.24.13.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 13:19:13 -0700 (PDT)
Subject: [PATCH 12/13] eeprom: ee1004: Add constant EE1004_NUM_PAGES
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <bd8439bc-3a6f-fd52-5fd1-bf9782061612@gmail.com>
Message-ID: <6167f9c5-995a-03c3-c324-e93e2a6c969b@gmail.com>
Date:   Mon, 24 May 2021 22:17:28 +0200
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

Add a constant for the number of pages.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/misc/eeprom/ee1004.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index 65fe11d8f..5173d040c 100644
--- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -32,16 +32,17 @@
  */
 
 #define EE1004_ADDR_SET_PAGE		0x36
-#define EE1004_EEPROM_SIZE		512
+#define EE1004_NUM_PAGES		2
 #define EE1004_PAGE_SIZE		256
 #define EE1004_PAGE_SHIFT		8
+#define EE1004_EEPROM_SIZE		(EE1004_PAGE_SIZE * EE1004_NUM_PAGES)
 
 /*
  * Mutex protects ee1004_set_page and ee1004_dev_count, and must be held
  * from page selection to end of read.
  */
 static DEFINE_MUTEX(ee1004_bus_lock);
-static struct i2c_client *ee1004_set_page[2];
+static struct i2c_client *ee1004_set_page[EE1004_NUM_PAGES];
 static unsigned int ee1004_dev_count;
 static int ee1004_current_page;
 
@@ -172,7 +173,7 @@ static int ee1004_probe(struct i2c_client *client)
 	/* Use 2 dummy devices for page select command */
 	mutex_lock(&ee1004_bus_lock);
 	if (++ee1004_dev_count == 1) {
-		for (cnr = 0; cnr < 2; cnr++) {
+		for (cnr = 0; cnr < EE1004_NUM_PAGES; cnr++) {
 			struct i2c_client *cl;
 
 			cl = i2c_new_dummy_device(client->adapter, EE1004_ADDR_SET_PAGE + cnr);
@@ -222,7 +223,7 @@ static int ee1004_remove(struct i2c_client *client)
 	/* Remove page select clients if this is the last device */
 	mutex_lock(&ee1004_bus_lock);
 	if (--ee1004_dev_count == 0) {
-		for (i = 0; i < 2; i++) {
+		for (i = 0; i < EE1004_NUM_PAGES; i++) {
 			i2c_unregister_device(ee1004_set_page[i]);
 			ee1004_set_page[i] = NULL;
 		}
-- 
2.31.1


