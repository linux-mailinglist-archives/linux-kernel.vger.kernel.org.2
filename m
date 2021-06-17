Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B1F3AAFB6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 11:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhFQJcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbhFQJcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:32:45 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE00C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 02:30:38 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id v7so4499227pgl.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 02:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SYbkYhz8dgvzCxm2xx3ltQCVLS/WASlN9bfsoiUbbWc=;
        b=pyG2ezEonhSZpmiR9w4aRgJpSw8RrKIDfEN/1ZUcre+W2p6ZZp510AFg5X+vESCJmb
         DHG57hmznembCe+kf0HzmpX+0NbvWrMoC1SgDOwiwp3p+Mn6W5adffrRP22cXsE4JyRZ
         B1E116SwPNZiYGO0a+nvyOoy173iS+c0O04a8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SYbkYhz8dgvzCxm2xx3ltQCVLS/WASlN9bfsoiUbbWc=;
        b=O10DmNnRKDAYCtAJo5nR+TzAx0L++OC4KNHTpfXbimPwxLvBRoMENXJET3RBEommT6
         6QlDOsrfHkqx1Rjvjufp6TgibxKPKlRj5BLHUebsPE7m6keNRk+GQtfRne7Ps4/Jfvav
         tanas7G6Jfy1dOauMKLhsFTeGU0RSdwvMjosi2inTj5qx/HqDQt3X98k8fJy0jDDizc7
         lo19pKwtK7Qg65ch5R7hNGnEnXeVnLwgZIxNAZxjYKmNl+1roOHTIRQb8P/2mqa+/rBp
         QYg4aVRQjsqMohoGZHVdgfzp7k6pZ63BHWyYNtwRSaKHs1WJG8qnSctbf9FcqS8p4yOT
         e2gQ==
X-Gm-Message-State: AOAM532G4O6BpGem4eIZRKRBbkGg9HG2YkKQLOpiXX4lIi1BeFt/lEG8
        bcoEgW7n7rApaFHN7RNVWNRITa4R2zvX+g==
X-Google-Smtp-Source: ABdhPJw/s1VjEh3D7QkWvCRIIEN5527xrRUM8tuxsJLqyJbkFYCVDMC6zwTDygQITZ2gT3hpvoSTwA==
X-Received: by 2002:a62:b502:0:b029:2ec:a539:e29b with SMTP id y2-20020a62b5020000b02902eca539e29bmr4319275pfe.37.1623922237921;
        Thu, 17 Jun 2021 02:30:37 -0700 (PDT)
Received: from localhost ([203.206.29.204])
        by smtp.gmail.com with ESMTPSA id fs10sm7733847pjb.31.2021.06.17.02.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 02:30:37 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, elver@google.com,
        akpm@linux-foundation.org, andreyknvl@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu,
        aneesh.kumar@linux.ibm.com, bsingharora@gmail.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v15 0/4] KASAN core changes for ppc64 radix KASAN
Date:   Thu, 17 Jun 2021 19:30:28 +1000
Message-Id: <20210617093032.103097-1-dja@axtens.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building on the work of Christophe, Aneesh and Balbir, I've ported
KASAN to 64-bit Book3S kernels running on the Radix MMU. I've been
trying this for a while, but we keep having collisions between the
kasan code in the mm tree and the code I want to put in to the ppc
tree.

This series just contains the kasan core changes that we need. These
can go in via the mm tree. I will then propose the powerpc changes for
a later cycle. (The most recent RFC for the powerpc changes is in the
v12 series at
https://lore.kernel.org/linux-mm/20210615014705.2234866-1-dja@axtens.net/
)

v15 applies to next-20210611. There should be no noticeable changes to
other platforms.

Changes since v14: Included a bunch of Reviewed-by:s, thanks
Christophe and Marco. Cleaned up the build time error #ifdefs, thanks
Christophe.

Changes since v13: move the MAX_PTR_PER_* definitions out of kasan and
into pgtable.h. Add a build time error to hopefully prevent any
confusion about when the new hook is applicable. Thanks Marco and
Christophe.

Changes since v12: respond to Marco's review comments - clean up the
help for ARCH_DISABLE_KASAN_INLINE, and add an arch readiness check to
the new granule poisioning function. Thanks Marco.

Daniel Axtens (4):
  kasan: allow an architecture to disable inline instrumentation
  kasan: allow architectures to provide an outline readiness check
  mm: define default MAX_PTRS_PER_* in include/pgtable.h
  kasan: use MAX_PTRS_PER_* for early shadow tables

 arch/s390/include/asm/pgtable.h     |  2 --
 include/asm-generic/pgtable-nop4d.h |  1 -
 include/linux/kasan.h               |  6 +++---
 include/linux/pgtable.h             | 22 ++++++++++++++++++++++
 lib/Kconfig.kasan                   | 14 ++++++++++++++
 mm/kasan/common.c                   |  4 ++++
 mm/kasan/generic.c                  |  3 +++
 mm/kasan/init.c                     |  6 +++---
 mm/kasan/kasan.h                    |  6 ++++++
 mm/kasan/shadow.c                   |  8 ++++++++
 10 files changed, 63 insertions(+), 9 deletions(-)

-- 
2.30.2

