Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39BC346511
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 17:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbhCWQ1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 12:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbhCWQ0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 12:26:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D98FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 09:26:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e129so3143441yba.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 09:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XqDxfe4GGK69zvJtB/kYAUp+QZJt4kx+lv6J7Sr9tRs=;
        b=BN4R/SJlfmcF5MRIrxPoBwW20iiC/MHlTCW0VYed+6puAkNQS0W8hNYSc0z3VZrKU7
         SdXClPSNc/C/NYsLV4vTi4vZNc0/AGi6qDvqmUlUHAWNi4uLCVSE5gkZW6mJVHRL99mI
         ltJGMNh4n8loh4cIEsHnQsKiC39Ni2bg1YeHvygmRR2iWfGS8EZTOCZ0I1Vx0j9d9YYP
         cZ8DxeGA/D6uP80gCQxVsnPLg8Gp/0X4PGa1LkJArMpKk0FZ8bqNE7gVDZcdP2rFckJK
         ufL1CAcGTTDMXnnUszwKKTePG8XQ5cGF2FOgn72T31iZNhUwepjLyvL4po2DtVT06tOU
         u08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XqDxfe4GGK69zvJtB/kYAUp+QZJt4kx+lv6J7Sr9tRs=;
        b=qG5ST2SHCFw3oJJ0ke0UF1CdhmejH+qVNAsq9tbp4Piwy5QXzYKCeKcgYzeJKNDkqh
         waN4xiW7LU9utIRPy/+qy3veDH13pX8ZqhcicSHyZ+9mtS3g2n6GSTwswxUd1jUH6UuH
         Bya10LGTvid9Vef2rQPySFDBEpGbMYl+54btTfm0aCGCZJ3xYkoMnDihHTsMH0Q19MVe
         somFifeGgSWYfF53JrFD7W+s6eayPwTzGk5/meP5CM1/zlsEMHFaQeT9iTWIFZ8+6ttM
         viOmY41OsLpUh3g+hQAdVYeqvRhQs5DR6t29Gndn7V/W+kictrt2JahTJ4308OJsZGq4
         rYbw==
X-Gm-Message-State: AOAM532fJstPMcRZvku3LbUcpo8xcOaS2unOlm9PpAHVgbxa9ai7U1Tz
        ATb8DIQrV92NcJZzsz3/I9uVh3X3xdd5
X-Google-Smtp-Source: ABdhPJyY6VFYJLcVfPwJqFGB/P8vkSlXhFXE+bJzCD7z0F2IHTQD7BmT8z01lHuh89TOcB3QZeNXivPGk6B0
X-Received: from bg.sfo.corp.google.com ([2620:15c:8:10:b5cc:cacb:2875:ae6e])
 (user=bgeffon job=sendgmr) by 2002:a25:58c5:: with SMTP id
 m188mr6582856ybb.286.1616516784790; Tue, 23 Mar 2021 09:26:24 -0700 (PDT)
Date:   Tue, 23 Mar 2021 09:26:11 -0700
In-Reply-To: <20210323162611.2398613-1-bgeffon@google.com>
Message-Id: <20210323162611.2398613-4-bgeffon@google.com>
Mime-Version: 1.0
References: <20210303175235.3308220-1-bgeffon@google.com> <20210323162611.2398613-1-bgeffon@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
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

