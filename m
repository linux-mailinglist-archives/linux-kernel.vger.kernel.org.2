Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2894314DC6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 12:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbhBILCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 06:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbhBIK5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:57:23 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62843C06178B
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 02:56:42 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 100so10365675otg.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 02:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y+87jDlelvAkmlccbbsaH9fufNQh8avTEY3L9pDsVQ4=;
        b=kOuKcCAoSI3K+pZ1OOigFzQmL/D1AGodIfTC5qH7C+a17cdSLZ+34W+s58QIpBZBd7
         3p6G0oXARZUvPrUXY9oEM50P7StY6h7jW4hsT+6yKaFj5oshU/8SSHS8bcNocWW87FqZ
         y7VyHxI/NDL5D67ernOa8S2nl582y+xc4aeyAVDbaP95CJG3VWnxleiRmebbXSPqb58O
         0hRg5R1oiENyFqG8J0dnBNfyW98qfTvHzEpw0u/K71rD/db3evICvlQaFzUJ17zljxTV
         6FBbgr6QjPZTiV9exzfv2j0/PUR14UC8pUYXl5QV53BHEsR4b7P+44FIUBEWLX+wp8M4
         C4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y+87jDlelvAkmlccbbsaH9fufNQh8avTEY3L9pDsVQ4=;
        b=sH4DY6orm7M3eJo+HSjS6mn8tw+swIZQeHALTjHo4uPY8se98G6CLumc7awOx3hOTj
         /cGKrz5kjbnEFTF+r3xl40+GQtzcOz4m/1XSdsQkYyMdsoLeZ40OBB28cJeixt5Dqgiu
         hMeqSuC+fZUfr5RDRLGHcUwVzoT/LM1H15iTpS2yMmnwyOB3SwJLH7q3AGbnJQLd3oKt
         HktnBqYDQw0E0I4QS+xYIcmJxzOfFIHavSgvbJuy3oc2Gia6/OIsnVIjY3SWGzPNq22s
         8varPbnsNpKNFVTQWAASGBsgEYprQn+Uc/Uc5nj945M8fZ/JCSiQSVOX9p4NtATZ6KqR
         vRUQ==
X-Gm-Message-State: AOAM530uVZuwgqv2+6lRn6gLnWw7G3boJRdWTo2WNyJy8UKvzkXvx0qi
        jx0KidVJW+oV337CnNkdZIE=
X-Google-Smtp-Source: ABdhPJwZ1E2WR8O8CEosYvCwLy1nVVpYDf1qJZ1fbJYyM7jJKanz/+mkswKuU5F9rw/bpVBI1OblIg==
X-Received: by 2002:a9d:30f:: with SMTP id 15mr15715024otv.212.1612868201816;
        Tue, 09 Feb 2021 02:56:41 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id g3sm4171377ooi.28.2021.02.09.02.56.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 02:56:41 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     willy@infradead.org, andriy.shevchenko@linux.intel.com,
        david@redhat.com, linmiaohe@huawei.com, vbabka@suse.cz,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, joe@perches.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 1/3] mm, slub: use pGp to print page flags
Date:   Tue,  9 Feb 2021 18:56:11 +0800
Message-Id: <20210209105613.42747-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210209105613.42747-1-laoar.shao@gmail.com>
References: <20210209105613.42747-1-laoar.shao@gmail.com>
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

