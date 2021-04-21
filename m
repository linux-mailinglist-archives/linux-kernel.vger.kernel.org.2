Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41BFD3664D8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 07:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbhDUF3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 01:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbhDUF3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 01:29:48 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8391C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 22:29:15 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id c17so27621024pfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 22:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5hFZoL/B1X+TSHMC73OVlRCB/m5eFhUPf/0EsulpbQc=;
        b=GSqR/tNLV3h2WeySeGfMGXOdlSgUpYvKwLbgArv7aByT94uKy05vclZyhRVEgxk6z1
         y2lzKfsYfERoExvktOFnGzS6Nit5WD4J93WIFbcrCCn5ypodHnnkR6Xb9ApUv4tRIkTX
         X4dQbkBfnwKACwTorawRek4NP46rAGerLZ384=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5hFZoL/B1X+TSHMC73OVlRCB/m5eFhUPf/0EsulpbQc=;
        b=bMZaftO1rN0a32Gf4l1Bzu++xwxRowdNBMQ2VJ81Y1loZ6RVGKf/59WUFhceNsdrct
         E8PjPDSabJ4FQyy6UzETiBt+FJX8gHWLho9d+iW2MRvIKGUCh3FpcOJOX/Yc4qlos7QQ
         JFBMgQVSrmFoACd4hd/3ejTxOPw00z51UBqHabHaPzgbsRnXRElIBxuBv8X48kE9fxI9
         cTD8LEmbkU+Y5dof4oO+urh5BewHy9Okq9bujrOhxaTUHQ4MAcWZLHQjbaqq6dEcwujf
         iQcXtI9Vb/DJuyBWBlHWu3O+h11VTxM3WfastHeRtwVheLtK2+ekrQyzV5tQhkiD66TZ
         iNnA==
X-Gm-Message-State: AOAM532cHF56IAWB8AeRyUGIiX2zrVNc1ekPbbdZBFU5dZNhVcZpDeKE
        Pzdx4TR2hDcLCHbMQ4tB5T6ypg==
X-Google-Smtp-Source: ABdhPJyZDRqJdOcJWbtPfs6X/UaeVpCly9Jbo3Ob3dn5LLzwTPwfK1AOmwpC17pOPG6/nzFx3YPVUw==
X-Received: by 2002:a17:90b:808:: with SMTP id bk8mr9347798pjb.128.1618982955584;
        Tue, 20 Apr 2021 22:29:15 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:b3e5:49c0:4843:2bbe])
        by smtp.gmail.com with ESMTPSA id b6sm602537pfa.185.2021.04.20.22.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 22:29:15 -0700 (PDT)
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
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v13 4/4] drm/panfrost: Add mt8183-mali compatible string
Date:   Wed, 21 Apr 2021 13:28:55 +0800
Message-Id: <20210421132841.v13.4.I5f6b04431828ec9c3e41e65f3337cec6a127480d@changeid>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210421052855.1279713-1-drinkcat@chromium.org>
References: <20210421052855.1279713-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for MT8183's G72 Bifrost.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Reviewed-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---

(no changes since v7)

Changes in v7:
 - Fix GPU ID in commit message

Changes in v6:
 - Context conflicts, reflow the code.
 - Use ARRAY_SIZE for power domains too.

Changes in v5:
 - Change power domain name from 2d to core2.

Changes in v4:
 - Add power domain names.

Changes in v3:
 - Match mt8183-mali instead of bifrost, as we require special
   handling for the 2 regulators and 3 power domains.

 drivers/gpu/drm/panfrost/panfrost_drv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 83a461bdeea8..ca07098a6141 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -665,6 +665,15 @@ static const struct panfrost_compatible amlogic_data = {
 	.vendor_quirk = panfrost_gpu_amlogic_quirk,
 };
 
+const char * const mediatek_mt8183_supplies[] = { "mali", "sram" };
+const char * const mediatek_mt8183_pm_domains[] = { "core0", "core1", "core2" };
+static const struct panfrost_compatible mediatek_mt8183_data = {
+	.num_supplies = ARRAY_SIZE(mediatek_mt8183_supplies),
+	.supply_names = mediatek_mt8183_supplies,
+	.num_pm_domains = ARRAY_SIZE(mediatek_mt8183_pm_domains),
+	.pm_domain_names = mediatek_mt8183_pm_domains,
+};
+
 static const struct of_device_id dt_match[] = {
 	/* Set first to probe before the generic compatibles */
 	{ .compatible = "amlogic,meson-gxm-mali",
@@ -681,6 +690,7 @@ static const struct of_device_id dt_match[] = {
 	{ .compatible = "arm,mali-t860", .data = &default_data, },
 	{ .compatible = "arm,mali-t880", .data = &default_data, },
 	{ .compatible = "arm,mali-bifrost", .data = &default_data, },
+	{ .compatible = "mediatek,mt8183-mali", .data = &mediatek_mt8183_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dt_match);
-- 
2.31.1.368.gbe11c130af-goog

