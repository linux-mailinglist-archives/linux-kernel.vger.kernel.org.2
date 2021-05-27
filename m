Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76653928C6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 09:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbhE0Hnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 03:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbhE0Hnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 03:43:49 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EF2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 00:42:15 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id l70so3085155pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 00:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BrbVgIij7R8LbUOrOIBIv2OLNl+Ip/Kqs7kj9XlKJUk=;
        b=SQtH/jrOEE6kk88cKkvSxsBamCau/HA6LO+WkxXT2OKIUlRPbubDXoPKK/J84DK90z
         tViLy+vQKnLAJK2PRgLoPMSraWAe08TSrKhWQ84yPmrmIDgjwjiC5qveCCmsX3JtUhaM
         S3QI3SIPi49owjcScyBxFzBrkyDdvujgOkMaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BrbVgIij7R8LbUOrOIBIv2OLNl+Ip/Kqs7kj9XlKJUk=;
        b=CO90PnGj7kOt8XMH8a7ZJAOUUMH4l8l4M0o2HvcvZPQcKc/+7RY/K/1U9vErd6jQcZ
         lLiW0WnjFMvDcXNA3dVoC2MO3/cmpG5i3XRjfAfVXLv2Tcb+j6mHHKdDSJx948SWZQUR
         Dj/JBShOIN00ZzMn/pQsBNB3ADA0tPynqr3gx0k3n0Adg3JSMzta0MhsC3mpenLYjmvP
         Vr3J2oqCmqC5cnqtUGiaf3y8t8s5I0/QC0lrb7QzkADQXgM0hf607LxUQQHs9dzb70Cs
         umHAA1W8k8uhY8wp4Z7LKLe8sw0dDRpKWgTmyTynwuOuBO/asIOKpL6bQDRYppxDLjwU
         76OA==
X-Gm-Message-State: AOAM530fvctG+WUy8MDXOFe/NmWa0LVcMF/O9s0yinMIg1K0+2SZekG4
        x0aYRbA26VT8ys/R1TQ3oL5HQQ==
X-Google-Smtp-Source: ABdhPJxuVP5C820VQJBG/Cqe/LBzPydpiOkSUvB5K7U8neoHStr0iUEtdqLCANJ++y7pTtplnH8sHQ==
X-Received: by 2002:a65:6849:: with SMTP id q9mr2443138pgt.377.1622101335476;
        Thu, 27 May 2021 00:42:15 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:ece5:55a4:6ad3:d20f])
        by smtp.gmail.com with ESMTPSA id h24sm1184857pfn.180.2021.05.27.00.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 00:42:15 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Robert Foss <robert.foss@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, intel-gfx@lists.freedesktop.org
Subject: [PATCH v6 RESEND 3/3] arm64: dts: mt8183: Add panel rotation
Date:   Thu, 27 May 2021 15:42:02 +0800
Message-Id: <20210527074202.1706724-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
In-Reply-To: <20210527074202.1706724-1-hsinyi@chromium.org>
References: <20210527074202.1706724-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

krane, kakadu, and kodama boards have a default panel rotation.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index ff56bcfa3370..793cc9501337 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -263,6 +263,7 @@ panel: panel@0 {
 		avee-supply = <&ppvarp_lcd>;
 		pp1800-supply = <&pp1800_lcd>;
 		backlight = <&backlight_lcd0>;
+		rotation = <270>;
 		port {
 			panel_in: endpoint {
 				remote-endpoint = <&dsi_out>;
-- 
2.31.1.818.g46aad6cb9e-goog

