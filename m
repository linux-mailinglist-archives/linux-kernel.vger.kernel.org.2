Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14B03DCCFC
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 19:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhHARhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 13:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhHARhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 13:37:12 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A790C06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 10:37:04 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id v8-20020a0568301bc8b02904d5b4e5ca3aso3135439ota.13
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 10:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c7qpadXUJx+KPKxSa8X8NJpv3KvsuMGkt1QAZKnVVgk=;
        b=mMlGcj2wok+904UEgIZWGn+C4Xk90FeK5jTK9x/vpnFFMxXgTykUdu5a/emkgRRe6s
         E+f6t7nkO4bfPDAcTTQJEijOu0Ijte7dMEOjROlGpNSvCGg3AhqQ06sO+JXys7qYP/4D
         BPyznaDqlJDIi2luh7ngwa+wTr0nrxn7B/orXnAQ1PuwtpuYGDR0zDksXIPRI3emjlxp
         Nnz2e4B0Rwkz4QOG2VHsz6CQWJ6nxZCCqvetzSGkopkcsNEm/7enU3cBYWIDH7DJYBQc
         UgJmALNmWzrF5OBP32GDtUtDKZUH+4UMW9lNTdtztDhmOL/7cQDX27VM8vx6I4AFRAAv
         t9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=c7qpadXUJx+KPKxSa8X8NJpv3KvsuMGkt1QAZKnVVgk=;
        b=SaxLQhkwAnYC8pLm7h2VCy6T6RsCf+lmavomdPYFslsBsYF+PqEVGsebp0gJfKsAXy
         CQs9E+LhcfJ7I9lmoAG57eOS5prn3VpIgAVlJDOraQHSq1fWIdbDmAX2PHbkQQAIvP4i
         MUvNyPFoflgKZKyTnMjZ80ev2AU2w6DabD062qVKr5jvXv6IjOuYl6336LdYm+fwL+vg
         hcN5qNrUq2YWGykpl/zKBcHbrDVeRQS5q0Q2s1hZRCJh7WEfUBrBx1TR/vWlqGqYg1cr
         CVZSBYNF/XgCnQuOMslA4Q1KbRxCTYnv5UbidSBhRP2WzjvesSSRgXx9kywK5G0D79t5
         PB3Q==
X-Gm-Message-State: AOAM531g88xKFw/hGM0UMRjXwvC4NKR1a2JwB6oEir+tdLnCEARX+9Tw
        ENdp3/wGfEwfxJWq2Y0lY0nd7JNpasU=
X-Google-Smtp-Source: ABdhPJygXwDJWVAZ5wVl5gsgDiGUfgeNLauoi+aGlTiI0tQEo761F9eiOYf7Avbu/qjaHRd1QYoeUg==
X-Received: by 2002:a9d:86d:: with SMTP id 100mr9212089oty.45.1627839423908;
        Sun, 01 Aug 2021 10:37:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d20sm1489889otq.67.2021.08.01.10.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 10:37:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Zankel <chris@zankel.net>
Cc:     Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH] xtensa: xtfpga: Try software restart before simulating CPU reset
Date:   Sun,  1 Aug 2021 10:36:59 -0700
Message-Id: <20210801173659.2788924-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rebooting xtensa images in qemu does not work. When executing a reboot
command, the qemu session either hangs or experiences an endless sequence
of error messages.

Kernel panic - not syncing: Unrecoverable error in exception handler

Debugging in qemu shows that the code jumps to the CPU restart address,
but Linux can not recover from there.

As it turns out, the FPGA has a means to reset the CPU by writing 0xdead
into a specific FPGA IO address. Use that mechanism to attempt a platform
reset. If it does not work, fall back to the existing mechanism.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
No idea if this is acceptable, but I thought it might be worth a try.

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
2.25.1

