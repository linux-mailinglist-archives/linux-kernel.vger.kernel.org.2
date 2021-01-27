Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C724306074
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 17:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236942AbhA0QBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 11:01:39 -0500
Received: from mout.gmx.net ([212.227.15.19]:33483 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236864AbhA0P6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611762987;
        bh=CP+ZV9x7pYPLb0ZLGilMnKmtm1IV5SmcQIld6+JgAhE=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=AgvzQR7JnAJBHEb7ME/c57A5ySlk4qE14+aL3vJ63bKHGnYKWOkIJBegHbqWOR2cQ
         cSWf16v7b8YrK38kf7dwEV2NmmGQ6Oh+pmUVBtmcJBzxFqKdE0sQ04GGyevgJ2uD+H
         qcfLPAE5KOVIimyiOV3Cy26170XogIeUKi9GBp5I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.167.183]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiJZE-1lb7Oe3N5S-00fSIn; Wed, 27
 Jan 2021 16:56:26 +0100
Date:   Wed, 27 Jan 2021 16:56:22 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture updates for kernel v5.11-rc6
Message-ID: <20210127155622.GA13805@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:6EALqzxabRMhIIqc06AyJ8Po7PpkbJuofYLFx+EtH8MQPZpu8hq
 KHbEzSA2jbQDOBqN++CYPDBzFWYzDYv/lSs0KXfUrNsTYN6rGYaKdn7P6seTe5VW3pubAqH
 YUaNIUSIi3OuxgKKd9JEioW4Wx4fcCmrn+/4KedT6/aXOGD8cy2/aR35b7Z3OnmuY42O3DZ
 Se6rjkBP+NhRKcJfJiJvQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z9BvlV4e9Dk=:iAmNk/yzEiJRYRDBPA/b6K
 ja+ecd54C0z7kguTDSruiiZJkrufEHnUgmzJEX3HJzwRK/4grfeUcgwNBIttc087QkGPYYl2V
 EjyH56Cs7VKP2hur6BaYSA5zNtlKFzkpG8Rzl7VNgBxLwaTlyJviZ6FBZgQzpDKdI+NjxpSCE
 5q/dJ6K2WiYuU8cvxvs9t+D6JMHA9AtAXsNRBPjLlFwxRNmk0O99XbeqjGGhSznkzd1pIZEFP
 c0ZP0jYMI9OLzKWDOghIyzX5OnJNssgOf6tf/tGq9N44gy3lZWdEl3iAIyKjiIK5CkEkO96uu
 UeR6OYdso927NvaAy2kKO6aiYxthKdn7rpiilzmDY3rJ9a9uWGy9vvP8+wwebJJbe/pcBivxP
 NASp1nvTzOhSM+k4I637ItGnM1I0J3X6SKUTzDNy2QE5CXhP5/EtITC2JMqKalm2AhybIw7Cy
 UsXSrY1buLtDT8OksTBXFVlymGim2h5xsQzu/ao2UYskwKqlQ4ZzAMozQA3nZ0oZSt+NvoFHH
 9IQAuJlV7YAC19STnltOZa+KYwA85zKhs//MYfmbuodP+DbKx/W+L7c9zPT8WixoVsPgqFqKI
 HUnyT5K8osHU/zaWnro2p8Bp1HxW4nCXS9phpY4yHGVXtHmpWIeVZaeyx95EVN6hVu4MlkIse
 vvmjMYktG4V+Fd9ssINQxQhGfuBzcTJy9sK/G/CklXoWY64NFBzXLk0uLAHeayu49l225iyLA
 7S+P/fuRi+l5dVHlF06PS1KPcN+a0rm5TSOjioCUsvwxEJTzBR3xAhkMUZs3aBu0d5Hik1iH+
 25ufJ2UQ0xKYeSZJuwPUt2Qju2xPZbpfGJcoK7Nj80ltbigZYm7Zk5TXiWf284QEt5ymKoal5
 dWKdG/MA55p2NfnLLJ0w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two fixes for the parisc architecture for kernel 5.11-rc6 from:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.11-2

Two small fixes:
* Fix linking error with 64-bit kernel when modules are disabled,
  reported by kernel test robot.
* Remove leftover reference to power_tasklet, by Davidlohr Bueso

Thanks,
Helge

----------------------------------------------------------------
Davidlohr Bueso (1):
      parisc: Remove leftover reference to the power_tasklet

Helge Deller (1):
      parisc: Enable -mlong-calls gcc option by default when !CONFIG_MODULES

 arch/parisc/Kconfig           |  5 ++---
 arch/parisc/include/asm/irq.h |  3 ---
 arch/parisc/kernel/entry.S    | 13 ++++++++++---
 3 files changed, 12 insertions(+), 9 deletions(-)
