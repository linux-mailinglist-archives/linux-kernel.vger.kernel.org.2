Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B84F44BA56
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 03:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhKJCfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 21:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhKJCff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 21:35:35 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A938C061764;
        Tue,  9 Nov 2021 18:32:48 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso332347pjb.2;
        Tue, 09 Nov 2021 18:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZEwpuSt1yBiIjYpLPBsJFt6s3rbMX5bKS5GbakO7x30=;
        b=OCX8Ml0Ev46RRm5TOXit5PsCU+sqbr24cVpdt+EV5lVRPYUksHcpCBOOlauVyYNtnx
         1/hOCKdSdqK//YHQZd0M6S+0Qg/N/68RFpEHico/F5jVIQAq2Fpq4HkTQSbtbJsiCfXE
         k71OXN5Oism8+BhvYzy2dv2MTETHSe8/r1h3DF3pm7bkSwO1Zhi1GJI4Up27ZYj/Ccsy
         hs1ZSVWw08GTJhH5AhYLUI3h5L1pwaVQSsINmkghX7G0UEvM6SYRNGVFtk7UGv22M79j
         aHI4zyDd1gi96bcmTJcxdkAoU2E90bCkXRNdklflQi/spOMc2qJMCbdCXqqH8d9sGNRy
         kl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZEwpuSt1yBiIjYpLPBsJFt6s3rbMX5bKS5GbakO7x30=;
        b=lSNnyBGt/gw1ENfjtk76vFH+JL5Ac95Wc/89imWbA7iV2/sY0+OUwU5cGugrKgVuRN
         MOyJAZZWWX95dAVg8tnR4cbPVENensTGeXlPh42O4oPbAnguHZdTgzBOz8pFQdI3w1QS
         fFWxZsiJv8K8YNAfYNJa87yLXA1M++wSQqKxWubb4Q21kMITJrMHWcX1iAm/byXQLgrR
         kUhCa8ehnq4Zu2uV1M1VOnenHQLkLYdgbxpVzA311NmTABj85zRSB0ZXQpmS+NwDWsTo
         AUcWx4S/f2w9xDMDdTNcaVOlPavd6HAB0RXv7lG9AAyL+mIXRCIxaK7TtzNeuWcgyvBB
         0QrQ==
X-Gm-Message-State: AOAM533aHXFHf7uEiNATsNwxlK4BpXdDMx1TQ0v9I3rGkCZZWitZHY6V
        yO9SxKoh1wKNtDGWzMRIvB4=
X-Google-Smtp-Source: ABdhPJylO+oOtoUeHKlNYNhuXwCSwhrDGslaljnjVvvJYTcG5z6gxwIWaO48mjrgLmvA2ThG+la9Vg==
X-Received: by 2002:a17:902:c404:b0:142:28c5:5416 with SMTP id k4-20020a170902c40400b0014228c55416mr12627173plk.62.1636511568486;
        Tue, 09 Nov 2021 18:32:48 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id co4sm3842938pjb.2.2021.11.09.18.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 18:32:48 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: yao.jing2@zte.com.cn
To:     valentina.manea.m@gmail.com
Cc:     shuah@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jing Yao <yao.jing2@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] usbip: vudc: Replace snprintf in show functions with  sysfs_emit
Date:   Wed, 10 Nov 2021 02:32:44 +0000
Message-Id: <20211110023244.135621-1-yao.jing2@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jing Yao <yao.jing2@zte.com.cn>

coccicheck complains about the use of snprintf() in sysfs show
functions:
WARNING use scnprintf or sprintf

Use sysfs_emit instead of scnprintf, snprintf or sprintf makes more
sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jing Yao <yao.jing2@zte.com.cn>
---
 drivers/usb/usbip/vudc_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/usbip/vudc_sysfs.c b/drivers/usb/usbip/vudc_sysfs.c
index d1cf6b51bf85..6af594bd3d5e 100644
--- a/drivers/usb/usbip/vudc_sysfs.c
+++ b/drivers/usb/usbip/vudc_sysfs.c
@@ -242,7 +242,7 @@ static ssize_t usbip_status_show(struct device *dev,
 	status = udc->ud.status;
 	spin_unlock_irq(&udc->ud.lock);
 
-	return snprintf(out, PAGE_SIZE, "%d\n", status);
+	return sysfs_emit(out, "%d\n", status);
 }
 static DEVICE_ATTR_RO(usbip_status);
 
-- 
2.25.1

