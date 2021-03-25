Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334B7348DB2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhCYKIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:08:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229617AbhCYKI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:08:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5370161A28;
        Thu, 25 Mar 2021 10:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616666906;
        bh=qBh9X3Ibv4fOJ4Pd4E80u6UTOYvNfnLHnBNTdIn7CGE=;
        h=From:To:Cc:Subject:Date:From;
        b=GgpAzCC29LtjBRbRo0SPkb5kO8fsvhRQa+qxx3cyUJwRCiMIygdXpwjcUec8l00gv
         O4TNPpjmQfR8msA9U8CvNOgrbxKRcVOws8WLtHMAn6lbTKBPzhZXZOItxKhtoJldVL
         nOi7CWn4yhGdr/UgHPvWLlipCnV9LZkeHgce3QZrf1pCaKDLXAAWBzLY/+jxis6fMx
         OtlNoohp2uqNgtT1TMXVQeRu3D0xCaNi4uWSs1JaovJV2hnFKvFIq2RoxvF69Cba/f
         1r36k1cCGJzY9fFUfk1wFZgfK7ygLtWkHcn+TNFdsW4WV6V7mZF/IozIztLhhQuP5t
         MpKRc3kDHi4YQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        dan.carpenter@oracle.com,
        Muhammad Usama Anjum <musamaanjum@gmail.com>
Subject: [PATCH -tip 0/2] x86/kprobes: Fix and cleanup can_boost()
Date:   Thu, 25 Mar 2021 19:08:20 +0900
Message-Id: <161666690060.1120877.4569379871114610764.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are 2 bugfixes for the x86/kprobes, [1/2] fixes an old bug which tries to find
instruction prefixes in insn->opcode (which should be never found) and misusing
insn->attr. [2/2] fixes a new bug found by Coverity in the recent commit 6256e668b7
("x86/kprobes: Use int3 instead of debug trap for single-step").
To fix the 2nd one, [2/2] also cleanup the switch-case with range cases, because
that is much more clear what is not boostable.

Thank you,

---

Masami Hiramatsu (2):
      x86/kprobes: Fix to check non boostable prefixes correctly
      x86/kprobes: Fix to identify indirect jmp and others using range case


 arch/x86/kernel/kprobes/core.c |   57 +++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
