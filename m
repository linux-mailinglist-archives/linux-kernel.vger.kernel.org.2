Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443FD397BA4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 23:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbhFAVTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 17:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbhFAVTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 17:19:05 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943B2C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 14:17:22 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so613769otc.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 14:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=N5uDhAxv0tIiSHDRiUFgmqD1xsYzRonX2XfRezH0zjg=;
        b=a1cxj0Qb2Q7mg06own49b3QWEpgT9CNesL748Sfwr3Zrrj4UjUtL2WJgo6VgXQxgbS
         lrbQiptZ2tK7nUNk37VezWPZSWUiMaAUlk+uTTw/hPjg5Y3p3cYWJVsnbJ96yp3bvusy
         CKSc0qiKTPR8TnTS4bu4h93yFsgOl1yLnwLe2lwDJ7JFP9AOVkETS0KajI/aQev92JOG
         IDlBqAqXQdEYoYBuyfXjtAeb7LQOmGhLtmQLXlTjffAY/EgAUU0AnSTa1aXgXxasaJZW
         ssE7zY9Xn9wUp05yYAVSsQ9iJ2yiUUYLpbHdnhuiz+LD3DR/vXyQvxaeM6UhS2Y8ROrq
         SsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=N5uDhAxv0tIiSHDRiUFgmqD1xsYzRonX2XfRezH0zjg=;
        b=tXPxMLzTXyuYv5CqWp5tQUWhA8A7ha6E44KkTms2QoeEq50NlXu22XsEhQDIAaALCN
         CQaqywZ6PktlQBv3ivdYOOTyeNHIMnektL+IvNmw7jSwuiucu8ILFKt0lGUj53w9kN/2
         /5sYtmMFoP36k1VWZL7ATtRUBhw2pr/3gQ0seHCtzJQdjPaJCUZrJY/ixBT3Kr8L449n
         HWejEkID4onYT6mue0NbdFBAjUomvNCpo86xtpciOiKIUvFVqytTEOZCVMloAkokJwZt
         6FhaHU3uiI+BArETHl2w3HzUbGF9HxIIygbSZaJtN+Ug7/6mAYm/UZzamAD0DO2eLVtE
         ckLQ==
X-Gm-Message-State: AOAM533zNC1UhAJVmUj4uIauqsCH0V1xDd2r6jKdzWEXuJ5MniuyWC+Y
        OB82rXYao4De90PTR9Bvv7+iDA==
X-Google-Smtp-Source: ABdhPJyFME7J7rL15FKaFRQawXTQiSK6pOg1sR2ou3YK3BC2tZQp+lfGEuFuRUcHe8NOh8jr4EVr0g==
X-Received: by 2002:a05:6830:1e54:: with SMTP id e20mr23511882otj.227.1622582241799;
        Tue, 01 Jun 2021 14:17:21 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l23sm3708287oie.52.2021.06.01.14.17.20
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 01 Jun 2021 14:17:21 -0700 (PDT)
Date:   Tue, 1 Jun 2021 14:17:19 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] mm/thp: remap_page() is only needed on anonymous THP
In-Reply-To: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2106011415430.2148@eggly.anvils>
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

THP splitting's unmap_page() only sets TTU_SPLIT_FREEZE when PageAnon,
and migration entries are only inserted when TTU_MIGRATION (unused here)
or TTU_SPLIT_FREEZE is set: so it's just a waste of time for remap_page()
to search for migration entries to remove when !PageAnon.

Fixes: baa355fd3314 ("thp: file pages support for split_huge_page()")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/huge_memory.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 305f709a7aca..e4a83e310452 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2354,6 +2354,7 @@ static void unmap_page(struct page *page)
 
 	VM_BUG_ON_PAGE(!PageHead(page), page);
 
+	/* If TTU_SPLIT_FREEZE is ever extended to file, update remap_page() */
 	if (PageAnon(page))
 		ttu_flags |= TTU_SPLIT_FREEZE;
 
@@ -2368,6 +2369,10 @@ static void unmap_page(struct page *page)
 static void remap_page(struct page *page, unsigned int nr)
 {
 	int i;
+
+	/* If TTU_SPLIT_FREEZE is ever extended to file, remove this check */
+	if (!PageAnon(page))
+		return;
 	if (PageTransHuge(page)) {
 		remove_migration_ptes(page, page, true);
 	} else {
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

