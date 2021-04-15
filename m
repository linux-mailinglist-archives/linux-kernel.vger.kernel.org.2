Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F6536085E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 13:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbhDOLhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 07:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhDOLhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 07:37:18 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81A9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 04:36:54 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id q10so16712554pgj.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 04:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rQJvTRV/7fDjT3QOfBh4SWLg2NtE/ncgVTRZLXI3jQg=;
        b=CV/zbT38o9xc/JlxxrpsDppJB6brI9Du6N5vvwdGkdGF5fdycvNr6yjPe2b9UlcmuP
         Ct9uO/UC2MhalLtR6y0j+U6yWqPTwGgYO7xgjLU8uvY+QkqhHMeOmr02DsBnQ15h6NMK
         /YaEN8z7e/eznmZEjoiVGqSKJ/IZv1NH1ESLAAf4ULDUzxx6OTTd83DWvFOKs+Fv05KQ
         jCm4kemnKQV25wC0DCV09QP9dyGB9T5Yv7u1ygwuiGDtCAlUXM+RTkZswcOMNHDiVtUT
         DsY8HoKwfMlQ+cj3LURUY2E5oA0oWJuqsWfxx+StL6EAsCuuaK6VALdLpq1NRyboeKI5
         j90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rQJvTRV/7fDjT3QOfBh4SWLg2NtE/ncgVTRZLXI3jQg=;
        b=BSotEVmLMSFwu3XouP9J/Htii1CETHtfQhlsWD2VLgka17+0naNsP9ZpEIXVKXHaBD
         mSkZIw43Un7lEnqPbZK69tdi8LHzBd5w/K8DNxyHjDlpp7gymwgc73Hus+2WIiHKbwmG
         bfe6DgJQ/RFMDrAGfQ1F9liZGvsDuVhR/Ij7pNTJgHrCOxrCB5xcQgGBYAQk2iwWJv/U
         xhaxsOAujKHrI28jr63pnbjcjXr6i2FRsON0+37+0wng3bVTR1Br5JEawDMW3TubtqgO
         4vInvK/duz+FfyERZF9oWqyk5crpjKrcIryJQ8XpC9cRbAOrkAHPQVzI6y9f5LtimPca
         6GsQ==
X-Gm-Message-State: AOAM53195mYuY/CD1SsAhuCCS/QMseenHjMZrsvm6otm6vuUTRfX9kMJ
        U2kxvz9WQuiXlXTrSkQtpvI=
X-Google-Smtp-Source: ABdhPJxQJQc/RvwTVocfAoK8WkLBXWEsSusi/CuxEGqLvPFcb0KI04pQzDT+fO/bAZMQKwYg0xUCAA==
X-Received: by 2002:a05:6a00:796:b029:247:7a27:d612 with SMTP id g22-20020a056a000796b02902477a27d612mr2717087pfu.78.1618486614369;
        Thu, 15 Apr 2021 04:36:54 -0700 (PDT)
Received: from mi-OptiPlex-7060.mioffice.cn ([209.9.72.212])
        by smtp.gmail.com with ESMTPSA id f65sm2276777pgc.19.2021.04.15.04.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 04:36:54 -0700 (PDT)
From:   zhuguangqing83@gmail.com
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     linux-kernel@vger.kernel.org,
        Guangqing Zhu <zhuguangqing83@gmail.com>
Subject: [PATCH] extcon: maxim: Fix missing IRQF_ONESHOT as only threaded handler
Date:   Thu, 15 Apr 2021 19:36:48 +0800
Message-Id: <20210415113648.21660-1-zhuguangqing83@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guangqing Zhu <zhuguangqing83@gmail.com>

Coccinelle noticed:
  1. drivers/extcon/extcon-max14577.c:699:8-33: ERROR: Threaded IRQ with
no primary handler requested without IRQF_ONESHOT
  2. drivers/extcon/extcon-max77693.c:1143:8-33: ERROR: Threaded IRQ with
no primary handler requested without IRQF_ONESHOT
  3. drivers/extcon/extcon-max77843.c:907:8-33: ERROR: Threaded IRQ with
no primary handler requested without IRQF_ONESHOT
  4. drivers/extcon/extcon-max8997.c:665:8-28: ERROR: Threaded IRQ with
no primary handler requested without IRQF_ONESHOT

Signed-off-by: Guangqing Zhu <zhuguangqing83@gmail.com>
---
 drivers/extcon/extcon-max14577.c | 2 +-
 drivers/extcon/extcon-max77693.c | 2 +-
 drivers/extcon/extcon-max77843.c | 3 ++-
 drivers/extcon/extcon-max8997.c  | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/extcon/extcon-max14577.c b/drivers/extcon/extcon-max14577.c
index ace523924e58..af15a9e00ee9 100644
--- a/drivers/extcon/extcon-max14577.c
+++ b/drivers/extcon/extcon-max14577.c
@@ -698,7 +698,7 @@ static int max14577_muic_probe(struct platform_device *pdev)
 
 		ret = devm_request_threaded_irq(&pdev->dev, virq, NULL,
 				max14577_muic_irq_handler,
-				IRQF_NO_SUSPEND,
+				IRQF_NO_SUSPEND | IRQF_ONESHOT,
 				muic_irq->name, info);
 		if (ret) {
 			dev_err(&pdev->dev,
diff --git a/drivers/extcon/extcon-max77693.c b/drivers/extcon/extcon-max77693.c
index 92af97e00828..4494eefce31f 100644
--- a/drivers/extcon/extcon-max77693.c
+++ b/drivers/extcon/extcon-max77693.c
@@ -1142,7 +1142,7 @@ static int max77693_muic_probe(struct platform_device *pdev)
 
 		ret = devm_request_threaded_irq(&pdev->dev, virq, NULL,
 				max77693_muic_irq_handler,
-				IRQF_NO_SUSPEND,
+				IRQF_NO_SUSPEND | IRQF_ONESHOT,
 				muic_irq->name, info);
 		if (ret) {
 			dev_err(&pdev->dev,
diff --git a/drivers/extcon/extcon-max77843.c b/drivers/extcon/extcon-max77843.c
index 8e6e97ec65a8..9167f99d2979 100644
--- a/drivers/extcon/extcon-max77843.c
+++ b/drivers/extcon/extcon-max77843.c
@@ -905,7 +905,8 @@ static int max77843_muic_probe(struct platform_device *pdev)
 		muic_irq->virq = virq;
 
 		ret = devm_request_threaded_irq(&pdev->dev, virq, NULL,
-				max77843_muic_irq_handler, IRQF_NO_SUSPEND,
+				max77843_muic_irq_handler,
+				IRQF_NO_SUSPEND | IRQF_ONESHOT,
 				muic_irq->name, info);
 		if (ret) {
 			dev_err(&pdev->dev,
diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8997.c
index e1408075ef7d..8b5efbca15e3 100644
--- a/drivers/extcon/extcon-max8997.c
+++ b/drivers/extcon/extcon-max8997.c
@@ -664,7 +664,7 @@ static int max8997_muic_probe(struct platform_device *pdev)
 
 		ret = request_threaded_irq(virq, NULL,
 				max8997_muic_irq_handler,
-				IRQF_NO_SUSPEND,
+				IRQF_NO_SUSPEND | IRQF_ONESHOT,
 				muic_irq->name, info);
 		if (ret) {
 			dev_err(&pdev->dev,
-- 
2.17.1

