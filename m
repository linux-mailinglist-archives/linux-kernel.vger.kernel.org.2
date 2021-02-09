Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A4B315671
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 20:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbhBITBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 14:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbhBIRvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:51:38 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68E2C061574
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 09:50:52 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id my11so1817850pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 09:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CTX9nI+l+jTlvtYfuIUJpxjytbyTmwWmiGbUoX39kz0=;
        b=jYp7erzkLHqd8ALqIUysIbs3Gm4bfwLk0NXzv1S/m+caSlmR9lanUASyGzSkRSqdEG
         2YjR9tv13CZ8gw/Wo3ttkw8x9BBe9aZ4/gU+9nBWrnWctQzQ13/bJLrIjtybpNnt3JwN
         NO2w4TMPcZhlbPXpTwySQMeB/DmaGJtW0btUtwKFwpCZzX5HlaDhU7aSVzqoG0lNjD5X
         78/G1QxtN/C62uCsLOSUAVVotGiJYyh8mqfURqIZep83NrzsdWcbTLcMZSIdgY39IKFj
         NQdbjUyHpULjTu0LJseTtQvhGC8rVNT4G9ysiasQKzPFJHdpFql70ag5n5Yr9151Y6Ur
         /19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=CTX9nI+l+jTlvtYfuIUJpxjytbyTmwWmiGbUoX39kz0=;
        b=B5LOzMW5VlWKmceZ1R+m/uorha6eZsygJ7gOI+jwsAG9feET9Y+jiE/wsYOIwpk7Tu
         45yE6GYSkfac1KmGIXnaSW2xEtcflaX5hnCb0tAV5IR/pfn9mpVUFPTpbeWHuTmLaUv6
         5VxUiCKu+Z99dmwm9wTbr7gqgPgYloN1VjkuxDzyt4Jaeje/6Vu36kffbr0Zv6gGflvV
         7sMY0SDPGCiLLiSoZCXkE92tefyMnR8ht0723wLax1Fz3iGDLk7Z0gUTwseMtQZhIiVM
         67VozKLe2tq+FeByhl6uB+Iy9h7wh6E1Mm9mELwQN96N7D3T8p/EnxTovOkhWYCWS9Kn
         ZKNg==
X-Gm-Message-State: AOAM5336Dm1OhTKQhFKDT5XcvUV6mQiIFs70mK+c42JzWhyTGc5dPGyK
        dbfc3WAlIVf/WKwcV94XByw=
X-Google-Smtp-Source: ABdhPJyUlnvVMLsH86gqTbh26uwn9gMrsGYQqPwCZV23qJXAdQl8W5Hp0cr6OIK2CoZnZ04U5DN0hw==
X-Received: by 2002:a17:90a:4083:: with SMTP id l3mr5155505pjg.109.1612893052380;
        Tue, 09 Feb 2021 09:50:52 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:d107:fbfb:a7c8:913e])
        by smtp.gmail.com with ESMTPSA id c188sm7625194pfa.98.2021.02.09.09.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 09:50:51 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH] mm: remove lru_add_drain_all in alloc_contig_range
Date:   Tue,  9 Feb 2021 09:50:48 -0800
Message-Id: <20210209175048.361638-1-minchan@kernel.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__alloc_contig_migrate_range already has lru_add_drain_all call
via migrate_prep. It's necessary to move LRU taget pages into
LRU list to be able to isolated. However, lru_add_drain_all call
after __alloc_contig_migrate_range is called is pointless.

This patch removes it.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/page_alloc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6446778cbc6b..f8fbee73dd6d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8603,8 +8603,6 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	 * isolated thus they won't get removed from buddy.
 	 */
 
-	lru_add_drain_all();
-
 	order = 0;
 	outer_start = start;
 	while (!PageBuddy(pfn_to_page(outer_start))) {
-- 
2.30.0.478.g8a0d178c01-goog

