Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC11A438B10
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 19:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhJXRq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 13:46:29 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:44540 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231757AbhJXRqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 13:46:25 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 19OHhxMX018387;
        Sun, 24 Oct 2021 19:43:59 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Ammar Faizi <ammar.faizi@students.amikom.ac.id>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] nolibc updates and cleanups
Date:   Sun, 24 Oct 2021 19:43:20 +0200
Message-Id: <20211024174323.18338-1-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

this small series includes the following updates for nolibc:

  - small cleanups and code reductions for x86_64 based on the removal
    of a few unneeded registers from the clobber list, and one shorter
    instruction to set the NR_exit value in %eax, both by Ammar Faizi.

  - Implementation of the gettid() syscall, by Mark Brown.

Please note, due to two adjacent instructions being touched by this
series and the previous one ("nolibc fixes marked for stable"), this
series will only apply after the stable one (I ordered the patches to
ease the backport to stable).

Thank you!
Willy

Ammar Faizi (2):
  tools/nolibc: x86: Remove `r8`, `r9` and `r10` from the clobber list
  tools/nolibc: x86-64: Use `mov $60,%eax` instead of `mov $60,%rax`

Mark Brown (1):
  tools/nolibc: Implement gettid()

 tools/include/nolibc/nolibc.h | 53 +++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 15 deletions(-)

-- 
2.17.5

