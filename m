Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35C53536FC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 07:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhDDFkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 01:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhDDFki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 01:40:38 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC4BC061756
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 22:40:32 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b8-20020a17090a5508b029014d0fbe9b64so631343pji.5
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 22:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KxyeeXYM+0996CFKfGwExxixHCD5JVGi5ipPAcYMkSg=;
        b=Njl5EIu18L7UlpKpxbxVVOfMtbUa6XdKE32KhTWr8XmZeibmo+CqL73CX0Ka7pzrDU
         bhLaJ4YXoBFtqzuhFMwxgVShCIsXdn0Jj62uKWLrZitzhfRA/RKwvQFjf8BMKBupU5GV
         BIq1Izg3MhnDwt1vq01sLkGhKxuKI9p2rbIrWN7aSlOjgtmdvVfeNPlzuObtNqeGXWzF
         z2ijBHognMmIVt3iRVzKLxxCrzpZXm42a32+mNlOWACUpHey/f/IVTFhAY1ZNtehyd2B
         iunxT7L/KeLfyj85rvvZLkX6LRVdRm/6b2EGJJhT0VyBF0kuXmGDAmQB75egoNGAF+0H
         RFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KxyeeXYM+0996CFKfGwExxixHCD5JVGi5ipPAcYMkSg=;
        b=Un0Xkhm9OCF8MqkoTVGWWG8/tjuEgVxo5YebOSIYajzWSh6zQAAYZh3SztyFviGsME
         g9JWkQwoKhvhcrlFnmTNdly+A9+i/O3yd6Lw6PZoeg0kBuY5m7Y2kKyNu0NyIF26XITC
         O8uU1qqjm0CujnO/zZ2l1JQir/bjzdf/wUKf9madF3znS6KDaVBkjFHXTBdC6QsXojrc
         0M4KbXvcbQ2X9OROU9Zr0rLT44H9mfNlpkmZQlcSlKWRxbX9hnpi+MYGbkVwgnCe83oK
         fdbvIfVbXtKGiL83L0gRiuAzECcs5Ux9cBolPM5elYXuCjmkgvdHZy3n0mFSexmX7LzD
         8dcQ==
X-Gm-Message-State: AOAM533NgAKFLnbegZnKM+eJidmCTIIs6flAPmYXWqB8Z/bYBvSYSspm
        nW8Yv6Mts6PUhHoMJzeyNOY=
X-Google-Smtp-Source: ABdhPJwTY1G+qMQ0x1XLtf9HBFsor12CoiNfQtUtMDCoE+gLtjOl3HnvSXaAguMpmiMF09X2CbEMSA==
X-Received: by 2002:a17:902:8218:b029:e6:190e:48e with SMTP id x24-20020a1709028218b02900e6190e048emr19130071pln.33.1617514831530;
        Sat, 03 Apr 2021 22:40:31 -0700 (PDT)
Received: from djbComp.hitronhub.home (S0106ac202ecb0523.gv.shawcable.net. [70.67.120.89])
        by smtp.gmail.com with ESMTPSA id y7sm11759877pja.25.2021.04.03.22.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 22:40:31 -0700 (PDT)
From:   Deborah Brouwer <deborahbrouwer3563@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, unixbhaskar@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com,
        Deborah Brouwer <deborahbrouwer3563@gmail.com>
Subject: [PATCH] staging: rtl8188eu: replace goto with direct return
Date:   Sat,  3 Apr 2021 22:40:08 -0700
Message-Id: <20210404054008.23525-1-deborahbrouwer3563@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To conform with Linux kernel coding style, replace goto statement that
does no cleanup with a direct return.  To preserve meaning, copy comments
from the original goto statement to the return statement.  Identified by
the checkpatch warning: WARNING: void function return statements are not
generally useful.

Signed-off-by: Deborah Brouwer <deborahbrouwer3563@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188e_dm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c b/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
index 391c59490718..d21f21857c20 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
@@ -139,7 +139,9 @@ void rtw_hal_dm_watchdog(struct adapter *Adapter)
 	hw_init_completed = Adapter->hw_init_completed;
 
 	if (!hw_init_completed)
-		goto skip_dm;
+		/*  Check GPIO to determine current RF on/off and Pbc status. */
+		/*  Check Hardware Radio ON/OFF or not */
+		return;
 
 	/* ODM */
 	pmlmepriv = &Adapter->mlmepriv;
@@ -156,10 +158,8 @@ void rtw_hal_dm_watchdog(struct adapter *Adapter)
 
 	Adapter->HalData->odmpriv.bLinked = bLinked;
 	ODM_DMWatchdog(&Adapter->HalData->odmpriv);
-skip_dm:
 	/*  Check GPIO to determine current RF on/off and Pbc status. */
 	/*  Check Hardware Radio ON/OFF or not */
-	return;
 }
 
 void rtw_hal_dm_init(struct adapter *Adapter)
-- 
2.17.1

