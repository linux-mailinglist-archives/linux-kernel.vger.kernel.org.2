Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A43445CAAA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 18:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349800AbhKXRLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 12:11:33 -0500
Received: from mout.gmx.net ([212.227.17.20]:44827 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349713AbhKXRLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 12:11:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637773675;
        bh=7TVFcTacTxW5YFJ5v8gtGJD8pvfmUxAQrKnPBRXpaGU=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=Dp0GlyIXxzZeXdOdt46dnequc63SF99BvtP+lBQAg3C8toePolf92ODHvJ+dQGjfP
         M9CUcp1dl+JMUZWe3ZveTYj26NKLRHor2Glmexzsxg/3Dxpk9U0HsLZ1z/AxMcTETS
         Bi0QL+PEA4NBOvuctkV2S+gvU7QhMfRicVWEinJ0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.189.116]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfHAB-1m9zMG1Swd-00grFM; Wed, 24
 Nov 2021 18:07:55 +0100
Date:   Wed, 24 Nov 2021 18:07:50 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>
Subject: [GIT PULL] parisc architecture bug and warning fixes for kernel
 v5.16-rc3
Message-ID: <YZ5xZijH8L7IIpJh@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:Dcqi2TkaI6KnmuX/cr4yz7xXOB0ytqfxsyJhQ42e6F9lBcy4Mlt
 kBM0E7tIOFkZhiIGhJMQl2fEZnCqTyxExrbU/pYzMgDyV0FCKYGr6t5xDU0EscTEEJ6nYid
 HbpROUVYhcXnWfGctgJdAuINICwEa2cC5cUeCOD75ln/hCXaoDkrYck2ZPwQIaOJNGEINJ3
 v2Ph1TfIX3a8cNkDQA0OA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XTxhxYKdHcM=:1/rkOZiub4D+fkTl3x4cjJ
 wZsk35jdPoBFT+Oa4k0+brFrJtmZjjE5+dY80ZTR/BS5SkB7awsdk9cVkUPa3smUFM/LKJCDW
 exl8IAek4u1i++cRJTyhbKVZY4OJK8u2MP1Nn9h6oiSRftiPOxSYYGN4afd3R48535I5BT6Go
 DVj1k0LLpKbIzyZXUDNSvdTWxzAokwuLvpbMvKnMOdlueWYmNXxZPgh/voQ22pUoOEu2+vc7G
 3MHGDmCi4istfSCRnzGFrdA/iLys4s42AY7cup45zxam9ObKiMA0+6klL3PYW5qYxC/uVjEE2
 wpdtnVPEKSeScyCuCx6/i3QqbKI/lxh/lCuAq9mxaLw1fcZvL7ZahbUzz83MYKjaJgaGQaOGE
 UfOPaBQ6c/Ptqw49T4JkIVIEO1ZiL/eYpVnEQnEIGEXKAcNdOYbu8tY9s/dfHSEGhfmID4s8h
 EQlvkZnFfmXUmC+XEuipfx8FPIN+TFC0zKurcf4/QLVpoQUOE4tEHd8FR3txT8Vwy3bafArkV
 bN1ZkyjtJOr1kuU5JnJI0uoUNHafXo3BCeNB+yTAlxEx/7c2JO9nL9SdaWvRYgxPs16hVQplg
 n6KCXNZNuQDU7gq+NvVSWHPhzt000atp7oAAMUaw5pMawO5OrJcUCoFR5F+PN5FAJ3Vo+F2ui
 cbY7I5Xt3vI67d4Ph5mZGVWSsDbT9pX3IfeJiYVnp/P6Upxgt8Y9ygjfiyRZ/e2+6O14zi7Fg
 evsz6dr20jJaKyQHH8AAsQdOC7QRbnN/MicmfU3XsQ9zhlVyBesSmMNyvaDuQ4SOgAF7E+BnU
 IV6eWUa1zXaIe7pirgttTH/xD6iU9jbiIJVQQw/Blxa3AnNdunKt0Di/6j9I38FnwcJB67c/d
 mKxnmf3NX7w4Io0wymhP2G7mBvUSWGDJbjqajJ2D5qClFNQzUMjb9n7WTtJP1Y8UExo+GzscC
 Es7FPOA/G+pFQysJvPCqCFXR3ppNIpQAA8UpikKzGi09hdtKOpFks1Gg09KCUL3Sf/vVAxBuq
 smHhGGTPT6NSEcTXJFsASdvFH6Lnh8tg85fuGGzuxrg4xtA0G4qbaz4eE57VqCMLUQtgmwfxc
 zqUiM3I1jtEzqo=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 136057256686de39cc3a07c2e39ef6bc43003ff6:

  Linux 5.16-rc2 (2021-11-21 13:47:39 -0800)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.16/parisc-5

for you to fetch changes up to 98400ad75e95860e9a10ec78b0b90ab66184a2ce:

  Revert "parisc: Fix backtrace to always include init funtion names" (2021-11-22 07:37:31 +0100)

----------------------------------------------------------------
parisc bug and warning fixes for kernel v5.16-rc3

Increase the FRAME_WARN value to avoid some new warnings which showed up
in the Linux kernel test project, revert a patch which moved the _stext
symbol and thus tiggered errors in the hardened usercopy checks, and
introduce an extru_safe() assembler macro to overcome possible unsafe
usage of the extru asm statement on 64-bit PA2.0 machines.

----------------------------------------------------------------
Helge Deller (4):
      parisc: Increase FRAME_WARN to 2048 bytes on parisc
      parisc: Provide an extru_safe() macro to extract unsigned bits
      parisc: Convert PTE lookup to use extru_safe() macro
      Revert "parisc: Fix backtrace to always include init funtion names"

John David Anglin (1):
      parisc: Fix extraction of hash lock bits in syscall.S

 arch/parisc/include/asm/assembly.h | 11 +++++++++++
 arch/parisc/kernel/entry.S         | 14 +++-----------
 arch/parisc/kernel/syscall.S       |  4 ++--
 arch/parisc/kernel/vmlinux.lds.S   |  3 +--
 lib/Kconfig.debug                  |  5 +++--
 5 files changed, 20 insertions(+), 17 deletions(-)

