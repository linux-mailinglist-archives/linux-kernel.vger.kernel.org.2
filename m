Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCB432BDF7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385083AbhCCQkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 11:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347487AbhCCMMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 07:12:43 -0500
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A54C06178C
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 04:12:03 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id 7so10107646ejh.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 04:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=iJEzlqcbA6uhEUEuHAVXPzScMobXeq18I/DGTA3EYs8=;
        b=eOYSOVRO77ER5mH0QhxZy1dQq+R5pwjis8BOGfoVKSez5r50LxdDkhYhAhgVPpspbs
         I0ssKV8fL5rODJqFcSvFCgqc6IBf27llaEs6EMAhMGyD9NNYqgaZR6fH6sqcQIOKEfDR
         IxD7CluLnvJvY54Wo3N1uoJMBpmk0Em+wWgn1ojtJTqWtJqan9kQsJmfA2PPOiwi/JMd
         66FFhBw6ns9XbIPxEwCNTKrfnDO1Z0RcBBEbrMOODXOd4/zU/vyqGeofNrVg3KlwnAOR
         FYkr2Oqkg3xrK3xLTFYQqQj6/nRhcxf4LSGsb11LrdV2wNUFC31IkOKdJMLQiGnDidsa
         j+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=iJEzlqcbA6uhEUEuHAVXPzScMobXeq18I/DGTA3EYs8=;
        b=YEVNZ0/bjFooKkHraXX/WrQDnH3FwP2xBtXdkdnX83f7ytFHDcuFPv3GjTao18xmob
         Kl0pZuHe9wRrxDlkIg8RH0dD6xaPmZYGWanmgqVVhM62zwp3JUe4VFGc1sm7jfuYis4M
         +YFPQm2A0tj1qv7ZgCFPjJCmxaFO1kZ8ha/14J4ZcjKchfFxhbDmmtQOiJCHnDLAL+WF
         tg3T4kkF96eg/FWRKf8SpViZ2nHmNG5eBBIO2sLAnJeauV6CyNnF2VNDBErDBxpdE7OG
         yCetIHNhSNESO3h7LFBimE5hFDJROwdczGpjA+82+bnrkRqOOa2mHiUWW4NN5GHKhLc8
         lzrw==
X-Gm-Message-State: AOAM532fwqt44PwsTruZUuGj1erPUsurstzK8BU4We77QxOgpMZQP/5X
        aasaM2TXPmdm5LmCHe+WsLTKoF5TMw==
X-Google-Smtp-Source: ABdhPJxdSZ0KR/e1q3osAVGWwuRTz4JELyIhl89vHZCZBb1dsLg/cDn6Mwc3eDQFLWOyOqlaBeVt/sPIbw==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:811:228c:e84:3381])
 (user=elver job=sendgmr) by 2002:aa7:cd8d:: with SMTP id x13mr24619685edv.286.1614773521450;
 Wed, 03 Mar 2021 04:12:01 -0800 (PST)
Date:   Wed,  3 Mar 2021 13:11:57 +0100
Message-Id: <20210303121157.3430807-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH mm] kfence: fix printk format for ptrdiff_t
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     glider@google.com, dvyukov@google.com, andreyknvl@google.com,
        jannh@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use %td for ptrdiff_t.

Link: https://lkml.kernel.org/r/3abbe4c9-16ad-c168-a90f-087978ccd8f7@csgroup.eu
Reported-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Marco Elver <elver@google.com>
---
 mm/kfence/report.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/kfence/report.c b/mm/kfence/report.c
index ab83d5a59bb1..519f037720f5 100644
--- a/mm/kfence/report.c
+++ b/mm/kfence/report.c
@@ -116,12 +116,12 @@ void kfence_print_object(struct seq_file *seq, const struct kfence_metadata *met
 	lockdep_assert_held(&meta->lock);
 
 	if (meta->state == KFENCE_OBJECT_UNUSED) {
-		seq_con_printf(seq, "kfence-#%zd unused\n", meta - kfence_metadata);
+		seq_con_printf(seq, "kfence-#%td unused\n", meta - kfence_metadata);
 		return;
 	}
 
 	seq_con_printf(seq,
-		       "kfence-#%zd [0x%p-0x%p"
+		       "kfence-#%td [0x%p-0x%p"
 		       ", size=%d, cache=%s] allocated by task %d:\n",
 		       meta - kfence_metadata, (void *)start, (void *)(start + size - 1), size,
 		       (cache && cache->name) ? cache->name : "<destroyed>", meta->alloc_track.pid);
@@ -204,7 +204,7 @@ void kfence_report_error(unsigned long address, bool is_write, struct pt_regs *r
 
 		pr_err("BUG: KFENCE: out-of-bounds %s in %pS\n\n", get_access_type(is_write),
 		       (void *)stack_entries[skipnr]);
-		pr_err("Out-of-bounds %s at 0x%p (%luB %s of kfence-#%zd):\n",
+		pr_err("Out-of-bounds %s at 0x%p (%luB %s of kfence-#%td):\n",
 		       get_access_type(is_write), (void *)address,
 		       left_of_object ? meta->addr - address : address - meta->addr,
 		       left_of_object ? "left" : "right", object_index);
@@ -213,14 +213,14 @@ void kfence_report_error(unsigned long address, bool is_write, struct pt_regs *r
 	case KFENCE_ERROR_UAF:
 		pr_err("BUG: KFENCE: use-after-free %s in %pS\n\n", get_access_type(is_write),
 		       (void *)stack_entries[skipnr]);
-		pr_err("Use-after-free %s at 0x%p (in kfence-#%zd):\n",
+		pr_err("Use-after-free %s at 0x%p (in kfence-#%td):\n",
 		       get_access_type(is_write), (void *)address, object_index);
 		break;
 	case KFENCE_ERROR_CORRUPTION:
 		pr_err("BUG: KFENCE: memory corruption in %pS\n\n", (void *)stack_entries[skipnr]);
 		pr_err("Corrupted memory at 0x%p ", (void *)address);
 		print_diff_canary(address, 16, meta);
-		pr_cont(" (in kfence-#%zd):\n", object_index);
+		pr_cont(" (in kfence-#%td):\n", object_index);
 		break;
 	case KFENCE_ERROR_INVALID:
 		pr_err("BUG: KFENCE: invalid %s in %pS\n\n", get_access_type(is_write),
@@ -230,7 +230,7 @@ void kfence_report_error(unsigned long address, bool is_write, struct pt_regs *r
 		break;
 	case KFENCE_ERROR_INVALID_FREE:
 		pr_err("BUG: KFENCE: invalid free in %pS\n\n", (void *)stack_entries[skipnr]);
-		pr_err("Invalid free of 0x%p (in kfence-#%zd):\n", (void *)address,
+		pr_err("Invalid free of 0x%p (in kfence-#%td):\n", (void *)address,
 		       object_index);
 		break;
 	}
-- 
2.30.1.766.gb4fecdf3b7-goog

