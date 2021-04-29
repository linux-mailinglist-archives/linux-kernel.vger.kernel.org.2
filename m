Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B5F36E788
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 11:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240059AbhD2JEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 05:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239730AbhD2JEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 05:04:39 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19625C06138C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 02:03:51 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id i24so18049392edy.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 02:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W+HLzXbkNngIE9tkgHqx97GNCxRpXGXx8Ojt9z/evco=;
        b=GBItjtMHIl9+fy1sfAPi2drO9fIPPAf3u5xufxexjqsbdmF4uIINYvXOAIEZgiqqNo
         Wsdh5SY6oBaU0E1YBTd6SU1JID0yqbCaxQnC2QDGLRJDbsf2jA9M1uy6tP9NMdj/TI7O
         0SmHpAVj7lb1ZtvDMcU9EZ6CvFVspZUa6fbJzCGMuw3GbAz9due6dTzo5homhF8iyNJ6
         /XpUIyOnfqwtLwANoXjV3u/TaAUj8Z51+IELjYn2/NvqFiyGamW/0fe71ZpTDQUWqOIv
         N8Tl3L99t3uQNKJ7edqd2pawkvQ66odmZ9Z1yKetCmS56MWyapKxPrweuxY0hGLmW2Ru
         0hRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W+HLzXbkNngIE9tkgHqx97GNCxRpXGXx8Ojt9z/evco=;
        b=XO8uqFXzMXpzD4nZgS8vYfxgEZUTtyMbHxVn1M+N/TqVgbufUHOnMYMtX3gjWpUowr
         /KAZJU+W8021TzR77NABsAx5lLB+exSQ1H8h1xswa0eAiyY2naXwK54KgmjYX1xbfAob
         eEiWfS+rvdaqNvnQwSxiL98VRGnqvy0zvH8KfVLrCDxjFk5cHzkEO6F1vdZfQWVliOBj
         uIhjO4MvM1fim8yjnAcTmzF7PNbY1hEYu97jyExVljfvmD3RyB2ZxAC0IGyibEK/0aB2
         4Pe8ru/uTDJ1rBh1sUVhX9l8Vi/dlfOT81duAsqHM99+8kh3JCBSBiU49EwWfLCS8kF2
         q8cw==
X-Gm-Message-State: AOAM532gPrcg0HeXRA2WvjJZ2HjmPMOCyTzmn/RGka26cHPHG7T8QDHA
        KbxOrsSb/Ozzr3gYP4iwfJBZTA==
X-Google-Smtp-Source: ABdhPJwI3INalSk/5D1+Nz2RIt7IqV/JfVEmFAdW+NvqkU08BDtWe79kNgj0WIjvOe3XIFipym9Zjg==
X-Received: by 2002:aa7:d413:: with SMTP id z19mr16987380edq.37.1619687030544;
        Thu, 29 Apr 2021 02:03:50 -0700 (PDT)
Received: from localhost.localdomain (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id j4sm1441152ejk.37.2021.04.29.02.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 02:03:49 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: meson: g12a: fix gp0 and hifi ranges
Date:   Thu, 29 Apr 2021 11:03:25 +0200
Message-Id: <20210429090325.60970-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While some SoC samples are able to lock with a PLL factor of 55, others
samples can't. ATM, a minimum of 60 appears to work on all the samples
I have tried.

Even with 60, it sometimes takes a long time for the PLL to eventually
lock. The documentation says that the minimum rate of these PLLs DCO
should be 3GHz, a factor of 125. Let's use that to be on the safe side.

With factor range changed, the PLL seems to lock quickly (enough) so far.
It is still unclear if the range was the only reason for the delay.

Fixes: 085a4ea93d54 ("clk: meson: g12a: add peripheral clock controller")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/g12a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index b080359b4645..a805bac93c11 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -1603,7 +1603,7 @@ static struct clk_regmap g12b_cpub_clk_trace = {
 };
 
 static const struct pll_mult_range g12a_gp0_pll_mult_range = {
-	.min = 55,
+	.min = 125,
 	.max = 255,
 };
 
-- 
2.31.1

