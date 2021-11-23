Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14AA4599E5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 02:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbhKWCAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 21:00:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:59526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230482AbhKWCAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 21:00:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 899AF60F70;
        Tue, 23 Nov 2021 01:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637632653;
        bh=DiRZ07Mz/LWCX1YgwTR0bxKJ+0HA3rQ0vFZS0plyMeQ=;
        h=From:To:Cc:Subject:Date:From;
        b=JjyhIRa4CRbPyeqxAFKMYepicgB1u4mNGFAtvPh6M56DylmdkG5nJ1HVAIq7Tez06
         X8RIrW5MOYPI/HNAWyVfzs0Y9pv0S7O43inZCdwzGn5zPA2rdiEFqlX1DEuLKb17oX
         S08/2GMgJkD1exeSQbRpiSDppmFiGtGEviL5Dbb4qHRCDZpOM5gS8EipaKGjdENEhS
         4dhrUKAr/xw3UlRMLc/h55Y7SvFM9pBSM1LtNrGOq1Qi9mBJUhZK4OIn9WPVKJDuSi
         nEXvMTU2at9EI2VSQ2uFzpZEsKDjp/lBF++mfPdXMsVgQGyiymXPl7+4d9TKNu5htx
         dWiLDSWbLvsFg==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup@brainfault.org, palmer@dabbelt.com,
        atishp@rivosinc.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH 0/3] riscv: Add riscv.fwsz kernel parameter to save memory
Date:   Tue, 23 Nov 2021 09:57:14 +0800
Message-Id: <20211123015717.542631-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The firmware of riscv (such as opensbi) occupy 2MB(64bit) /
4MB(32bit) in Linux. It's very wasteful to small memory footprint
soc chip such as Allwinner D1s/F133. The kernel parameter gives a
chance to users to set the proper size of the firmware and get
more than 1.5MB of memory.

Guo Ren (3):
  riscv: Remove 2MB offset in the mm layout
  riscv: Add early_param to decrease firmware region
  riscv: Add riscv.fwsz kernel parameter

 .../admin-guide/kernel-parameters.txt         |  3 +++
 arch/riscv/include/asm/page.h                 |  8 +++++++
 arch/riscv/kernel/head.S                      | 10 +++-----
 arch/riscv/kernel/vmlinux.lds.S               |  5 ++--
 arch/riscv/mm/init.c                          | 23 ++++++++++++++++---
 5 files changed, 36 insertions(+), 13 deletions(-)

-- 
2.25.1

