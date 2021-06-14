Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513F53A6DE1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 19:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbhFNSBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 14:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbhFNSBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 14:01:18 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12960C061767
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 10:59:08 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id a127so5296262pfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 10:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J+erjNqDrPoL2uchSu9MBs+KDJ5et74963hksVtnp4U=;
        b=ktjbhTt3lFNJ6ACFxiZ5oXAKXa263kBrdQ7nUNo6fUizS688kNIztupsr8eMphLCNR
         98dtW+RZDmdypbhhDT1XEN/3IxDoL09OHy/uTSEp1as92NkfkFvG3TSvqbn0rW4RMU5C
         73zPD+M8oQjXyWaFk9K5vI2qO6VTnQibRWE7y+zNkBbwPoIWBRH+Fty9FJTLljJzZslc
         mijpsxYKBc/p87fe6eZb4Qxx45GiAIc4bet9+3h/nx8udX95OxHnEflfczUBbYExP2EO
         GGZFnw8Y2JgPw/2xKayNzhlPhNTLcjmm8UuZXGsmEHWP8ytaFh7SwQtH9UqaKgvwoG8g
         VxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J+erjNqDrPoL2uchSu9MBs+KDJ5et74963hksVtnp4U=;
        b=paLegmrECG+oBF9RCW2stClrrZwdYl7ySvJKiQbi3U4zT86b9AZYAME4B4olEEvnfR
         hnsREB1QNZifO8HByMnpcvWX8ucRa2DQci29Zyx9IDIiMOTiqteTKTEZgwoVWUAmAXI1
         4cebtVEwRVNoFt2HHEkzzntbvCmQLE6sfw2TsZx0qU9NY7qzSilzFvZbrtlUAMLA0n8f
         1evC3QvRwi3xPZ4HzIR+X1PyDepGiIVWSBxirOQV2uZ6tnBteQ3QQkmRJdZbz1KO0Oxf
         gqN+6DMYN8E6haH/BBSkVbQRGFoMn2cpco7gp1HZxj/qBTqMCaSixK/Eb/E7uaEvBNTn
         tb6A==
X-Gm-Message-State: AOAM5338dRPMgwmq593ofH0JRgWAFBLHVfiyky/Bl3h4bxMGvGjNMQy4
        di/cb08Q9oVDShKBsrtWhXoflA==
X-Google-Smtp-Source: ABdhPJwf6/qYjkPrsRLZtvnEVqB2JCec4VNquyuN+tC3lcaPzyQhoNr9AZXeHvgHdSMAFv9ib5LAuA==
X-Received: by 2002:aa7:9ab3:0:b029:2f7:e053:f727 with SMTP id x19-20020aa79ab30000b02902f7e053f727mr118091pfi.74.1623693546772;
        Mon, 14 Jun 2021 10:59:06 -0700 (PDT)
Received: from p14s.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id z17sm13553246pfq.218.2021.06.14.10.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:59:06 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] coresight: core: Fix use of uninitialized pointer
Date:   Mon, 14 Jun 2021 11:58:57 -0600
Message-Id: <20210614175901.532683-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614175901.532683-1-mathieu.poirier@linaro.org>
References: <20210614175901.532683-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junhao He <hejunhao2@hisilicon.com>

Currently the pointer "sink" might be checked before initialized. Fix
this by initializing this pointer.

Link: https://lore.kernel.org/r/1620912469-52222-2-git-send-email-liuqi115@huawei.com
Signed-off-by: Junhao He <hejunhao2@hisilicon.com>
Signed-off-by: Qi Liu <liuqi115@huawei.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Fixes: 6d578258b955 ("coresight: Make sysfs functional on topologies with per core sink")
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index a7971c68b0be..20ea4aa619f0 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -608,7 +608,7 @@ static struct coresight_device *
 coresight_find_enabled_sink(struct coresight_device *csdev)
 {
 	int i;
-	struct coresight_device *sink;
+	struct coresight_device *sink = NULL;
 
 	if ((csdev->type == CORESIGHT_DEV_TYPE_SINK ||
 	     csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) &&
-- 
2.25.1

