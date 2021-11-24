Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC3645CB4D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 18:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243278AbhKXRpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 12:45:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:40960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243013AbhKXRpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 12:45:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B38C60FBF;
        Wed, 24 Nov 2021 17:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637775714;
        bh=lH/dXDV0nIRP78xdGz0EvAjdCfRkFefJ65O7dnEm7PA=;
        h=Date:From:To:cc:Subject:From;
        b=GM1pbrcl/oBO1SRjSjVu6M2XXZtev8DRj5pQh5JcBwrcl6bnQrRsUUMcfiL5qtc3a
         wJSD2VE/J+G4v88hXfb0Lpp95L6ldR5qtwsGdnv7rQPn1X+jRZ97gGyuRXiEu+aHMg
         mJGDd3q5VeWJOyDs5c0Jqd5hxs2MEDfdnTSYGzlkWAbpwazZsHjCWTS2x5FtbYbSc5
         E9u6Gxr2FXLHL8tXAiFjQyz9z8Tbl6daBhOgteWGj6ijZsXxiFO5nSENMLnG7JgybJ
         vRAuSSbVSY66LHedllfG9cbjQ66+YKW0puyqtl84URHwb+dNxi7WKtx0dzhmkFd5+T
         MHQDT2hPgsf8Q==
Date:   Wed, 24 Nov 2021 18:41:49 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jslaby@suse.cz
Subject: [PATCH] kasan: distinguish kasan report from generic BUG()
Message-ID: <nycvar.YFH.7.76.2111241839590.16505@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

The typical KASAN report always begins with

	BUG: KASAN: ....

in kernel log. That 'BUG:' prefix creates a false impression that it's an 
actual BUG() codepath being executed, and as such things like 
'panic_on_oops' etc. would work on it as expected; but that's obviously 
not the case.

Switch the order of prefixes to make this distinction clear and avoid 
confusion.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 mm/kasan/report.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 0bc10f452f7e..ead714c844e9 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -86,7 +86,7 @@ __setup("kasan_multi_shot", kasan_set_multi_shot);
 
 static void print_error_description(struct kasan_access_info *info)
 {
-	pr_err("BUG: KASAN: %s in %pS\n",
+	pr_err("KASAN: BUG: %s in %pS\n",
 		kasan_get_bug_type(info), (void *)info->ip);
 	if (info->access_size)
 		pr_err("%s of size %zu at addr %px by task %s/%d\n",
@@ -366,7 +366,7 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
 #endif /* IS_ENABLED(CONFIG_KUNIT) */
 
 	start_report(&flags);
-	pr_err("BUG: KASAN: double-free or invalid-free in %pS\n", (void *)ip);
+	pr_err("KASAN: BUG: double-free or invalid-free in %pS\n", (void *)ip);
 	kasan_print_tags(tag, object);
 	pr_err("\n");
 	print_address_description(object, tag);
@@ -386,7 +386,7 @@ void kasan_report_async(void)
 #endif /* IS_ENABLED(CONFIG_KUNIT) */
 
 	start_report(&flags);
-	pr_err("BUG: KASAN: invalid-access\n");
+	pr_err("KASAN: BUG: invalid-access\n");
 	pr_err("Asynchronous mode enabled: no access details available\n");
 	pr_err("\n");
 	dump_stack_lvl(KERN_ERR);


-- 
Jiri Kosina
SUSE Labs

