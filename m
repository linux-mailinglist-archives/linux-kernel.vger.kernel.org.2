Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4400D43B687
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 18:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235887AbhJZQKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235872AbhJZQKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:10:53 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F73C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:08:28 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 5so15460512edw.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oU+EeY72Fqxo4fuN88dML4OJjiCHzSRBLySQqfRpU6s=;
        b=EpVIsA8GKPo7dk/fZDHOCL8DXg2THekLyD8GvJ1+QSmhCGoRek4kq37MFuWeTXiRpx
         D1fz2Uxu7u1Jr82GIuHHPi3DZMBcOyePePAP1ibi9T7jyzBIFJ1aWFoaWOjyoWvE0jd7
         PMjhtJHVqDl+TlWbjSAWulUT3+fJwS9xZv9WZ0rqS3cKIXcFZA7QruaP6OCF7XDYQR9R
         SSO1vUiz9NKtvxPAaoKztcSELSAGXAuBs/iVKXwNIhMhxGtT3XKEAN164OBgah0hXQ50
         /rSS/COR3zV9a674A1N+TuaMMHk3wqS4qAaGRq97YqtSrG5+U8FHO6UnHvtVHfna5Z1X
         RJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oU+EeY72Fqxo4fuN88dML4OJjiCHzSRBLySQqfRpU6s=;
        b=STWBpcKMofzO2jBaQlkzdTBISaZBWO4GEzTDlm/w8LAkB5vm9q5Ptx/IyRq6wO2eMB
         pBya3xtt5siStWePBTbbN9EOMbJLIOjT8XvfiBPuJky4qJ+rYjzPxiVeqjXy6Bdo6afR
         BIvw3gFQm2ubONDVNUvR9ptgBlEllN8arJwUjOxPyZVU30zt7vMgarGq51kSFbSLGKXK
         ZqWEmF0OCeLTm02GLYyM64sUM22HWftABevYBSy+lIUyyuyTaMoHWtso3FMFHhP15eTr
         5Y9RzDyFYFQWy7J5nMA3g52h7qKG1XFFPoz/qWblxk5LV6Or+U1hhRT2686bX5iUIM7W
         2I3Q==
X-Gm-Message-State: AOAM532aLAiDACEXITGGfd8X9y69+k80JzVKELcXCaB4hltOz+CncP6c
        d2Hsp3rqp8/UwhLZ1b5Wex4=
X-Google-Smtp-Source: ABdhPJzrbtOvYqLsp3FLdTpT/Amo1B5J4A7Ys4+PXalhb9IOcwydKRsjZqHL2AH62jn9HrKJliqqFw==
X-Received: by 2002:a50:ee01:: with SMTP id g1mr22757719eds.79.1635264320421;
        Tue, 26 Oct 2021 09:05:20 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id eu9sm4025195ejc.14.2021.10.26.09.05.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 09:05:20 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>
Subject: [PATCH V2 1/4] xen/unpopulated-alloc: Drop check for virt_addr_valid() in fill_list()
Date:   Tue, 26 Oct 2021 19:05:09 +0300
Message-Id: <1635264312-3796-2-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1635264312-3796-1-git-send-email-olekstysh@gmail.com>
References: <1635264312-3796-1-git-send-email-olekstysh@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

If memremap_pages() succeeds the range is guaranteed to have proper page
table, there is no need for an additional virt_addr_valid() check.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
---
Changes RFC -> V2:
   - new patch, instead of
     "[RFC PATCH 1/2] arm64: mm: Make virt_addr_valid to check for pfn_valid again"
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

