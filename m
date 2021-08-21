Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5243F3859
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 05:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239021AbhHUDpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 23:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhHUDpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 23:45:04 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2245C061575;
        Fri, 20 Aug 2021 20:44:25 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 14so13018812qkc.4;
        Fri, 20 Aug 2021 20:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BMMXZy+vy7iOFMr75/d6RfEe9G09ecTNIemEPKOnyQ4=;
        b=uB3ZKzVAGIUiX/JzsMbo90IFombokXoAFtUa9QYKAbJDbtDNjvStPDfa4hiMc/lChN
         HLly3TJEBoQ2/FSnoNvJLRJRXkw57LQaS+zschEauRLYNw4pNiZSX2nSZ5JNJ1ivC7en
         JeLGNWE+HaDOGcBCrDFZ+wp35ZPPBfCWb2AvHnpXGFTr7r9UcY2a65qZfq02d5gzEaYJ
         g9FdusvZYwJbUvpPCp34R9/icW0j4zEUFh9pN8cU8FyU7EtJ9k9rRjUk+LsTi50+X8u1
         eyDNWuw/rzqt1P8B8I4zxIClSDohRLfl41CmvF/zCEsg6NIagk/3qEuZxq99xri8UI6g
         X7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BMMXZy+vy7iOFMr75/d6RfEe9G09ecTNIemEPKOnyQ4=;
        b=IKCgUr78rjADmutfOej4rAOd/MOhme9uN/nx4u4v0SyXO044SQ70u9eCJeApL2EVNl
         ESXfZ3YhFz63eWmFLqq2kjojdBAznZmI3FecMF5pKigUKCz5YMTMia1zF9uT2KZu6zKD
         Mw6lXLNz+cQ7AoBjt0LiRUCexK70qJWa2MthHN35pD4tygiBG+IkZS1oiU4EMqx3HDRq
         SpjOHbNuuzI8Ridsn3Hb8EUIdbZTQJYYveFJj6Ru8yrFNlBWOcVyKxEHTeHVFlMrUSX2
         bieR4y78sf4RKcnlpxgtBadNfxALSsl4ahsCF8vYvRE++rzfOlpj3A6T16AitHU/B/HI
         DaXQ==
X-Gm-Message-State: AOAM532ItJxg9vwlG3AERYWZw6igwkANnWbXV3Tql+uGutag5MgPNRWm
        HFZtxeCppNEcgMTYsf9/HsBLNTmMraE=
X-Google-Smtp-Source: ABdhPJwiVW+0gBZNHWW2ihB/2MdPi8clwhIiL+GsRI1tPv6mEKGX7grD92dCoOlIXXZ9qe4LZxeEQQ==
X-Received: by 2002:a37:749:: with SMTP id 70mr11384907qkh.461.1629517464828;
        Fri, 20 Aug 2021 20:44:24 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s20sm2367346qtw.14.2021.08.20.20.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 20:44:24 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <jing.yangyang@zte.com.cn>
To:     inux-ia64@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ia64/kernel/iosapic: replace a printk + WARN_ON() to a WARN()
Date:   Fri, 20 Aug 2021 20:44:16 -0700
Message-Id: <20210821034416.27992-1-jing.yangyang@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jing yangyang <jing.yangyang@zte.com.cn>

Replace a printk+WARN_ON() by a WARN(); this increases the chance of 
the string making it into the bugreport

This issue was detected with the help of Coccinelle.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
---
 arch/ia64/kernel/iosapic.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/ia64/kernel/iosapic.c b/arch/ia64/kernel/iosapic.c
index 35adcf8..cb8ba1c 100644
--- a/arch/ia64/kernel/iosapic.c
+++ b/arch/ia64/kernel/iosapic.c
@@ -794,17 +794,13 @@ static inline unsigned char choose_dmode(void)
 	 */
 	irq = gsi_to_irq(gsi);
 	if (irq < 0) {
-		printk(KERN_ERR "iosapic_unregister_intr(%u) unbalanced\n",
-		       gsi);
-		WARN_ON(1);
+		WARN_ON(1, "iosapic_unregister_intr(%u) unbalanced\n", gsi);
 		return;
 	}
 
 	spin_lock_irqsave(&iosapic_lock, flags);
 	if ((rte = find_rte(irq, gsi)) == NULL) {
-		printk(KERN_ERR "iosapic_unregister_intr(%u) unbalanced\n",
-		       gsi);
-		WARN_ON(1);
+		WARN_ON(1, "iosapic_unregister_intr(%u) unbalanced\n", gsi);
 		goto out;
 	}
 
-- 
1.8.3.1


