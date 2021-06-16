Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F893A8F13
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 04:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbhFPDAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 23:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhFPDAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 23:00:17 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093B0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 19:58:10 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id b12so358839plg.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 19:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=a9KFIkitloa+O/psChmM03Ow9Qedo4UEKz1deWLlXB4=;
        b=h7OBrycEokCmK0f/mDPrpHqwzx0eG3bCpwj6VTtMjbauPUkI2+PrQ1RrmUI5jpGFN+
         EEMFrqaMGwVhso4mqC6tiqqJV0n5x0/wdkJWjszph2df12Ad4qCRjCoIN5c8zAw00TiJ
         WFT8clCX1xdSpyqpv+KqSKUij4mU3fptchCR3dWcyciA7lQ2jUNK0weI9Vr+0jm0/hZs
         DwWnt76hHkWeUd9+eXekmRr2Z+K11G6RcQEeIbZRiPexZEesKTZqrKZXpEPXOX4Q1Sp6
         cUT8lACE6ab8TyoCKJRLgNj4zg8rHLE+Ee4TFiiD4yxK5g41NuWyzETLr/uHL8uWLeZC
         xRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a9KFIkitloa+O/psChmM03Ow9Qedo4UEKz1deWLlXB4=;
        b=K7sQbkzP197IJtGbuI5blmm4nrFmm5M2Fk54NJCAa7p5VjcZGC5OKhFYwBHgTNE/v6
         xT8N4rM0WDVxehV/effRsX1q0T9TjiqucGzoe22K2B1hIolS8RcXqCPUmFkzIOn+vS7J
         F23tahN9t8qvcgJC1Yd86QVRjAhJcwujzv6EObRUEnjRrXC5rzbNReef7hwEDhHPEf7L
         nNLiv44gAqS8lk2HMreC2b+zvVX1os8we8Fi8zwJPMBMPob8ryeeblb93n2GqxN4ZX4c
         gVFbRn4MnuhkzIxodCsbuTgsgyvgN6JhX1Ngb9UneNibrkeS4tjnhi4qLFwcuO7jWqoZ
         DUbg==
X-Gm-Message-State: AOAM531907lXzlr8xyH3qsXNvLZOYjAaZ9RLST1ysMESxx+DVdhqnajg
        cUvuTVLCfgij8vJai13LhF4FI3liRzS5aQ==
X-Google-Smtp-Source: ABdhPJxDR7A5NJUK2DL/vLGmMkWMk626fBF8sGRfjMM99XPZ3Y8WBHg87s7gYzkgU/XZTY25H7+rfQ==
X-Received: by 2002:a17:90a:4812:: with SMTP id a18mr8300581pjh.40.1623812290511;
        Tue, 15 Jun 2021 19:58:10 -0700 (PDT)
Received: from bj10045pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id m134sm438923pfd.148.2021.06.15.19.58.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jun 2021 19:58:10 -0700 (PDT)
From:   Zhenguo Zhao <zhenguo6858@gmail.com>
To:     zhenguo6858@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH]        tty: n_gsm: Fix CR bit value when initiator=0
Date:   Wed, 16 Jun 2021 10:56:39 +0800
Message-Id: <1623812199-31866-1-git-send-email-zhenguo6858@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenguo Zhao <zhenguo.zhao1@unisoc.com>

	When set initiator=0,switch to Responder,gsmld received dlci SABM/DISC
	frame,CR bit should be 0 by calculation.

	receive DLC0 SABM CMD:
	[69.740263] c1 gsmld_receive: 00000000: f9 03 3f 01 1c f9
	[69.893247] c1 gsm_queue cr:1
	[69.897629] c1 <-- 0) C: SABM(P)
	[69.907516] c1 gsm_queue cr:0

Signed-off-by: Zhenguo Zhao <zhenguo.zhao1@unisoc.com>
---
 drivers/tty/n_gsm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 5fea02c..becca2c 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1779,7 +1779,7 @@ static void gsm_queue(struct gsm_mux *gsm)
 
 	switch (gsm->control) {
 	case SABM|PF:
-		if (cr == 0)
+		if (cr == 1)
 			goto invalid;
 		if (dlci == NULL)
 			dlci = gsm_dlci_alloc(gsm, address);
@@ -1793,7 +1793,7 @@ static void gsm_queue(struct gsm_mux *gsm)
 		}
 		break;
 	case DISC|PF:
-		if (cr == 0)
+		if (cr == 1)
 			goto invalid;
 		if (dlci == NULL || dlci->state == DLCI_CLOSED) {
 			gsm_response(gsm, address, DM);
-- 
1.9.1

