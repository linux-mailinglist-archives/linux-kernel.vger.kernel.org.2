Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FFE39185B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 15:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbhEZNCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 09:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbhEZNCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 09:02:25 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44F1C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:00:52 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id b191so676544wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jB1Di/AfofpCu9RhowXJK+PZPPiB12GqSTdmHK1d9Gs=;
        b=XueaPXDzGT/uaui/1XGPYO40JEvM+f5xhaJSj0qWULREhRiPfOsWIJTIqeJu/+79LE
         /JvmnSQQ4nkjsvzcvpVFKjk6e/x/pp4f2tv6PDdK/8Q3gDx7Y0z9S02MqrMSC7qR4Zuu
         bfjvNHfdYI5g7Fi4s9Dq5JP6gL+I/cQaSWp+kKqlf7vuGcLcJ7GraAcPSfuNxSxKjAP+
         DJWPvvkZgdJyt8GmEZDBvQ8oNB8yR9NEv/e8MeC0ikxtnzEbVy4bd0mYWFTCxxJg9T4K
         aDDS8pvPrsJfP4ZEvrBRTqDge8IP95Cm2z2KLK3DUArmyFq5X+EcEr5DqmDn0Lj3hIPf
         YzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jB1Di/AfofpCu9RhowXJK+PZPPiB12GqSTdmHK1d9Gs=;
        b=G0E+dyMBxSyZKiB/KpaBDKY8N0SAbXZAf/jEmcm8gQCffiQ4jzhPPYG0hocbigag1n
         8JSEcdPyeskJlKgpwY/+1sblD+63WQAxWNicTsKFv64jJP1Z0exNfh8440s0mN5kLi7h
         mPInL/nQLL2+qlYSXUaYBV43bx9kIMF5eaZBMtJF5JIoU5mIIRLOJFNn6p2y3bKE8B35
         wxZpBWR0l8yuSzkx8l9tWK3aCIZhpQYNUdjhpvk5THH4syASMzYS9G7OPvQFrrLoGZkW
         CJAI4x/8S/u3+FEyC+BhD5CMYHzoDjxafrScIa9Dpkeej3KfO8MKg1i9+GsmVzKRdNmp
         347A==
X-Gm-Message-State: AOAM531hFoAvYlRwFv/XUZ48FqTXGiA2sn3cEbaMKHRSkLD1h/+jsu+u
        g2DCEMshEnLOsU7wIrEpzycp1g==
X-Google-Smtp-Source: ABdhPJxSOO9StGRuudmQN9i7ChF2W6rcnS4woOgbTYoScVCLCvoBk+w9nBv1Dqd1JhymAQ/M/CDreg==
X-Received: by 2002:a05:600c:3542:: with SMTP id i2mr26506996wmq.124.1622034051442;
        Wed, 26 May 2021 06:00:51 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id y14sm6430036wmj.37.2021.05.26.06.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 06:00:50 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 05/24] usb: dwc2: params: Fix naming of 'dwc2_get_hwparams()' in the docs
Date:   Wed, 26 May 2021 14:00:18 +0100
Message-Id: <20210526130037.856068-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526130037.856068-1-lee.jones@linaro.org>
References: <20210526130037.856068-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/usb/dwc2/params.c:787: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Cc: Minas Harutyunyan <hminas@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/dwc2/params.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 7a6089fa81e1d..67c5eb1402325 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -784,8 +784,8 @@ static void dwc2_get_dev_hwparams(struct dwc2_hsotg *hsotg)
 }
 
 /**
- * During device initialization, read various hardware configuration
- * registers and interpret the contents.
+ * dwc2_get_hwparams() - During device initialization, read various hardware
+ *                       configuration registers and interpret the contents.
  *
  * @hsotg: Programming view of the DWC_otg controller
  *
-- 
2.31.1

