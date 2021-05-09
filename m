Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D56737781F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 21:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhEITkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 15:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhEITkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 15:40:02 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B33C061574
        for <linux-kernel@vger.kernel.org>; Sun,  9 May 2021 12:38:57 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id v5so18143732ljg.12
        for <linux-kernel@vger.kernel.org>; Sun, 09 May 2021 12:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S8tyYOINgJcgXO+YLeHnUlDVZZruEdZrDr6md8OI68k=;
        b=nzlu7ccem0ygsiY/jJ0x16lK73WjRmh51B0MtwxG3bflCWQEcPuh5mOREu5EmGPZ5B
         CC/WfyY/pGPTn6gfZq5uu5F26Vm4vqWf21hIl6ey2hLhXx/BoRdZOR8LMoq3HhtAG7vx
         giNPFVzOMbameC316jucY9r6OuSbFqBOUsBBKOSliqXCd2PCcJSk9OOGGHfeou4KN1Ch
         oC/MrMUjGWP/z2VL1S1h1perKLwI00rajDsMI1u0/5RLWjmzS5jumBGY80DlopOtZokG
         l0Pcnw0ze7ZguflS6CS+4Dke8VFGlVwB6PEwatDZ3zICvqrv1z/8ddaRnRrcl0Id9VOZ
         pYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S8tyYOINgJcgXO+YLeHnUlDVZZruEdZrDr6md8OI68k=;
        b=nFGvtp/6DkNLCuqWcEfSk7eYz36VZHAE/iqGkiBgv6gvgy2E0kRwv4mXg472lUssaM
         IFR7eA4n+9mJpH+R3EqHdSa98uK6sju2MVfvhlI8IgHK32FuAgb7JaM6oTkvFSxrg5Qy
         DnB2vxsVETx3CCfSH+AzmyqqVIes9cY68qnhyOCoufphP8bp8GDo0jrIA4n1uGGaE4Xh
         z2yzMsVySY10dtjChv9+oOnYg1HLyFcSB5H7Kj+bj8Yr1Obn862oM5gU4a+gJ7j2Wie/
         JvlpBqwbphxHcQEVWp+Hus/xg+cV17VOt3jfvqJ0hFP3UkAlXZO+xL5afzSYTJ+fAJz7
         0tfg==
X-Gm-Message-State: AOAM532z3YEoWLNTkhwcETh2Nkx+1L94EY8p4+U1tA20Qfz49DwQZxuQ
        +rgVcxjJu6NT7NJBARhqKPc=
X-Google-Smtp-Source: ABdhPJz4+CgRWqWhVIi9vQherdRk/qSSdjAHrJnWqHztMNOv2DvPjKazUo0hPzXDsA4SYTO7xFWqbQ==
X-Received: by 2002:a2e:7005:: with SMTP id l5mr945485ljc.150.1620589135987;
        Sun, 09 May 2021 12:38:55 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id m17sm1999269lfh.146.2021.05.09.12.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 12:38:55 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mel Gorman <mgorman@suse.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 2/2] mm/vmalloc: Print a warning message first on failure
Date:   Sun,  9 May 2021 21:38:44 +0200
Message-Id: <20210509193844.2562-2-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210509193844.2562-1-urezki@gmail.com>
References: <20210509193844.2562-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a memory allocation for array of pages are not succeed
emit a warning message as a first step and then perform the
further cleanup.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 Makefile     | 2 +-
 mm/vmalloc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index bb50a5ac2e13..1d658e171495 100644
--- a/Makefile
+++ b/Makefile
@@ -430,7 +430,7 @@ HOSTCXX	= g++
 endif
 
 export KBUILD_USERCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
-			      -O2 -fomit-frame-pointer -std=gnu89
+			      -O0 -g -fomit-frame-pointer -std=gnu89
 export KBUILD_USERLDFLAGS :=
 
 KBUILD_HOSTCFLAGS   := $(KBUILD_USERCFLAGS) $(HOST_LFS_CFLAGS) $(HOSTCFLAGS)
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index dbc6744400d5..1f664a17d9ea 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2781,11 +2781,11 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	}
 
 	if (!area->pages) {
-		free_vm_area(area);
 		warn_alloc(gfp_mask, NULL,
 			   "vmalloc size %lu allocation failure: "
 			   "page array size %lu allocation failed",
 			   nr_small_pages * PAGE_SIZE, array_size);
+		free_vm_area(area);
 		return NULL;
 	}
 
-- 
2.20.1

