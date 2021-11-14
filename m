Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149B044FA04
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 19:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbhKNTBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 14:01:20 -0500
Received: from mout.gmx.net ([212.227.17.20]:39001 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234564AbhKNTBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 14:01:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636916286;
        bh=mT2oOSXYfgyZ/6gj+loHbZRTxrt0+Zx33oDXnFskF0k=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=KD5sqWZL5LR4djHl6++joWAopF/Q6PEIpB7g2NXsecnNna3GefYdrBvQWX4zZOZ2Y
         8d69KIU+q/OQts8wMhiUW4i9t+Cp6SlYBNvd1eKNkPlflYe97WnuCqV2mWor+YdHpl
         2TliWkaoBraCV5K/nbnIS7ovsTcTfKIHDajSwv7Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([92.116.191.59]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhD6g-1m9PNU0vuU-00eNfI; Sun, 14
 Nov 2021 19:58:06 +0100
Date:   Sun, 14 Nov 2021 19:57:32 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>
Subject: [GIT PULL] few more parisc architecture fixes for kernel v5.16-rc1
Message-ID: <YZFcHM+23JDGpXTE@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:ek5S+BSPO3iUnM6d3px+IvhDXfDfEHfihx4bunPycUHLQRnrXKe
 VYsDLUEqhGWnfwIjNaOkz5MxIEYdWNipz+7McRvU64bB0frZuXdWUdP3+TBkPnG1YZ6BTT4
 23FYXMLmR2XtHw69rMIGV4FNWwPc+sqjGr/KkTTvRxdIq2iFJPsMi3tFvViPBlVsc3WEuiu
 +CCFAwf8IybfmQiEt84wQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7X4/k2bmU5s=:xwJKQObmabn4x/GC5tReM8
 6msLafOEI28NAuRLQf19pnVLqgvMRxOnzF2YxSe7z82/SACEVw83xO+aNLFN+Vvbp2x8Mjh+8
 3ldzHtlbe44/gHRnXyIUyaDvYhAziGjA4WzFKhbThsHwmGyFKofROZxOU8paoyg8syfGLCgHh
 prsua/O00VPtgo4RF5r5Wt6S3llrJMhptab7DZpvtbE588nPjqnRAQR4fciShJmfaLs8aM6we
 K1jIKyrYce95tecaiCbsTjcencS/EyoyfpvsXcp+beZlx8GZAahk2B/SxwJ56ni4hpixwrIoK
 PBnL3hRw/hxl5/XK7BAwWB6MVAU3K2xjkQbJyB0rdaoxRoXF2mTjVCwvwgtVa34nOQCKPYol+
 TvQ25Y5WpnP8yyzUZkcsx2WA+rSM/hGRPPu+fs28hbL3tKb6kCOCxKWe5rqlNq3wFj44xGNqW
 6bY4vmvizYZZ6E16kJTSs5d1kOGJHjt8lU2R3FKXF0Am3lJAqwKDlBMDKciiJm0Od/lDvveW5
 0P00BBBcOuJLIy39tIDSuNBTGoykTFbJEtV424GxtfH5sjL6pG8DrFl88OlTEWhIWeOP7tv67
 r+ArCd+WaucDlEW2dks+s6q/K0BHDuI5a9gOHeG5+yK8XfZCn3J4nISBrxwKRdn9LFHBGom3G
 KJLFwjVaGud8HX/2d/Px+jjXe0i/XrKO/Cg2lVCDp6mMCVwhZtzkGLAgjhjCUPipY9tKv1NGj
 oPG/FZbJusqR1YDiktu8DI0Fi5RO2dlvVRiEHrPhWsUL1EhAdVzyte0XVgn8C+6eQQBIYhavl
 s+ZagkaqZc5ud/l3pK+Nt/ER6iDjm38J9ObGUuRQ1ghQIOLXlChZnzvt4O0rV0kV+CoLKYQLn
 3RvjkCqsjdATyNdjA6Sbz1+tPXL9LixYpMH3GUJEjZCj8CiF2wXmYY5pFF5Tqr9XBrC6rdmnx
 HkeyNyi1UhuKsbGUkPX8tQHjtICqVbsL+GucmdaqGWOvYL83qUhMm9lRBKMw7qNJZ7lOKOYud
 WoPRqyUvGIsx5ZGC6O1AeZXHaNJiCdhLS3uF3OUX1t/1vSDnacABT78dtp7uklglvedore93A
 UrCwxRDygjqQY8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit c8103c2718eb99aab954187ca5be14f3d994c9be:

  Merge tag '5.16-rc-part2-smb3-client-fixes' of git://git.samba.org/sfrench/cifs-2.6 (2021-11-13 12:24:19 -0800)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.16/parisc-3

for you to fetch changes up to 3ec18fc7831e7d79e2d536dd1f3bc0d3ba425e8a:

  parisc/entry: fix trace test in syscall exit path (2021-11-13 22:10:56 +0100)

----------------------------------------------------------------
parisc architecture build-, trace-, backtrace- and page table fixes

Fix a build error in stracktrace.c, fix resolving of addresses to
function names in backtraces, fix single-stepping in assembly code
and flush userspace pte's when using set_pte_at().

----------------------------------------------------------------
Helge Deller (2):
      parisc: Fix backtrace to always include init funtion names
      parisc: Fix implicit declaration of function '__kernel_text_address'

John David Anglin (1):
      parisc: Flush kernel data mapping in set_pte_at() when installing pte for user page

Sven Schnelle (1):
      parisc/entry: fix trace test in syscall exit path

 arch/parisc/include/asm/pgtable.h | 10 ++++++++--
 arch/parisc/kernel/cache.c        |  4 ++--
 arch/parisc/kernel/entry.S        |  2 +-
 arch/parisc/kernel/stacktrace.c   |  1 +
 arch/parisc/kernel/vmlinux.lds.S  |  3 ++-
 5 files changed, 14 insertions(+), 6 deletions(-)
