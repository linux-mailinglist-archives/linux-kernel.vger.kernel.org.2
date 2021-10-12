Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3371B42AB70
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbhJLSEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbhJLSEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:04:01 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DB4C061746
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:01:59 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id t2so142249qtx.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kIr58qV5WpRay8Un4aCE59erJsFKjxl5xtHUFfszgvw=;
        b=APFcJCMwEwhUnWDhbjJl/47EYYCRSL66MqFK5gwiy/c+CsUcYNGXOxd9bxZdBy26Qq
         sQBYLREgxDAgtnn0OoS24xevjiCKpekpRPs9pcOAZVH+hHl3EShtl87yRMhzVt2xtPSD
         jPyEooMAjk1TTSDeYX5cvzvKmzcNYKSKE6mnhyVeDoeYYodo+YxTLbkAx78hS9pSGW7j
         fCKOPfVbm2QDM/7D5Odtb04yT6PJdR3tUXYXxv7GmkmzXV8+NIleM1elr4SukPwBYMnE
         owD6GHSShAXaSVgW+947pD2JY8B5PPv+oF1csX0yijtlTIO2sMHmRgJnxgMBKbg+lzn/
         Yflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kIr58qV5WpRay8Un4aCE59erJsFKjxl5xtHUFfszgvw=;
        b=zWnM/9GSSR2Af2Nghue5RCH3KsMCevZ5zDNCXVfl/GPYEpXoF/lajGqxRj+hazKle4
         OkrkELznCLhsqmQwLwiXmxCX3UjKallu7nwI9us2rRelxkgssNAleUz34gBhiDcy1aGg
         S6HgNbAO2QZ9um50A9+cgjdXYnY6I4nGdirJvTIkRbzM9cWBbeqhfHBvWigV7iNUAYhU
         mRxlqIZX7QwAHjj0Rkx+cthjCemfG4CFP9x0lgFcFR1LZafz8l2ysghVfUWnQx90Y1uL
         666R7Lj1i99IplQOTB3gnrtoVeOY+X/wMtfr0LTJ60SMeHKKDrGeMpkU83mx8L4OIUk6
         +OLg==
X-Gm-Message-State: AOAM5316EFAyzqrygsBdqaJYTOGKefvW1nKZfHCH/fyngYd+luQ1RFCw
        bOvX6/91mnFbdEk5/xBy3Regjg==
X-Google-Smtp-Source: ABdhPJwASH6CVRSFTgQo/VwOt0e0q8DY9ofHco7CvmtZqHAxJ1tq9C/Qvq6u9Bbcz1hr7c2/HMKJeQ==
X-Received: by 2002:ac8:5e49:: with SMTP id i9mr1670456qtx.145.1634061718567;
        Tue, 12 Oct 2021 11:01:58 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id i67sm6157794qkd.90.2021.10.12.11.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:01:58 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/11] PageSlab: eliminate unnecessary compound_head() call in mm/slab
Date:   Tue, 12 Oct 2021 14:01:44 -0400
Message-Id: <20211012180148.1669685-8-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211012180148.1669685-1-hannes@cmpxchg.org>
References: <20211012180148.1669685-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmem_freepages() is only ever called on the full slab, i.e. the
headpage. Further, after the PageSlab() check, the callsite continues
with a series of operations that are not legal on tailpages and would
trigger asserts on their own already.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/slab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slab.c b/mm/slab.c
index 829f2b6d4af7..d0f725637663 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1396,7 +1396,7 @@ static void kmem_freepages(struct kmem_cache *cachep, struct page *page)
 {
 	int order = cachep->gfporder;
 
-	BUG_ON(!PageSlab(compound_head(page)));
+	BUG_ON(!PageSlab(page));
 	__ClearPageSlabPfmemalloc(page);
 	__ClearPageSlab(page);
 	page_mapcount_reset(page);
-- 
2.32.0

