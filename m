Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC2F320518
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 12:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhBTLet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 06:34:49 -0500
Received: from mail-pl1-f169.google.com ([209.85.214.169]:42045 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhBTLeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 06:34:46 -0500
Received: by mail-pl1-f169.google.com with SMTP id s16so4833807plr.9
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 03:34:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=6SO1Xm1ig+zqP+nOLpgMuboGgnmxrihdNAhVpNDjz14=;
        b=LIP2rmOaD2zTVtEQujsyVKPG575GVxsmYL1z9mYBqlw6s3XAOzS6CVdBfrmmjqF+x7
         nKBspJM4NazqHpii+yojI9YgQ/YJ5S7lx7VFamIzcY2f/F4ojIEckBb5Vo2Bl9+ubiW4
         8KseGbCN0yRm7CSRVJ1I8ZvTFGA+3iVPhfnqrezUBUgfRFb/jcladGAT72Py0swjjeC6
         Wy+gy2/sBFQZtxKhjoU92yENVrAkRe4vglQx0eEpglTSZGjFA6oU665F3jhx71xiezUD
         6SEW2LRBZxYEtByu11uCsbw651OAzaZLlFwWWFahZAIBHR1dRSUfSBdp71q5HXpp7V5v
         OHhA==
X-Gm-Message-State: AOAM533UEYAY6e+/ksqZMKBevhRfT/GflYaAdXsh7OJynU5RO7Xnp+d4
        5h24o0J4XZOvREmWKvBVw8A=
X-Google-Smtp-Source: ABdhPJxBwp7yqsafMoz+q5eb5wy7bykkZSUSCmFk/QhBEiW4JMB3hmSM9v6CGa4OrUyqEMPfrH6nrQ==
X-Received: by 2002:a17:90a:c695:: with SMTP id n21mr14024879pjt.207.1613820845724;
        Sat, 20 Feb 2021 03:34:05 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.155.120])
        by smtp.gmail.com with ESMTPSA id l65sm3776803pfd.67.2021.02.20.03.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 03:34:05 -0800 (PST)
Date:   Sat, 20 Feb 2021 17:04:00 +0530
From:   karthik alapati <mail@karthek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mukul Mehar <mukulmehar02@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wimax: fix sparse incorrect type issue
Message-ID: <YDDzqPT81QBGpTBB@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix sparse warning by casting to explicit user address-space
pointer type

Signed-off-by: karthik alapati <mail@karthek.com>
---
 drivers/staging/wlan-ng/p80211netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wlan-ng/p80211netdev.c b/drivers/staging/wlan-ng/p80211netdev.c
index 6f9666dc0..70570e8a5 100644
--- a/drivers/staging/wlan-ng/p80211netdev.c
+++ b/drivers/staging/wlan-ng/p80211netdev.c
@@ -569,7 +569,7 @@ static int p80211knetdev_do_ioctl(struct net_device *dev,
 		goto bail;
 	}
 
-	msgbuf = memdup_user(req->data, req->len);
+	msgbuf = memdup_user((void __user *)req->data, req->len);
 	if (IS_ERR(msgbuf)) {
 		result = PTR_ERR(msgbuf);
 		goto bail;
-- 
2.30.1

