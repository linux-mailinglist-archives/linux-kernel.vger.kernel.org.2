Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B0D4310B4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 08:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhJRGma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 02:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhJRGm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 02:42:29 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAD4C061745
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 23:40:18 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 5so36393902edw.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 23:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5/7hBCmpfW9MTjUXgrKdtGWjkgtU8/we8OWRfC8+kMU=;
        b=jGCiFWIozFtWDE1T+9nxnGqjF2A1pX0+KZyJP2RLpI1vI6tRTql9ktYE+xvnk/+nVT
         i54qqTOQ8UiOV/6Djx6Ye/m4JtiqqiamvXTRLztf9jzVUnpfGpV1Ws/rwnWQb7B4yxKB
         o4sjyaGPbV8qTNWy0JTp9g9vY4Tfg0cPTepWFBmMcluYYGabrGcUAkxIRSGLfWis0DfA
         mtNNqgM6xE+fU9Q1IuONkj74QTkmrfagz4ASHP086615rpO9S1SwknxKofRDQieBsKgh
         H6Uq1xO14mKNaLR1Zshuql0Tyh8a1C3QmyYImRYCZkn02zfFbSKqndXljCavVNIqwSIj
         mP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=5/7hBCmpfW9MTjUXgrKdtGWjkgtU8/we8OWRfC8+kMU=;
        b=oXBeN6dcbPWdiQbVS3W5FjJud4NrUGnRDQ9N70cbiFuVjVaMgD2ZUoTsntGXOWtAsa
         W7FhHxBx5ddqkGS17Dk9fr270YzKj5emF+hsi6Yo3MH2YeGJMr47N3LQd3oNCxIu0wbX
         br9F5vv+1JVRKCjOP9DTK5D/9ATFuEyeB9nS9lZlA+t5PzXKQZxE1vprJ/MQNP7Fino4
         Zw5B8/de7blvUvs3CC+QVmma98BiDBMUMwQs1CrrVORHbMcx8HXWlLF9bbD35zZxPCcb
         FCxHnUzJ8dsCaOW2h0Qxy6qh4moJJqZV1tQEBGNn1fwQ7iViVoU7wM8QA+uAZKZqsPQT
         iEAw==
X-Gm-Message-State: AOAM5300lUiV+JChCew7r4HG5j7SYBIEOQJ43UKokcEiRW0oUeG2qZDL
        TEwCG+62A9E0x/5SEXT+sRGvkCazj0/IXQ==
X-Google-Smtp-Source: ABdhPJwpfA0BoEQhv6pd4Op8P97mbX7msngKe6mKU3AEA7gl3+/5yuT20iGp771CluTA50hpKXe3qw==
X-Received: by 2002:a17:906:6bce:: with SMTP id t14mr27276140ejs.546.1634539216960;
        Sun, 17 Oct 2021 23:40:16 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id j22sm8253013ejt.11.2021.10.17.23.40.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Oct 2021 23:40:16 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: display: xilinx: Fix example with psgtr
Date:   Mon, 18 Oct 2021 08:40:12 +0200
Message-Id: <a291be294dea6e580ad9acd436742a48b7cd00a2.1634539210.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit cea0f76a483d ("dt-bindings: phy: Add DT bindings for Xilinx ZynqMP
PSGTR PHY") clearly defines #phy-cells as 4. In past 5 cells were used by
it never went to upstream. That's why fix example by using only 4 cells
instead of 5.

Fixes: e7c7970a678d ("dt-bindings: display: xlnx: Add ZynqMP DP subsystem bindings")
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 .../devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml   | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml b/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml
index d88bd93f4b80..10ec78ca1c65 100644
--- a/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml
+++ b/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml
@@ -160,8 +160,8 @@ examples:
                <&xlnx_dpdma 2>,
                <&xlnx_dpdma 3>;
 
-        phys = <&psgtr 1 PHY_TYPE_DP 0 3 27000000>,
-               <&psgtr 0 PHY_TYPE_DP 1 3 27000000>;
+        phys = <&psgtr 1 PHY_TYPE_DP 0 3>,
+               <&psgtr 0 PHY_TYPE_DP 1 3>;
 
         phy-names = "dp-phy0", "dp-phy1";
     };
-- 
2.33.1

