Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4574C432D19
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 07:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbhJSFUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 01:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbhJSFT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 01:19:58 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA348C06176C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 22:17:46 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id q19so16609362pfl.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 22:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bczBzbxa2p8od+DULmDk7Iuu1IoW3ABzQKBbfdi1h54=;
        b=E7Xn6leFGGliUjeXMG7oFajCAqdnI7TOtm2jvfbLNwAHAVHonfBesrx2JhIx90argF
         dNjsVex0QIITlK+q22XkP/KtseQOxUxS0PB+HjOg4uJz6akc4Xc501Yh8+nBJk0ahEM/
         BEY/q7Jb0yniB1alq2Ab1YC8LzsAFFhtfRWQTSM2WkHIuaO+I+Y9FxIhNMYG6NlJ5OfJ
         OtSf4P5e2FnrABlDnD5objaJh/RiAfnfVRG9yZ4CLPB1p4O+glThJfKoQvBJjVASpEXj
         K4EZAQzY+w2KdwhjZ54WxiY/1PdUlef5XyRf9jbx//wSeNFfIncKBrQ+4RxZabsvNWon
         vAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bczBzbxa2p8od+DULmDk7Iuu1IoW3ABzQKBbfdi1h54=;
        b=qyzkjPi5/rcmbCvRHXTY0xZfcDqxa7jeaa/w1MWgHdacXr5I2BC3FxYyQ6pjp2pehB
         sD1DHKOXedoJ0y0+rPRrEVKv2qDFK5ddHFfRhH3Uiv4Z/W4DYz5CThSjj+rY0pCHvQoF
         qDp9DirhDTKJg3fu49CGYO8jfEc5H84fTUPoysrWhqbtd7aEbeqqjekx6bwmlhcCXpGC
         jS9Ulz6GAQFdTyA2mNxEXJW/4WaxSSPHwd/dY8KuFuwJsyTRTf10/XJw6GaDZ3RRJSDj
         oCkaXrqa5N0Ksn8ut0inJVQUGOHFnfXrLQIWUdLTPABhIcnfNRHdbL61ZUpokPx14JJ5
         svYw==
X-Gm-Message-State: AOAM53175oLr0wtNH+zl6DfYpo5KZ2vQ1dUPgv0chaPD0MmaR8i9KFPj
        Y0ASk/kFwnkJTgCuveVSkQM=
X-Google-Smtp-Source: ABdhPJxsvnRgWMyo+3p0ic9f3hdtP8NvLL7ceIGmlioyeSN8mZ/OeBRoOVnXGXBkLZ0LCYnrvQYp9g==
X-Received: by 2002:a63:36ca:: with SMTP id d193mr26954592pga.73.1634620666450;
        Mon, 18 Oct 2021 22:17:46 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:4171:83c2:8384:24c5])
        by smtp.gmail.com with ESMTPSA id me12sm1168844pjb.27.2021.10.18.22.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 22:17:45 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 09/10] xtensa: remove unused variable wmask
Date:   Mon, 18 Oct 2021 22:17:15 -0700
Message-Id: <20211019051716.4173-10-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211019051716.4173-1-jcmvbkbc@gmail.com>
References: <20211019051716.4173-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After a cleanup the function show_regs doesn't use variable wmask but
still computes it. Drop it.

Fixes: 8d7e8240e66c ("[XTENSA] Clean up elf-gregset.")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/traps.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 4418438b13e6..35a7d47f28cf 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -464,12 +464,10 @@ void secondary_trap_init(void)
 
 void show_regs(struct pt_regs * regs)
 {
-	int i, wmask;
+	int i;
 
 	show_regs_print_info(KERN_DEFAULT);
 
-	wmask = regs->wmask & ~1;
-
 	for (i = 0; i < 16; i++) {
 		if ((i % 8) == 0)
 			pr_info("a%02d:", i);
-- 
2.20.1

