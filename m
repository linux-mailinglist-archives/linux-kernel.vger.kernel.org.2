Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB38363D49
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 10:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238133AbhDSISU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 04:18:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50453 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235494AbhDSISH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 04:18:07 -0400
Received: from mail-ej1-f71.google.com ([209.85.218.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYP68-0007ve-PU
        for linux-kernel@vger.kernel.org; Mon, 19 Apr 2021 08:17:36 +0000
Received: by mail-ej1-f71.google.com with SMTP id j25-20020a1709060519b029037cb8ca241aso3347835eja.19
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 01:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UpAJNzbD9MKVQi14LfzEiS6XF3kyB2Fc0GZ6ydruDWw=;
        b=nlH1yoq9F3w6YQaO4FZbckZjrdf77mHamY0R8pbLrZzHL7zJoaReE3VArA3yxZ8xrS
         NJmqCkabVud+VEvXyQ+PJLJReCxQVqlPEt1huyoC6uInKag73gfJWXxu8a1cHfd0nico
         5TNLDqwAdTsTvUzk7uz6sQN0bw4g3ail+k+yJD7nzv4Tp4js4bju5NP490r5uQG+Lug8
         mRh6AvDPEBmGW0UdwoOUDRzM1BVxB7HeJS+ncSipGhjJF32wGtOUtENGYrN4Y6x/DiEh
         utZocUJY5CaByut1eof0CVzCmBE0ZzbEhwG4rta/hqABwOWjPUzu0xA+hPSv2ix2AZUj
         4QKg==
X-Gm-Message-State: AOAM530YgpAryCt1xgBv1QXlTjQtS8O92RfIdJVWSUTe8zUn3h/mP91G
        DA0tvaHdYmeOMuvxqnISxn2JYQXVuRF6YPVB3r/aZ8HRfdT5B7j+Pz6x+vqDUIvtnPZynCBAqlj
        ejXu8r9jkGW34HkpgQDSiWDHufH1DdCaNGuQe/xfsQA==
X-Received: by 2002:aa7:cd83:: with SMTP id x3mr23871129edv.373.1618820256546;
        Mon, 19 Apr 2021 01:17:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrRRvmlGCkxx4tXzhKQpNcCtZtp5i5u5JPY0gywyHuqwKmdgiNtXRNYyjndMc/zdrzzTv4fQ==
X-Received: by 2002:aa7:cd83:: with SMTP id x3mr23871118edv.373.1618820256448;
        Mon, 19 Apr 2021 01:17:36 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id da13sm12384781edb.6.2021.04.19.01.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 01:17:36 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 6/7] mfd: wm831x: Correct kerneldoc
Date:   Mon, 19 Apr 2021 10:17:25 +0200
Message-Id: <20210419081726.67867-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210419081726.67867-1-krzysztof.kozlowski@canonical.com>
References: <20210419081726.67867-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct kerneldoc function name to fix W=1 warning:

  drivers/mfd/wm831x-core.c:121: warning:
    expecting prototype for wm831x_reg_unlock(). Prototype was for wm831x_reg_lock() instead

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/mfd/wm831x-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/wm831x-core.c b/drivers/mfd/wm831x-core.c
index bcef08f58fb3..c31809b17547 100644
--- a/drivers/mfd/wm831x-core.c
+++ b/drivers/mfd/wm831x-core.c
@@ -109,7 +109,7 @@ static int wm831x_reg_locked(struct wm831x *wm831x, unsigned short reg)
 }
 
 /**
- * wm831x_reg_unlock: Unlock user keyed registers
+ * wm831x_reg_lock: Unlock user keyed registers
  *
  * The WM831x has a user key preventing writes to particularly
  * critical registers.  This function locks those registers,
-- 
2.25.1

