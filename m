Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA3F31C01B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbhBORHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbhBOPxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 10:53:47 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A45BC061756
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 07:53:07 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id z15so4416833pfc.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 07:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lMogc+88WyQtKfJD7auvy+h4i72decXJNUKFaJ3X740=;
        b=f1k2NYrwwh8xNqd+o6sELNC/Xmn6BqejfYUsOdc/hz0lBUnnqJbmZ6ctx3UFqArygT
         17RseW+oVDoiLEI7HMJNK21OEjCqDymgNg0x7NUkKvm3mqEJUMMFTqwXVTreKYEAMaVn
         NT5WTNjazDqjE6gbKospAb/bP2MIm/2KO7K6DQSVS5pmtIVQ/fk0y3P2Z44fyk9cSNfI
         6m8XtvcXoTYU4Ar6eV8caQZzWuWCgbAMi/hIpyAapvGN0W22M84wPxIq+wI/kmalhFX0
         Xk5B8uoaiiAyioEjYb+3HBMPnnn5+dfTuIvRTn/InmeIAUyoc+4DkOZkJyM3wksC3W91
         WFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lMogc+88WyQtKfJD7auvy+h4i72decXJNUKFaJ3X740=;
        b=nLqDO3s/86PHNmKtp1txjYadusywSo2AxaIFa2V4uAwqYvXQTwLRm5MgVBFYjjh3ei
         dz3aNjApDBfBaffeXmrWpBS0LthoIfPJ5W9sd9pwR/uuqJo1vqCCk1X8DmB1b3sshA3P
         urybTyMbyKisnpLMV6ixQbOM9b9yRhI+iT9et+MP5V7aaUnWNmazRD6Tv+n6zxJbGZyE
         mdg1qCsqD0pfkQuluwOgEhOB0+514SyYyZzRhzZaaLJuEgI2rQHenGVktQBlmZHUZ90e
         9J50W15ryAVgSOu3IUfSHUpXhBWd7vKJjekNnYMigu77gI0qx4ztlefxuaPdF8rce2cO
         vJiQ==
X-Gm-Message-State: AOAM532791R8JHniIlFeCfwAx3WyZPak4aHFjcgdOTj4Ym95d465sSHA
        aGO9ZrmM8gW3l77NLoy9hTA=
X-Google-Smtp-Source: ABdhPJzyd3xnuMeGDrvMoMMEnluGJNTY+zKXAvszGpcjAWV7U3QqkpZ5CMs1fRYSM3tyK5jr+hTz/Q==
X-Received: by 2002:a62:3852:0:b029:1da:7238:1cb1 with SMTP id f79-20020a6238520000b02901da72381cb1mr15988342pfa.11.1613404387231;
        Mon, 15 Feb 2021 07:53:07 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id i1sm19771215pfq.158.2021.02.15.07.53.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2021 07:53:06 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     pmladek@suse.com, willy@infradead.org,
        andriy.shevchenko@linux.intel.com, david@redhat.com,
        linmiaohe@huawei.com, vbabka@suse.cz, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 1/3] mm, slub: use pGp to print page flags
Date:   Mon, 15 Feb 2021 23:51:39 +0800
Message-Id: <20210215155141.47432-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210215155141.47432-1-laoar.shao@gmail.com>
References: <20210215155141.47432-1-laoar.shao@gmail.com>
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

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: David Rientjes <rientjes@google.com>
Acked-by: Christoph Lameter <cl@linux.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 mm/slub.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 7ecbbbe5bc0c..ddd429832577 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -641,8 +641,9 @@ void print_tracking(struct kmem_cache *s, void *object)
 
 static void print_page_info(struct page *page)
 {
-	pr_err("INFO: Slab 0x%p objects=%u used=%u fp=0x%p flags=0x%04lx\n",
-	       page, page->objects, page->inuse, page->freelist, page->flags);
+	pr_err("INFO: Slab 0x%p objects=%u used=%u fp=0x%p flags=%#lx(%pGp)\n",
+	       page, page->objects, page->inuse, page->freelist,
+	       page->flags, &page->flags);
 
 }
 
-- 
2.18.2

