Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5F2453E8C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 03:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbhKQCqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 21:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhKQCqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 21:46:20 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9300C061570;
        Tue, 16 Nov 2021 18:43:22 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 28so871088pgq.8;
        Tue, 16 Nov 2021 18:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3bBAKF0rXpsZjZFTjDb9z1siKN7G6tFghunlSlXiQ9I=;
        b=ovKK6pdy7X3TMzw5Id05nYQcyaFRpS/LtqyZtASwum9k/xccxDLSorMGT5CbnftqxA
         XEhfa1wfnXic0oKCUH7/RkE/RJjsgNbHVKkd4lTVYANvjVfhhGa19FPjCea8vf7QCIlF
         /EonpBfWyD8G+dhIyqjKr1fnd1WBHQAljcgK2FcmRmNAan9fxKJ0b9aSgTEgguFNK5ip
         99il3POCWICmIum9u/iXbkwlpRREzFRbdQNAO9Ruz2eL1QtbqniepRyCbCmqV9OkPkcb
         OhCccYd4f0OMkASdHiEh2o5OStlRZY5SGpFY8rdlqUkUA/AZ+7TG6zY29OfIpFca7B0b
         Lp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=3bBAKF0rXpsZjZFTjDb9z1siKN7G6tFghunlSlXiQ9I=;
        b=YVnzmngak0JqKRE2rU/44oFQovc3AKsOC7sjGzA4gbjCamzFVfk2t4Rpsj/D9P6Ueq
         rDBY7vWxoVgV3iifTYF174zC0JHPOY0xt6VuuqKcZjrS35CUYYZSFs7UJaQJ59HRQrfC
         G+MdIv9zJm12HYTxaeVumv+i89+2Ua71EGH2Gt/PurBYpuSZ7y+yCZ9YTfdfgc7PkX2I
         MymBqRnDkcuzx7h506JxgTIWav/ORoqR73RC1w+9QiJ/5iiKQiMCT9J3/sSu2as+n3SX
         rb/LaknnvSGKYZKAXmR3g/RHedtpXRWiRxMIkJv/9tPT0FyUfh/W0u2LB0y4vHoUSChx
         TViw==
X-Gm-Message-State: AOAM530dfKqwVMMPbKvAtqSqXuJfNLlUuAkYjO8K9qQJj+8X/UgdkPWS
        Ztiwu2ykPcsufpaiegfAZQDyv8/p0FY=
X-Google-Smtp-Source: ABdhPJwsu3lOa8+LnXL+RdutnbP+/ngMRwtx2zSdGeySsV+9gWGvLuqtUTSKRijJpH7R4X5439B87w==
X-Received: by 2002:a63:c00b:: with SMTP id h11mr2774774pgg.207.1637117002335;
        Tue, 16 Nov 2021 18:43:22 -0800 (PST)
Received: from localhost (220-135-95-34.hinet-ip.hinet.net. [220.135.95.34])
        by smtp.gmail.com with ESMTPSA id k5sm2909900pgt.49.2021.11.16.18.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 18:43:21 -0800 (PST)
Sender: AceLan Kao <acelan@gmail.com>
From:   AceLan Kao <acelan.kao@canonical.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        SophieHu <sophiehu@aaeon.com.tw>
Subject: [PATCH] hwmon: f71882fg: Add F81966 support
Date:   Wed, 17 Nov 2021 10:43:20 +0800
Message-Id: <20211117024320.2428144-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Menghui Wu <Menghui_Wu@aaeon.com.tw>

This adds hardware monitor support the Fintek F81966 Super I/O chip.
Testing was done on the Aaeon SSE-IPTI

Signed-off-by: Menghui Wu <Menghui_Wu@aaeon.com.tw>
Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
---
 drivers/hwmon/f71882fg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index 4673d403759a..938a8b9ec70d 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -49,6 +49,7 @@
 #define SIO_F81768D_ID		0x1210	/* Chipset ID */
 #define SIO_F81865_ID		0x0704	/* Chipset ID */
 #define SIO_F81866_ID		0x1010	/* Chipset ID */
+#define SIO_F81966_ID		0x1502	/* Chipset ID */
 
 #define REGION_LENGTH		8
 #define ADDR_REG_OFFSET		5
@@ -2672,6 +2673,7 @@ static int __init f71882fg_find(int sioaddr, struct f71882fg_sio_data *sio_data)
 		sio_data->type = f81865f;
 		break;
 	case SIO_F81866_ID:
+	case SIO_F81966_ID:
 		sio_data->type = f81866a;
 		break;
 	default:
-- 
2.25.1

