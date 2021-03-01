Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9CF8328058
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbhCAOJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:09:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:49314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236083AbhCAOIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:08:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 904DE64D99;
        Mon,  1 Mar 2021 14:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614607690;
        bh=B+oJtXP8jLA9R46vUJpzXxKoLBwvsxZUYVYrGcBwKP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TJbGI7+fOQV7mZjof50fylYGa2840aU9ILTgVz/YvHjF5tp8USpyricwB1xoAIWVS
         YI7/54ye/wpGckVq8U8eM130zCtuyW4BEMwa2/7jTiGt2aocX5WHU7AgAnTkIQqK6p
         SU5Motzc8yl5zvNEP5JGWkVn6o0l0bEmOwtN1Xh6OcOCiAKXt96D1YyYIJJxp0U7Bo
         E7Mp4CfukGm2X0bEAegKNkFFXwVUpbZR/KOE6Ol2YpZpX/ioJsyivErp8+pN2e5afo
         fP0VySnMoRsRQYE9mKNMjHuj5YrnXJOsVokPJIy//f9CkFOk82RwzdgDYtIzFbruth
         v4S3MTXqNwWhA==
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
Subject: [RFC PATCH 0/1] x86/kprobes: Remoev single-step trap from x86 kprobes
Date:   Mon,  1 Mar 2021 23:08:04 +0900
Message-Id: <161460768474.430263.18425867006584111900.stgit@devnote2>
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

Hi Andy,

Here is the patch to remove the single-step debug trap from the x86 kprobe.
This uses int3 as you suggested instead of the debug trap, for removing the
iret which returns to kernel.
Some instructions must be emulated and some instructions becomes not able
to be probed, but as far as I can see those are not rare case.

TODOs/discussions
 - extend kprobe debugfs interface to show the arch-dependent flags, like
   [BOOST], [EMULATE].
 - Consider this emulation code split into a file and share it with uprobe
   (uprobe already has its own emulator) and alternatives (it has int3_emulate_*)
   but it can be overengineering.
 - Add testcases for emulator. Current kprobe smoke test is not arch specific.
   Maybe better to probe an assembly target code so that it can test "boosted",
   "emulated" or "int3-single-stepped" cases.

Thank you,

---

Masami Hiramatsu (1):
      x86/kprobes: Use int3 instead of debug trap for single-step


 arch/x86/include/asm/kprobes.h |   21 +-
 arch/x86/kernel/kprobes/core.c |  515 ++++++++++++++++++++++++++--------------
 arch/x86/kernel/traps.c        |    3 
 3 files changed, 351 insertions(+), 188 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
