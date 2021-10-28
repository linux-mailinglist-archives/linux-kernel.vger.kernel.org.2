Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA8D43E86F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 20:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhJ1SiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 14:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbhJ1Sh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 14:37:57 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49718C0613B9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 11:35:30 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j9so15509180lfu.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 11:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n4WzQadX+RqazB/22Gcyj8+qG3ieppJrK8iuTkJY04o=;
        b=lz9xHVl/WZ2+qnHRULOWJhF3wAg+Qu/4QXcPuEBwjl0bcQxDa7ZcADKsUnqisJL85m
         9QuxVaumc9MsznWizeq3BP1NSxZv7ZZKlHK0QE7Bt3b1WVXBM4cd1AQ+bZSm9I81B/+y
         nrw2D9un7XZGlJbRX4HJx4X+vEMQysSSi9CKh4jgzthdODy8xr6DoJz9mecr8DutP+vd
         4InCy0xFoZRcbF7Xm+9ocRSWR0Nn24L+m+Xtf+ZAVZnWhEQO/f37Miw4CpwOn192h3dY
         SYx9lUgPK9DHydFFvuDaDUxvKoBcA4cUZN+0GEGni0H3/OF+3HBCMV3nTsr1lj44uFFa
         XG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n4WzQadX+RqazB/22Gcyj8+qG3ieppJrK8iuTkJY04o=;
        b=3VZNtfSKbSAHypgHRgY2fpb0dt1T4oVlnNmzkHZzSHY3eBVz32+rMk9LYcKvl27VeE
         34tWwzA/ydSCt2c17p+LEUreb4FjGPUD713isGHSRLJlF2YkXcB2A4jL4TYhtZ+bXvI+
         YVmlZ7eZ25wnGzkB3WcchP0hgII0NRvpaqIC5wPGBBiheaQsTN+piqdJnhLXUjksqVSL
         4EH9o6p+HlKmVVZftIrTRX9pS+SsVLUlC1UXljw7G9aUTsI2fp4m5ebFlcV5AeyrbO2y
         Co49JI65G5+Pemr2/l3FrmpA2SdcjxM6ajtt8ejfvHenSVN2P2PgUytGBWP5lHuMMdzX
         uGvA==
X-Gm-Message-State: AOAM532R9cXoYhEyP5XTCmhgPx+SeBoLRZYJ4jPstbH/g4OiSKzhLQV4
        bGdbdCdZgpV3w/trOtatvrCWWg==
X-Google-Smtp-Source: ABdhPJzw48y/mBL2BnGr0m1Qqbbip97MzoXwpbjKR4smI4OiyzC/sI4MTwQAwE05fJIq4q+TjgD1Pw==
X-Received: by 2002:a05:6512:b8b:: with SMTP id b11mr5822144lfv.99.1635446128588;
        Thu, 28 Oct 2021 11:35:28 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id z3sm390466lfh.17.2021.10.28.11.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 11:35:28 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 0/7] watchdog: s3c2410: Add Exynos850 support
Date:   Thu, 28 Oct 2021 21:35:20 +0300
Message-Id: <20211028183527.3050-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos850 WDT IP-core differs a bit from existing platforms:
  - Another set of PMU registers
  - Separate WDT instance for each CPU cluster, having different PMU
    registers/bits
  - Source clock is different from PCLK

Implement all missing features above and enable Exynos850 WDT support.

Sam Protsenko (7):
  dt-bindings: watchdog: Require samsung,syscon-phandle for Exynos7
  dt-bindings: watchdog: Document Exynos850 watchdog bindings
  watchdog: s3c2410: Make reset disable optional
  watchdog: s3c2410: Add support for WDT counter enable
  watchdog: s3c2410: Introduce separate source clock
  watchdog: s3c2410: Add Exynos850 support
  watchdog: s3c2410: Let kernel kick watchdog

 .../bindings/watchdog/samsung-wdt.yaml        |  17 +-
 drivers/watchdog/s3c2410_wdt.c                | 215 ++++++++++++++----
 2 files changed, 190 insertions(+), 42 deletions(-)

-- 
2.30.2

