Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA1633AFBC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhCOKPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhCOKPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:15:07 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F9BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:15:06 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo19086843wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8y5b2VDJq2uxZg06dfRG9ZmzLOxQKYqLlX2oZGo99NU=;
        b=R6WiinF+JrvfG9o+EBcqGNJrb69/rPZm58W9qFIx9BhDF4/e1m5XXgnTmrqMlbskDH
         7KayyE7u6LyBV8emT0jN4+6ac8MI4+bfL8vfxPiyuqgNhv/1nyj9sJpQsxc/yvy/pf7o
         36KZvGanGHqwLG8p3oWlTp7Z3KcMPZ9ShxGl+VhaRoZtD1AYuJB2ACNRq7w0Bi+S74OK
         42DKmuIjI2oJzILLTyYUUW2NkrgLSsfbP+S5SofWCRdQg4kpzFbiG8zu+nlA3xAhC22k
         +oel77zyKD+Ffv5jLOuz9FinJ7k5/uyy+Fin1/x8c0nK7EDZTfWXZA160/n1Xx9x+ocv
         Z83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8y5b2VDJq2uxZg06dfRG9ZmzLOxQKYqLlX2oZGo99NU=;
        b=kXteLI3+ov22df9kudgAd526i6sbdLAmxS8SzXtcqImG9wTHAys+ZpE0PDRN8vw2GT
         wyxUywTNKQhUWQoD9crJT9iJBBQdMvkzv12O9EHR/+7Ix4aJUw1GFHcNE5c0TiZ5MFEj
         cuXHH9FmqPUCtum7WdouSHTt9rTKAVlHIE/hhEaCvSx1yJchN/Wld0r4CZ7oj4mVp4a1
         r1Mw80onk0akh1Bbwild/xfsGD+BVAmoVerIhy6P7+3LGh/fWIL2BlMseNoeDFj1xlIO
         owPpneXs93w8gkgraddPs8rsjw6nc3ahqsX9NCVivAGIiJBAmmss9DW9LSP87uxHEjUx
         yebQ==
X-Gm-Message-State: AOAM533kccMN9Gv1Kyen/JQQQnM9+N2i5ZJqgIzyhxuuclPt57MQOzZf
        2jL6WeLW26oQIxwYviu2SK0=
X-Google-Smtp-Source: ABdhPJy5bAAu9UX8pJjpmoDXYhNqrJ6HBtu1X638wPkYsapll6EJCO8xrn7Zf06CdtOJhbiS39muNQ==
X-Received: by 2002:a05:600c:2106:: with SMTP id u6mr25505382wml.55.1615803305505;
        Mon, 15 Mar 2021 03:15:05 -0700 (PDT)
Received: from agape.jhs ([5.171.72.229])
        by smtp.gmail.com with ESMTPSA id i8sm20229937wry.90.2021.03.15.03.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 03:15:05 -0700 (PDT)
Date:   Mon, 15 Mar 2021 11:15:02 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/15] staging: rtl8723bs: remove unused code blocks
 conditioned by never set CONFIG_PM
Message-ID: <77ea39e63246fa4756afcf2bdea573f43fefc74c.1615801721.git.fabioaiuto83@gmail.com>
References: <cover.1615801721.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615801721.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove conditional code blocks checked by unused CONFIG_PM

cleaning required in TODO file:

find and remove code blocks guarded by never set CONFIG_FOO defines

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 2ff71d001c07..5748e1c1a25c 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -3198,14 +3198,6 @@ static void rtw_cfg80211_preinit_wiphy(struct adapter *padapter, struct wiphy *w
 	wiphy->flags |= WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
 	wiphy->flags |= WIPHY_FLAG_OFFCHAN_TX | WIPHY_FLAG_HAVE_AP_SME;
 
-#if defined(CONFIG_PM)
-	wiphy->max_sched_scan_reqs = 1;
-#endif
-
-#if defined(CONFIG_PM)
-	wiphy->wowlan = &wowlan_stub;
-#endif
-
 	if (padapter->registrypriv.power_mgnt != PS_MODE_ACTIVE)
 		wiphy->flags |= WIPHY_FLAG_PS_ON_BY_DEFAULT;
 	else
-- 
2.20.1

