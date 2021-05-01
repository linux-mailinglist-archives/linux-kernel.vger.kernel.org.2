Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C413370773
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 15:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbhEANxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 09:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbhEANxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 09:53:43 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7F4C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 06:52:49 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id p4so1044401pfo.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 06:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=1OO8KJegNvuVXl/QR8Ti4ghr+nskjCRbiCGn/om46yw=;
        b=fVcpvgQtOl+z28kPWiCL4UzHRkr7ViZCZuoL7ZEZa8BC4sqYg8RXre03pcFFvyOc1A
         753nGNy2j+nPXpdhI08z6KCNnTBpdtJdP7XJ0GOXD/EprPfx4HkcxLCZwpJoEFzFStrX
         ui8JVxHPb7rL6nnLGFTQ7wcf3Evjgq9IBzx7gysVU+Iow/4nweTsn+4bJjcvYX9uGeuH
         m+ZoMdpcJZE4CdwgpmLhHPSXXg/qB+rxdlabCBIMJ6GWJm3ldeOCROsL7WFs9rpWz9n9
         IriqHHmdy+xA58YBo1MyyfoZwaZPgBHC2mf1vYG+s1p3VhpYTZvG2TtK3nb4oXdldUKq
         goew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=1OO8KJegNvuVXl/QR8Ti4ghr+nskjCRbiCGn/om46yw=;
        b=rZWt9un+eAYaqavATubUhB6KP5yKAnPmwpzo5qdEFUcItWCeAGmbKDY/HLEe3PILPi
         mxpaGi9cv9OQIZDYWDWMOWlqYvgblnFqAcqQj0A6gb1+2maTrwbYoxtCUzkXeHsQmAi5
         1IAWh8R9mfx/oTvIsDwp6ucf6cM4ic7HmaMDu72tIFq+WLXSxKTGL/G7s4/eQ+VaDHez
         oULO0keFNx/dXQDWl8OjHrTtGnfMlPfqmoq6oDpSI+sFHaTnX9zAobmM2gGdw13NNglk
         hxa0wee/DPiaohABBi7LFu/lC9KLH+TQh3/5Tn24UqgN+cdJiLrujEOlGqv6I+W76aAK
         gW7g==
X-Gm-Message-State: AOAM532BngvuFgWBv4+OPXiPp/4bLEQxyuCGANvexuDE6ThLYRwqbpx+
        Q4c/f1ZZVO5LURuHs0OyFFs=
X-Google-Smtp-Source: ABdhPJyH7HmM+q1tOPfcMOAJwckq4RxpFuptV/qT+SG5H2MfG3N0fyaWGqY+I8nYXQOvgL+nLOE6gQ==
X-Received: by 2002:a63:f311:: with SMTP id l17mr9215804pgh.405.1619877168329;
        Sat, 01 May 2021 06:52:48 -0700 (PDT)
Received: from ashish-NUC8i5BEH ([122.177.225.134])
        by smtp.gmail.com with ESMTPSA id b21sm4762687pji.39.2021.05.01.06.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 06:52:47 -0700 (PDT)
Date:   Sat, 1 May 2021 19:22:41 +0530
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
Subject: [PATCH v4] staging: wlan-ng: silence incorrect type in argument 1
 (different address spaces)
Message-ID: <YI1dKdfBKaSh3J8v@ashish-NUC8i5BEH>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently p80211knetdev_do_ioctl use type casting to req->data to prevent
sparse warning while calling memdup_user, instead of type casting it here,
its better to change data type for data inside p80211ioctl_req to include
__user.

Signed-off-by: Ashish Kalra <eashishkalra@gmail.com>
---

Changes from v3:
Corrected line wrap in change log comments and checkpatch warnings

Changes from v2:
Corrected line wrap in change log comments

Changes from v1:
removed type casting of (void __user *) for req->data and corrected type
for data to include __user.

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

