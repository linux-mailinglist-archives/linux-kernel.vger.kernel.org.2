Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6914393F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236381AbhE1JIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236554AbhE1JIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:08:14 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D515C06138F
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:06:36 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o127so1691881wmo.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yCHwgdsgQ6fJQNC1IP1vbSWWrvc2ky/5/NAN71BbxeE=;
        b=PG5t4BCUUCZooJ+B3jhYXhsmN9ESA6HHKQ7dYImvqyNpS4TK5JYGjV8uPIJjAcZUB6
         Z1OF0JP58MOJBdVS8ccjTb6NLQpUTTBBPppVoFhTF8iMIlqlflIXbN/mbzSSl+yRSha4
         7/HGmym0jQn/uMk2ST2NDNGGCcI5suIHkdBE/jORz5P8NMOoLpt5QvQ3v0D5tFtnUAUA
         ue6n4vvDmpkRlQNbEVaYCVJBrxWAtIB//7yDgx2xdsvooR0ZUouAoOQFD4guyuRGPkuK
         kBpleCuybKvFmTzIEffaIEznno/uMEmQK2ECSQ6AR4Q4o9c/Vs1Jmjjn0wOK56wAMYfP
         xiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yCHwgdsgQ6fJQNC1IP1vbSWWrvc2ky/5/NAN71BbxeE=;
        b=e2134Py86U1AbxpzhOCtsGHH44xNh7hxJKZbcdUwiJ8s3P+7hRzsLvOQPd7zQ9VFz0
         fa5WnRgzifOvJdST9rHWvDkUCA9azj+RU8fVPgYDFvlUbKmLiNmLEQMBwtYOvddxcdYI
         mZT1pJ028O9DrLiFS+spzDoHiAA/yRGVfD50BceKjC7HcbSbJeKQUVlzSqyRS4MWFtYe
         lBwVKXFqIs4gqg52r0s9KlGBXNaIq5SvvlNvSt9JVvkczWG6Wag7UeUjookgsn0imLHx
         OSXGSRwGgd3pd+OpSeDIVwjuCNAZpKFZO3jJEAXabfQ/IM5wZhrFnFsds2UpGOgyz1+i
         iQLA==
X-Gm-Message-State: AOAM533KJSAooGPMtzoxuTwzHhzXmk5xivcPUaqLQwWhw4dvNF5uA3n8
        MnLCgpavT0jmcIa2927sOEJYfw==
X-Google-Smtp-Source: ABdhPJxyfm6pDw+DMnxXCmn5D2PdL8QainP2YGqTXuiWGdEN+yP7MpJAKHmRyYINo5bQCc/bXzTW3A==
X-Received: by 2002:a1c:6782:: with SMTP id b124mr12124040wmc.159.1622192795140;
        Fri, 28 May 2021 02:06:35 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id m132sm6105911wmf.11.2021.05.28.02.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:06:34 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        John Lenz <lenz@cs.wisc.edu>,
        Richard Purdie <rpurdie@openedhand.com>,
        linux-leds@vger.kernel.org
Subject: [PATCH 03/15] leds: led-class: Fix incorrectly documented param 'dev'
Date:   Fri, 28 May 2021 10:06:17 +0100
Message-Id: <20210528090629.1800173-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528090629.1800173-1-lee.jones@linaro.org>
References: <20210528090629.1800173-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/leds/led-class.c:521: warning: Function parameter or member 'dev' not described in 'devm_led_classdev_unregister'
 drivers/leds/led-class.c:521: warning: Excess function parameter 'parent' description in 'devm_led_classdev_unregister'

Cc: Pavel Machek <pavel@ucw.cz>
Cc: John Lenz <lenz@cs.wisc.edu>
Cc: Richard Purdie <rpurdie@openedhand.com>
Cc: linux-leds@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/leds/led-class.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index 2e495ff678562..16271a1de12a7 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -513,7 +513,7 @@ static int devm_led_classdev_match(struct device *dev, void *res, void *data)
 
 /**
  * devm_led_classdev_unregister() - resource managed led_classdev_unregister()
- * @parent: The device to unregister.
+ * @dev: The device to unregister.
  * @led_cdev: the led_classdev structure for this device.
  */
 void devm_led_classdev_unregister(struct device *dev,
-- 
2.31.1

