Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D4C3A6F5C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhFNTtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbhFNTtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:49:15 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC3AC061574;
        Mon, 14 Jun 2021 12:47:00 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n7so9587398wri.3;
        Mon, 14 Jun 2021 12:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AG81bnuj7Ds0VoaAuYMA0QCooJitxDZ8k9RGpVjLaAU=;
        b=IdnozBOdsyHczY/+Ljn57ccH/GHZULAC8coxhu6LQ42LbWmGg4Zn2bW4/V/EF7uzq2
         /d4Se3uzsLLIvk1gSyb3FfllzUqjF3n63hCtnjteR22kxgUMbdiZfgslV43eeMS+Xq4S
         JxBENZ1cK9BNWIoGOiERC/Dl+ECvpCaVh/AQzeLx1W4qxKQvfvvAIYiuWRVetKKLxNm4
         SeIWjNX3OeIKum1rp2+f5/67705K1iPzxMJQY4XWdK6dxm2YvC7ovwT6zK+slUTegkUp
         SzWoObUV/1dK9psbkPq/rzYxX6k5nLxHsFhlX+kLJCgrcHwpxjZNO48qThqFWpHozCt1
         Lrpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AG81bnuj7Ds0VoaAuYMA0QCooJitxDZ8k9RGpVjLaAU=;
        b=gaeTkezEVIGdRA1HFufJ5YvSRUo12FG4ixMNsdHnA2pqTvP5XFtyD7xMToauDIUtOy
         wJHptXxHrg4z4/9a7yy4pduvixKUzbJ+vqr0wwLiU0kPa/49KIdCpzp5fp25Wt9OkT5e
         oQ54yf4397qymHpSfLsjxf8ZzIAtH13yBw+11dEsHxYGCwJojyfLlAFJiSCVhOtsNsco
         /Cvr5v8xDzTZc48piNSrTu96CANhoIyP1xcuQFU9A7Zoafroil+P7U03RS9N1zvuAvK1
         b7fhZLX5jSwCAy7QPMXote4irdMN+Z5GcBwpTtjwq1152UaAZpAvT/i5RvPY3PLQ7YNq
         Bp8w==
X-Gm-Message-State: AOAM530X5lOZJ0qeIyVYyMi09V5qwiW5PX2WW2l5LkvPDT7tDrGj3Ini
        8Do0Lsg6WJL8IhcD8ENQyck=
X-Google-Smtp-Source: ABdhPJyporis3EOVRxPHw3JRbzRXtLa/sBpEPMXX5quijMNYP/pLxTuq8wgADodeqe4EyMTOJULeLw==
X-Received: by 2002:adf:dcc3:: with SMTP id x3mr19757071wrm.177.1623700018037;
        Mon, 14 Jun 2021 12:46:58 -0700 (PDT)
Received: from xws.localdomain (p5487b5f5.dip0.t-ipconnect.de. [84.135.181.245])
        by smtp.gmail.com with ESMTPSA id f12sm20280194wru.81.2021.06.14.12.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 12:46:57 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH] MAINTAINERS: Update IRC link for Surface System Aggregator subsystem
Date:   Mon, 14 Jun 2021 21:46:35 +0200
Message-Id: <20210614194635.1681519-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have moved to libera.chat. Update the link accordingly.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 142d4baa4f0f..7e38764f778c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12190,7 +12190,7 @@ M:	Maximilian Luz <luzmaximilian@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 W:	https://github.com/linux-surface/surface-aggregator-module
-C:	irc://chat.freenode.net/##linux-surface
+C:	irc://irc.libera.chat/linux-surface
 F:	Documentation/driver-api/surface_aggregator/
 F:	drivers/platform/surface/aggregator/
 F:	drivers/platform/surface/surface_acpi_notify.c
-- 
2.32.0

