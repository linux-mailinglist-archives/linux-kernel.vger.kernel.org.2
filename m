Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4D93ED1B9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 12:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbhHPKPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 06:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhHPKO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 06:14:59 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E416AC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 03:14:27 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n12so19506475plf.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 03:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7lBav3BiTSHLqodpKTwEx5kosNYnKYUMB4CDNs59htE=;
        b=G9o8UuC+GwLrBXxScll6XnRHsD1N3zo8VSdXUWSO9d9GGTZXqJL4YBRJsEY9VB5zAf
         pMcK2XtoOqUbhESubnhR6EjH98pz0uDEuVfLjWJlgwMqJLISlN121rx9fael6vaEtBsP
         TBP304OLPlVgUlfY/+UL02BS0UOaZ0h/zrKXnCIfmZgk3yS8jzuZu5xxYEJxEq0diiK3
         YNs2wETT+THIUUX8UbRX9EqbHlHnX3Q2VV0k77qrbzHL2k1FswCTwSxprbuGuBlMaQeb
         mCGnvoGzxTDsArRb0gq+aXRL+LvBy6z5acuCDWbkOSqJKwk9a4CcH4oQJ84qlwfghLse
         9Ptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7lBav3BiTSHLqodpKTwEx5kosNYnKYUMB4CDNs59htE=;
        b=FzwLN9zWm3biV4/P4PEM3p9FAnnWEpO3UPPwSGgwybvDP7u1Db7Mtqnt2CtomQG26p
         Ambcm7Rrm7E/w9Uie1K0liUH5XSRwQIKZeB/ALaboI6sR3cNQBPA6/5CJYlqQFZQK4GM
         Ursonteb/qqG+1YXBCKLp0GHczwlaDr2118s8FBvc+jpcv9rAY8rwIhYptgE4gWaqzHZ
         cKt++Qe8WmB36wNeWk3WBXLW1EAYy/SGX+boAxh0wwsvEqISle3no2EyHfUnxpk9H132
         iUOSiGHL2vRMDjphFZ65x1Lc0qjVGPDcVekNRk7HmufwixQrsYBNPulFNu2vtJDxPlt0
         Xdjg==
X-Gm-Message-State: AOAM530WOal67qzp5liWkp8tX4+/O+WBWPIEO9BUfCusbDpkERuRCpO4
        uX266F8xn9g72i6BGLz1WddzOGDEmBA=
X-Google-Smtp-Source: ABdhPJzzm70wm4zcGgTAvB56PJrhMb0g0TdKk0KGgZ5Qmv1YwjG50tjG6kSAPy+b7K9zNJMX4AyiWA==
X-Received: by 2002:a17:90a:e018:: with SMTP id u24mr16558665pjy.126.1629108867525;
        Mon, 16 Aug 2021 03:14:27 -0700 (PDT)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id 65sm12773508pgi.12.2021.08.16.03.14.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Aug 2021 03:14:26 -0700 (PDT)
From:   Jiazi Li <jqqlijiazi@gmail.com>
X-Google-Original-From: Jiazi Li <lijiazi@xiaomi.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiazi Li <lijiazi@xiaomi.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] char: misc: init list head only when needed
Date:   Mon, 16 Aug 2021 18:12:32 +0800
Message-Id: <853e8529c18c4a71c36b49f9598961fbc3f39682.1628921932.git.lijiazi@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a module successfully registers a misc device.
Then, due to some bugs, use same address register misc device
again, init list head will corrupt misc_list, resulting in oops
when using misc_list.

In this scenario, do not init list head, if registration is
successful, init list head is also not required.

Signed-off-by: Jiazi Li <lijiazi@xiaomi.com>
---
 drivers/char/misc.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index ca5141e..2451640 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -176,7 +176,6 @@ int misc_register(struct miscdevice *misc)
 	int err = 0;
 	bool is_dynamic = (misc->minor == MISC_DYNAMIC_MINOR);
 
-	INIT_LIST_HEAD(&misc->list);
 
 	mutex_lock(&misc_mtx);
 
@@ -185,7 +184,7 @@ int misc_register(struct miscdevice *misc)
 
 		if (i >= DYNAMIC_MINORS) {
 			err = -EBUSY;
-			goto out;
+			goto err2;
 		}
 		misc->minor = DYNAMIC_MINORS - i - 1;
 		set_bit(i, misc_minors);
@@ -195,7 +194,13 @@ int misc_register(struct miscdevice *misc)
 		list_for_each_entry(c, &misc_list, list) {
 			if (c->minor == misc->minor) {
 				err = -EBUSY;
-				goto out;
+				/*
+				 * if module use same address double register,
+				 * init list will corrupt misc_list
+				 */
+				if (c == misc)
+					goto err1;
+				goto err2;
 			}
 		}
 	}
@@ -214,7 +219,7 @@ int misc_register(struct miscdevice *misc)
 			misc->minor = MISC_DYNAMIC_MINOR;
 		}
 		err = PTR_ERR(misc->this_device);
-		goto out;
+		goto err2;
 	}
 
 	/*
@@ -222,7 +227,11 @@ int misc_register(struct miscdevice *misc)
 	 * earlier defaults
 	 */
 	list_add(&misc->list, &misc_list);
- out:
+	mutex_unlock(&misc_mtx);
+	return 0;
+ err2:
+	INIT_LIST_HEAD(&misc->list);
+ err1:
 	mutex_unlock(&misc_mtx);
 	return err;
 }
-- 
2.7.4

