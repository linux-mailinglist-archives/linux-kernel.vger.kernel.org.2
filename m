Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B8C370770
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 15:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbhEANoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 09:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhEANn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 09:43:58 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17516C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 06:43:09 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id e2so431172plh.8
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 06:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=SKQN4qrkVF+YMQJBQev8dGty0Fkt2Rp9SQ2c3egCWA8=;
        b=uvkYbTzpYuoli3HZ+PZm4ilOAZrRUyvSW/9Ad+MjxojLz4i+Qq7LKOU9hBhAtfJARZ
         m8dlyFiniaUvuSZzIuQ7iyEGORIWZj8kqhhAJJryRB9HOsoM3iHpKfkt2Cv6bbLdvD3Z
         JmLc/MbBXtlYghhFvfQgO9crOITjcT947rEJXA5b7HrQ0PukboR5CXzcfzSWu5c33W2H
         u7BRPEVfsGOd7N9MC94xIQ7qCXaoQjLbQrAqcRrlYjUzeTaRSERzd7i45SkOSUENVA3S
         9mfnbQwRq3kXzVuOC4eSAmuN888RjGlz/NS3uf4g5rQ1IfSugj5NwN3y8cS0rDS6aNX0
         o+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=SKQN4qrkVF+YMQJBQev8dGty0Fkt2Rp9SQ2c3egCWA8=;
        b=qQBHQf5ZWygpmfhligTP8qEm8X/J1LYPbTWuLDq4lUGnEkiEvEYJd4Cxlp7DRIHDcH
         PGRH0XdLyrDtGY7jSqYTo9rfhfHMGk4mEMw6cWgoL6f4q1fVRWTixVERs4dIKoWsheLa
         +7t4MYq0DGkS2hKGg+xJx2TCB7CgoV077ElbQ9VS4cRcXgKayYSy+9fuzO3MndpImgQG
         hFeVBycc6rUXzhp9wz706GWiI4gquEUsaDTOI0FMacdUflyUMpnZlhMy2gU1vX3UpHLN
         5jyWW4qPP3RobL9k+fT32xa1GIBeE2U7kej2o4Ccnob+AnzmnfwbUB4z809lDavLfgj7
         yR4g==
X-Gm-Message-State: AOAM531Ubt1YVFOy+uKDfgBukk52FADEks9E15raDzQTeCbGSGIbk4RJ
        UMD/vNI8YBIdPfB8GKW7FmY=
X-Google-Smtp-Source: ABdhPJwI6RG60fqaAajwjGitgkGrtw4farL4wqGiuR7bSp9A8LNWxCY8RCNt1OB5532O75dJbosUug==
X-Received: by 2002:a17:90b:194:: with SMTP id t20mr10876475pjs.83.1619876588248;
        Sat, 01 May 2021 06:43:08 -0700 (PDT)
Received: from ashish-NUC8i5BEH ([122.177.225.134])
        by smtp.gmail.com with ESMTPSA id z25sm4609482pfr.120.2021.05.01.06.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 06:43:07 -0700 (PDT)
Date:   Sat, 1 May 2021 19:13:00 +0530
From:   Ashish Kalra <eashishkalra@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ashish Kalra <eashishkalra@gmail.com>,
        Ivan Safonov <insafonov@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        David Howells <dhowells@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Allen Pais <apais@linux.microsoft.com>,
        Pritthijit Nath <pritthijit.nath@icloud.com>,
        Abheek Dhawan <adawesomeguy222@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: wlan-ng: silence incorrect type in argument 1
 (different address spaces)
Message-ID: <YI1a5NS+UyTNTwIJ@ashish-NUC8i5BEH>
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

Changes from v2:
Corrected line wrap in change log comments

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

