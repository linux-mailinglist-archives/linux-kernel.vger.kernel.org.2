Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7D443960C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 14:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbhJYMXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:23:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232455AbhJYMXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:23:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BE0460C49;
        Mon, 25 Oct 2021 12:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635164468;
        bh=JV1mpIeCSzX8GePfpnW8PcigBSkTj7UpXOkBuwJJ6t0=;
        h=From:To:Cc:Subject:Date:From;
        b=EMA0FRl/ggerm3EttqkhWO45j8qqWzk1C25/3dmdpCLrfz/CcKwXvcyR74Dam+sFy
         J+TcfC8GQimFONlZ3XOJauucbyJIic9yncHZZkp9CCBFF1bOAl3Fv2sQVRihm0Km7i
         +T35WeF7wmHg8LifdicKMk70nHSZ9zTF1n3rh8mPRKeSXDsopHpOxoke+2DVI8w5gE
         /wgCpXHj+/7Ere/9vnAZf08dhUMET9RNZcpt792X2JoVKinpUZU3usjRP/neE463JG
         ESE5SFwOvpNQfjCNQMy7W2JDBZPTDeSAnucEf3+iKdhTDW5tEq5NBW7S25Okifaltf
         DQz1cnJvMNcPw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        James Morse <james.morse@arm.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 0/4] arm64: Support dynamic preemption v2
Date:   Mon, 25 Oct 2021 14:20:58 +0200
Message-Id: <20211025122102.46089-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Not much change on the core side but:

_ Use latest arm64 static call implementation by Ard
_ Rebase against latest tip:/sched/core

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	preempt/arm-v2

HEAD: 5700542b609d9ab640210d7dd93621c7967688e6

Thanks,
	Frederic
---

Frederic Weisbecker (3):
      sched/preempt: Prepare for supporting !CONFIG_GENERIC_ENTRY dynamic preemption
      arm64: Implement IRQ exit preemption static call for dynamic preemption
      arm64: Implement HAVE_PREEMPT_DYNAMIC

Ard Biesheuvel (1):
      arm64: implement support for static call trampolines


 arch/Kconfig                         |  1 -
 arch/arm64/Kconfig                   |  2 ++
 arch/arm64/include/asm/preempt.h     | 23 +++++++++++++++-
 arch/arm64/include/asm/static_call.h | 25 ++++++++++++++++++
 arch/arm64/kernel/entry-common.c     | 15 ++++++++---
 arch/arm64/kernel/patching.c         | 51 +++++++++++++++++++++++++++++++++---
 arch/arm64/kernel/vmlinux.lds.S      |  1 +
 include/linux/entry-common.h         |  3 ++-
 kernel/sched/core.c                  |  6 +++--
 9 files changed, 116 insertions(+), 11 deletions(-)
