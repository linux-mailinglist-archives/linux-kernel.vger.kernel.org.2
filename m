Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D67375D60
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 01:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbhEFX0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 19:26:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60075 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231765AbhEFX0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 19:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620343545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wdtiudLSXqX9mG3wVVY1C6HQ27m2h7nYkQwJQU/EgKg=;
        b=JC8SRgS5wfwkOmmwG1HkXyOIXQVSrSNOhAA6xF4HCsL8CVcDz7xWwDFw7snciyH3x3QBBv
        Q6S8H3gxUIj75jCnmjNRv61UH17Ok8Ppzoru9II9DnPJk/1taI2L/DfltoOIAQnHhTZ4cT
        787hHm4CcSOMNPwTXerJXDB+rQtcyPs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-1DRLckaeOt-QkUBqodOtrg-1; Thu, 06 May 2021 19:25:44 -0400
X-MC-Unique: 1DRLckaeOt-QkUBqodOtrg-1
Received: by mail-qt1-f199.google.com with SMTP id i12-20020ac860cc0000b02901cb6d022744so4561637qtm.20
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 16:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wdtiudLSXqX9mG3wVVY1C6HQ27m2h7nYkQwJQU/EgKg=;
        b=KNwSnn8wizq9uLJCXC4CMrltDsL8w0rUUJjWwYdOe7XKIZ4vB+RwrAlHpYB+D72Jmx
         Lo6QqzOe+jFF1ibGob1VOiC/Gg4tto0Tlo+ialAkqUhBbc82qSvOwosRgSRA/fhhmeLO
         dJfbS71XPTdOle0dbquMtr3m/tgSB9fPbmOryR/GN0Aj+6/nUgkDT1ifQRh9jKbkvC1v
         e4ExnYjAqq0BgRKMSEmZim86+g5s//oitshqHuJm5p7EfDI4cLZAmJ3tcxet7dvvI/fZ
         v9jxFbUuewAsRy3CgrordklT24Yb0urRagyERIF3Edugh+AiXFiecE35h82+tyBTKy0K
         YdOw==
X-Gm-Message-State: AOAM530AZOVsNfxUtGvZt5fbb47+3HUEBiZkI3iss+06ve2Sge0S8aCy
        3T9JLwRV2bijJBzWkd7IcoEpsa4RnDs8E8Zaw1qHV+QpnU29Ml7t5lj1i8l9mUIl41pEyoGmIU7
        K5KG1oHYSvsEZ85zhxRmKgN++
X-Received: by 2002:ac8:5fd5:: with SMTP id k21mr3071546qta.231.1620343543487;
        Thu, 06 May 2021 16:25:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3dk/t7SX3sfbhwUbA67QTp2M/7n3z1E6C0HGX6OS4HRvcdqLfWnmNr2vPMSeg4IVAFExKaA==
X-Received: by 2002:ac8:5fd5:: with SMTP id k21mr3071528qta.231.1620343543208;
        Thu, 06 May 2021 16:25:43 -0700 (PDT)
Received: from t490s.redhat.com (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id q13sm1605026qkn.10.2021.05.06.16.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 16:25:42 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH 2/3] mm: gup: allow FOLL_PIN to scale in SMP
Date:   Thu,  6 May 2021 19:25:36 -0400
Message-Id: <20210506232537.165788-3-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210506232537.165788-1-peterx@redhat.com>
References: <20210506232537.165788-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Arcangeli <aarcange@redhat.com>

has_pinned cannot be written by each pin-fast or it won't scale in
SMP. This isn't "false sharing" strictly speaking (it's more like
"true non-sharing"), but it creates the same SMP scalability
bottleneck of "false sharing".

To verify the improvement a new "pin_fast.c" program was added to
the will-it-scale benchmark.

