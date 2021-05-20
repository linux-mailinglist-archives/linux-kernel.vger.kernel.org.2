Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD8A38AE0C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhETMXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbhETMXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:23:08 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D455DC09F5F6
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 04:17:04 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id z19-20020a7bc7d30000b029017521c1fb75so5197007wmk.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 04:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FFbC/8AD0LOFNwNu9BRgUtFruC/G1IwePtG3av6RsOY=;
        b=k1LNclxtiP6W7x7zqryjIF2j1zX5LVI89E2F+ZC0OosAJK+edKHkMljCHDcNA4W6r9
         oo4eZKxNjGjNVEJ8BFhLlpoqnPMwuEiPyWw0EOz4IxxVlKUgsrlswX/caR97z6QS70oV
         NZ3/faNHyMCstTucEuXIupFp8etwQE4J3yqi0J69jZcU0Mx7BKVpa2T7q24WhNiKWtvb
         PU5LpeN250fH9rB8YtK5Dy/MNYmxcDZJKb5GKWG8MkZ5EEWxsJ6BFLPncstIQhXlrfUP
         vHUQIPzmn+0TEAFURxP+OL/A4Cij2M4dnT2BPNlHbT0nR+8xyCyGrpl/dPtQmw2IqIcV
         nkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FFbC/8AD0LOFNwNu9BRgUtFruC/G1IwePtG3av6RsOY=;
        b=hCjjXhFsNP/KR0jksety2TC2wJZr4C2ZKDtMRx4PlZlnzLI8igAq2A4olhC9EQDHES
         7G9f6+yyjjJipJBD8u5yByeU05ADeg+ct37B8QxFBTTUONAm9ZIVoG7JPGKUm4qX7CyZ
         mzxycIKFRgLR4M27LSC8LmCd4NO6+cEnDf2NeXR8UqTARrQVxYzeO7TgCqIaMC7M39PL
         3bw1XOHC9sHZn63sD5vnZOb86k95U5aKrZEZcadtlW/yBVu+PkqDI2VyQia7hQNatSLk
         fUiz79caSO+70I63LV+hANdrJWgQ3jtUVGTLIEDH996NC5PTk+FJhBDlF9eoI41rGmhW
         YJFg==
X-Gm-Message-State: AOAM5338lD2UzzJE4Ywv3/zqr15wSERsVwIrumcJOrpsXFXYu1bMPl8e
        kON7cQAAHk9tqkwIgSUHdjzOkA==
X-Google-Smtp-Source: ABdhPJy170kk8Q53GOuLn6l2Mf+w5xTtNMkRzkP4oBTF3ZetnMbI5rV9xgKJjjvpwPsSs4pLxpDMAw==
X-Received: by 2002:a1c:4d01:: with SMTP id o1mr3222583wmh.42.1621509423424;
        Thu, 20 May 2021 04:17:03 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id a19sm2310757wmb.40.2021.05.20.04.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 04:17:02 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     mkorpershoek@baylibre.com, Fabien Parent <fparent@baylibre.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: rng: mediatek: add mt8365 to mtk rng binding
Date:   Thu, 20 May 2021 13:16:56 +0200
Message-Id: <20210520111656.66017-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520111656.66017-1-fparent@baylibre.com>
References: <20210520111656.66017-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RNG binding for MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

v2: Write the compatible in a more compact way

 Documentation/devicetree/bindings/rng/mtk-rng.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/rng/mtk-rng.yaml b/Documentation/devicetree/bindings/rng/mtk-rng.yaml
index 4be5fc3c1409..61888e07bda0 100644
--- a/Documentation/devicetree/bindings/rng/mtk-rng.yaml
+++ b/Documentation/devicetree/bindings/rng/mtk-rng.yaml
@@ -21,6 +21,7 @@ properties:
           - enum:
               - mediatek,mt7622-rng
               - mediatek,mt7629-rng
+              - mediatek,mt8365-rng
               - mediatek,mt8516-rng
           - const: mediatek,mt7623-rng
 
-- 
2.31.1

