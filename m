Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5531237070C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 13:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbhEALkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 07:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbhEALka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 07:40:30 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E6AC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 04:39:40 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id p2so423070pgh.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 04:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=V8Oh5UM+MuV4MLaFnRZfCDneLqfuPCQcjlq7Di+tmDk=;
        b=EiMn8cSdYzr7/++h6nLUN02El8BNKIJoyGedBJD04ih+UFfzoXNZKRXRPXQXPNfVus
         ZNb56g/H7yYSKP+KNArjMhke16K5nS0CI/NMvcphI71K9HNmMphIEU5KKfK2eECVmuK9
         eaIE3LE6/vQgyGH3rv0dZGV7P6866rdD/FQNuRMlJSjLJZSeItMFv9z4eXH9mfpFprJ5
         ArrFdeRhiBrShxbKOwSoWDrgVY/usDgIqLQDXFFCnY3chY0ocCwQtAA6+DZNJ5+fLwLi
         wFkiT2SlUNXt1fpyWNofd0HYqZJOKkVAw+JYGQhNLjqRHR7sgwh3osN2MTc92QsTBBX9
         h4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=V8Oh5UM+MuV4MLaFnRZfCDneLqfuPCQcjlq7Di+tmDk=;
        b=gePdNaL9G94pZ2Z83S3Y3chcjmJHUuu4DAoXYtaCrtqmwzctUSYOhh39g4CfVbtLDi
         K0w0vWd1muxcXlcPEqv90MPRnB76nX8Wet8Wiz7Zg+WILHOjfMA0LFtpwx2lfCjlP0Q8
         fnJNXJim9uYODUXdx3RKKRlWdia3W9Q0tEVc+QFBj9JQRsUPYeOBpMaJtZ4NJ44CbLQU
         lUejheew9DO3CizrWLvYbJuh8ylMr+F6sQQrNP9tvtSN7c8r6tDQ9w+h53RsluJPJ8eX
         QGtakjSvFizf/ul10m82aZwd9+X3ounWYct809Ud1TDi4GPKF84HWriksAW5mGKr3wFW
         nMhA==
X-Gm-Message-State: AOAM531WcshwPKWsyYCQo54pBjy05EPQO6FO1UqPCyg4mFKSBY9YwWLN
        CnsNjRPZSnjJRrnzh/TYiLY=
X-Google-Smtp-Source: ABdhPJy+EZw8Jt0ErF8L4JM+hDj/iQC44ohBfxDNxEdptqq3ukX+lJySuxnQjVxNaX+qFxQd1CN2RA==
X-Received: by 2002:a63:570b:: with SMTP id l11mr9009643pgb.193.1619869179376;
        Sat, 01 May 2021 04:39:39 -0700 (PDT)
Received: from ashish-NUC8i5BEH ([122.177.225.134])
        by smtp.gmail.com with ESMTPSA id x9sm5531489pge.55.2021.05.01.04.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 04:39:38 -0700 (PDT)
Date:   Sat, 1 May 2021 17:09:28 +0530
From:   Ashish Kalra <eashishkalra@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ashish Kalra <eashishkalra@gmail.com>,
        Ivan Safonov <insafonov@gmail.com>,
        Abheek Dhawan <adawesomeguy222@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Pritthijit Nath <pritthijit.nath@icloud.com>,
        Allen Pais <apais@linux.microsoft.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: wlan-ng: silence incorrect type in argument 1
 (different address spaces)
Message-ID: <YI098DQNtK3i2Fge@ashish-NUC8i5BEH>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently p80211knetdev_do_ioctl use type casting to req->data to prevent sparse warning while calling memdup_user, instead of type casting it here, its better to change data type for data inside p80211ioctl_req to include __user.

Signed-off-by: Ashish Kalra <eashishkalra@gmail.com>
---

Changes from v1:
removed type casting of (void __user *) for req->data and corrected type for data to include __user.

 drivers/staging/wlan-ng/p80211ioctl.h  | 2 +-
 drivers/staging/wlan-ng/p80211netdev.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/wlan-ng/p80211ioctl.h b/drivers/staging/wlan-ng/p80211ioctl.h
index ed65ac57adbe..77e8d2913b76 100644
--- a/drivers/staging/wlan-ng/p80211ioctl.h
+++ b/drivers/staging/wlan-ng/p80211ioctl.h
@@ -81,7 +81,7 @@
 
 struct p80211ioctl_req {
 	char name[WLAN_DEVNAMELEN_MAX];
-	caddr_t data;
+	char __user *data;
 	u32 magic;
 	u16 len;
 	u32 result;
diff --git a/drivers/staging/wlan-ng/p80211netdev.c b/drivers/staging/wlan-ng/p80211netdev.c
index 70570e8a5ad2..dfb2d2832830 100644
--- a/drivers/staging/wlan-ng/p80211netdev.c
+++ b/drivers/staging/wlan-ng/p80211netdev.c
@@ -569,7 +569,7 @@ static int p80211knetdev_do_ioctl(struct net_device *dev,
 		goto bail;
 	}
 
-	msgbuf = memdup_user((void __user *)req->data, req->len);
+	msgbuf = memdup_user(req->data, req->len);
 	if (IS_ERR(msgbuf)) {
 		result = PTR_ERR(msgbuf);
 		goto bail;
@@ -579,7 +579,7 @@ static int p80211knetdev_do_ioctl(struct net_device *dev,
 
 	if (result == 0) {
 		if (copy_to_user
-		    ((void __user *)req->data, msgbuf, req->len)) {
+		    (req->data, msgbuf, req->len)) {
 			result = -EFAULT;
 		}
 	}
-- 
2.30.2

