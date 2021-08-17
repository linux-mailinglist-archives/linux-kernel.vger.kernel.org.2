Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5FB3EF42E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 22:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbhHQUja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 16:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhHQUj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 16:39:29 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E12BC061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 13:38:55 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id bd1so1055003oib.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 13:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qst5Lct6ju3ZiqLPEwiEwZCexgwlBiGnZjd8VzBBJAU=;
        b=awQiy6mW2gRQnPCe2fzj1nM0naHRZ0XG7PtwKsN+oeM+V1LTqxkC4tbTfyZvL1lAZt
         OR78CydauxbVPha8JB4aJdd21BS5qPmddFNVV8yHzEd+58Kq/9Dm+8zcSw9PkKmZrH+f
         ooWZZzfZKnshQ0MrQ8SPqjrKBGnG1nbJinc73YlJ8nnH4F3ayI4snwnoduNEV59bNKWd
         zokeFoBW9vV35/mBznhRtf7+13DqR3NGbkdJKfObe8qOzxRHvmsFjdDxq8L7bshz6HXW
         yJb8azF3Zx0pnZE1/NxjDhWTO4HEFGPwpDUTqKGH/rxkV4gbQoFl2OZ0dizxZueg5uJK
         nLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qst5Lct6ju3ZiqLPEwiEwZCexgwlBiGnZjd8VzBBJAU=;
        b=FMU3RIZKUiCHQZncs2jB3Pc1t/pef/yVGVu3KIhth+8tMDfiN5oQMBVAYzZd0Qtyer
         esbX2ScYeU6Cv1VsWhlirIQVeVFwjmYfD5GP1dqbxHZGyrn8tZzRKTLyNwLMIJUK0X6J
         /LMJkjDOWl6mF8VZIO73Y/vCndeDZUepdQx42uCnE0A3hOiXoUfMv/bno0EedlLxCRql
         7HBwf32RBI/1BWAK6yphlN/PjaiOW/WPWzbKpXLp89CgxyV0DV2n+6LnXHXbJFAdclL2
         JdpokpBaiooPg5Sc9cdOsk1W5TuC5R80iMWBUrxJMPW/AdBK+v++msq6fBNp6GLSWspI
         Kpfg==
X-Gm-Message-State: AOAM533COk5DcY6RxvDFxs7a51S8CGQ123lX1+cnOv8xRMoUrJ1eLatU
        xdQserPx7t1Zwv1irT+DHD4=
X-Google-Smtp-Source: ABdhPJwEz7DnFMOfwvP1SQynjScCfEKl40/eHeQR+3rbX+xGM3tfkwDMrJwtk6DzD4MapWrozxezgg==
X-Received: by 2002:aca:5316:: with SMTP id h22mr4096473oib.13.1629232734996;
        Tue, 17 Aug 2021 13:38:54 -0700 (PDT)
Received: from vaslot-XPS-8930 (2603-8081-2340-02f5-2f69-e1eb-f257-277e.res6.spectrum.com. [2603:8081:2340:2f5:2f69:e1eb:f257:277e])
        by smtp.gmail.com with ESMTPSA id t13sm633599oor.37.2021.08.17.13.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 13:38:54 -0700 (PDT)
From:   Vishal Aslot <os.vaslot@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        os.vaslot@gmail.com
Subject: [PATCH] mm: Changed leading spaces to tabs
Date:   Tue, 17 Aug 2021 15:38:27 -0500
Message-Id: <20210817203827.54586-1-os.vaslot@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up two ERRORs produced by checkpatch.pl in internal.h.

Signed-off-by: Vishal Aslot <os.vaslot@gmail.com>
---
 mm/internal.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 31ff935b2547..c97fe964ab15 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -557,8 +557,8 @@ extern u64 hwpoison_filter_memcg;
 extern u32 hwpoison_filter_enable;
 
 extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
-        unsigned long, unsigned long,
-        unsigned long, unsigned long);
+	unsigned long, unsigned long,
+	unsigned long, unsigned long);
 
 extern void set_pageblock_order(void);
 unsigned int reclaim_clean_pages_from_list(struct zone *zone,
@@ -647,11 +647,11 @@ struct migration_target_control {
  */
 #ifdef CONFIG_MMU
 int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
-                pgprot_t prot, struct page **pages, unsigned int page_shift);
+		pgprot_t prot, struct page **pages, unsigned int page_shift);
 #else
 static inline
 int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
-                pgprot_t prot, struct page **pages, unsigned int page_shift)
+		pgprot_t prot, struct page **pages, unsigned int page_shift)
 {
 	return -EINVAL;
 }
-- 
2.27.0

