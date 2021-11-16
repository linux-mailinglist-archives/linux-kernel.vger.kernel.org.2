Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90486453128
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 12:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbhKPLtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 06:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbhKPLtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:49:35 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2061C061746
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:46:38 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso1690699wmr.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d1giUkCfPq6BR7uk0WV+6luLzyXkW70izeBPdkRQixI=;
        b=Xl+s/Y+c6nx9/ssKwbB11JGD0OU2RJVsDDn63pKqMVpiNeTHVx6K9hiW8FIVHP+bED
         ITKubhlPT6+5nxng0+XsDdWfi6wMF/ZesmW9XJSiwV+/3TnK4/MMbm3h0Zpgh5vvSdRp
         I7UOBnwfqlPb+l9BbNgAvqF39e+0aUOA+mx0WADkeNj7nkaXmZ+rQm9ojBaA4uCMqhn3
         qT8cAWndIAnRwwawgi8BTXl9DVk2aqQ4glDG1AcUExeOcqm8VSWIeWFJwqoFhIOuR3H+
         Snc4FvKNc+iBDSYTmOR39Zjb7sXBvE25N44egbMmsM007cB763IJw27M/zj/T3ZVX1Gg
         UmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d1giUkCfPq6BR7uk0WV+6luLzyXkW70izeBPdkRQixI=;
        b=gLUxSTfjE5saX78n7imHu7r+qWS+uF/e9dX4V8vaBHEyJdoO8rxzC1VBLugEkimFt1
         RRkkVxSklxNy7PH6L4Bd2TVTvevvjBB3gG6c469W2Vm9b5pD80YMbKNTuB7hP12DQ1Zw
         xN28eNRCcB17A+TwjJYvRLDVjvUXKGJX69eny8QBAtH/AECumeRpodFaZ/VswfnS9/ZH
         Xra7mryGaM6JT+1Iw43hS3JKxc0R5qVJ3dhShmqjYEuy4YTE25p4NjCUdQQX9oqyubD4
         yLbdAxi7x9naLpjNXPli15EuMFP02ZVxnWXCe+lrtbcRi6ZRHmpY3RgWeMl/WB3aKdqW
         eKqQ==
X-Gm-Message-State: AOAM5321+JLwdV3Jgoa7psJUd9zMnKCAR7xboHGBn0LIGsv/Melq2qKh
        TZ+8aeVS7tCOGyqiJ01TOvjxGw==
X-Google-Smtp-Source: ABdhPJxaw+wUnniAUrUtV7PikZ66OiA9SnbGXVSJR1Yh/NAhlhXK+STZmfyX2180s1YmVLDGNmCg0g==
X-Received: by 2002:a05:600c:3b8f:: with SMTP id n15mr68986799wms.180.1637063197566;
        Tue, 16 Nov 2021 03:46:37 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id z11sm16934698wrt.58.2021.11.16.03.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 03:46:36 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/3] ASoC: codecs: wcd938x: fix volatile register range
Date:   Tue, 16 Nov 2021 11:46:21 +0000
Message-Id: <20211116114623.11891-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211116114623.11891-1-srinivas.kandagatla@linaro.org>
References: <20211116114623.11891-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interrupt Clear registers WCD938X_INTR_CLEAR_0 -  WCD938X_INTR_CLEAR_2
are not marked as volatile. This has resulted in a missing interrupt bug
while performing runtime pm. regcache_sync() during runtime pm resume path
will write to Interrupt clear registers with previous values which basically
clears the pending interrupt and actual interrupt handler never sees this
interrupt.

This issue is more visible with headset plug-in plug-out case compared to
headset button.

Fix this by adding the Interrupt clear registers to volatile range

Fixes: 8d78602aa87a ("ASoC: codecs: wcd938x: add basic driver")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd938x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 52de7d14b139..67151c7770c6 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -1174,6 +1174,9 @@ static bool wcd938x_readonly_register(struct device *dev, unsigned int reg)
 	case WCD938X_DIGITAL_INTR_STATUS_0:
 	case WCD938X_DIGITAL_INTR_STATUS_1:
 	case WCD938X_DIGITAL_INTR_STATUS_2:
+	case WCD938X_DIGITAL_INTR_CLEAR_0:
+	case WCD938X_DIGITAL_INTR_CLEAR_1:
+	case WCD938X_DIGITAL_INTR_CLEAR_2:
 	case WCD938X_DIGITAL_SWR_HM_TEST_0:
 	case WCD938X_DIGITAL_SWR_HM_TEST_1:
 	case WCD938X_DIGITAL_EFUSE_T_DATA_0:
-- 
2.21.0

