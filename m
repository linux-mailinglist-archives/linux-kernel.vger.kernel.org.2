Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2004068F9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 11:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbhIJJUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 05:20:21 -0400
Received: from mout.gmx.net ([212.227.17.20]:57581 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231962AbhIJJUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 05:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631265539;
        bh=KC8PBZPAKY6mB63juMjuHGYQPgWXdI2KoK1vz5ZL8GY=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=k/f9tf4dEGLDXmYZEDG5Eg9TkuZKybZN3No7+eLtHiU+njly9UE/sb25THAWQED9m
         aNLLI/EYiLexYaBsPoyg/p3RCYc5SfLWaR4bdmD/o0hBnAuWcIJAN3nnqNQp8GlIKf
         0CHDPfy2Gm9w1IeTBcIcksNM3ChRu7THOhYRwByY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([80.187.121.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7zBb-1n1aAD2zT9-014zMH; Fri, 10
 Sep 2021 11:18:58 +0200
Date:   Fri, 10 Sep 2021 11:17:20 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes for kernel v5.15-rc1
Message-ID: <YTsioP7hPOP47cfn@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:TV4ueebJTrFNQK8+ByJZcVLoLf9VVT2Ywu1cwYD5e2aV2nHJi+y
 pEvKsMZDKBZcWJQePbSy0kbpK+NFz1G+EbLViWBS9tewN1aZ+/6cX0sewU25yF7RJxxMDCv
 NEa1D+F9c58ieO2JnaJrlTgtWZZIMNYituQoopQ/o2XD8MEj40icoOwRTclTi4gITfPTgyG
 /NC/1fXrJszp1GtHBsnUQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vJHlsmIwOe4=:qiHUuAHOec1E/4mEPDArmW
 N4Rwu+9k0ICXc+4nlN2J+eCdzr7anXtRmC11dEa38jSwztKzqs9QsIiHwMJV6UmvgCJAUNwde
 7x2lJG0ioBaHeQT8qJJP7mzGCgsdETT+fCZau9kdTQpcYedesSNGwc/7bwcHDXJp2eEKsAgZl
 6tsrIDPWfxDm5tBWweXm1HCRRcxqFxnJkxTB7wI63WNelSWdOU76oaos0sPT57GZ/agCMCRB0
 pJ7A3qlm9K8DErPFgO0+MOp2hxfAL45JmnbY/KEjXmGG7qXq53vpbqm9WFnx5XDN/nnrLBP/m
 VkDVzKtOgNF9Nxsva730rAhawTxQsyAPDF8AeJxhPbdMk8xP/nAsL6+qUzullMDOBP8Ve7a/I
 MNsFKpuhSrmmg5T8NLUciaFJEz9Ze7B6+qMTYlua8qA17qV2zdphSQuRZkJi9xnpKeUS7CP8o
 PQH9UvG4z7TPU9GFdfRBE0h07hR1sLtkjmsgzPWdqhzAWqT7b97MvmwRqxsyXZI+2yHGtXrx9
 Qsp6rDfVe5O2j4qaSGNL2BSu1jbfBox7QAag1v552VKc0ZyzkHano6iCtNkn7BZO7o6gVdhVI
 ykl4HaXm1KO4+2iWJwUP5+LaIbZKVIOFDLLoefXjS+GX2ZtTbvAJl+l7x8Ew2ezujXabfvZmi
 +x8OBWyw/E/dFf+xpWlWHebRpeELRIRp9BubdR3lDxRLmcXWWePF2TyntYtPzcLePDp2vfshP
 yhvvdXbiQ8HI/NsCco7sf0a8YXZiGfW5/OL7HvWYQCqkzaNddyu2Tfh2Z62iQpmeozX1NrNgh
 ZmVyVUgoj9hohT+TDlyG/O+5MZqrzUTRrkbnhnrKLSUqCtbiAVOW0fmOnwJ9t0SGAS6hExvsC
 lgOYRcFME22/d9I+4asa+q9kiZWRnIcYAxGu8PIFFbxgfFiXtINp+aUJmMIU3Ow7iWstt9eBv
 jruCZhz7eAhZVhF2Skeh5B1VFvauOI6ZAJXFK6Q0eyYGxZS6TsrK6tcmhdvKlobuaXvNF1Xkt
 ZUghzZkxdgT47Qig+rv25GF870/uNegqhr3xhrLuFY0HVv8kS4K8wii6V7I6l7vRMlesXITZJ
 DRMkfI31RCc6J8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull some more parisc architecture fixes for kernel 5.15-rc1 from:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.15/parisc-3

Fixes:
* Build warning fixes in Makefile and Dino PCI driver
* Fix when sched_clock is marked unstable
* Drop strnlen_user() in favour of generic version
* Prevent kernel to write outside userspace signal stack
* Remove CONFIG_SET_FS incl. KERNEL_DS and USER_DS from parisc and switch to
  __get/put_kernel_nofault()

Thanks,
Helge

------------
The following changes since commit a3fa7a101dcff93791d1b1bdb3affcad1410c8c1:

  Merge branches 'akpm' and 'akpm-hotfixes' (patches from Andrew) (2021-09-08 18:52:05 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.15-3

for you to fetch changes up to 671028728083e856e9919221b109e3b2cd2ccc49:

  parisc: Implement __get/put_kernel_nofault() (2021-09-09 22:53:09 +0200)

----------------------------------------------------------------
Guenter Roeck (1):
      parisc: Move pci_dev_is_behind_card_dino to where it is used

Helge Deller (7):
      parisc: Add missing FORCE prerequisite in Makefile
      parisc: Drop strnlen_user() in favour of generic version
      parisc: Drop useless debug info and comments from signal.c
      parisc: Check user signal stack trampoline is inside TASK_SIZE
      parisc: Reduce sigreturn trampoline to 3 instructions
      parisc: Mark sched_clock unstable only if clocks are not syncronized
      parisc: Implement __get/put_kernel_nofault()

 arch/parisc/Kconfig                   |   2 -
 arch/parisc/boot/compressed/Makefile  |  18 ++---
 arch/parisc/include/asm/processor.h   |   4 --
 arch/parisc/include/asm/rt_sigframe.h |   2 +-
 arch/parisc/include/asm/thread_info.h |   2 -
 arch/parisc/include/asm/uaccess.h     | 125 +++++++++++++++++-----------------
 arch/parisc/kernel/asm-offsets.c      |   1 -
 arch/parisc/kernel/parisc_ksyms.c     |   1 -
 arch/parisc/kernel/setup.c            |   2 -
 arch/parisc/kernel/signal.c           |  45 +++++-------
 arch/parisc/kernel/signal32.h         |   2 +-
 arch/parisc/kernel/time.c             |   7 +-
 arch/parisc/lib/lusercopy.S           |  52 +-------------
 drivers/parisc/dino.c                 |  18 ++---
 14 files changed, 102 insertions(+), 179 deletions(-)
