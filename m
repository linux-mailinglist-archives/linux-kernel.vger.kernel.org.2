Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC273453A1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhCWAJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbhCWAIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:08:55 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DD0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:08:54 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u9so24166975ejj.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RzjrmL+tkC/eeLpoJtSd20+B14+/Cwhj6C9dFlflmdg=;
        b=WqweiCaCWDAF8Ap5fY3QACCbnozJIThAuz122qgDRsjRGNMZtN21b2QQaT3GYgvi+A
         pRXeU6AcD03J4lbn2Q6YCNWtJqpZaXwDlgA/AwYNDrtN4K/HI/VfJSFVloCDe18IdD99
         BznJKf8GTSU4THzOvAwBPFavgVgFRTAE90HDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RzjrmL+tkC/eeLpoJtSd20+B14+/Cwhj6C9dFlflmdg=;
        b=r9V9uUi7sVxXLWodP1WHQuzpdh6AvfSdvdO4exOi8oqMPo0FxxPt6f93Q4m9Iks6nD
         3srOYx2GRnmwt+ha9BnHwKvw3ZezNVetXDaXDdE/Z3aM31dY32zqCABf5iT1MImhEa3C
         eVQaLtKfrHFfhj8bJkLzevhcahStUX3AU2C8stXNEaw+Qk4mx810VbRQuypfXh/KMF8Q
         jiAJtMSA18VeBlxeGfVw3TW6sD1SwMnsyf1a67LztnIICgsfrh3j4mBzJCcr8b1LiSkf
         A1GwKY7rh4yYbNPn3QtqFx1NoBmkQ21mxMiVCffsfQbSIq7rw/QkY5OaLTTHTdeqfZGB
         q5Ww==
X-Gm-Message-State: AOAM533xPS0tJ9bey37aew6nQUS6VwN8XQTx8sKkGu2P3d5d8ZxDS2br
        F+TRGXqAzgMGJOsEDtZ8947BroWeVdI6Pg==
X-Google-Smtp-Source: ABdhPJx22SDD+magR9aLHMOK4srl4u6z5iYaaq9/d8QvHGWJx+jx1WJfomVKwIXnziDulHns2iFuwA==
X-Received: by 2002:a17:906:f12:: with SMTP id z18mr2247199eji.132.1616458133495;
        Mon, 22 Mar 2021 17:08:53 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id o20sm12117379eds.65.2021.03.22.17.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 17:08:53 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] clkdev: remove unnecessary __ref annotations
Date:   Tue, 23 Mar 2021 01:08:50 +0100
Message-Id: <20210323000850.401648-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clkdev_alloc and vclkdev_alloc do not call any functions living in
.init.text (nor are there comments as to when and why that would be
safe). The original annotation dates back to when the code was
imported from ARM in 6d803ba736ab, and AFAICT the last reason to have
the annotation vanished with ea17c9d868c1 (sh: Use generic clkdev.h
header).

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/clk/clkdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 0f2e3fcf0f19..d446c2c697d5 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -153,7 +153,7 @@ struct clk_lookup_alloc {
 	char	con_id[MAX_CON_ID];
 };
 
-static struct clk_lookup * __ref
+static struct clk_lookup *
 vclkdev_alloc(struct clk_hw *hw, const char *con_id, const char *dev_fmt,
 	va_list ap)
 {
@@ -190,7 +190,7 @@ vclkdev_create(struct clk_hw *hw, const char *con_id, const char *dev_fmt,
 	return cl;
 }
 
-struct clk_lookup * __ref
+struct clk_lookup *
 clkdev_alloc(struct clk *clk, const char *con_id, const char *dev_fmt, ...)
 {
 	struct clk_lookup *cl;
-- 
2.29.2

