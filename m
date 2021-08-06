Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F223E28BC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 12:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245264AbhHFKgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 06:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245198AbhHFKfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 06:35:46 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB16C06179C
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 03:35:30 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id nh14so15963613pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 03:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NBP1mI1eJEmFrRBUj3/dx1CqWPqkwlbz29Jcl4m2xAk=;
        b=JdKNJSBvRopa3Urrf3WhX/uKXIwQujM9Ti8EciOTg67ZJ1j0meWMTB7/EibJ6XLLqC
         dD+TEpkqMPtcqpcMHgpUGRGGUky93D3Yq8qYpfiQjSzT/wXJfKOP6ZkUmJDGlj3cxO4t
         zJEiyJGmpXj/MnrRj0JdCX6l4yFXHk/TOLsgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NBP1mI1eJEmFrRBUj3/dx1CqWPqkwlbz29Jcl4m2xAk=;
        b=c/UTPe/TT1LOsCmnZI44/H7NHMqVmoizUi3fHHHz5xehrjOt5GXM8gwwe5Hrge7KXO
         pPoNLJInuMoy03FW50P9ZPkJMx8RHtXSK9Gr+jJgY9sEp6MxtcbxBiSpGEchdz3hgmrp
         sL6OH+S7bpqiILv+iy8DgqA4VPYCeI8Je6pKI1hlV8sLuEmBmWsPks6HtFnhL0lnpRmZ
         /G81oyc7MBxHyWMlinSMEyExhYrYMMcSdl6IkWem+F/tLeEKXq88WEBfvCGFGM5/VTXp
         TxPhMD+pSe+A2iYNiqsDidrYBF/JNK1yvLbXmOXPud4xs2BYxijTF+tSI/f4a88XEx8a
         +g0Q==
X-Gm-Message-State: AOAM531yYBoAAZphxa+MhUryloh9SSNaohR+hR77kXlhR62ww48m9XXL
        7ORInatQsXar29wdDqknJMuwXw==
X-Google-Smtp-Source: ABdhPJyYJf8IZc/UBHsRMF484qyLGnbbn2jXQbe+CyHk6yZx9o4TB97jhd9dHES8sNQ5E1cwkJ1NBg==
X-Received: by 2002:a17:90a:d190:: with SMTP id fu16mr20709870pjb.157.1628246130284;
        Fri, 06 Aug 2021 03:35:30 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:6f20:cf00:347a:afc2])
        by smtp.gmail.com with UTF8SMTPSA id 6sm12821707pjk.1.2021.08.06.03.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 03:35:30 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH v2 9/9] drm/i915: use DMA_ATTR_PERSISTENT_STREAMING flag
Date:   Fri,  6 Aug 2021 19:34:23 +0900
Message-Id: <20210806103423.3341285-10-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
In-Reply-To: <20210806103423.3341285-1-stevensd@google.com>
References: <20210806103423.3341285-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

Use the new DMA_ATTR_PERSISTENT_STREAMING for long lived dma mappings
which directly handle CPU cache coherency instead of using dma_sync_*.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c | 4 +++-
 drivers/gpu/drm/i915/i915_gem_gtt.c        | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
index 616c3a2f1baf..df982cfb4f34 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c
@@ -48,7 +48,9 @@ static struct sg_table *i915_gem_map_dma_buf(struct dma_buf_attachment *attachme
 		src = sg_next(src);
 	}
 
-	ret = dma_map_sgtable(attachment->dev, st, dir, DMA_ATTR_SKIP_CPU_SYNC);
+	ret = dma_map_sgtable(attachment->dev, st, dir,
+			      DMA_ATTR_SKIP_CPU_SYNC |
+			      DMA_ATTR_PERSISTENT_STREAMING);
 	if (ret)
 		goto err_free_sg;
 
diff --git a/drivers/gpu/drm/i915/i915_gem_gtt.c b/drivers/gpu/drm/i915/i915_gem_gtt.c
index 36489be4896b..f27a849631f7 100644
--- a/drivers/gpu/drm/i915/i915_gem_gtt.c
+++ b/drivers/gpu/drm/i915/i915_gem_gtt.c
@@ -33,7 +33,8 @@ int i915_gem_gtt_prepare_pages(struct drm_i915_gem_object *obj,
 				     PCI_DMA_BIDIRECTIONAL,
 				     DMA_ATTR_SKIP_CPU_SYNC |
 				     DMA_ATTR_NO_KERNEL_MAPPING |
-				     DMA_ATTR_NO_WARN))
+				     DMA_ATTR_NO_WARN |
+				     DMA_ATTR_PERSISTENT_STREAMING))
 			return 0;
 
 		/*
-- 
2.32.0.605.g8dce9f2422-goog

