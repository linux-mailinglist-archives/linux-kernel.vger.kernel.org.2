Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B213662FE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 02:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbhDUAUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 20:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbhDUAUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 20:20:03 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F104C06138B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 17:19:30 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id y1so4964981plg.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 17:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5hFZoL/B1X+TSHMC73OVlRCB/m5eFhUPf/0EsulpbQc=;
        b=m86Akho6e5NFRQG+D9b5XKy1PM6jBUdw/OAXHb0gNMKjnsjAWo5nsN1SanDXJ3iNCL
         pfHEaIvhgdU29LPWVXVMQtU//JFrjVcsKlnAmg+kjZw84uDn/dy6b4khV62ciU9plhJa
         lMVfjivc8cIq7ok/I0nblMrd/Gbniy4M+Ev3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5hFZoL/B1X+TSHMC73OVlRCB/m5eFhUPf/0EsulpbQc=;
        b=CTHGVm8ucE+SMC0pSG8eQBDatiGm2Q7dlO4I2wHfc8+tBUcEnS1FNPdrV93VUM2s+S
         3WMLewBCabLfeHscXbu+bal+2d0BDwpFWIKMAgWhj4VshbL78sXYHr4orDj2Hy2IPIBL
         +nzQ65g2RmbzUa7L/Jdf/dkVpJ/C0K6c7N+KFeqt6dHHWUYFcVC1iYAHHYzXF6I9VpAC
         yNqxhrUY3KIQvEvKKRi6qIhPj1SvgjtEM4pM30T7e/LWsMKNqbn9TvrTeln5lo2OCiN0
         aVybsTnP+DdigxEPMbGaw+8wO6DBJOTfA7WhGMGctxstDcIoRpvtMp4cGzJcRgI4vGfF
         zAJw==
X-Gm-Message-State: AOAM533wHGSqw/RUPlzii4aQl+4L6+DHhN2gSWbIf5AraeWw82t1ya0E
        i/l4tVyHBsNG4Zj6qIkaeajKUA==
X-Google-Smtp-Source: ABdhPJwPcD332xjlRJLIeFst3MzhfSb/LQ1n4pU5CTQv/wJO0T4lmQXl3wRtx/vDfJA1pFQZD+KMsg==
X-Received: by 2002:a17:902:6544:b029:ea:f94e:9d4e with SMTP id d4-20020a1709026544b02900eaf94e9d4emr31488680pln.16.1618964369761;
        Tue, 20 Apr 2021 17:19:29 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:95d2:8c89:b629:ff49])
        by smtp.gmail.com with ESMTPSA id d20sm145494pfn.166.2021.04.20.17.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 17:19:29 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     fshao@chromium.org, hsinyi@chromium.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        hoegsberg@chromium.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        boris.brezillon@collabora.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v12 4/4] drm/panfrost: Add mt8183-mali compatible string
Date:   Wed, 21 Apr 2021 08:19:08 +0800
Message-Id: <20210421081831.v12.4.I5f6b04431828ec9c3e41e65f3337cec6a127480d@changeid>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210421001908.813625-1-drinkcat@chromium.org>
References: <20210421001908.813625-1-drinkcat@chromium.org>
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

