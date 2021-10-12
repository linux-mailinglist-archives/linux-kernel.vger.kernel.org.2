Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B373242AB75
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbhJLSEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbhJLSEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:04:05 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2209AC061764
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:02:01 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id az39so6532440qkb.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EJleHbVtWFR6gqUGI4pMK3bP4aI2cTYgy4hO4rU19aY=;
        b=SzHk97+39EXkttB7Lcw0JFRnbjxuOzQa4QMcS+7Pnak9LUL8400Ch6IeQEO4X9RQYC
         SmUsHsHiEjQqsphLd2x9Jh3Y1GZBSxR57bLxQ93NhuCHeuPz5C8HlCXC/KAUylUm4jPG
         uJhs+iEHiloK/6bKOXSgO0ii+g4sdLCzkrSeh+a6LChSoa2c/Hv+oSChwRKqcNzb+wqF
         otALpvGvHBEq27rFOqPBpe+d1Wu68gC15DM+a/UgIfnIyLe0WpcAEUZLJBE63nD9EyZE
         ++nx+P0QcnjPPMhsIAYtUYtpvgmV+bwzHTtLCD9ds4ZI5yTFDjT7Mi0BQzG1w473Im5P
         MSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EJleHbVtWFR6gqUGI4pMK3bP4aI2cTYgy4hO4rU19aY=;
        b=2hc92JMQaIzrY667/ZrBY4XvDlsj6+w4S57+FxNCvcm7R/wqMUUC/fYo+ZCPXXyiut
         BoM2HqrJ2l539ZkykLEQM8FVvV9G+EwUmXaTo3nkDbVuTd188RQSu4LSkyK6sEqIjBRZ
         TUxWOunzH1oIRJHCrqx904BDP5uOKD5CvugOccA1rbqQ/vK+1N6XXua5jXyh7U9NPDed
         bNwJM7HddWrPoTxbddNo32wYo532aIeH67QPaAvhVTEq7MY76/4PUeuqBitVIhLQeq8Q
         +/6ms3dq1NvKiOjCqz8Q1UbCx7sbeQe0d7H14wUQ81tLU9p8JklfuvXR7ZlC4u8zy4ee
         yduQ==
X-Gm-Message-State: AOAM533LW6ol2i0i0No9tT0cnaC3LJFRO2EIY6InytUmIcLbizLYjhZp
        Bqz8bG2rnpFolT2jRa+fTLPbrQ==
X-Google-Smtp-Source: ABdhPJyTqn/1OfEZHmHubXFqDcHcCvvI6aiY+JnAN16rKv0iWgpmjvHcrtWJma04shZz9kCbKhhbWg==
X-Received: by 2002:ae9:de84:: with SMTP id s126mr21370083qkf.350.1634061720380;
        Tue, 12 Oct 2021 11:02:00 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id t9sm7261733qtx.47.2021.10.12.11.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:02:00 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/11] PageSlab: eliminate unnecessary compound_head() calls in mm/slub
Date:   Tue, 12 Oct 2021 14:01:46 -0400
Message-Id: <20211012180148.1669685-10-hannes@cmpxchg.org>
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
 mm/slub.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 37a4cc1e73a7..d1bd004c8c2f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3554,7 +3554,7 @@ int build_detached_freelist(struct kmem_cache *s, size_t size,
 	page = virt_to_head_page(object);
 	if (!s) {
 		/* Handle kalloc'ed objects */
-		if (unlikely(!PageSlab(compound_head(page)))) {
+		if (unlikely(!PageSlab(page))) {
 			free_nonslab_page(page, object);
 			p[size] = NULL; /* mark object processed */
 			return size;
@@ -4516,7 +4516,7 @@ size_t __ksize(const void *object)
 
 	page = virt_to_head_page(object);
 
-	if (unlikely(!PageSlab(compound_head(page)))) {
+	if (unlikely(!PageSlab(page))) {
 		WARN_ON(!PageCompound(page));
 		return page_size(page);
 	}
@@ -4536,7 +4536,7 @@ void kfree(const void *x)
 		return;
 
 	page = virt_to_head_page(x);
-	if (unlikely(!PageSlab(compound_head(page)))) {
+	if (unlikely(!PageSlab(page))) {
 		free_nonslab_page(page, object);
 		return;
 	}
-- 
2.32.0

