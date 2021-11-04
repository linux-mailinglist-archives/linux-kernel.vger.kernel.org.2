Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00914457CA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 18:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhKDRDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 13:03:02 -0400
Received: from mout.gmx.net ([212.227.15.15]:58061 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231616AbhKDRDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 13:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636045200;
        bh=tKM5PQHWpgP8pl+4MrNWopKIsPwcNVs6I6DSoiDoe9k=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=St92rN/1vmF0PImyF9jhO8otSLDq/KYZ4DS93VcktW8Ta6oVLeAcY1H7gbSSpchTd
         KVPbHhzdrDKxQDkkESqmX0pmB9Px35J/KQcP/ybFiWRhKoYwfyCTWJNM3LpaWYehvi
         CiYjI4mrUaLCVkviQly55M8BXtNXWgwjr/HFwHb4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.157.73]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXGvM-1nFE9J3jSQ-00Yh2F; Thu, 04
 Nov 2021 17:59:59 +0100
Date:   Thu, 4 Nov 2021 17:59:32 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [GIT PULL] more parisc architecture fixes for kernel v5.16-rc1
Message-ID: <YYQRdM6er3Hty3qP@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:O5pkn/ut4pPxRa9lTa22n8YkW5f1SRoRSO++aunw3b+DAnP2Pje
 QvVbjsjmLU3yIUgSXXblO5sK5vzrW7LdvZi/HsVwUvxXPjCWFMtZx1zO+EAbpYTME0D/ZqH
 ITZNN4Wnhq6dvG+8VQD2S6cS1LaLAD8XnrAtcUAH+euorCUU56vQmJi20AZLzyLaPQy/lpL
 b0qrKahA5gShkKxdtgc0g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:I6aRUJgK+ZY=:TZyU60TjWsqJDq4oJoaKPg
 LIBP3IzGoQ38gmXsOcDre1vqxslyW/zqopl7EK+EMoQ/I4cz06733hcGBglBleatG08wXOhcG
 q/7uGIJU/sbNcQmxypONF8wGU8Td4ZXu0OgpTOWczw1vBl2tZAlPVPonA8w4JVGbl1fujknX+
 UT+P0+/kxv23RJE7KWE5uMNypFA0G4XIHat3gAVRgRWNv0HtgrOSVLqMmifwyBplvAUtpDRXY
 egIRsUPzg82PfuLvgRLmKBnBF4JQjWiUnWR+zTPmOAZ1cQaPUbCZqlnoAe+jijRAS7sMs6tsV
 n4q9V7SzEeFqeHVRxwWBuuybquwGbGQnSV4/a4qGCe86l5P8X+q6SozymPi2xQ0XOCZbCZCQ8
 iDABsqT1eK+OJaokPb8foJoUxIL6VjzHQqJJpMMhVHz9HyD3zzpdqn6OSMuCHVMKFbR2aPSl1
 0JbXTzEvt8YOpIMYvJSGXipRdRZFBlk6skgMEemmseCC0kpjg422raWacYxKiMUQmMzuXDMgN
 4esTLYPVHj41t07nHjPQnNZgzfOZhqgeS2Z9jXgoCvZvOTkj7ozt0bjh/abZdiwEzaKiRcjRQ
 V15Adj4i88Wu+rVD2Ozg0lRuwPkx+1UXAWHSoALvgkFaC5BhiAWe1ALNqu3BFHffgdBbwRx/T
 EK7C+5t1l2xCgQX5f+y2tbbLYfvW+j/Dtej4dOxt10fd0pueRRAFCAsoWiBihyj3w+CGZPM8l
 DMG8uXtvPNC8pDAyiuiwPNjvZQiD/qA0svnySSUQ6aTrjsKUrteOltOO+jAhS+wEgAiP8SWyd
 CMKerRdY4tvubgXvsCU/sy2ea/Q/1JxKQuXaWtnI0om13ieyrOKSoRgXGfNVnwSWaxWN1uYxV
 m38XeE1VWPPKv+ufIDU+Cj3aF9izC2KmHoiZxI3Dwdrbwc2sZwXmT7o23b8jMhJ+crpYnf1oZ
 CmdsVGNmT8HJAT4L9qL4nmUdAMajXnHMli3NKXxKIQORQz3h4Y8L6R1S5v47ObfZoORvHIV+m
 SIgsmrYF2tyGlcUlg2MgAQBaqlt4esjiW2pzQEKprDI5QzfnynMaUPjj/D08Kiqtv+HYB20It
 G4YaKSbSS3vD9g=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7ddb58cb0ecae8e8b6181d736a87667cc9ab8389:

  Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux (2021-11-03 21:18:44 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.16/parisc-2

for you to fetch changes up to 2a2e8202c7a16a85a881ad2b6e32ccbebdc01dda:

  parisc: move CPU field back into thread_info (2021-11-04 11:21:47 +0100)

----------------------------------------------------------------
Second round of parisc architecture fixes and updates for kernel v5.16-rc1

One build error fix and two optimizations:

- Fix build error by moving the CPU field back into thread_info struct
  (Ard Biesheuvel)

- Do not enable IRQs unconditionally at start of interrupt handler if
  they were disabled before (Sven Schnelle)

- Keep interrupts enabled during cmpxchg and futex operations (Dave Anglin)

----------------------------------------------------------------
Ard Biesheuvel (1):
      parisc: move CPU field back into thread_info

Dave Anglin (1):
      parisc: Don't disable interrupts in cmpxchg and futex operations

Sven Schnelle (1):
      parisc: don't enable irqs unconditionally in handle_interruption()

 arch/parisc/include/asm/futex.h       | 24 +++++++++++-------------
 arch/parisc/include/asm/smp.h         | 19 ++-----------------
 arch/parisc/include/asm/thread_info.h |  3 +++
 arch/parisc/kernel/asm-offsets.c      |  5 -----
 arch/parisc/kernel/smp.c              |  2 --
 arch/parisc/kernel/syscall.S          | 10 ----------
 arch/parisc/kernel/traps.c            |  2 +-
 7 files changed, 17 insertions(+), 48 deletions(-)
