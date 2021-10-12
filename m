Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4BA342AB6D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbhJLSEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbhJLSD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:03:58 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851B3C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:01:56 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id y11so113089qtn.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=003A3RpbxJpia6h8OJVwVmN8N2rifd/MJ8qrrv8J8WI=;
        b=HNR7OnYKCsaKVe/66ccJJ3qRoY0/5QYlZMwMRph64x/N/Q5ppPrii/KqTzqfJyKdku
         KkoTJCIgr+Mfe6kFyiWDVWYyx4iQco4EWDdAO7H7mrg4HmI8DIh/+JcuBPbcoVGuO4BI
         b+NZqM+Xax0KCiR4sp+coYDJHbAH31t+u2YL51HLfkVmFkZxxJsiOzDUSvAGX7pyQpaU
         SC/LjIPC8lu8gyhIbM0Cz0sOAYVrfjDPXwEiAiT7QaOzhMRz00gzW+iHfmP3801XAJb2
         ojN8A3QDAt0roW9h05jyXE8hjKZXI6Jrw64Uz7Smw19dyyZAo6EPHDmAY53Vf0G9tkHz
         O/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=003A3RpbxJpia6h8OJVwVmN8N2rifd/MJ8qrrv8J8WI=;
        b=HmsCEm/8SwRLxEvEHY24z6L2W9aUc2FefeXQOSx0jSX2ikj0ytXfHedyBWOGkgDvi5
         MbEvetMASZ57OzL5GD5hUZA9wbKcPR6Ma4zBhRej97QREs0meuShGdKeKUiKaVOrO5WB
         hk1+Gl4ZeSm1+U1dH5ZD1yggYdoMq3QgRjmlMm+1bzpkdvZjs7r8ZWyJJN6JHWYiPoG6
         qsIEC+LGFXBaycuoQPMCU04bdP2N8seVuIAguGjFkDbv1lEFGkvANgnRuns5yLLDvidj
         GozEjX7O5XDpiQbqeNyOEuAfSZ3nD3MbhWhsT4ZXMIILFF3gDTfpyEWH+dgo8zqPd1ZI
         tY/Q==
X-Gm-Message-State: AOAM530zWWvYbnZ4iF6sVwpJAsR6KPvkugcmdbJ1SkCeciOWF4p5Gfck
        2bzUH1koqeFflQbJufFTKPbkhg==
X-Google-Smtp-Source: ABdhPJyX5Fvu+U8cqav7fytlJ4DiQHHGf32yxspbjIFqLp/AdEMNeikDRJKkSjWl/VNUdIMXzGBEfg==
X-Received: by 2002:a05:622a:1444:: with SMTP id v4mr24079249qtx.298.1634061715795;
        Tue, 12 Oct 2021 11:01:55 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id t24sm6273030qkj.38.2021.10.12.11.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:01:55 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/11] PageSlab: eliminate unnecessary compound_head() calls in mm/debug
Date:   Tue, 12 Oct 2021 14:01:41 -0400
Message-Id: <20211012180148.1669685-5-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211012180148.1669685-1-hannes@cmpxchg.org>
References: <20211012180148.1669685-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

head is resolved at the beginning of the function.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/debug.c b/mm/debug.c
index 500f5adce00e..fae0f81ad831 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -84,7 +84,7 @@ static void __dump_page(struct page *page)
 	 * page->_mapcount space in struct page is used by sl[aou]b pages to
 	 * encode own info.
 	 */
-	mapcount = PageSlab(compound_head(head)) ? 0 : page_mapcount(page);
+	mapcount = PageSlab(head) ? 0 : page_mapcount(page);
 
 	pr_warn("page:%p refcount:%d mapcount:%d mapping:%p index:%#lx pfn:%#lx\n",
 			page, page_ref_count(head), mapcount, mapping,
-- 
2.32.0

