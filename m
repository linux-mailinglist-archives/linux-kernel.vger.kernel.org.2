Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E2C3EBA37
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 18:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbhHMQlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 12:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbhHMQlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 12:41:22 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2874FC061756;
        Fri, 13 Aug 2021 09:40:55 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id o1-20020a05600c5101b02902e676fe1f04so8012745wms.1;
        Fri, 13 Aug 2021 09:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=bg+ey9jn4eCnxo8lKaJlDWoU38GqGlmQ73XY5Oghpto=;
        b=m38Siw5Gbam+IOURK2ZK13+BuFuM7+/tFvcTXm9BY15+1V/J1ZyOUbcNLgReI4RxhF
         9A8pLcmDVKdMWWyVLLrP8Oyxgpg9ynvWY7RKdBwD7wv7cLhyXgNIK4qiA8NzdTsuhY5T
         qYSYWzGi6aLBoH8iZtOVKt7ErSklgGcF5e07tUPodZK6Lu4Sorr8vCe80eN3cOLibEww
         Rd7NSCnJ4HiTqtYBbklf4sZBtzIDi3AjZCRdD2YPMvykbkPYKehlFGEZTV++67itIz2e
         4xscEI4oG8Ko3tX989VL64qj68tmH+gi1LzHBQABRWTmt+HsW0+hkKCuVpDRSh1CCG6R
         ZzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=bg+ey9jn4eCnxo8lKaJlDWoU38GqGlmQ73XY5Oghpto=;
        b=Gc7ofzeH0bMKjo6dAXY3X8imLRHmeJ3d7HhHBVjPutT19v7gV1O4t7YpNstXOT3cQo
         6vS2tTO9YIQGfzVQAA5MKBTJetOy1GA4yUOvXZQmUGUQlcfLmrQjIGjypTgpqJMK/JWC
         R+lfs9KTaePUyEXIUIMuU6Y9ZDSGlpMAYz1BGXYI6iS/daE6LRsDG1jEAbrvWN/tVxVm
         33JmSkYGSShBeZbSJlCZv5p80GzWfkRMTAON5QPP5D0He2k7j3MrtNi9ewX/zoXhpWWc
         srx3lyhAlXNy7JK56RTeEzM6jzQ6zKgXxdef8A+rkNdZklRaaSFiTCWdxNyh9zr8w9Cb
         xCJA==
X-Gm-Message-State: AOAM5317ueZAId8/I6HjyvJfVRRujEaJGaSAhjjevN6eQiuNb8xC00b6
        uYaL5F4T34QviIkkmFub0CM=
X-Google-Smtp-Source: ABdhPJzCZ3PjZwkwgGlym/w7aSXNOaeG10yp53D1PQCiuWJrE9C6Z+K4OrGRZPJRl+8GROCG5tRrTw==
X-Received: by 2002:a1c:9a8b:: with SMTP id c133mr3474079wme.103.1628872853722;
        Fri, 13 Aug 2021 09:40:53 -0700 (PDT)
Received: from pc ([196.234.235.93])
        by smtp.gmail.com with ESMTPSA id d13sm1604669wra.70.2021.08.13.09.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 09:40:53 -0700 (PDT)
Date:   Fri, 13 Aug 2021 17:40:49 +0100
From:   Salah Triki <salah.triki@gmail.com>
To:     Keith Packard <keithp@keithp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: misc: chaoskey: remove useless else
Message-ID: <20210813164049.GA2310720@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove useless else in order to make the code cleaner.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/usb/misc/chaoskey.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/misc/chaoskey.c b/drivers/usb/misc/chaoskey.c
index 87067c3d6109..9814ac2201d5 100644
--- a/drivers/usb/misc/chaoskey.c
+++ b/drivers/usb/misc/chaoskey.c
@@ -299,14 +299,11 @@ static int chaoskey_release(struct inode *inode, struct file *file)
 
 	--dev->open;
 
-	if (!dev->present) {
-		if (dev->open == 0) {
-			mutex_unlock(&dev->lock);
+	mutex_unlock(&dev->lock);
+
+	if (!dev->present)
+		if (dev->open == 0)
 			chaoskey_free(dev);
-		} else
-			mutex_unlock(&dev->lock);
-	} else
-		mutex_unlock(&dev->lock);
 
 	usb_dbg(interface, "release success");
 	return 0;
-- 
2.25.1

