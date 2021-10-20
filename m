Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E09B4347DC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 11:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhJTJ0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 05:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhJTJ0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:26:14 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D56C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 02:24:00 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id t11so15691580plq.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 02:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yWl5yOSTlZxQV+P8niAYJJRlevXxIYBfkDqixsRoddI=;
        b=KFzxq6+Ri2N+fOMs/NGyNLqeZHBOJ0NdRypcnVsI0rVhwOaoZFAhg8yWVDUA1N85en
         6zUBcWuOaAg/K4pyz5T6CUQ9ztvvvAGKzgIB+rlDXukwFMK6CvA6vjMJFpm/JJbRbJSi
         T9PiZV1jvedIS8hbs4hQLJajYgmmh9jizeSmXz5GP6XxeQHxc7RZLVcvSpN8/KGKVlJT
         eTre1bK00XQ8IGvB3dDvu9HMLIceYMB8OZ3UQgNewmxMblRmPPT5rdGPu1Yc05KzAtY/
         kEhmnm0YO6vJCR2YaKHn+OyfbT7FaRM+WYGxzhuUsyWlo9mJhI+HXrpGT0h32hxupM6M
         OtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yWl5yOSTlZxQV+P8niAYJJRlevXxIYBfkDqixsRoddI=;
        b=xrnMcAyaEdeOQtaVgeKKAaFsv5iLEBFtMW9mXuG0ujHLzetetTF21eKTYTFL58LNgd
         pCZrUvJpiflnlHFL5Bh34TjKUcqyHs4rEZawRTarUjrErZwLpbNUGKubcVSFUcfxk1IM
         vbhIcdrmgLXRUv0bHzYIAd5SlWOzoXax873TBEvsQVKPYZbY05jKHdYUSRkN+5AbuV89
         oDmFaBkiZ1InDkXV7eOEQNshsq/Kxdxz5Z77WoPb02ZJ1fLOOMXnWyOQ+LGAMFm0098m
         2U9fv/IROB3SiUHcoWf8DP8Fc4mfnA8Cy7i44faxadEE0JpdQBleoAvakYM3JwRBaCEL
         4JpQ==
X-Gm-Message-State: AOAM531kPH3/hG3UUdwr50PADd4PnZwmD3kFyS88zex9IMJ7VaE/lM9Z
        PeQl8/uaznPUQu7XrQszttw89tbJTb0=
X-Google-Smtp-Source: ABdhPJw9uFlq2ikVBaBMFRNgYUl6bjM09HywY3d3x/LFLh2JlMD+SH+8QvPpi4Umx6NyXmAaolSykA==
X-Received: by 2002:a17:90a:df13:: with SMTP id gp19mr6029912pjb.151.1634721840264;
        Wed, 20 Oct 2021 02:24:00 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id nl18sm1947447pjb.3.2021.10.20.02.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 02:24:00 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.jianping@zte.com.cn
To:     linux@armlinux.org.uk
Cc:     ran.jianping@zte.com.cn, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH ARM] ARM: remove duplicate include in hackkit.c
Date:   Wed, 20 Oct 2021 09:23:51 +0000
Message-Id: <20211020092351.1039341-1-ran.jianping@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ran jianping <ran.jianping@zte.com.cn>

'linux/tty.h' included in '/arch/arm/mach-sa1100/hackkit.c'
 is duplicated.It is also included on the 21 line.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ran jianping <ran.jianping@zte.com.cn>
---
 arch/arm/mach-sa1100/hackkit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-sa1100/hackkit.c b/arch/arm/mach-sa1100/hackkit.c
index 3085f1c2e586..14cd646df9fe 100644
--- a/arch/arm/mach-sa1100/hackkit.c
+++ b/arch/arm/mach-sa1100/hackkit.c
@@ -18,7 +18,6 @@
 #include <linux/serial_core.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
-#include <linux/tty.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
-- 
2.25.1

