Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F3D3EC4FB
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 22:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbhHNUU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 16:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbhHNUUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 16:20:25 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E907C061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 13:19:57 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so26018107pjn.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 13:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ePTL3Kfj5FpJJV64v2XN6rOLtZyUMBX7KPr/SFojksg=;
        b=kf1Tbb+9UkthXULcv3jhomGwS7YOaN93jx1dbvVp5WKHs3Q3VKpqI4KneToozvnGbn
         xOUpiYJ2ZhfqJCf7B6/EMySTahTt7PSb3RfPqxvXdn0/PH/AQmpn6h3wZHUd1LmcRzlY
         fZ5t7t7+HeDK3ZcU5qTbB2inVDgcrgl0/HEdR0evMk04U0oWHGh6Hc6aQvYFkavzeuJM
         kGIzdqdFsx9RvpzGskzn5vGgTLHsBNQ46dn1w6SlNrxgCRRKlNwEflNAeFisqZJZTJML
         XctKMJXM2JZ/QQCwBM2zKfpAFIQeTUE0emm4JIHA31wYN4yKZKbKjiyPgoAR4UqC3jzy
         JgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ePTL3Kfj5FpJJV64v2XN6rOLtZyUMBX7KPr/SFojksg=;
        b=hbNHtpz3NG+JmVzBiI5NZJpM+QZgyisTrptXwQeoV2R0gDYSBMxdqGmAtuYrZGRCbw
         mdI5KhEkcf9+hmuHIViAMlbiEUISU6EiyxcL1BkA++wmEDHXrXyVkKquqUFg1Fnv8tFi
         05GZz1nPs8ALe6NN39Z/X8y2Z7YrGzIOD+q9+Vu8686XfprtvLmxxgkG7bF9U7ezz0IN
         ZawYRZlUMytrh1iLocBjPOdl1mpNVE38dbYlzoLXz9DWaj60tPPHTFiwj66Gppdf1UFB
         i46ieFhMNnNGImF+Mz30TGYjUlvPBITNHL2q84vl6gou6C5TRi4eHJW7VijVTV6z01Nl
         M4UA==
X-Gm-Message-State: AOAM530Lc9vg9BY2Xuvl8vZVanxG13/VWJ3s8ITE5ER8T128exDNaNWp
        fJaShxIqFj1Jb+DmN0DOfHQ=
X-Google-Smtp-Source: ABdhPJyd/i/l/TfPZNQZDIBXG+aOMRplp4tSWMwKxKVFpTQcDZmEXsyQt7VWpnVqVcUm3RyklrgM/A==
X-Received: by 2002:a63:1352:: with SMTP id 18mr8066688pgt.348.1628972396713;
        Sat, 14 Aug 2021 13:19:56 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id u13sm6413121pfi.51.2021.08.14.13.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 13:19:56 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Takashi Iwai <tiwai@suse.com>, Jawoslav Kysela <perex@perex.cz>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bjorn@helgaas.com>
Subject: [PATCH 2/3] ASoC: ti: omap-mcbsp: Use of_device_get_match_data
Date:   Sun, 15 Aug 2021 01:49:40 +0530
Message-Id: <44f3b21198dd1e40e1e5e783db2b3dd76505b562.1628972198.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628972198.git.aakashhemadri123@gmail.com>
References: <cover.1628972198.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefer `of_device_get_match_data` over `of_match_device`

Retrieve OF match data using `of_device_get_match_data`, this is cleaner
and better expresses intent.

Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
---
 sound/soc/ti/omap-mcbsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
index 4479d74f0a45..fcb651487854 100644
--- a/sound/soc/ti/omap-mcbsp.c
+++ b/sound/soc/ti/omap-mcbsp.c
@@ -1373,7 +1373,7 @@ static int asoc_mcbsp_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	int ret;
 
-	match = of_match_device(omap_mcbsp_of_match, &pdev->dev);
+	match = of_device_get_match_data(&pdev->dev);
 	if (match) {
 		struct device_node *node = pdev->dev.of_node;
 		struct omap_mcbsp_platform_data *pdata_quirk = pdata;
-- 
2.32.0

