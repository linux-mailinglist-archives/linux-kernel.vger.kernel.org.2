Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29B0368FF6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 12:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241846AbhDWKBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 06:01:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41417 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhDWKBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 06:01:19 -0400
Received: from mail-wm1-f71.google.com ([209.85.128.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lZsc5-00005E-V2
        for linux-kernel@vger.kernel.org; Fri, 23 Apr 2021 10:00:42 +0000
Received: by mail-wm1-f71.google.com with SMTP id o18-20020a1ca5120000b02901333a56d46eso537672wme.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 03:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RT/uGfEE61bUXQ3HR7ruOjjWjeW0FT4Ckc7w+ZiFRPw=;
        b=WRnUuRktBtXtBhlfeJy6XIoS9HTocWRXRy22id9HsEpK8ZI0CUBnmbNTEscuEgN8MW
         RtsNWmTce7HzqIeLguI3a9j4K8gWg57tmAvMSc45uwvqdAkacUkHLQ8j5ZduaSFqBa3f
         IkdiRRil2IX2XOt+zZm0zm8RpgSinxk1zuHapvpvZa3lfvf9iUFN5X0k8n2kBUZDyYn7
         R2TNd3EXibwzFO80UBjWp1DmO/Eufr6wMNQ0S+RL3zxOld7TZkHVJwZGpSRXXnqEPF3e
         uTAHWYFA0CKzwGjxpsD4Gga/UqdfB5Z4sDFYOoSRz6dZkRxyzzwIDdBdp2B/QHUntd2j
         snGQ==
X-Gm-Message-State: AOAM531Jah1KuwZv+fkcP8a/as/44I679Zb9ZpdHOF3vMpvb0Ub+Feuh
        UaWI4mtUqnGHTtzbezadjkgQ9bHTIQCPvkoCjfg3od1WlN7oYgzvDSVbu/UZPo2jTPlHctG/QZO
        uJA8Nb/ZAxiwzQBeW83s4hOP2cKn9Kq0Jct0xUAzZcw==
X-Received: by 2002:adf:9d88:: with SMTP id p8mr3657103wre.138.1619172041622;
        Fri, 23 Apr 2021 03:00:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw37ml8W+zBb1rCUp4rhtus6Jm+/6pWmI4PCg6VZ5/5mLKg2BJ23hfoMJNqtZbgO3uAQu/Kig==
X-Received: by 2002:adf:9d88:: with SMTP id p8mr3657089wre.138.1619172041449;
        Fri, 23 Apr 2021 03:00:41 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id r2sm8006103wrt.79.2021.04.23.03.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 03:00:41 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] coccinelle: irqf_oneshot: reduce the severity due to false positives
Date:   Fri, 23 Apr 2021 12:00:33 +0200
Message-Id: <20210423100033.78580-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IRQF_ONESHOT should be present for threaded IRQ using default
primary handler.  However intetrupt of many child devices, e.g. children
of MFD, is nested thus the IRQF_ONESHOT is not needed.  The coccinelle
message about error misleads submitters and reviewers about the severity
of the issue, so make it a warning and mention possible false positive.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 scripts/coccinelle/misc/irqf_oneshot.cocci | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/misc/irqf_oneshot.cocci b/scripts/coccinelle/misc/irqf_oneshot.cocci
index 7b48287b3dc1..9b6f404d07f2 100644
--- a/scripts/coccinelle/misc/irqf_oneshot.cocci
+++ b/scripts/coccinelle/misc/irqf_oneshot.cocci
@@ -103,11 +103,11 @@ devm_request_threaded_irq@p(dev, irq, NULL, ...)
 @script:python depends on org@
 p << match.p;
 @@
-msg = "ERROR: Threaded IRQ with no primary handler requested without IRQF_ONESHOT"
+msg = "WARNING: Threaded IRQ with no primary handler requested without IRQF_ONESHOT (unless it is nested IRQ)"
 coccilib.org.print_todo(p[0],msg)
 
 @script:python depends on report@
 p << match.p;
 @@
-msg = "ERROR: Threaded IRQ with no primary handler requested without IRQF_ONESHOT"
+msg = "WARNING: Threaded IRQ with no primary handler requested without IRQF_ONESHOT (unless it is nested IRQ)"
 coccilib.report.print_report(p[0],msg)
-- 
2.25.1

