Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2E038F427
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 22:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbhEXUUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 16:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbhEXUUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 16:20:11 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363E8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:18:42 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u133so15494273wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 13:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UWbc3A4xusH+l3GuJO5/5GzRqV+bUKZhUJbaZCD33Jk=;
        b=AKIxhBz0N99dRPbNSo9mylWCbyKtAQ4iSuBloRrSSZtBAEF1FQe4Wk05Y55ZBjC9xW
         vt1EPeVicTJsyH2Yc0uqxv0TiIii5sP/WeSl+1pfE3Aqx0dheXeNySngAd1ILUYp0k7D
         X11wuX3qzZ1VKS0y1Inr0uj8tC0mcuTrUHsf5wQZjzn+RHIu6eUTFat5UwYzJ9G15iyK
         pqfWGXkN1/jDbKutN2FPXG2NNZhRdqaHWAVpjq8CX6gv9LBXRhTgK7oOCirHx5qGdETq
         LEJZWY0nZuPV53NCOyz6O9H3BxYOKK+70/+zkn4KJ1dQr5fkXwAZTSX8K/OA9UknuDil
         cx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UWbc3A4xusH+l3GuJO5/5GzRqV+bUKZhUJbaZCD33Jk=;
        b=A1yhTw5elf3HQ3Fx3ICjSyHFTUYy5ErKUsPojmfx/73X+68FsEMOkneYEaHWgYtAwL
         XR26jaZYkyhcU4+ON4a90DfByMFBrrGLBEjkJ92NHMSk+9pWofL+xipyyLV/oMP10VKk
         IvC390MJftwU6NXsl92z8OOWd3I8dizzlvANLDXaPL0GG02Krg+7Xi+A/i7C2e5j7+i1
         zlYKfjQUw8XWN7IpjeHdlCk9ke8u8UOTuxqs6jv9kKRCA1l+815bArN2Tj0LLYPUWofz
         bp7LBQQbDnHVUpxQ6elL+xIeeOW/+TrYcdUBRelbOePbRFUxoPt+wle9jEcsruG4837L
         fgGQ==
X-Gm-Message-State: AOAM532s9IoDLLIivcFCyz+P6jsRmJQm28Zb9yQHBYtZSZQos7PgZQtS
        wr3wcN4OHqFlz5anx43NqcpIIL4ccmw=
X-Google-Smtp-Source: ABdhPJx7ekWYOZ6MJcEGsbwb//Kl4wklCL5ZisdMHh9TpZp6RobM69Dj4idszepXaD2pgEaJVr5Dkg==
X-Received: by 2002:a1c:7909:: with SMTP id l9mr646897wme.129.1621887520558;
        Mon, 24 May 2021 13:18:40 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:8954:39a5:6045:cd0c? (p200300ea8f384600895439a56045cd0c.dip0.t-ipconnect.de. [2003:ea:8f38:4600:8954:39a5:6045:cd0c])
        by smtp.googlemail.com with ESMTPSA id i5sm13834332wrw.29.2021.05.24.13.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 13:18:40 -0700 (PDT)
Subject: [PATCH 02/13] eeprom: ee1004: Remove not needed check in ee1004_read
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <bd8439bc-3a6f-fd52-5fd1-bf9782061612@gmail.com>
Message-ID: <33889bff-3614-4b73-5010-701635e1edab@gmail.com>
Date:   Mon, 24 May 2021 22:09:49 +0200
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

sysfs_kf_bin_read() checks this for us already. In addition
the function works correctly also w/o this check.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/misc/eeprom/ee1004.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index 0613a5300..6aff333ff 100644
--- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -97,9 +97,6 @@ static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
 	size_t requested = count;
 	int page;
 
-	if (unlikely(!count))
-		return count;
-
 	page = off >> EE1004_PAGE_SHIFT;
 	if (unlikely(page > 1))
 		return 0;
-- 
2.31.1


