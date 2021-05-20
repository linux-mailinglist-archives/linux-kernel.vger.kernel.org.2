Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD9A38B690
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237499AbhETTC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236620AbhETTCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:02:39 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A182C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:01:17 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a4so18758805wrr.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lIVNEWSC2Jsb3xDrgcxFucT3yo9qXnMbQ7RXe/nUmB8=;
        b=sO0DBvtCCl2hnSdKrXaHKipuFZz41jcJw70JtL7AiHUAM17ZESebKeTO6+kZGQEmfz
         2XmzTuKV4hbiN2a+rnM8V8mAefJiQKxM03Q5KBNjCdboQPmQgBkvJop/ZtqjCGyWOvao
         YBChqvo+vZFYcwKHu+csr5GRAp2PjTWxLxaAK4I6Qk8X+bnB4hVpG9EahBJIbtP/0Zem
         h9pI/yZhLAXAhJG+gIJRATpsD2uEW/CPnSYA+EAf9b9+qenE+8s2xjTt9bOumAV2vkrV
         XRfkterbGrOaU/6vp4jaXFjcBe4jy6Ifb+tc6XWBNPpIuuJk+aREH+fvuwm+52KjVX1W
         IfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lIVNEWSC2Jsb3xDrgcxFucT3yo9qXnMbQ7RXe/nUmB8=;
        b=N1dHR2s5Mx5Lf0HgllbNZeAncDSIPm0gR2j7X+dmzGaLpTPEaI923bFgf+Ymj9dOTf
         /QZiHGNnpnkY4byYk7mNNATg224vrQkqch/1iWTWJSSPVzBbc/+VGI8oMjN70pg+5+RB
         h598PfTt2BKR2jr9+NhbRDZAuXCYcCu3+o/2Z7mLFbRYrhqEg7GWiHv8ZurgEMnDlIjr
         4QDWUBdo4x9LBl+shdkp1VC0OfvNMFazIzeVQUHNZA60twP/dVSYbF+zuQMCBMI960KE
         ADr7cS9h27MaB2+d2ygfPwHYnKmol1rcspygbMztfCc5xdNHjM1f1IXeSR4aqbvshfwe
         FDGA==
X-Gm-Message-State: AOAM530c7f6kf2ITpxRf6S4L+OJ+49AoqA6YM9FsLlQDk89gx72J5N0T
        z1+6WGxMHSFv+4p+UzGK8qkreA==
X-Google-Smtp-Source: ABdhPJypGARHHlnnWcESAq2q0d2d3ZQLgzaMUZ971o9hrcTcQbMotYZPZqXhhFE6odmq2CnoKBH5RQ==
X-Received: by 2002:adf:e589:: with SMTP id l9mr5898739wrm.361.1621537275970;
        Thu, 20 May 2021 12:01:15 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id p20sm9011899wmq.10.2021.05.20.12.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 12:01:15 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Subject: [PATCH 06/16] i2c: busses: i2c-cadence: Fix incorrectly documented 'enum cdns_i2c_slave_mode'
Date:   Thu, 20 May 2021 20:00:55 +0100
Message-Id: <20210520190105.3772683-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520190105.3772683-1-lee.jones@linaro.org>
References: <20210520190105.3772683-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/i2c/busses/i2c-cadence.c:157: warning: expecting prototype for enum cdns_i2c_slave_mode. Prototype was for enum cdns_i2c_slave_state instead

Cc: Michal Simek <michal.simek@xilinx.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-i2c@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/i2c/busses/i2c-cadence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index c1bbc4caeb5c9..66aafa7d11234 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -144,7 +144,7 @@ enum cdns_i2c_mode {
 };
 
 /**
- * enum cdns_i2c_slave_mode - Slave state when I2C is operating in slave mode
+ * enum cdns_i2c_slave_state - Slave state when I2C is operating in slave mode
  *
  * @CDNS_I2C_SLAVE_STATE_IDLE: I2C slave idle
  * @CDNS_I2C_SLAVE_STATE_SEND: I2C slave sending data to master
-- 
2.31.1

