Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F3236D251
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 08:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbhD1Gkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 02:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhD1Gkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 02:40:36 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5B5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 23:39:52 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id a11so1355881plh.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 23:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=NhmVMEaIqvnthCWjIRQe+gWpUDAqZuKcGu7caMo/xzw=;
        b=UBN0E1sgTq5PGpkXWxo0ahv8YsFlKy4cFyzlPvPgF02hVzOxtyJIGoD7eq2nKPN+ZH
         dYtMfxDVqhkSuR8vNQ5RvtXu+zy0aG9jBCLvLeGq8eZjwDg3Ci4c5XzkjfnQTZWk8F6p
         rjKOJAqkkKEpQ+hRohiqKAun6WjXskVVImSvmueUP2vVBI0QMCwwbieXvtSdig1ypkJg
         rzc9zieiPE8qP2H72GEuokRHdm1g4/NDeqiJgKtnQ2skcg3XGixNZAhNB+WnU0P6E37m
         TOxX8cgb9Zdi6QDF3/G/b8Pxj8X9Y+FPikT19n1CKhR2WDjGatVITUd1YtHEE7WVGYSw
         vtiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=NhmVMEaIqvnthCWjIRQe+gWpUDAqZuKcGu7caMo/xzw=;
        b=t0IHgfQd6oYeZ7IcMx54SFcHXwmH+pa5bUNAaRY46oyC14XDNzcMJ3PDx9tunlYprM
         /+rTou9JhTnfmviHJHBh8AFtbMqbnzQlok8aoNvQ4f4QYoeivNCRjox5ErR5/dA+P1Vn
         ZOHjBKgV4zLQ2y4GfMeWgbBQFmsoOHSAQ/cZkRErCLYecAvlVSZNVTUrhabDtXawAOjY
         xGGdJ2jiPzfiFEez/GhZZ7IRJg46morwgYIdJnLdC2fJnfWamCmuIB6+/2kquPDnnkJa
         Kd2DAJsmEiqppQhIE1gtbwM6tpN3jyWp/knppBpGlE0iDrVr5oQY//f2vRzugITyAUsa
         EAVA==
X-Gm-Message-State: AOAM5321P7NVSHNzoRp9DVzrCbcMzwx7t2/cV2y/NiKvn8gmEypQkwJ5
        pwmAwdRRHWyz6qHCr5BslTPN1p2d4UZHjnCr
X-Google-Smtp-Source: ABdhPJyHgr2gNr84j1kh3UOSlmUMBfASE8cDqgjsTiTeIFWz2WfwjAZj+QqK/B9Gxxwszd7taksV2Q==
X-Received: by 2002:a17:90a:a58f:: with SMTP id b15mr30268137pjq.135.1619591991405;
        Tue, 27 Apr 2021 23:39:51 -0700 (PDT)
Received: from ashish ([182.77.14.23])
        by smtp.gmail.com with ESMTPSA id u18sm4188507pfm.4.2021.04.27.23.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 23:39:50 -0700 (PDT)
Date:   Tue, 27 Apr 2021 18:03:10 +0000
From:   Ashish Kalra <eashishkalra@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ashish Kalra <eashishkalra@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: wlan-ng: silence incorrect type in argument 1
 (different address spaces)
Message-ID: <20210427180310.GA37264@ashish>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently p80211knetdev_do_ioctl use type casting to req->data to prevent sparse warning while 
calling memdup_user, instead of type casting it here, its better to change data type for data 
inside p80211ioctl_req to include __user.

Signed-off-by: Ashish Kalra <eashishkalra@gmail.com>
---

Changes from v1: 
removed type casting of (void __user *) for req->data and corrected type for data to include __user.

 drivers/staging/wlan-ng/p80211ioctl.h  | 2 +-
 drivers/staging/wlan-ng/p80211netdev.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/wlan-ng/p80211ioctl.h b/drivers/staging/wlan-ng/p80211ioctl.h
index ed65ac57a..77e8d2913 100644
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
index 70570e8a5..dfb2d2832 100644
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
2.25.1

