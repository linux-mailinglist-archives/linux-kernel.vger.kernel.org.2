Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F02043B65B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 18:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237170AbhJZQDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbhJZQDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:03:46 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD293C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:01:22 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id w15so16375438ilv.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=/gA0KFvGXSdxex+fMXRM3sBjJt0PuBVd+JsL/yBoWAs=;
        b=S2fAGG4HkJg/fX1LYM0MZHwW0KGnqfM8mcWfWbDuklh/p8T3M0K9OUsOyHCDcUo5hs
         INpxWCPxr0ZzFb6vISnwFI0rxaDZxM0JcjPAmnRlfNf9cFDOHJSj4YRxEnbJo8fdhEA+
         d9WqhLodR0Xsuk8pRJN6axTuUpRZ4WKmhq5ehLAhdU1W9AnuenkcSxUlMkv7jWm/nip3
         /f4l3FT2KoW6kspGePK1qi0LLUfhnHsbNtQJ5opVIHgTRjU/rBe/iBu2m8Whuu46zsQe
         OLSuBzE3f9zbjSNcTDnfSGkLkD0iVMTodt6QjUOXrYZQJJhJo6UVB9uTNHCrbH3pkxO5
         +/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=/gA0KFvGXSdxex+fMXRM3sBjJt0PuBVd+JsL/yBoWAs=;
        b=uUInlWkDXyw4N12SiqYpPI1vYW0hZIA3HpkFZJAbE8VlCWupHubA2ledZT6FLpUMsj
         NQnwMFLY5Itud6uj3zM5y3GU5xe2IxOxJxLVK3RMhZ3/e7c5lMoHn6OgfdL4pN1/e0qL
         8kyJThg38gOswUE72knIJRHyK0E+1QOkIVLdnOGcPFTmU2ybg4nwapQLvaQ85qBgDCJq
         dOLPI0e7J/Nui/xap2883t7weWro33lZ9eJEJ0x5HcHKgHy17d2sQ7Vzg8EH7A1jw/qQ
         4FyQkdRjHKkQ4xou1vl8bIPBEjg+Ay72ovCxrEuxm7aDUzcMxj61MzilNGjRBNOefhdt
         M+bA==
X-Gm-Message-State: AOAM531/0XXe3xFtrVcdPTBZWdQtSYz/go+HdD1tKq1HW6bw/SW75V8S
        KGkLYrwZbX2EJg02WNZfFsdfAcy0KgKWjQ==
X-Google-Smtp-Source: ABdhPJzscMM+0lKAzjxwvb/dte7Th6IVJJ3LtihsTRKHETvzzKy+HR/MB+hqRtLf1ZgzcVZbTXUkCA==
X-Received: by 2002:a05:6e02:bc9:: with SMTP id c9mr14809334ilu.309.1635264081808;
        Tue, 26 Oct 2021 09:01:21 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id u4sm5406249ilv.39.2021.10.26.09.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 09:01:21 -0700 (PDT)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] mm: move more expensive part of XA setup out of mapping check
Message-ID: <49f67983-b802-8929-edab-d807f745c9ca@kernel.dk>
Date:   Tue, 26 Oct 2021 10:01:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fast path here is not needing any writeback, yet we spend time setting
up the xarray lookup data upfront. Move the part that actually needs to
iterate the address space mapping into a separate helper, saving ~30% of
the time here.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/mm/filemap.c b/mm/filemap.c
index 850920276846..0e4021edac0b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -638,6 +638,30 @@ static bool mapping_needs_writeback(struct address_space *mapping)
 	return mapping->nrpages;
 }
 
+static bool filemap_range_has_writeback(struct address_space *mapping,
+					loff_t start_byte, loff_t end_byte)
+{
+	XA_STATE(xas, &mapping->i_pages, start_byte >> PAGE_SHIFT);
+	pgoff_t max = end_byte >> PAGE_SHIFT;
+	struct page *page;
+
+	if (end_byte < start_byte)
+		return false;
+
+	rcu_read_lock();
+	xas_for_each(&xas, page, max) {
+		if (xas_retry(&xas, page))
+			continue;
+		if (xa_is_value(page))
+			continue;
+		if (PageDirty(page) || PageLocked(page) || PageWriteback(page))
+			break;
+	}
+	rcu_read_unlock();
+	return page != NULL;
+
+}
+
 /**
  * filemap_range_needs_writeback - check if range potentially needs writeback
  * @mapping:           address space within which to check
@@ -655,29 +679,12 @@ static bool mapping_needs_writeback(struct address_space *mapping)
 bool filemap_range_needs_writeback(struct address_space *mapping,
 				   loff_t start_byte, loff_t end_byte)
 {
-	XA_STATE(xas, &mapping->i_pages, start_byte >> PAGE_SHIFT);
-	pgoff_t max = end_byte >> PAGE_SHIFT;
-	struct page *page;
-
 	if (!mapping_needs_writeback(mapping))
 		return false;
 	if (!mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) &&
 	    !mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
 		return false;
-	if (end_byte < start_byte)
-		return false;
-
-	rcu_read_lock();
-	xas_for_each(&xas, page, max) {
-		if (xas_retry(&xas, page))
-			continue;
-		if (xa_is_value(page))
-			continue;
-		if (PageDirty(page) || PageLocked(page) || PageWriteback(page))
-			break;
-	}
-	rcu_read_unlock();
-	return page != NULL;
+	return filemap_range_has_writeback(mapping, start_byte, end_byte);
 }
 EXPORT_SYMBOL_GPL(filemap_range_needs_writeback);
 
-- 
Jens Axboe

