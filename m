Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C14340C18
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhCRRqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbhCRRpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:45:51 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4A6C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:45:50 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id 94so4749624qtc.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eEthMhsVtKGTUyiAbeT/3DmcKa1q9L+Bg4NZOlr+SGA=;
        b=fDe73JUDydWWuzSreL/N3PtoZ9EbDr3/HtYRiSXJW57kHFqCr+OpHINmD23kkC8XZq
         QLszDkWqJNe/Qxo3RkoyWmLzVy2HmeMOc2qRAtmW6ba2EJP0btQJGYVUAOYTmDCvtYZB
         118gkXkoHoLAltaICS249Pzx9rhWM9usf1i3vwpPDz9oPr/UMsktITb8SntC85INpjiV
         +1uRwCUymnAApJvzTescfH2LpCojK50JnOidH1xoVURJXhMX82SETTaqY6vGIRxwbAsh
         vnsAmP0PrVT17OAFTgcvH0N5ADWceFaJY8ZxOr2vHSlEftu6jClDj0xY2ViRJD58rQ6O
         RTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eEthMhsVtKGTUyiAbeT/3DmcKa1q9L+Bg4NZOlr+SGA=;
        b=Me/xjB5eVIdaIKHdld/GGHk/QdgRNmJWyj7rr03O9TulwaQvv2f1+In1m7pYub4VZN
         EiCMAJDEh9y6JpQBF4HtqmcTRnn0znuau8reiE8WAopIq2TVbbdl1CQW3WkmB1SgMFSc
         wHFkbNrUYup8AVPr6OAb/hjyDEtt6LTsetSFz70noE9eFNpy+ocsF2UOMaAwGtVGvot0
         xGyAFhjVNMudyk+QeLPp8OqGqV+AR5NFtTU7hoTB5gJGouIbwKfVRZ/R9emHpUszMzl/
         LOAQXexXdSpikYncWihsvmVQf6Aakh8AbZ9ZQ9Gmq6IwdOw8bs96RQhBKXks1DI3rTj5
         BqtA==
X-Gm-Message-State: AOAM532LXF/Isej+hnjzBnHVb5IW8BBax4zjgV2JTM8jECRIJfsa1uwA
        OWqs1KsuRSnIMJG/TNLIKhA=
X-Google-Smtp-Source: ABdhPJzhkEyuUIjDSySV0uHjJqruUAB+zTPe1r0ANE0b5DNVCHXfg3ycsWq7RLBPShrObGQxF/t/fA==
X-Received: by 2002:a05:622a:216:: with SMTP id b22mr4822014qtx.263.1616089550116;
        Thu, 18 Mar 2021 10:45:50 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com (179-125-249-210.dynamic.desktop.com.br. [179.125.249.210])
        by smtp.gmail.com with ESMTPSA id p8sm1940785qtu.8.2021.03.18.10.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 10:45:49 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] powerpc/kernel/iommu: Use largepool as a last resort when !largealloc
Date:   Thu, 18 Mar 2021 14:44:17 -0300
Message-Id: <20210318174414.684630-2-leobras.c@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210318174414.684630-1-leobras.c@gmail.com>
References: <20210318174414.684630-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of today, doing iommu_range_alloc() only for !largealloc (npages <= 15)
will only be able to use 3/4 of the available pages, given pages on
largepool  not being available for !largealloc.

This could mean some drivers not being able to fully use all the available
pages for the DMA window.

Add pages on largepool as a last resort for !largealloc, making all pages
of the DMA window available.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kernel/iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 3329ef045805..ae6ad8dca605 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -255,6 +255,15 @@ static unsigned long iommu_range_alloc(struct device *dev,
 			pass++;
 			goto again;
 
+		} else if (pass == tbl->nr_pools + 1) {
+			/* Last resort: try largepool */
+			spin_unlock(&pool->lock);
+			pool = &tbl->large_pool;
+			spin_lock(&pool->lock);
+			pool->hint = pool->start;
+			pass++;
+			goto again;
+
 		} else {
 			/* Give up */
 			spin_unlock_irqrestore(&(pool->lock), flags);
-- 
2.29.2

