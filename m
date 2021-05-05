Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E95F373409
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 05:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhEEDzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 23:55:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45167 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230465AbhEEDzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 23:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620186890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=N1QqSR2kJ89HqBrkHvTqK0OHz8+QW97ovsc8b69ofO4=;
        b=Z09kAp6K/Qxgk2npz4xFqMqLLkJxKaA6tU8Aqzr6Dr+Dl2cRcLYEGIi1gRmRUuZzDjyoSY
        tCnm84ERiy67Cz9eBHcPRkd9+h9VviDY1nhTCNKphyVMHAAvPhl65tEUJgwhjIU3aohmG8
        5yVlQkKr80D8xaQ+oZp/WBwIkRQ9mfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-fIHtToMSMB6UHtkzkjmpxA-1; Tue, 04 May 2021 23:54:46 -0400
X-MC-Unique: fIHtToMSMB6UHtkzkjmpxA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DCAA107ACCD;
        Wed,  5 May 2021 03:54:44 +0000 (UTC)
Received: from treble.redhat.com (ovpn-115-93.rdu2.redhat.com [10.10.115.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5B651002D71;
        Wed,  5 May 2021 03:54:38 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        David Laight <David.Laight@aculab.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH v4 0/4] x86/uaccess: Use pointer masking to limit uaccess speculation
Date:   Tue,  4 May 2021 22:54:28 -0500
Message-Id: <cover.1620186182.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This one managed to fall through the cracks back in September.  Here's a
fresh new version.

Ideally, we'd switch all access_ok() users to access_ok_mask() or
something, but that's a much bigger change.

I dropped all the ack/review tags because the rebase was significant.

Please review carefully :-)


v4 changes:

- Rebased on the latest.

- Split up into multiple logical patches.

- Renamed "force_user_ptr()" -> "mask_user_ptr()" to prevent confusing
  it with '__force' casting.  [based on Dan's comment]

- Instead of reusing array_index_nospec(), made a new separate inline
  asm statement.  Otherwise it fails the build on recent toolchains
  and/or kernels because the "g" constraint in array_index_mask_nospec()
  isn't big enough for TASK_SIZE_MAX.  I could have changed "g" to "r",
  but that would negatively impact code generation for the other users.


v3 was here:

  https://lore.kernel.org/lkml/1d06ed6485b66b9f674900368b63d7ef79f666ca.1599756789.git.jpoimboe@redhat.com/


Josh Poimboeuf (4):
  uaccess: Always inline strn*_user() helper functions
  uaccess: Fix __user annotations for copy_mc_to_user()
  x86/uaccess: Use pointer masking to limit uaccess speculation
  x86/nospec: Remove barrier_nospec()

 Documentation/admin-guide/hw-vuln/spectre.rst |  6 +--
 arch/x86/include/asm/barrier.h                |  3 --
 arch/x86/include/asm/futex.h                  |  5 ++
 arch/x86/include/asm/uaccess.h                | 48 +++++++++++++------
 arch/x86/include/asm/uaccess_64.h             | 12 ++---
 arch/x86/kernel/cpu/sgx/virt.c                |  6 ++-
 arch/x86/lib/copy_mc.c                        | 10 ++--
 arch/x86/lib/csum-wrappers_64.c               |  5 +-
 arch/x86/lib/getuser.S                        | 16 ++-----
 arch/x86/lib/putuser.S                        |  8 ++++
 arch/x86/lib/usercopy_32.c                    |  6 +--
 arch/x86/lib/usercopy_64.c                    |  7 +--
 lib/iov_iter.c                                |  2 +-
 lib/strncpy_from_user.c                       |  6 ++-
 lib/strnlen_user.c                            |  4 +-
 15 files changed, 89 insertions(+), 55 deletions(-)

-- 
2.31.1

