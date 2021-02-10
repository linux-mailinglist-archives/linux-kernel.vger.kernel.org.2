Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8944B317374
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 23:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbhBJWfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 17:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbhBJWe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 17:34:29 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDF8C06178C
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 14:33:25 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id n14so3718326iog.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 14:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kS/gU6f8FHhPHE8VvojwVRld2jg6RFS0NvtZfg95Sy4=;
        b=ybH66RtLq3+ZJzCR6tIlv+7xXv+gGzUgrwWkYfyuFs1cyrV3T4poUJu9KPIFpJG1f5
         4LGLyqScDW+7N7ZwHMALv+1TWI15tkq0mOvOkzP4ZJQrTk83bJLflfxfRrzk6gGTT7mq
         7n+vV+Jf1pAL/oHxB+IJzh7/U5pBXBhlxwNxULajY8/A0Op77VhycJK5Qt+DDXIOCLsG
         QQ/k51Cvz52V4Mhuadkc3+U5rnu9UVTgptCvt5y6zmt4m7oG7auhEQAcb5OX688Q6nlM
         sEsJnCYC+rwF+wELJu19V2rIh/ia8xZBtJvKqri9lcfrZvxcPnVqHoLDtT80Pjt0Zas8
         ZswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kS/gU6f8FHhPHE8VvojwVRld2jg6RFS0NvtZfg95Sy4=;
        b=idHUpp8TkNNeGNPpLPMwMbxmzHvnJMtinT+BHcZ3dZydE6cXOkDWX68Cl4GKBr+d1C
         p1KeYk7Ixp5Ya5bzwr7QJPGF1U2YMifc12adABcLGwhOvCfLk6JmdFR/T6V6Lr9VgaTy
         yNa6K6MM58htj9yF1LuMb6xPLNJ8XTpkE8VbAiK4sfRe8h5RCUg7PkkXq2C9P7vNs0Yj
         uQZe3yDv5+F2qVsVkqM9fZ0j9LXutDQ4eHnrUoSXHXp5bNqMC/gOP+UrEJWWHx7+rwd6
         SOamgSvFxZ3aQugMeaWmkfpX7EcPIqW0qNpCckN6eXRVchyNLkOr5II+LLqchDlrz4RG
         tkCg==
X-Gm-Message-State: AOAM532IHqBJkaNDeuLcqX65VKbq+x1WKL7KnvBw9hBAv1+LcFwh084z
        akxL7wR3X6WwnwdKzazYdaH0Nw==
X-Google-Smtp-Source: ABdhPJxl1uhDN2EE0556rEtchpUcIrMm8/d3TsTBfXqBDl9/5+XSK0UCr9FGPxhv908m0FBlaFXRNg==
X-Received: by 2002:a5d:980c:: with SMTP id a12mr2832889iol.196.1612996405495;
        Wed, 10 Feb 2021 14:33:25 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id e23sm1484525ioc.34.2021.02.10.14.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 14:33:25 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     elder@kernel.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/5] net: ipa: don't report EPROBE_DEFER error
Date:   Wed, 10 Feb 2021 16:33:17 -0600
Message-Id: <20210210223320.11269-3-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210210223320.11269-1-elder@linaro.org>
References: <20210210223320.11269-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When initializing the IPA core clock and interconnects, it's
possible we'll get an EPROBE_DEFER error.  This isn't really an
error, it's just means we need to be re-probed later.

Check the return code when initializing these, and if it's
EPROBE_DEFER, skip printing the error message.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_clock.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ipa/ipa_clock.c b/drivers/net/ipa/ipa_clock.c
index 354675a643db5..9c845f9bb318e 100644
--- a/drivers/net/ipa/ipa_clock.c
+++ b/drivers/net/ipa/ipa_clock.c
@@ -68,8 +68,9 @@ static int ipa_interconnect_init_one(struct device *dev,
 	if (IS_ERR(path)) {
 		int ret = PTR_ERR(path);
 
-		dev_err(dev, "error %d getting %s interconnect\n", ret,
-			data->name);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "error %d getting %s interconnect\n", ret,
+				data->name);
 
 		return ret;
 	}
@@ -281,7 +282,10 @@ ipa_clock_init(struct device *dev, const struct ipa_clock_data *data)
 
 	clk = clk_get(dev, "core");
 	if (IS_ERR(clk)) {
-		dev_err(dev, "error %ld getting core clock\n", PTR_ERR(clk));
+		ret = PTR_ERR(clk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "error %d getting core clock\n", ret);
+
 		return ERR_CAST(clk);
 	}
 
-- 
2.20.1

