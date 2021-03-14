Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF6033A5AF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 16:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbhCNPqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 11:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbhCNPpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 11:45:31 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED593C061574;
        Sun, 14 Mar 2021 08:45:30 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j18so4452921wra.2;
        Sun, 14 Mar 2021 08:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f6C5LnJcPjvrSoy/lW5/dsmp2Az/VjPBdQ0RoCAGgfc=;
        b=ZYxiTzHuyZcBK0UmcnUMMH2wRhTl8IC9KjHzV4UiQHTwXYXCQ4DuHAFmssHWQQe5Ep
         JKNxFfS+xnNMvxIlbXBKxXN4PO60R0jQOzt5KWqrk57csAkbqxsEF1I6Hg+Oxy8/Wrk5
         mvaVKDn8I8nTuNJ+242qcfWHFmfwgJt0GRl8p3qqQjeIZY6/PaNzlzx8e3v7eIcVUGyn
         Ds0f1y3RimkVFewBa+h8AKsauiu2qsw4zlCV9AnORuNZS6VFp/XQ2EzbvngAhdH71MlV
         0pXNKNDyZbZsrkQWMmybLEgakqVBJR2xGxQ6Hnq5nJg7y/eWQea0bnIoyky9kZfN+Z/N
         Nbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f6C5LnJcPjvrSoy/lW5/dsmp2Az/VjPBdQ0RoCAGgfc=;
        b=HWzfRH4a1AkY3bg9BPN4JBv3UieM5GqRKgyzVyLoHp4oFioDVRwAKd5xTOoeiUUc/y
         IoYrkPa0gid2eScZr3IffXRJojNOzuUQ3R5//EnW6s96kbUaxYisQMxKusGNlOqOSGJQ
         gvimyovHiskFv/4As20n9mNxeNJz3fTg/vBsECI/rUrlljHoAs/NtEpSU8BjidG+wRF7
         IY8TJ1H3e9QlrxbINEMOV/kGWutWySRXEngeLZjbOtbQTObaVavuC2RQZByjfGdo8nga
         GsumaS4lHWPVjCRQIfAxrtr5X97ySx8kSNf9G06ja9XEzDjvjXpUg7Ie1R5/uSDQtSxL
         XLeg==
X-Gm-Message-State: AOAM533hz4hAbOIs1pW3XP64uBQqPNLp24X7eCJ8Mf2n2bKBK21dyHYx
        hAHHa4c6nC4mX11/ofRiDHk=
X-Google-Smtp-Source: ABdhPJxXAO+1FBI64G8zBdvT7vnz3Vqw9PUJEJpwZD9Nk01gBQn6RH3itOOLxfyExn9w7NOHrnJzhg==
X-Received: by 2002:adf:a2c2:: with SMTP id t2mr23194274wra.47.1615736729659;
        Sun, 14 Mar 2021 08:45:29 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id f14sm9673507wmf.7.2021.03.14.08.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 08:45:29 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Paul Fertser <fercerpav@gmail.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/17] ASoC: tegra20: i2s: Correct driver removal order
Date:   Sun, 14 Mar 2021 18:44:51 +0300
Message-Id: <20210314154459.15375-10-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314154459.15375-1-digetx@gmail.com>
References: <20210314154459.15375-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra20 I2S driver has a wrong driver removal order, which should be
opposite to the registration order, but it's not. In particular the
runtime PM is disabled in a wrong order. Fix the order.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 sound/soc/tegra/tegra20_i2s.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/tegra/tegra20_i2s.c b/sound/soc/tegra/tegra20_i2s.c
index 267517446d27..0f2bdc2e8598 100644
--- a/sound/soc/tegra/tegra20_i2s.c
+++ b/sound/soc/tegra/tegra20_i2s.c
@@ -440,13 +440,13 @@ static int tegra20_i2s_platform_remove(struct platform_device *pdev)
 {
 	struct tegra20_i2s *i2s = dev_get_drvdata(&pdev->dev);
 
+	tegra_pcm_platform_unregister(&pdev->dev);
+	snd_soc_unregister_component(&pdev->dev);
+
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		tegra20_i2s_runtime_suspend(&pdev->dev);
 
-	tegra_pcm_platform_unregister(&pdev->dev);
-	snd_soc_unregister_component(&pdev->dev);
-
 	clk_put(i2s->clk_i2s);
 
 	return 0;
-- 
2.30.2

