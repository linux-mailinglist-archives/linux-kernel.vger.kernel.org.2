Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A4236ABCD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 07:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhDZFTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 01:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbhDZFTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 01:19:39 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E6AC061756
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 22:18:56 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id z16so39305915pga.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 22:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gt4pb5bT5mW/MToENIuo4Jt8VqUlSnyGRgKvmw6yKp0=;
        b=PLSD7jhKImFPl98DBSFMj8R/b5Ul4bbE+BoQg9DsV2ma3TcmldaXG7B0oHdDFuM1lD
         /HVqkDvzFawztE9+VgbeJojJAMZvcfkOkTS7KH/HG+p21hPsekQVIJpXS07mWJHskcY4
         rEnzo0eFpJwFbTCLUYHx9TOYDAeOD6D9JpLVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gt4pb5bT5mW/MToENIuo4Jt8VqUlSnyGRgKvmw6yKp0=;
        b=UXpeXQJhaoVm8qi20ir+FJDFVsxGu6xA77CFNe9f56vAIWu8sdvl/VsFRiDX0kMn4b
         rN51FnTLPjRf0c91VV2P4BuuZR7uyLoW0jv14+rP7p6wyHKv01ZBZu43RFd6epuAKXoW
         4cYQIEd9kNaqvUAewuaSR9n5HxvHWNMoXakP6/9JPbR+MJXlVkTs66C+fxl7OMQpxjvM
         71NK8tCm9U2nEBQOzxJUxqmFDMpn6TZ/PurkqBcKZFDAQINJAaPEs5VVIB1x79R1lLtK
         FAg0jrc/NskPXOji/nALAzI+aC5X020A2mMSTlPLDP5nJjh3mXqnhZmPpUWmKUHnCKma
         2U/Q==
X-Gm-Message-State: AOAM530xx1DwgWft2aNq3AfdyN/c5+2PnyL4LS0orimfnybT/on12pdt
        5hCfamQmh7zwDUCrerPnh0RNvQ==
X-Google-Smtp-Source: ABdhPJwhzSFNys1E+rEQpwqHLs4DcKy+qdcvTtSweq5ZIYRg4MfS83Z6E4sOu0fwV5TrQEfwqkVuOQ==
X-Received: by 2002:a63:6b4a:: with SMTP id g71mr15306124pgc.274.1619414336303;
        Sun, 25 Apr 2021 22:18:56 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:49dc:8519:4648:67e])
        by smtp.gmail.com with ESMTPSA id h9sm9928420pgl.67.2021.04.25.22.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 22:18:56 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 2/2] arm64: dts: mt8183: Add panel rotation
Date:   Mon, 26 Apr 2021 13:18:48 +0800
Message-Id: <20210426051848.2600890-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210426051848.2600890-1-hsinyi@chromium.org>
References: <20210426051848.2600890-1-hsinyi@chromium.org>
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
2.31.1.498.g6c1eba8ee3d-goog

