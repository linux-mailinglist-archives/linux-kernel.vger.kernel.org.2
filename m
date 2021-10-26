Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19FF243B847
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 19:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbhJZRkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 13:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235515AbhJZRku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 13:40:50 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31ACC061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 10:38:25 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id bp7so15868186qkb.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 10:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1wFVuNwCQDYBl4y+oheYP9hytkXQV86RHdzyMeLYvHo=;
        b=DgmpiJ5a4TBPAgk9kfH34K6GHXyXVUok93gbxtPSDZBT9hSEB3TNmKPMh7S4AdUTiY
         vaIa4rtpH/4yK9n/egQL2T/v1rb+40jk3YhuPBIAeznL3+Vg1ti7X+Vcb+l1jLhx0iyU
         +BnmNbsW4WV1mWaqP2dMLeNKUDszdu82/Pyv1tELesYUa6S2ecc7KEe2/6n96YRqURfn
         GnbGn8c5PTRw1aLI869AqkjrrDCfAN8wCwfPF/cmo9xQRxFSIs2rL5owDcZcGOEVg2kx
         QD0pEfbdtm8G0v6vbHSs95Wq2qjtBZ6SlG3j7qJv/OZfm/WB5BBY6r44gUnhdUv1+LiI
         GxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1wFVuNwCQDYBl4y+oheYP9hytkXQV86RHdzyMeLYvHo=;
        b=SdcnEHL0k2G7sYwg2hfMzBp5qfyqCWHjvnJ3QYScLl/TmobL9ISMV45X0fUpFHle6o
         Q93Opzdww9Kno4QSEh5oJkTaHLtWaubBzRpngttGwL3at6zYtbtKpkVQ64kUDU4Q/e1w
         SxU+Q/v/FG13Zgwa6C00r7Lbkb1cl4J1jXIP8Yaivn2P7VoZeiT/o+IuLtLHaGW+80Bs
         0BzijoqDdj12s0I8Ihx+Fm6ndP+kSpVUT+zi00i9Ow0fpuUay//CU2HIGjvPTdiDzR6s
         uU04hw0qyAPoGifQdOeltd3PLP9nWH3XRjcfT2ELlsBqyadO3dMT3UgIDXv/AQT+ckqC
         dnnA==
X-Gm-Message-State: AOAM531nrDYX+WmimXlA/rqwKMBmtV2w6uASNM2uEBkMDV1ddENcMDZc
        K15UewborykVIuh6V6PocaQp8w==
X-Google-Smtp-Source: ABdhPJyMZJkPL/lBXsv80gSA7jyRMzmSsRuOz4irGOx6Nwzcx1LmjIDkWSNzBFsXqrtVX0RQFW5FWA==
X-Received: by 2002:ae9:f813:: with SMTP id x19mr4851895qkh.198.1635269904891;
        Tue, 26 Oct 2021 10:38:24 -0700 (PDT)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id bj37sm11001939qkb.49.2021.10.26.10.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 10:38:24 -0700 (PDT)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-m68k@lists.linux-m68k.org,
        anshuman.khandual@arm.com, willy@infradead.org,
        akpm@linux-foundation.org, william.kucharski@oracle.com,
        mike.kravetz@oracle.com, vbabka@suse.cz, geert@linux-m68k.org,
        schmitzmic@gmail.com, rostedt@goodmis.org, mingo@redhat.com,
        hannes@cmpxchg.org, guro@fb.com, songmuchun@bytedance.com,
        weixugc@google.com, gthelen@google.com
Subject: [RFC 0/8] Hardening page _refcount
Date:   Tue, 26 Oct 2021 17:38:14 +0000
Message-Id: <20211026173822.502506-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is hard to root cause _refcount problems, because they usually
manifest after the damage has occurred.  Yet, they can lead to
catastrophic failures such memory corruptions.

Improve debugability by adding more checks that ensure that
page->_refcount never turns negative (i.e. double free does not
happen, or free after freeze etc).

- Check for overflow and underflow right from the functions that
  modify _refcount
- Remove set_page_count(), so we do not unconditionally overwrite
  _refcount with an unrestrained value
- Trace return values in all functions that modify _refcount

Applies against v5.15-rc7. Boot tested in QEMU.

Pasha Tatashin (8):
  mm: add overflow and underflow checks for page->_refcount
  mm/hugetlb: remove useless set_page_count()
  mm: Avoid using set_page_count() in set_page_recounted()
  mm: remove set_page_count() from page_frag_alloc_align
  mm: avoid using set_page_count() when pages are freed into allocator
  mm: rename init_page_count() -> page_ref_init()
  mm: remove set_page_count()
  mm: simplify page_ref_* functions

 arch/m68k/mm/motorola.c         |   2 +-
 include/linux/mm.h              |   2 +-
 include/linux/page_ref.h        | 116 ++++++++++++++++----------------
 include/trace/events/page_ref.h |  66 +++++++++++-------
 mm/debug_page_ref.c             |  22 ++----
 mm/hugetlb.c                    |   2 +-
 mm/internal.h                   |   5 +-
 mm/page_alloc.c                 |  19 ++++--
 8 files changed, 125 insertions(+), 109 deletions(-)

-- 
2.33.0.1079.g6e70778dc9-goog

