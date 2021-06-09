Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1141C3A1644
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236957AbhFIN7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237084AbhFIN7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:59:12 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64236C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 06:57:05 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 3-20020a05600c0243b029019f2f9b2b8aso4290930wmj.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 06:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GtTfat+z4qsQAJi7YljHJL6j8Luu+LN1kPWBAI8xkrI=;
        b=Oz9d7SxENkLcn6ZmKFrTlAY6yO3Sl2vU8BIckPyxXCA3jGc3xSIzRCN5yDAL71rrV2
         /eFhtwgsp7Hr4I1QQZZKvHY9+0HwENlW7GVuyqLMY4xCOAXMwgDLuDteYiOMxWlWg9am
         FguRTGD84yAC+xtVCzJ93eBZ10YfQ6lcwY+MmKxcM8AYnp3z0iklTvK5cBdsiEGIWwL1
         BqCwrnSbaYQjpzAG1mFTa+JV0xfZrVl0czC4WaLQ8XILXfCSGpHvBrG5A38NmzxiPuG0
         guCW0joUlHm+bIaYQ6UJFSphA1kzvDxwGrrm4JP7rEvA8eZFuLp8qB4Ki+R8hmjQgbZU
         /v8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GtTfat+z4qsQAJi7YljHJL6j8Luu+LN1kPWBAI8xkrI=;
        b=PmtGUb1NwggXgtB+WiLoRh5kq32VB1jRv4R+FdSR8o3qQCjBDqCvcL1CZiZVAt0NOG
         Gw1/hd0LmfLLeZK/As884KE+DayuBA/v23ogbMOcC/qNEbEcxVt7UyLyxRUqcBrONo7q
         1dV95epXD0Kf21yIN/OWva9wATgupppMGnnn5o5owKTMdySQWqDNtx0YbkgHDgkKH5wN
         4ZUcrlcLp/54/2THGQs/BctZN1YJOI01qZU3dh0ljyyXEtVaN1yoO472fnvLu/nGJdTi
         P6XIHdh5w4eyxHwoNeYsSgeMIqtVXL0gA5l0dkrHpk9+DjYd76i9VglvEi5748HDtX/a
         TpYA==
X-Gm-Message-State: AOAM530P3dDd3T9ine8DkNm1E2qvVR6TRUDS4D18X4IMFyHHncQxoYM/
        FVIJoXYYNYnOks7QWX1hIRc=
X-Google-Smtp-Source: ABdhPJyenGGxO0xTSduJkCYgtGWUtvIzPD49vQozB55tcOO1w2HX6zCncb3BiaF2lQnGGyvuzTPFPg==
X-Received: by 2002:a7b:c954:: with SMTP id i20mr27713184wml.161.1623247023914;
        Wed, 09 Jun 2021 06:57:03 -0700 (PDT)
Received: from linux.local (host-82-59-55-132.retail.telecomitalia.it. [82.59.55.132])
        by smtp.gmail.com with ESMTPSA id q5sm20819898wmc.0.2021.06.09.06.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 06:57:03 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: rtl8712: Replace printk() with netdev_dbg()
Date:   Wed,  9 Jun 2021 15:56:59 +0200
Message-Id: <20210609135659.4054-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced printk() with netdev_dbg() because the latter is preferred in
network devices drivers.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl8712_cmd.c b/drivers/staging/rtl8712/rtl8712_cmd.c
index e94604cb71fd..e9294e1ed06e 100644
--- a/drivers/staging/rtl8712/rtl8712_cmd.c
+++ b/drivers/staging/rtl8712/rtl8712_cmd.c
@@ -55,7 +55,7 @@ static void check_hw_pbc(struct _adapter *padapter)
 		/* Here we only set bPbcPressed to true
 		 * After trigger PBC, the variable will be set to false
 		 */
-		printk(KERN_DEBUG "CheckPbcGPIO - PBC is pressed !!!!\n");
+		netdev_dbg(padapter->pnetdev, "CheckPbcGPIO - PBC is pressed !!!!\n");
 		/* 0 is the default value and it means the application monitors
 		 * the HW PBC doesn't provide its pid to driver.
 		 */
-- 
2.31.1

