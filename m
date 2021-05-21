Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0099638CE18
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 21:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236750AbhEUTXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 15:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbhEUTXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 15:23:41 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0C0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 12:22:18 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d11so22049031wrw.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 12:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lCvDZboK+sgJocYbp6i5xIDHmRT6b8Yyjq3esu6gxfo=;
        b=KjlQFn31EOeR8uVjczSkSfdI1+2/wSmUgLeUJMZgIwr5OzcG7OMv/nIxc6pDVx0FZK
         tjOxIMTbX/stCi4U5Ettoq39FrFywIaRd2Z0moczt5aKcrJyIikf8Uo39xeJ5nvvqSNP
         S67Id/Ema54u+5vvMuaPi+gjccOxGTMIVpP2WiegE7t39TEpWStXBXGiWDDWpyuZmRqn
         MMogny6eDtr8RKXHLnrkblKER3Cuss3rw8D6IVasO2QAQ56XFE+NEYKFOMaWcjwtgAfQ
         L1Nc+XXyIA4BPvLXoj9qsMtGeHMZNY1tft6B2wKRPjd/ZPoHebtU0TZFA7WxaRf2hNcX
         8x6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lCvDZboK+sgJocYbp6i5xIDHmRT6b8Yyjq3esu6gxfo=;
        b=tnDxLC8tn+vBfqDScBAFv4texbD2nSZd5dPXYjB+h8wB8JCx8FM3th5Z8pmyS0d5Zm
         HBgiHALJ7EHA5GDd85USyOn+Hzes90JngzypvClbr7WFSaSYXxj8OzrKOtVCR6MMCDNG
         VJKisnaZ5krPn13iU+S+DZUtTlVe8KLGei5nd64fLC6bxjQorPCYJpGtDaF7pM7y2u4i
         Hh/q19z8t4bhX1vJbdUpfZ6WjFhHrWNefiyqfUcmwQnBmm1lPqpQDVqO0eW0Bh/Glxq9
         nuFqvzj/QhHclDmGwm3X58bn/5olzbZ3oc1wdV7E1X37TLB9Nz8Nr8Oou9gxZSU/JFcF
         6tUg==
X-Gm-Message-State: AOAM530uxASWROBx6GSEOBQJ3Z7m2QyehSWLjS6RbPKGdK7Ql9BWZvqA
        BgsWlU02z+1oomiwV2I7dHGrTw==
X-Google-Smtp-Source: ABdhPJyha3zUIQVEPgrYCfHfXucNDkaW03LrDb+6HEy0gMi5M3PUND53o9t4gxQxxBnnlC8BxpL1sQ==
X-Received: by 2002:a05:6000:104a:: with SMTP id c10mr11128983wrx.45.1621624936663;
        Fri, 21 May 2021 12:22:16 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id s1sm478760wmj.8.2021.05.21.12.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 12:22:15 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, fabio.estevam@freescale.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] dt-bindings: input: remove fsl-mma8450 which is handled by trivial-devices
Date:   Fri, 21 May 2021 19:22:10 +0000
Message-Id: <20210521192210.12839-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trivial-devices.yaml already provide bindings for fsl-mma8450.
Since input/fsl-mma8450.txt provides no extra value, lets remove it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../devicetree/bindings/input/fsl-mma8450.txt        | 12 ------------
 1 file changed, 12 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/fsl-mma8450.txt

diff --git a/Documentation/devicetree/bindings/input/fsl-mma8450.txt b/Documentation/devicetree/bindings/input/fsl-mma8450.txt
deleted file mode 100644
index 0b96e5737d3a..000000000000
--- a/Documentation/devicetree/bindings/input/fsl-mma8450.txt
+++ /dev/null
@@ -1,12 +0,0 @@
-* Freescale MMA8450 3-Axis Accelerometer
-
-Required properties:
-- compatible : "fsl,mma8450".
-- reg: the I2C address of MMA8450
-
-Example:
-
-accelerometer: mma8450@1c {
-	compatible = "fsl,mma8450";
-	reg = <0x1c>;
-};
-- 
2.26.3

