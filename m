Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D68540F88A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245049AbhIQM7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244983AbhIQM7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:59:24 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125C3C0613D9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 05:58:02 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id c190-20020a1c9ac7000000b0030b459ea869so1343133wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 05:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=plrOrvIZM2TLyxiMQcIWBN+4lREuMv3pRG/Sh7a1xC8=;
        b=A1XyPdxcOquLxN0aX50A1ZFpsIYqi3fOAj7lTpkAapmpB6s0I7t5BtLQBntoT5o/gC
         LTk3U5iGqZXV00d7UWu1zJeHwNQUIaZQXm49I9GxJIR/4y18GU6Nvyoikkh2w2l4zgcp
         B3UYoAnqDqm9GVkUY9hqfwcQPouBjXs+iZX47NO/QJ/t4wb1kggMVtkvmAtzd4qzJFRW
         7nWbDttoNJXmYKodYdihre5foSUAr0yPacNcyWtLspR5zCXh9y8npouXY1dRxKM6UQcn
         WZ3a9DrYMmZAVwaW7QgPnDaW9jP4k2Ex3PG5EKtnNHZgrO8bzEd2qcrTOZ99BSIM62Lu
         8eYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=plrOrvIZM2TLyxiMQcIWBN+4lREuMv3pRG/Sh7a1xC8=;
        b=UZO9akhxEwsCK6NOpP+vqp8mova6ZYityWg1GOD9XM6VNb6Y5KafKGEgf1Q0ahwbzD
         sUnrzFH5ng0OPwqJDDlQyHD2UJlStgf9MtDtlxmCyRhQvCvAgfBt8L822L9vREcxpFKN
         yVns3hT339tO9xJ1Yr8b9U+LMn/RIrNrXDqYEpt0tC4GrGVK5pRSNPLQBXQ4l5zuReK1
         Iyab7IQzNXVATfRafP5qpuf+uopPjTX9WbyIUOEVO+h7hHUmm98yUMqSlzEbGnyJiNvx
         XJ2Up1YOwqxzfApswQfTZaSRlq3uPWGzNQIKmwiIOEdaMgjlsk880V3ne6NzdYDTo3nP
         C2Wg==
X-Gm-Message-State: AOAM530xKbLlNyznHfXQHTJGGmpfEsbn2S60DKlO6vomUoQANxrq+CVU
        kXeF1vUVBIv0jxKzwo0kjQBH3g==
X-Google-Smtp-Source: ABdhPJxTbG15Mr23ALcQTVgBRPbbO7jTynJgRBVrKM9JKm3YI/iNB4vjrE9aSV9fhOwwMUSmYbl5Hw==
X-Received: by 2002:a7b:c086:: with SMTP id r6mr10257667wmh.46.1631883480653;
        Fri, 17 Sep 2021 05:58:00 -0700 (PDT)
Received: from localhost.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f3sm6358636wmj.28.2021.09.17.05.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 05:58:00 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        matthias.bgg@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, ohad@wizery.com,
        bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        sumit.semwal@linaro.org
Cc:     christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, khilman@baylibre.com,
        gpain@baylibre.com, Alexandre Bailon <abailon@baylibre.com>
Subject: [RFC PATCH 4/4] ARM64: mt8183-pumpkin: Add the APU DRM device
Date:   Fri, 17 Sep 2021 14:59:45 +0200
Message-Id: <20210917125945.620097-5-abailon@baylibre.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210917125945.620097-1-abailon@baylibre.com>
References: <20210917125945.620097-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This add the APU DRM device to pumkpin.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
index 7fbed2b7bc6f8..c540dbfe30151 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
@@ -98,6 +98,12 @@ ntc {
 		pulldown-ohm = <0>;
 		io-channels = <&auxadc 0>;
 	};
+
+	apu_drm@0 {
+		compatible = "mediatek,apu-drm";
+		remoteproc = <&apu0>, <&apu1>;
+		iova = <0 0x60000000 0 0x10000000>;
+	};
 };
 
 &auxadc {
-- 
2.31.1

