Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E822C37871B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 13:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbhEJLNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 07:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbhEJKuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:50:25 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D03C061361
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 03:38:48 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h4so16049191wrt.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 03:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Prd7IRa+ZjrFAJ2l9tG9om0bmi1tNmgIcFpqkLdVso8=;
        b=NuhWo+54thqqc6supEKfQxC6/OlcJeHSBZV2wKNM8FXf1rp/G+p34TWHidArw4GZK7
         Qo/UGOk5atuqwWGVqARjwx6G3ZFQqw7c/SeJL3FR9C5lHrA124/ClYt3hNvMrXTHFsh7
         wqplJa90tPOPGEWwUMTCwyErLOYYigo4akoRNht5C1jSBTbowLBeMgITVQ9AVtAKesxO
         rOD+7dl+1nmOrCLZbqLBy4GD/agqRW1Zn5zIqYm/FUOiHx9QoVnafgZOFsZ31jWw6Kbq
         O27l1HXZ4B9H2Y38yInMxBYf9eQpCYHW9uwQ1M2OE7JK+RCQyt/CUTk2QW0l6vqNvJJS
         DuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Prd7IRa+ZjrFAJ2l9tG9om0bmi1tNmgIcFpqkLdVso8=;
        b=V3yxe7iWHu7nWot7PMwLw7Svt0FASJOPbzQ9dsVemIEpIN6yr0vOfjGPBpH7mMVF1o
         4Ge3EBvuRK5qCR2sJjAPH+lamj/jtHAlPYlQCVSe/BwCTKNCrTpc/rVjiGuE/AmCApx6
         5frq8MwEnQqBEVfBL64//3PnufIfZ1mNR4pjSBN/t854P8/Z37oGORzteWhREnC/efX9
         LLPBPk96bzSRqwDl77M/lkRPSMLvn3r5o4JlnmHENAslZjXlA6rk+msVT8eTufrsBPzV
         otP5h9BcVY/J4CSKQZ45KIdwkJ9oV90gCxIsrICQogQAEOEEPZyjcORt4G42CCJbUaoe
         0NJQ==
X-Gm-Message-State: AOAM530/i9ePcmPWgvDRFECCAdkYjKsGMlt1ZrumrykM5fEl1Ki97nUJ
        NY7Sp2pYisQnAB4Hx5DG4j5v0s1MWJVLjX8h
X-Google-Smtp-Source: ABdhPJwa6IkT8s5sItmkcKt+12m+tAbUxpwWn0JQHjuk3Z7CgKM3vnSR2vC1+VQFJherkPDIUIMrlw==
X-Received: by 2002:adf:eec4:: with SMTP id a4mr30213979wrp.159.1620643127467;
        Mon, 10 May 2021 03:38:47 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id d127sm25055313wmd.14.2021.05.10.03.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 03:38:47 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: codecs: lpass-rx-macro: add missing MODULE_DEVICE_TABLE
Date:   Mon, 10 May 2021 11:38:44 +0100
Message-Id: <20210510103844.1532-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix module loading by adding missing MODULE_DEVICE_TABLE.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-rx-macro.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index b0ebfc8d180c..171ab7f519c0 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -3579,6 +3579,7 @@ static const struct of_device_id rx_macro_dt_match[] = {
 	{ .compatible = "qcom,sm8250-lpass-rx-macro" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, rx_macro_dt_match);
 
 static struct platform_driver rx_macro_driver = {
 	.driver = {
-- 
2.21.0

