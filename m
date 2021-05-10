Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4850378271
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhEJKfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbhEJKbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:31:50 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1656DC06137C
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 03:28:01 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id t193so428736pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 03:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=314DroehraaonWcTjTH0R5/hEXI7UJ2gguYdw49op1o=;
        b=QkKSXtPu66DwSuiRaGwTwnDXVUXBbM4aBSOXgHW4gDMFQUzhLHO2w/9XN4B75gucpN
         xHR6Ouz9hWBrxXwVcvabzYDmnZBb6GZGSNTDVo4mvM6GV6udoYKGIHUo3f7hLwNpMzPm
         w4fpHwKLg30OyBMkRdTQjy0WMuj2c9vSNRP6aW0oKzeSMjecnWvlc9/wjI2T+6dC0ffM
         83Zs2PgAbrTLCaeXAwAIFswefQNeqPo1adUA2nTdMS+6pIasKimyZlON4gDcSPVnEdf2
         hLBjMLavq7RWzOItWOGH0D/49sQOfrJL6wjRLpw2ac4AAYa2f/mMOrCA2TEbCIo46k8y
         trcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=314DroehraaonWcTjTH0R5/hEXI7UJ2gguYdw49op1o=;
        b=Ry+qbj0gYF1M24wYvWFnNsRhQvO3OFrk7YC0Nvl0NI/nudKU0cxj6SOMVBmURjsLEE
         8yYGFWTQ0q4XLyRjNZiLv6zjbaBn3lOEO8rHYPvzy4vyt0jZKnI5nF1oufctUq1Mvwu2
         WA2PXLl38lvSCX6FFpLvBM+KmEbnN/gIyKWfs1HYg7EYcylMP3UlEDKqx9vxep4DHQHY
         PW+CeyfIyu1qJ9P0tbviDSdQqrSIViMQIMZb/42UNrhYyl5lKVtrP1Oyaw8Eb+l2bGyh
         YpX2C3eH6y5Rx0XZ2SoZ6qAFIASDOOf1t8e0HVP4VrCpJXGD9e4cDD6Yuw8Np4iHjVpm
         dQGw==
X-Gm-Message-State: AOAM5314p0tva34auTJmhVNDeCo5tH68OV3oHBcl8y8unX057FdF3Ode
        qTzt3WTowNPvo+5PAjP74zGK60qZYKe2VA==
X-Google-Smtp-Source: ABdhPJzACrhB0UoKaRJsr7yGACXsuLoijXHum4Hz51YabYmIgSmzJT1Z7JEoJZYP4V8KaGeqFsS77w==
X-Received: by 2002:a05:6a00:2401:b029:28e:823b:fd53 with SMTP id z1-20020a056a002401b029028e823bfd53mr24326749pfh.71.1620642480636;
        Mon, 10 May 2021 03:28:00 -0700 (PDT)
Received: from masabert ([202.12.244.3])
        by smtp.gmail.com with ESMTPSA id q27sm10863759pfl.41.2021.05.10.03.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 03:28:00 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id 4D907236045C; Mon, 10 May 2021 19:27:57 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, dunlap@infradead.org,
        srinivas.kandagatla@linaro.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, bgoswami@codeaurora.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] ASoC:q6dsp:q6afe-dai: Fix a typo in module description
Date:   Mon, 10 May 2021 19:27:52 +0900
Message-Id: <20210510102752.40620-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a spelling typo in MODULE_DESCRIPTION
in q6afe-dai.c

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index b539af86e8f7..2166fc305c8f 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -1706,5 +1706,5 @@ static struct platform_driver q6afe_dai_platform_driver = {
 };
 module_platform_driver(q6afe_dai_platform_driver);
 
-MODULE_DESCRIPTION("Q6 Audio Fronend dai driver");
+MODULE_DESCRIPTION("Q6 Audio Frontend dai driver");
 MODULE_LICENSE("GPL v2");
-- 
2.25.0

