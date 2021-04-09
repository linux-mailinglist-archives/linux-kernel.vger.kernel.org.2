Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264A8359B85
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 12:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbhDIKMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 06:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbhDIKE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:04:27 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2962C0613F0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 03:01:53 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id l4so7699584ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 03:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t5MrkBplUUW0jMP76detLuZqvjeuH5bGcdiLHmrpOV0=;
        b=aOKZyoK1e7xHR3B6+TTvGsvy9sUdH3GQq2Fv6Mydx42N9wb5bBcJPrvUplwtR/mqNk
         lrpLTCajPmlYyZsioQDRdcUBoIssh38Cf6xj6eW4Et+tSg98A7BF500IqwE9J5RXaKvn
         gpD6Wwh8Bvmgnv0eVHt9T//bAkPEWWzhSDSSB9eM1/FrzRVD91KHTEX/DDJxcocP9JSa
         pvxxqJ4RF13jL22G7mf+MwZaTF4kpHaJtve1xd7GJ1uX/DrP4BvMwnAYCsep6g5/Gfzb
         atGaAdIOs/W6FuEQkEaz2O12XQmK/HmVZTaYLA3tD7vVTOOc1Xk3bX25ItopYco24hzy
         /kUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t5MrkBplUUW0jMP76detLuZqvjeuH5bGcdiLHmrpOV0=;
        b=EikpM6vpYbsJfd1oJatAbzdD9yFoSEQzxut1sZiWd7AMXfkn+ztV7Dc9SwWPpylSYp
         Q5UjANlee45rCf+YBqlKHwQD11ITpsEg+frQm1hXc9+ZNNzibuOt9y+iHl22YnCj+AVg
         CutABfAcLopMBn9aTunqBp6hN+jCR+s0jDPWFvZdf7sDxg0KNUbF42D5lsyWck68HEsR
         Jpe0Q/d9Dw5SOleYcsSrtnbvCnTfUwoRRtLKkVGD/LX67gxS+MM9LB440RYknHMbmxev
         G2yhYCWKPtJFUF3mXh3EnBSJhhcvZVlxwT87xevk0ngyU3QhYa1Jnyzkeq5s8vSfLIg4
         33bA==
X-Gm-Message-State: AOAM532CZL7jLiu1jxz7OSPSJmUs/TS9k6Lhm6VC+g8OMbGfM9Q80Un8
        +Bxy8q7MXYalAMkeMebNNXyS+yGwXkA=
X-Google-Smtp-Source: ABdhPJzW+9b/StIgSDnjiIRYU+ita+RNBimNLDEAWgwEGdyc/muLvrTDZFGzFG5y+HigeF+8tgWRZg==
X-Received: by 2002:a17:906:1351:: with SMTP id x17mr15651133ejb.242.1617962512476;
        Fri, 09 Apr 2021 03:01:52 -0700 (PDT)
Received: from agape ([5.171.72.173])
        by smtp.gmail.com with ESMTPSA id h8sm1114387ede.25.2021.04.09.03.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 03:01:52 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 03/11] staging: rtl8723bs: remove unused code block in os_dep/ioctl_linux.c
Date:   Fri,  9 Apr 2021 12:01:31 +0200
Message-Id: <b1d8f99f949fd79b27295e8a508d1b0c5861622f.1617962215.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617962215.git.fabioaiuto83@gmail.com>
References: <cover.1617962215.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused code block which does nothing.

A list is parsed but no value is written outside
the scope of the function rtw_dbg_port.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 20 -------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 303a236fe8e6..9735522f9cc8 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2567,26 +2567,6 @@ static int rtw_dbg_port(struct net_device *dev,
 					}
 					break;
 				case 0x09:
-					{
-						int i;
-						struct list_head	*plist, *phead;
-
-						spin_lock_bh(&pstapriv->sta_hash_lock);
-
-						for (i = 0; i < NUM_STA; i++) {
-							phead = &(pstapriv->sta_hash[i]);
-							plist = get_next(phead);
-
-							while (phead != plist) {
-								psta = container_of(plist, struct sta_info, hash_list);
-
-								plist = get_next(plist);
-							}
-						}
-
-						spin_unlock_bh(&pstapriv->sta_hash_lock);
-
-					}
 					break;
 				case 0x0a:
 					{
-- 
2.20.1

