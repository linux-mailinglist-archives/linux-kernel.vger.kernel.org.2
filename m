Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0508C306B0A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 03:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhA1CVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 21:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhA1CU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 21:20:58 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EE7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 18:20:18 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id y72so1067568ooa.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 18:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zYH+mxvn2A3dJD0z4OcS09UkAKI7HiExMGSeLtKn4tM=;
        b=tiLdanme9ZPBFmKmUuqRLeH0jzl1towtFwyue+W036MJ4w7Q0h3Sm2QCo4P1rIaIlk
         7D4SLMuAhkyYviCcoDpfvA0uOU8oaZTxj+tLUOr5WubWXhJ4SsIB0Ydz+Io8iLcPYytW
         ePgTpOJp/AbNutt5hSSVtiPIy5WrR2pb4kS5ZQ0451wXIFLnSWmApDHyVIAkKTcVWFQk
         POsFMp4eMdPSfwh4Vd2fRDnImdpCIULirez05hpHBCakb89KyHRO5WN6xhtZjQOKoUHA
         CX65q8qxcvc7z5zyn3y7QQHf3CDBv+f4wcbyD54+hg68pHuxvXdbbDwtSX4TyJrkDlrt
         8QVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zYH+mxvn2A3dJD0z4OcS09UkAKI7HiExMGSeLtKn4tM=;
        b=Ty5xC+k2bfuT64ZSaZhmUtAqmdQVMbSzSJrJlE+MgjLwZ2VpNQz9uIOLNrAsOd+YUl
         +WL+6gL8hpGGL5BDGxFmN+vIgS+SXklYDfebYOAQnJcZ3orMkBi7Vnne9ZAziJ0FN6be
         50JIItyCod6ayVItRXR5F2wyEPWFbgLmqzitGlBvb/dlDeB1WqeRSV3AYB9H1ANTD92c
         DQnwFhqgD9dAaGgjgJ62ZBmbIUk+gc+ilndaItVnabOTtt2OTWCRyBcA5OPEBnsn9Ssk
         UqFk1QjELRxFTLnm28+96F1USlJVD84lnOKsof++tzZ36OIByf9L+ZFECCp3JdBlr+wG
         ZfOw==
X-Gm-Message-State: AOAM533pDiFeTeghBpuhKNVr2gplFEPKUoE9MHTgc2xVsLtVbdVKn9G9
        yQxJ+zxh4fEiH0LQE2QK1Hs=
X-Google-Smtp-Source: ABdhPJwfIyMxrySXxF9sSW16i+roO96QXXqk46k4/giZAvfnNk8o1ICwull2rDWtQmj+ARrMwaG5kg==
X-Received: by 2002:a4a:646:: with SMTP id 67mr9826383ooj.33.1611800417909;
        Wed, 27 Jan 2021 18:20:17 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id m10sm731246otp.19.2021.01.27.18.20.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 18:20:17 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     david@redhat.com, vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 1/3] mm, slub: use pGp to print page flags
Date:   Thu, 28 Jan 2021 10:19:45 +0800
Message-Id: <20210128021947.22877-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210128021947.22877-1-laoar.shao@gmail.com>
References: <20210128021947.22877-1-laoar.shao@gmail.com>
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
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 mm/slub.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 69742ab9a21d..4b9ab267afbc 100644
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
2.17.1

