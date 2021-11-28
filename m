Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EBE460768
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 17:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358323AbhK1QUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 11:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358150AbhK1QSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 11:18:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6A4C061574
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 08:14:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A6D8B80D10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 16:14:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC91C004E1;
        Sun, 28 Nov 2021 16:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638116094;
        bh=vHDplKEDLCK/kpKCYkZg98w+XWHX6aiLaK0i/C/Hktg=;
        h=From:To:Cc:Subject:Date:From;
        b=Gpq7AS8WI+lWVCKh3ewefnBYpCMWnrfBjubh8AiL4nnzXPD5Dcrt7Ha3F8WVnvYc0
         dAJ5ra6jNsGnMaWXQvOmehg6Vf/QRnFXwEVg7GG/Uu6G3DW2EJwSykdjHLs6Plg0w0
         YoJ0bU5vsqpLF5gi4LtSb0pZa28gtuXtVpQBN+hkOdcvuX8CmpO/XAqq9EhMbzmdup
         sS+ktGwp5qO86A3uR/eNyTDTm/6ko6fy6kCSv0c0SoG/Rv4dqvueuL1F2UP4apl3b5
         +tJ7qLdP41CKoCukhosiZNApfNyHI7C0U+oxgmSdXZY1nmlnH8vCIC3yeFGntuuZ9r
         2F+8M/UTvFnOQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org
Subject: [PATCH 0/5] riscv: misc clean up
Date:   Mon, 29 Nov 2021 00:07:36 +0800
Message-Id: <20211128160741.2122-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a misc clean up: clean up useless LoCs, or make some
functions static, or mark function pointer as __initdata, or remove
one function().

Jisheng Zhang (5):
  riscv: remove cpu_stop()
  riscv: head: make secondary_start_common() static
  riscv: kvm: make kvm_riscv_vcpu_fp_clean() static
  riscv: errata: alternative: mark vendor_patch_func __initdata
  riscv: head: remove useless __PAGE_ALIGNED_BSS and .balign

 arch/riscv/errata/alternative.c | 3 ++-
 arch/riscv/include/asm/smp.h    | 2 --
 arch/riscv/kernel/cpu-hotplug.c | 8 +-------
 arch/riscv/kernel/head.S        | 9 ++-------
 arch/riscv/kvm/vcpu_fp.c        | 2 +-
 5 files changed, 6 insertions(+), 18 deletions(-)

-- 
2.34.0

