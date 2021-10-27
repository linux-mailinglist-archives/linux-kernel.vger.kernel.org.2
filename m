Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838E343D1C3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 21:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240436AbhJ0Tj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 15:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240359AbhJ0Tj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 15:39:56 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E8CC061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 12:37:30 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 82-20020a1c0055000000b0032ccc3ad5c1so5275335wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 12:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SicCXKs6bSeaSHXuCyXJT0xoCckIe95FFIqDwjDPpxE=;
        b=UoS2p0zSnHCj/U3wgISw9M3NprbnEhSZAuHxiTbZZbuf+s86YMAjHslWqjlWp/ogLj
         RycbGFxi3hEpUbOFeiMFHw7H1X9hObav4GFmdEHSp2c6cfqD8rwEgFPK/kH0aAkN8faq
         9frDu8gK2vRgcrKNsjpasxukqPvvwYrZdi3zmOjY50wLvVtqrZlaM1VGnNa6Z+bVjXGH
         yADswbBibaCZt2RTuWonHi0zZ4YAXVVqBrLvKInQSQPhKGyLdsDC2yT2A2pSxm6VZfKo
         5Em8c93LThWqtkcwUby+dWyt3dN8Ex3Sm0BamSMx26jsMCbJfjgvPNR0ReSx0yrwCkIl
         tCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SicCXKs6bSeaSHXuCyXJT0xoCckIe95FFIqDwjDPpxE=;
        b=IF4U4t1do+yDPHhq4uDEWblIrxSDiTkizVthyACkMYQZRXNYtxU6RTaL+UILK3tSn7
         pVp7FILjS5OA6nWmWcdiGwdhepKhxuMt4gX6JsQWikaUJhReiM1hnwjdMTVwzoXlII83
         EDB/xJDjaLjrrASNcWKA+RTUw0g6Vs95S5Ud1HoNaklH1qbKTrZsofTWOhLmlX/RCb4l
         JXLtm48O1DLoqGUSzgWUJaEfgjH6+oYFKnxKCHB0OGJhHqt2unTLkAVY3XpXNJmzQaBf
         gMkGGicHeC4MQTByK+G9ZXnV3wXuJK0our2K4ZfNefcoIVGV3qRyApF3dsDHYtS2e9VJ
         Eg+w==
X-Gm-Message-State: AOAM531RYebAjYv7kCLJCi6R81iM8Zt0SYe4JkEiBJ37SymXBpp/D73U
        CzprthqtDhUU5isSFZ1b15gZFReyyA==
X-Google-Smtp-Source: ABdhPJyE6fQAD22yzcjm8AoGZ2IVi3KWinsRcFqwxs75vexeVwzBw7I0TmtQZehEdiF4gyGD9O/nIw==
X-Received: by 2002:a1c:1941:: with SMTP id 62mr7479043wmz.131.1635363449436;
        Wed, 27 Oct 2021 12:37:29 -0700 (PDT)
Received: from localhost.localdomain ([2.49.141.30])
        by smtp.googlemail.com with ESMTPSA id 6sm607704wma.48.2021.10.27.12.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 12:37:29 -0700 (PDT)
From:   vaatsalya shrivastava <shrivastavavaatsalya@gmail.com>
To:     manohar.vanga@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        vaatsalya shrivastava <shrivastavavaatsalya@gmail.com>
Subject: [PATCH] staging: comedi: Cleaned a bit of code that was not required
Date:   Wed, 27 Oct 2021 15:32:34 -0400
Message-Id: <20211027193235.5927-1-shrivastavavaatsalya@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warning found by checkpatch.pl script.

Signed-off-by: vaatsalya shrivastava <shrivastavavaatsalya@gmail.com>
---
 drivers/comedi/drivers/dt2815.c        | 2 +-
 drivers/staging/vme/devices/vme_user.h | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/comedi/drivers/dt2815.c b/drivers/comedi/drivers/dt2815.c
index 5906f32aa01f..2be240630bbd 100644
--- a/drivers/comedi/drivers/dt2815.c
+++ b/drivers/comedi/drivers/dt2815.c
@@ -17,7 +17,7 @@
  * contrary, please update.
  *
  * Configuration options:
- * [0] - I/O port base base address
+ * [0] - I/O port base address
  * [1] - IRQ (unused)
  * [2] - Voltage unipolar/bipolar configuration
  *	0 == unipolar 5V  (0V -- +5V)
diff --git a/drivers/staging/vme/devices/vme_user.h b/drivers/staging/vme/devices/vme_user.h
index 19ecb05781cc..3c1564fd9b20 100644
--- a/drivers/staging/vme/devices/vme_user.h
+++ b/drivers/staging/vme/devices/vme_user.h
@@ -14,11 +14,11 @@ struct vme_master {
 	__u32 aspace;		/* Address Space */
 	__u32 cycle;		/* Cycle properties */
 	__u32 dwidth;		/* Maximum Data Width */
-#if 0
+
 	char prefetchenable;		/* Prefetch Read Enable State */
 	int prefetchsize;		/* Prefetch Read Size (Cache Lines) */
 	char wrpostenable;		/* Write Post State */
-#endif
+
 } __packed;
 
 /*
@@ -35,11 +35,11 @@ struct vme_slave {
 	__u64 size;		/* Window Size */
 	__u32 aspace;		/* Address Space */
 	__u32 cycle;		/* Cycle properties */
-#if 0
+
 	char wrpostenable;		/* Write Post State */
 	char rmwlock;			/* Lock PCI during RMW Cycles */
 	char data64bitcapable;		/* non-VMEbus capable of 64-bit Data */
-#endif
+
 } __packed;
 
 struct vme_irq_id {
-- 
2.30.2

