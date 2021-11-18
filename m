Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54617455D66
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 15:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbhKROJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 09:09:05 -0500
Received: from mout.gmx.net ([212.227.15.15]:39197 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232373AbhKROJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 09:09:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637244356;
        bh=RfooAqtvucDmSWxoLUAuHVBifyZvndjTdoCshpWAFuI=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=Shs3wVhNIDmmlZHIJ+2Xc2G+zMN0m+qrXUX7ca2M6DaqR451/YmNuR8Wyu035nreN
         MtmfS2OdEFUW7K7e5ZlzXnrwc1G7NGLDUgQ4LMPLlovr1wPGX8pJHYlO/Yba37uhRX
         qvM4IOkfKtq6WLIdqRk2VKtjFir3RcDKKEHygrlY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.156.59]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5fMe-1mkw6D3PWE-007Dfz; Thu, 18
 Nov 2021 15:05:55 +0100
Date:   Thu, 18 Nov 2021 15:05:19 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>
Subject: [GIT PULL] parisc architecture bug and warning fixes for kernel
 v5.16-rc2
Message-ID: <YZZdn80/xHPvP9cf@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:mTzFJVFQi6xR351UJ49yrrg7E/SD1yt3cenAB/xI5QzVaPUXgkk
 U9EBay2zjtJmkNWOne2zqbvO0e2S76geTzvzzwMcfqpxrTGfQp7Eo/IgOFlw0oOEbkotzZT
 /uPFTZ+d43ZXRlfwnTPSdwmGNC5h0Bkv3K/vBGGYwYH3dY64IkUX0bqe2AwVCBg5bbwZ8mM
 zJUY38XrgsNmMRUlEAaKQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:q3ZrzPaDo6k=:4FPWiGSdvXgldQ3I3aEY5c
 ZEqLOQiG8EtNTGp1KiFtKIHU+P/HgSB1Bz0Nn+wmziBTIaHzVSmWzEf1seTSSZyIofJu438oQ
 prW7QI0FNtWm3xnPkn8c7lecNkBYjZjFj0QcM4eqZDsrshsi9WtoMMaqH5R597vtidD7WOZCP
 azWlcz9/i7Y01vqj8yNKt2ZK2cAVpI+DZiOoT1Do8oDgqxtkGeHzvkqGHKfq/SqSAtBnyCILr
 QeeXe0arUmKvi91Jd0iMSboAZC6aeh6/Vl9W9D4S0XYISsvR7BwNfvj8VPeY+nGxYnkUODdbR
 75e8qR0AdoMg39++SmbNxApuMDsAQBRg9y18HNvuYMckRbEwxhzXmP+5zf5DcESp8Dzwq5ULm
 No+1paKQ2naVzpBgw7h3lrX8Mt/ZnEZgySAj2Uo7iaAVt6tlinOcyxe+KkRjr/6GocZznRV2A
 hrgLEAcbi3NpLYTfLrHyUv7cRWaEa3EBDp6tC689SujpkMzArQbLfcJiYwphWnVGUE5lk4LoQ
 0bbzG2vI3ASBa2qL26xXn8DYMT1qQY1UZrvFPVE+t9dnMn/HAK0QZCpVnwW3ABaeE+TqkZASk
 1ado2w0P8L+vmPN+AuxVygazbf462U7VgRObB9Ez+/hogG7TFXFGmzasMObnN9lShox+w6Lp0
 0VT9ROlLInliaSZHsVFvfrw1AjSOlFtfDmAK6jnyuKTOhxMrRSkCrOIKQxhehuyrwkL79A+J0
 yre+lwY8shee9Litw6dZdNiUPQ463bFtASqDbk+aId+wU2pfnkFIJWjakPxHBolznb/kkiEr5
 GlvI1779fk6eeDo9nhYyAjMwpEep+AaGPClwFPTceN4ql/+/+TM06VkLDkdJFM1B3PhKqdnM3
 qeA5vwE/KD6lr7y0RvTMQt/Tthbdt0BAzb+1whGIUq+kFEpwll0NX7mkjvq06wIYljsfLd2Ks
 LsysczfAT7yDD3L5FYQrhjvtvIGjDBUMro1tmiJ/RS92TtrCtGYTnb9eQ21qchHmI7NTcboG1
 7NffzNK4dxXHioYpCUVpcUze9s6TTnHXOwqsrYn2ocswxo/IfVZ4FVX2IbZAO2xBkJP1K8Ots
 lPD7QJvN1zM0a0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.16/parisc-4

for you to fetch changes up to 9412f5aaa86429e018941994076bd63a0618111c:

  parisc: Enable CONFIG_PRINTK_TIME=y in 32bit defconfig (2021-11-18 09:02:32 +0100)

----------------------------------------------------------------
parisc bug and warning fixes and wire up futex_waitv

Fix some warnings which showed up with allmodconfig builds, a revert of
a change to the sigreturn trampoline which broke signal handling, wire
up futex_waitv and add CONFIG_PRINTK_TIME=y to 32bit defconfig.

----------------------------------------------------------------
Helge Deller (5):
      parisc: Include stringify.h to avoid build error in crypto/api.c
      parisc: Wire up futex_waitv
      parisc: Wrap assembler related defines inside __ASSEMBLY__
      Revert "parisc: Reduce sigreturn trampoline to 3 instructions"
      parisc: Enable CONFIG_PRINTK_TIME=y in 32bit defconfig

Sven Schnelle (1):
      parisc/sticon: fix reverse colors

 arch/parisc/configs/generic-32bit_defconfig |  1 +
 arch/parisc/include/asm/assembly.h          | 44 ++++++++++++++++-------------
 arch/parisc/include/asm/jump_label.h        |  1 +
 arch/parisc/include/asm/rt_sigframe.h       |  2 +-
 arch/parisc/kernel/signal.c                 | 13 +++++----
 arch/parisc/kernel/signal32.h               |  2 +-
 arch/parisc/kernel/syscalls/syscall.tbl     |  1 +
 drivers/video/console/sticon.c              | 12 ++++----
 8 files changed, 42 insertions(+), 34 deletions(-)

