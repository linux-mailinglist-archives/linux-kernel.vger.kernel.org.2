Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F0A3570AA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353685AbhDGPoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:44:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46134 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353712AbhDGPoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:44:12 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lUALZ-0008I1-Fl
        for linux-kernel@vger.kernel.org; Wed, 07 Apr 2021 15:44:01 +0000
Received: by mail-wr1-f69.google.com with SMTP id t2so3926683wrr.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 08:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JyWeMjI4x/EwxkwT3CxdyKhwEUnSI84WCRjnEDLdno8=;
        b=qwS9NT+qklJVPaAXTbKsql8Bnn46q4cIfl18G6Tcq+ng2KxxnEOSFhdp0peaOWGOry
         1UwOFVia8jpnyRss0KT5EBmhY4RqA3EkVjv1zsKjkvjkhiGBD3HqLKqscnCQ7qT6Ol6f
         UVDKRnzZLMC1EnL0RP9byPETNVRb/7bnEpRa+fi7flAbgpvxvZY1/wXXo26esITSLe47
         gxcgBH36Njh+zP+Ya5mciwgzPwYbt7NqBITFAOD5/Gpl0T4MxNaMtzlhGLylZX6Kya5M
         ceyH3zV4m4UXiEC6YQf6XiVJ4MLO1kuA2skPP+p1yAx6MWSqr2Gvo22GHpR+/uw9FpDM
         a6sg==
X-Gm-Message-State: AOAM530s5arLKLV4CBvH4t//3jPW7gXAkewYdcwIF6h7ZJmbdbQtJGFl
        Aio4f21/8rvgU0oPdFpqMLfx7hfBH9UlR5BBeAHzmM+WG/Oe6jonu0oObLxHWUW4fTUxsfmJ/ye
        l00jP+UqGhmmG6onvEaFI8Fs0+Ai+zbSGZojLEzbR1Q==
X-Received: by 2002:a1c:7515:: with SMTP id o21mr3701307wmc.90.1617810240837;
        Wed, 07 Apr 2021 08:44:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJznTljTOjyBN+pQ4Miw6twsAAOpwdC8oz1va3+AaBwVdBo3VZu7aGuyraYQuCHSO0xTLJKQ==
X-Received: by 2002:a1c:7515:: with SMTP id o21mr3701300wmc.90.1617810240726;
        Wed, 07 Apr 2021 08:44:00 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id a11sm2010376wrv.21.2021.04.07.08.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 08:44:00 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] memory: renesas-rpc-if: fix possible NULL pointer dereference of resource
Date:   Wed,  7 Apr 2021 17:43:57 +0200
Message-Id: <20210407154357.70200-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform_get_resource_byname() can return NULL which would be
immediately dereferenced by resource_size().  Instead dereference it
after validating the resource.

Addresses-Coverity: Dereference null return value
Fixes: ca7d8b980b67 ("memory: add Renesas RPC-IF driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/memory/renesas-rpc-if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 8d36e221def1..45eed659b0c6 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -192,10 +192,10 @@ int rpcif_sw_init(struct rpcif *rpc, struct device *dev)
 	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dirmap");
-	rpc->size = resource_size(res);
 	rpc->dirmap = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(rpc->dirmap))
 		rpc->dirmap = NULL;
+	rpc->size = resource_size(res);
 
 	rpc->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 
-- 
2.25.1

