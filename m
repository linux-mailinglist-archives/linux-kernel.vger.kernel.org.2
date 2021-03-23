Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D175345AB6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhCWJXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhCWJXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:23:30 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14574C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:23:30 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id g8so10110808qvx.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DIUTi3R3RnB8XZ8jIbE4k6ovrlYAEKEjVvCfRHAa3YY=;
        b=Qyhflb+Jy0x/CtJUmFkcfrx5cigGsMFv/x9a1d297V2amuvC2Z27kO9LxUAwAvud6U
         T+pP5jcozfXcai8/QfsUGkHIo2ytvLUbXlopRKGRgCDfUj044RkX7wlnPNRq8RvXRQ85
         t5TEN0btcsIE6r68x70rqJ7Ho2mMvIvUORpe3fVcgV9ZS3QGSRLA/tXu4/qM4/CISATA
         K3OEtamYzc5lB9qUsmFJxK+xennbJt4Wa7v9tSKnmTkb5sSIFJ0mUxiM27RLocTbRI5u
         3ZHicfdpTpLCjHlXddfLmArIpPXWrr3+lKdYvua3jvYr7Jgd/ywxpKwV5SZ1dP0Pp8Ml
         aYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DIUTi3R3RnB8XZ8jIbE4k6ovrlYAEKEjVvCfRHAa3YY=;
        b=LEVHpApvAwAp6lXsV4o497DqtwR4VY/hmOB9APSINzpqiX6ikO1LgMeorFX9v7Qgj7
         DJrwCovuNHTaVCGYTrOrOVchiDLjqIwpvGweYQGuJ7/gHoJPHjtooMAJJ16mYJUl34f6
         1l00nGiWJXV61D+k+KYOPu7sXdKN4rD3OZonP7CLGP8C+0+RzGii54aTznk2/O7DKJWn
         NRLnSxM63Znvq9w0E9hjckG6ULs7ZSNI+IaH3yiLqsaftnKgERanaRzy8UZ3YIr1Z1Y+
         9G980PN5es+kY/vySt6Sfetl3hggUPlkKzqabNuZgJCapp/nzlr8UJvjS6VUBSo8U/ox
         uJJA==
X-Gm-Message-State: AOAM531hneFcXVCfQM8ElAVI/ObIOknrev0tMcrhYgwKZnCyVimbdbe3
        tAYqO17R6xpLuB6j8K8HlHnAqFl4wGuVYWs3
X-Google-Smtp-Source: ABdhPJyY2Q706FR1fjy1C40dVBmor49bh/PRsL4RequqwGGgmHpwUfW0UVy8yoYHEz75RyKfWzMJ2w==
X-Received: by 2002:a0c:f6cf:: with SMTP id d15mr3847201qvo.62.1616491409335;
        Tue, 23 Mar 2021 02:23:29 -0700 (PDT)
Received: from localhost.localdomain ([143.244.44.229])
        by smtp.gmail.com with ESMTPSA id j26sm10597974qtp.30.2021.03.23.02.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 02:23:28 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        unixbhaskar@gmail.com, yanaijie@huawei.com, amarjargal16@gmail.com,
        matthew.v.deangelis@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH V2]staging: rtl8723bs: Trivial typo fix
Date:   Tue, 23 Mar 2021 14:53:00 +0530
Message-Id: <20210323092300.1740913-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/netowrk/network/

..and an extra space has removed from the sentence.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
  Changes from V1:
  I have missed to remove an extra space in the sentence,
  corrected,Greg pointed out,thanks.

 drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 2c9425e2a1e9..562bc929be4c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -599,7 +599,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 		}

 		if (rtw_roam_flags(adapter)) {
-			/* TODO: don't  select netowrk in the same ess as oldest if it's new enough*/
+			/* TODO: don't select network in the same ess as oldest if it's new enough*/
 		}

 		if (oldest == NULL || time_after(oldest->last_scanned, pnetwork->last_scanned))
--
2.31.0

