Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E15442AB73
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbhJLSE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbhJLSEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:04:05 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13977C061765
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:02:02 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id c20so176198qtb.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5lvw5Qkq1aYtQrdDyynEw7+1fb+LBtUMWle5QZBxmmc=;
        b=ZRxAa3dCUIQ/2t2A5bfPUBO8+qsrLWcdjgBysmSz2hHYKrWWA4F0s4IpOR036raCEC
         9NXiSvCs1tTgg7nSbEwvLytFT3p8aeclNnkTRgSYbvuGXeOI5RggN9r2XlJBapTCy6k6
         wflt913blZ8EukxCzpHwbZfU0RjgzaERvpGVArHj+ZVzfRWLLMGKWqWQz6VdHYO3yRRb
         RsyJDpGVkl88h4tLRrtNYBzQJK8hZEeVFfkQrCrySOBcj75PPMeMv0eQUF02ScpNIFlX
         IhVkvf+hBAf10AJv+XiKYEfzsd3TLuSXS90GMuAkx+qwVECwOSYxozbpL8MTPxjqffoX
         QUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5lvw5Qkq1aYtQrdDyynEw7+1fb+LBtUMWle5QZBxmmc=;
        b=C7/07Bx2znUjf4zJlmO0SzI+pzfJuoxRtmhe8xfyRbXMoQKSJoJUg/vdiels37ykV4
         ZIhvD7lRRu9QxCr8SpU+dpNkzRy4feJ6sM9XHGgk6+hZA4GoBCL261y6OPqaxMhd6c9F
         CTV0tkGswLU0JkLY9FjM/mvk/oOdBiEd7ITbbXhxxQi2amDnNMmAOc1N4ChfuPDltDhW
         Nu4+JPHunHBQQo+xJbv+Fcb3joxhPgs/lZew6gWQyhXfrTEr6l2kx/uFUMJLyuDYsCp9
         4G9nFEzvC8MTgUZuAsJF89C53ftBZ2pC6qshpok+KA51JKKK6++vVVZy9dJugijU/X8K
         4azQ==
X-Gm-Message-State: AOAM530jjNpTkKtfr26PTqMKZrqzzhBwMIKNArd0C/N0AAy+WtJHQBqK
        u7LBUrb1w/O1YDhZuzj3Bb3PSg==
X-Google-Smtp-Source: ABdhPJyN0BoLusx+W7Z8FkZAXpS+c+bgMpYmaXYb4NUw/SQe981ABNR1OzmuWw0cbmEILaHzL0SOQA==
X-Received: by 2002:ac8:705d:: with SMTP id y29mr24210129qtm.73.1634061721311;
        Tue, 12 Oct 2021 11:02:01 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id m17sm6876285qtx.62.2021.10.12.11.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:02:01 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/11] PageSlab: eliminate unnecessary compound_head() call in mm/usercopy
Date:   Tue, 12 Oct 2021 14:01:47 -0400
Message-Id: <20211012180148.1669685-11-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211012180148.1669685-1-hannes@cmpxchg.org>
References: <20211012180148.1669685-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/usercopy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/usercopy.c b/mm/usercopy.c
index 924e236522da..b3de3c4eefba 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -235,7 +235,7 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
 	 */
 	page = compound_head(kmap_to_page((void *)ptr));
 
-	if (PageSlab(compound_head(page))) {
+	if (PageSlab(page)) {
 		/* Check slab allocator for flags and size. */
 		__check_heap_object(ptr, n, page, to_user);
 	} else {
-- 
2.32.0

