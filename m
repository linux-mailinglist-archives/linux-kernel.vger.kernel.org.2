Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3941F3654B4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 11:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhDTJCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 05:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhDTJCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 05:02:22 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF658C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 02:01:49 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id o16so5713484plg.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 02:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=nUTxD83tk99lAvG8V7zJLQuPHa5YvvReXL8ln/DNe9Y=;
        b=UXB94sY2D5CrMsl/iyK72EuZFmC2BeVYULg6Jqcf1+ZBz65O7ld1bEnRlB27uBFlg7
         WrlJCEIHwR6kfZQBU8v42GlPUDNkoxZ4OduJbGFNz1DLGBld7Tg/mAGBKGjaOfv7DsAe
         ZGiIw9KvjY8XTElYID/+3+iYRz4fqLopaveo3Hzshp00TDPjMaV2BuFFypHt6o4aRkz1
         McAGrnGAbP81yu1bxXPDHQNnrKUGwz2NXCk5OXhMr31PALMwZ9z8HLRRPTmWXmxQLHuj
         kDQ4DXfv4ONi06CkLxJND+i5uqln2GJk8tzrfD0E/TAmoohjeKBMvfQJCQfkgLXx8I9I
         qYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=nUTxD83tk99lAvG8V7zJLQuPHa5YvvReXL8ln/DNe9Y=;
        b=FLL0/NCmwctvhCeDvr+1eI88NvfVYQ5+YYVyEjBO8uYcNUakEtIWPcSfizQkr3U9dh
         HdqA3SS0rfmP+IICCDVzU+edmizt81QQlLm/pncvUiWhyDpCAxV3MFXNDfi5WW+qy5BI
         zo6EcMHiyVKwbr+FxvMO3maOhJLaYKObJ6cHoTxLC7diqSUJDfvprV8UsEc4cv9dKmTw
         owEylhQ4B8DwHbGoMhNk3xolhJkWxVRpHx4S0x/sXT47B8upBte8NznY94NY4VXuMV+v
         I+wK5yeMvpytVPgkZpXfvlY/cf7Bs6JEjH1k7oNd90imnaGj8hOwHnVVsJoAYA2+1rvd
         fN+g==
X-Gm-Message-State: AOAM531fMB2sPYkedX+h4Z7t8Y77b77244T3NX4Q5NrvV4yDa2BGxgx8
        TRjGVMLwfAHwpEq1DterQug=
X-Google-Smtp-Source: ABdhPJxF52UkL+Rb6yGN0+lwvAFPPmWOvFjz9PeYVIProM8YegqdIpLfmPnMRbD23utLBh+ZtfEk8g==
X-Received: by 2002:a17:90b:4b86:: with SMTP id lr6mr3872498pjb.77.1618909309084;
        Tue, 20 Apr 2021 02:01:49 -0700 (PDT)
Received: from ashish-NUC8i5BEH ([182.77.14.23])
        by smtp.gmail.com with ESMTPSA id n20sm14733914pgv.15.2021.04.20.02.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 02:01:48 -0700 (PDT)
Date:   Tue, 20 Apr 2021 14:31:42 +0530
From:   Ashish Kalra <eashishkalra@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Abheek Dhawan <adawesomeguy222@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Romain Perier <romain.perier@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Ivan Safonov <insafonov@gmail.com>,
        Ashish Kalra <eashishkalra@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     eashishkalra@gmail.com
Subject: [PATCH] staging: wlan-ng: silence incorrect type in argument 1
 (different address spaces) warning
Message-ID: <20210420090142.GA4086@ashish-NUC8i5BEH>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon running sparse, "warning: incorrect type in argument 1 (different address spaces)
is brought to notice for this file.let's add correct typecast to make it cleaner and
silence the Sparse warning.

Signed-off-by: Ashish Kalra <eashishkalra@gmail.com>
---
 drivers/staging/wlan-ng/p80211netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wlan-ng/p80211netdev.c b/drivers/staging/wlan-ng/p80211netdev.c
index 6f9666dc0277..70570e8a5ad2 100644
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
2.25.1

