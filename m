Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0E136CA44
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238152AbhD0RXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235777AbhD0RXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:23:30 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F798C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 10:22:46 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id f11-20020a17090a638bb02901524d3a3d48so7512684pjj.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 10:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:reply-to:mime-version
         :content-disposition;
        bh=4aQcJ05qM8Bj1O99QnqWNUcSrtGTjkQQ9E6tg2L5a0M=;
        b=eh487a0QFxf8+o2uBd5ApLOBCOSWbky45t2rhevKHrsCawD4OZ+fQoTAZyRv/e3W4I
         JsFJdtNsorT5QcFZ3rJof+7apwxKjIJlhsJB1RHpkPwCTSGKsjx8OT5DWuRa8JmoGwdl
         rr04iiji3RNYB86ksvG2rvLmd5ZPkvbDxpBESeaLj4zk79oEzBfLe/eXQwHs/ZxMi+Fy
         KB7JXe6zfygiBuCo6ruGDcsmRUJAPrTvvQbkvUgV914FiUzb+IatXmKSSNvGWbrX5HH5
         C+Zuhyy3iVVbrWXZBVrMtZZJMzv0f1bEbz+ypKoxMlRMO8H0sMPUsueYTl/4UgQNBy3A
         Ti0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:reply-to
         :mime-version:content-disposition;
        bh=4aQcJ05qM8Bj1O99QnqWNUcSrtGTjkQQ9E6tg2L5a0M=;
        b=FxSbk2Bg/ztSvnY3FrRkFLjSksuliO05nsf+YE4wbkMJ2ssi+TBulb+Nh/Xb+d5hiH
         BZ9slS8JhIDMJSjAP7pEj2TfUNUbV5MHkxI4/W+fEf08bpftk8dOhfbVeO9d3M8K+fSK
         JNU/SkGS8blS/R1grsZJT6rNU6Kdei/mKwPjvZUzGbYzNnf6GadQ9lO65379mEH/grlz
         8yQwrM+mPxVYKh7/ULN/OasQtcfdF2lvSQyKKPcEtBZKZCtGgfYytcZPIwICI7G7hVAT
         0XrKTDXSq7QcJU/HyHIpueock8CuWAMG7SoitwRDsSdA/cW8P3q47tHcF4VQlwA5Iw9c
         wBvg==
X-Gm-Message-State: AOAM530DqKAIC9JZcWP/sNOhTGFxBjQ4AFkJA/DfYD7psgMt2KyrlnBt
        /IFUCMIPjBMSLAdu9R/jfaQ=
X-Google-Smtp-Source: ABdhPJzmrkvDiStAmtd7+VGvZsI9pYupESy16PFw+F9Kq3HKRKavCuP0bioUmlFpVo2aME8RSxiWhw==
X-Received: by 2002:a17:902:8d84:b029:eb:37bd:a3f7 with SMTP id v4-20020a1709028d84b02900eb37bda3f7mr25339714plo.26.1619544165761;
        Tue, 27 Apr 2021 10:22:45 -0700 (PDT)
Received: from ashish ([182.77.14.23])
        by smtp.gmail.com with ESMTPSA id i10sm2746126pjj.16.2021.04.27.10.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 10:22:45 -0700 (PDT)
Date:   Tue, 27 Apr 2021 17:22:40 +0000
From:   Ashish Kalra <eashishkalra@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Abheek Dhawan <adawesomeguy222@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Romain Perier <romain.perier@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Ivan Safonov <insafonov@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: wlan-ng: silence incorrect type in argument 1
 (different address spaces)
Message-ID: <20210427172240.GA36694@ashish>
Reply-To: YIg3UcWgwElAsUnI@kroah.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Corrected data type for variable data adding __user to make it cleaner and silence the Sparse warning. This is version 2 of patch, version 1 can be found at https://lore.kernel.org/linux-staging/20210420090142.GA4086@ashish-NUC8i5BEH/

Signed-off-by: Ashish Kalra <eashishkalra@gmail.com>
---

Changes from v1: removed type casting of (void __user *) for req->data and corrected type for data to include __user.

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

