Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577D935AE37
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbhDJOX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbhDJOVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:21:50 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8282EC06138B
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:21:16 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a7so13073728eju.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=75uzijMaXeM4/Fh+95uVhQDxEt+qvy+jANgJCzP36jQ=;
        b=ksHXqnnv8/h/I2BisfVI0eVxaRryQkJRHKRYd6dhEpq5U5U+mL03tLYSGIaVwHnlkr
         EOh5l0nY2T/KyJXJGdPE41RmkMf/16Ty2Ij3/D6Ro/L8LbEPG/auPFJU7cNRGej2uu+H
         vriPKe4wQFq2UCNws1w4z8R3XFNFUBVDqfeCdS6tKjJFVkRK9RUMBnJG8vXAMtMqnYaM
         CaHwrDHYjh8i7XbPK++N639AwCJa0wHbvWoOVjJ4mLBqyotOvxF8wpUyAoM4pyfNPnEx
         Ra4/wdIfXxDHiIp5TSZdEVVe7No5hvJy76eqoXRHRiRoOZW3Inl5JBFvlZhIcvqBd3UI
         fOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=75uzijMaXeM4/Fh+95uVhQDxEt+qvy+jANgJCzP36jQ=;
        b=RT1twNVwPXMkvekqV5RBLma4sApqP2i0JBCiIzk4tbSCePt8eObFLLp0ELZVVwDB9g
         6tYwwkjGEVXewydni0iOxKWUbJLxZ1KLUxM94R8ZMQypUTZPgIDuUc/4vQFGY+ZecVGB
         5uZ5jsS56yyEu5I+5IX4Aj+8wdhyEE26d+7DlWDw8aklvD+p6nhSuN3Kdbqnc1i/AOuv
         lozYrnGCYcQ/L9uee2zWWFXwNXo+vxlp19WX9noeDjnblGz9aqwQbdMUI4chJEhbXwqM
         r6nrYfdOc9CGruO3Zj3rfIV1N0ofYNZp1hiP/LsUlA500cm5n0TJynt8EKfHviBEM+da
         FAiQ==
X-Gm-Message-State: AOAM533NcUl5jY/wcFkoMLFJwCcmyPkEq+9pcMF5yREyAHrzy5w1u2lv
        HT839zoQQ/AMvYvxcQ9MXsSpLU1cQPDDEQ==
X-Google-Smtp-Source: ABdhPJw1Z+2EI7/w/oe2Njaf6Oaf1PDv6h984uE9U03dK5B51ZrfjPz9sNSVBiStHY12OtDZhbm1NQ==
X-Received: by 2002:a17:906:c9d8:: with SMTP id hk24mr20444378ejb.480.1618064475094;
        Sat, 10 Apr 2021 07:21:15 -0700 (PDT)
Received: from agape ([5.171.81.28])
        by smtp.gmail.com with ESMTPSA id z22sm2052818ejr.60.2021.04.10.07.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 07:21:14 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 22/25] staging: rtl8723bs: remove empty else block in os_dep/ioctl_cfg80211.c
Date:   Sat, 10 Apr 2021 16:20:35 +0200
Message-Id: <1bee993834410c2c11a6799e1868589efc1334f6.1618064275.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618064274.git.fabioaiuto83@gmail.com>
References: <cover.1618064274.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove empty else-block

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 39d0a0d24d2b..9c98820952e4 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1226,7 +1226,6 @@ void rtw_cfg80211_indicate_scan_done(struct adapter *adapter, bool aborted)
 			cfg80211_scan_done(pwdev_priv->scan_request, &info);
 
 		pwdev_priv->scan_request = NULL;
-	} else {
 	}
 	spin_unlock_bh(&pwdev_priv->scan_req_lock);
 }
-- 
2.20.1

