Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E3E3F9326
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 05:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244221AbhH0Ds5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 23:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244186AbhH0Ds4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 23:48:56 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF60FC061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 20:48:08 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id f11-20020a17090aa78b00b0018e98a7cddaso3886856pjq.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 20:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mwgFztDtwTJnE/yw2MlhgDLCRshM3rrgSK7jP9bPyDk=;
        b=JKJaqTNaN7ys6o9vZAB/73qE7kofzEn01XTAPOtpcG8S04hoOX7CG0ntNhJeCLUT03
         qFbV128vLfY5ysenR09gk/FmaU6vTQD4WZjpIYObTx/1xCXIvL/6hJRh+nr0/bqEwfN0
         zIseV9kW3JIsKAuSdmMBQtcZX1ZqlFoefKmss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mwgFztDtwTJnE/yw2MlhgDLCRshM3rrgSK7jP9bPyDk=;
        b=MGJq9v4HluoksFHjRJf+RM3NX56Kj9S5fQwY+XQKTFE0y+6B6ldBCtbrrmk3/godKr
         LQfmT+eQ015UhwYlIsniRdgWhWmJ6E5Qxzyt8xr3Zb0HghyDAmUgMOsuLfP9btnQDyx2
         oSsUKIhzHX8/jt8csLiNob6ofl3nSgeeSx/AYWtKAy99fBru8GX+cHtlNjk51rqL7NgZ
         4/AYcoHOBv2anmAiLNmXLZu1si6kQ5S+/Wm5NId4zpSd1iLPThjabjkSia6k9SRYUsmo
         XMaMpBkHi/VCuCR2NGFhG1J+W9r6mCVnEMRWOMz7oblsAfTwIIpzuXByXH56eBzkjJy/
         R91A==
X-Gm-Message-State: AOAM532N6pCg5vVfK1IzyGwLoCoqJirb8Tl5stVJaKKwsH12vnjyEIpz
        TyfNDq8WzXBX2/2TV8ojE0r59A==
X-Google-Smtp-Source: ABdhPJw9t3/HJ94d/WJL9NBeKyLqg/WTO7DspIt2BocohxNh8ne/OwfXYZCdpaZtALwaKVlxjjk/sw==
X-Received: by 2002:a17:90a:428c:: with SMTP id p12mr8432682pjg.193.1630036088218;
        Thu, 26 Aug 2021 20:48:08 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:fa09:1580:9bf2:4c0a])
        by smtp.gmail.com with UTF8SMTPSA id 15sm392254pjw.39.2021.08.26.20.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 20:48:07 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        konrad.wilk@oracle.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, Claire Chang <tientzu@chromium.org>
Subject: [PATCH] swiotlb: use depends on for DMA_RESTRICTED_POOL
Date:   Fri, 27 Aug 2021 11:48:02 +0800
Message-Id: <20210827034802.1065294-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use depends on instead of select for DMA_RESTRICTED_POOL; otherwise it
will make SWIOTLB user configurable and cause compile errors for some
arch (e.g. mips).

Fixes: 0b84e4f8b793 ("swiotlb: Add restricted DMA pool initialization")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 kernel/dma/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index fd4db714d86b..1b02179758cb 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -82,8 +82,7 @@ config SWIOTLB
 
 config DMA_RESTRICTED_POOL
 	bool "DMA Restricted Pool"
-	depends on OF && OF_RESERVED_MEM
-	select SWIOTLB
+	depends on OF && OF_RESERVED_MEM && SWIOTLB
 	help
 	  This enables support for restricted DMA pools which provide a level of
 	  DMA memory protection on systems with limited hardware protection
-- 
2.33.0.259.gc128427fd7-goog

