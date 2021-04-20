Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902E23657C6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 13:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbhDTLkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 07:40:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39155 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbhDTLkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 07:40:13 -0400
Received: from mail-ej1-f70.google.com ([209.85.218.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYojE-0005XY-NX
        for linux-kernel@vger.kernel.org; Tue, 20 Apr 2021 11:39:40 +0000
Received: by mail-ej1-f70.google.com with SMTP id f15-20020a170906738fb029037c94426fffso4674769ejl.22
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 04:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xk3WBnA32t2m4Myce9cZ0YQ9ZIjnwr2MU+dccRhDaEQ=;
        b=izgyJxkNYHfMZvRHv31Uu5hF7rT88XIGu3inKplXboVP7B0RoCR6R95xNZXf+ERF/Z
         RzaOnRmzcyKW8eVTjhj3hPAszHcVC1SJYd6zFEJquP4En7WKjpNZ3bFAjEc9Lja0hNiK
         ZG47GebrxgKR9yj4GxFuK7eH7noiD8IZ4HKblIQclcDc6h9z1RVwEO+rwrwyzc4u+Sy5
         LpQazH/3w01wdL1YR2UwZrcUgRKWaxbik3++GoriKIdcVjWU+KmdeD8J/WHQOayUxEVM
         Nylx+6EL98B8qLVj0OFPwQnggzlhv5CuYE+pzAY1pKgepyTzw5svolir7yBukEphbCrI
         NVEQ==
X-Gm-Message-State: AOAM533cKqqGM7W1XPCiTtZospgYG5ywt9/kmTl7N3zxVGyls6IdC1QH
        IhV6UmCZnosmCcsiJKkrNVptCIfhPcS2dWx+R5Aiat06ht+RJe7Eyz6aNpLVVhlNIGe6XZiXGL5
        KlRzE4+2mKAMENs63sBCGGQ5HmjFqkJevFPtWQ8B7jQ==
X-Received: by 2002:a17:906:b85a:: with SMTP id ga26mr27062871ejb.366.1618918780498;
        Tue, 20 Apr 2021 04:39:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJs56MliRWAB0TrKrTN4psbryZ6Ncf4csq/xRSSpnIs0jNai0M7qouKkTw2it1vSiuzy3rzQ==
X-Received: by 2002:a17:906:b85a:: with SMTP id ga26mr27062853ejb.366.1618918780368;
        Tue, 20 Apr 2021 04:39:40 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id bw26sm10109007ejb.119.2021.04.20.04.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 04:39:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org,
        patches@opensource.cirrus.com
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH v2 7/7] mfd: twl: Correct kerneldoc
Date:   Tue, 20 Apr 2021 13:39:29 +0200
Message-Id: <20210420113929.278082-7-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420113929.278082-1-krzysztof.kozlowski@canonical.com>
References: <20210420113929.278082-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct kerneldoc function name to fix W=1 warning:

  drivers/mfd/twl-core.c:496: warning:
    expecting prototype for twl_regcache_bypass(). Prototype was for twl_set_regcache_bypass() instead

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/mfd/twl-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 20cf8cfe4f3b..24b77b18b725 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -485,8 +485,8 @@ int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
 EXPORT_SYMBOL(twl_i2c_read);
 
 /**
- * twl_regcache_bypass - Configure the regcache bypass for the regmap associated
- *			 with the module
+ * twl_set_regcache_bypass - Configure the regcache bypass for the regmap
+ *			     associated with the module
  * @mod_no: module number
  * @enable: Regcache bypass state
  *
-- 
2.25.1

