Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0DA6453C0E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 23:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhKPWDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 17:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbhKPWDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 17:03:40 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DBDC061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 14:00:43 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id l8so677016qtk.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 14:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4dNfZMhPuFcyxePqa0vmlBFT/+rwFJ3uCwWesj1DFsA=;
        b=ly1Rm0wfM5OSyY1KTrTw2dPh6ny3OnlJwVtGy6oD8tYo8mmkmU+BmhrChu8AC/CtpX
         vFTmpUTZi+mJGjufmrs9/WZPAplr3P9y9qHtUknGO6d7NxlBJQofNRkg4qal+F9+5CAl
         nuD75JgslIQKZ86tt5Z+7ud01tCX1RlA4DKc8g/NYxdetRhWGqNl0w1rq83g2svBnbNA
         sIB8Z80zAHsL5eH6+jQg84SF++n3WiwSmM1laayOwXPtBa8QMcKJH3IrIAAoT4nntRbO
         Ql9HSPTFl2NnkRhC2z9Ld4FwgF9R75I5xpQEo7fB/kcbzeL24z9cEl0GE8H98lk2RSsm
         CHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4dNfZMhPuFcyxePqa0vmlBFT/+rwFJ3uCwWesj1DFsA=;
        b=MwzqLhGwK/f6MwhoQBOm/sa5KqyPZ1e71WJpCdfE9UIfBVsQR9MuBBOMJx7hrnNZ0z
         EoAQ0C2b3RmDxaN+c9WjMNqnlvopQp+oWwBOpCcEwDcslO4HHiTNZ5CNTjYAnJ0LvJiS
         z5CJK/jP0J4ARn2p4cSMfJQ+hqo99vqkqIVV5OWECYqtBAilFO90NWFFCZBTuoODxqqX
         26i7IkDSwNFrUiXSLRXb1WF+gOYHc0ewsjV+iIsCzpb/zYBjie7wMZ+gW60ejPRddL8H
         9lwg9bxi8nFvq7dWCqA1kHNa56iQ7gj+kzvHbz1djfZueZV5w4TurJHWFtS9Fb3SR3oo
         uPhw==
X-Gm-Message-State: AOAM533m8Qu0RX1jL/BdqXrBnoRqwxiHTQQH431AGQnXbpsHigL15kja
        yKtXmgR3fNbOXrBEsMFS2lRjQVDlvy2JSw==
X-Google-Smtp-Source: ABdhPJwEhnmfZvJ0sDvT0M5a2V0uMoBVGB/BxRoRe12S3zBcBJRSoNZjuBNfC7dQnuoAGq7wnW4pUQ==
X-Received: by 2002:ac8:7fd0:: with SMTP id b16mr11472042qtk.172.1637100042294;
        Tue, 16 Nov 2021 14:00:42 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id i11sm2975655qko.116.2021.11.16.14.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 14:00:41 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        akpm@linux-foundation.org, rientjes@google.com, pjt@google.com,
        weixugc@google.com, gthelen@google.com, mingo@redhat.com,
        corbet@lwn.net, will@kernel.org, rppt@kernel.org,
        keescook@chromium.org, tglx@linutronix.de, peterz@infradead.org,
        masahiroy@kernel.org, samitolvanen@google.com,
        dave.hansen@linux.intel.com, x86@kernel.org, frederic@kernel.org,
        hpa@zytor.com, aneesh.kumar@linux.ibm.com
Subject: [RFC 0/3] page table check
Date:   Tue, 16 Nov 2021 22:00:35 +0000
Message-Id: <20211116220038.116484-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pasha Tatashin <tatashin@google.com>

Ensure that some memory corruptions are prevented by checking at the
time of insertion of entries into user page tables that there is no
illegal sharing.

We have recently found a problem [1] that existed in kernel since 4.14.
The problem was caused by broken page ref count and led to memory
leaking from one process into another. The problem was accidentally
detected by studying a dump of one process and noticing that one page
contains memory that should not belong to this process.

There are some other page->_refcount related problems that were recently
fixed: [2], [3] which potentially could also lead to illegal sharing.

In addition to hardening refcount [4] itself, this work is an attempt to
prevent this class of memory corruption issues.

It uses a simple state machine that is independent from regular MM logic
to check for illegal sharing at time pages are inserted and removed 
from page tables.

[1] https://lore.kernel.org/all/xr9335nxwc5y.fsf@gthelen2.svl.corp.google.com
[2] https://lore.kernel.org/all/1582661774-30925-2-git-send-email-akaher@vmware.com
[3] https://lore.kernel.org/all/20210622021423.154662-3-mike.kravetz@oracle.com
[4] https://lore.kernel.org/all/20211026173822.502506-1-pasha.tatashin@soleen.com

Pasha Tatashin (3):
  mm: ptep_clear() page table helper
  mm: page table check
  x86: mm: add x86_64 support for page table check

 Documentation/vm/arch_pgtable_helpers.rst |   6 +-
 Documentation/vm/page_table_check.rst     |  53 +++++
 MAINTAINERS                               |   9 +
 arch/Kconfig                              |   3 +
 arch/x86/Kconfig                          |   1 +
 arch/x86/include/asm/pgtable.h            |  27 ++-
 include/linux/page_table_check.h          | 147 ++++++++++++
 include/linux/pgtable.h                   |   8 +
 mm/Kconfig.debug                          |  24 ++
 mm/Makefile                               |   1 +
 mm/khugepaged.c                           |  12 +-
 mm/page_alloc.c                           |   4 +
 mm/page_ext.c                             |   4 +
 mm/page_table_check.c                     | 264 ++++++++++++++++++++++
 14 files changed, 549 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/vm/page_table_check.rst
 create mode 100644 include/linux/page_table_check.h
 create mode 100644 mm/page_table_check.c

-- 
2.34.0.rc1.387.gb447b232ab-goog

