Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913033664D7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 07:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbhDUF3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 01:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbhDUF3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 01:29:45 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A354AC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 22:29:12 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id z16so28659047pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 22:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S9cFyFhO9R2yAwKrT8XRyCRc7wvjemRTlbN3hfsszKw=;
        b=GT2Mj0spMd/69rT4+Fhdj1pS4MN1vIrov8lSPUi/QFrEy7oGA7K7MmZZ1+0t07zuQZ
         87Jy+zbUfAP3B0gYZYGYN4mBxnffj+twRcqVepho+einnzZUKjVnU37e3EoA6u+Gbmhf
         ydsF6en+tAM9NroZp8rB2CV9mTcPYkDO5modg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S9cFyFhO9R2yAwKrT8XRyCRc7wvjemRTlbN3hfsszKw=;
        b=febckLHgChz9LlqfYLQNt2hgO2/mFaXkVLCIZPTIpESlK8592J0tphFX7tb0AOf+CP
         SpchN+fxk8DS5DF+9pXvHNBvRTGnJYUH4JgasQYeIa1ta4pFTkoMv67BMnNTVYwq3ztZ
         dobPnmQnQkDx7M2crJ4UtvyPpSyHS+DrIioodaELBTDRDqKpAizSSXLlTYKMECZBcpRn
         as3nV/6jx+/DVJkeNMVzn6meaWUv+H+FlTtinvQEH7SxcIVX0V+txEoVdmE97myZAlQM
         FUX8iEzj4vZIXLOxaRsPfX0YCpGczcQigKoCBpj+swqOapXN0yFWXR7gRWBUcDuwbcji
         53WA==
X-Gm-Message-State: AOAM530Hs6Ofrq5JgJ2QS1lZyd6qj4jeutGK2RGh66VPFOm9C3VsWBuR
        QNbGq5nqGuwEkA7Bfzbuj1FNCw==
X-Google-Smtp-Source: ABdhPJxBMqVZ6+h/34Wk2pJLfm7hRZQgqp/mXZcC9Tsu2PNfWfLWzrLQJFgTRN03I7fqZ9CG1bO0og==
X-Received: by 2002:aa7:9817:0:b029:25d:f866:4a71 with SMTP id e23-20020aa798170000b029025df8664a71mr16154245pfl.47.1618982952228;
        Tue, 20 Apr 2021 22:29:12 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:b3e5:49c0:4843:2bbe])
        by smtp.gmail.com with ESMTPSA id b6sm602537pfa.185.2021.04.20.22.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 22:29:10 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     fshao@chromium.org, hsinyi@chromium.org, hoegsberg@chromium.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        boris.brezillon@collabora.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v13 3/4] drm/panfrost: devfreq: Disable devfreq when num_supplies > 1
Date:   Wed, 21 Apr 2021 13:28:54 +0800
Message-Id: <20210421132841.v13.3.I3af068abe30c9c85cabc4486385c52e56527a509@changeid>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210421052855.1279713-1-drinkcat@chromium.org>
References: <20210421052855.1279713-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPUs with more than a single regulator (e.g. G72 on MT8183) will
require platform-specific handling for devfreq, for 2 reasons:
 1. The opp core (drivers/opp/core.c:_generic_set_opp_regulator)
    does not support multiple regulators, so we'll need custom
    handlers.
 2. Generally, platforms with 2 regulators have platform-specific
    constraints on how the voltages should be set (e.g.
    minimum/maximum voltage difference between them), so we
    should not just create generic handlers that simply
    change the voltages without taking care of those constraints.

Disable devfreq for now on those GPUs.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Reviewed-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---

Changes in v13:
 - devfreq: Fix conflict resolution mistake when rebasing, didn't
   even compile. Oops.

Changes in v9:
 - Explain why devfreq needs to be disabled for GPUs with >1
   regulators.

Changes in v8:
 - Use DRM_DEV_INFO instead of ERROR

Changes in v7:
 - Fix GPU ID in commit message

Changes in v6:
 - devfreq: New change

 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index 47d27e54a34f..3644652f726f 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -92,6 +92,15 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
 	struct thermal_cooling_device *cooling;
 	struct panfrost_devfreq *pfdevfreq = &pfdev->pfdevfreq;
 
+	if (pfdev->comp->num_supplies > 1) {
+		/*
+		 * GPUs with more than 1 supply require platform-specific handling:
+		 * continue without devfreq
+		 */
+		DRM_DEV_INFO(dev, "More than 1 supply is not supported yet\n");
+		return 0;
+	}
+
 	ret = devm_pm_opp_set_regulators(dev, pfdev->comp->supply_names,
 					 pfdev->comp->num_supplies);
 	if (ret) {
-- 
2.31.1.368.gbe11c130af-goog

