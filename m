Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD104383B55
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 19:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242436AbhEQRen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 13:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbhEQRel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 13:34:41 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325A6C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 10:33:25 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t193so5145038pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 10:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Z4KnEHs7xum8C1o1fyhvi0Rl4fGVgrNoI+acmfQPiU=;
        b=II4ZQK+Ib6eu6M4ujmFkVGRh0lhlEXGy4OhNYHW/ayWazsn1Tih0VUQVwOoL9OfU1x
         jM+jnuudXCU2zhOtkwrDv6tVqA9VEJSmJs9Ofbc194+v3PHw9pvovOl8BXA8N2Uj/+eV
         DeHGsxJeP9fnG5JZeeAz39qR1mvm2BG8ETFLPryR2Ro/GtHqPKdSl45WVubkXVhd4KU+
         lOBzKpFSBUlvWd0MXX3+a92eSfb/1xAmfFI792M5guEwtDXHOKw6n8uZJbr+CSfEZgx4
         V8xfhWvrCdaPsrqWYkLcyIb07r15eqwXPxiCYZ4TbHPcSY7WTC2YMiA/adHG15Z9w9tG
         9rrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Z4KnEHs7xum8C1o1fyhvi0Rl4fGVgrNoI+acmfQPiU=;
        b=WI0LCXNzpObWui0pOUHVzN5Z2QvuBmW5XCaprtC4ZoIBqR5BmmWPEB9+Lm8Gaof10i
         98odtD1Jtes0LScNvODyuuYD1wjlRGmSYLcCKoRUtQFM/6E99Iy2NoF/EkLD0CXtV0KE
         ex7huIWozcej0UGX3k5aHlykvTuK362UjqlASBYj0YUtbv2NeNNN/iPc/aj4sODe0AI7
         oT4dlGEBfP8cvU9B5ekf8D7rNuh0tG3QbGmXgKSUd/UMvVhqp5EdXkc1aL2EuonCX6qZ
         GXSMuG442+13mEBI8iNfKul+OalXL3y5/w4pgXXoUj1oPKN0lDZ7CmDVNQyF6/NpGHOO
         FhQw==
X-Gm-Message-State: AOAM531RI4tvn46XrAQg9aN/vSYcr/X+ED6xwP9KSNVQ0HlYzE0vQgQE
        SRiccpqQB3wvX63IX3sqb12m42AgV8U=
X-Google-Smtp-Source: ABdhPJz4dADr/6tr7cQGaBtlEp7PLgeEo4Ca+xmp6nSpRxKLIsbC8wH1/oh59FR+EwEyQ/tvm874pQ==
X-Received: by 2002:a65:558a:: with SMTP id j10mr634666pgs.404.1621272804648;
        Mon, 17 May 2021 10:33:24 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:47e:c24d:6c72:a52:2c8:7df1])
        by smtp.gmail.com with ESMTPSA id c12sm10358296pfr.154.2021.05.17.10.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 10:33:24 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: [PATCH v8 01/10] mfd: mt6360: Rearrange include file
Date:   Tue, 18 May 2021 01:33:05 +0800
Message-Id: <20210517173314.140912-2-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517173314.140912-1-gene.chen.richtek@gmail.com>
References: <20210517173314.140912-1-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Rearrange include file without sorting by alphabet.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mt6360-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index 480722acf706..de6cf8edff0c 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -5,14 +5,15 @@
  * Author: Gene Chen <gene_chen@richtek.com>
  */
 
+#include <linux/crc8.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mfd/core.h>
 #include <linux/module.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
 
 #include <linux/mfd/mt6360.h>
 
-- 
2.25.1

