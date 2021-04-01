Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957DC351210
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbhDAJXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbhDAJWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:22:17 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95805C061794
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:22:12 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id r12so1849376ejr.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3G3s/S8lRMB91e3/ict3UMMhMSDTheEUiSUyBvwqizs=;
        b=N/ajMhfMdO5Dqf7INeWxcn5JZV1txVtnS+0OKtDg4rfps5QzRuuHmxP0ETYwllMNYY
         WT0akmoTcXC4Tyt3/qzfqEJ0+J/L+1FPezk7vX2GuC7VyZByGNaLFwTqKckIIIhzCjv+
         mk8KHo0mbc0/bzU4Xr2XY0lJ8xtIpy8x6Z+E+6oKD6NxYD5pakYb/9QIrNEtBEHhSSo1
         uLRsH+/f4eH/CUSBv3y6nhzO25vPpGEt3+YYOmcnYwZ+ePWzFCT9uMDGIAtRcXGiiRz0
         PLQNin3WoC1jUYENvHpJWosDEixxycUdW5Sg8AEfKQbQDs7U5JhkZ+hnvg3yVEWORWpe
         qBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3G3s/S8lRMB91e3/ict3UMMhMSDTheEUiSUyBvwqizs=;
        b=blkc7CemxtIfCA4VDIzVk+TzU+RYMYq03FSLtvTA3KTegAE81skm4stcoXzLFXL6H4
         QvZzI2rWtG8A7b3baiCk/7RRCM4X+8chcXH2FeMWdj6tv0ElAj3ztImV2p82alWqA+nL
         LTnrugytQ0HMphg/W9XE2SzcdSlARlbhL5cjoniZoz0vQKSlkpBukShiX+qayXtmX8Cf
         XehZDDdC89cExLtsUo+W0wZcCZIk+DEdoLzLq9GLQNAlg1GgqJINEKt6605OU8t4GgIz
         QEyrNpn1xNNmoyF+31TzK3VPAcTRa61D1MfYSgnBnU4ULymH/lC9Rdzvd98Q15x0MXMT
         st/w==
X-Gm-Message-State: AOAM530ZS8QA0Ma/0d7Gs8BW+PxszEZw8LGiBiACZOetvixVvZ2iHfgz
        rjKCT2jOYLwMe+hAhaFyVT0=
X-Google-Smtp-Source: ABdhPJz7v5KLPe1jt96WFfq5zX8Hzw37lFfVgjMdf/vqFLp7jPGvTHSEsf5Jits17Qy5ulxqFhvjVw==
X-Received: by 2002:a17:907:75fc:: with SMTP id jz28mr8264546ejc.490.1617268931426;
        Thu, 01 Apr 2021 02:22:11 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id pg2sm2439810ejb.49.2021.04.01.02.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:22:11 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 29/49] staging: rtl8723bs: added driver prefix in log messages
Date:   Thu,  1 Apr 2021 11:20:59 +0200
Message-Id: <44684b22f5e90e730b64a574d3e6a3e433a2fc5d.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

added driver prefix in log messages in hal/rtl8723b_hal_init.c

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index df15b9c206f3..da9529054459 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -360,13 +360,14 @@ s32 rtl8723b_FirmwareDownload(struct adapter *padapter, bool  bUsedWoWLANFw)
 
 	rtStatus = request_firmware(&fw, fwfilepath, device);
 	if (rtStatus) {
-		pr_err("Request firmware failed with error 0x%x\n", rtStatus);
+		pr_err("%s Request firmware failed with error 0x%x\n",
+		       DRIVER_PREFIX, rtStatus);
 		rtStatus = _FAIL;
 		goto exit;
 	}
 
 	if (!fw) {
-		pr_err("Firmware %s not available\n", fwfilepath);
+		pr_err("%s Firmware %s not available\n", DRIVER_PREFIX, fwfilepath);
 		rtStatus = _FAIL;
 		goto exit;
 	}
-- 
2.20.1

