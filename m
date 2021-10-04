Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13628421970
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 23:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhJDVrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 17:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbhJDVrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 17:47:46 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FE8C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 14:45:57 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id s16so15689816pfk.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 14:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jnVUz7cckIzuOpFBzdErFnhTI+WjBJRaEaWrDbGSfDs=;
        b=Czpbi/3Bpn9+3YBD9owvuQYZnnr0sSH+KNYORW3yjVZRrBQDpf9rrGPBsojMISMe5r
         CVOFjSGpetj7UTT8eCgFhdKaZuh/4TZn+DBNaf9Kq2/rvKcbUHlypXztCdTMiGWpulFZ
         9KSameZ2qta1WVf6b3cPco2qjVJMOoaJLfHxeCNHFhibkpDP6WFVhA2nqF7XSuWXAMtM
         3L19kAsi7sxQPENYWpvZzy4+YHeY5+EykwHCcI/DxYUCbBpqd5W+H8cyJF2Ga9VDmdvQ
         RP+lQCKR3ZlIeVpUw0rnS5XsG94xNMYdCeK3SBnNYF8lyummYVKcYAlsig+Im3jwGIaJ
         0WwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jnVUz7cckIzuOpFBzdErFnhTI+WjBJRaEaWrDbGSfDs=;
        b=OIhfYnmuotrPaRzzrb+DNt0UYuQA9wUsMTE6BRUkJFszW5/YnVrI5+8LIG/P5+dO/w
         imxWZkNNhgYfbkwpwFQmBzXLLMYNMdUNneDswXR/IHPflcvaXMd0sCIOTXAZ+ppSD2oo
         bgTZ1D6rRhE2JdCMyx174ee/1ijUstA4pp03b2tfqjuYZ+hU1MQv04681Mvtdqf6EEbT
         Aba46aDSSk5lxp/T7zDT7GotxqTJsVvBOO8Cr9AMkY1YLwHjDaXDuNwLhf3+FB6qOwE0
         zNOUKzwXJNlHDHPYTgwe+hs/1viAMyRF3A4fLB9OWm22lcvpH6I2M3lO4RWgyBckB4i+
         Y1eg==
X-Gm-Message-State: AOAM5308Zy0rdCOTJ4DmJK/Ktrf8bPRs3W3yK6qre1y9/2nmYGMeRrIf
        Vg5OTA7e3eJ71xw49Lnvq5g=
X-Google-Smtp-Source: ABdhPJyQPQk7tibakHPa9HyUtQ344H/8GVmDY3hLpiJcwvGGK9meGllYjQA2vnTr438dx44dBt4jvw==
X-Received: by 2002:aa7:8116:0:b0:44b:e0d1:25e9 with SMTP id b22-20020aa78116000000b0044be0d125e9mr28136977pfi.53.1633383956496;
        Mon, 04 Oct 2021 14:45:56 -0700 (PDT)
Received: from octofox.cadence.com ([2601:641:401:1d20:ecea:c8ec:ff7b:52])
        by smtp.gmail.com with ESMTPSA id x11sm9372609pfh.75.2021.10.04.14.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 14:45:55 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2] xtensa: xtfpga: Try software restart before simulating CPU reset
Date:   Mon,  4 Oct 2021 14:45:44 -0700
Message-Id: <20211004214544.20167-1-jcmvbkbc@gmail.com>
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
Changes v1->v2:
- use WRITE_ONCE instead of simple assignment

 arch/xtensa/platforms/xtfpga/setup.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/platforms/xtfpga/setup.c b/arch/xtensa/platforms/xtfpga/setup.c
index 4f7d6142d41f..324f1f2aba09 100644
--- a/arch/xtensa/platforms/xtfpga/setup.c
+++ b/arch/xtensa/platforms/xtfpga/setup.c
@@ -51,8 +51,12 @@ void platform_power_off(void)
 
 void platform_restart(void)
 {
-	/* Flush and reset the mmu, simulate a processor reset, and
-	 * jump to the reset vector. */
+	/* Try software reset first. */
+	WRITE_ONCE(*(u32 *)XTFPGA_SWRST_VADDR, 0xdead);
+
+	/* If software reset did not work, flush and reset the mmu,
+	 * simulate a processor reset, and jump to the reset vector.
+	 */
 	cpu_reset();
 	/* control never gets here */
 }
-- 
2.20.1

