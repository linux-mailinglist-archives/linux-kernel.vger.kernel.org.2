Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB7D35ABB1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 09:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhDJHfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 03:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhDJHfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 03:35:53 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50A2C061762
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 00:35:38 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a6so7697361wrw.8
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 00:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IL4eJ2SU5IZ2kRbEuN6Vx3POFYlD6P3bZwQQbIsZ3gM=;
        b=IUjMDuQz1QTXpdQ6ZjYur6b1MKimoIZQ1pPqdm64E038xdIuePT/FK6ehBxr0+3jke
         SG+3b54iLikdNuXINDGLmPz86lg7kBrVZ+cuW4j/D68pNIvDwoBdXK+6jNCkvRdlDxyI
         wr6CAUrQLPVFfIomfsjEFs9piCwpi7n2VJchE9oh+OsA2a6xO3kneGr4Q9+1t2aMOAjZ
         mBm56efTpMoot2G1otLwkKujF5fJvoLVkDnvBiCiElil86jmggWSwbC/iuD72MtzrY0D
         Ar+EH8ivv+Ms+6O83KJkdrdjNmvQ82F5hGSArtNKyMbIczWeONfP2HZ32IO/RXvOWppg
         WMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IL4eJ2SU5IZ2kRbEuN6Vx3POFYlD6P3bZwQQbIsZ3gM=;
        b=BNVxyPp0PHPUY3rPnUlh3KzBFFP5ceGLs07+qAG9aQUuoRt82LXV3IegX2kmfPob8v
         sfGh9cKFE9fXU3tB1t76GOQX1WOXtzSKTHxCc9w0F9FD/oUijrrPNWI7HB31r3wxruT5
         0PHSukkabV35X2upF3LfH9CPVlSmPq19xFCC+KjBDnSitI4KcnWdWYt0AFcrT1uqc3Z8
         JyNwK7xiA5NQjVOSOHtp1nZ92dN1AAjyyfV4VmVU/Bn1W+1QufauxwCmG/73WNA0O2vT
         aFosL86aTCX1Av7pWuv/tTxpFLNScY57W+6J737FTqI5MBVcrKvnEBK/UI4TgkK5aGY+
         WAkA==
X-Gm-Message-State: AOAM533qLniWarzbZmpXZ3QmGIg6Et/xZ7Auq69XWY/wWrXIdm0rvEtG
        J4w9t/ywy2VpumJuGAldsmh5jXvpvzw=
X-Google-Smtp-Source: ABdhPJzH9RrO+cKCAo1UqT215D4ZHaE1CFuTbhSvCVMR1arhSh3HT8YnxPEs1m60ahapqIhZF36Dnw==
X-Received: by 2002:adf:db42:: with SMTP id f2mr21498856wrj.359.1618040137667;
        Sat, 10 Apr 2021 00:35:37 -0700 (PDT)
Received: from localhost.localdomain ([85.203.46.195])
        by smtp.gmail.com with ESMTPSA id k16sm7770749wrl.47.2021.04.10.00.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 00:35:37 -0700 (PDT)
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
To:     tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH] preempt/dynamic: fix typo in macro conditional statement
Date:   Sat, 10 Apr 2021 15:35:23 +0800
Message-Id: <20210410073523.5493-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 40607ee97e4e ("preempt/dynamic: Provide irqentry_exit_cond_resched()
 static call") tried to provide irqentry_exit_cond_resched() static call
in irqentry_exit, but has a typo in macro conditional statement.

This patch fix this typo.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
 kernel/entry/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 8442e5c9cfa2..2003d69bd6d5 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -422,7 +422,7 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 
 		instrumentation_begin();
 		if (IS_ENABLED(CONFIG_PREEMPTION)) {
-#ifdef CONFIG_PREEMT_DYNAMIC
+#ifdef CONFIG_PREEMPT_DYNAMIC
 			static_call(irqentry_exit_cond_resched)();
 #else
 			irqentry_exit_cond_resched();
-- 
2.25.1

