Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370373A00CC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 20:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbhFHSrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 14:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbhFHSmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 14:42:53 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5148C0611BD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 11:39:59 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h16so12460556pjv.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 11:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yzft9dd0vSeYhbqzTlKmJNFC+BFjIqdFg8djl4vNOCs=;
        b=fKMg+T/GcvrJgmMBWMGLmhO7JM2Xskyd6kNdHclQ3ImCktIasIAU5yt+BTLNsoSOOJ
         h24tzt0WugDC+e7wiA/4raF3/lwiO3VRJffQ2Y2Yat7/sOR/YDFfd85fZi0J1akU5ll9
         fCYo/kHqTICHDpRz99Q5bvKDHAId4ERFLYEXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yzft9dd0vSeYhbqzTlKmJNFC+BFjIqdFg8djl4vNOCs=;
        b=uOfbXBZqou+xT+xKBx+RD/WE1jHtPzTh+BThTSwNezD9i6J+PYboKDczuVTV76cUVr
         TbJ9WYYvivAaJmMtMXv4FwfMSW5TydaMrnbqaiK8WiOLTcaAdtHIXo97eQ0HPv4fyfM0
         3kdoJXkIbXD4KVwbb+JU68hmeFBJHF9Er4DAFMXrjHFzvccjR2KtasdSYbkbXimKJIjr
         92UnWnhgMg6Dt7rRtyZuGdPXzLGE1S8zGlSBdfltKYCHNGhvC/W9B0kpk/SxGcxrDMeW
         OAX40lx+hqqjQBdFc3Hit9zwUmogtQwPALdtLzMDCbmLvL70OL4F17CHjy8rtnO1VqlD
         bSDQ==
X-Gm-Message-State: AOAM530HCkAtQMBdGHzINlypU96V/bSWijc9Y5LELX1rKjsGcmjO++nA
        yo+1RGer9SIzIb5CsTtMP7ioGw==
X-Google-Smtp-Source: ABdhPJwS3KPZAsqhT8J29mTedkNx6p7Ke/oarm+JiBj6cVpii3q7g//5NCUpMwmE0mWzBsO5367gFQ==
X-Received: by 2002:a17:90b:354:: with SMTP id fh20mr27778700pjb.67.1623177599221;
        Tue, 08 Jun 2021 11:39:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x125sm11185015pfx.201.2021.06.08.11.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 11:39:57 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marco Elver <elver@google.com>,
        Christoph Lameter <cl@linux.com>,
        "Lin, Zhenpeng" <zplin@psu.edu>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <guro@fb.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v4 1/3] mm/slub: Clarify verification reporting
Date:   Tue,  8 Jun 2021 11:39:53 -0700
Message-Id: <20210608183955.280836-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210608183955.280836-1-keescook@chromium.org>
References: <20210608183955.280836-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=178be2f9d2e784ee9bf12a0f196176c115be9fbb; i=U+vADmko1G4lZ39LsoUZb95Wrx2rzv1r6guaqRqH67M=; m=KNPYS4ZBPM+uSQxSrL5WKoyUoDfTLfQIvACRYbVbr6o=; p=oVLORPkeeRwgt0gc55edlRvCMc3IvI98MP3RDST0Gds=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmC/uXoACgkQiXL039xtwCZwew/+M13 4wKVrclvxFWQ7U4l1afq0WF/fGE8hgsFeBYQox+dbgIZbDFA56wtNup/udYkNnkiz1muhxBERvtpx V/1Ap4LRawWE41JgshDMfF7c8rJRoy+lolYEjMbXFvs/YxH6TSqFqHXMfy70QRfraczox8kT8mwaB 3l6enWQxhMCeTygt27lZ+F417VXJD/bM1zyLrC3FE0JJ9dJ/uuiE7ZzTMY8DMLgpu+VoSwNqWL4zR lUfNYyxwQz5/3puRkpungw97NK5d14+Ug+tcWImkEGsbPD2iD6Rlra8JVpGa5XTSsqlBOu8Mrqo/q UmqQalgmoWOamnvCiAaBI24YHpLU8pQq178JqK2O0owPhbC8mlNpTEVgZ43GF1hkDhhPQ/QvwRz0Z XC+1WyhwjUT9FRHHhPhRWOgxpY5Q8illryl21dK+9IbuLYRyX1s6Nh4fERJRqltrb6hKHePAUbGzD i5Nh9dwYX4skY48Oui7IL5I+KZsycdwLSXDfQNvN+MmqVmN35gOMJYvq6Kd+LFCDwzAamQyyXUTPp OkUA89+s5SQ958kNjTvicCs7xe5hmRareo/aslj2P9P//WAzu0x0AjGvBXx9/NZ9f0z9/spWcxI4+ Qtjy5K0z/S5nGC6E4tBifF99GPbi0/Y3ge/0NMroeVZrLwbkWQV2KuCPMP/hB14c=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of repeating "Redzone" and "Poison", clarify which sides of
those zones got tripped. Additionally fix column alignment in the
trailer.

Before:

BUG test (Tainted: G    B            ): Redzone overwritten
...
Redzone (____ptrval____): bb bb bb bb bb bb bb bb      ........
Object (____ptrval____): f6 f4 a5 40 1d e8            ...@..
Redzone (____ptrval____): 1a aa                        ..
Padding (____ptrval____): 00 00 00 00 00 00 00 00      ........

After:

