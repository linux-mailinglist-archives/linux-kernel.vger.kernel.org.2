Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090C430A6FC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 12:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhBAL5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 06:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhBAL5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 06:57:36 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B6FC061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 03:56:56 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id p21so111412pld.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 03:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hIsvW8P9+uYLezvOEppL2cu9Sms7br/nplzxkf+Uuow=;
        b=Uu1LJYqpQCre5B6+Qh8vSJ3YYTTxMi+qsQNfArcHITOE2isNcr4A9MTpdxAzQqf+k2
         h7LDkqQEiXMOH1oBlo0tMgDj7I98QPAI/Mfd6eTPj+mEK5h2SRAuwpcBx/iESzd08q/6
         MeVA4Gge1kXB5Vg6Vlcl9Gk0Hz+HzEGPZyfPm5n7D4QRvflKpphd3oZKJztYx3B6Ljed
         biyMGx6WhBtwFCSdj2U2Fj6kzZsz02oHVgh+0vxE6bT5qvim6A66rh36lSM5Lsy5Gfl3
         uG5F9cDOUuBx/rtHS4C+8iVxwNHPREjdd5Q8dU9VnHPhv2skUx6B5Q+xT419HBEXr/oW
         K8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hIsvW8P9+uYLezvOEppL2cu9Sms7br/nplzxkf+Uuow=;
        b=nxMUHXTuocjG/nKl5aYzl4wzKGk5KIOnbpPi9DdandCy1wTvqi3xv8ra2d5H6Id9cw
         0UyqULmtc+Xdfg4TWITDk2bYEljDB9N8g3OkPwDzIueun2/avPgeP/XJlZU7wEI8qDGX
         WzhWwHVaFhv/TB2iM/Kk7Lf/5CYI4A+5bkfiTZ1rmfrCboBzCAwulSsdgvCqBAYKzLEL
         ePsoVb7rjYJSX4orXa+zK0zmpCLUUssZcOjnzgnmbKWnzrXvYh2CXAbnLILejih3h/Xw
         DEkOAJTQgqreNHLPrOOB+Y1w++Y+xkdHKa8nhztTRfHkFuSCrbcy/aXqvQhISbFyT494
         rVDg==
X-Gm-Message-State: AOAM530nRmLeeHz53afvKUPPYzB7s2BwSdpvWftTgwSC/Av03gwKOVvx
        FkBea7ezBxGKmjpvy7M28ak=
X-Google-Smtp-Source: ABdhPJwotWx0PNovNqXAjWXtfufDcrYYrYEaWnGE6Fjq3aTUQJyyzmhls5TUbA66zs1mkTfD5SvkaA==
X-Received: by 2002:a17:903:2292:b029:de:45c0:7005 with SMTP id b18-20020a1709032292b02900de45c07005mr17472088plh.75.1612180615792;
        Mon, 01 Feb 2021 03:56:55 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id dw23sm7195152pjb.3.2021.02.01.03.56.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 03:56:55 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     andriy.shevchenko@linux.intel.com, david@redhat.com,
        vbabka@suse.cz, linmiaohe@huawei.com, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux@rasmusvillemoes.dk
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 1/3] mm, slub: use pGp to print page flags
Date:   Mon,  1 Feb 2021 19:56:08 +0800
Message-Id: <20210201115610.87808-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210201115610.87808-1-laoar.shao@gmail.com>
References: <20210201115610.87808-1-laoar.shao@gmail.com>
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

