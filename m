Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99FF339D24
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 10:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhCMJDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 04:03:34 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:57639 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbhCMJDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 04:03:32 -0500
Received: from relay13.mail.gandi.net (unknown [217.70.178.233])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 72C843AAC3B
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 08:45:34 +0000 (UTC)
Received: from debian.home (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay13.mail.gandi.net (Postfix) with ESMTPSA id 736AF80003;
        Sat, 13 Mar 2021 08:45:10 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nylon Chen <nylon7@andestech.com>,
        Nick Hu <nickhu@andestech.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v3 0/2] Improve KASAN_VMALLOC support 
Date:   Sat, 13 Mar 2021 03:45:03 -0500
Message-Id: <20210313084505.16132-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset improves KASAN vmalloc implementation by fixing an
oversight where kernel page table was not flushed in patch 1 and by
reworking the kernel page table PGD level population in patch 2.

Changes in v3:
- Split into 2 patches
- Add reviewed-by

Changes in v2:
- Quiet kernel test robot warnings about missing prototypes by declaring
  the introduced functions as static.

Alexandre Ghiti (2):
  riscv: Ensure page table writes are flushed when initializing KASAN
    vmalloc
  riscv: Cleanup KASAN_VMALLOC support

 arch/riscv/mm/kasan_init.c | 61 +++++++++++++-------------------------
 1 file changed, 20 insertions(+), 41 deletions(-)

-- 
2.20.1

