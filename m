Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC31387F8B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 20:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351540AbhERSYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 14:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351524AbhERSYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 14:24:43 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734F1C061573;
        Tue, 18 May 2021 11:23:25 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id b15-20020a17090a550fb029015dad75163dso2037873pji.0;
        Tue, 18 May 2021 11:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VeljYR5alzrAzxkyBn4PSDhx6vZQM78YA3D/fgR2ogo=;
        b=m+6WBC3Znf40Skbt89rEhIlHOmIUpgXzZn/XUviedZFk4DWyq5wY7LXryBqTQ+A/b1
         x/yeRF8GEJtCa2DRUcen0va+ngLaIzXisHptuhAvJSfCYYkzdUk+CwtTVrkdCOnn7YPR
         +uSOcwaqqw99OKg72YKWIrstpow1KF9wZMaXrr6096sH8dZLkQr5e2/NRc1R2BoCYubA
         H8vt2VvfBUzwdrvHrSZthMkmIijSFOvOQtsV1VRFY3/XPR23INEc9qzqI5lUl/5jZYib
         kuQgCbsRMR3ESo+Lvj2WVSdJav1z1TvN/aXuRigWZEv155n66RtkBi1WKkGsj5XnAE0u
         aytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VeljYR5alzrAzxkyBn4PSDhx6vZQM78YA3D/fgR2ogo=;
        b=a2hCf6cAIJxxadfvbWFd6nRoQF3aKebIXpItJNJKNfssLk5VqspdQksXCxxcXQMcbL
         Vc1a+dneeAUi9twj2Hb96kxUCV1LWHfIi3BGuu5HyiS26M7DlQNDh3Cw9JB31aXMkytL
         OPa5zA9e+sTQudhvxfyyTUqH1IQMDAartCA30ldJgBLtJUQiHGNuih51SqjNTY699Hqt
         N4LbQF3tDCpXH/pz6bpBjbsa1Ms4+fAepW7JD4nLUt6W/pm7lpu1JGbk7hz3Zm2ZmA9B
         8tznt5AIXKyOnCaTVDWLPHqUWImhP/aPA8xBqCn2XYTSrNwL8NGnERA4ENMVZId5oD8A
         5A9A==
X-Gm-Message-State: AOAM533pn1QvbhgJRecgO36DTWl3cB0eTsTTvkW3XPiqqpaXr/eKIx9M
        xUff0GsQYY/zR4Rv6Lnmfl+8Rg7Qy9Jvvg==
X-Google-Smtp-Source: ABdhPJzYmciEiS9phWq+8CRTRf9S4j9y8Uyp+VH94jT6y6a8HYrvhP1f1LjDd7IFjacyNWwdf433/Q==
X-Received: by 2002:a17:90a:ad44:: with SMTP id w4mr6766598pjv.71.1621362204745;
        Tue, 18 May 2021 11:23:24 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:600d:a93f:e998:b72d:dcc8:8823])
        by smtp.googlemail.com with ESMTPSA id lj13sm2446661pjb.3.2021.05.18.11.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 11:23:23 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        rdunlap@infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        grandmaster@al2klimov.de, keescook@chromium.org
Subject: [PATCH] irqchip/irq-omap-intc: fix kernel-doc syntax in file header
Date:   Tue, 18 May 2021 23:53:10 +0530
Message-Id: <20210518182310.14461-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The opening comment mark '/**' is used for highlighting the beginning of
kernel-doc comments.
The header for include/linux/irqchip/irq-omap-intc.h follows this syntax,
but the content inside does not comply with kernel-doc.

This line was probably not meant for kernel-doc parsing, but is parsed
due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
causes unexpected warning from kernel-doc:
warning: expecting prototype for irq(). Prototype was for __INCLUDE_LINUX_IRQCHIP_IRQ_OMAP_INTC_H() instead

Provide a simple fix by replacing this occurrence with general comment
format, i.e. '/*', to prevent kernel-doc from parsing it.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
 include/linux/irqchip/irq-omap-intc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irqchip/irq-omap-intc.h b/include/linux/irqchip/irq-omap-intc.h
index dca379c0d7eb..e31057e26a00 100644
--- a/include/linux/irqchip/irq-omap-intc.h
+++ b/include/linux/irqchip/irq-omap-intc.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/**
+/*
  * irq-omap-intc.h - INTC Idle Functions
  *
  * Copyright (C) 2014 Texas Instruments Incorporated - https://www.ti.com
-- 
2.17.1

