Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E8839862F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbhFBKTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbhFBKTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:19:30 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C941C06138A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:17:41 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso1015991wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 03:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IaN8N4SwEQrPn+u2HQ3FO/LZbSLlVWFBVcnYwdv3wCs=;
        b=bSW6ZL+7zZa+QM2ud7nV1QPCqrO5jzc/kHE/vu13Io5qxhLSNzel/Xcaokg8btp8uh
         FL56n8T+a95Muw3fPonKg9Efx7uJ96x5sUt3BCFgs8FOYSA2igouWXZl28yPG214GWcH
         QoxHQcvisOjfyHtuaPt+ZZqFQbCpCq/RljymK1gfuxYqfESCyoY0KPfU98koEITUjn8S
         +Tk1wW+FQ78x5kLAfk+BHpIJgdRmcWDEr6Wvw2lDvQhah0xCbvKV5odlai/ZfGf64MVL
         DIIoBiqYFOEmABHJVEoDh1WG/lF+JavEJA7hgJlnwiEmx2EVHMgX0O/b2VBroxD92rGn
         OL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IaN8N4SwEQrPn+u2HQ3FO/LZbSLlVWFBVcnYwdv3wCs=;
        b=RaOJR1K8md7je82LEYbcPqft+PRDpxQbdeB/Xb9/Hwur9gZn9U0QRnm0DV6KHxi4je
         hi4Q6BYuK12cKC/ErfF8k8EL24r+q84yf8tmkeadyNp+dJsIFtcU8lhLpsYnniQaZGOm
         f/J1tf7qGyeXES0qgZWEWCz9mgA5e5sYgelAOo7LcnYKlrWv1rYx1JW+GNz0osKTAbn3
         BzXGz3zNnelmTFgxdr4AnIuaPVYaTVdAsbxUk+oJt1DFs5MD/m1krYZoMjlM2WMW0Rn8
         nYvoXOSvy+nOentt3ZCkf5nSmLkpwF/63OD8V8eCp4cfn1D3L7gTWaYQ3K5fmRbkpVGU
         jhkQ==
X-Gm-Message-State: AOAM532ffHIwTwU4FxaPP7ODPq2TZbXt4OMEOvusoxgYfT/2ND+PeUNp
        gC1Js2vOWTCw0QqN9EkLnVJ5kQ==
X-Google-Smtp-Source: ABdhPJxzD2xGXtYBHZW16DWMzaAyYT814nTJ/1+jt7r3sr74FSs387lxf3C8y47yqKxFz6W+MG9v5g==
X-Received: by 2002:a05:600c:255:: with SMTP id 21mr2635741wmj.46.1622629059678;
        Wed, 02 Jun 2021 03:17:39 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id q11sm1593265wmq.1.2021.06.02.03.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:17:39 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Andre Hedrick <andre@linux-ide.org>,
        Mark Lord <mlord@pobox.com>, linux-ide@vger.kernel.org
Subject: [PATCH 06/21] ide: cs5530: Fix incorrect documentation for function init_chipset_cs5530()
Date:   Wed,  2 Jun 2021 11:17:07 +0100
Message-Id: <20210602101722.2276638-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602101722.2276638-1-lee.jones@linaro.org>
References: <20210602101722.2276638-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/ide/cs5530.c:139: warning: expecting prototype for init_chipset_5530(). Prototype was for init_chipset_cs5530() instead

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andre Hedrick <andre@linux-ide.org>
Cc: Mark Lord <mlord@pobox.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ide/cs5530.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/cs5530.c b/drivers/ide/cs5530.c
index 5bb46e7130c8a..366be8c978a6e 100644
--- a/drivers/ide/cs5530.c
+++ b/drivers/ide/cs5530.c
@@ -129,7 +129,7 @@ static void cs5530_set_dma_mode(ide_hwif_t *hwif, ide_drive_t *drive)
 }
 
 /**
- *	init_chipset_5530	-	set up 5530 bridge
+ *	init_chipset_cs5530	-	set up 5530 bridge
  *	@dev: PCI device
  *
  *	Initialize the cs5530 bridge for reliable IDE DMA operation.
-- 
2.31.1

