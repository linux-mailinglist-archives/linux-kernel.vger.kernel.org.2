Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A94B38F42D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 22:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhEXUU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 16:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbhEXUU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 16:20:27 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C987BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:18:58 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id i17so29778965wrq.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NOQumBJn9VkBWaI8qaCjgr6pHvvXb016yedMrhKyF8w=;
        b=icT5+/y2jW18SNnCc3JFS9cMx5yHxMLPDotvYpvlECAHtmMxFIT6yQuqiSOtYI58l+
         AkT+hHU3U6iRpmQ0/cvJnxNR67u+0c841e6HyIK54hV+kK6MpyOBqf4h113hCIBGeccg
         Ots3oF0hOFgrpnkfr212hph26rZm1cD4i8MXfO8UqkKGrE8AiUgc2FJqMzeP9TPs20tV
         5pK0DYQjLiQxIFi0rFL+G3q/1S3KFyytYgsEYNs3enOZmBmWpHaWWa810v1aomE976ce
         UhZswxuWgIoQ8FzXX8lVXPT/SPAxpod8ixPo+SF9KjvPfZkK0u9KsRJsOPHpubECSFU8
         uIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NOQumBJn9VkBWaI8qaCjgr6pHvvXb016yedMrhKyF8w=;
        b=TnqxunRPqPELP2CxshHZ/ugDMPDUFSTzktEax2TD3/PujJwDx8QsScpXejHzfe80ma
         KO7zLEnAJYJzxeUMFLpf8J6EYWeF72Yzd+TABTc40atUcECq4M4fNNIIXLmDVqFFyAkV
         osozbSnBf07vkuug9IhqDxUjULGMh/bgn6Gc6PT6uYUvP/ThrKrhTQM1O2JNo5bl9hXc
         HdCVEfyg9/EF5obNdZAY0jDs1GkBcgrRCqvhkAgprv2arnLmATWGa74s4WyAHeK7GwaT
         aLK9lUV2oHGTjFL6njr/4Xl1UAsxMAE9w6kjwwDYQ1VowQ7woXZEmfxns4uIUWAnmJA8
         VGXg==
X-Gm-Message-State: AOAM531qO+dEsEL7EaQMI7gT6Z5IWA7I78/RfULu2N0yfuyWXDo0IxO8
        JPC4ImO19qSgAmqPISe587jhQinZiiI=
X-Google-Smtp-Source: ABdhPJyRYhriGO9/1b+MIT1IA+EkkBk8F94MG9pHL21WV6ah1CANv3fknhOVoLGWtcsCmZwnQjHm1Q==
X-Received: by 2002:a5d:63c1:: with SMTP id c1mr23749337wrw.71.1621887537196;
        Mon, 24 May 2021 13:18:57 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:8954:39a5:6045:cd0c? (p200300ea8f384600895439a56045cd0c.dip0.t-ipconnect.de. [2003:ea:8f38:4600:8954:39a5:6045:cd0c])
        by smtp.googlemail.com with ESMTPSA id i5sm13834960wrw.29.2021.05.24.13.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 13:18:56 -0700 (PDT)
Subject: [PATCH 07/13] eeprom: ee1004: Switch to i2c probe_new callback
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <bd8439bc-3a6f-fd52-5fd1-bf9782061612@gmail.com>
Message-ID: <eb5be659-7427-46c5-66c2-b39650e08ea3@gmail.com>
Date:   Mon, 24 May 2021 22:13:52 +0200
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

Switch to the new i2c_driver probe callback version.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/misc/eeprom/ee1004.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index 4b2c60a18..460cc22ea 100644
--- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -163,8 +163,7 @@ static struct bin_attribute *ee1004_attrs[] = {
 
 BIN_ATTRIBUTE_GROUPS(ee1004);
 
-static int ee1004_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int ee1004_probe(struct i2c_client *client)
 {
 	int err, cnr = 0;
 
@@ -246,7 +245,7 @@ static struct i2c_driver ee1004_driver = {
 		.name = "ee1004",
 		.dev_groups = ee1004_groups,
 	},
-	.probe = ee1004_probe,
+	.probe_new = ee1004_probe,
 	.remove = ee1004_remove,
 	.id_table = ee1004_ids,
 };
-- 
2.31.1


