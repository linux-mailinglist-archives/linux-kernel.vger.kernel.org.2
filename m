Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B94391211
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbhEZIMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbhEZIM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:12:28 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E8BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:10:57 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id q5so95686wrs.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bDSnzMMUsSCO/Ot3eHEEcypeAaPDKCbTf+CZBsVWvXk=;
        b=Oj271lYyyEcFHqCvK/PvbCsiJwjzledPoePmF++Gj2MdibSjRlyL4mVcS0zoEEh8w4
         AgX7qDMZFrTXK1A2aiygbzZ/gfxbLec5+EvClM5kcgdej1zLpAgCCVLmsa/lutNEr9WQ
         VjZD+EZo9lycVNfyLuPe2ajCPay0mlgpMj/JwnumvyJNVYiNQiU49WaT8R70lrHQ1qpz
         Nb3nT9jF/9X8iH8zJ+Qwi4dhxv7A/EDm1/PQprnOl+88mBQe88Cfryu6eXs1UHX2ysDZ
         jXPpTa+CCwwqE1IeUJipVrd7Y1KW+AiMOuAzHr8JPnHQIGJbL6uWMoo6eyHW1/TlFF5G
         8Lew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bDSnzMMUsSCO/Ot3eHEEcypeAaPDKCbTf+CZBsVWvXk=;
        b=tr2csOHF4RfwNjJP3V3+POHShl7E3ulc+B3iznEvUb78SB7rdlp6sU8Wdc/sq3H9cT
         tOJC5ayMl4fU+ROMivnS09mQ+8hcT1wk+Mt89vP459ZTe47YNN0KWcbBPEH4D4LaxNKK
         INb8udTwnXtIsrHtn8jU63CqNqMv+EWb0gFgeAe1GoGdbBqP5dwFKAl6Xim1+AD4HKJS
         F8kT8qSiCLUHujLwvNB6oq/7aPZX7bWOQCSM1i10o6fwturBUG1HsMk7LYmwEaURhht/
         MdQB6TJVx1UEccWw5i4z9+7VLPSQwP6Fb9qSf2A3v8SDWZoCbZXX1b35cEV4zAiqS5+Q
         4wTg==
X-Gm-Message-State: AOAM5325ftoN24YS5ss0ai+LKUmZwh1r35uUTKpYBMKmYfQjT4ek//Ku
        G71vvGUr557IfPNSg9MPojdZIg==
X-Google-Smtp-Source: ABdhPJz3yjlyraF6S44Uj2mEX7ZsHUcNNRdDjrQ+Ni9JmuBFPxwkNhg9uI7hTz05bua7Af3GdTpjYw==
X-Received: by 2002:adf:de09:: with SMTP id b9mr31879815wrm.340.1622016655832;
        Wed, 26 May 2021 01:10:55 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id v11sm22628319wrs.9.2021.05.26.01.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:10:55 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 10/10] bus: fsl-mc: mc-io: Correct misdocumentation of 'dpmcp_dev' param
Date:   Wed, 26 May 2021 09:10:38 +0100
Message-Id: <20210526081038.544942-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526081038.544942-1-lee.jones@linaro.org>
References: <20210526081038.544942-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/bus/fsl-mc/mc-io.c:70: warning: Function parameter or member 'dpmcp_dev' not described in 'fsl_create_mc_io'

Cc: Stuart Yoder <stuyoder@gmail.com>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/bus/fsl-mc/mc-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/mc-io.c b/drivers/bus/fsl-mc/mc-io.c
index 9af6b05b89d6f..95b10a6cf3073 100644
--- a/drivers/bus/fsl-mc/mc-io.c
+++ b/drivers/bus/fsl-mc/mc-io.c
@@ -55,7 +55,7 @@ static void fsl_mc_io_unset_dpmcp(struct fsl_mc_io *mc_io)
  * @dev: device to be associated with the MC I/O object
  * @mc_portal_phys_addr: physical address of the MC portal to use
  * @mc_portal_size: size in bytes of the MC portal
- * @dpmcp-dev: Pointer to the DPMCP object associated with this MC I/O
+ * @dpmcp_dev: Pointer to the DPMCP object associated with this MC I/O
  * object or NULL if none.
  * @flags: flags for the new MC I/O object
  * @new_mc_io: Area to return pointer to newly created MC I/O object
-- 
2.31.1

