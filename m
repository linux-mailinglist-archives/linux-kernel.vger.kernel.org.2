Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61F9438AF7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 19:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhJXRbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 13:31:36 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:44524 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229638AbhJXRbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 13:31:35 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 19OHSWAM018037;
        Sun, 24 Oct 2021 19:28:32 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Bedirhan KURT <windowz414@gnuweeb.org>,
        Louvian Lyndal <louvianlyndal@gmail.com>,
        Ammar Faizi <ammar.faizi@students.amikom.ac.id>,
        Peter Cordes <peter@cordes.ca>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] nolibc fixes marked for -stable
Date:   Sun, 24 Oct 2021 19:28:13 +0200
Message-Id: <20211024172816.17993-1-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

here are a few fixes for nolibc. Ammar Faizi figured that the stack was
not properly aligned on x86_64, it was aligned for after the call instead
of before due to my misunderstanding of the spec. This made me check i386
and I got it wrong there as well. Others are OK as they do not push but
switch pointers on a call. The problem is essentially detected when using
SIMD instructions (either voluntarily or when the compiler does it on its
own).

A second (less important) issue is that I thought that it was up to the
userland code to truncate the code passed to exit() to 8 bits while it's
the kernel that does it. The difference is subtle but is visible in strace,
and this was reported by Ammar as well. This time it affected all supported
archs.

This series is based on 5.15-rc6. I marked them for backport to stable,
just in case anyone uses nolibc for bisecting bugs.

Thanks!
Willy


Ammar Faizi (1):
  tools/nolibc: x86-64: Fix startup code bug

Willy Tarreau (2):
  tools/nolibc: i386: fix initial stack alignment
  tools/nolibc: fix incorrect truncation of exit code

 tools/include/nolibc/nolibc.h | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

-- 
2.17.5

