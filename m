Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD0745CE72
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 21:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244331AbhKXU5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 15:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243576AbhKXU5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 15:57:06 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B07C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 12:53:56 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id u3so10572165lfl.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 12:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2+gPEFaRRl8eqNS/Y7LbhXO/rInityndJKkrLyh8HGc=;
        b=IwvGIOlmD0oLisHuoxC0LwTIm8NUw9yKPbrPmZLK8GGePIHRwcp+OPgQg9/dFz2RM+
         hiUSYru4os/gS4+2xDQ891EiT8Es/5YWqw9BDywwm1RY5ncIMObRrKeQgjYVgm8B6mkI
         UveLsDorJ+JQODSdlevg+ZACcmr+4Hinld08AA5HcR8ehyfrQ1nMgCkaYC5qAhWQSESz
         3y9fkpnDMP0RELGxwKQ9ofXdvltdwEWn94VpY5+xp5Y4y0Fk5nCw4RjtsfYxeAgV94kC
         dkhG+TFfzQBAPGrBfx14mFdmFl4LmT6G97wesoZyIx3ogxjn4o/PvrkXx/cU5UZSOZr6
         qyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2+gPEFaRRl8eqNS/Y7LbhXO/rInityndJKkrLyh8HGc=;
        b=jR5pvtoO83ckbBbVT7sJ3A3PvZGCGwizZ2RBdjhw+veJ96optNLkClf1zEYsehS9D/
         XU0ef4lzWZHyJrcz1BK2OvPiLzgOZ7QyLUBiTTaCeFSORKSZXrc527XoOGgDTrJg7Y+/
         2bZLejhs86CX2xzanoY3GTrDDsUVeENXYMZxPLMX8q3yysV5dW5BzIEbHNH4icQ+BtQj
         TDzxS2f1bhfNtjk1NSneyR/ztd1PAOXlyRasDtIN+1TbkHHCPuSUYd6tUIFvCv3cdxZ5
         +MY+lqLbXu6wQHSageFo8UwaUywQCSPCZFzgIoHOhB3ym0/e1lWpiEXZeXfmoVu97Ui0
         Km3Q==
X-Gm-Message-State: AOAM533JPY5uNeAwJSFcLT43xMTXhVg3tpNYg2DDQyJR0jKUYk/ScIh/
        4KfE2iQUXQJYKwVIiZqqr8o=
X-Google-Smtp-Source: ABdhPJzgTBl/5RrVAWHSyUlG+h2B5h/aX5PT6dG7/gd2BKTy6uPSUT4F9O8nlmLnMgGhSJ12GFeJ4g==
X-Received: by 2002:a05:6512:22d2:: with SMTP id g18mr17528659lfu.244.1637787234615;
        Wed, 24 Nov 2021 12:53:54 -0800 (PST)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id j11sm97608ljc.9.2021.11.24.12.53.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Nov 2021 12:53:54 -0800 (PST)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>
Subject: [PATCH V3 1/6] xen/unpopulated-alloc: Drop check for virt_addr_valid() in fill_list()
Date:   Wed, 24 Nov 2021 22:53:38 +0200
Message-Id: <1637787223-21129-2-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1637787223-21129-1-git-send-email-olekstysh@gmail.com>
References: <1637787223-21129-1-git-send-email-olekstysh@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

If memremap_pages() succeeds the range is guaranteed to have proper page
table, there is no need for an additional virt_addr_valid() check.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
Changes RFC -> V2:
   - new patch, instead of
     "[RFC PATCH 1/2] arm64: mm: Make virt_addr_valid to check for pfn_valid again"

Changes V2 -> V3:
   - add Boris' R-b
---
 drivers/xen/unpopulated-alloc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/xen/unpopulated-alloc.c b/drivers/xen/unpopulated-alloc.c
index 87e6b7d..a03dc5b 100644
--- a/drivers/xen/unpopulated-alloc.c
+++ b/drivers/xen/unpopulated-alloc.c
@@ -85,7 +85,6 @@ static int fill_list(unsigned int nr_pages)
 	for (i = 0; i < alloc_pages; i++) {
 		struct page *pg = virt_to_page(vaddr + PAGE_SIZE * i);
 
-		BUG_ON(!virt_addr_valid(vaddr + PAGE_SIZE * i));
 		pg->zone_device_data = page_list;
 		page_list = pg;
 		list_count++;
-- 
2.7.4

