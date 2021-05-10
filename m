Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968D0377F2B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhEJJOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhEJJOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:14:16 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560E5C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 02:13:12 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t18so15792460wry.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 02:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2p3Sj2BkzdaMJsqcUQ08/NFSQSUt4nJXy9Ws6vh2r0s=;
        b=rRR6r5eDRXVzXoT/7EFS1eZBDj9JdoW9087XwJukMzISm9THlixZqPCE3SPNshFHaN
         zj54T2zZC2RpdSfunrq/eeHciH3S2ywXCHaNpN8zquP5iuuSpuZ3fb9Gn/glg+1Zp/z3
         rksTUZZHDaxQAZcKSQEl1WXKNLCDvS1KQ/S5R8798gLFVkv6UK4ymJuDvDZmdVJPo4rC
         zRZ6oOMhcgIT+HcKs4JosSdwweoLmu8i2tcXa8bRN6e+4iuydFQHoTvtSQ+FMXx75ceV
         vx6ryye1O1TgspURIwR/H3V8/IwYmCfMcHgTzPfTq3vv4hPY161+tL3MI/yE4VR2aoo4
         5OQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2p3Sj2BkzdaMJsqcUQ08/NFSQSUt4nJXy9Ws6vh2r0s=;
        b=VWFXt+hlj30Mn2KKATeNi38yoRb5H2mW+VMuYTROIXECwevhIFM7i0VC4STPMHPjG4
         HN+oBr9tunYteLL9GoYoWz0JD5Rj0/Q3NksDhONy446wKnQ4tB/pNsuGxg8A4yVxc+bH
         FD+DXkK6kXTpNHwDdh/jkv0E/VLAgnMLghcPwPBzbNGsgTC70NPhN5QGdIY6YMpRvUvF
         +sVstdsyGFKQl2oY6NTKdeTeJJFhw9sDeRrZbeF89Vq3DeaW8mnrFc4dvAdGQq6OydJ6
         C14yh5UKCHbb8e8NI7vHboDwlbZQb9MYP84Pt49k4DOpJPzvkhOQxRLXaZ6J8YKYWzCN
         wBRA==
X-Gm-Message-State: AOAM532q8rC8irKez8eYOrXpiSb8b3oIpJyvPNPiPqp9e67Cq+Ei1tms
        lpNUi1QBtcfmEk3Suqp7e400Htuqe8o7QklO
X-Google-Smtp-Source: ABdhPJzH2NzW12N3YI4X71yzlA6PknqwfMKM+/0EaS90DHOLFGGhWehylx6FHOVwRzknimcRhZJGUA==
X-Received: by 2002:a5d:6e04:: with SMTP id h4mr28965063wrz.256.1620637991115;
        Mon, 10 May 2021 02:13:11 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id s5sm19040575wmh.37.2021.05.10.02.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 02:13:10 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/2] mfd: wcd934x: add additional interrupts required for MBHC support
Date:   Mon, 10 May 2021 10:12:39 +0100
Message-Id: <20210510091239.2442-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210510091239.2442-1-srinivas.kandagatla@linaro.org>
References: <20210510091239.2442-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WCD934x supports Multi Button Headset control which enable headset detection
along with headset button detection.

This patch adds interrupts required for MBHC functionality.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/mfd/wcd934x.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mfd/wcd934x.c b/drivers/mfd/wcd934x.c
index 53d46fadcf5a..aa19a6a4fdbf 100644
--- a/drivers/mfd/wcd934x.c
+++ b/drivers/mfd/wcd934x.c
@@ -46,6 +46,13 @@ static const struct mfd_cell wcd934x_devices[] = {
 
 static const struct regmap_irq wcd934x_irqs[] = {
 	WCD934X_REGMAP_IRQ_REG(WCD934X_IRQ_SLIMBUS, 0, BIT(0)),
+	WCD934X_REGMAP_IRQ_REG(WCD934X_IRQ_HPH_PA_OCPL_FAULT, 0, BIT(2)),
+	WCD934X_REGMAP_IRQ_REG(WCD934X_IRQ_HPH_PA_OCPR_FAULT, 0, BIT(3)),
+	WCD934X_REGMAP_IRQ_REG(WCD934X_IRQ_MBHC_SW_DET, 1, BIT(0)),
+	WCD934X_REGMAP_IRQ_REG(WCD934X_IRQ_MBHC_ELECT_INS_REM_DET, 1, BIT(1)),
+	WCD934X_REGMAP_IRQ_REG(WCD934X_IRQ_MBHC_BUTTON_PRESS_DET, 1, BIT(2)),
+	WCD934X_REGMAP_IRQ_REG(WCD934X_IRQ_MBHC_BUTTON_RELEASE_DET, 1, BIT(3)),
+	WCD934X_REGMAP_IRQ_REG(WCD934X_IRQ_MBHC_ELECT_INS_REM_LEG_DET, 1, BIT(4)),
 	WCD934X_REGMAP_IRQ_REG(WCD934X_IRQ_SOUNDWIRE, 2, BIT(4)),
 };
 
-- 
2.21.0

