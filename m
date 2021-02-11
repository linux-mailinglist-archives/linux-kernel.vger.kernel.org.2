Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD5631950C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 22:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhBKVUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 16:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhBKVUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 16:20:33 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CE6C06178B
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 13:19:33 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id f2so7269356ioq.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 13:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cH4qjKY0CS8cPWsSWSIfB/XmNwAKP+9ETXOQq1WP0+o=;
        b=j2q608rJJFE+nLbZ3vJpb510PbN918XLbfooaDSSYI6GuTE/UF93JfR3B5LwQTTFxP
         7veyTPNG6WRMMoLkm3oRjH1H8GMiyfjIuXV68XJfnlvu2Yk6ZkPOGUHJE1zJJXO3zhy6
         348tcI0DbxjG/x/fQ4SMH8YV45JrB1DoOqXjnLmuPF+C9LYsYZMhxWfmisg0SAfBMM4Z
         nfpOq+2e/8jPHlRg2CyTSqBcNUoe8LO3yFnmem4ThMfYzc+FGm0GyS9kelhApIj3OZrS
         n3Ms5UHmi3qqwdQ+UR8SGL8qpZ+1cFsancrcl33ePmMVBAQWzp6kzlX8ho+b3HtVOUjW
         G9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cH4qjKY0CS8cPWsSWSIfB/XmNwAKP+9ETXOQq1WP0+o=;
        b=Sj/QeGvHpuJyrIt06kfjx6DYQi2UMkhuArqH5jhSDrGLzazGUawqPWwaXSatD5igd9
         4GEy0oVQxFuphhzJokI3eKnlha31HsMTiKmzEMkenKsk+kUNX3PesImm28kWo2xk2x1x
         3noO/BNql1WferCwkFzaNMVjdUNYwg7635IeSE7Vr+u39hNDCP9HyE1CNjixWnsivklJ
         8eowmaJWNt5f+9uQvuxZ/WhDffeFKDYst1A2aNSIGyKd6uG4xe66u/6XZkUk5viT69jB
         eXX235KfdHvU5hjKe0Nx8UjPXvwsH6Bxj5g11qw5TzfnpB+1jFonQu4RTLNXq0VMSTyO
         pCrw==
X-Gm-Message-State: AOAM531N+hHnlLlBg/glhkAO0AJu/k0/NHmlDLm0zdNShcCoc6puXhQb
        wOuA9YKOOGdGPoiI/jDbFXGpOg==
X-Google-Smtp-Source: ABdhPJyHi0jpvZQRcM2ThmuxoElLYv2QeWBKH88pRAEiGwCzLXgsdusDB3U3V9DizoCZeqjRv5UofQ==
X-Received: by 2002:a5e:9409:: with SMTP id q9mr7011153ioj.54.1613078372886;
        Thu, 11 Feb 2021 13:19:32 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id j10sm3155718ilc.50.2021.02.11.13.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 13:19:32 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     elder@kernel.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 2/5] net: ipa: don't report EPROBE_DEFER error
Date:   Thu, 11 Feb 2021 15:19:24 -0600
Message-Id: <20210211211927.28061-3-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210211211927.28061-1-elder@linaro.org>
References: <20210211211927.28061-1-elder@linaro.org>
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
 drivers/net/ipa/ipa_clock.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ipa/ipa_clock.c b/drivers/net/ipa/ipa_clock.c
index 354675a643db5..238a713f6b604 100644
--- a/drivers/net/ipa/ipa_clock.c
+++ b/drivers/net/ipa/ipa_clock.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
- * Copyright (C) 2018-2020 Linaro Ltd.
+ * Copyright (C) 2018-2021 Linaro Ltd.
  */
 
 #include <linux/refcount.h>
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

