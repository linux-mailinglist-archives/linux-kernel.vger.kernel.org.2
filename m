Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57BF42AB6F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbhJLSEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbhJLSEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:04:00 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C7FC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:01:58 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id c28so124275qtv.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J8ymrs8BqWOXJaCIl/vcEAutu2VS1jf5LIfnMpirIno=;
        b=api8DVz7bx2oVQ9f/ldYVg6zIqaVgDK7XC9AFr+oN86gJUIaU00fus2enBiUFdASXt
         9z97UHOo927hwXvSGCqTP+3e5Iw95QOfW8fVJS/47yZSekiS0TdW1Pc8iMeEjE9Nuyi+
         Pi7Cji+zNPmltNfU5w+6HHF8PdI6yIQH87MkiQcaOZGv0hjr7XPQJTkrU/cUMXhMKfef
         QEAQk/jeArS7E8NqSbtWRxnWH3BdQwv2AgQcrUsE4Tf1Yed9OouT6Kmah7HPNjLgsV3q
         vgMFftQyqsTPtygeQr5esj1j1xfCcPWCPKt1B4XgzkbuXHYcoYGGJN4TzKlfZ31yVoOd
         zTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J8ymrs8BqWOXJaCIl/vcEAutu2VS1jf5LIfnMpirIno=;
        b=BCH88w73IUW561uIDQyh4d7FVe3th5UwQ+MpZq2ct88p1nITu9+9aQCY32x4uQRUqF
         Lf47sRQLCfoT1XKjaeGtae/aJq+rONM8bAGRgHS8ArsyZMnerDbHJk5zgmSoQ6OouXrp
         FB2BenrsXuNs26SqM5KsQI9QIKegKhH+n7BICOQyZM8t0INatWv8uu7G6mmn+uOvnn4c
         I96qEKKMsVM6dvSwGpLwXfyn0opb92Z8rTEtJhjw9vkFmiDLh8CAu0yC6PJfIOUKXQsn
         Out5yXG+Ka369FA5xoFtT/S+733SzUcPbTS65qjB2sJW++iEq8byMEBWeqjiiRW3YN3P
         RSsQ==
X-Gm-Message-State: AOAM533dlDDM3fgFTcvtOxcROHUneBx026+cPeCR6wktSZLYhWkZY/KM
        J8oRew8jc9QPeB/OZuPWU3jI8g==
X-Google-Smtp-Source: ABdhPJwex0JUkya50iE19scsh2CAYyRUyxGrtV8kBBtZ1MSZyKRxk+YCwqYGdOyf580wHjeqTNFzFQ==
X-Received: by 2002:ac8:1e10:: with SMTP id n16mr24325914qtl.86.1634061717671;
        Tue, 12 Oct 2021 11:01:57 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id 6sm3417977qko.88.2021.10.12.11.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:01:57 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/11] PageSlab: eliminate unnecessary compound_head() call in mm/nommu
Date:   Tue, 12 Oct 2021 14:01:43 -0400
Message-Id: <20211012180148.1669685-7-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211012180148.1669685-1-hannes@cmpxchg.org>
References: <20211012180148.1669685-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page comes from virt_to_head_page().

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/nommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index c233126dd476..02d2427b8f9e 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -87,7 +87,7 @@ unsigned int kobjsize(const void *objp)
 	 * If the allocator sets PageSlab, we know the pointer came from
 	 * kmalloc().
 	 */
-	if (PageSlab(compound_head(page)))
+	if (PageSlab(page))
 		return ksize(objp);
 
 	/*
-- 
2.32.0

