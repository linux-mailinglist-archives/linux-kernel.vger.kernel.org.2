Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8442362F9B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 13:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236401AbhDQLb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 07:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbhDQLas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 07:30:48 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0870C061761;
        Sat, 17 Apr 2021 04:30:21 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id l4so45804052ejc.10;
        Sat, 17 Apr 2021 04:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WpY6qaVVbiXXNlFP7xWIKSLPQ4/30CArlxUBPJObKKU=;
        b=sjmEiYPvwk8+WgblZL1E8/PrigzmiV4oUkY6MoFgJYa39jFWdOK0v+/SKji0B386/7
         N8IW90BLm6FPEVZOWL5Rja7rmeWMhZPT+Y13+yGjrIqUCBwta1y6zsjf+18IUy6SuNHi
         tQWMcAPLsjVWGnoP565x8yN4jwNYCqUvtbjbyi2IyrXG3ACyOIz41AMQl8sNxsSTYFk9
         QnAkBUHoaBJF4nbsjqns6bC2/7/98qmHjOwijIW6SvpHvqoGMiPfGJdm8VlDSULspqPN
         Qsyue7l+nG1DGbwSUZ3KbGMSxV7mzxROq4vK1K8Kc/BO8FKTnNCXsQeO64NkrurAnL4+
         lUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WpY6qaVVbiXXNlFP7xWIKSLPQ4/30CArlxUBPJObKKU=;
        b=mPo0GO04H05LLDKUQU/kHhSKUPBPjX8rQq7QeU1J1EwIWXrZNox5zdTQ87Ghd7MBgn
         8oWWLlaV4pCY9DTi4O6Q9gRjn3vMb86gPk++fNQEQOEQ35uzkOz5bqOF6mqYkOEcIY30
         cP3Nc2DSbPuy8/nTM9WnWbCKMjPUceL5N8hgv/+CFJJ/clma9XgONkJ6JPg2NYTVduol
         N0qE1X3NSoRopwZIOPe9HdLkzLv5z9PEknYuBZ7YTjLxKoZkXYvj6X9iRgG4Ohs/JXAO
         KMU0Ub+/+lzicqFCNHArnF1XtGR5sCefURVziLTFG1g1Xn12e05oNhbMRExRJbDxNsck
         ERCw==
X-Gm-Message-State: AOAM5303M2YtB4pwzMCprLRhT8Qj/StlvCtLKeCot1TEYZCYpjes8iOH
        FyK9Vq12jJ2F3+vQoDc8bwY=
X-Google-Smtp-Source: ABdhPJx9so2DJWJkXpaaza7EcdenoKizJJmiylh9P3u2FqaiZqNuaZGYX9tg5CeMB49SJcrpCDphZA==
X-Received: by 2002:a17:906:b0cd:: with SMTP id bk13mr7525557ejb.184.1618659020603;
        Sat, 17 Apr 2021 04:30:20 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f20sm3022875ejw.36.2021.04.17.04.30.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Apr 2021 04:30:20 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 14/15] dt-bindings: power: rockchip: Add bindings for RK3568 Soc
Date:   Sat, 17 Apr 2021 13:29:51 +0200
Message-Id: <20210417112952.8516-15-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210417112952.8516-1-jbx6244@gmail.com>
References: <20210417112952.8516-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elaine Zhang <zhangqing@rock-chips.com>

Add the compatible string for RK3568 SoC.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changed V8:
  Add pd-node ref schema
---
 Documentation/devicetree/bindings/power/rockchip,power-controller.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
index f71569de9..9b9d71087 100644
--- a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
@@ -40,6 +40,7 @@ properties:
       - rockchip,rk3366-power-controller
       - rockchip,rk3368-power-controller
       - rockchip,rk3399-power-controller
+      - rockchip,rk3568-power-controller
 
   "#power-domain-cells":
     const: 1
@@ -117,6 +118,7 @@ $defs:
           "include/dt-bindings/power/rk3366-power.h"
           "include/dt-bindings/power/rk3368-power.h"
           "include/dt-bindings/power/rk3399-power.h"
+          "include/dt-bindings/power/rk3568-power.h"
 
       clocks:
         minItems: 1
-- 
2.11.0

