Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278003C2344
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 14:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhGIMIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 08:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbhGIMIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 08:08:37 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D779C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 05:05:53 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id f13so22675342lfh.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 05:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HC3TFVQETt12BDyl6iqYoB6JjOT22n0xQEi68NzER/g=;
        b=JDqPMkLoBFDWAiSLbbp0X/e5Rlas72BS6rdCol34Q2vhzGcDTwlajprSXKrPx7K5Ul
         SwglmConpphoedvpXxkfRbbcG8HOkIFMTjWSpOrKJf9wP5cqIJcpn8FSXBw1TN3Tjjfq
         uStED7FFYE+Z71LZEfnMMKi/h1jekeLjkU5JFTeF2TP1ixOMmaoIKrh1etQN/3V0+wKT
         +oQq0P+NonXAaDXdu6L//bIjy6J49pgNCTtn5q6LUbUnOxRTV5m1sFpXJDmICtkDVcoJ
         mfZ1bYegJf+1FpiofhelbxKmTRtMfCuroik1yJ0qEyRYBWTwSIZTC53rHd4nObvn8Y4h
         c5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HC3TFVQETt12BDyl6iqYoB6JjOT22n0xQEi68NzER/g=;
        b=ujSn/TWGqitezRWn1sDuWS127rwJmwfh1wSzUIzLDhUZujB74wlMKp3CyZY8sZgt7e
         B3uNjnunq2r+PJR4a8gU60GRcdNs2kzBRmGV+nCEF6oeoZSjdLoR97DgJ/bBAzpVSGOL
         3n5ZVRB8chmPHO+vsFGJvFW0YhvIZ7RyTffdRnIfZ8dSiG9usi/ukEAB9kz5GNgUIRvf
         iTFnLyyKDzEv6ZtIjheIrSmBJLcwzbibh1QViaSLvXW4DQ3trSIXmfJX2VCJ4ixUmP5k
         Vhkpb9DHcc22KV10k/FNSej4vFvkpE/sWAA469hYjOhBcrKFw2J62du/Cj8YM87dIMME
         Egjg==
X-Gm-Message-State: AOAM5329Le2hauh8v41d7ssxQJFHj0Qj7VoaMtSjGiYxVvnsOGUIoGkF
        QEkxg29m4dw18a7N/x9MxUM=
X-Google-Smtp-Source: ABdhPJzAegaVvFnJ0lgzhNSBk18tRRuAn1UZGgi0QGaqH00c4Y2Y60YTShTgw+5NWGIpKQod6qkwQA==
X-Received: by 2002:a19:e05c:: with SMTP id g28mr28826388lfj.299.1625832352025;
        Fri, 09 Jul 2021 05:05:52 -0700 (PDT)
Received: from octofox.metropolis ([5.18.185.11])
        by smtp.gmail.com with ESMTPSA id q15sm583586ljg.126.2021.07.09.05.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 05:05:51 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: add fairness to IRQ handling
Date:   Fri,  9 Jul 2021 05:05:42 -0700
Message-Id: <20210709120542.11551-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Track which IRQs have been served at each level to make sure that no IRQ
is served more than once while other IRQs at the same level are pending.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/traps.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index efc3a29cde80..874b6efc6fb3 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -268,6 +268,7 @@ void do_interrupt(struct pt_regs *regs)
 		XCHAL_INTLEVEL7_MASK,
 	};
 	struct pt_regs *old_regs;
+	unsigned unhandled = ~0u;
 
 	trace_hardirqs_off();
 
@@ -283,6 +284,10 @@ void do_interrupt(struct pt_regs *regs)
 		for (level = LOCKLEVEL; level > 0; --level) {
 			if (int_at_level & int_level_mask[level]) {
 				int_at_level &= int_level_mask[level];
+				if (int_at_level & unhandled)
+					int_at_level &= unhandled;
+				else
+					unhandled |= int_level_mask[level];
 				break;
 			}
 		}
@@ -290,6 +295,8 @@ void do_interrupt(struct pt_regs *regs)
 		if (level == 0)
 			break;
 
+		/* clear lowest pending irq in the unhandled mask */
+		unhandled ^= (int_at_level & -int_at_level);
 		do_IRQ(__ffs(int_at_level), regs);
 	}
 
-- 
2.20.1

