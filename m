Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DB33E5375
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 08:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237806AbhHJG0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 02:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbhHJG0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 02:26:47 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37634C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 23:26:25 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z2so22505899lft.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 23:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KJblD1y+qHn3wdjDCoDkUfQxp7E9z/k1WwnfUwfIYyM=;
        b=WYP8kUAPCPad7gI6jY98V65Vgu7u4/0nE4cFaF3MnWAhh+uO5OikXIunOk5RNWWCkS
         2L6VtL9haY/GqvhguHP/OSS0aEwBYpZBbwTv59KTSkIWXCAubBcnZv+Ls75+kPb7Hwdr
         QFsD1CY6vuPvVsb34IIukZYV4wBtB8OTcY89cNj4qUQjXOv3Cr67D/BbNJNOcCdgw3jI
         vUDVtu1E7ioVS7PDsYvp93akWuyAEw01sq0vGI5iAfR3lnitOOFNtmVwHjugdjbv8j2t
         VqvUd/LaVckZJjeD2gl4nlS9FnV1DW56dAPD5t5rtIGQEDH4QrcqceouPgW1n3XS3B/+
         ouPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KJblD1y+qHn3wdjDCoDkUfQxp7E9z/k1WwnfUwfIYyM=;
        b=q9NSrPtNiQhGCzRzd0AscA92fQj3LMRVl8fKCIkqzvzRT0QkElN/cg2xVx0757M9XL
         2IzfUQpwK28Y0fqrML4lXrm/CBSZIsW4GUa1n4DfrnbmKSwDkcOulRqUaGdw5z8EkBrY
         o9oPaq5PUoaGpE7BZrwY0GZiUIF73Pf58FaAeLYdIi+PlomqF5iOZ6aHwExFv6nqL3u1
         9A1b6ORoSIPZHaJa4/bKVILIQt0WEJ4d0AKKcufrv9b6i+wL9w0j/jWjFGomyN0v53YP
         jr+nx3PIu+IxJ7fu/KEn3594yxqu91LCJCmwaxh6QjNfxkHWjuxyVYvTCXE4tiho9msG
         ybbw==
X-Gm-Message-State: AOAM533oVcoNgVLIVbWvyqlrOOAz5sLzPkKum0PbQKqqfdLw7PEWPXJn
        yihuOqRnjJq6wqQMcCva7wxToA==
X-Google-Smtp-Source: ABdhPJwEfhyq1oDAPUD+NUvsniIszXrUrcqLIpaj8cWNmXevuFhB6Zr+WNuDP199OnFXqedrudhx9A==
X-Received: by 2002:ac2:4472:: with SMTP id y18mr20677419lfl.137.1628576783588;
        Mon, 09 Aug 2021 23:26:23 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c9sm1957788lfr.46.2021.08.09.23.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 23:26:22 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 8BED5102BBF; Tue, 10 Aug 2021 09:26:34 +0300 (+03)
To:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 0/5] x86: Impplement support for unaccepted memory
Date:   Tue, 10 Aug 2021 09:26:21 +0300
Message-Id: <20210810062626.1012-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UEFI Specification version 2.9 introduces concept of memory acceptance:
Some Virtual Machine platforms, such as Intel TDX or AMD SEV-SNP,
requiring memory to be accepted before it can be used by the guest.
Accepting happens via a protocol specific for the Virtrual Machine
platform.

Accepting memory is costly and it makes VMM allocate memory for the
accepted guest physical address range. We don't want to accept all memory
upfront.

The patchset implements on-demand memory acceptance for TDX.

Please, review. Any feedback is welcome.

Kirill A. Shutemov (5):
  mm: Add support for unaccepted memory
  efi/x86: Implement support for unaccepted memory
  x86/boot/compressed: Handle unaccepted memory
  x86/mm: Provide helpers for unaccepted memory
  x86/tdx: Unaccepted memory support

 Documentation/x86/zero-page.rst              |  1 +
 arch/x86/Kconfig                             |  1 +
 arch/x86/boot/compressed/Makefile            |  1 +
 arch/x86/boot/compressed/bitmap.c            | 86 ++++++++++++++++++++
 arch/x86/boot/compressed/kaslr.c             | 14 +++-
 arch/x86/boot/compressed/misc.c              |  9 ++
 arch/x86/boot/compressed/tdx.c               | 29 +++++++
 arch/x86/boot/compressed/unaccepted_memory.c | 51 ++++++++++++
 arch/x86/include/asm/page.h                  |  5 ++
 arch/x86/include/asm/tdx.h                   |  2 +
 arch/x86/include/asm/unaccepted_memory.h     | 17 ++++
 arch/x86/include/uapi/asm/bootparam.h        |  3 +-
 arch/x86/kernel/tdx.c                        |  8 ++
 arch/x86/mm/Makefile                         |  2 +
 arch/x86/mm/unaccepted_memory.c              | 84 +++++++++++++++++++
 drivers/firmware/efi/Kconfig                 | 12 +++
 drivers/firmware/efi/efi.c                   |  1 +
 drivers/firmware/efi/libstub/x86-stub.c      | 75 ++++++++++++++---
 include/linux/efi.h                          |  3 +-
 mm/internal.h                                | 14 ++++
 mm/memblock.c                                |  1 +
 mm/page_alloc.c                              | 13 ++-
 22 files changed, 414 insertions(+), 18 deletions(-)
 create mode 100644 arch/x86/boot/compressed/bitmap.c
 create mode 100644 arch/x86/boot/compressed/unaccepted_memory.c
 create mode 100644 arch/x86/include/asm/unaccepted_memory.h
 create mode 100644 arch/x86/mm/unaccepted_memory.c

-- 
2.31.1

