Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4729F442105
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 20:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhKATqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 15:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhKATqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 15:46:12 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5298C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 12:43:38 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id k2so2769505pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 12:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Ukfv7pdz0nMzxtQVrVKwSDs1iv/takb0qfr2vtUbBY=;
        b=DSgl+6WFZBpfISZNBj2g74k1FtWOu+ZlnfYg5QRFVMk98z8CnmEo/lD9kDZHHy101P
         VuVt2lKmD8nHMekVctclmHiT3IYIe8xn7Qx3htwOUSugXBdBJv2V8RWnT24Tk29rn/2R
         zMuR+9kzS9IbOAwrLmx+LLGcP0uwcL0KYHz5cK9sTjV+4xEPdEPoNKaXUoB+m8r3Dc+d
         hvm2RNsCPDvV4tXpwR6sFxOQtwxQjvKZjbK9XcHuGe+mv+O6/zOpoS7S163OUcqtZGEx
         3dfUH5/qEOdBcgVESUJu0AZfnvEqnK8ethA9KcG60IqVRcbrp3tI0Syvp3ZOba4tFbMI
         Y6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Ukfv7pdz0nMzxtQVrVKwSDs1iv/takb0qfr2vtUbBY=;
        b=fLpMzYlSrgtaLsaR4ZeqhioEl3gjMvLD+HSpMQegaHLqIL2Xjff9On12yIA9MPfIHW
         wjDkXDvXeZQK4JMWX0A1Y2kDGD3veSB6pMsIhSdP0jfKFqBCU04l3l2AcM75ycSwDAIZ
         jHgZjknFjdpQe2W0N/kmFHK1Edif5CaQDdfTxEi2guFUslw5K5BqaJ3veIP7bIgS9jd9
         pKHPYonlYUSdjxhdvj96IK2o3fzdrgTJh4tGaue8vB+i6FF5nhVvB+pP6uuuKATkH8bl
         teyKx9cKtg0+fv6Bn0PhieLE9ba531u1l1BMcI//sxOCQQDjTrn4NZvaNAixlfNUFJV9
         RRCA==
X-Gm-Message-State: AOAM531aAgWeqbYKxsxRXAzD7TJsYbEuO63XTdbUG40B5+zshBXtLBTm
        ncQFUSI55U5v82oMKHDy/2k=
X-Google-Smtp-Source: ABdhPJz1EFCgRQt0FEm5r3xoBF+RDEU3HqMkdy/9HTH56ECJpk1YZTHP0liUuXiqqZXBnRZ1YTralQ==
X-Received: by 2002:a65:6554:: with SMTP id a20mr11155635pgw.107.1635795818470;
        Mon, 01 Nov 2021 12:43:38 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id c1sm14306887pfv.54.2021.11.01.12.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 12:43:37 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     naresh.kamboju@linaro.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com, naoya.horiguchi@nec.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: page-flags: fix build failure due to missing parameter for HasHWPoisoned flag
Date:   Mon,  1 Nov 2021 12:43:36 -0700
Message-Id: <20211101194336.305546-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The below build failure when !CONFIG_MEMORY_FAILURE was reported for
v5.16 merge window:
In file included from include/linux/mmzone.h:22,
                 from include/linux/gfp.h:6,
                 from include/linux/slab.h:15,
                 from include/linux/crypto.h:20,
                 from arch/x86/kernel/asm-offsets.c:9:
include/linux/page-flags.h:806:29: error: macro "PAGEFLAG_FALSE"
requires 2 arguments, but only 1 given
  806 | PAGEFLAG_FALSE(HasHWPoisoned)
      |                             ^
include/linux/page-flags.h:411: note: macro "PAGEFLAG_FALSE" defined here
  411 | #define PAGEFLAG_FALSE(uname, lname) TESTPAGEFLAG_FALSE(uname, lname)   \
      |
include/linux/page-flags.h:807:39: error: macro "TESTSCFLAG_FALSE"
requires 2 arguments, but only 1 given
  807 |         TESTSCFLAG_FALSE(HasHWPoisoned)
      |                                       ^
include/linux/page-flags.h:414: note: macro "TESTSCFLAG_FALSE" defined here
  414 | #define TESTSCFLAG_FALSE(uname, lname)
         \
      |
include/linux/page-flags.h:806:1: error: unknown type name 'PAGEFLAG_FALSE'
  806 | PAGEFLAG_FALSE(HasHWPoisoned)
      | ^~~~~~~~~~~~~~
include/linux/page-flags.h:807:25: error: expected ';' before 'static'
  807 |         TESTSCFLAG_FALSE(HasHWPoisoned)
      |                         ^
      |                         ;
......
  815 | static inline bool is_page_hwpoison(struct page *page)
      | ~~~~~~
make[2]: *** [scripts/Makefile.build:121: arch/x86/kernel/asm-offsets.s] Error 1

The commit d389a4a81155 ("mm: Add folio flag manipulation functions")
changed the definition of PAGEFLAG macros, this caused the build failure
for HasHWPoisoned flag.  The new flag was introduced by commit
eac96c3efdb5 ("mm: filemap: check if THP has hwpoisoned subpage for PMD
page fault") in v5.15-rc7.  But the folio series pull request was
prepared before v5.15, so this new flag was missed.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/page-flags.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index d8623d6e1141..981341a3c3c4 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -803,8 +803,8 @@ PAGEFLAG_FALSE(DoubleMap, double_map)
 PAGEFLAG(HasHWPoisoned, has_hwpoisoned, PF_SECOND)
 	TESTSCFLAG(HasHWPoisoned, has_hwpoisoned, PF_SECOND)
 #else
-PAGEFLAG_FALSE(HasHWPoisoned)
-	TESTSCFLAG_FALSE(HasHWPoisoned)
+PAGEFLAG_FALSE(HasHWPoisoned, has_hwpoisoned)
+	TESTSCFLAG_FALSE(HasHWPoisoned, has_hwpoisoned)
 #endif
 
 /*
-- 
2.26.2

