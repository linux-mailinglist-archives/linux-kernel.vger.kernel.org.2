Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8448C3721CF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 22:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhECUrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 16:47:25 -0400
Received: from mout.gmx.net ([212.227.15.19]:37389 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229596AbhECUrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 16:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620074778;
        bh=T08OXliPRYO+Cz8TMMdWHTcGdT2Pxw6qW6PdI0815MI=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=L7VY5PqSLR90L3QKLwVwOPxMfGB0Z2TAKN2w9n5LJT+DEi/P4RSDd0tXaE93u3Jv/
         7cJzxIaO22awex6iyUqEB7jbpv//hcnjU0ENPeuC/xZR7g/1rjc79g3PIJxghlky9d
         YzdHtTmYjkbHEf/+NjHcSExGNG6I1uXtA5YGGyqU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.187.2]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYvY2-1lza3u1F56-00UudO; Mon, 03
 May 2021 22:46:18 +0200
Date:   Mon, 3 May 2021 22:45:33 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture updates for kernel v5.13-rc1
Message-ID: <YJBg7V02gxIRPrDx@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:WUtIV0npfJjVDVDaeOXz6htvPbC4d7F4HH1TgTBpagfSHEAdkFx
 GxmR42l2/A1rlfROqwmN9wDO6Vod651dPdZPgl5hdnqbIAY7+kMyYj5CE/8GKOqOsogeu9a
 qRNS+dDU/hv9RwH/l1BKYrCGNoXr2+asaADPfhhtbRQ2/32Y7Yf2m7zf67tC46JTwE8g77J
 nBni5SlhamR48knjO8LhQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7QjwhshCmIc=:9Vz48RX8x/4fDkOPuvdBYw
 2f7rTNPqwfWSNprjAj1eQyf97r0ZADyrshkcRBDDivHlboQT6fdCTkY3Tx2Y25RjGInmJilc6
 6azbDRQd70cHAlP1fuSNJxIV4qi0oLkqKvReaTuRGu2+8FxWKL3sA58ZIHsjCwTkpyh76JsT3
 ImrSHvr9/lcMmFY7aA+1xJScmjdpQCqKAMKLq2320YKZX02uMNcdqaAwmCUoiks3JvQ7BXywJ
 GOr1EvlwgM8GwT1efWjxc8xB+ayWpOKxBxKgYdfXPvqC/rJ2QzKwb3Ju25OJ8sygOukyimlsc
 McFDkVN673wv/rWNaLPn+y2B8/7g/k+1T1zQNVSyRUXPvCvNTJlR7jkJv+yK7vhljN6Zb/If9
 1TVkWEt3JWNj0KF7ck2eEyaT74e3P1p5Vcvo04a4Vv93ZP5j3N+wG4ziv1WDzl4thrHFETpvu
 gTEJn6g5quCnrRWcfXD535Ep5MWyI6cHtVa7Zfva6NHyonBuJ4s6r+EAvQd9BhXyBi1zWywXc
 F2DdzqZHnKdQrtHVD5ai8V8MK93TpgF+oSRVt3sSC+BoNoaYw92d0o5iLL5ojE0INZXqNmU6L
 ewN/X0a0Pf3GMbOqYauv/ssdKDa+i7oSpb7bDy5ovWR2tFotUbRoGa5VnA8P5InzxWLJIWDvo
 O27hWSWwwuIevivq9MtBPzpz+8qOmnZE7AsU7wVPbX91kljf5Z29ZPqNsDRO6bQL9IneJkLBO
 GFRmXiPQ4pa1qk1TSQ33GOyaI2hI3JaEpcdRAMNrTqahEdMAZnhOERv+ZMO79AzJvLIK/2jgJ
 7K3LCyeKBCKUaTAkzRwMtCJhkdMHK4uWoWFVb1dgW1cBYM9xmGOAJTcCS29MbSKToJHkVMFSE
 cw4U2fopVe6t/9YAEeP1qrLpuaeTqcmy2tef76/RH2jTDHrLPqygXmtd8sTfJLCA1pCAVWmBQ
 Dx8GgC+uFNdfnpX+tVGQpkJdxvdpXWlbHbfF08FQmrLb2RNFC0EQRLD5XYwzbUDs6zKbKswAe
 QaDEjb4Q1rHUhQt8MuRWGv/WNaZ2k9gKEi+ue3twLnsgUcJwTxyZAFTO+Mtr7ezsmPMHywt4D
 DckMhlz/Kc2YWQSkjk497vrtgjUMNxzT4MpBuUxim0Dn9ShSZz70MFLmnRpDjJqoifSpWR22d
 6/l7ANOsEe04sTfoAizASYlhTQXoO0dbXWpz36eGB+oeEKgVSQfklxJIgrrUOXYrVHDMU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the parisc architecture updates for kernel 5.13-rc1 from:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.13/parisc

Thanks,
Helge

----------------------------------------------------------------
parisc architecture updates for kernel 5.13:

- switch to generic syscall header scripts

- minor typo fix in setup.c

----------------------------------------------------------------
Helge Deller (1):
      parisc: Fix typo in setup.c

Masahiro Yamada (2):
      parisc: syscalls: switch to generic syscalltbl.sh
      parisc: syscalls: switch to generic syscallhdr.sh

 arch/parisc/include/asm/Kbuild            |  1 -
 arch/parisc/kernel/setup.c                |  2 +-
 arch/parisc/kernel/syscall.S              | 16 ++++++--------
 arch/parisc/kernel/syscalls/Makefile      | 30 ++++++++------------------
 arch/parisc/kernel/syscalls/syscallhdr.sh | 36 -------------------------------
 arch/parisc/kernel/syscalls/syscalltbl.sh | 36 -------------------------------
 6 files changed, 17 insertions(+), 104 deletions(-)
 delete mode 100644 arch/parisc/kernel/syscalls/syscallhdr.sh
 delete mode 100644 arch/parisc/kernel/syscalls/syscalltbl.sh
