Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF6C38CF91
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 23:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhEUVCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 17:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhEUVCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 17:02:40 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD56C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 14:01:16 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ne24-20020a17090b3758b029015f2dafecb0so6660722pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 14:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qcucsln58OsrXcIsnyUyuUI/EGMDXBHA3sqXqZbY5oQ=;
        b=aV1t1CAkEUTf2hFhPL0C02ioDHWC3FjKXeMwGRamT26ZTjEZBzNqGTmZYDvrtA3HhS
         B2WWNw8sfATpuLnGwIlevkc8TkGaLuYHs0MAhP4CUy6CPuW23GqjJcR8w5m00Z9QeBoB
         bOVSeIcNZHPV0LfiH+KC/xKFS9oJiKDdeAbrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qcucsln58OsrXcIsnyUyuUI/EGMDXBHA3sqXqZbY5oQ=;
        b=Vf9b7PH/b3fDpZNezXfWAg3Rf34kVF2lwE0yQjRCsT7TE9dBxHYfyMbb6HxsBF+5T3
         lVcZkBl2/wHiSwUMXXrNRedy2lzsTfXyojhya0iWBBxBjRQ3qjb2bIEUzkYcPug1bSvI
         F8/+I0wbR1tt21hE5ORb4zqywNjxOOz9VjYhd93cKY4cD7i+RgNQo0en0CW3BncXYL85
         P+HAOCKHMe7iawsXMp+eIZUF+/bjb4rvr6x4TJXrau3yOuFvXNYtr2E1BUYf0L9Uae4d
         uxK8ry4knvhoPSnDVOBXjrVccPtvG4r4zN8EG4GLnnEazjr7R4mZHll3GBsAmTN99nAM
         Lccw==
X-Gm-Message-State: AOAM531b42t7vB5e3MLJx8f+0/EVO2JwZRJbWFd9t14HS9d0gxnCKdUk
        6FlQ60Gaw3vtIAxHyVThm7XgxA==
X-Google-Smtp-Source: ABdhPJzjiR9OmDU991lLjA+2s0PA+vhVMkD1DNqpi/iUqDxkAh+P7lJrs9JUFen9Q5TsbtHn3chUQg==
X-Received: by 2002:a17:902:b412:b029:ef:1737:ed with SMTP id x18-20020a170902b412b02900ef173700edmr14322796plr.43.1621630875766;
        Fri, 21 May 2021 14:01:15 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:10e9:a6cd:727f:561e])
        by smtp.gmail.com with ESMTPSA id o6sm5202532pfb.126.2021.05.21.14.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 14:01:15 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Joe Perches <joe@perches.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] nvmem: qfprom: Improve the comment about regulator setting
Date:   Fri, 21 May 2021 14:00:58 -0700
Message-Id: <20210521140031.2.Iaa641db08ce7c571860dcce13e4ce056008b711e@changeid>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
In-Reply-To: <20210521140031.1.Ibaca694aedfaff823feefa06b29ae746c641dd1a@changeid>
References: <20210521140031.1.Ibaca694aedfaff823feefa06b29ae746c641dd1a@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In review feedback Joe Perches found the existing comment
confusing. Let's use something based on the wording proposed by Joe.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/nvmem/qfprom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index 1ba666bcb900..81fbad5e939d 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -196,9 +196,9 @@ static int qfprom_enable_fuse_blowing(const struct qfprom_priv *priv,
 	}
 
 	/*
-	 * Hardware requires a min voltage for fuse blowing; this may be
-	 * a rail shared do don't specify a max--regulator constraints
-	 * will handle.
+	 * Hardware requires a minimum voltage for fuse blowing.
+	 * This may be a shared rail so don't specify a maximum.
+	 * Regulator constraints will cap to the actual maximum.
 	 */
 	ret = regulator_set_voltage(priv->vcc, qfprom_blow_uV, INT_MAX);
 	if (ret) {
-- 
2.31.1.818.g46aad6cb9e-goog

