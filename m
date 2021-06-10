Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8BB3A34EE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 22:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhFJUiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 16:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhFJUiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 16:38:11 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECEAC0617A6;
        Thu, 10 Jun 2021 13:36:14 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q5so3692464wrm.1;
        Thu, 10 Jun 2021 13:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4y60JQKB34QNB9sv/yVkOKvgJb0tCzWEyPcfsh+RT04=;
        b=PcjnJftVqR/ROjwfq0tFEg0fB0K9gCSVZbIYnUcPD+/HaEW2ZXgAICk/2U9vu4758U
         4eMlZ8CotUsYxW+dTA970o2Nd0PGXn8FGGYHpCf/K3b3ETuJo8m8v40LZ6GnlMe1TGzq
         Vy34yXrMR841+qJwO4ogNwI7b2ErwjL8irjL9SKfMRevUXHNH5sm3I9duo7kjymeWIOd
         VdeXPXKE9MVAjOwhKGy9mzs4rmLRonmI3AW3FiuauUlpRNCyYB5Fvhlr9DT5N1auJo06
         ivo7Jvu+VuR7nOhu0z1g0ce4QC/iVW6wPo9Qb1A1Hvcdg6XI2KdQs5QAd2uCyL4yfGEz
         v5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4y60JQKB34QNB9sv/yVkOKvgJb0tCzWEyPcfsh+RT04=;
        b=dIRQMVUpRe8uKiXVT3BS1d54NytXija+xvO/8G8qdeYRAiLVMABkpn11/ScUeI9pYI
         7BrUtml+7Z1jCxQ9knAJtQnwKlBUY4yGI+oilnesH+HMKr5vBT/NP+cTdbz0lrVdpOP2
         o1i27iAKWqT/2Zj3xi0VnXND7MmzRJYT5x8HuRf6uqX1gE1HI6ki+hiZZB5o+ZuZoHbL
         qU+kXPfthkxVW5y9RYaGb7ZU45KXU71oBXwaMvTUO/HdDDlwQunen46vnqWJnV9n+EIk
         EoSI71ME/BtKpSxLi3NPZqexszZ/WOjqkMtBHKkdrFEiaxe1UpdUQTylvIBe/R+H1rbf
         YBHg==
X-Gm-Message-State: AOAM531mtgLXWzlJkoJVuXDqGy3Uz5v/vermXYNyY4dNt5tahP+6YlqV
        BVBbEoXPE1snQyAH1ZmOGW0=
X-Google-Smtp-Source: ABdhPJy2v9npB3FyNxPLPFnXfwq+1w5IMJ00c7ENkpN5tVzc0BUXqR8AImvpCsMubYuk1CowL5g1wQ==
X-Received: by 2002:adf:e389:: with SMTP id e9mr278787wrm.424.1623357373120;
        Thu, 10 Jun 2021 13:36:13 -0700 (PDT)
Received: from cluster5 ([80.76.206.81])
        by smtp.gmail.com with ESMTPSA id q3sm4542609wrz.71.2021.06.10.13.36.11
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 10 Jun 2021 13:36:12 -0700 (PDT)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] ARM: dts: NSP: enable DMA on bcm988312hr
Date:   Thu, 10 Jun 2021 21:35:12 +0100
Message-Id: <20210610203524.2215918-3-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210610203524.2215918-1-mnhagan88@gmail.com>
References: <20210610203524.2215918-1-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous patch "ARM: dts: NSP: Disable PL330 by default, add
dma-coherent property" set the DMAC to disabled by default, requiring it
to be manually enabled on each device. The bcm988312hr was mistakenly
omitted. This patch adds it back.

Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
---
 arch/arm/boot/dts/bcm988312hr.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/bcm988312hr.dts b/arch/arm/boot/dts/bcm988312hr.dts
index a7953e5acc01..7cfb48fb48ba 100644
--- a/arch/arm/boot/dts/bcm988312hr.dts
+++ b/arch/arm/boot/dts/bcm988312hr.dts
@@ -58,6 +58,10 @@ gpio-restart {
 
 /* USB 3 support needed to be complete */
 
+&dma {
+	status = "okay";
+};
+
 &amac0 {
 	status = "okay";
 };
-- 
2.26.3

