Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958B0312EFD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 11:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhBHK23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 05:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbhBHKPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 05:15:50 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C961C061788
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 02:15:09 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id y11so13682869otq.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 02:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AfzWei4umlGVQDuzDsu/6vxC6VqYoM19+5981ukNvio=;
        b=f747CuabzW6jNHZmUHMnJFaY9lfhzlNIpY/CW3aucW05mfIRlJI06OKmbh3oFbo28o
         K8w14VbfkqpQYBvM4wZDQPTGsm4rgqus+hLTuSS1NvDMZOfTccJ94JSJLqXxMsqYH9G/
         yELGoNhfoJ0QcmTUDZfabkygXTmCThBq9z0LKkt0LoMMD7BqZ0j/rtXSht5TxZ7Tv22m
         QBXu7/9tci11r5a6OB11h1rFox3bn/jJ/iv5/f2kf71gBgB0z/MRxOSAMICo3OcJea9S
         +hUcaFWS76E6oz5kFrmXUfXqLKQaj6k0FQV0ZZxX6yhalplMMBbId+2AirlLhOibyrpc
         lvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AfzWei4umlGVQDuzDsu/6vxC6VqYoM19+5981ukNvio=;
        b=F23o0cgPA9m7MbSKWai9m21QXMVPFb9QuPiG/gUzQh+izb+Wcy7mH0pnw4KPu7xMlB
         FpXncDjmxp4l0rnDctb/TNfIVZmm6hFFT2wjAPs1ZW2/N9cdKD4fsYJ8mTIWvcigqkjF
         5BWEbxTtVHzE3uBk3kk0dfCUJOAnqU/X8qA9oPqAxjwaoI33asUu1JJVnFXEgDnwKRJT
         H6YgPZfk23ZjaFdBOBoyjW19DaXgNJ5E6fbdcXW7cMO+EfI5pnlFKoLK6dWCTwMVQ7If
         uCq6fpl7CNnvDBg5txz7jaQoY4VUO6htY1vGOCP5ekYHyZCN8mr+3OkvDLcLqJZuXXn4
         dEXg==
X-Gm-Message-State: AOAM531eI81dvu+/CeDL7DdJS1QcR/h8k6AOAeLhjDgp6YrFQfn5YW1i
        Z0+vlykXaYkh2++08wdQXWE=
X-Google-Smtp-Source: ABdhPJzIcYkSTcrgXQFDdnYYRK99jagCTwAnxOCgJDgXzdOQkUEOoLXdzrnsr5Hde1YeF151SZy4gw==
X-Received: by 2002:a9d:71c6:: with SMTP id z6mr12266305otj.276.1612779309010;
        Mon, 08 Feb 2021 02:15:09 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id t3sm607226otb.36.2021.02.08.02.15.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Feb 2021 02:15:08 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     andriy.shevchenko@linux.intel.com, david@redhat.com,
        vbabka@suse.cz, willy@infradead.org, cl@linux.com,
        linmiaohe@huawei.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 1/3] mm, slub: use pGp to print page flags
Date:   Mon,  8 Feb 2021 18:14:37 +0800
Message-Id: <20210208101439.55474-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210208101439.55474-1-laoar.shao@gmail.com>
References: <20210208101439.55474-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As pGp has been already introduced in printk, we'd better use it to make
the output human readable.

Before this change, the output is,
[ 6155.716018] INFO: Slab 0x000000004027dd4f objects=33 used=3 fp=0x000000008cd1579c flags=0x17ffffc0010200

While after this change, the output is,
[ 8846.517809] INFO: Slab 0x00000000f42a2c60 objects=33 used=3 fp=0x0000000060d32ca8 flags=0x17ffffc0010200(slab|head)

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: David Rientjes <rientjes@google.com>
Acked-by: Christoph Lameter <cl@linux.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 mm/slub.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 34dcc09e2ec9..87ff086e68a4 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -638,8 +638,9 @@ void print_tracking(struct kmem_cache *s, void *object)
 
 static void print_page_info(struct page *page)
 {
-	pr_err("INFO: Slab 0x%p objects=%u used=%u fp=0x%p flags=0x%04lx\n",
-	       page, page->objects, page->inuse, page->freelist, page->flags);
+	pr_err("INFO: Slab 0x%p objects=%u used=%u fp=0x%p flags=%#lx(%pGp)\n",
+	       page, page->objects, page->inuse, page->freelist,
+	       page->flags, &page->flags);
 
 }
 
-- 
2.17.1

