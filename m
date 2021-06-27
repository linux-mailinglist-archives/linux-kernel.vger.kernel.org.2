Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882A23B5283
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 10:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhF0IHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 04:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhF0IGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 04:06:55 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8851C061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 01:04:30 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id i4so7087103plt.12
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 01:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U2lr/dVfkj0DRgesTOsb773D9hC9i1BnrhiVCvVHqAA=;
        b=A4LXQcqwf0203TFrhXOnyhqoFua/QrtKdm8Bz5+5dzWoGykHpoMP9+rWtsDDhQhwNN
         BIOpCcYa2ES2b7kO7uheWc77BoW00/5Ux6lBqFb9e8W4iWxKMKxUg5YYTd6o0ar2ua7j
         pLbVLfSg5UDt5JqS/ONgvSSdBrKz1+KZt9KWtouBNAMbVDuw57HcUOUOAEDth9IWDThz
         NvROGH8bPNr74FmFjCGUO6brul5BKBexkmfK8mRU560VfRQFBUMykZpUJgI+rZOnvfFm
         59a00r7L/Vyhd8qD+mePQ01t6wIx3Nf4supz6Sn8kN+SK7iP8wxD8vHDtKzca9JaNy/9
         rXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U2lr/dVfkj0DRgesTOsb773D9hC9i1BnrhiVCvVHqAA=;
        b=JL5l8uM4T7v8RNXSbO5Bk1XypQwNzkpJXqdasJJq2BgJHYZxfRKcZXRcn0yP8N2NOK
         tCHdbi68DUhJQbFJfwsjOkRKcwzDgqT9nx7kc/CKihOc05bSMAM1Au9UpvScJ/p/wt0U
         956LF3p0crMajuO84XSSzx4jdhFwVjSlY3lW3YWDkHXhK4Itp04hQhNXmGp4EV99uP/g
         d5v1tMcFUiRp+u4uyM/ruhiF8hMp865i+JmdQuJpZkrw4QiY0rH5e3Q/N55XWEhHu486
         D/j/GDvUXy0dIWxHT+31Gkjd2AqVDEr1aaYDxHUEdNZNuTBVIywDVGM2CTaSStLyj+Ol
         MBPQ==
X-Gm-Message-State: AOAM530wy4sFyKGTqmti8YOMY+fuSg0AmLk/Qj6wvz/+xjxvc3XTWEDg
        NkqcABQqEmtW71WFPDbC3WwwyQ==
X-Google-Smtp-Source: ABdhPJwmZd/9jaQC2a8sCiM2JfEjiV4Fb8A9f2VLepcaekw64F6rp+94buZ/jrABmK1lBiYIkWqHMg==
X-Received: by 2002:a17:902:ea12:b029:128:977b:fa78 with SMTP id s18-20020a170902ea12b0290128977bfa78mr11006075plg.15.1624781069958;
        Sun, 27 Jun 2021 01:04:29 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id go16sm14297610pjb.42.2021.06.27.01.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 01:04:29 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     ChiYuan Huang <cy_huang@richtek.com>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: rt5033: Fix n_voltages settings for BUCK and LDO
Date:   Sun, 27 Jun 2021 16:04:18 +0800
Message-Id: <20210627080418.1718127-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For linear regulators, the n_voltages should be (max - min) / step + 1.

Buck voltage from 1v to 3V, per step 100mV, and vout mask is 0x1f.
If value is from 20 to 31, the voltage will all be fixed to 3V.
And LDO also, just vout range is different from 1.2v to 3v, step is the
same. If value is from 18 to 31, the voltage will also be fixed to 3v.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Reviewed-by: ChiYuan Huang <cy_huang@richtek.com>
---
ChiYuan helps to check the datasheet, so add his reviewed-by tag.
BTW, althought the changes is in mfd include file but the actually impact
is in regulator driver. So I add regulator prefix in the patch.

 include/linux/mfd/rt5033-private.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/rt5033-private.h b/include/linux/mfd/rt5033-private.h
index 2d1895c3efbf..40a0c2dfb80f 100644
--- a/include/linux/mfd/rt5033-private.h
+++ b/include/linux/mfd/rt5033-private.h
@@ -200,13 +200,13 @@ enum rt5033_reg {
 #define RT5033_REGULATOR_BUCK_VOLTAGE_MIN		1000000U
 #define RT5033_REGULATOR_BUCK_VOLTAGE_MAX		3000000U
 #define RT5033_REGULATOR_BUCK_VOLTAGE_STEP		100000U
-#define RT5033_REGULATOR_BUCK_VOLTAGE_STEP_NUM		32
+#define RT5033_REGULATOR_BUCK_VOLTAGE_STEP_NUM		21
 
 /* RT5033 regulator LDO output voltage uV */
 #define RT5033_REGULATOR_LDO_VOLTAGE_MIN		1200000U
 #define RT5033_REGULATOR_LDO_VOLTAGE_MAX		3000000U
 #define RT5033_REGULATOR_LDO_VOLTAGE_STEP		100000U
-#define RT5033_REGULATOR_LDO_VOLTAGE_STEP_NUM		32
+#define RT5033_REGULATOR_LDO_VOLTAGE_STEP_NUM		19
 
 /* RT5033 regulator SAFE LDO output voltage uV */
 #define RT5033_REGULATOR_SAFE_LDO_VOLTAGE		4900000U
-- 
2.25.1

