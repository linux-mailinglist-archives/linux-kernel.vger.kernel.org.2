Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62E04457EF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 18:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhKDRJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 13:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbhKDRJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 13:09:33 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95095C061205
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 10:06:55 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id c26-20020a9d615a000000b0055bf6efab46so935311otk.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 10:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AkqChPnPSN5fMwuIQ2K/rgJWrknzWBl6gBTKcahDpRA=;
        b=u+MUCDDyyPAhhA2xzCjx0U7d40hPHusdXM2+k05ohsbQVaetcv+aj534n8xMdgSdZa
         zEVlpRl9UXRwI0a3ZX13/j0yygzHkuGvp3JABsiNnb/l/Abeaj9oJaAEjKu/awJPhz25
         ULJhlNtJBkt3cVhUrs21pIq+7P+7qUvlT1f8WXRsaqIuYT7gQb0Nyj/RGD90N/KptRSD
         YaUyDEaRRAW2lnWrPyMwMiWmCmePxWqHjg8ZpoE44Gw6R1cY8IAIGdOuwWWdrbcsYt0K
         OZtFLojc6wPQt72R7y+9UM699sRTKupO/bSVtKRIMoJQ2rNBAUDzjfmTHOkcB9UhjSzL
         l7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AkqChPnPSN5fMwuIQ2K/rgJWrknzWBl6gBTKcahDpRA=;
        b=Mtyp/CnE3wOjHAGhdHseqbiAKG/Z6syTsOm5Xq9nGUbEG97jnUNX7bTxJyRHqgxLmK
         OC6aCIXcboyEMhyTsJdoMBsEk0BJv4XC+BmVsp/uCKuQtHsMiwt5rDphe0rpXMJE2/OY
         1gMbtkMe1RoeGJiVl07RLBusP1vuzeAzvmEATX4yyqWmaSMsE2BkOb4qm4oE1Wq1cXqT
         qOaao5/GUphEiLlKUMYZT/DO8UKuK8Rj99lBwyAZ+SiI6kcKwjHaDwKVKg5Ve0mWg/t9
         ISwjwO1CK1LBmax1ZI2iSVbOtjaPYdXotxvATB8kFi/3XDSDZdovwlgv+SrcwiHmM23i
         Q/Rw==
X-Gm-Message-State: AOAM533BgU64y9kIa9mFSKlVWRCbnc7gqvqD3onDbR5XiJdLkuEBbm1S
        725+D9kmBxCxAZCdDxhGEktH4En57v0ePg==
X-Google-Smtp-Source: ABdhPJy2G1slU/3u+UxEp6iHtKcBf1aqOUliNI2njqNy0wmtt6CE3nYN4USY+5XbX4ClQ7gJFYPsBw==
X-Received: by 2002:a05:6830:448e:: with SMTP id r14mr27861890otv.171.1636045614922;
        Thu, 04 Nov 2021 10:06:54 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q5sm1490236otc.79.2021.11.04.10.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 10:06:54 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     vladimir.zapolskiy@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: qcom: sm8350: Correct UFS and SDC offsets
Date:   Thu,  4 Nov 2021 10:08:35 -0700
Message-Id: <20211104170835.1993686-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The downstream TLMM binding covers a group of TLMM-related hardware
blocks, but the upstream binding only captures the particular block
related to controlling the TLMM pins from an OS. In the translation of
the driver from downstream, the offset of 0x100000 was lost for the UFS
and SDC pingroups.

Fixes: d5d348a3271f ("pinctrl: qcom: Add SM8350 pinctrl driver")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-sm8350.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-sm8350.c b/drivers/pinctrl/qcom/pinctrl-sm8350.c
index 4d8f8636c2b3..1c042d39380c 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm8350.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm8350.c
@@ -1597,10 +1597,10 @@ static const struct msm_pingroup sm8350_groups[] = {
 	[200] = PINGROUP(200, qdss_gpio, _, _, _, _, _, _, _, _),
 	[201] = PINGROUP(201, _, _, _, _, _, _, _, _, _),
 	[202] = PINGROUP(202, _, _, _, _, _, _, _, _, _),
-	[203] = UFS_RESET(ufs_reset, 0x1d8000),
-	[204] = SDC_PINGROUP(sdc2_clk, 0x1cf000, 14, 6),
-	[205] = SDC_PINGROUP(sdc2_cmd, 0x1cf000, 11, 3),
-	[206] = SDC_PINGROUP(sdc2_data, 0x1cf000, 9, 0),
+	[203] = UFS_RESET(ufs_reset, 0xd8000),
+	[204] = SDC_PINGROUP(sdc2_clk, 0xcf000, 14, 6),
+	[205] = SDC_PINGROUP(sdc2_cmd, 0xcf000, 11, 3),
+	[206] = SDC_PINGROUP(sdc2_data, 0xcf000, 9, 0),
 };
 
 static const struct msm_gpio_wakeirq_map sm8350_pdc_map[] = {
-- 
2.33.1

