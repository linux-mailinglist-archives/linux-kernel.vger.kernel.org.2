Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88789442474
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 00:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbhKBABx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 20:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbhKBABu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 20:01:50 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75A8C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 16:59:16 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id f1so17429490qto.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 16:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=FkaNvoDsGOAygrt8rCxvHLIv2s9JnK9uDBFT7bc7q5E=;
        b=Z/NWnxRLVBwHOMIyp4qQbHvop4i10seT8np6sn0mAurNOOkkhR0rXFuyfDXTz14oXf
         IxthXmqSCg2OWeYCkpp6Nq7c2bAZU1Bun9PoAfmi+XRnHQ/Bzc2Lg6QZ0umcWp7jiBrH
         oWB2dXcXI+lCh58vO1bxdMpdDzwSn9Nxyyq0RLuIRx2lOt79Jo/30Ke/aFHHRJUzEOPY
         jiGArhgdA3JcKLRZj+FXlUnWLoiM6UMWpl1gX7NMZNPBKVn3rXTi1btbWq0txiUQpcw3
         YNapeBvp1caQHqPcLh7MF6XbX5swGYked5qEtAg1yRi5lvcyBTxl/Gg62oPq/G12pRHL
         XLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FkaNvoDsGOAygrt8rCxvHLIv2s9JnK9uDBFT7bc7q5E=;
        b=VjDqTyiOWOgXRGI9uHU6uxptawgKtAt0+yDM+Imp3fnp6gc1BiXnT1KFSan6zDghGd
         IIhgUlyRflB2e8dn8n4jecGZyRxTyjZTCe2eotJI2Fc7KU82jDmgwNtxWVBGWuLuFuD4
         oXEDybCYPk0EINQzPwABdAMvNZJC0EkZWWblIifFURMcvpRqaBb93retosihaHRb2was
         yf+SHRL6n6HAKWYkTfp3Xis4Flt+oO0QR0o/n1zVvXUIo6sOO6VfVqCJYg11ecvnyjni
         8zr0VfFoEkozY7Z/ix1TUs3Bqbs8LE+8fvnWJ+ziqqWBkJm2/DU0Harnz/OOus/andfh
         PJZw==
X-Gm-Message-State: AOAM531yUZuhYGEpw4kQlfvuXj/T6DkoPhG8NMhKhYTv4Hrl6S8qgQCp
        CozvvbRqqN48fxRMXCkYSh3hy/gW+ERNH67XqrTm/E3u8+DdKg==
X-Google-Smtp-Source: ABdhPJysiwntFDZ80WkD/qjHRx004ESeCbfs0+1u+M8gxEfXd5uyUyGuSfA1rHusy7JQlbl/b28zVTLj//0Vzn5bfg8=
X-Received: by 2002:a05:622a:1996:: with SMTP id u22mr7798828qtc.128.1635811156072;
 Mon, 01 Nov 2021 16:59:16 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <pcmoore@umich.edu>
Date:   Mon, 1 Nov 2021 19:59:05 -0400
Message-ID: <CAEtDzYQHS+j2kN3tys0QM_Myqx5BTLkkcTx6AjHEJh=zzxqY-Q@mail.gmail.com>
Subject: [GIT PULL] Audit patches for v5.16
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the audit pull request for v5.16 with a note about merge
conflicts following the (very) short list of highlight(s) below.

** Highlight

- Add some additional audit logging to capture the openat2() syscall
open_how struct info.  Previous variations of the open()/openat()
syscalls allowed audit admins to inspect the syscall args to get the
information contained in the new open_how struct used in openat2().

** Merge Notes

- I'm expecting three trees to add new audit record types during this
merge window: SELinux, block/device-mapper, and audit.  I've already
talked with the different maintainers and there shouldn't be any
duplicated values, but I expect you will see some merge conflicts in
include/uapi/linux/audit.h; the "correct" values should end up as:

  +#define AUDIT_URINGOP   1336 /* io_uring operation */
  +#define AUDIT_OPENAT2   1337 /* Record showing openat2 how args */
  +#define AUDIT_DM_CTRL   1338 /* Device Mapper target control */
  +#define AUDIT_DM_EVENT  1339 /* Device Mapper events */

Thanks,
-Paul

--
The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

 Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20211101

for you to fetch changes up to d9516f346e8b8e9c7dd37976a06a5bde1a871d6f:

 audit: return early if the filter rule has a lower priority
   (2021-10-18 18:34:37 -0400)

----------------------------------------------------------------
audit/stable-5.16 PR 20211101

----------------------------------------------------------------
Cai Huoqing (1):
     audit: Convert to SPDX identifier

Christophe Leroy (1):
     audit: rename struct node to struct audit_node to prevent future name
            collisions

Gaosheng Cui (1):
     audit: return early if the filter rule has a lower priority

Ondrej Mosnacek (1):
     lsm_audit: avoid overloading the "key" audit field

Richard Guy Briggs (3):
     audit: replace magic audit syscall class numbers with macros
     audit: add support for the openat2 syscall
     audit: add OPENAT2 record to list "how" info

MAINTAINERS                        |  1 +
arch/alpha/kernel/audit.c          | 10 +++++---
arch/ia64/kernel/audit.c           | 10 +++++---
arch/parisc/kernel/audit.c         | 10 +++++---
arch/parisc/kernel/compat_audit.c  | 11 +++++---
arch/powerpc/kernel/audit.c        | 12 +++++----
arch/powerpc/kernel/compat_audit.c | 13 ++++++----
arch/s390/kernel/audit.c           | 12 +++++----
arch/s390/kernel/compat_audit.c    | 13 ++++++----
arch/sparc/kernel/audit.c          | 12 +++++----
arch/sparc/kernel/compat_audit.c   | 13 ++++++----
arch/x86/ia32/audit.c              | 13 ++++++----
arch/x86/kernel/audit_64.c         | 10 +++++---
fs/open.c                          |  2 ++
include/linux/audit.h              | 11 ++++++++
include/linux/audit_arch.h         | 24 ++++++++++++++++++
include/uapi/linux/audit.h         |  1 +
kernel/audit.h                     |  2 ++
kernel/audit_tree.c                | 20 +++++++--------
kernel/auditsc.c                   | 51 +++++++++++++++++++-------------
lib/audit.c                        | 14 +++++++----
lib/compat_audit.c                 | 15 +++++++----
security/lsm_audit.c               |  2 +-
23 files changed, 184 insertions(+), 98 deletions(-)
create mode 100644 include/linux/audit_arch.h

-- 
paul moore
www.paul-moore.com
