Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CC7346790
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 19:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhCWS0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 14:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbhCWSZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 14:25:38 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FADC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 11:25:38 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id b21so2692685pfo.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 11:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XqDxfe4GGK69zvJtB/kYAUp+QZJt4kx+lv6J7Sr9tRs=;
        b=pmX4m2+lbq8wnS3lDGZpOiVbrBKH9GZtNYepLlpUhILycXMuqeBz3snMC85G7kSa3Z
         0trYrBGz1Ox/zg4rWqDN8q2a6uuaE/o3qj9T8eNhGxbFlk2H4OH740cB4ZX/7ul7r8+R
         vN+S0vS8w3q0modfq8gt5cRopIK7WH6SHLg3HufwOlaBEIQ5U499dUYeOTkKTO7UIH9p
         plGtyf9P+aH9ogIuDl9ic2r4iouA+ocbS+zhhg6rfLoBEJU62JoB+AY/jKGf5FXXQgpc
         dl+QM4f/C6UPjj7xhpJ8HKMaghCv3XC4+B4xUwLR83CUJZvmciW8GDUZjZ9SI50a7rgp
         SEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XqDxfe4GGK69zvJtB/kYAUp+QZJt4kx+lv6J7Sr9tRs=;
        b=QDfg71AXdDG/uAZ+epncqXdW+RigiTNIyhgpRAsNFEEABcV9oWUCot0aYsuBVE/3Ut
         iNtvC3m0l9ymaZ3Szn69rTuy/PQq6YHznDSRREg2zDRQCzbwN9RjX76cqhPJ4HX4yJbh
         qvwUGzyvV2rMFYZJYyKZM8s3L6CsCkQp7JcaDbC40wCSCuS9R4A/n7avQwxl0RxRD7sl
         6KbtnAbTP/xotpFQ8cb0moT0gTKYKpYH8VDzrraTwdugxf+4H0HRlf1LnpYjpgQkylnM
         KSZDGgi0j+GAB2d9l1r8hn4f9QUDb6I2lCTkJZHd/Tu2jQ/8vXQIvKNjUF6NhmJSkvk3
         kPJw==
X-Gm-Message-State: AOAM531VEE/Xu1f08HFeF58UyFkl11SGMOieMH2nIOG+X3SeJD2eLQIx
        gUUFJVUARKT4LaQZGzPUb0IJrNKzD0ZW
X-Google-Smtp-Source: ABdhPJw89EMS2/MQ8wDqH2rLOe3CHbpDkSo8Pn93HIvJ3T4TR1ONMKvTuAoGolSWr3Iia5mN69ivSciAdNzW
X-Received: from bg.sfo.corp.google.com ([2620:15c:8:10:b047:e98d:2134:b4dd])
 (user=bgeffon job=sendgmr) by 2002:aa7:9493:0:b029:1f8:a493:b747 with SMTP id
 z19-20020aa794930000b02901f8a493b747mr5851808pfk.41.1616523938296; Tue, 23
 Mar 2021 11:25:38 -0700 (PDT)
Date:   Tue, 23 Mar 2021 11:25:20 -0700
In-Reply-To: <20210323182520.2712101-1-bgeffon@google.com>
Message-Id: <20210323182520.2712101-4-bgeffon@google.com>
Mime-Version: 1.0
References: <20210303175235.3308220-1-bgeffon@google.com> <20210323182520.2712101-1-bgeffon@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH] mremap.2: MREMAP_DONTUNMAP to reflect to supported mappings
From:   Brian Geffon <bgeffon@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Brian Geffon <bgeffon@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andy Lutomirski <luto@amacapital.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Dmitry Safonov <dima@arista.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Alejandro Colomar <alx.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mremap(2) now supports MREMAP_DONTUNMAP with mapping types other
than private anonymous.

Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 man2/mremap.2 | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/man2/mremap.2 b/man2/mremap.2
index 3ed0c0c0a..72acbc111 100644
--- a/man2/mremap.2
+++ b/man2/mremap.2
@@ -118,16 +118,6 @@ This flag, which must be used in conjunction with
 remaps a mapping to a new address but does not unmap the mapping at
 .IR old_address .
 .IP
-The
-.B MREMAP_DONTUNMAP
-flag can be used only with private anonymous mappings
-(see the description of
-.BR MAP_PRIVATE
-and
-.BR MAP_ANONYMOUS
-in
-.BR mmap (2)).
-.IP
 After completion,
 any access to the range specified by
 .IR old_address
@@ -227,7 +217,8 @@ was specified, but one or more pages in the range specified by
 .IR old_address
 and
 .IR old_size
-were not private anonymous;
+were part of a special mapping or the mapping is one that
+does not support merging or expanding;
 .IP *
 .B MREMAP_DONTUNMAP
 was specified and
-- 
2.31.0.rc2.261.g7f71774620-goog

