Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBA236F688
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhD3Hp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbhD3HpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:45:10 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204F2C061343
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:21 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id r12so103835493ejr.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VXGJ6BJNTyxC31APtHNNGgHRV6GpZZQxSZgzKX376VM=;
        b=qLuVph+PcXo+KZrNAROdoyGE2e5zsOk+PMtlgwGWITrVbTwIMh5HwZQmDoszPecVYF
         nvoo+0AKTnBTgGUDNUNEaY1tK7/ToXARsw93DFJ8Qh2+0yQqw7Eso5QOJnKMFWk229t1
         TLiTMOGcBGVCuPnanm8xkwmK1ieB8rLzPU1Ao9I8vU6o8r4ybq1RBQPLHfyhxXNvg5I0
         zd4EThU1ZCRJY9DJUT5DGy23DmGKHBb5OHplD06QfU6DoOEuY2MNWgpYX8LbkRMm99Bt
         Q1J1HWEaJntaRO8OL03sm92OqqOKO3daEqYHIX7iGhjTs38edo1QhZ55qFHBxl7+dCcY
         kMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VXGJ6BJNTyxC31APtHNNGgHRV6GpZZQxSZgzKX376VM=;
        b=r9ThUk/GMumTsfPkZRsikeDNptNSw9SXSyX4j9mZCLqRJm+ua2gGNQYqonllwtTU6F
         AVG/DlfABCdsWIzH39SzClDxynOw07iQUl6fVm0piw3FUTzlAHXei4aXtVC4bfKKdIq9
         gpYOdj58JETsl/rn19AJQtpjhU0C0VdmcHa+hyAm92Q4E408WNvdor5E1NN/XVnLzdj6
         x7fpkmDXRlkE8YcqJ97w0jxCXwtYjB/DiJ3RX1Q1gVF71tIy6jZ9/A97LJ/FQAtAnhGQ
         6QCPP0c+K7Fy0ZoVu10qytgiGPT8BPxPLDDjVnJFWRBWuRCjW9G+Ee2uBxxkFb8CjjjP
         hJGw==
X-Gm-Message-State: AOAM532ipWB59R+lUMFszHKdOfuojft+jn1Um16FgxKlhLPyMHIKuoUY
        R+6MGsQs2BmhjWgV4dkTjBbHqwDAOQS8aw==
X-Google-Smtp-Source: ABdhPJweM32GDcWIwAV1MVg4bHw7432Bm2PzfYb4i3k2yKt/1C3EuN7JN2Nd/pWCXxidBcvq0phB7Q==
X-Received: by 2002:a17:906:7209:: with SMTP id m9mr2842854ejk.223.1619768659735;
        Fri, 30 Apr 2021 00:44:19 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id b8sm663743edu.41.2021.04.30.00.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:44:19 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 09/43] staging: rtl8723bs: replace ODM_RT_ASSERT with netdev_dbg()
Date:   Fri, 30 Apr 2021 09:43:27 +0200
Message-Id: <6439b25d986369de899c5770390cb3e9fdd9e2dd.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace ODM_RT_ASSERT with netdev dbg.

Marco ODM_RT_ASSERT wraps a raw prink and prints a message
everytime second argument is false. This occurrence prints
always, so replace it with netdev_dbg()

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm.c b/drivers/staging/rtl8723bs/hal/odm.c
index 0027ce211619..fcd3f97e7df5 100644
--- a/drivers/staging/rtl8723bs/hal/odm.c
+++ b/drivers/staging/rtl8723bs/hal/odm.c
@@ -552,7 +552,8 @@ bool ODM_RAStateCheck(
 		break;
 
 	default:
-		ODM_RT_ASSERT(pDM_Odm, false, ("wrong rssi level setting %d !", *pRATRState));
+		netdev_dbg(pDM_Odm->Adapter->pnetdev,
+			   "wrong rssi level setting %d !", *pRATRState);
 		break;
 	}
 
-- 
2.20.1

