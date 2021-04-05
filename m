Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A61F35483E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 23:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241278AbhDEVns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 17:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhDEVni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 17:43:38 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DDFC061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 14:43:31 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id o14so9225195qvn.18
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 14:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=gfJiVLWnR3u0HT0QPuAVfbid+Hjz+9NTHVVf/avPiLs=;
        b=M3yvuA1uL2HlxtaCa3D1y4Poke4m37DPILkYUmES0Opj+tc41x9ZEqA/ZwrM4Xnj+a
         Uf71VEuiHHo4pF9BJy1ete9zY0Pc7+dKlrsUZZUyZNgv9dQ/WPFgZ6QH1ijw+HUkvVWA
         YRzWwslXWsa8XFuZ10GyZKAWqsLKS+yUcRiYIMJqQiiw/65GhFIRCow3tkbZw61Sgva3
         VBwyscj0bhQTvoqa0tWxx6oveok66n6ajFTlsSOvwKUUSsbuLQXfBnCfRmcYTdR5tAdt
         OHHWCk5Tr/hAtIxjEEbyAjeuEJsRYQ8FWLOYlPNvzPTw6GsoEvVx2jtChEDBaOgw2aKd
         S0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=gfJiVLWnR3u0HT0QPuAVfbid+Hjz+9NTHVVf/avPiLs=;
        b=paPr3Q1rr+T1cZx+e2CXNpe4s39DU5pbfH9Gfq3XRUOStdzXA4vuE0wjjJSaXNETKQ
         rrudBZmIpWp4lgeUoAywoP5cDallV+TRnngS3MFqp56n97TogBMjaNonw1GR1UQGZcPf
         +USX4L/Ib4kBrKaaHI08bG1vPYf2s3QFGRY3BuPpb4eZmb4HIh8MOF22EzOFbu8XMpJo
         9j+pACcAi7A6hfPYvNwcTypLraoNzaSC+eA2KbBMQQIbpkmCbLInQnAEB5VSeYSoxPiz
         VdYJapo7EJbzSSKz20KLQOzi+pgVa7UHr96v/taZmrj4ZwQbDckFTDmt4F5+dh60PXGF
         7l8w==
X-Gm-Message-State: AOAM530dkHmTjXppSn3R3pB+3xTlGFlZEq2+go8FjdeIip2pXX4YWJu0
        cK/Ah3CJko1cosL3Yonf5d8GmmQ=
X-Google-Smtp-Source: ABdhPJxV6U+sF4CX99Re8zx+JaWecKrw4a4IkQ+sv2HqAwztwfRVsj6d3/HXUwzvOOBrR05cED/suBo=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:8495:4fdf:186d:cc80])
 (user=pcc job=sendgmr) by 2002:a0c:e9c7:: with SMTP id q7mr25192903qvo.7.1617659010098;
 Mon, 05 Apr 2021 14:43:30 -0700 (PDT)
Date:   Mon,  5 Apr 2021 14:43:21 -0700
Message-Id: <20210405214321.1953019-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH] kasan: fix kasan_byte_accessible() to be consistent with
 actual checks
From:   Peter Collingbourne <pcc@google.com>
To:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can sometimes end up with kasan_byte_accessible() being called
on non-slab memory. For example ksize() and krealloc() may end up
calling it on KFENCE allocated memory. In this case the memory will
be tagged with KASAN_SHADOW_INIT, which a subsequent patch ("kasan:
initialize shadow to TAG_INVALID for SW_TAGS") will set to the same
value as KASAN_TAG_INVALID, causing kasan_byte_accessible() to fail
when called on non-slab memory.

This highlighted the fact that the check in kasan_byte_accessible()
was inconsistent with checks as implemented for loads and stores
(kasan_check_range() in SW tags mode and hardware-implemented
checks in HW tags mode). kasan_check_range() does not have a
check for KASAN_TAG_INVALID, and instead has a comparison against
KASAN_SHADOW_START. In HW tags mode, we do not have either, but we
do set TCR_EL1.TCMA which corresponds with the comparison against
KASAN_TAG_KERNEL.

Therefore, update kasan_byte_accessible() for both SW and HW tags
modes to correspond with the respective checks on loads and stores.

Link: https://linux-review.googlesource.com/id/Ic6d40803c57dcc6331bd97fbb9a60b0d38a65a36
Signed-off-by: Peter Collingbourne <pcc@google.com>
---
 mm/kasan/kasan.h   | 3 +--
 mm/kasan/sw_tags.c | 8 +++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 8c55634d6edd..e18e8da35255 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -368,8 +368,7 @@ static inline bool kasan_byte_accessible(const void *addr)
 	u8 ptr_tag = get_tag(addr);
 	u8 mem_tag = hw_get_mem_tag((void *)addr);
 
-	return (mem_tag != KASAN_TAG_INVALID) &&
-		(ptr_tag == KASAN_TAG_KERNEL || ptr_tag == mem_tag);
+	return ptr_tag == KASAN_TAG_KERNEL || ptr_tag == mem_tag;
 }
 
 #else /* CONFIG_KASAN_HW_TAGS */
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index 94c2d33be333..914225eeda99 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -121,10 +121,12 @@ bool kasan_check_range(unsigned long addr, size_t size, bool write,
 bool kasan_byte_accessible(const void *addr)
 {
 	u8 tag = get_tag(addr);
-	u8 shadow_byte = READ_ONCE(*(u8 *)kasan_mem_to_shadow(kasan_reset_tag(addr)));
+	void *untagged_addr = kasan_reset_tag(addr);
+	u8 shadow_byte = READ_ONCE(*(u8 *)kasan_mem_to_shadow(untagged_addr));
 
-	return (shadow_byte != KASAN_TAG_INVALID) &&
-		(tag == KASAN_TAG_KERNEL || tag == shadow_byte);
+	return untagged_addr >=
+		       kasan_shadow_to_mem((void *)KASAN_SHADOW_START) &&
+	       (tag == KASAN_TAG_KERNEL || tag == shadow_byte);
 }
 
 #define DEFINE_HWASAN_LOAD_STORE(size)					\
-- 
2.31.0.208.g409f899ff0-goog

