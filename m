Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F8A33761E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbhCKOtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:49:04 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60707 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbhCKOsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:48:40 -0500
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lKMcB-0001JL-Ju
        for linux-kernel@vger.kernel.org; Thu, 11 Mar 2021 14:48:39 +0000
Received: by mail-ed1-f69.google.com with SMTP id p6so9936596edq.21
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 06:48:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AfZi1aLqaVnii5CtMfRTKmgGkJ5oB3CQKhmO+KpjKXk=;
        b=cy5DDq/r7lUTCN6AlmpK45UisuPXQxekROjNxiigaXHSMABkrjPXOgsWVxQROgy5I5
         HJvnaohnz6ZdnbXIA/KHHobW07EgZp/q72fioJJhIHceeJiXVZtn/Mbkut9A984HrJFi
         +3qs3MWqL/wrGm0BtIQ/gywCyoJLaJqW+IHxWEfofqTdqtuAMpt0I7KvcRHYhrG1MNS7
         g5jxFyx4e0aCGfxYquCXv0BMrcRbZFiJp4VRKZ10vkBmPRav31/fjrQH0RXqJxPw3VzD
         OhzKaYtXIghXR6aMkOnXXdcBbjHIBHgPnTKSOQ4hkv3DSRKhSKMniqBLUtvFRSqUSWce
         alwA==
X-Gm-Message-State: AOAM530r5176LGaWEsc9W58fNkvJ5ubUGPCgzjv3YUqTk36aQGTUy5Qo
        HT7DqMz0XfeigpY2qs3TpVARe80vzrKMcnM1IXKa05XulMAX13nS0NuFSbXU5tYGqkJPKbiDsWm
        gqe1tYueL0/mJkb/A+wu5iYetvWJy1WHJ99UQT7V5Ww==
X-Received: by 2002:a17:906:d9d1:: with SMTP id qk17mr3415852ejb.52.1615474119390;
        Thu, 11 Mar 2021 06:48:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyagpzsCI1n5bt7Tkf7ZjVO9M2j0SJ55XaHVkf0RzwuAx+DX5ofwBgGUu7nSq8q0RydQaLX5Q==
X-Received: by 2002:a17:906:d9d1:: with SMTP id qk17mr3415833ejb.52.1615474119145;
        Thu, 11 Mar 2021 06:48:39 -0800 (PST)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id u59sm1559995edc.73.2021.03.11.06.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 06:48:38 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH] clk: socfpga: fix iomem pointer cast on 64-bit
Date:   Thu, 11 Mar 2021 15:48:33 +0100
Message-Id: <20210311144833.1313387-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointers should be cast to unsigned long instead of integer.  This fixes
warning when compile testing on ARM64:

  drivers/clk/socfpga/clk-gate.c: In function ‘socfpga_clk_recalc_rate’:
  drivers/clk/socfpga/clk-gate.c:102:7: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/clk/socfpga/clk-gate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-gate.c
index 43ecd507bf83..c876523d5d51 100644
--- a/drivers/clk/socfpga/clk-gate.c
+++ b/drivers/clk/socfpga/clk-gate.c
@@ -99,7 +99,7 @@ static unsigned long socfpga_clk_recalc_rate(struct clk_hw *hwclk,
 		val = readl(socfpgaclk->div_reg) >> socfpgaclk->shift;
 		val &= GENMASK(socfpgaclk->width - 1, 0);
 		/* Check for GPIO_DB_CLK by its offset */
-		if ((int) socfpgaclk->div_reg & SOCFPGA_GPIO_DB_CLK_OFFSET)
+		if ((unsigned long) socfpgaclk->div_reg & SOCFPGA_GPIO_DB_CLK_OFFSET)
 			div = val + 1;
 		else
 			div = (1 << val);
-- 
2.25.1