BUG test (Tainted: G    B            ): Right Redzone overwritten
...
Redzone  (____ptrval____): bb bb bb bb bb bb bb bb      ........
Object   (____ptrval____): f6 f4 a5 40 1d e8            ...@..
Redzone  (____ptrval____): 1a aa                        ..
Padding  (____ptrval____): 00 00 00 00 00 00 00 00      ........

The earlier commits that slowly resulted in the "Before" reporting were:

  d86bd1bece6f ("mm/slub: support left redzone")
  ffc79d288000 ("slub: use print_hex_dump")
  2492268472e7 ("SLUB: change error reporting format to follow lockdep loosely")

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Link: https://lore.kernel.org/lkml/cfdb11d7-fb8e-e578-c939-f7f5fb69a6bd@suse.cz/
---
 Documentation/vm/slub.rst | 10 +++++-----
 mm/slub.c                 | 14 +++++++-------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/vm/slub.rst b/Documentation/vm/slub.rst
index 03f294a638bd..d3028554b1e9 100644
--- a/Documentation/vm/slub.rst
+++ b/Documentation/vm/slub.rst
@@ -181,7 +181,7 @@ SLUB Debug output
 Here is a sample of slub debug output::
 
  ====================================================================
- BUG kmalloc-8: Redzone overwritten
+ BUG kmalloc-8: Right Redzone overwritten
  --------------------------------------------------------------------
 
  INFO: 0xc90f6d28-0xc90f6d2b. First byte 0x00 instead of 0xcc
@@ -189,10 +189,10 @@ Here is a sample of slub debug output::
  INFO: Object 0xc90f6d20 @offset=3360 fp=0xc90f6d58
  INFO: Allocated in get_modalias+0x61/0xf5 age=53 cpu=1 pid=554
 
- Bytes b4 0xc90f6d10:  00 00 00 00 00 00 00 00 5a 5a 5a 5a 5a 5a 5a 5a ........ZZZZZZZZ
-   Object 0xc90f6d20:  31 30 31 39 2e 30 30 35                         1019.005
-  Redzone 0xc90f6d28:  00 cc cc cc                                     .
-  Padding 0xc90f6d50:  5a 5a 5a 5a 5a 5a 5a 5a                         ZZZZZZZZ
+ Bytes b4 (0xc90f6d10): 00 00 00 00 00 00 00 00 5a 5a 5a 5a 5a 5a 5a 5a ........ZZZZZZZZ
+ Object   (0xc90f6d20): 31 30 31 39 2e 30 30 35                         1019.005
+ Redzone  (0xc90f6d28): 00 cc cc cc                                     .
+ Padding  (0xc90f6d50): 5a 5a 5a 5a 5a 5a 5a 5a                         ZZZZZZZZ
 
    [<c010523d>] dump_trace+0x63/0x1eb
    [<c01053df>] show_trace_log_lvl+0x1a/0x2f
diff --git a/mm/slub.c b/mm/slub.c
index 3f96e099817a..f91d9fe7d0d8 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -712,15 +712,15 @@ static void print_trailer(struct kmem_cache *s, struct page *page, u8 *p)
 	       p, p - addr, get_freepointer(s, p));
 
 	if (s->flags & SLAB_RED_ZONE)
-		print_section(KERN_ERR, "Redzone ", p - s->red_left_pad,
+		print_section(KERN_ERR, "Redzone  ", p - s->red_left_pad,
 			      s->red_left_pad);
 	else if (p > addr + 16)
 		print_section(KERN_ERR, "Bytes b4 ", p - 16, 16);
 
-	print_section(KERN_ERR, "Object ", p,
+	print_section(KERN_ERR,         "Object   ", p,
 		      min_t(unsigned int, s->object_size, PAGE_SIZE));
 	if (s->flags & SLAB_RED_ZONE)
-		print_section(KERN_ERR, "Redzone ", p + s->object_size,
+		print_section(KERN_ERR, "Redzone  ", p + s->object_size,
 			s->inuse - s->object_size);
 
 	off = get_info_end(s);
@@ -732,7 +732,7 @@ static void print_trailer(struct kmem_cache *s, struct page *page, u8 *p)
 
 	if (off != size_from_object(s))
 		/* Beginning of the filler is the free pointer */
-		print_section(KERN_ERR, "Padding ", p + off,
+		print_section(KERN_ERR, "Padding  ", p + off,
 			      size_from_object(s) - off);
 
 	dump_stack();
@@ -909,11 +909,11 @@ static int check_object(struct kmem_cache *s, struct page *page,
 	u8 *endobject = object + s->object_size;
 
 	if (s->flags & SLAB_RED_ZONE) {
-		if (!check_bytes_and_report(s, page, object, "Redzone",
+		if (!check_bytes_and_report(s, page, object, "Left Redzone",
 			object - s->red_left_pad, val, s->red_left_pad))
 			return 0;
 
-		if (!check_bytes_and_report(s, page, object, "Redzone",
+		if (!check_bytes_and_report(s, page, object, "Right Redzone",
 			endobject, val, s->inuse - s->object_size))
 			return 0;
 	} else {
@@ -928,7 +928,7 @@ static int check_object(struct kmem_cache *s, struct page *page,
 		if (val != SLUB_RED_ACTIVE && (s->flags & __OBJECT_POISON) &&
 			(!check_bytes_and_report(s, page, p, "Poison", p,
 					POISON_FREE, s->object_size - 1) ||
-			 !check_bytes_and_report(s, page, p, "Poison",
+			 !check_bytes_and_report(s, page, p, "End Poison",
 				p + s->object_size - 1, POISON_END, 1)))
 			return 0;
 		/*
-- 
2.25.1

