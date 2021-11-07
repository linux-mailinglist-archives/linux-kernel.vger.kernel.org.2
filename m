Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62224447678
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 23:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbhKGW4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 17:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhKGW4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 17:56:21 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F10C061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 14:53:38 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id h16-20020a9d7990000000b0055c7ae44dd2so6797480otm.10
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 14:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=jm4HkC4WuEFuj0T0GbogyNYTH9ILCYVGsH89yM0+sVY=;
        b=un0ROogmycQPFx5MqbulloXygKairZ+6ICrLoIPL2vYLlsh789nazo6Hsv2mzEp9si
         KxsA2GvDQwJ1CyowwYEETVMYITQwhBWuAm3qQK4mf1aJAaNttM9T7LG0qRfer46RBS73
         4agnUB02PckB5CFsfjvJFJbR34Uuy1nZK8Pqn/daNB8SX5IJA/LGNmzDxi4IMbeDlyiK
         TECXtEA50ld1oexOL7TBN9Rkd/sqAN3UJjwQPu1x4ILChGrpIuyJicdLF0ScWXMNEW+v
         taJxAHI4D5Aw0ZUbUtiFlVenJMm3qLYvN3Q9ImTAHcDBa2oDSkdy0pWNwOOGrtIghQM+
         BDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=jm4HkC4WuEFuj0T0GbogyNYTH9ILCYVGsH89yM0+sVY=;
        b=Fl7oPOArH0Su1HbDHoR73WWCypTv2y9X4UERlKf5KGwxxgK4PpUn85GlBxkVJURoFL
         Q/CqXuxJBMiTgGvteZxyizy0c/Or4IiauO+JS8EnBPE7FEijRLVKrL89ychY0Iu1th46
         FEd5KHK3it0iTrkIm9xP6XsTO2/vz1eraJTVT6oKEO4chPdlCNzasn7YMUxyv3zD9R0A
         IYoiLNakyNf4D/tAViHLNoNdMM7ODNiONDMZfOvra/1xnlRzlHYoI5WiULlstFelpDDw
         b90RRcd58cZ9ZK5KXO3uVPdXVq0++3Zix1oYYmayPbbB3awxGEuYse86yLO+MixrBVuE
         NioQ==
X-Gm-Message-State: AOAM533CMuOla6xNsyYKQLSUpUClDbvFSqPAobbnPQp9Z3ZGiyTmLJsE
        vWku9o1YNJoB7P9yq3Fh1NzuBg==
X-Google-Smtp-Source: ABdhPJysbhbn4/+ndMMNZXqbf3gQjWDNDbQttUiUK/XLCQDWvKwg4RdzkreaUtPvwYgM+hv/FRLoRw==
X-Received: by 2002:a9d:2f42:: with SMTP id h60mr10652072otb.159.1636325617800;
        Sun, 07 Nov 2021 14:53:37 -0800 (PST)
Received: from fedora ([187.64.134.142])
        by smtp.gmail.com with ESMTPSA id r22sm1841169oij.36.2021.11.07.14.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 14:53:37 -0800 (PST)
Date:   Sun, 7 Nov 2021 19:53:32 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        will@kernel.org, nathan@kernel.org, ndesaulniers@google.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] iommu/vt-d: Remove unused dma_to_mm_pfn function
Message-ID: <YYhY7GqlrcTZlzuA@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dma_to_buf_pfn function, which is not used in the codebase.

This was pointed by clang with the following warning:

drivers/iommu/intel/iommu.c:136:29: warning: unused function
'dma_to_mm_pfn' [-Wunused-function]
static inline unsigned long dma_to_mm_pfn(unsigned long dma_pfn)
                            ^

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/iommu/intel/iommu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 0bde0c8b4126..35300b5b69f7 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -133,11 +133,6 @@ static inline unsigned long lvl_to_nr_pages(unsigned int lvl)
 
 /* VT-d pages must always be _smaller_ than MM pages. Otherwise things
    are never going to work. */
-static inline unsigned long dma_to_mm_pfn(unsigned long dma_pfn)
-{
-	return dma_pfn >> (PAGE_SHIFT - VTD_PAGE_SHIFT);
-}
-
 static inline unsigned long mm_to_dma_pfn(unsigned long mm_pfn)
 {
 	return mm_pfn << (PAGE_SHIFT - VTD_PAGE_SHIFT);
-- 
2.31.1

