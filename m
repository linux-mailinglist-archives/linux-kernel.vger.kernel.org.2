Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA34836C7ED
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 16:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238459AbhD0Oqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 10:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbhD0Oqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 10:46:47 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886DCC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 07:46:04 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so7350065pjv.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 07:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=2xFujiKNAg6k8WiwS+GsUKGoyhfviAT6MrFMuV7g0VY=;
        b=W9bX/yQROiVEU3xK/9vtl2mZLT98Kf4hlhcJHT17XauZB0OobUBtWOaqq8wJa1NlXQ
         ib1BezYVzqVtSsChKSGdWHq1fNK9XeMcnvEdY+Ol//OwKa6dqE/gqrJ2O3UkY7ydHHzd
         4rnD+QGh3SAnIj/tzAFpm+hitGY0bug/yVgHKumed7qHGCmP6KOhxV1S1ecFZMNmDvjV
         sIZ5Suh9mvggueaJ8s+V8VVdClx1yiuxnqohMQuqlQRarT9y6RioOa7u7lL0GVK/P9/e
         yrzjO1nMMmMMz/+wH0L1mY7OVQ8k1SEDilBi34w5HTlOtAd5C7CsOvmcRKUbeXZ8+6Xo
         6jTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=2xFujiKNAg6k8WiwS+GsUKGoyhfviAT6MrFMuV7g0VY=;
        b=cRxSTeJBDymqXvVmWTz9Rm/XJod1/g3GpfTxwYAPMg7OU+/b9nrhX51wUwsTCDTCpe
         kY7YsUFEcPxyI6vOvRzm2Q2fmcac+sr/mj378YnKkA5LdtaNS3xKwGJTmW5/Wj5/2ESq
         cDwY05hmoa5Um0t2mt/l8GOTUeTio1pJBPun2S2128FQUfg7TL61y0ssqvlW+4Y5Blq3
         T0O+mAhd67ypU+0oDQB9zzZeFirGYJl49R4dYpSeIjlpnhPxl/FbOJ0bY/7vyxEUsSjV
         QSG010ogx/uKpEXP6m4/+Ts82JuEW157CVKkhOEs+O3eWSrN5QNFjviNi9aub7NuYWGL
         Dljg==
X-Gm-Message-State: AOAM531GczaxhylVSa/uXKqmA7xhm1RsK8dVVkwFVLQU0j4pSk0GMDjB
        nDOMszm02ufhSlEi3DkNLgDFXOSeUSG6WpUL
X-Google-Smtp-Source: ABdhPJxtXvWCa9hLb5LLDNJ/OtEomusxQ80BJn1FFpa3wF54twM45iN+8HfzeIfYVJngMdxspzrk0Q==
X-Received: by 2002:a17:90b:3686:: with SMTP id mj6mr5330388pjb.116.1619534763867;
        Tue, 27 Apr 2021 07:46:03 -0700 (PDT)
Received: from ashish ([182.77.14.23])
        by smtp.gmail.com with ESMTPSA id o4sm2838199pfk.15.2021.04.27.07.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 07:46:02 -0700 (PDT)
Date:   Tue, 27 Apr 2021 14:45:56 +0000
From:   Ashish Kalra <eashishkalra@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Abheek Dhawan <adawesomeguy222@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Romain Perier <romain.perier@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Ivan Safonov <insafonov@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     eashishkalra@gmail.com
Subject: [PATCH v2] staging: wlan-ng: silence incorrect type in argument 1
 (different address spaces) warningJoe Perches <joe@perches.com>,
Message-ID: <20210427144556.GA19024@ashish>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Abheek Dhawan <adawesomeguy222@gmail.com>,
Johannes Weiner <hannes@cmpxchg.org>,
Romain Perier <romain.perier@gmail.com>,
Waiman Long <longman@redhat.com>,
Allen Pais <apais@linux.microsoft.com>,
Ivan Safonov <insafonov@gmail.com>,
linux-staging@lists.linux.dev,
linux-kernel@vger.kernel.org
Upon running sparse, "warning: incorrect type in argument 1 (different
address spaces) is brought to notice for this file.let's correct data type for
variable data adding __user to make it cleaner and silence the Sparse
warning. This is version 2 of the patch, version 1 can be found at
https://lkml.org/lkml/2021/4/20/203

Signed-off-by: Ashish Kalra <eashishkalra@gmail.com>
---
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

