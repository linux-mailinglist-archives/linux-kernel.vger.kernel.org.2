Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503DC3E013D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 14:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238141AbhHDMey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 08:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238134AbhHDMex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 08:34:53 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D590EC0613D5;
        Wed,  4 Aug 2021 05:34:39 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id b128so1110377wmb.4;
        Wed, 04 Aug 2021 05:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bscLBBxSp/7m6JERdqYQYKeE5EKDs4x7qnAlAbmwuL0=;
        b=cVIPMYunR9QGCxscCjq36YV26aj+lLbUre/c+a5AFodLgyWBZTVjLKAHDByUO5tDAU
         63B4tAEnA4uMQcumEeA3HswgOFR9vngVTB79OZZCIvUmIT9BDJK9qee+0NbF7DUM1BHu
         jSBySiFTIr2f0fQENHBmlpFnGt1N+vMzPNagss9QWfX1rhRbAx1bPZ9rYpEK5g2l1k6k
         Urd2sRsGTxxGNNc9lPt5bUi9hAlwpbRQtJIj/TPsw3L3RfTtiQE/3JxoDiC4n8X9gANd
         EBy8vi/J5BxZuK/Q2UrZyTxBYYsa2Q0uPbhc2ve75nbRrZojf9DiiZLXST4fkQaY0X2y
         fyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bscLBBxSp/7m6JERdqYQYKeE5EKDs4x7qnAlAbmwuL0=;
        b=idRilUtmRBG2QHCtuJ/keYlAwEc57KtpPwnR+p3BKQkAvqh+CVG5vwG6dn2YDEloWD
         Lt5caKSkqTIwkW/ZMS37rL7P0BtZ7itzlEYl4d65FOo3yy3bRd2Zu0O7GlEqehmNltis
         NaP5VQnz9toFwu0Bjfw6DLzCpcUx4uMt+/GyGVer9F/zhGAWE+t8xD4VZOES5VImXfpr
         68/smT4b6gwYVBRcvlx071CX5aqQJeYGBQSaXJOTFAFNQxc/KBRR/Zr6rvCR0ltn5lrY
         RfE5GopP4WtsJ7ucnyyUnqg3xLA0z6+gLvD00ejomqCTOTCwyyCdiEIwp4L19t8CzD1X
         0qyg==
X-Gm-Message-State: AOAM530npB80YJP+Z+M8mthNshNpZY9MP9qryyzgmjxdPMFMObf5iWza
        gtD2ZIszRl+QqqmuTvloSFQ=
X-Google-Smtp-Source: ABdhPJz28qlyXIdrRNei1ra9BQlpFIw2V+T3iu5LkTQLtGY0rLTJzDpVjPNGxx3U2oHVeAE/0fKTJg==
X-Received: by 2002:a1c:7fc4:: with SMTP id a187mr26280525wmd.15.1628080478437;
        Wed, 04 Aug 2021 05:34:38 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d4a:5b00:f5aa:e9bf:ac96:6276])
        by smtp.gmail.com with ESMTPSA id g138sm2620158wmg.32.2021.08.04.05.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 05:34:38 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Randy Dunlap <rdunlap@infradead.org>, Pavel Machek <pavel@ucw.cz>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 1/2] leds: trigger: remove reference to obsolete CONFIG_IDE_GD_ATA
Date:   Wed,  4 Aug 2021 14:34:25 +0200
Message-Id: <20210804123426.16947-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210804123426.16947-1-lukas.bulwahn@gmail.com>
References: <20210804123426.16947-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b7fb14d3ac63 ("ide: remove the legacy ide driver") removes the
definition of the config IDE_GD_ATA.

So, remove the obsolete reference in ./drivers/leds/trigger/Kconfig.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/leds/trigger/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/trigger/Kconfig b/drivers/leds/trigger/Kconfig
index b77a01bd27f4..1f1d57288085 100644
--- a/drivers/leds/trigger/Kconfig
+++ b/drivers/leds/trigger/Kconfig
@@ -34,7 +34,7 @@ config LEDS_TRIGGER_ONESHOT
 
 config LEDS_TRIGGER_DISK
 	bool "LED Disk Trigger"
-	depends on IDE_GD_ATA || ATA
+	depends on ATA
 	help
 	  This allows LEDs to be controlled by disk activity.
 	  If unsure, say Y.
-- 
2.17.1

