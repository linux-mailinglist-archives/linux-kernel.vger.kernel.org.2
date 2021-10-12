Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5930842AB6C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbhJLSEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbhJLSD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:03:57 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA20C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:01:55 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id q125so20166686qkd.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0e0rL00kLadi2lyvM6hOzWlirSZ5oBt2j8X8F7bJZSM=;
        b=chQcxN4bRHoM7gj2TinQmcPE3Y4oJRxOkiEHEqowVxhCJo6D+Op8aYj8LkysJoHjDt
         Ayh2luHwOdYCu+ecHB4EonMFD7nG5YVFsuzIR1Non/doeQFyR3rwSnBvD2tgIX719L5D
         NtJIuo/6VjEkihK9V8OZrEvY7+8xrBHkeKCUeVFHJFwICJ0/U2v4UXYBhUBwo6I0W7t1
         MrxJ0Bx8nlpqDdR6T2tOncI4YqW7cw53JU2/mObdD/bJBfEqeA6EihjNw5M/h991Zvgp
         r/mHE8Kxz8P9RbBBsKrnLUEyV6JbZInyDW84XQIr+1R9nW/jlR07K3uM55hJPtBeMTFB
         T0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0e0rL00kLadi2lyvM6hOzWlirSZ5oBt2j8X8F7bJZSM=;
        b=LAueUD4grwbHnHmTKjqOWd+2CPYBGn8qwmH7qs9/F9xCkTGyECM5ixPgOzjzMdrJT/
         6Z+bcSQM99HK2FZmCoEa29TUC5FbkvjCgQ3eJamWV1a8/IAI5VzN05ftoHA72M+IkzvK
         DGaMiJqqU2l0T5poPpSR5IyPLEzHHDPfVe9vgQ8sPRGOuH1PMQUDbxPE3oaV888N7jSa
         jKwfLGXzjEUaxNrZnyApSFlv90K/3eMxcjALv6pCHLI/OngihDYmRm3qYSKVlqD7x2QR
         SkD2HreLbrVRhsUwKyLKw+Xm37WbaejuvwNtjXQgErjZbREpqZRsHCBC+AwPRDOkRwq/
         2rGg==
X-Gm-Message-State: AOAM5310y9cf88CzTKsSYOPbuuLnbKS+GtJZHS9mhkIn4/5IG1nGk40D
        wdtRg4epPzhEQlh2OwZfO0+Plw==
X-Google-Smtp-Source: ABdhPJza8yelISHYV2A2JNlOPcudILx0Sa5Dcpdsaxzffy0q9fqNcu137J6I1K7iZBHRbBmYnVVrFw==
X-Received: by 2002:a37:a041:: with SMTP id j62mr21265322qke.423.1634061714932;
        Tue, 12 Oct 2021 11:01:54 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id a16sm5992748qkn.16.2021.10.12.11.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:01:54 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/11] PageSlab: eliminate unnecessary compound_head() calls in kernel/resource
Date:   Tue, 12 Oct 2021 14:01:40 -0400
Message-Id: <20211012180148.1669685-4-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211012180148.1669685-1-hannes@cmpxchg.org>
References: <20211012180148.1669685-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virt_to_head_page() implies it.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 kernel/resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index a363211fda99..ca9f5198a01f 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -151,7 +151,7 @@ static void free_resource(struct resource *res)
 	if (!res)
 		return;
 
-	if (!PageSlab(compound_head(virt_to_head_page(res)))) {
+	if (!PageSlab(virt_to_head_page(res))) {
 		spin_lock(&bootmem_resource_lock);
 		res->sibling = bootmem_resource_free;
 		bootmem_resource_free = res;
-- 
2.32.0

