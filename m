Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00191307D60
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhA1SGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhA1SDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:03:37 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB1BC0617A9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:02:47 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id m2so5041275wmm.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 10:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=azFmqObNrsq2Y9KjmcVwLZnWbMejrbRgZoxiCEhbXjM=;
        b=HNGSfsRPfXOsvjYZ7/0xtd7uCashfdor2Eo/qkjTDPQH12ec/MO+9jNMbB/dyUMQJF
         7g7ReSrcfoqkCpBh36rKtsCpmczMvqyXaqetvt0+xbGorohmXiyHF4TV6gSc/b823c4F
         Vj0PNNYViEBVsnqcbx1shl+9VrWnH6e0WqnUQIwB1IAe9c0ExAWS1DFrBTcxuUQA2YBx
         BEBQH0xDA2qAMIH9+d18aK01tAQU8lO0h3mmIOeJgtduRGovJYc824139kQtmg8YqrlQ
         lSYBB4/O0IG4u4n7m3Z0LgwauIq46AiQHti0NdSxXJXdIR/QdhDfdcDyU3XzbKRnKp9B
         qXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=azFmqObNrsq2Y9KjmcVwLZnWbMejrbRgZoxiCEhbXjM=;
        b=tfjpreW0PzXoL11RwPanSJWHcE5ON4IVVzKb6m5S5WqzIq0wj8kV68iG1pPZg6+yP2
         YfQIh9ww6kP8jZi9sG65lZP7SVmOssZLuQ0ayN84cmNP8G3eEBbC7z5aj1LaYdOdhQl2
         Xx38KYyBV+ePKp+ZC7CgQR+a1lw0cOHXvWyRr90CRYsjtLX2DiWDzGQ68FHNhfoCAQ9z
         t6JHyvHhLrfBBhaeNQ7QnfshXNAsy28jJCQ1InyP6jtBvSMbll8UCR3JI7Z7nf2T0uL+
         EqiuazSPrWt8W4wSI7MRqKXEZPpTOhJfO5h8GqtZOCH7m0MGe80j3COb50kdTAAvM9lZ
         /j6A==
X-Gm-Message-State: AOAM531fCC8jnzCEKTGPxGqr+PHeTPKtj+DDrCHjmpQfxqrraZjE6qLU
        1CP8rXQFQPeu1qeA380A9paFfw==
X-Google-Smtp-Source: ABdhPJw9yt3wZkSFszLXr+EE6OLfe4qNPCK4cG+E8VjybhnGF87k5wzXMes6R+iUcVwPwSLVR6gq2Q==
X-Received: by 2002:a1c:ab57:: with SMTP id u84mr422142wme.115.1611856966567;
        Thu, 28 Jan 2021 10:02:46 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id u6sm8280794wro.75.2021.01.28.10.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:02:45 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: [PATCH 03/20] ata: ahci_platform: Ignore -Woverride-init
Date:   Thu, 28 Jan 2021 18:02:22 +0000
Message-Id: <20210128180239.548512-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128180239.548512-1-lee.jones@linaro.org>
References: <20210128180239.548512-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some ATA drivers use the SCSI host template, a series of interwoven
macros, to aid with initialisation.  Some of these macros conflict,
resulting in the over-writing of previously set values.

This is known behaviour and can be safely ignored.

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/ata/ahci_platform.c:21:
 drivers/ata/ahci.h:387:16: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/ahci_platform.c:40:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:387:16: note: (near initialization for ‘ahci_platform_sht.can_queue’)
 drivers/ata/ahci_platform.c:40:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:391:17: warning: initialized field overwritten [-Woverride-init]
 drivers/ata/ahci_platform.c:40:2: note: in expansion of macro ‘AHCI_SHT’
 drivers/ata/ahci.h:391:17: note: (near initialization for ‘ahci_platform_sht.sdev_attrs’)
 drivers/ata/ahci_platform.c:40:2: note: in expansion of macro ‘AHCI_SHT’

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index d24bf4d2b08d6..c7c26a0ef7632 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS_ahci_dm816.o		= $(call cc-disable-warning, override-init)
+CFLAGS_ahci_platform.o		= $(call cc-disable-warning, override-init)
 
 obj-$(CONFIG_ATA)		+= libata.o
 
-- 
2.25.1

