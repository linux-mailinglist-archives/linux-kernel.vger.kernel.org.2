Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACA3361B72
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 10:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240314AbhDPIJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240258AbhDPIJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:09:11 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED60FC061574;
        Fri, 16 Apr 2021 01:08:46 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u21so40841522ejo.13;
        Fri, 16 Apr 2021 01:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zVybsMqluNO9BMi2O3k2e3fLGvOiZiUgtpoVSgohbLY=;
        b=NruGJMfRRR9+uo24Pjx457WHq7jjzMasM0MlC8BdZFCl0ra06oMFTnbdl2+2I4xZng
         /o0Grrc1ZHWjK7QqQuYSuUY+OOCVSdjcGJWwc2zmXv6iQwuCJeToE3CJRsSEyd/+K59d
         NvOzzfwMnmNcddkshVNV25XIYSLbVnIdNuCHhzRLSX9cQEe++xTMRy5GeWr7ym0fzhi1
         TEhvHMo/eCPOObUsm44741zt39/NizORnrBCnM1EvbeTuCWgkja0KmcJPWhyrCvMOKIU
         5FNptgfEySKeIDeSjW132ULiSZ+Df03jzPZAD66a5NSsKedDFnmbcIv5wqh0B+d4P5nj
         3ntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zVybsMqluNO9BMi2O3k2e3fLGvOiZiUgtpoVSgohbLY=;
        b=llKhAF0M0/DHbm6q78e5/N/42fzMc7ICW2kH39GPpunNLW5jdLwnnc5ls9VM4Q3AoV
         TviqbGsEipqADCOSfYOR2zG4L/eF2dot8Ww3thJyLkbYueyBpSVq/ElQfoKMFd9JbIhc
         wiCYwN/Yt/glx3TEc7rxqxxrZOzATLPHgwPXUl37wTbv+4jNYFsRVvmy9g4J/nTJTHls
         MqvBFwqf3kO5CO5KLdSiUIzxuHlQtgsKQuCNJVNuQX0a6yErZ7dEsRUYHRLKBl+5ZXhw
         rycni6SDsq0aP6BJWpHHiS9txcm98OnE19Spovq2ZQaNE7aumqzEVKgwhnQ+wMQ8JQp8
         m6QA==
X-Gm-Message-State: AOAM532gNKhPl/58dXiKyY9SK9scw+gc3H/3YaI4np7beQEvVxVyayVa
        FaFDDZ3Ku0fe4xwbo8uifUA=
X-Google-Smtp-Source: ABdhPJz0D6IJN+Gy5h6PgPncZDg3EDz4COvNCL/A0zcsQgOCE5Gvcm7J4cnWzpuBFZMcRkmpj9e01g==
X-Received: by 2002:a17:906:95cb:: with SMTP id n11mr7413708ejy.251.1618560525791;
        Fri, 16 Apr 2021 01:08:45 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q16sm4672303edv.61.2021.04.16.01.08.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Apr 2021 01:08:45 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 14/15] dt-bindings: power: rockchip: Add bindings for RK3568 Soc
Date:   Fri, 16 Apr 2021 10:03:41 +0200
Message-Id: <20210416080342.18614-15-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210416080342.18614-1-jbx6244@gmail.com>
References: <20210416080342.18614-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elaine Zhang <zhangqing@rock-chips.com>

Add the compatible string for RK3568 SoC.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
A note for rob+dt and others:
  A review and ack tag was not added, because in this version
  the schema layout changed a bit
Please have a look at it again

Changed V8:
  Add pd-node ref schema
---
 Documentation/devicetree/bindings/power/rockchip,power-controller.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
index 2b9950fd6..24eb00834 100644
--- a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
@@ -40,6 +40,7 @@ properties:
       - rockchip,rk3366-power-controller
       - rockchip,rk3368-power-controller
       - rockchip,rk3399-power-controller
+      - rockchip,rk3568-power-controller
 
   "#power-domain-cells":
     const: 1
@@ -135,6 +136,7 @@ definitions:
           "include/dt-bindings/power/rk3366-power.h"
           "include/dt-bindings/power/rk3368-power.h"
           "include/dt-bindings/power/rk3399-power.h"
+          "include/dt-bindings/power/rk3568-power.h"
 
       clocks:
         minItems: 1
-- 
2.11.0

