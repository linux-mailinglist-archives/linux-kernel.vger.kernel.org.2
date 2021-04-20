Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154CD3651A6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 06:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhDTEyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 00:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhDTEyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 00:54:50 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A1CC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 21:54:20 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id e13so28376102qkl.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 21:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=knEsnqVVpHBAjh8i95W10HK2zNEcEEQ59QU8Kyx/Vek=;
        b=bq2FqkoqFeOqQJDjYkFKExA6zH8OpGUykxjhtJTGayymtQoErLUJeDmJs6EZ/rNSs0
         ndAnArkadebgcSDRHxAknJxszrFhVcvkzaXQfDMxbYGSNXNCXouNBUJ3a/XMvXgSpK0M
         W2lEIcAGeetVj2JZkpxgGTxUQqiTJFqwG1Otde4GWCKdvcp2LbN3DcmQMUyC8pszxcfo
         WwSA46Cy3r9KdLqPaCkwthNlajAATRD0lDadB92WDtRFZY0zkotr+LBRqIm6ZS+UL+wW
         Ea8ZRsd5tZchDCYfRRrWT9ojV9J2CmO8S1op2ysGbDZegRIhYpmhVNdqc6HXK9+cofjr
         K7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=knEsnqVVpHBAjh8i95W10HK2zNEcEEQ59QU8Kyx/Vek=;
        b=dAHvfp0daEIAH7QMxLr0RUWHLhOQsPWPjydfE2Vw7oti/Ecp8p6L+RQYou2BYgjXfu
         n8GB+FQRhbz+4+Rs9qoR/y0hgfIPCdLNa0FiuCdvNGbhlBgC2OTXM/2WG+tDB8oTPzWp
         xHYYSu15pT2ojRdSNYDHs2QD9CadK6KBdhGgW4XMzp2KAlooD7CSW7Fa2IGAlQZ7lXv0
         eAPyQxx7Z4tLx37DlrBNVjCnSnLjTgtcXNfmDP6w40bbuEg5w3iAgWfrKpjro+AmxDc6
         DV+8keQVi6vyqjLUi5xB1VF2gATIzxpP9cb0j0CnHp8QYNjZG+o1zbZwZnj4u+tuFhNi
         cP8w==
X-Gm-Message-State: AOAM531ijTPNT/ZccXMxkY1dthDBZPIW2GXA2JA3xD6nfarmKVvkroad
        vn8+bVCUEZlltt1pGggwja0=
X-Google-Smtp-Source: ABdhPJyoJY8zIXqIQ542ji0NV7LsWtIE3/ZDBBL5Hhcs46ZrQzz7kOr/MoUgzDkXTMF4fQVLUhNWFA==
X-Received: by 2002:ae9:e912:: with SMTP id x18mr15662415qkf.315.1618894459007;
        Mon, 19 Apr 2021 21:54:19 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com ([177.35.200.187])
        by smtp.gmail.com with ESMTPSA id y29sm10930176qtm.13.2021.04.19.21.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 21:54:18 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] powerpc/pseries/iommu: Fix window size for direct mapping with pmem
Date:   Tue, 20 Apr 2021 01:54:04 -0300
Message-Id: <20210420045404.438735-1-leobras.c@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of today, if the DDW is big enough to fit (1 << MAX_PHYSMEM_BITS) it's
possible to use direct DMA mapping even with pmem region.

But, if that happens, the window size (len) is set to
(MAX_PHYSMEM_BITS - page_shift) instead of MAX_PHYSMEM_BITS, causing a
pagesize times smaller DDW to be created, being insufficient for correct
usage.

Fix this so the correct window size is used in this case.

Fixes: bf6e2d562bbc4("powerpc/dma: Fallback to dma_ops when persistent memory present")
Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 9fc5217f0c8e..836cbbe0ecc5 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -1229,7 +1229,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	if (pmem_present) {
 		if (query.largest_available_block >=
 		    (1ULL << (MAX_PHYSMEM_BITS - page_shift)))
-			len = MAX_PHYSMEM_BITS - page_shift;
+			len = MAX_PHYSMEM_BITS;
 		else
 			dev_info(&dev->dev, "Skipping ibm,pmemory");
 	}
-- 
2.30.2