== pin_fast.c - start ==
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 #define _GNU_SOURCE
 #include <fcntl.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <string.h>
 #include <assert.h>
 #include <sys/prctl.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>

 /* exercises pin_user_pages_fast, requires a kernel with CONFIG_GUP_TEST=y */
 char *testcase_description = "pin_user_pages_fast SMP scalability benchmark";

 static int gup_fd;
 #define NR_PAGES 1024
 #define BUFLEN (getpagesize() * NR_PAGES)

 #define GUP_TEST_MAX_PAGES_TO_DUMP		8
 #define PIN_FAST_BENCHMARK	_IOWR('g', 2, struct gup_test)

 struct gup_test {
 	__u64 get_delta_usec;
 	__u64 put_delta_usec;
 	__u64 addr;
 	__u64 size;
 	__u32 nr_pages_per_call;
 	__u32 flags;
 	/*
 	 * Each non-zero entry is the number of the page (1-based: first page is
 	 * page 1, so that zero entries mean "do nothing") from the .addr base.
 	 */
 	__u32 which_pages[GUP_TEST_MAX_PAGES_TO_DUMP];
 };

 void testcase_prepare(unsigned long nr_tasks)
 {
 	gup_fd = open("/sys/kernel/debug/gup_test", O_RDWR);
 	assert(gup_fd >= 0);
 }

 void testcase(unsigned long long *iterations, unsigned long nr)
 {
 	char *p = aligned_alloc(getpagesize()*512, BUFLEN);
 	assert(p);
 	assert(!madvise(p, BUFLEN, MADV_HUGEPAGE));
 	for (int i = 0; i < NR_PAGES; i++)
 		p[getpagesize()*i] = 0;

 	struct gup_test gup = {
 		.size = BUFLEN,
 		.addr = (unsigned long)p,
 		.nr_pages_per_call = 1,
 	};

 	while (1) {
 		assert(!ioctl(gup_fd, PIN_FAST_BENCHMARK, &gup));

 		(*iterations)++;
 	}

 	free(p);
 }

 void testcase_cleanup(void)
 {
 	assert(!close(gup_fd));
 }
== pin_fast.c - end ==

The pin_fast will-it-scale benchmark was run with 1 thread per-CPU
on this 2 NUMA nodes system:

available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191
node 0 size: 128792 MB
node 0 free: 126741 MB
node 1 cpus: 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255
node 1 size: 128944 MB
node 1 free: 127330 MB
node distances:
node   0   1
  0:  10  32
  1:  32  10

Before this commit (average 25617 +- 0.16%):

tasks,processes,processes_idle,threads,threads_idle,linear
0,0,100,0,100,0
256,0,0.00,25641,0.17,0
tasks,processes,processes_idle,threads,threads_idle,linear
0,0,100,0,100,0
256,0,0.00,25652,0.16,0
tasks,processes,processes_idle,threads,threads_idle,linear
0,0,100,0,100,0
256,0,0.00,25559,0.16,0

After this commit (average 1194790 +- 0.11%):

tasks,processes,processes_idle,threads,threads_idle,linear
0,0,100,0,100,0
256,0,0.00,1196513,0.19,0
tasks,processes,processes_idle,threads,threads_idle,linear
0,0,100,0,100,0
256,0,0.00,1194664,0.19,0
tasks,processes,processes_idle,threads,threads_idle,linear
0,0,100,0,100,0
256,0,0.00,1193194,0.19,0

This commits increases the SMP scalability of pin_user_pages_fast()
executed by different threads of the same process by more than 4000%.

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 63a079e361a3d..8b513e1723b45 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1292,7 +1292,7 @@ static __always_inline long __get_user_pages_locked(struct mm_struct *mm,
 		BUG_ON(*locked != 1);
 	}
 
-	if (flags & FOLL_PIN)
+	if (flags & FOLL_PIN && !atomic_read(&mm->has_pinned))
 		atomic_set(&mm->has_pinned, 1);
 
 	/*
@@ -2617,7 +2617,7 @@ static int internal_get_user_pages_fast(unsigned long start,
 				       FOLL_FAST_ONLY)))
 		return -EINVAL;
 
-	if (gup_flags & FOLL_PIN)
+	if (gup_flags & FOLL_PIN && !atomic_read(&current->mm->has_pinned))
 		atomic_set(&current->mm->has_pinned, 1);
 
 	if (!(gup_flags & FOLL_FAST_ONLY))
-- 
2.31.1

