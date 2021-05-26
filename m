Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4167B391862
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 15:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbhEZNDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 09:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234864AbhEZNC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 09:02:29 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECDEC061345
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:00:57 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id f20-20020a05600c4e94b0290181f6edda88so459125wmq.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8thE6pWPMC1cZ/BkZSyAo0Kom76zxaAdnKK0vRxVopk=;
        b=l3+9+sArtJ/npKGd6maCVLyj/91WVG4+XgCQZ8lCsVfxqN9PiIf9xxGjew1wVJcAXP
         hwN2AFlt19+wj5Dmb41WkHz7uADqmujPGU4DpgFyUIVe9DwGKRTlLvHyUmkwKtRS4O08
         9QM6pD7kpebhn4Cr6ERpZVh3Hwt2ZtnPgMHWRC5db05UNXZMFxN6fCzBN6M0zXtRagpS
         ihmPe35VaENaN/ZgKdftqp+Sy62B+Tbo/Bx7cVjq96NxJnrhID0Zjp3uqmoyNq4yYyyz
         pXMF70sWENPREoD3EpPBxrbmHiiRMKq7C3uo9Nmc/OgYsJYmWXI1roKwwOuFvfPTaCnK
         SyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8thE6pWPMC1cZ/BkZSyAo0Kom76zxaAdnKK0vRxVopk=;
        b=NaIB6flhyjF3byFzW9siRd93hkncUg75bG3YNSOXawjaZacgpBPUWVXab4dXjiacpx
         gSbqzOZyTfRJAZAofS3cbniON7uus46nRLvr9gyRJ6OI773lIyOl1OGy82A56BFExbxo
         O+IYJTFRNqb7qyJpEZn8ihvvAcGeWivG0Xwpe5OXkzDiQk0KgLsEbESqJ22pMp8Zc71h
         YjfV8PwNQJJWrrCne+WPv5jhNXlrDpajjGe+on+tyqF9F0SRhIJSJgbGw4zatTvI17Zf
         vxyNgQdex9pIS/dOheZopKurx51Lp3zc6dYZ/UqJeHQyUTcYOyv2aP/zV8S9pjz45xhE
         vsHg==
X-Gm-Message-State: AOAM531cx2BXYETmwbiFuqIH4HOULegXUHrooRL5p+ablKCQg8zb+fJq
        AjVaEbN1gAe2m1yyq45xiQPY4A==
X-Google-Smtp-Source: ABdhPJzDQZva0sgjfdrbMXbrSAL33f5tBEZSMmlg1aDjhxxk7JL2scIVT78zduvBUEtv/4DFX/ZUxQ==
X-Received: by 2002:a7b:cf09:: with SMTP id l9mr29419759wmg.184.1622034055675;
        Wed, 26 May 2021 06:00:55 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id y14sm6430036wmj.37.2021.05.26.06.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 06:00:55 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pawel Jez <pjez@cadence.com>, linux-usb@vger.kernel.org
Subject: [PATCH 09/24] usb: cdns3: cdns3-ep0: Fix a few kernel-doc formatting issues
Date:   Wed, 26 May 2021 14:00:22 +0100
Message-Id: <20210526130037.856068-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526130037.856068-1-lee.jones@linaro.org>
References: <20210526130037.856068-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/usb/cdns3/cdns3-ep0.c:680: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/usb/cdns3/cdns3-ep0.c:775: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 drivers/usb/cdns3/cdns3-ep0.c:868: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Cc: Peter Chen <peter.chen@kernel.org>
Cc: Pawel Laszczak <pawell@cadence.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Aswath Govindraju <a-govindraju@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pawel Jez <pjez@cadence.com>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/cdns3/cdns3-ep0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-ep0.c b/drivers/usb/cdns3/cdns3-ep0.c
index 9a17802275d51..02ec7ab4bb489 100644
--- a/drivers/usb/cdns3/cdns3-ep0.c
+++ b/drivers/usb/cdns3/cdns3-ep0.c
@@ -677,7 +677,7 @@ static int cdns3_gadget_ep0_set_halt(struct usb_ep *ep, int value)
 }
 
 /**
- * cdns3_gadget_ep0_queue Transfer data on endpoint zero
+ * cdns3_gadget_ep0_queue - Transfer data on endpoint zero
  * @ep: pointer to endpoint zero object
  * @request: pointer to request object
  * @gfp_flags: gfp flags
@@ -772,7 +772,7 @@ static int cdns3_gadget_ep0_queue(struct usb_ep *ep,
 }
 
 /**
- * cdns3_gadget_ep_set_wedge Set wedge on selected endpoint
+ * cdns3_gadget_ep_set_wedge - Set wedge on selected endpoint
  * @ep: endpoint object
  *
  * Returns 0
@@ -865,7 +865,7 @@ void cdns3_ep0_config(struct cdns3_device *priv_dev)
 }
 
 /**
- * cdns3_init_ep0 Initializes software endpoint 0 of gadget
+ * cdns3_init_ep0 - Initializes software endpoint 0 of gadget
  * @priv_dev: extended gadget object
  * @priv_ep: extended endpoint object
  *
-- 
2.31.1

