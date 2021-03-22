Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE70E344057
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 13:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhCVMAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 08:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbhCVMAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:00:36 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6089BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 05:00:36 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id y5so8602971qkl.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 05:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XYgniBMEcc3hOqXgjSHEPhe8uho6LMuUOlOae09XhF4=;
        b=sDURPToRuQSReSwZPxK+COCC/Q2ODPfbo/VaO/xrcmNKrr4rqm1p9c6RRRzBy5INnL
         4rIx6Si+zx82KRIU1QxtmhCnjuIN1Wxa6Dzy8TuHjYssZW33b5MOWUE7P9KtdPQeWG2D
         pG6epwv63ufsW3qNtjOf06geFuQ675ABAQt4OWVqD1Kj24ZA3xv+uTU7xuOkqU6fJm9o
         P5oB2yodpPBlfGJoD4q6DTKFkX2/R4SdODJJ+QWtnHnz6W1Wb7wBMJOqkDPF9SCN5zPz
         m9ATJxqmymei/VFVfCwjoPPu91lPW063Gu+PYn3TaZBUbN7im84rH7eXp3aDdMqHyjx/
         Xewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XYgniBMEcc3hOqXgjSHEPhe8uho6LMuUOlOae09XhF4=;
        b=mY8mOcV1xOVPaacoFghjU0hcPjKfy1DB3Fvs3mdtJwVPaI6uocmLPpPJUJzaU7Z1I0
         37MmqUA4pGS4+i4RvkoRmFv2koovMI4HkT0MOJCLKs7k5nSAxoeviIcJOIuhFpa0pdqI
         qiZEV1q9X8V2rhfHQzuC3BMKKZvWJx0oFV5WUs146H0y22ZY9JpUt8mF3DOJDHuSSDok
         U5TP+hf9/aIi6jZWoZFOCns/pWyosMxhKzX8G1YoEkXDfihtBcXcTMf8YPv63BcCiXy2
         cAMpVYQ9amxNgsL4/+P11tkXt2lSSpc3gpQawK6a9hYzalVeXB1YncO/bAymNLp5Sb4q
         E5tA==
X-Gm-Message-State: AOAM533cBRm3BkGVDr4OlNrvOqCVY+dRaINxAR6eE4aoGmyJMLNjYWly
        PDekegfziI2Hv6XmMhwNA3E=
X-Google-Smtp-Source: ABdhPJzRVQCxQ1xipsPBYsASO+e2v126BBXqdFxHBd0xIZJKwDF3TayFv74zGZbaQmIRnRPL704ZyQ==
X-Received: by 2002:a05:620a:16b1:: with SMTP id s17mr10323301qkj.302.1616414435684;
        Mon, 22 Mar 2021 05:00:35 -0700 (PDT)
Received: from localhost.localdomain ([143.244.44.200])
        by smtp.gmail.com with ESMTPSA id o76sm10705794qke.79.2021.03.22.05.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 05:00:35 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     maz@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] irqdomain: Couple of typo fixes
Date:   Mon, 22 Mar 2021 17:30:17 +0530
Message-Id: <20210322120017.2084799-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/nececssary/necessary/ ....two different places

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 kernel/irq/irqdomain.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index d10ab1d689d5..349adef40c9d 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+\// SPDX-License-Identifier: GPL-2.0

 #define pr_fmt(fmt)  "irq: " fmt

@@ -665,7 +665,7 @@ unsigned int irq_create_mapping_affinity(struct irq_domain *domain,

 	pr_debug("irq_create_mapping(0x%p, 0x%lx)\n", domain, hwirq);

-	/* Look for default domain if nececssary */
+	/* Look for default domain if necessary */
 	if (domain == NULL)
 		domain = irq_default_domain;
 	if (domain == NULL) {
@@ -906,7 +906,7 @@ unsigned int irq_find_mapping(struct irq_domain *domain,
 {
 	struct irq_data *data;

-	/* Look for default domain if nececssary */
+	/* Look for default domain if necessary */
 	if (domain == NULL)
 		domain = irq_default_domain;
 	if (domain == NULL)
--
2.31.0

