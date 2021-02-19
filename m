Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2B831F689
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 10:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhBSJ1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 04:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhBSJ1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 04:27:03 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C329DC061756
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 01:26:21 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id t26so3535518pgv.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 01:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E3lKUpNPgWtCHRkjPYUdcYm0hE3joAAMdlvhD8+x+v4=;
        b=UbX9vWQ7ohQgaFTxTWAwoYny8yk5EeM8U+zlUXpqZvpQx0orKYrNGBrieSzRpVPQkK
         wo4D66bVDZ1rdHtWQT2M4cMTwY987PBqKLwxY831u2F2nIZiZRLcCe7/LOmLHFOYjCgv
         EqTqM0roJ95mwUk+wV15vDqcYMVMyeUCwArEvqGrW0KnMqsnFWGazTuH3v3NHaYj4tAv
         ApeFGKM5WmWP0UnxiA/oo5QSo9A8TrfvaKchW/mqqy6Lj4xtXGsD7w2xyEuFHO4Yt1Cy
         SzP2rUWuoXUis59c6XO1c+0d+LCBg5sk/EcYUsLc+3w+AZlNLnm1nE+rh4WaQXHci3mQ
         Dn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E3lKUpNPgWtCHRkjPYUdcYm0hE3joAAMdlvhD8+x+v4=;
        b=YuxoWeoTLQkXubQTb4ofpfXvYU3PfPhqmA7qzLm0qUOTLPiMVxpuE37WKQ+w5K/l6p
         IrW3aUTEV+0ZUWcBsSwA80TIFHUqERQefQVeR1twlgRN4HzX4gPFuKjHbST/ALpXpDEC
         pwbvEn4Cvumz9fITSXZaEMs2bWd6OXPeokP1ieeCYFqKSesp/074y/rorb1oM0zVq39R
         0cwmZtz1gEaZBRW4FkdSXwAgMPKtGoaY7BAepMddqrvMTqZ/GPjoXFNuYDDghaRYG/PF
         Fnztq7s583QdYe05JV4U/xve36+RnwGhh98WixaouLKNZc1iKeThDqbj2sSoXcnu4IdM
         CYyw==
X-Gm-Message-State: AOAM531/cRkTeWZlMwmReltq+fiPsdziAERhNSQJsiDuyf73aWdewd4O
        Mm9cRP5QagMGPjmiIyeY/cgUxXugbvAgVg==
X-Google-Smtp-Source: ABdhPJw0Dp8YYvQGiDBF9iPKrRfduTFHM/4DbEN4bolQMsN7NcaXnJc70jyh+dIOgSXDbsFUsmCr8w==
X-Received: by 2002:a63:2009:: with SMTP id g9mr7756927pgg.219.1613726781414;
        Fri, 19 Feb 2021 01:26:21 -0800 (PST)
Received: from localhost.localdomain ([122.10.161.207])
        by smtp.gmail.com with ESMTPSA id r23sm8544337pgl.42.2021.02.19.01.26.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Feb 2021 01:26:21 -0800 (PST)
From:   Yejune Deng <yejune.deng@gmail.com>
To:     shuo.a.liu@intel.com
Cc:     linux-kernel@vger.kernel.org, Yejune Deng <yejune.deng@gmail.com>
Subject: [PATCH] virt: acrn: Use vfs_poll() instead of f_op->poll()
Date:   Fri, 19 Feb 2021 17:26:12 +0800
Message-Id: <20210219092612.7533-1-yejune.deng@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In acrn_irqfd_assign(), use vfs_poll() is a more advanced function,
as the same time, modify the definition of events.

Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
---
 drivers/virt/acrn/irqfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/acrn/irqfd.c b/drivers/virt/acrn/irqfd.c
index a8766d528e29..19890396e174 100644
--- a/drivers/virt/acrn/irqfd.c
+++ b/drivers/virt/acrn/irqfd.c
@@ -112,9 +112,9 @@ static int acrn_irqfd_assign(struct acrn_vm *vm, struct acrn_irqfd *args)
 {
 	struct eventfd_ctx *eventfd = NULL;
 	struct hsm_irqfd *irqfd, *tmp;
-	unsigned int events;
 	struct fd f;
 	int ret = 0;
+	__poll_t events;
 
 	irqfd = kzalloc(sizeof(*irqfd), GFP_KERNEL);
 	if (!irqfd)
@@ -158,7 +158,7 @@ static int acrn_irqfd_assign(struct acrn_vm *vm, struct acrn_irqfd *args)
 	mutex_unlock(&vm->irqfds_lock);
 
 	/* Check the pending event in this stage */
-	events = f.file->f_op->poll(f.file, &irqfd->pt);
+	events = vfs_poll(f.file, &irqfd->pt);
 
 	if (events & POLLIN)
 		acrn_irqfd_inject(irqfd);
-- 
2.29.0

