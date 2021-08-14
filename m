Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368263EC4FC
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 22:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbhHNUUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 16:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbhHNUU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 16:20:28 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB20C0617AD
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 13:20:00 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j12-20020a17090aeb0c00b00179530520b3so5593081pjz.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 13:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hvKMQmOLj6OmKuLluvPksBR7uMBeqMOloBYYGumCRK8=;
        b=BE2s+NqEn4DbtEps+vzNh1JAevWZM+ii/JtaK0P+fMlRBIjZOdbdfRMfP8e9tjUlpx
         P5e4VgIRXGtvSqDkbasFfH37FOOu8ieIi5KwK4sq8sXoChap+DF6ND84F+FIjp+95CXi
         0xQGrnAUXUBD/gJ1hFbo1ANodVcxw+HWctQJvVGU4neUfE9Ow/eWKCOt+ABIH38uu+GV
         BhboIPUGgQ3yuEEka7jeCF7eKR7UJt9oW1usflutpkBQ5QZCcjMFFOULfwNoaODsbtLX
         nwjkYJS03kZlexIMT2lgIxpbukNSOGfBbbcAOdo3YjU8rIg0vy10N+myueD/D2IrfdU5
         uA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hvKMQmOLj6OmKuLluvPksBR7uMBeqMOloBYYGumCRK8=;
        b=Hvgy6xAOTKPqc6HvQ5h7rvN4UZ4fUMwSmxO0MgMS13MQbGAgfej8GTeCbR11ptAi4V
         imOp1M79M285Mn97WS4EZkt+lXtB5NLwI5SpCmBHcbgzbQBhRJ90BvbbVo08WDcVkkFx
         +1yf0xA9xY7SmQYyNoqPU6SjlemiUoBUjv4B8r+Mebrjvbk1timoWjIMu8oeQuNPLKJk
         zmcLweakChUgbcRq8q2NOVmdJhiaHM6rlr+ElttN1yz54Fq2E0JjaOGqyqYZrm1pfxlS
         v+5MPNbgiAOoOxgRS97SKTx6bMYTlVTOVqRdtwOnbdSh/2jX06YEK88HSCKgTchDZGqi
         +kag==
X-Gm-Message-State: AOAM533Yj+XaVMdeAcyYUoETOfwgI9YLiL6c7kJd5N/VC2wf6owyX9+u
        dB3+Y8u4MWCp5wuhGClMKc4=
X-Google-Smtp-Source: ABdhPJxA06VZoHW86ZtZg2aIgjU9cv15c2XHAQctF98Bsnsi0yv/B8oD8+fyzzFL/ayLTD6Ao1fvng==
X-Received: by 2002:aa7:8503:0:b029:3bb:6253:345d with SMTP id v3-20020aa785030000b02903bb6253345dmr8259509pfn.35.1628972399802;
        Sat, 14 Aug 2021 13:19:59 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id u13sm6413121pfi.51.2021.08.14.13.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 13:19:59 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Takashi Iwai <tiwai@suse.com>, Jawoslav Kysela <perex@perex.cz>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bjorn@helgaas.com>
Subject: [PATCH 3/3] ASoC: ti: davinci-evm: Use of_device_get_match_data
Date:   Sun, 15 Aug 2021 01:49:41 +0530
Message-Id: <6ebb350fa8a960b8775ce324b7786dbaa865a1c8.1628972198.git.aakashhemadri123@gmail.com>
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
 sound/soc/ti/davinci-evm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/ti/davinci-evm.c b/sound/soc/ti/davinci-evm.c
index b043a0070d20..bf13f3d25cec 100644
--- a/sound/soc/ti/davinci-evm.c
+++ b/sound/soc/ti/davinci-evm.c
@@ -389,7 +389,7 @@ static int davinci_evm_probe(struct platform_device *pdev)
 	struct clk *mclk;
 	int ret = 0;
 
-	match = of_match_device(of_match_ptr(davinci_evm_dt_ids), &pdev->dev);
+	match = of_device_get_match_data(&pdev->dev);
 	if (!match) {
 		dev_err(&pdev->dev, "Error: No device match found\n");
 		return -ENODEV;
-- 
2.32.0

