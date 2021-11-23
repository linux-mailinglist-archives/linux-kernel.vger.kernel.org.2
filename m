Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0BC45A14A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 12:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbhKWLYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 06:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236028AbhKWLY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 06:24:26 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0192C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 03:21:15 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id m15so18002328pgu.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 03:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z+/tM6AGO8qVa/0Ves95KRNhzSUdOxRaqnGgKB5D++M=;
        b=XpXqNAebRwgXhworSNtt028SsP5KTorBtVnPQ2NDJ5AqE0w8IT8BOg6T3ewnDOxn0x
         QaNyBlTudA5wA6HUsP3tTtdlTWjvrE8GuQPbTwT1fW+w1gEOlQN/lkvuxJNQ4SJKqEYn
         we3ePUFjfo44/HkRFeRMoGLKvp+vx0wcGlvTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z+/tM6AGO8qVa/0Ves95KRNhzSUdOxRaqnGgKB5D++M=;
        b=wiU3t3cE2hZrUvjSEUB7GOAoUC1mUxLmwADVImMUzNxIJQhSos2CypXClbj8cW93eH
         oKsmBkzThKiJy55QjRzbGLLG+tDAy3nBFrQ41mTnxVTBnhRBbnS/ako8kWN+ncwTNfoS
         OQL2zCYUWywMXLS62ZwDMi/EtcUv6CyYuayvD1OZMjfVNwARB4fZjhmmhFNlxsRkVCqY
         QfqkIEnMN5a353PqyRzg8LzkTvArJWqBMk0YmuqqELgcBiBro2c2NWnTQ0IdEEmMJmci
         RVenHWtmEld6WzujAo/JKjfXyw41MZaEB1YSiRty2Lnlpdb214ya5aV2F4taZTQSGiHK
         zFHA==
X-Gm-Message-State: AOAM532hi/jVoLkaj2AJ+5SUz2e0yvdWDrxSnZ1D7g2xElPxN2jdtt8S
        2xwQESdYk3WOrQ4J4C3eHpwv0CxAPTHOFw==
X-Google-Smtp-Source: ABdhPJxETkQVjZ/TElThsyh1V0RdLsnWog1QFLXL9SdSSg23n2Tff5mZqtPLZT8Oh2DPEEUzXXmy1w==
X-Received: by 2002:a63:f64:: with SMTP id 36mr3117696pgp.464.1637666475417;
        Tue, 23 Nov 2021 03:21:15 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:d1ae:c331:ed2a:15e9])
        by smtp.gmail.com with ESMTPSA id 63sm11093914pfz.119.2021.11.23.03.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 03:21:15 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        - <devicetree-spec@vger.kernel.org>, devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, senozhatsky@chromium.org,
        tfiga@chromium.org
Subject: [PATCH 2/3] dt-bindings: Add io-tlb-segsize property for restricted-dma-pool
Date:   Tue, 23 Nov 2021 19:21:03 +0800
Message-Id: <20211123112104.3530135-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
In-Reply-To: <20211123112104.3530135-1-hsinyi@chromium.org>
References: <20211123112104.3530135-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a io-tlb-segsize property that each restricted-dma-pool can set its
own io_tlb_segsize since some use cases require slabs larger than default
value (128).

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 .../bindings/reserved-memory/shared-dma-pool.yaml         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml b/Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml
index a4bf757d6881de..6198bf6b76f0b2 100644
--- a/Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml
+++ b/Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml
@@ -56,6 +56,14 @@ properties:
       If this property is present, then Linux will use the region for
       the default pool of the consistent DMA allocator.
 
+  io-tlb-segsize:
+    type: u32
+    description: >
+      Each restricted-dma-pool can use this property to set its own
+      io_tlb_segsize. If not set, it will use the default value
+      IO_TLB_SEGSIZE defined in include/linux/swiotlb.h. The value has
+      to be a power of 2, otherwise it will fall back to IO_TLB_SEGSIZE.
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.0.rc2.393.gf8c9666880-goog

