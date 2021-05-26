Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78D2391874
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 15:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbhEZNDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 09:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbhEZNCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 09:02:42 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C31C061351
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:01:06 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m18so1071320wrv.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 06:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ynJxnpUACagJ1PRG8av2gZwk6Q/EIQ9VI4Cq/HwLkQ=;
        b=ssYLQUB5UqpTDXgRfJyhf7QESK8IsqWzk/9Xtmno5Z9IXAt0z9CnK0I0uKbGZImCPQ
         WGJYk4caiZtR4cpemwfokceEgKL8EUOOHGCM1AIdhWdJ7JsSlmOheI2bV6McMo/3Ilzv
         nCqLTQxWZ6CDHMiOXceCjXD26rriaWrQAdZW5RtyZPfFGCaSkMUv009h+rdhY04apvCv
         vyxr9dTYEEo3R4M9UwsTxySdqvWFiEjYkrV/orKQ9encuOW/1wiFAR8b3Oq3BFyoTzY7
         wSQDO6PsmWO2DZvHSLDnZyJxF9Ari56Hs62n0x+z24VdBOHWYnU+GAgsLCLM+BKb8edb
         KUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ynJxnpUACagJ1PRG8av2gZwk6Q/EIQ9VI4Cq/HwLkQ=;
        b=A7tptzX+mA0VLVp3OijBwkRyywNRGrxYGDJ2gE6XoSxOd0RK/1E/1OJju2IoVAk1eH
         ISmYeYuVZOK7AlRM5EM2NIyUHemlhKuNsChrljKEfGZKuIXisDLkhQ0pdFFcyzjF0i7F
         C+VgjamURaR3FFoRIXg7B/xRzG8U1a4x7fnfTzg9xkGLAs5F7CmkuJOUXYCJynEip90O
         UzTzzqcJp02Kj+NmWZadpKoYNiL3G5NgvuAbmlRf1790CRNe8MkteKBJp3Yg6RElzQM6
         ChXL4MEniFCaIXXvzFIsYmFHXcRviAE4xcocxZbiGVSi+LswqZ+XWvpWxjIPvdF6TDgJ
         oO+w==
X-Gm-Message-State: AOAM532eZjIGht8E0UNGLN4o8/Y/npsXKw2bgOXhpeFBU74paZzGdTkk
        S+Heu2R4w1XDvyrgKuHSKSRCwA==
X-Google-Smtp-Source: ABdhPJyF3TqysAgaRiv3QaQr06FQAN77YlyS9WNhVKxL6TmWnfq2kezblAecIcdfC9TJOvcKmfpGxw==
X-Received: by 2002:adf:ee86:: with SMTP id b6mr25972174wro.53.1622034065270;
        Wed, 26 May 2021 06:01:05 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id y14sm6430036wmj.37.2021.05.26.06.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 06:01:04 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
Subject: [PATCH 18/24] usb: gadget: udc: pxa27x_udc: Fix documentation for 'pxa27x_udc_start()'
Date:   Wed, 26 May 2021 14:00:31 +0100
Message-Id: <20210526130037.856068-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526130037.856068-1-lee.jones@linaro.org>
References: <20210526130037.856068-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/usb/gadget/udc/pxa27x_udc.c:1749: warning: expecting prototype for pxa27x_start(). Prototype was for pxa27x_udc_start() instead

Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-usb@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/gadget/udc/pxa27x_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/pxa27x_udc.c b/drivers/usb/gadget/udc/pxa27x_udc.c
index ce57961dfd2d6..b2759b04b8e94 100644
--- a/drivers/usb/gadget/udc/pxa27x_udc.c
+++ b/drivers/usb/gadget/udc/pxa27x_udc.c
@@ -1730,7 +1730,7 @@ static void udc_enable(struct pxa_udc *udc)
 }
 
 /**
- * pxa27x_start - Register gadget driver
+ * pxa27x_udc_start - Register gadget driver
  * @g: gadget
  * @driver: gadget driver
  *
-- 
2.31.1

