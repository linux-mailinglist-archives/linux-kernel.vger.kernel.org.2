Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C153D0E8F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 14:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238323AbhGULYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 07:24:11 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:48238
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238184AbhGULVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 07:21:12 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id AC0A13F24D;
        Wed, 21 Jul 2021 12:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626868908;
        bh=4rNr75iyy/j1TQd7Pr+dzCy4gKd7n5s0DoW6abDmq8Q=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=jWgWr3fGBqcLb8uG/vUpfQLwqcb2LKm7kS/9qpV5tWi99kj0WWTi6cpk+YRxmlUcy
         z2uQFX81eCVQSY9NipHZrYVhQWhsNn8C39a+ci61CUdB9147UdUL4WYaoIIJ45cnkl
         NLjnXnKPFrYHVmsz7uef7iTVlrFX/69MQzLHQmQlyzTvPK2E6hutNba4aPMBlFw9Qp
         K4RNIOSLyKATOL/E53/WEic/zuFAGTAZ9DYQDitYUEcc1l7yPKlZu7dOJWJjEDT4fq
         1tP8UANdVFOCIPMOpLOnuhRRSEckUrd8FHaFR4YnwfTt03wpYS0wxmOvD0T5YgJDRS
         AnKc6QyHebKvg==
From:   Colin King <colin.king@canonical.com>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org
Subject: [PATCH] posix-timers: remove redundant initialization of variable ret
Date:   Wed, 21 Jul 2021 13:01:47 +0100
Message-Id: <20210721120147.109570-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable ret is being initialized with a value that is never
read, it is being updated later on. The assignment is redundant and
can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 kernel/time/posix-timers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index dd5697d7347b..3913222e7bcf 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -336,7 +336,7 @@ void posixtimer_rearm(struct kernel_siginfo *info)
 int posix_timer_event(struct k_itimer *timr, int si_private)
 {
 	enum pid_type type;
-	int ret = -1;
+	int ret;
 	/*
 	 * FIXME: if ->sigq is queued we can race with
 	 * dequeue_signal()->posixtimer_rearm().
-- 
2.31.1

