Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADBE63140B3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbhBHUnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:43:15 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:50169 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236212AbhBHTbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:31:07 -0500
X-Originating-IP: 2.7.49.219
Received: from debian.home (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id C803F60008;
        Mon,  8 Feb 2021 19:30:20 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, kasan-dev@googlegroups.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH 0/4] Kasan improvements and fixes 
Date:   Mon,  8 Feb 2021 14:30:13 -0500
Message-Id: <20210208193017.30904-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small series contains some improvements for the riscv KASAN code:

- it brings a better readability of the code (patch 1/2)
- it fixes oversight regarding page table population which I uncovered
  while working on my sv48 patchset (patch 3)
- it helps to have better performance by using hugepages when possible
  (patch 4)

Alexandre Ghiti (4):
  riscv: Improve kasan definitions
  riscv: Use KASAN_SHADOW_INIT define for kasan memory initialization
  riscv: Improve kasan population function
  riscv: Improve kasan population by using hugepages when possible

 arch/riscv/include/asm/kasan.h |  22 +++++-
 arch/riscv/mm/kasan_init.c     | 119 ++++++++++++++++++++++++---------
 2 files changed, 108 insertions(+), 33 deletions(-)

-- 
2.20.1

