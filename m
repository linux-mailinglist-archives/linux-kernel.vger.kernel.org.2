Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B703E3122
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 23:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245233AbhHFVd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 17:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243571AbhHFVdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 17:33:25 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D871C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 14:32:43 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id y16-20020a4ad6500000b0290258a7ff4058so2577924oos.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 14:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0FFKOfNVS5j/32Zs1ttdVtGfFgL6Hp+Qlqyo96Y9neY=;
        b=SbCCan87vLHRS9fzbj82MVNv0FEhyJ2TuWHyP/huHeROPSRKo8yavpOj9UVbkchFXL
         arba7bkHfZG4wYKtD6JPxnZWNL+qIM+wstEdl8xoS4LjZHkkN5KieE7h+WGjXW97/U8R
         E1s+OBF+pWS9B+rN7/sNg534UYFaj7NrQq0jH/O+15QvVHawzeuVpmFOfcpBBbymixBS
         gxnoms/rr0fpdgtbUXKi8PXI51JTwWm30hT48tXCPROIN5S7/lg59LudtLDXbx6a92rW
         DiHtwXd4FgOXznLO3LZqurk4Lq2+Gsn+qNCr1c7cacrBL1B/gvINZnUjOuG7nUQjrxIa
         OhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=0FFKOfNVS5j/32Zs1ttdVtGfFgL6Hp+Qlqyo96Y9neY=;
        b=R2uZ912QanQBdnGA5P00A4oiACckk4vs5OEZRFsklHVQV6HXnKSbCssYXEEEE3HdHm
         rQx1MnRVvhcE7jFcjOj9RMTfU1K76SB8o42Q5JwAir058MeUsVc6ze++Q6XkROYX15qq
         4SgM9t9JNhOxbsrsqzUKqJfReIzo/C6kX08OjKSSoyUw7phONDnFuAQGHI7sqFqAxTQ9
         XqKe174grOt2r/SVU56E8NX/O8bMEaKaCWgNrO+rpMic/e891He+vcYzVEw8eYqEF9K9
         ujnIunKA5v1VRiL2yuEo4XxxdlvDI2mnHnG+aXLi4c4xAvYRB8PiG8snQdFHp+igcRnE
         4jFA==
X-Gm-Message-State: AOAM532AKx1KgsNYQALZo8eojeZfe7e7pT114tH14GNys9Komcm3aNoS
        TjVp/eOYvvQieU6eBwUBh7V47JhLGmY=
X-Google-Smtp-Source: ABdhPJzam/GUFFewKobEvnxt+6II5fjJ1JU2Z/09c0B8BunffUD/RI7cHK7yNlhqNGLBQBcxZ2C7ow==
X-Received: by 2002:a4a:ea37:: with SMTP id y23mr6892930ood.39.1628285562534;
        Fri, 06 Aug 2021 14:32:42 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id d7sm1504882oon.18.2021.08.06.14.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 14:32:41 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] staging: r8188eu: Fix potential memory leak or NULL dereference
Date:   Fri,  6 Aug 2021 16:32:35 -0500
Message-Id: <20210806213235.22349-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In routine c2h_wk_callback(() following a kmalloc() call, the
error recovery is flawed. If the kmalloc() returns a pointer
that is not NULL, and the following c2h_evt_read() fails, the
code will leak that buffer. If the kmalloc() fails, a NULL
dereference will occur in the following code.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index c3a9051ca10c..238ae79f4141 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1908,8 +1908,12 @@ static void c2h_wk_callback(struct work_struct *work)
 			c2h_evt = kmalloc(16, GFP_KERNEL);
 			if (c2h_evt) {
 				/* This C2H event is not read, read & clear now */
-				if (c2h_evt_read(adapter, (u8 *)c2h_evt) != _SUCCESS)
+				if (c2h_evt_read(adapter, (u8 *)c2h_evt) != _SUCCESS) {
+					kfree(c2h_evt);
 					continue;
+				}
+			} else {
+				return;
 			}
 		}
 
-- 
2.32.0

