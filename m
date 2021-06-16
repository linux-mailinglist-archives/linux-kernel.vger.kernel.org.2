Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57BDC3AA138
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 18:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbhFPQ2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:28:01 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:17894 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231511AbhFPQ2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1623860754; x=1655396754;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=3+Q6ffjeuIyWeUXeB/hUGVYYFCK/LW+an/k3cvbcW7E=;
  b=QL/gleAjgIxEdlX1FMqHlL6PmsHGkAF/i6+vZABShDEXDOhh/ymi3fw8
   7ELpsM2GJ/BhEhzSpzAb97EifRzRqu5ZgPa4FuoFcxvlpKHH47SGSGEWx
   uGJooBOLv/kIV2ZsLZNF50awDm/1fZlhfoAgC04mVgH+EaCHg/btXvtB5
   M=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 16 Jun 2021 09:25:54 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 16 Jun 2021 09:25:53 -0700
Received: from th-lint-040.qualcomm.com (10.80.80.8) by
 nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Wed, 16 Jun 2021 09:25:51 -0700
From:   Georgi Djakov <quic_c_gdjako@quicinc.com>
To:     <vbabka@suse.cz>, <akpm@linux-foundation.org>,
        <iamjoonsoo.kim@lge.com>, <rientjes@google.com>,
        <penberg@kernel.org>, <cl@linux.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <djakov@kernel.org>
Subject: [PATCH] mm/slub: Add taint after the errors are printed
Date:   Wed, 16 Jun 2021 09:25:38 -0700
Message-ID: <1623860738-146761-1-git-send-email-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running the kernel with panic_on_taint, the usual slub debug error
messages are not being printed when object corruption happens. That's
because we panic in add_taint(), which is called before printing the
additional information. This is a bit unfortunate as the error messages
are actually very useful, especially before a panic. Let's fix this by
moving add_taint() after the errors are printed on the console.

Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 mm/slub.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index a8b0daa1a307..ce7b8e4551b5 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -719,8 +719,6 @@ static void slab_bug(struct kmem_cache *s, char *fmt, ...)
 	pr_err("=============================================================================\n");
 	pr_err("BUG %s (%s): %pV\n", s->name, print_tainted(), &vaf);
 	pr_err("-----------------------------------------------------------------------------\n\n");
-
-	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 	va_end(args);
 }
 
@@ -801,6 +799,7 @@ void object_err(struct kmem_cache *s, struct page *page,
 
 	slab_bug(s, "%s", reason);
 	print_trailer(s, page, object);
+	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 }
 
 static __printf(3, 4) void slab_err(struct kmem_cache *s, struct page *page,
@@ -818,6 +817,7 @@ static __printf(3, 4) void slab_err(struct kmem_cache *s, struct page *page,
 	slab_bug(s, "%s", buf);
 	print_page_info(page);
 	dump_stack();
+	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 }
 
 static void init_object(struct kmem_cache *s, void *object, u8 val)
@@ -869,6 +869,7 @@ static int check_bytes_and_report(struct kmem_cache *s, struct page *page,
 					fault, end - 1, fault - addr,
 					fault[0], value);
 	print_trailer(s, page, object);
+	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 
 skip_bug_print:
 	restore_bytes(s, what, value, fault, end);
