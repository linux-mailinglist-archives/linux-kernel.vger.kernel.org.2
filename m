Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9022341BB59
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 01:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243529AbhI1X65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 19:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243523AbhI1X6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 19:58:51 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392B3C06176D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 16:57:02 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id m1-20020a05620a290100b0045e5e0b11e6so3038778qkp.23
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 16:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0xU4rMhQf+Tsh4aGgPmL2VLP+qQMedKrbqJYsYtJvB8=;
        b=FTmdfSXZII7cRm19ecx75o8eAllYwqePg0NuCytvZQYsu0X/kUlzn7IL8ZeM/3z4ja
         ZLxBRz3wowKQUTP2PFV5gX3ESiyJcR4aH9wi1Bgcnw8DRlxUhWx/YFPBDqKHfEH+vxNZ
         cSU3SmdXvpusOlXyjNep2n+mzycENEL8nX5N4xL+wDPAkVYMzyVGKzEuXiFRmw4jjmh8
         ++Cz3M/FDUY0WukzbPkIqUDEzhDjIi1+Eo/eK2TZ2gQgOn8zz0pRZoIgB2McJjePq0uw
         uic1+Yv4HruxWjTzDDf3GC4w+FJmQOaZecctiPMnp6RQ+M4dYt0OVyK8EvWZCsA7IvzU
         4+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0xU4rMhQf+Tsh4aGgPmL2VLP+qQMedKrbqJYsYtJvB8=;
        b=kEEyFIbHLNVgou5m6aViRp6rtC0AsNk5t3+uPHbC24kJXRM/TuoZoykAvYond140ow
         g3lwopVNc9IDKzdhJ8fJSygDzY4r4MkbGjy7j0KY3ScctNyra4iH9S2KQ/Jke/8jJKyt
         uSfcB8sQMUrc1HLVxD2zzfItt8KmsLrctiA7onJp3StKSaCRWjaB5De1JpI7hXbENpGO
         IUsxB3gxX+p9UtVX7J73a5tA3KLapooZl1hLGl0dpSV3noOJYuuF3Mk8wb0O++pd00Z9
         GY4DahqUsaztDT3vOSPDN28BJGlzZg+lwb9Hm6yez9U3jKqHhwuo2pTTVk5ghs/CKNup
         NBrg==
X-Gm-Message-State: AOAM532wKm2Uk8FqDQrXhg05eTfInrvyLBwAyyPhSUX1PrqHn2+jDCom
        SOtl+vUaQZokWMxSzffPIHS3MRzNuOJeGrScpyo=
X-Google-Smtp-Source: ABdhPJxXnGbQVYIKPCX7yNjY7ijrlFpSIGUian9jiU0yLqRqfT6gSGW3vVD1t8tBVnpZPavgKlT5Hlw9NDYqIMPa9/k=
X-Received: from willmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2dd0])
 (user=willmcvicker job=sendgmr) by 2002:a05:6214:98d:: with SMTP id
 dt13mr8482075qvb.13.1632873421401; Tue, 28 Sep 2021 16:57:01 -0700 (PDT)
Date:   Tue, 28 Sep 2021 23:56:22 +0000
In-Reply-To: <20210928235635.1348330-1-willmcvicker@google.com>
Message-Id: <20210928235635.1348330-6-willmcvicker@google.com>
Mime-Version: 1.0
References: <20210928235635.1348330-1-willmcvicker@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v2 05/12] clk: export __clk_lookup
From:   Will McVicker <willmcvicker@google.com>
To:     Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Saravana Kannan <saravanak@google.com>,
        Will McVicker <willmcvicker@google.com>,
        kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This symbol is needed to modularize the samsung clk drivers. It's used
to get the clock using the clock name.

Signed-off-by: Will McVicker <willmcvicker@google.com>
---
 drivers/clk/clk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 65508eb89ec9..f2aa4b49adfc 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -612,6 +612,7 @@ struct clk *__clk_lookup(const char *name)
 
 	return !core ? NULL : core->hw->clk;
 }
+EXPORT_SYMBOL_GPL(__clk_lookup);
 
 static void clk_core_get_boundaries(struct clk_core *core,
 				    unsigned long *min_rate,
-- 
2.33.0.685.g46640cef36-goog

