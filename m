Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D57D36C9E5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237744AbhD0Q7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238781AbhD0Q7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:59:36 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCF1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:58:52 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id e2so26912324plh.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=1AGNuGHLiEZNEotvrW58K2H0R4feS2Mkobtfjgal6GU=;
        b=fp3frHUFgW560Gvtc++SA6hXUnivhNELQJwkkzBLrc4kWLEbnNc7rEWa1jhwCb8Qk/
         mTdkMOF4iACKWRVyjtoHayCy0lp/hy/Q/gy10W3kvqRCSdMVYVQxTOFco03UjLDuFhtq
         1FYRsqEGElRiPsZBC2wG1pZ5Fqt5HgHgbCHH41aZyUCBDoI8OWRRKsfWYeyGK/PLdU5j
         uRP0GfNLNpLC7pAmrwN9dR5x2zKwtMs/zT8cnJXt341ReeM078MBOf2U3aMVkr/qu6h3
         Jbokw9Skat/wThbVnw6tTplxs5AKdZONrxvu3WMBlBRqi+z3rU0s4VVx0RM4KDNAHc7M
         gp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=1AGNuGHLiEZNEotvrW58K2H0R4feS2Mkobtfjgal6GU=;
        b=J9yIDJFQSOUotKukcc8flAUzIqYy8Utgi77XMH9ez7Pa+/+U4C43Vq6rb9c8HVNkNp
         oqxLVIdLzOTZZmamo24MhzbLj07K8mD82r3fxpQPLdBQktkGZlh1AIgP4kIbZyMHdZAW
         mdmu8mez8wo/Zcjz5zPxizNBG9QeNgZUaP4C2uQm0Vrq3snjd2GNAF8e8yx0Tyq+wQKz
         kZqzABDjmIn7PV5DkYTpYsMJ0W2o5i8c3BxcC3+PKrUDuzzpcc9/ozs43Ght7vB+/38Q
         OX4MDuDf+ANzbW8Y3Zh8L42VV0PF8I1IlS6D9tgkypfnzc226m5U6Jy0/71JdU8XbvWx
         y1JA==
X-Gm-Message-State: AOAM5332KVoj27KsUIpo27gO0Wp+pO5nIFvfPcN5muAfyYNr5f6dTLUi
        ljFSbCo2y9jyqlZBODb9AXjtV/azzQdUzCun
X-Google-Smtp-Source: ABdhPJx2oPd9GXcOgE+fgMaSbmoib0o3LyMBDpfz8ri4R+tmB4CUOlFF7ojgEOx6CGp6REYG0p49ow==
X-Received: by 2002:a17:90a:3f08:: with SMTP id l8mr5898720pjc.136.1619542731876;
        Tue, 27 Apr 2021 09:58:51 -0700 (PDT)
Received: from ashish ([182.77.14.23])
        by smtp.gmail.com with ESMTPSA id z17sm2840745pfe.181.2021.04.27.09.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 09:58:48 -0700 (PDT)
Date:   Tue, 27 Apr 2021 16:58:44 +0000
From:   Ashish Kalra <eashishkalra@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ashish Kalra <eashishkalra@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: wlan-ng: silence incorrect type in argument 1
 (different address spaces)
Message-ID: <20210427165844.GA35857@ashish>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Corrected data type for variable data adding __user to make it cleaner and silence the Sparse warning. This is version 2 of patch, version 1 can be found at https://lore.kernel.org/linux-staging/20210420090142.GA4086@ashish-NUC8i5BEH/

Signed-off-by: Ashish Kalra <eashishkalra@gmail.com>
---

Changes from v1: removed type casting of (void __user *) for req->data and corrected type for data to include __user
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

