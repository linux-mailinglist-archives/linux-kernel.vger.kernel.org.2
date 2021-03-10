Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E895633324D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 01:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhCJAZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 19:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhCJAZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 19:25:01 -0500
X-Greylist: delayed 87914 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 09 Mar 2021 16:25:01 PST
Received: from mail.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5449C06174A;
        Tue,  9 Mar 2021 16:25:01 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id 015764D2ECC91;
        Tue,  9 Mar 2021 16:24:58 -0800 (PST)
Date:   Tue, 09 Mar 2021 16:24:54 -0800 (PST)
Message-Id: <20210309.162454.822491855062735992.davem@davemloft.net>
To:     torvalds@linux-foundation.org
Cc:     glaubitz@physik.fu-berlin.de, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT] SPARC
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAHk-=whgiPiFy9Ye_t=fV9J8VdqgZW5XQcb-1z8PgpQbVBWqCQ@mail.gmail.com>
References: <37859f29-dc59-d6c2-6f92-abaae32ee4ab@physik.fu-berlin.de>
        <20210309.110812.234617387417457658.davem@davemloft.net>
        <CAHk-=whgiPiFy9Ye_t=fV9J8VdqgZW5XQcb-1z8PgpQbVBWqCQ@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Tue, 09 Mar 2021 16:24:59 -0800 (PST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 9 Mar 2021 11:27:41 -0800

> On Tue, Mar 9, 2021 at 11:08 AM David Miller <davem@davemloft.net> wrote:
> 
> (And yes, I prefer lore.kernel.org over marc, although for single
> patches it doesn't make much of a difference. For patch series, I find
> 'b4' so convenient that I definitely want the patch to show up on
> lore.kernel.org).

Sadly, lore does not archive sparclinux@vger.kernel.org, so there
isn't much choice in this case.
> 
> I'll await your pull request or 'I have nothing else, take it from
> xyz', this thread is otherwise archived for me as "done".

I added Rob's fix to the tree, here is a new pull request, thanks!

The following changes since commit 062c84fccc4444805738d76a2699c4d3c95184ec:

  Merge tag 'rproc-v5.12' of git://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc (2021-02-24 11:30:13 -0800)

are available in the Git repository at:

  git://git.kernel.org:/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 69264b4a43aff7307283e2bae29e9305ab6b7d47:

  sparc: sparc64_defconfig: remove duplicate CONFIGs (2021-03-09 16:22:40 -0800)

----------------------------------------------------------------
Al Viro (10):
      sparc32: don't bother with lookup_fault() in __bzero()
      sparc32: kill lookup_fault()
      sparc32: switch __bzero() away from range exception table entries
      sparc32: get rid of range exception table entries in checksum_32.S
      sparc32: switch copy_user.S away from range exception table entries
      sparc32: switch to generic extables
      Merge remote-tracking branch 'sparc/master' into work.sparc32
      sparc64: get rid of fake_swapper_regs
      sparc32: get rid of fake_swapper_regs
      sparc32: take ->thread.flags out

Corentin Labbe (1):
      sparc: sparc64_defconfig: remove duplicate CONFIGs

David S. Miller (2):
      Merge branch 'work.sparc' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
      Merge branch 'work.sparc32' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs

Rob Gardner (1):
      sparc64: Fix opcode filtering in handling of no fault loads

 arch/sparc/configs/sparc64_defconfig               |   4 +-
 arch/sparc/include/asm/elf_64.h                    |   1 -
 arch/sparc/include/asm/{extable_64.h => extable.h} |   4 +-
 arch/sparc/include/asm/processor_32.h              |   6 +-
 arch/sparc/include/asm/thread_info_64.h            |   1 +
 arch/sparc/include/asm/uaccess.h                   |   3 +
 arch/sparc/include/asm/uaccess_32.h                |  38 ----------
 arch/sparc/include/asm/uaccess_64.h                |   1 -
 arch/sparc/kernel/head_32.S                        |   2 +-
 arch/sparc/kernel/head_64.S                        |   2 +-
 arch/sparc/kernel/process_32.c                     |  12 ----
 arch/sparc/kernel/setup_32.c                       |   3 -
 arch/sparc/kernel/setup_64.c                       |   4 --
 arch/sparc/kernel/traps_64.c                       |  13 ++--
 arch/sparc/kernel/unaligned_32.c                   | 106 ++-------------------------
 arch/sparc/lib/checksum_32.S                       |  64 +++++++----------
 arch/sparc/lib/copy_user.S                         | 315 +++++++++++++++++++++++++++++----------------------------------------------------
 arch/sparc/lib/memset.S                            |  87 +++++++++--------------
 arch/sparc/mm/Makefile                             |   2 +-
 arch/sparc/mm/extable.c                            | 107 ----------------------------
 arch/sparc/mm/fault_32.c                           |  80 +++------------------
 arch/sparc/mm/mm_32.h                              |   2 -
 lib/extable.c                                      |   5 --
 23 files changed, 205 insertions(+), 657 deletions(-)
 rename arch/sparc/include/asm/{extable_64.h => extable.h} (92%)
 delete mode 100644 arch/sparc/mm/extable.c
