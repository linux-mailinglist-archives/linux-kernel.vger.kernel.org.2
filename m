Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E7A320BE3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 17:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhBUQ6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 11:58:06 -0500
Received: from mout.gmx.net ([212.227.17.20]:46051 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229926AbhBUQ6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 11:58:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613926582;
        bh=jK4e3b5Bzxat5l0gtGhmvSTPthqm1CVZ0q1xv2i/aXk=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=e9C0UaL4vr4bMRmrP3tJSy5GVPNOqSCJgtvQ10IEb8qTE3bqW8Mtgatm66cUhST4E
         U1NTO4uZiRO85A2kLpIN43YpLwDsB9JyKGq/P7hR8ItAHZQKIQ4uuFP4L9ovbNI23H
         XD1O2P5BgCR4ufEw0HfmeCL9+F+O27t4TrwoiSGw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.180.210]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGQj7-1l4HEp2Pev-00GnBN; Sun, 21
 Feb 2021 17:56:22 +0100
Date:   Sun, 21 Feb 2021 17:56:07 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture updates for kernel v5.12-rc1
Message-ID: <YDKQpwGHc7IDsDcp@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:2EuxwCxHJEyF+5nT1Ogxe+xkVd28AaFKFpqyA/SZt1gt7d5IMTo
 n0Fn3HzukKmzxEdwh+AcnBreDmcCFJ5q3VZ7tVMiBolitqdFi+Og24T5AXCm0+cB+oFc/rn
 Z0y5Zxi6wME2eecqwHSS22mqRXF/Q7LiL/0mBA53r0a+FXD2+d29O+Im+8bSsSbGs4VDJVc
 GfDvm2LlpPCqZywGFijzA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XIHVLrz6kWQ=:9pHRDZCoBlklNqtNe9i/OD
 xgYx4yZfJjtHnGtN16hilcYLWBRL+DVOzVcalEvhfNMbDzGZelw7+Pu1AKywZqu1IRgyHe5nH
 4iLC8xcZVNqXe0fI3rKzEiIgWeRIxSLqCg1F8yDTqNcVu8hXcWyOy/Jb9yHyqJX7HUOdeUznH
 QX4nbwdN7OpTEnHA6vndLBbyRdjs5ZFunvCE/Txs06Q//5iExw8JiFcZrCVZcxhrTq1iLvNLS
 L9yQiQ1+7srK3heNreLgKayzzEKHKBNUkExxEvtHrlBixDFRh06LlWFSax+E++1aS47qYqjiN
 p16kh96GN46coBiHxdH4ELAKxtEf08rxJZSq6NUX46GBsC5TwdV/lWj9zRFpTzXB8+KOleaiB
 aMM+Ix+y9gSuE+pL+ZAOg+7tVC8dEUv4MthXc56kqn4qChuk//CFrFgOnsF4TIgMRlt9lXkJH
 x2aeaKLaDF0YOrlNW3TtD8yKUWWHmcjQdU6ZAqlj6hyroYL5YN1N1TqqXS3IwFvbiJOuZ0L2i
 kSV0voAh+OxpBUj/qqSimaVebeEvQTmi4zlAXFnWo652qdx6vo6ZbGIduslo7mrQTCqkAym78
 i2FUnuRuCvAFkC54XNABsSIpNR6BeoYCKS5wY/OGXj7a25FBHa9UW9xRP6jDL4wpS7vNAvBLH
 XT8EIxONFwiFcZsEub7igqDGp4xCA8kG+cgjdnL1F7ZtYv8QCv5+xRdYbSJnzc++6VPq2KnQf
 A7o0lm3jK4Vm/44ubAjz/nohOc6TC310Qv/qr8M+3FAv+fpC8KdBjT3mr37nqade610xXrO0V
 VWzXxB7HDsEaC9w7WqHfTtZW1p2opTRdRYBG7E8lExkiJ6L4z0yFJcga/uiMaSqa1bh+375K8
 Evfq/pBsgyj9ZzQ+ox9A==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the parisc architecture updates for kernel 5.12-rc1 from:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.12-1

Updates include:
* Optimize parisc page table locks by using the existing page_table_lock
* Export argv0-preserve flag in binfmt_misc for usage in qemu-user
* Fix interrupt table (IVT) checksum so firmware will call crash handler (HPMC)
* Increase IRQ stack to 64kb on 64-bit kernel
* Switch to common devmem_is_allowed() implementation
* Minor fix to get_whan()

Thanks,
Helge

----------------------------------------------------------------
Helge Deller (3):
      parisc: Drop out of get_whan() if task is running again
      parisc: Use the generic devmem_is_allowed()
      parisc: Optimize per-pagetable spinlocks

John David Anglin (1):
      parisc: Bump 64-bit IRQ stack size to 64 KB

Laurent Vivier (1):
      binfmt_misc: pass binfmt_misc flags to the interpreter

Sven Schnelle (1):
      parisc: Fix IVT checksum calculation wrt HPMC

Tiezhu Yang (1):
      parisc: Replace test_ti_thread_flag() with test_tsk_thread_flag()

 arch/parisc/Kconfig                   |  11 ++++
 arch/parisc/include/asm/compat.h      |   2 +-
 arch/parisc/include/asm/io.h          |   2 +
 arch/parisc/include/asm/mmu_context.h |   7 ++
 arch/parisc/include/asm/page.h        |   2 +-
 arch/parisc/include/asm/pgalloc.h     |  76 ++++++----------------
 arch/parisc/include/asm/pgtable.h     |  89 ++++++--------------------
 arch/parisc/kernel/asm-offsets.c      |   1 -
 arch/parisc/kernel/entry.S            | 116 +++++++++++++++-------------------
 arch/parisc/kernel/hpmc.S             |  10 ---
 arch/parisc/kernel/irq.c              |   4 ++
 arch/parisc/kernel/process.c          |   2 +
 arch/parisc/kernel/traps.c            |   9 +--
 arch/parisc/mm/hugetlbpage.c          |  13 ----
 arch/parisc/mm/init.c                 |  10 +--
 fs/binfmt_elf.c                       |   5 +-
 fs/binfmt_elf_fdpic.c                 |   5 +-
 fs/binfmt_misc.c                      |   4 +-
 include/linux/binfmts.h               |   4 ++
 include/uapi/linux/binfmts.h          |   4 ++
 20 files changed, 141 insertions(+), 235 deletions(-)
