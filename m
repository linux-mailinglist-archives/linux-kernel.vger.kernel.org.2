Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A45347D00
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbhCXPu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbhCXPuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:50:52 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CA9C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:50:52 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id z2so24976451wrl.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G1l/7GKgxC7z3LCn+ZLNkyBsm6JDNMcpMQeWILgYaPA=;
        b=NeIspziNKd3CbXe6b+FgHM9e6pQTnnSJJidiFBjXj3//O/y2gJhLgjArQGeu4DMLL6
         mYOQJVfBAERgZdz7mjY3HbjVJm2+r0FOWrrDGb/b816eeayn900ULP8p8AjgGjw10oFO
         jJnjqktQm240XySnr0RnLGYqDDcvvmQsAO0JY0jHTy2Y7yPYLZKPOEKH6geI132ddzXK
         Ydvd72fy//89OwouThjOubdkKEQciJiJTiCy+xYNkDTzj4IKes5mAPBKr32JxA6UbkCB
         cv0azkG0pTm7KDzH57QRVz93fEEI/INTg3IsxTa0JCIEph9tQOWDch3q6wiqeIPPhGxZ
         pdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G1l/7GKgxC7z3LCn+ZLNkyBsm6JDNMcpMQeWILgYaPA=;
        b=o/1+c+8VG9La7y8grdZzw/a4tZdlk3Owg6Bo40xWa8QVSr2Z56AsCZs+kDIaLrBiR7
         iiur6tnd8WQb4WmhOF281AzaiPdj8FVTIRvPnX3Itvo0p9BHNBCPm/EeCDE6nz9XMw/r
         pZW1+xtSIloFpxvojHSXpBeCmNYPmfUd6GjhGPSwixj0yHG8kG3f5gTdWUhRJVO15xps
         v62T6AcuyKoRxKSs9A15QuP0Y9XSPah/FeTwsST4/oll5OCopf9q1U/MuoO15is2BCnP
         yQHAF2WenRqaVAj7I2wj8ZblDXpPf4qX7S5ODw6mTFHUAy5EWV7giNGI1qNRuPrKOGN0
         uF/g==
X-Gm-Message-State: AOAM533XjVdTMn2Gq3MOq5BO+EeMaoda4g/VXRWFvowHIihE2EbKpoFj
        Q9MERa3XJx5ShCdHwPxu45M=
X-Google-Smtp-Source: ABdhPJz3j/PjU7fzF181XjNCu86wiHgkViX0UUQ5/OfaGedQbY/q5jXJE2nXs+YSFLZFZaiUoUh3lA==
X-Received: by 2002:a5d:5051:: with SMTP id h17mr4186559wrt.80.1616601050936;
        Wed, 24 Mar 2021 08:50:50 -0700 (PDT)
Received: from agape ([5.171.72.168])
        by smtp.gmail.com with ESMTPSA id j30sm4105046wrj.62.2021.03.24.08.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 08:50:50 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 1/3] staging: rtl8723bs: remove assignment in condition in core/rtw_ieee80211.c
Date:   Wed, 24 Mar 2021 16:50:34 +0100
Message-Id: <8e784a7e1407924724c97398af8e5aeb23460612.1616600897.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616600897.git.fabioaiuto83@gmail.com>
References: <cover.1616600897.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch warning:

ERROR: do not use assignment in if condition
1118: FILE: drivers/staging/rtl8723bs/core/rtw_ieee80211.c:1118:
+		if ((addr = of_get_property(np, "local-mac-address", &len)) &&

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index cccbea555a32..e931afc3ba22 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -1115,8 +1115,9 @@ void rtw_macaddr_cfg(struct device *dev, u8 *mac_addr)
 	}
 
 	if (is_broadcast_ether_addr(mac) || is_zero_ether_addr(mac)) {
-		if ((addr = of_get_property(np, "local-mac-address", &len)) &&
-		    len == ETH_ALEN) {
+		addr = of_get_property(np, "local-mac-address", &len);
+
+		if (addr && len == ETH_ALEN) {
 			ether_addr_copy(mac_addr, addr);
 		} else {
 			eth_random_addr(mac_addr);
-- 
2.20.1

