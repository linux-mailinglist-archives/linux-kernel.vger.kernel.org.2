Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69EB632A908
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 19:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580564AbhCBSEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 13:04:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:39032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1578615AbhCBP0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:26:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91EA564F31;
        Tue,  2 Mar 2021 15:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614698718;
        bh=Nq8L06FtypdWg8CR2NXIMxneJKdnrBKynQYhaYdm4pY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CFbWBbrNu0SPNCkri4XW66CSPtZTqrC66Sx6rm62QsayDnJShXPKhj8cVbeIdawla
         pT5VFxF1jOY/aWwjA3DBkpPB6gkOtCGalt1NDIHo7DIJT2ETcOIT+XIDPG/Hes/Izi
         q3oDWSI3y7ISNIYcK+PbEB18rLS9AlwdIqRSuOZ/B3oKorU7gmJpO74p0UqB9Gcn2M
         VF85mUi5mtFNU28V9rdkCoQXlcgMwHmStOyk5XNW6drXf2+0R1N731viOR8SbnQmsx
         0UwzEyIzK9i5SMR8KT5hw5W6vyKBKJmHwxwuHkyV+5NGzyYLsjsIHpmpwBg0oUf7uB
         /9Fvpk7n6AEYQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH -tip 0/3] x86/kprobes: Remoev single-step trap from x86 kprobes
Date:   Wed,  3 Mar 2021 00:25:12 +0900
Message-Id: <161469871251.49483.9142858308048988638.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225112245.607c70ec13cf8d279390e89e@kernel.org>
References: <20210225112245.607c70ec13cf8d279390e89e@kernel.org>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a series of patches to remove the single-step debug trap from the
x86 kprobe.

The first 2 patches ([1/3][2/3]) are bugfixes which I've sent recently;

 https://lore.kernel.org/lkml/161425451732.93763.18329509061375062554.stgit@devnote2/

And [3/3] is actually the patch to remove single-step from kprobes. The RFC
version is here;

 https://lore.kernel.org/lkml/161460768474.430263.18425867006584111900.stgit@devnote2/

This uses int3 as Andy suggested instead of the debug trap, for removing the
IRET which returns to kernel.
Some instructions must be emulated and some instructions becomes not able
to be probed, but as far as I can see those are not rare case.

Thank you,

---

Masami Hiramatsu (3):
      x86/kprobes: Retrieve correct opcode for group instruction
      x86/kprobes: Identify far indirect JMP correctly
      x86/kprobes: Use int3 instead of debug trap for single-step


 arch/x86/include/asm/kprobes.h |   21 +-
 arch/x86/kernel/kprobes/core.c |  524 ++++++++++++++++++++++++++--------------
 arch/x86/kernel/traps.c        |    3 
 3 files changed, 358 insertions(+), 190 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
