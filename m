Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA733FB586
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 14:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbhH3MFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 08:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236858AbhH3MFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 08:05:35 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FFFC06179A
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:04:40 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id e26so3224838wmk.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ykIIFku5+vbZUnxk+devw/re+bV9Aj//c6+PrJONt+A=;
        b=Z/NGLQ2oWkXNZoH76qNWul/Mo6GyiKy8ejuzIZ2GYmntKa17Ocax3DO4ErAqKBYJKC
         EKS0VaAKGheYAGEMl7PyeVGUxcA36nUegUeR4ra0NjdtqOTk2PAbVqYPBK5x/lDj9KKZ
         bFAOU9dXTZVdZDaqYHInjjhCHM5qZmiZkdhgYsRMWVe6c8afFQ7Z/WQPkognaJ8aDioc
         vRcfa5SMrquiO2ZpWcrujad3oQ1OZ5dQAgBiFiRMSnBtU5ns4Y3qLnnX1UX5L2kCpewP
         Hn3Gr6jl/VhD/HmgiuxJdktXnYXfu4Pb4Dv9F4aOd86iSJm4reyPa9jCGkBDkB3aO0iN
         xpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ykIIFku5+vbZUnxk+devw/re+bV9Aj//c6+PrJONt+A=;
        b=OTayozsQgkCldYI5rqdlhe/lvlXXDN4nety1j01NwqMHraAwVqqEXgyvHJwNlD/4B9
         C8BuHmiiIAOGdZTiqJoOScbvM4fMFfMY2QNmwBUEYFATpIGHkG5YLoERl65oTa2dLwMK
         z6x5urY2CcdYC61mWgH9qFsQBo0PVJaJ8NeU34PROhhfhMYfH7eem/JW5lOtX3vWQSNQ
         URRJBev7i5OVxDlqYZYlcB43xZsh3ZL4IHv04awUXKhLTg3VtUp6wWXeAjCSuNsJz8Xp
         eFGD7BLyDobxJmLQM9nfkRRE2QZ4jNOlXlCzVXbIVc70YRO/y0PDR3d2+IkrBFo4bfq9
         2CVA==
X-Gm-Message-State: AOAM532wF9WtcdyRtTBQ2QLvNYYzfvnsXq+u+sG27LOiB3OgiEftMaUB
        SnF5t8zRGyp9FOHSA1XRwkE=
X-Google-Smtp-Source: ABdhPJzohl+VQIKPDmj4ZJWIlp0ggt3cC+259AklQElDA9qhec51mzLPifFU/A3HcRw7jvFtRMRJaw==
X-Received: by 2002:a05:600c:4309:: with SMTP id p9mr21913229wme.174.1630325079211;
        Mon, 30 Aug 2021 05:04:39 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id f18sm13184195wmc.6.2021.08.30.05.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 05:04:38 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/8] staging: r8188eu: use ether_addr_copy() in rtw_macaddr_cfg()
Date:   Mon, 30 Aug 2021 14:04:18 +0200
Message-Id: <20210830120420.5287-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830120420.5287-1-straube.linux@gmail.com>
References: <20210830120420.5287-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ether_addr_copy() in rtw_macaddr_cfg() to copy the mac address.
The buffers are properly aligned.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index 370a710ab7cb..c37358be631f 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -1026,10 +1026,10 @@ void rtw_macaddr_cfg(u8 *mac_addr)
 
 	if (rtw_initmac && mac_pton(rtw_initmac, mac)) {
 		/* Users specify the mac address */
-		memcpy(mac_addr, mac, ETH_ALEN);
+		ether_addr_copy(mac_addr, mac);
 	} else {
 		/* Use the mac address stored in the Efuse */
-		memcpy(mac, mac_addr, ETH_ALEN);
+		ether_addr_copy(mac, mac_addr);
 	}
 
 	if (is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac)) {
-- 
2.33.0

