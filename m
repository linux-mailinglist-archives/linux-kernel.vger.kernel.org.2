Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68965371121
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 07:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhECFGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 01:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbhECFGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 01:06:23 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EFBC061761
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 22:05:29 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id gj14so2384984pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 22:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Gd+q5isoBTEaO167JYZlFPuozG7kopSgX/B2WmZT4CU=;
        b=lSkSIsRdhK8drnieHGaWU5Z3g0S5yMaBlkNsgsDMY3lvBXhgUlv0SUc4MJ1Xqe5GAB
         evI5zV66b80zQU0tftjWz08/TIs9qYdfswLM3vDfLBeGrNDwfJJbppalGGEYeTMGsdsP
         40SVzfFobjxQAC/vuSSP1ApIuSeidLvTdWZpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gd+q5isoBTEaO167JYZlFPuozG7kopSgX/B2WmZT4CU=;
        b=cBMN5J5V1zrDmPd3G/u/YvMrSJyyjgq/WdC9CilBJYMy2BugNiCCScxW1yUxuNOuWr
         Yj/OvpQVeYIqUN7+VeLapv0ccpStSxlbTqkShq3aCu1zArsVtk2iaYVPbWVh/Zsdo0ws
         OYBQE/PH4Pxz3Cwi00gPJUFe7ZCSjiBYGSiO/myT6kJqoNMmaZMM+/GbVwBz3Jd4gzSU
         2A+tw8eadleTsHaDy8ZsC7bmkgJy/+C9ENwbCOtS2lB8NAQGIvQzBir3yUZrABHa1AiT
         CVPV99QUmvR66hyxCUG9F7+HmZwrb+E08JB5+W8USrUEGlMk8SDe35TRfhhSH4s3/rig
         BY4w==
X-Gm-Message-State: AOAM531zPpYANYgMK245LISwub0HdUxsRGx70faQlu4bzmKrHfM4P7aS
        c5Hl5iRnmLPd3WyrB68ip9sktg==
X-Google-Smtp-Source: ABdhPJzr0YgdF6zJDMGKSd8q835/nBnu4xKXG1psfhQlDWIKQuWD9DbhfQLmkZ2QLfxMzWvV/OJmcg==
X-Received: by 2002:a17:902:d204:b029:ed:19aa:c364 with SMTP id t4-20020a170902d204b02900ed19aac364mr18594442ply.34.1620018329259;
        Sun, 02 May 2021 22:05:29 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:63a0:c726:475a:ace5])
        by smtp.gmail.com with ESMTPSA id 14sm7854600pfi.145.2021.05.02.22.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 May 2021 22:05:28 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        devicetree@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: mediatek: Add optional mediatek,gce-events property
Date:   Mon,  3 May 2021 13:05:23 +0800
Message-Id: <20210503050523.2571758-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
In-Reply-To: <20210503050523.2571758-1-hsinyi@chromium.org>
References: <20210503050523.2571758-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mediatek,gce-events property is used by gce clients.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 .../devicetree/bindings/display/mediatek/mediatek,disp.txt  | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
index fbb59c9ddda6..939b2da3bdc5 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
@@ -75,6 +75,10 @@ Optional properties (RDMA function blocks):
   mediatek,rdma-fifo-size of mt8183-rdma0 is 5K
   mediatek,rdma-fifo-size of mt8183-rdma1 is 2K
 
+Optional properties for display mutex:
+- mediatek,gce-events: GCE events used by clients. The event numbers are
+  defined in 'dt-bindings/gce/<chip>-gce.h'.
+
 Examples:
 
 mmsys: clock-controller@14000000 {
@@ -209,6 +213,8 @@ mutex: mutex@14020000 {
 	interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_LOW>;
 	power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 	clocks = <&mmsys CLK_MM_MUTEX_32K>;
+	mediatek,gce-events = <CMDQ_EVENT_MUTEX0_STREAM_EOF>,
+			      <CMDQ_EVENT_MUTEX1_STREAM_EOF>;
 };
 
 od@14023000 {
-- 
2.31.1.527.g47e6f16901-goog

