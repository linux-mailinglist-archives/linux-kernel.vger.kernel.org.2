Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F18E3EBF26
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 03:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbhHNBBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 21:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbhHNBBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 21:01:41 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DE6C061756;
        Fri, 13 Aug 2021 18:01:14 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso18413049pjy.5;
        Fri, 13 Aug 2021 18:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o8WfKmwINea2dak8eWcmeq5nymhBz5xQuf8CqG8OJr4=;
        b=sme3zgAmzQduFkzUo7E7f5eQZMJa3fnQrOektKNNlG3qHZyjx+gugUTEvhxDweudgc
         Xrn1f/qVwH1SZ6EHgp5YzIM/GA4q1A/Xh8MTzcyQqO3k/kTHeIHGgLMEZn0rWPP3r1ZS
         S0X02Og4zzGF62aWtQGVrS9J/VHGBVYyRIyeNHbwrFVO1NhuDge1QU4aYsAlT2xf/Pln
         qV218p69LURe2muWVW3NuOYDZnA3MB8i8Qp1fMFiRmfh/yXdhDkeRYJg/bdS/vAEkwV9
         k7wYRHRnOo9gnRAUDlY2GIF8PWhbfLZm7UJ56YFC/QPSwRzmjNAaeerPAIQlWCcivAy1
         JwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o8WfKmwINea2dak8eWcmeq5nymhBz5xQuf8CqG8OJr4=;
        b=g0cvQ95zXFPts9GpGyhpI/8HqF17KRzoOjDyXYs7pk3XqH8vAXgvaNSsBcB1LlrI7b
         t99vjzYG6ckP8yB01rEJgBTmU7xaLXZ3Dru1rbFJJiL1Ichw3Z+/mtuq1xy7Bxt+MAA2
         MhoLnsVUJlWoZovZEm5aNkLV6mR/TqrOidVQwgru/zDjpJRQJ94THkNf1/RQ689+wpoT
         4ZrM6heHC8Y+mR0Avyg4bzdIhpX+J8AVUTPw9nXQAv+8//rW/Yz5YrPcDlJzW19C9vh+
         X0w0x6G4FUOA5uDPALXAAuqebijcFvjI50pwvU2CaYC7UEQOiKiIBo6gn69xgYh155rA
         D0GQ==
X-Gm-Message-State: AOAM531V6QI4njh0idaBESKlg0dPUcWp1TUM7ZANVpUQ3nUDm1aY+pTE
        9M6EIiIvmmVc6z4BxfpIntJSWi6pUAQ=
X-Google-Smtp-Source: ABdhPJyvqIYq99aYHZZ4QxkLEnzM+vZyY2LJsYVQru7UAbCFTMMITPvHy9591bOseWCwgr4vXYUr3A==
X-Received: by 2002:a65:63d7:: with SMTP id n23mr4788455pgv.46.1628902874156;
        Fri, 13 Aug 2021 18:01:14 -0700 (PDT)
Received: from WRT-WX9.. ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id p17sm2905008pjg.54.2021.08.13.18.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 18:01:13 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] alpha: in_irq() cleanup
Date:   Sat, 14 Aug 2021 09:01:03 +0800
Message-Id: <20210814010103.3929-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the obsolete and ambiguos macro in_irq() with new
macro in_hardirq().

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 arch/alpha/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index a5123ea426ce..a524de9f1c98 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -134,7 +134,7 @@ common_shutdown_1(void *generic_ptr)
 #ifdef CONFIG_DUMMY_CONSOLE
 		/* If we've gotten here after SysRq-b, leave interrupt
 		   context before taking over the console. */
-		if (in_irq())
+		if (in_hardirq())
 			irq_exit();
 		/* This has the effect of resetting the VGA video origin.  */
 		console_lock();
-- 
2.30.2

