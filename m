Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1924435FD30
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 23:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbhDNVUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 17:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbhDNVTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 17:19:40 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7405BC06175F;
        Wed, 14 Apr 2021 14:19:17 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n2so33541563ejy.7;
        Wed, 14 Apr 2021 14:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F5YnMoeI4BcqVYscCNU5u7SkDX5pKXOy3KyGP8x/t/A=;
        b=lNSPar5egpCWY5E30O3i3AkiiAUErI3Poip/WYYWLcbrildCK2fZdNdcHP+E2KXLIY
         8121w0dh73BmCOJ8Ckdt9PbEz1fIu0PCNAPO81ikW3NJ+MHExM/C+BJZlezpxiWErlcf
         eJst4YCl0lTjlHel5W4TDD7QyrLxivJJikZXczm5irx2/45i34gNJ5BiPf0mllnm4zXd
         o3fT/Bq4Qdth/dtUwO/TMUf41BzFq78H+4vCXLoQUwh37Q9bHBfIK8cqwJqGcbf4adZ+
         nnuxDMroyn/DXItVXIr+IDM/lNppRg1qt7XwUFekgtOZTNPstAMRMJhbtlmtXak/nwFV
         YTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F5YnMoeI4BcqVYscCNU5u7SkDX5pKXOy3KyGP8x/t/A=;
        b=Jhq6db2gPZhVYBmPEQUK6VzCPy9N8gYxcJPBABHeX9tEQSJkZF6Uo2TJBDu/myntGc
         uBvQQmegZhk7qZhtk6qWvtVYnKByTe9zD5rhyaPLpkZfX4ogiRePBoTunw9aVpvYLWgh
         NJcSRCHFZgyXxYmRypf9M5c2AasODzfY4B4w5w833Yc9mhHs+QKnfiebwHtJe9g/BLRY
         we8m2uLQeJ6rcb3QAGrqk/55RWqMI78iJZxZkzBeq/F7fMli2crD3dKQi/uIXViHy+bF
         o2Z1d2nXd/VpqPtfe42/8W2myZiT9d3gRBvXcnS+zQQbGTXkbRPaBihXVByd1r2yWc3N
         PhZQ==
X-Gm-Message-State: AOAM532gzHl07S1yeq0vdU/bc3K+11X1xNhOjrAY2QDCguFUFulQ2a1c
        7QGGBvi1R0rTzRHV2PEB+dk=
X-Google-Smtp-Source: ABdhPJyTYkUEW+WE558pCNRKo8Gg+nj8vJqjRZ6gWh4Gu1rp6xiUeJkUyVaoyzFsCL3LUh+dTg/0ow==
X-Received: by 2002:a17:906:f56:: with SMTP id h22mr80129ejj.494.1618435156208;
        Wed, 14 Apr 2021 14:19:16 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id v5sm568222edx.87.2021.04.14.14.19.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Apr 2021 14:19:16 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 10/11] dt-bindings: power: rockchip: Add bindings for RK3568 Soc
Date:   Wed, 14 Apr 2021 23:18:55 +0200
Message-Id: <20210414211856.12104-11-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210414211856.12104-1-jbx6244@gmail.com>
References: <20210414211856.12104-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elaine Zhang <zhangqing@rock-chips.com>

Add the compatible string for RK3568 SoC.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/power/rockchip,power-controller.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
index 934308006..1354f1dc0 100644
--- a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
@@ -37,6 +37,7 @@ properties:
       - rockchip,rk3366-power-controller
       - rockchip,rk3368-power-controller
       - rockchip,rk3399-power-controller
+      - rockchip,rk3568-power-controller
 
   "#power-domain-cells":
     const: 1
@@ -82,6 +83,7 @@ patternProperties:
           "include/dt-bindings/power/rk3366-power.h"
           "include/dt-bindings/power/rk3368-power.h"
           "include/dt-bindings/power/rk3399-power.h"
+          "include/dt-bindings/power/rk3568-power.h"
 
       clocks:
         description: |
-- 
2.11.0

