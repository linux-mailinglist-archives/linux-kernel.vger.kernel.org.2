Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC3742AB69
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhJLSD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhJLSDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:03:54 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B8DC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:01:52 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id c28so124007qtv.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jZVSq/QQ0LXyDCUs082Ufi1LJb8/1UawzHS4L/yAETI=;
        b=dTMXcs5ow1uGJIpzZktTFZfgi8P1mJWd65Ng6Pebv9FLS3ypgK1E6U6QX8KVrlk/3w
         6TbO8rschFzjfwrFJevf4xKdKOoAC6GJe3B+y1P++T8qOenyljLW27+8Qll1LDL5avST
         3OqPIiFYVQYWMDjVMWuZRtUSw54vyOBHIO+yatqbw8VT1Si0tLZ/i1TXfdtRUR/s29cD
         hfz0WmFGxL2AydwQCbw4aRsLyEDfjquTTuJvqBRzm4w0Kd+O38osTuXgMu5Vg9yPadk6
         VvdhJ6LnnDnZsTOR3WHWJ6HBimlWOHVYRtgRKEXH47bI2QcMxrg/A3GEjSr9DSm7dVd4
         bAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jZVSq/QQ0LXyDCUs082Ufi1LJb8/1UawzHS4L/yAETI=;
        b=wVJKDMLCee8K7eQhjq4jZLO8zDRu1gqSwI2y6JBiR8P+ZRWvjSc7vyO3l55L+12mef
         /kZKTtiUfD1bzCUvReknrqlnceq0VUffV7phJ21QahiMQYdHfFohDHR+9Q3L3rZP5CpV
         nGoVMzhlmDPUfmMyXd92hxM2KanCAT9e4PGt3uswFZzavKNvZpS9Ed/tUUMz+EQMjmkJ
         j/a5azHe1Rt85VsvcjV2YbQakbeXaAjyI2NVrXIa4EIwhbrV3NJY+//ModOAofgVu+XY
         XHWUD0PFaW3IiolDXSjfCa/Stp33iZVQc6VmHuvt1sNH+ASvcjUMAENCa6vCN/ESgZQv
         0GMw==
X-Gm-Message-State: AOAM532lxOK/19oV/Ol2qtOD348eHQIuzVh/5XM0111PfBkNHG6Vcbfs
        DPm/xWlt8u6/S1Ib/KQyYU54oA==
X-Google-Smtp-Source: ABdhPJyAIgYpX/YkGKVVwQ2kvAOZ8RaSQxwhyfOToQYuWzTo05dgoCDs3JCrJeUHRVM7TzV917UpcQ==
X-Received: by 2002:ac8:7059:: with SMTP id y25mr23387455qtm.404.1634061711972;
        Tue, 12 Oct 2021 11:01:51 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id q27sm2449377qki.57.2021.10.12.11.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:01:51 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 00/11] PageSlab: eliminate unnecessary compound_head() calls
Date:   Tue, 12 Oct 2021 14:01:37 -0400
Message-Id: <20211012180148.1669685-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PageSlab() currently imposes a compound_head() call on all callsites
even though only very few situations encounter tailpages. This short
series bubbles tailpage resolution up to the few sites that need it,
and eliminates it everywhere else.

This is a stand-alone improvement. However, it's inspired by Willy's
patches to split struct slab from struct page. Those patches currently
resolve a slab object pointer to its struct slab as follows:

	slab = virt_to_slab(p);		/* tailpage resolution */
	if (slab_test_cache(slab)) {	/* slab or page alloc bypass? */
		do_slab_stuff(slab);
	} else {
		page = (struct page *)slab;
		do_page_stuff(page);
	}

which makes struct slab an ambiguous type that needs to self-identify
with the slab_test_cache() test (which in turn relies on PG_slab in
the flags field shared between page and slab).

It would be preferable to do:

	page = virt_to_head_page(p);	/* tailpage resolution */
	if (PageSlab(page)) {		/* slab or page alloc bypass? */
		slab = page_slab(page);
		do_slab_stuff(slab);
	} else {
		do_page_stuff(page);
	}

and leave the ambiguity and the need to self-identify with struct
page, so that struct slab is a strong and unambiguous type, and a
non-NULL struct slab encountered in the wild is always a valid object
without the need to check another dedicated flag for validity first.

However, because PageSlab() currently implies tailpage resolution,
writing the virt->slab lookup in the preferred way would add yet more
unnecessary compound_head() call to the hottest MM paths.

The page flag helpers should eventually all be weaned off of those
compound_head() calls for their unnecessary overhead alone. But this
one in particular is now getting in the way of writing code in the
preferred manner, and bleeding page ambiguity into the new types that
are supposed to eliminate specifically that. It's ripe for a cleanup.

Based on v5.15-rc4.

 arch/ia64/kernel/mca_drv.c |  2 +-
 drivers/ata/libata-sff.c   |  2 +-
 fs/proc/page.c             | 12 +++++++-----
 include/linux/net.h        |  2 +-
 include/linux/page-flags.h | 10 +++++-----
 mm/kasan/generic.c         |  2 +-
 mm/kasan/kasan.h           |  2 +-
 mm/kasan/report.c          |  4 ++--
 mm/kasan/report_tags.c     |  2 +-
 mm/memory-failure.c        |  6 +++---
 mm/memory.c                |  3 ++-
 mm/slab.h                  |  2 +-
 mm/slob.c                  |  4 ++--
 mm/slub.c                  |  6 +++---
 mm/util.c                  |  2 +-
 15 files changed, 32 insertions(+), 29 deletions(-)


