Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2676B325FE4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 10:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhBZJU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 04:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhBZJSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:18:18 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8103CC061756
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 01:17:37 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id t18so6365350qva.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 01:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=3ZV7zZPMbpU90hBRfWaNQjlV4YJIoQKZGm7WEWLxpX4=;
        b=bVhcMmIyAbwGbLJBYZ75Qq9rNu19JeSUX5B4gMG2srJgTft177olYXRffkrhdTHnTA
         BRELpmytdqOo1mKL5BOGk77f0O069iHh8TR8mDx1fYQ8IErV8OtvmwGnSjFdWD6qCM8E
         5Z3qyAYaasiI7I7U2iy7nePmC+aKb4N0rBoe8hNh85tTAXQEXomY7GrKeJMIG14qK/rp
         /YaKvpGEoFsBm7+hGRnTeHKSzVYP3d3SUTIDQ3DV5PtxR2pyUHtjGRfuMj09T9ATPsrJ
         /A/KQIjZ1xiHWBlHtpvmFVUQGfspEQwfjfzOXSqwaH3BC5mx+Of1ztfhf/7ekrblccD1
         qSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3ZV7zZPMbpU90hBRfWaNQjlV4YJIoQKZGm7WEWLxpX4=;
        b=KEedIpS+TgXzdeU6VBUy1M6qj3udJGfcmXl+ZO78vtVs+pUwedJijpo39NwXsOnNnZ
         FXzJ8zUaGJd29TZB9N2rICkXFwMg1swGbOou68BiXWMtHK5+8a+1h0IOenf1K0mLpxOt
         tE7xdpnRx8ieEg7fFTFLc1xtF7tlqSocTc5HDFT9oqdnHga4Qmj31UurflFyMib9Ft+o
         K0AXPY79LdJjjWS8OFQfpzxEBs+exsMIXq20tnprm8FOLHi5ViLeM/+zrjyYS/FayNol
         c7lRFFAjsoOGgjlHn/Y/DBkrj5hYjr/oAQTtht8+9DSCwiDjUqT4nC9KWYRf41N+T4PB
         /kZw==
X-Gm-Message-State: AOAM533xZl4ED9gnO1/HR1t7MpIR6g40WbiJ0EMIizcezq1XeHddzFyS
        9dSU8ktJyMrhgaOTzu9EfjIBvKBDOts=
X-Google-Smtp-Source: ABdhPJx8nJVj5jAhSGuPMleKa6a6NW+uOHQVRn7EGIb51y0p35dsddTx/zqDTNTX0eFHlbdcF2Ta3TyGIOA=
Sender: "yuzhao via sendgmr" <yuzhao@yuzhao.bld.corp.google.com>
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:69b6:2618:c96a:ceba])
 (user=yuzhao job=sendgmr) by 2002:a05:6214:aae:: with SMTP id
 ew14mr1604473qvb.24.1614331056594; Fri, 26 Feb 2021 01:17:36 -0800 (PST)
Date:   Fri, 26 Feb 2021 02:17:15 -0700
In-Reply-To: <20210224084807.2179942-1-yuzhao@google.com>
Message-Id: <20210226091718.2927291-1-yuzhao@google.com>
Mime-Version: 1.0
References: <20210224084807.2179942-1-yuzhao@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v2 0/3] trim the uses of compound_head()
From:   Yu Zhao <yuzhao@google.com>
To:     akpm@linux-foundation.org, alex.shi@linux.alibaba.com,
        vbabka@suse.cz, willy@infradead.org
Cc:     guro@fb.com, hannes@cmpxchg.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series "mm: lru related cleanups" starting at commit 42895ea73bcd
("mm/vmscan.c: use add_page_to_lru_list()") bloated vmlinux by 1777
bytes, according to:
  https://lore.kernel.org/linux-mm/85b3e8f2-5982-3329-c20d-cf062b8da71e@suse.cz/

It turned out many places inline Page{Active,Unevictable} which in
turn include compound_head().

From the v1:
  Removing compound_head() entirely from Page{Active,Unevictable} may
  not be the best option (for the moment) because there may be other
  cases that need compound_head().

In addition to picking a couple pieces of low-hanging fruit, this v2
removes compound_head() completely from Page{Active,Unevictable}.

bloat-o-meter result before and after the series:
  add/remove: 0/0 grow/shrink: 6/92 up/down: 697/-7656 (-6959)

Yu Zhao (3):
  mm: bypass compound_head() for PF_NO_TAIL when enforce=1
  mm: use PF_NO_TAIL for PG_lru
  mm: use PF_ONLY_HEAD for PG_active and PG_unevictable

 fs/proc/task_mmu.c         |  3 ++-
 include/linux/page-flags.h | 16 ++++++++--------
 2 files changed, 10 insertions(+), 9 deletions(-)

-- 
2.30.1.766.gb4fecdf3b7-goog
