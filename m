Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280D03C71CF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 16:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbhGMOHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 10:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236636AbhGMOHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 10:07:23 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F5FC0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 07:04:33 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d2so30695244wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 07:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vOIUcGl6OP33Jqy69oCSIbVfIJAMACUPuFSgBT/mZq0=;
        b=rzozn0NMI7/ypYCD3LqzYeKGRY4hQQps8JSy49mzE9Qu45D1JYakCSLOXvA0veTpPI
         iP361IVy26u6qRpPMMzeT9t2kOtyVd9EXDLbhx1m4uDxgLYojmav9itvEBCFx9SI1U7l
         dnnVYe/MQd5a0j9vG4l3YJQduuoFuSEYwS2wZij7UpyZSHU749g0CfOLRIxuWHqCQCHp
         dk4+ldbEacv0Ul2FrOu7alqH2Nhjav7lXqwjkB4qitGNbv0NgEBGmdwYe+XfgS+Yy2sq
         TH4zFeBzK72qRQpZg4UM463isHBWpCaQ3eIEGGoV11oFHzxVg1C1TPsdJ+jwp5dRCQqM
         iwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vOIUcGl6OP33Jqy69oCSIbVfIJAMACUPuFSgBT/mZq0=;
        b=lFmNOP/jXB6URzyohP5ouVtkLgaQAQReFoRMYFM17XwDjUizP++xo19Ne5Htb7+/wX
         5ITh6vqQcQ1XujOrEG5KcqZeHYX+0DIshdBoWJ0CT8wQfikQ31Noza1K7Pgrfq+xMBXe
         QfqZimxHV3qo8o9lL3+EVqRgtPheN21ucBTqKz0J+d39gfxR9jSG0R/IUHHm1RzfjBSQ
         Tsw5KtDFLBbsZ6fUIjiJIweiWScGLzALc5uz3LWJaMczBvqC2bYWZAASa/HsytSam1n4
         fwvNE/aGjWbVs9aIgQEG8VrdBlVzuT3NdHlXf6tOusBkW7n5jqP26TEG3OkilPXhkB/v
         65iA==
X-Gm-Message-State: AOAM530NwIbb9akEQ8vNhj5TxTRtBbyaZ68UYdEQWO2z9hXkS6dBKOIR
        CAqlVjOiO/d9trKLg+m/haZKdA==
X-Google-Smtp-Source: ABdhPJwFeZ1fRJKzzL9MhDH5tR7drpblpFSuiq6qqLeTrory6p0I+Rm77YJ2fJuituCtWlrzpA7NKw==
X-Received: by 2002:adf:ed4a:: with SMTP id u10mr5943502wro.330.1626185072316;
        Tue, 13 Jul 2021 07:04:32 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id x1sm2958240wmc.0.2021.07.13.07.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 07:04:31 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] ASoC: codecs: wcd938x: make sdw dependency explicit in Kconfig
Date:   Tue, 13 Jul 2021 15:04:17 +0100
Message-Id: <20210713140417.23693-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

currenlty wcd938x has only soundwire interface and depends on
symbols from wcd938x soundwire module, so make this dependency
explicit in Kconfig

Without this one of the randconfig endup setting
CONFIG_SND_SOC_WCD938X=y
CONFIG_SND_SOC_WCD938X_SDW=m
resulting in some undefined reference to wcd938x_sdw* symbols.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 045442228868 ("ASoC: codecs: wcd938x: add audio routing and Kconfig")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 2d80836ef220..f47d46eb76bc 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1557,6 +1557,7 @@ config SND_SOC_WCD934X
 	  Qualcomm SoCs like SDM845.
 
 config SND_SOC_WCD938X
+	depends on SND_SOC_WCD938X_SDW
 	tristate
 
 config SND_SOC_WCD938X_SDW
-- 
2.21.0

