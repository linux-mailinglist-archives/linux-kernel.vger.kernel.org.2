Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFE93752A7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 12:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbhEFKzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 06:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbhEFKzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 06:55:12 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7CAC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 03:54:12 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id x10-20020adfc18a0000b029010d83c83f2aso2036859wre.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 03:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ipcG+5uCgsazZ7SR+haE6w/wCwHthGEmmd5v1cTEP/8=;
        b=Dt5VHadtdFALJNc2V8NVWfsRwTuNJvem5dJIW6zihJXQSNYad98je3UEUvAryxgUjx
         BRAY/7A0Qjj1kZbAiaaVjlJBJ0Fhfa/kWwAYG+kGD1JIh5jOaan0hQysxjH6j4mqAN3m
         o4foBxQrb36gzuEDwy342mjrN7DX/UB8DK3AXqzjho+xEEfc4WylZYrmmv7q8OWNFQ5z
         sN4p9TLHJOa3lTnbdfFrvGDheSsK9Y387iacN2mMdvc7xkNodiGBZYEHIB2mEW/NTGep
         gmdqC2xdDwlyw7AoL9u8hIjSZ6KGzTQcQGo9+kaltMMvPc6OHQsX/s7NF6jXhm1fvuri
         w7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ipcG+5uCgsazZ7SR+haE6w/wCwHthGEmmd5v1cTEP/8=;
        b=fdW4klnvlBARAedRHRkBAYSXQGIjc9Ltu+rirqBHn8F5masQBokILuRVJI6on+qxBg
         NeMzIaMHCv6etgQ4UehtHNn4vgipV/7CmobvhSx/pSJgxNOoKKXuOLHgJYuTXPjwJqa/
         nPxreqtWn4h9Nrk30IZy52glTrBtaW1hhsZuYN7dhVPO1WyaXqo2DSBSWeCIYff/KOpe
         WNonDZ/0eVrThzt4Hyt+M/HT+Tz6h4NsEAgv+o2SNKdn9F706ySAfBy3yomdYcFaTWOK
         QK4rhF1ig6MW0GO31f0cKbmO46jbOS4roT4C+cJ1b3FuyTYjbEiyNeoBfzMYraNhuX7o
         yLMg==
X-Gm-Message-State: AOAM530JCmT0fhFIFSbInZQRGnEbmfMqIzmIq3wDctb2s9FTUAZZIg5l
        3vMa87wqR3eqZcF7iB6NwFUQPL1N5to=
X-Google-Smtp-Source: ABdhPJyI4tYi07VP6AcDu1zYJvLTRf5hulbyrr5zLv7ZRLrHEwhdxwIvgr7nn0FOX+y6VSPUX4Xy2JCWDNk=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:14b:3523:e987:8aa8])
 (user=glider job=sendgmr) by 2002:a1c:804a:: with SMTP id b71mr3337751wmd.82.1620298451425;
 Thu, 06 May 2021 03:54:11 -0700 (PDT)
Date:   Thu,  6 May 2021 12:54:05 +0200
In-Reply-To: <20210506105405.3535023-1-glider@google.com>
Message-Id: <20210506105405.3535023-2-glider@google.com>
Mime-Version: 1.0
References: <20210506105405.3535023-1-glider@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v2 2/2] kasan: use dump_stack_lvl(KERN_ERR) to print stacks
From:   Alexander Potapenko <glider@google.com>
To:     akpm@linux-foundation.org, pmladek@suse.com, mingo@kernel.org
Cc:     bo.he@intel.com, yanmin_zhang@linux.intel.com,
        psodagud@quicinc.com, dvyukov@google.com, elver@google.com,
        linux-kernel@vger.kernel.org, ryabinin.a.a@gmail.com,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the contents of KASAN reports are printed with pr_err(), so use
a consistent logging level to print the memory access stacks.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Prasad Sodagudi <psodagud@quicinc.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Marco Elver <elver@google.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 mm/kasan/report.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 14bd51ea2348..8fff1825b22c 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -230,7 +230,7 @@ static void print_address_description(void *addr, u8 tag)
 {
 	struct page *page = kasan_addr_to_page(addr);
 
-	dump_stack();
+	dump_stack_lvl(KERN_ERR);
 	pr_err("\n");
 
 	if (page && PageSlab(page)) {
@@ -375,7 +375,7 @@ void kasan_report_async(void)
 	pr_err("BUG: KASAN: invalid-access\n");
 	pr_err("Asynchronous mode enabled: no access details available\n");
 	pr_err("\n");
-	dump_stack();
+	dump_stack_lvl(KERN_ERR);
 	end_report(&flags, 0);
 }
 #endif /* CONFIG_KASAN_HW_TAGS */
@@ -420,7 +420,7 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
 		pr_err("\n");
 		print_memory_metadata(info.first_bad_addr);
 	} else {
-		dump_stack();
+		dump_stack_lvl(KERN_ERR);
 	}
 
 	end_report(&flags, addr);
-- 
2.31.1.527.g47e6f16901-goog

