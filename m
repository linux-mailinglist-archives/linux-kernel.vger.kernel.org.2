Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DDC340739
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 14:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhCRNwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 09:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhCRNvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:51:49 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9332C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 06:51:49 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id u10so4910971ilb.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 06:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N1vkQNGymFwLks9UB15v9pfiGh7bDRvcY3otglQibLg=;
        b=oJr3ErB8nC70YVt1rjZq5Mqw4v//cj+aIJtDLSw/SNR4nrqEVZfz+I4NZ+Y8helJas
         TwdDohMwi3O2Cptvx1vx1yWAjnNi0g//Mrvs+QadukrzOv9uV9zrsWSbbMwGRJf0S1AG
         ZNz9TRYUQNzNcLfl6Lv4ZAsnVQVa2NcukTO3Bv8+Ebp3aeZnYEZuAKyxNnuDxwlhjr0B
         OeWXNFHEGD3uV+9i53PfmHf9l7cxDx2O/BoIO954l5yAIgLBzQfd77GLFCRHvvZQDRvU
         fZ3OqtwRp0bH6zKsKgqcOavoMe8XT9tz5EDIPdWR+Tlt72jcr0i1CX+wwDNIstA3JpIv
         LB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N1vkQNGymFwLks9UB15v9pfiGh7bDRvcY3otglQibLg=;
        b=EFjaXIgLzaO5XO91vst/Fw/Gc3g/FSaAHjGXGjXia+FgtYs+xcCac0BwydreiTDEYD
         Bwws5JYD45jFE7vdifx7V8ghyv0G44E0rN+opBrNE9fZxF/scwV1nhHPKm2Lqmqf/92G
         WSDGJYlku19uzUKRJ7uqG31Ebshe84ku727tKvbesFoUsDUDyr6PRRP0syQzA+dpPg06
         2UlZtCYJ7+xfKfYTROqUSe5pkSdWKD25EBQB7bh94ir4W3RV68OZAVtfktxBj0TMJ/SP
         n9H7gvJR6GIcOdkeRHXxYMD0jBJiPI0XsyT19MVYYieAIBIiC/ZabllEd4tcVUTLg88Y
         FJvw==
X-Gm-Message-State: AOAM533AG9dKeCm7fe1gdqYnx45s6Jzu+kDZR0S1DFa0zNbUH0Ub/qF0
        sN3eoSPOiTfJhKKUbN2YM57M0A==
X-Google-Smtp-Source: ABdhPJw/v5KSdXwmj4gFVffI/BwXbLUBFn3CmIwAOMMAtKRhEpG6aBVfJVcHVl8PCd5pCmeZFLtJ4w==
X-Received: by 2002:a92:7d11:: with SMTP id y17mr11403584ilc.93.1616075508858;
        Thu, 18 Mar 2021 06:51:48 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id j20sm1139377ilo.78.2021.03.18.06.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 06:51:48 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     f.fainelli@gmail.com, bjorn.andersson@linaro.org,
        evgreen@chromium.org, cpratapa@codeaurora.org,
        subashab@codeaurora.org, elder@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 4/4] net: ipa: relax 64-bit build requirement
Date:   Thu, 18 Mar 2021 08:51:41 -0500
Message-Id: <20210318135141.583977-5-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318135141.583977-1-elder@linaro.org>
References: <20210318135141.583977-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently assume the IPA driver is built only for a 64 bit kernel.

When this constraint was put in place it eliminated some do_div()
calls, replacing them with the "/" and "%" operators.  We now only
use these operations on u32 and size_t objects.  In a 32-bit kernel
build, size_t will be 32 bits wide, so there remains no reason to
use do_div() for divide and modulo.

A few recent commits also fix some code that assumes that DMA
addresses are 64 bits wide.

With that, we can get rid of the 64-bit build requirement.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/Kconfig    |  2 +-
 drivers/net/ipa/ipa_main.c | 10 ++++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ipa/Kconfig b/drivers/net/ipa/Kconfig
index b68f1289b89ef..90a90262e0d07 100644
--- a/drivers/net/ipa/Kconfig
+++ b/drivers/net/ipa/Kconfig
@@ -1,6 +1,6 @@
 config QCOM_IPA
 	tristate "Qualcomm IPA support"
-	depends on 64BIT && NET && QCOM_SMEM
+	depends on NET && QCOM_SMEM
 	depends on ARCH_QCOM || COMPILE_TEST
 	depends on QCOM_RPROC_COMMON || (QCOM_RPROC_COMMON=n && COMPILE_TEST)
 	select QCOM_MDT_LOADER if ARCH_QCOM
diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 97c1b55405cbf..d354e3e65ec50 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -735,8 +735,14 @@ MODULE_DEVICE_TABLE(of, ipa_match);
 static void ipa_validate_build(void)
 {
 #ifdef IPA_VALIDATE
-	/* We assume we're working on 64-bit hardware */
-	BUILD_BUG_ON(!IS_ENABLED(CONFIG_64BIT));
+	/* At one time we assumed a 64-bit build, allowing some do_div()
+	 * calls to be replaced by simple division or modulo operations.
+	 * We currently only perform divide and modulo operations on u32,
+	 * u16, or size_t objects, and of those only size_t has any chance
+	 * of being a 64-bit value.  (It should be guaranteed 32 bits wide
+	 * on a 32-bit build, but there is no harm in verifying that.)
+	 */
+	BUILD_BUG_ON(!IS_ENABLED(CONFIG_64BIT) && sizeof(size_t) != 4);
 
 	/* Code assumes the EE ID for the AP is 0 (zeroed structure field) */
 	BUILD_BUG_ON(GSI_EE_AP != 0);
-- 
2.27.0

