Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C1545AEA1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 22:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238872AbhKWVvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 16:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238275AbhKWVv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 16:51:27 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97653C061714
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 13:48:18 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id p4so637832qkm.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 13:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dctDXHNU1q9da31Tnsq1sIllSOHxeco7Fe+PBlmDzOE=;
        b=QRtEuFjW+azHFglL/vXbIoRpG2GcaT+OuFjnxiN/cr5tMZOTjkOaxjVqO9BQ2j2T0X
         bvu0kSu9mF8wvz3Wf8GlFhYFxm5YB//jzRPxIHRLdvFDS4NWBXVB8N/iYUTLRQ9yvt9y
         SaPlDSN03ju/2jSmgpd9BE+zEs5gzOHOHHI+zN84xM+BbXA5qLxituZiH7fmtKLHO7J+
         kpyCSiIGpmLr4liw0YTeuT1E5TeQ3WNdNiFNq9TigIC/hv76g+WE0UCwsXS4dEqq2389
         Lqc/PfRaYzHrx93V7f866V6SJ0rxvU3So9Qwxl4olCmYbn/Wn6FSj/QQ3n2rVH5Geec1
         rW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dctDXHNU1q9da31Tnsq1sIllSOHxeco7Fe+PBlmDzOE=;
        b=UB11sI9xTCX4Iha7IV/rpi6arkDBJTRYfpJvR/XQtnAXXVeek/0H9QHMipZ1S7y1+p
         JR35o8szx4grxX4VYslsrgM22td+bBTWw/82t1SBNrRO8IGtjE5DgF+tA8QyDubYTPsj
         IJ3ciRF4tZHinX0r0UZB54bE2vJMOPlTaTKguPo+eo6zgn4uG438FxTeJjOP/7Iw3cWs
         VHb7+ZGyr/KeM67ib5kbcvHSbqRiKRx8jsGFaVJ6GSvfLKohgDAaTrMpvYQn29Kp9qt2
         U8EGTeadzIF1irhnNcNzZfSLvRCbGJHUKhs+x2Pdg/tnTdRHexL5QdGNOnpgA8aZNaXa
         Pg1Q==
X-Gm-Message-State: AOAM533zY8PKpaYeRIkp/hkm52T6JCwtxf3xMZ1Om2MiNIGJB6Ptj/er
        z/rxcbf4kyr4fsV/jX/QLCNTpt9Nv6wPKA==
X-Google-Smtp-Source: ABdhPJwc3RXJ+u83+624gMQXyt2/nbmXULhs3IPZTszA4FyZtBuKlkZRHtG4XO2yMdkMPBFiHZWUPQ==
X-Received: by 2002:a05:620a:4148:: with SMTP id k8mr687064qko.0.1637704097705;
        Tue, 23 Nov 2021 13:48:17 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id i11sm7356912qko.116.2021.11.23.13.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 13:48:16 -0800 (PST)
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
Subject: [PATCH 0/3] page table check
Date:   Tue, 23 Nov 2021 21:48:11 +0000
Message-Id: <20211123214814.3756047-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pasha Tatashin <tatashin@google.com>

Changelog:
v1:
- Added ptep_clear() to mm/debug_vm_pgtable.c (thanks Anshuman Khandual)
- Addressed documentation comments from Jonathan Corbet.

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

Previous versions:
RFC: https://lore.kernel.org/all/20211116220038.116484-1-pasha.tatashin@soleen.com

Pasha Tatashin (3):
  mm: ptep_clear() page table helper
  mm: page table check
  x86: mm: add x86_64 support for page table check

 Documentation/vm/arch_pgtable_helpers.rst |   6 +-
 Documentation/vm/index.rst                |   1 +
 Documentation/vm/page_table_check.rst     |  56 +++++
 MAINTAINERS                               |   9 +
 arch/Kconfig                              |   3 +
 arch/x86/Kconfig                          |   1 +
 arch/x86/include/asm/pgtable.h            |  29 ++-
 include/linux/page_table_check.h          | 147 ++++++++++++
 include/linux/pgtable.h                   |   8 +
 mm/Kconfig.debug                          |  24 ++
 mm/Makefile                               |   1 +
 mm/debug_vm_pgtable.c                     |   2 +-
 mm/khugepaged.c                           |  12 +-
 mm/page_alloc.c                           |   4 +
 mm/page_ext.c                             |   4 +
 mm/page_table_check.c                     | 261 ++++++++++++++++++++++
 16 files changed, 553 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/vm/page_table_check.rst
 create mode 100644 include/linux/page_table_check.h
 create mode 100644 mm/page_table_check.c

-- 
2.34.0.rc2.393.gf8c9666880-goog

