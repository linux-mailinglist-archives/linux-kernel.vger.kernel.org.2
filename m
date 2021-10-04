Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8767C42050E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 05:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhJDDQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 23:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbhJDDQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 23:16:05 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B39C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 20:14:15 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id x8so2915504plv.8
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 20:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RKnjjVOVAOCInl/nMgbxZfi/GBeRFnh4ynzj/tmEXRI=;
        b=kpLA465SHWMY05MKq0WxlBMzhIp3REP3vUwciyH55Un7boa2U2LWarStF9LHxVzvVI
         fJuobPWki3xq7eiK2VHUwVkqAbYp2F0yf/fov8LuiD35leNWSFTchCM04SQim4ymMSHC
         Pxpkl7SFe9cUZOGEglSBtHh8PD2WpCUDt3FfMfbSZnB4Ow5ok6SDlKZNJF9TVugsRUry
         +Tr8SWeq4e6PeSJJqoblTg69kQi2FCQu5LOmID/wZccTAs3r5YDOD7MyKkywbHhV9iJt
         wViCUeKWHj9JSoVmv5w+/+VTCvCZlifbS4GDLAbm6Ktgl6sKKj38htMuaIrXNKg9CipJ
         ZDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RKnjjVOVAOCInl/nMgbxZfi/GBeRFnh4ynzj/tmEXRI=;
        b=mX8/PNgTuIfxFJp1Y2vRvQjlQk9QHXW3GG1g+GXn2mYg/kTe+jy7YwoDfAxsA65B9C
         Sadh+x9b4rJ+nSDyjdeD6OMmPYOKm8+O2Jov0ia0hllDVWmv4X1ZuyfjB83A7lRoVXTy
         L5BvW8m4QQH1dZO9ZMz/ScLyrdrwpm3RX0prkaHa215XAXABmA+l7jFJMjbAic/nRmDX
         GhE/D5WbAu/L05e52FUnqU0NoJghv/1qL2k4y+HD9elsEHatSuqx60SD5AjJ83upuKrW
         GkM1fuPtU3BJnseSWW7nniVyQyj2UMzvuLAmLbQWvtNnbYxixafMuR98GpwwcyJ3DB1o
         M33w==
X-Gm-Message-State: AOAM531LnizajJIO911jeWNwwKWyerMmATTLILi7qIN3mwda2zF0uohn
        iFFW0PbYZubfqaL5gbiMAkM=
X-Google-Smtp-Source: ABdhPJy8WjH+EK+vaTNiU+WotRSwzTTUkUu4dhGqhndTit+hx8sYVCPmpILJIvG5KBYU0nsZHCnvOw==
X-Received: by 2002:a17:902:6947:b0:13e:8e8d:cc34 with SMTP id k7-20020a170902694700b0013e8e8dcc34mr12787700plt.88.1633317254581;
        Sun, 03 Oct 2021 20:14:14 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:ecea:c8ec:ff7b:52])
        by smtp.gmail.com with ESMTPSA id h2sm11035776pjk.44.2021.10.03.20.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 20:14:13 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: xtfpga: Try software restart before simulating CPU reset
Date:   Sun,  3 Oct 2021 20:13:41 -0700
Message-Id: <20211004031341.20297-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Rebooting xtensa images loaded with the '-kernel' option in qemu does
not work. When executing a reboot command, the qemu session either hangs
or experiences an endless sequence of error messages.

  Kernel panic - not syncing: Unrecoverable error in exception handler

Reset code jumps to the CPU restart address, but Linux can not recover
from there because code and data in the kernel init sections have been
discarded and overwritten at this point.

XTFPGA platforms have a means to reset the CPU by writing 0xdead into a
specific FPGA IO address. When used in QEMU the kernel image loaded with
the '-kernel' option gets restored to its original state allowing the
machine to boot successfully.

Use that mechanism to attempt a platform reset. If it does not work,
fall back to the existing mechanism.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/platforms/xtfpga/setup.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/platforms/xtfpga/setup.c b/arch/xtensa/platforms/xtfpga/setup.c
index 4f7d6142d41f..9b1e36b06530 100644
--- a/arch/xtensa/platforms/xtfpga/setup.c
+++ b/arch/xtensa/platforms/xtfpga/setup.c
@@ -51,8 +51,12 @@ void platform_power_off(void)
 
 void platform_restart(void)
 {
-	/* Flush and reset the mmu, simulate a processor reset, and
-	 * jump to the reset vector. */
+	/* Try software reset first. */
+	*((unsigned int *)XTFPGA_SWRST_VADDR) = 0xdead;
+
+	/* If software reset did not work, flush and reset the mmu,
+	 * simulate a processor reset, and jump to the reset vector.
+	 */
 	cpu_reset();
 	/* control never gets here */
 }
-- 
2.20.1

