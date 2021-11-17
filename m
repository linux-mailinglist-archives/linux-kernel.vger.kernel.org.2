Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142D5453D94
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 02:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhKQBYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 20:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhKQBYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 20:24:00 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D15C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 17:21:03 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id f20so1107496qtb.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 17:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lsu/+Dlf6nvbIcwhCk1nDEAKiHRAiNEwHnNPLdpCCNI=;
        b=iz+DmZROy+IVt+Y2G2VVdSXUsjtZvtQQXfpLBlxzPuVNTlzOyebumq4rKHQfJDpZgV
         ARKt+eb+2VS2+7webHt82qH0TI7rGj8A5TircT+5CYVDrKoNoS9B2e82vJvpNx0lloIM
         cgTkUXDhfuNNt6JPZOLEViSNjpYPE0/MIipMAtiz9X7Fi5F12qas2D/mrGlse+nWV6g9
         xUj6k1hzJlOHwkq7BBan+Pl3rhHTPhk67vztQefmwb+jhTZDJ4dkCE2PK0zb3PXr7ZZX
         r2//FirkOYJ3qQ7OrprxHNf7eSaCz4TpGAd3KmnTQDJDY9PggIeIiEpVjO0hhn1CVmdF
         3UNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lsu/+Dlf6nvbIcwhCk1nDEAKiHRAiNEwHnNPLdpCCNI=;
        b=1r8zVgfpJgsQZ0FsdsKWHwkLhy9JQgxE7QW+AvgbKZwQEw/+s3BlRl/te0waHOXdMG
         shf4s6gD2L4fmVZXJW7Nq8mdW1xLK9ai5Jb/fZEpA/igxre/OmmnHe8YcaJqKyQnUP1c
         E6DdQcxtmRc2Kxj6TVur52xZ0TP0jvJDO6et2Jbf3WbXbuyDBdHHdrJ29qZKl2VDJ7d3
         +Ecfkift65zAsugxSyCOEhpjKEeQgG28N/BZ1VFq/8W603cgYf3uYkbasJOMdFvFpgdv
         te7PIauf4ROHQcsULC7MXHwZE5QR67dlYcHgwHtVtTplLom35OvcSj2JLJUK+VxC7mgG
         ky6w==
X-Gm-Message-State: AOAM532Rjt81SruilgplUhqBNE73XPMMdAnLz2EsvwePGI+KHfXVbyEU
        BEHVI7CysQ3FqTGPOscEIvHDOA==
X-Google-Smtp-Source: ABdhPJzEiXHAXrib5AI+jV3jGqeNMAXCg9XwRAA02iSxFrGPE6Xu/nJ4VSQHsPSEKxNgj5/ipkQAEA==
X-Received: by 2002:ac8:57ca:: with SMTP id w10mr12661397qta.88.1637112062135;
        Tue, 16 Nov 2021 17:21:02 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id i6sm3482289qti.40.2021.11.16.17.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 17:21:01 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-m68k@lists.linux-m68k.org,
        anshuman.khandual@arm.com, willy@infradead.org,
        akpm@linux-foundation.org, william.kucharski@oracle.com,
        mike.kravetz@oracle.com, vbabka@suse.cz, geert@linux-m68k.org,
        schmitzmic@gmail.com, rostedt@goodmis.org, mingo@redhat.com,
        hannes@cmpxchg.org, guro@fb.com, songmuchun@bytedance.com,
        weixugc@google.com, gthelen@google.com, rientjes@google.com,
        pjt@google.com
Subject: [RFC v2 00/10] Hardening page _refcount
Date:   Wed, 17 Nov 2021 01:20:49 +0000
Message-Id: <20211117012059.141450-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pasha Tatashin <tatashin@google.com>

Changelog:
- use the "fetch" variant instead of "return" of atomic instructions
- allow negative values, as we are using all 32-bits of _refcount.


It is hard to root cause _refcount problems, because they usually
manifest after the damage has occurred.  Yet, they can lead to
catastrophic failures such memory corruptions. There were a number
of refcount related issues discovered recently [1], [2], [3].

Improve debugability by adding more checks that ensure that
page->_refcount never turns negative (i.e. double free does not
happen, or free after freeze etc).

- Check for overflow and underflow right from the functions that
  modify _refcount
- Remove set_page_count(), so we do not unconditionally overwrite
  _refcount with an unrestrained value
- Trace return values in all functions that modify _refcount

Applies against next-20211116.

Previous verions:
RFCv1: https://lore.kernel.org/all/20211026173822.502506-1-pasha.tatashin@soleen.com

[1] https://lore.kernel.org/all/xr9335nxwc5y.fsf@gthelen2.svl.corp.google.com
[2] https://lore.kernel.org/all/1582661774-30925-2-git-send-email-akaher@vmware.com
[3] https://lore.kernel.org/all/20210622021423.154662-3-mike.kravetz@oracle.com

Pasha Tatashin (10):
  mm: page_ref_add_unless() does not trace 'u' argument
  mm: add overflow and underflow checks for page->_refcount
  mm: Avoid using set_page_count() in set_page_recounted()
  mm: remove set_page_count() from page_frag_alloc_align
  mm: avoid using set_page_count() when pages are freed into allocator
  mm: rename init_page_count() -> page_ref_init()
  mm: remove set_page_count()
  mm: simplify page_ref_* functions
  mm: do not use atomic_set_release in page_ref_unfreeze()
  mm: use atomic_cmpxchg_acquire in page_ref_freeze().

 arch/m68k/mm/motorola.c         |   2 +-
 include/linux/mm.h              |   2 +-
 include/linux/page_ref.h        | 159 +++++++++++++++-----------------
 include/trace/events/page_ref.h |  99 +++++++++++++++-----
 mm/debug_page_ref.c             |  30 ++----
 mm/internal.h                   |   6 +-
 mm/page_alloc.c                 |  19 ++--
 7 files changed, 180 insertions(+), 137 deletions(-)

-- 
2.34.0.rc1.387.gb447b232ab-goog

