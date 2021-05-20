Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CB338B41B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 18:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbhETQSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 12:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbhETQSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:18:33 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88B0C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:17:11 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id f75-20020a1c1f4e0000b0290171001e7329so5573691wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DSEIaoO2erY4/GbHdcIXSVMqyjIxSPIRHtmmIHvOzJQ=;
        b=tbFnB+3MOF41wS7CnLWRHfkq70bfUI46jiga1LlvvKZag6xEnebf1vG8T6QthEPEGy
         ne3U7rB6/w5TzqdYQghWXw9FivPZGYh6vOXwQJhy/4ngE+bs3kUKiJZk9nwSEeEq3ZJl
         hoGdGKe+98I31n+mmvwigz7sNDdPOWHceUN8mjHQXhE8hpZVvZCeEpmU0+hVwMlvwAqe
         iM7O37Wya7xBx7zHqZVYJAt86ttevMbEiAi+o3E5b/yUvYp1VCHcUNmsa7TxA+hwO9dH
         V8Px7CZokgxAB5GhsQOyJPtI3ML9u5LcOwq0MiCNC+LzJhR0X0VVMbKyYR4zQl/6QFci
         culw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DSEIaoO2erY4/GbHdcIXSVMqyjIxSPIRHtmmIHvOzJQ=;
        b=qLxp75d5LQ3H2Z5U0QZTFB5t8CS7AvhbK2BUrRt+eG0wjeNKZiN0V0v6wGSxkq+Hv0
         sM3Rj/7rsqGhlq3K5T9pBWxja+RHwZDBFdq/qDaS/uX/XS3WD3FLovU2phudEtcwmUbv
         jKSbHnAAzQNwhTIHfoB6WOyEI0KUPcmaDEw1l7WBQhnlPOz0LIoCGoceU4GrvfhG2XAH
         21GuJQSgiQDMzE5zewdoNdA+dVJ2Xi9fQg4tbnZN44u12FCEk9NZUHm/HQvy99uNf+X7
         z4TukCZqacAfGoze9xhv3j9CMj9ch9vAcFdS8WCuACj01jpfLm5cByY92tXz01hzYX+i
         GfOg==
X-Gm-Message-State: AOAM530vi80lPb0mGluruGAp5NascnwUAVnrFZhDYmWibq3KgKcr26dC
        /sBASNbwqpk1AwsOl9H3cOR8OuJT+u6cq46O
X-Google-Smtp-Source: ABdhPJyYblC5KDnM7csM6z7PWzIyBhMBmbPHHL8eT9KaZ+21Ymq3o7CJAGPN/DbTRC/nLLRCxbkHrQ==
X-Received: by 2002:a7b:c849:: with SMTP id c9mr4917981wml.84.1621527430402;
        Thu, 20 May 2021 09:17:10 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v15sm9465137wmj.39.2021.05.20.09.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 09:17:09 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org, linus.walleij@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Peter Collingbourne <pcc@google.com>
Subject: [RESEND 1/1] clk: versatile: remove dependency on ARCH_*
Date:   Thu, 20 May 2021 17:17:02 +0100
Message-Id: <20210520161702.3746174-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Collingbourne <pcc@google.com>

It is now possible to build a modular kernel for vexpress by
not setting CONFIG_ARCH_VEXPRESS=y and instead setting =m on the
drivers that it normally implies. This is with the exception of
CLK_VEXPRESS_OSC which is currently hidden behind a dependency on
one of several ARCH_* variables. Remove that dependency so that
CLK_VEXPRESS_OSC may be enabled without it.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/I435a21e2e5f6187db54f4ef2079b60028ab2ea69
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/versatile/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/versatile/Kconfig b/drivers/clk/versatile/Kconfig
index 91f0ff54237d2..792315d893db3 100644
--- a/drivers/clk/versatile/Kconfig
+++ b/drivers/clk/versatile/Kconfig
@@ -1,8 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 menu "Clock driver for ARM Reference designs"
-	depends on ARCH_INTEGRATOR || ARCH_REALVIEW || \
-		ARCH_VERSATILE || ARCH_VEXPRESS || COMPILE_TEST
 
 config ICST
 	bool "Clock driver for ARM Reference designs ICST"
-- 
2.31.1

