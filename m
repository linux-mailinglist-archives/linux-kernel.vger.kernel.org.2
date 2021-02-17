Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67DE31DCD0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 16:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbhBQP6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 10:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbhBQP6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:58:05 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE677C061788
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 07:57:24 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id b3so17926713wrj.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 07:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ne17C46QzQZFeljqEWsecuHVsH/K8AauDxB5827FAeY=;
        b=iQPLYOmydw1PH/A5gfWMlOAfsJqWC3/mmfvJCZhFnKLl8/Au/uyLdq8BFrzfAe/Lmw
         scZPOGxm2bihkDU+yz+6m0GAZ+hUjIV67+i2jv63FSbQCphPq3msHgN0YTMvgmWc++hC
         IGCFLlLyD/bA+/IzTIk0AKz1p55Db8VeAFZgu3KquqU45wc5lUGmkyi6rXK+sXfLZGtY
         WJ2DFqsJUrNYzfn6mj3wHproLdRD+lsymRfwX/1SFCyscndEy6ASmYQLPRulzNm2ryfG
         FH9TVkaVcmE/rqP8u6FobVfWQ6ARos22TDIxajV5JW2PPwk/zPDVMTtS71OGyazuwfls
         qmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ne17C46QzQZFeljqEWsecuHVsH/K8AauDxB5827FAeY=;
        b=Z38hR5cINFVWlWUmUllTjDC7No9Ot7fZPeS3pCDSciDCxp/C1B5d9y61B67uF/0/jj
         5ffQrJo86YTo9dNIePC45hmylBLlgbnrBRaOk205/RXQg57Qqkds8h61PVNEUKPJzrOZ
         L8wb+dIkK0oCCv/DYZqfUFPPmJwuRhz2aXXTliGjQkZYVkXYEIzZKqcpsAR0F7FLb5OG
         KWVUDrhWDqhIDai8lhbNLnEi0t7SM2iLftFNSzFbPIL3Kg285k1FbndEx5WzMS9vq/2k
         yLIdAnAECWPKK85jc3UK3hcAOEY4/6PFFlTObL65HJLRHfxqyaHfqfJshFxYmyQkmwO8
         tZZA==
X-Gm-Message-State: AOAM531lpDYCYHJr/SKEaYxTTKMWGut5GMYowjYDd8Qnz+kXfkUAT/Cu
        087nNmdgpVZE+K+ZH1aRQDaaIVGBEkxa/A==
X-Google-Smtp-Source: ABdhPJxc/r4sZ8OMTtAbGHIDcOgMGMOUeowWmCJfZkXSRGTSYcwILM651vV+CEagy9Az9gy2pqnenA==
X-Received: by 2002:a5d:6687:: with SMTP id l7mr13562769wru.187.1613577443521;
        Wed, 17 Feb 2021 07:57:23 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id b2sm4860480wrn.2.2021.02.17.07.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 07:57:23 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bryan.odonoghue@linaro.org, dikshita@qti.qualcomm.com,
        jonathan@marek.ca, stanimir.varbanov@linaro.org
Subject: [PATCH 1/1] arm64: defconfig: Enable SM8250 video clock controller
Date:   Wed, 17 Feb 2021 15:58:42 +0000
Message-Id: <20210217155842.1715999-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210217155842.1715999-1-bryan.odonoghue@linaro.org>
References: <20210217155842.1715999-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the building of the sm8250 video clock controller by default.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d612f633b771..292f1edd78e6 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -960,6 +960,7 @@ CONFIG_SM_GCC_8250=y
 CONFIG_SM_GPUCC_8150=y
 CONFIG_SM_GPUCC_8250=y
 CONFIG_SM_DISPCC_8250=y
+CONFIG_SM_VIDEOCC_8250=y
 CONFIG_QCOM_HFPLL=y
 CONFIG_CLK_GFM_LPASS_SM8250=m
 CONFIG_HWSPINLOCK=y
-- 
2.29.2

