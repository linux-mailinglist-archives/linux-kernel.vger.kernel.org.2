Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254C73336A2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 08:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbhCJHtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 02:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhCJHtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 02:49:10 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8D3C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 23:49:10 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id s21so1130664pjq.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 23:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dvp9oDPr2aXVni5MslBiMmnlh8KTKKiXl9dnsNUki18=;
        b=V+mqWr16/4vWsZyHYN1fCn36hZMUs1eoy5mu+n7cVfRgMrwBing3pjf+2OKSWOdKce
         neZBRYgoOJzxSjJKcIm4Taj22pzyh1DqQ08Qy1g8GQ/R65JkIHVZo7AYdo9p6QV7v9Gf
         COhIIZoghr+xBz6hc/2Fz59l6hYSFaQRxqZNQR4ELM471sLZBG73JUIxMuB0kPVq5pXY
         +j8L+AzoTHL+vPxxx1lq8IYHjTWtENqRWoHlW72dbTyUgLMQxO9A3bZS2SGswnGB9D8w
         NV1koxYkXzo7JLTrk6gAaXXGsSuEkuNCXR0+mfeVNeZzB+Zhi4DF47U388nv4lm+oztp
         mkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dvp9oDPr2aXVni5MslBiMmnlh8KTKKiXl9dnsNUki18=;
        b=EUV3dydub0fX2SZesZUKJnZMdPGAVfR187Pxtt8hNvDk1F1UxwFI3MBIGnhkCWRyuT
         AsqMjmWJssC84KlKB6IEetWkYt+k/N10qRfMc1Vv+zvnM9UH5sFLjGqmeklS7Se2aciO
         KeINg/8gvgZG8VFsB3f4STmnfbf5sDeRgQ5DJbEzaqcaPjiCcH73BNDGsSPVpIeblcso
         aNvacYp6nVt2uAAwO6baI+s93FYBjI2npw+XYsRza4hSunZLd7jGvD6Qkh2AU24R7e2Z
         +S/AJODxPD0DTlCnxOV60H93PAnfXQtWH0VG/S+dUs+dkbc+8gu39q/Fp9fRS8cCMEGC
         yy3w==
X-Gm-Message-State: AOAM532RRgEwtqknoS4GEtTh3qwzL2+9Gupw+G+6iGacNwlhZm8TCRW9
        Hy1kWbIsnxAhtV7BdlEwKjlR1GoZJ2Qc5Q==
X-Google-Smtp-Source: ABdhPJw5B+fajZx6ce6Uu+mavC/f6ZDkzsl39TQr9VMq2qQs/eNdN8mGUzpc1J6/uTjW5Bphk/i5hg==
X-Received: by 2002:a17:90a:634a:: with SMTP id v10mr2249733pjs.109.1615362550093;
        Tue, 09 Mar 2021 23:49:10 -0800 (PST)
Received: from localhost.localdomain ([122.10.161.207])
        by smtp.gmail.com with ESMTPSA id q11sm883591pfh.132.2021.03.09.23.49.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Mar 2021 23:49:09 -0800 (PST)
From:   Yejune Deng <yejune.deng@gmail.com>
To:     shuo.a.liu@intel.com, yejune.deng@gmail.com,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] virt: acrn: Use EPOLLIN instead of POLLIN
Date:   Wed, 10 Mar 2021 15:49:01 +0800
Message-Id: <20210310074901.7486-1-yejune.deng@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following sparse warning:
"sparse warnings: (new ones prefixed by >>)"
>> drivers/virt/acrn/irqfd.c:163:13: sparse: sparse: restricted __poll_t
 degrades to integer

Fixes: 803c1aadecdb("virt: acrn: Use vfs_poll() instead of f_op->poll()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
---
 drivers/virt/acrn/irqfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virt/acrn/irqfd.c b/drivers/virt/acrn/irqfd.c
index 98d6e9b18f9e..df5184979b28 100644
--- a/drivers/virt/acrn/irqfd.c
+++ b/drivers/virt/acrn/irqfd.c
@@ -160,7 +160,7 @@ static int acrn_irqfd_assign(struct acrn_vm *vm, struct acrn_irqfd *args)
 	/* Check the pending event in this stage */
 	events = vfs_poll(f.file, &irqfd->pt);
 
-	if (events & POLLIN)
+	if (events & EPOLLIN)
 		acrn_irqfd_inject(irqfd);
 
 	fdput(f);
-- 
2.29.0

