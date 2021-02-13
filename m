Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1823231AB96
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 14:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhBMNRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 08:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhBMNRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 08:17:11 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0756C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 05:16:29 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id u25so3518213lfc.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 05:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nPbqrJuXIW4ot4VyS1QmTXkJKxb4GxS010Xfjk124w8=;
        b=m+FlFSVyoHlt5P8m4Bj7iVdALwyKMaKTGkDy2kfTzhNDhoawZ9rRq+HRqWblBzkfEE
         vmxo/3NKu90R6RUqT+vF7f7mtpd7V3eNcmKR3QGgf06n86C8aTRKes04S4kOsHiPEGa/
         8dHllT0MebwldpqjIDfaa9TBB0vyUcL5LxJ8y7mSp/VTaHb2Z15ZMsg4bvCBCVshaEEY
         V1wwlJc0ahLOyVOKp9W2P1Ic94VL34a0ZFw1AZEEkxPThB4f55WuWpGjsyOS664vIXSd
         h+4AmbYAADFYY67Hs+HrUaNFyR+yFc+C0qrlnNt1gluXCrWM4ZQte2bhCVv+nj/0R0aY
         pdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nPbqrJuXIW4ot4VyS1QmTXkJKxb4GxS010Xfjk124w8=;
        b=JAGJnbhCAMdCjHNanSwAvlkdbK3XLEyreyW2MUi1hY9VViBpwhZseRVfkzujcnVssF
         mnfOlgSiCdDgaEvLDD/UCk7iRt9D+BkKHvdEgAKiV9AtMlwTGgIbSRihLRJQy8YRrfnX
         O6xppap6N4n/upUJRGmUC1hpas2IgWZPb2eshGM+7WiUPjpEInxo87IFJ3ADsmTQb7eg
         mm+D74qC+FJQ0mzE8AqOJBLPwCwOUh4ERkh/xWts6U+7kA0Jsg7coPSlFvDU4A9/CQlv
         DbLub2NrL5bnRHge9gSsi1iebQuja4X2JDj7phyKCrsJxoLRhfb23rcnUHcEWNKVKJVK
         7gew==
X-Gm-Message-State: AOAM533aVGPqi9eYJr//+E0BmqRbepvgQ2Fzz0GvY/B4NJOw6b4RmpKe
        npOVUwd9ukDxxUrZgJjAJag=
X-Google-Smtp-Source: ABdhPJy0t+8LOLGIuAkt9SIDTyjKKIKA9ayDI/EDGl5jDCh9oXWze2ym6niBieWrORQWVT9H/lhD1Q==
X-Received: by 2002:a19:5d56:: with SMTP id p22mr3792392lfj.360.1613222188115;
        Sat, 13 Feb 2021 05:16:28 -0800 (PST)
Received: from alpha (10.177.smarthome.spb.ru. [109.71.177.10])
        by smtp.gmail.com with ESMTPSA id f13sm1235299lfc.39.2021.02.13.05.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 05:16:27 -0800 (PST)
Received: (nullmailer pid 452050 invoked by uid 1000);
        Sat, 13 Feb 2021 12:09:53 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Allen Pais <apais@linux.microsoft.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Waiman Long <longman@redhat.com>,
        Abheek Dhawan <adawesomeguy222@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH] staging:wlan-ng: use memdup_user instead of kmalloc/copy_from_user
Date:   Sat, 13 Feb 2021 15:05:28 +0300
Message-Id: <20210213120527.451531-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memdup_user() is shorter and safer equivalent
of kmalloc/copy_from_user pair.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/wlan-ng/p80211netdev.c | 28 ++++++++++++--------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/wlan-ng/p80211netdev.c b/drivers/staging/wlan-ng/p80211netdev.c
index a15abb2c8f54..6f9666dc0277 100644
--- a/drivers/staging/wlan-ng/p80211netdev.c
+++ b/drivers/staging/wlan-ng/p80211netdev.c
@@ -569,24 +569,22 @@ static int p80211knetdev_do_ioctl(struct net_device *dev,
 		goto bail;
 	}
 
-	/* Allocate a buf of size req->len */
-	msgbuf = kmalloc(req->len, GFP_KERNEL);
-	if (msgbuf) {
-		if (copy_from_user(msgbuf, (void __user *)req->data, req->len))
-			result = -EFAULT;
-		else
-			result = p80211req_dorequest(wlandev, msgbuf);
+	msgbuf = memdup_user(req->data, req->len);
+	if (IS_ERR(msgbuf)) {
+		result = PTR_ERR(msgbuf);
+		goto bail;
+	}
 
-		if (result == 0) {
-			if (copy_to_user
-			    ((void __user *)req->data, msgbuf, req->len)) {
-				result = -EFAULT;
-			}
+	result = p80211req_dorequest(wlandev, msgbuf);
+
+	if (result == 0) {
+		if (copy_to_user
+		    ((void __user *)req->data, msgbuf, req->len)) {
+			result = -EFAULT;
 		}
-		kfree(msgbuf);
-	} else {
-		result = -ENOMEM;
 	}
+	kfree(msgbuf);
+
 bail:
 	/* If allocate,copyfrom or copyto fails, return errno */
 	return result;
-- 
2.26.2

