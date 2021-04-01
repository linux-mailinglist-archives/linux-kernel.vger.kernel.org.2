Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1760351F99
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 21:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbhDATWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 15:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbhDATWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 15:22:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A73C049FC3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 11:21:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 71so3517478ybl.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 11:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0N8IRlpZCc+JNO1agCNZJgiEjdZ4z9xnpYX3T0RKHMk=;
        b=YfeCHfRpjn1rmG46iTjwDs/beGhMipksc95TDdIIBPJepeoN1aplkQ4EzMFPolE8ew
         1DNQtu4k7v9q3M7M29NGBMohnTti+WI8IFy7pLVZ+S+IkYeQRyEGmKZCz+JX3T96OkW+
         5spDS9mQ/aflNXqJnLy7K1ADLGI99x/qpx9NPZiWb+ihy11q0JTv4i3DEno7cc9h78xe
         BYHhr0U8MlMwqlwhUygs85XyX5/wgW7yb5cOveBE1No4g/h95mSNL3g0k/AZeyw3Necj
         45bCLIuHb4RzcRt8agHFJscasMLNGnSjou46AqdxaG7kN6qlJESGMgp5rpFVS4pYXoiw
         De3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0N8IRlpZCc+JNO1agCNZJgiEjdZ4z9xnpYX3T0RKHMk=;
        b=P8r5yTPOEFR9Chi7Ir4FZwA1fPzqwJ29aulpno3ydIWbMkiGlfWkSpjxDJruQD0zAj
         5ErQsv/pl5IMnrzO9ILQguqZp6vUh6dZxVq8FyXP4dEuI4cJawm/EDDEbEOttqvvUzrM
         V+twb6jpuf9h+LVUPXdGzyhmA1ZthehPL+OSndGPZ/LD65ahUdonQ90HdyJeWHrlec8R
         0fbcAMI5Z80qs4XwEu28cqrP2zj8Ypjf9fOr+UtJeNxNZH8S5iS18LCjVz8WAgIb3rle
         zM9zKP+KgryazXElNiiRBCYJE4haM7X25W2j4Yv2gEctH+jnR4H+JAbdA8u7cjM0C2+k
         8JTw==
X-Gm-Message-State: AOAM533rrLiFrUZORqKDxoIvZQdXETZj3Qen0xUnP9W30fYSKeB+6YIK
        bWkXE1kGsOj5AJ6ERHnYchk1pH2s00M=
X-Google-Smtp-Source: ABdhPJxdI1+Qsiv6XFFGBskyXGeHiol6mFQlsLm791vMD3iBmxlffuLSrgkVhkZ2zzyfn+F50mjVCev/R0s=
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:899:1066:21fc:b3c5])
 (user=surenb job=sendgmr) by 2002:a25:ce05:: with SMTP id x5mr13383665ybe.146.1617301288517;
 Thu, 01 Apr 2021 11:21:28 -0700 (PDT)
Date:   Thu,  1 Apr 2021 11:21:20 -0700
Message-Id: <20210401182125.171484-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH 0/5] 4.19 backports of fixes for "CoW after fork() issue"
From:   Suren Baghdasaryan <surenb@google.com>
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jannh@google.com, ktkhai@virtuozzo.com,
        torvalds@linux-foundation.org, shli@fb.com, namit@vmware.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We received a report that the copy-on-write issue repored by Jann Horn in
https://bugs.chromium.org/p/project-zero/issues/detail?id=2045 is still
reproducible on 4.14 and 4.19 kernels (the first issue with the reproducer
coded in vmsplice.c). I confirmed this and also that the issue was not
reproducible with 5.10 kernel. I tracked the fix to the following patch
introduced in 5.9 which changes the do_wp_page() logic:

09854ba94c6a 'mm: do_wp_page() simplification'

I backported this patch (#2 in the series) along with 2 prerequisite patches
(#1 and #4) that keep the backports clean and two followup fixes to the main
patch (#3 and #5). I had to skip the following fix:

feb889fb40fa 'mm: don't put pinned pages into the swap cache'

because it uses page_maybe_dma_pinned() which does not exists in earlier
kernels. Because pin_user_pages() does not exist there as well, I *think*
we can safely skip this fix on older kernels, but I would appreciate if
someone could confirm that claim.

The patchset cleanly applies over: stable linux-4.19.y, tag: v4.19.184

Note: 4.14 and 4.19 backports are very similar, so while I backported
only to these two versions I think backports for other versions can be
done easily.

Kirill Tkhai (1):
  mm: reuse only-pte-mapped KSM page in do_wp_page()

Linus Torvalds (2):
  mm: do_wp_page() simplification
  mm: fix misplaced unlock_page in do_wp_page()

Nadav Amit (1):
  mm/userfaultfd: fix memory corruption due to writeprotect

Shaohua Li (1):
  userfaultfd: wp: add helper for writeprotect check

 include/linux/ksm.h           |  7 ++++
 include/linux/userfaultfd_k.h | 10 ++++++
 mm/ksm.c                      | 30 ++++++++++++++++--
 mm/memory.c                   | 60 ++++++++++++++++-------------------
 4 files changed, 73 insertions(+), 34 deletions(-)

-- 
2.31.0.291.g576ba9dcdaf-goog

