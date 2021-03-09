Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47260331CB2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 03:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbhCICAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 21:00:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:41360 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230139AbhCICAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 21:00:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D60ADAB8C;
        Tue,  9 Mar 2021 01:59:59 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     npiggin@gmail.com
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, dave@stgolabs.net
Subject: [PATCH 0/3] powerpc/qspinlock: Some tuning updates
Date:   Mon,  8 Mar 2021 17:59:47 -0800
Message-Id: <20210309015950.27688-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A few updates while going through the powerpc port of the qspinlock.

Patches 1 and 2 are straightforward, while patch 3 can be considered
more of an rfc as I've only tested on a single machine, and there
could be an alternative way if it doesn't end up being nearly a
universal performance win.

Thanks!

Davidlohr Bueso (3):
  powerpc/spinlock: Define smp_mb__after_spinlock only once
  powerpc/spinlock: Unserialize spin_is_locked
  powerpc/qspinlock: Use generic smp_cond_load_relaxed

 arch/powerpc/include/asm/barrier.h         | 16 ----------------
 arch/powerpc/include/asm/qspinlock.h       | 14 --------------
 arch/powerpc/include/asm/simple_spinlock.h |  6 +-----
 arch/powerpc/include/asm/spinlock.h        |  3 +++
 4 files changed, 4 insertions(+), 35 deletions(-)

--
2.26.2

