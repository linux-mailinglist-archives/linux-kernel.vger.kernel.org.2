Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87ACC453D34
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 01:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbhKQAmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 19:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhKQAmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 19:42:10 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21F8C061570;
        Tue, 16 Nov 2021 16:39:12 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id p19so982208qtw.12;
        Tue, 16 Nov 2021 16:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w76EybrnaGtyzuuTmNM/pkrCVBcP2o2Ywq7QeTL4Wj4=;
        b=RfEDaEpM7Q/JbCzUtjePEIyY9JqlYyicN/Lshcteuz3P9tYc5LKAiizOxu9wGkv5zo
         qwhKViIe5PwkpySjmVeI4j8tmCD9ofW9MTxuMbygx5y1B5UCjALQUTBvF+mNMk1KunQ0
         qgTqdvh9Q8K8O/PZZ00ngNxFIYea7D5nY4N/od3PNqTqTj/XV/mCXzh1a5XSNlMo/6ba
         KLTDbJ43dCQ/EdZIEWJTtzrzzmdDEn10wIWjedJyPANe2bHAHLkjExYqniywLA7DfN7X
         VF4sru+3YffMcMxJVbauLgQ04k4i8YtaaUaOeV3FN3x0frVlUlr/R3/jF4rLL7wBQnA9
         jxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w76EybrnaGtyzuuTmNM/pkrCVBcP2o2Ywq7QeTL4Wj4=;
        b=h9VjcxlVoMQVQf/cF+urLwboOSEyriSvAocFP4ZnDShI+1gDW9Rws9y24IJGH1NxAu
         64dsXo205JpL4qi8Dp5XcrwDSQAI/GMJkDyUomLSZZsdDAscBch982Zbutgn8HfrIREy
         V3Fbi5hxbxu7ehb1/y3/reN0j2jUJeGfz52GF/7DST2w/FZmICWpIefnVevAzV3LuOhN
         KyJJ3fP/WZ5wKqx1AhCLrkRjvH6T4SkuZp8Xd7uAKIKcaPb+kSEw5BX1AwUlg5HtHZ9Z
         7S1U2siuCM6itSLUgkbYjRILmNC5cD0/AG6ixdxL7KvqSPHsfvSYMza7SA075UFfXMhQ
         4ysQ==
X-Gm-Message-State: AOAM531uj+9Rx7R+FThk4Emt1dlR3Y1TKTv/reW+JiatfVX8Cnk7kAFo
        o0p8rqFzMTyyLywCwR8Kb84=
X-Google-Smtp-Source: ABdhPJxbeSHNuB4kFTbLxOih9qJ62SSPVRY/aQlqThDRVr2hf19MTW/Jd3fVex7UJYa6VazPT4stxw==
X-Received: by 2002:ac8:7d45:: with SMTP id h5mr12280765qtb.256.1637109552186;
        Tue, 16 Nov 2021 16:39:12 -0800 (PST)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id a38sm8403777qkp.80.2021.11.16.16.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 16:39:11 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
X-Google-Original-From: Liam Beguin <lvb@xiphos.com>
To:     liambeguin@gmail.com,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     Liam Beguin <lvb@xiphos.com>, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/1] dt-bindings: phy: zynqmp-psgtr: fix USB phy name
Date:   Tue, 16 Nov 2021 19:38:41 -0500
Message-Id: <20211117003841.2030813-1-lvb@xiphos.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PHY_TYPE_USB is undefined and was added as PHY_TYPE_USB2 and
PHY_TYPE_USB3 in 2fbbc96d1600 (phy: Add PHY header file for DT x Driver
defines, 2014-11-04). Fix documentation to avoid misleading users.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml b/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
index 04d5654efb38..79906519c652 100644
--- a/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
+++ b/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
@@ -29,7 +29,7 @@ properties:
           - PHY_TYPE_PCIE
           - PHY_TYPE_SATA
           - PHY_TYPE_SGMII
-          - PHY_TYPE_USB
+          - PHY_TYPE_USB3
       - description: The PHY instance
         minimum: 0
         maximum: 1 # for DP, SATA or USB
-- 
2.34.0

