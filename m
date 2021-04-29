Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95D136EE2A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 18:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbhD2QbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 12:31:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240873AbhD2Qa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 12:30:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97C8961407;
        Thu, 29 Apr 2021 16:30:09 +0000 (UTC)
Date:   Thu, 29 Apr 2021 12:30:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, peterz@infradead.org, jpoimboe@redhat.com,
        jbaron@akamai.com, ardb@kernel.org,
        Atish Patra <Atish.Patra@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>, akpm@linux-foundation.org,
        rppt@kernel.org, mhiramat@kernel.org, zong.li@sifive.com,
        guoren@linux.alibaba.com, wangkefeng.wang@huawei.com,
        0x7f454c46@gmail.com, chenhuang5@huawei.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH] RISC-V: insn: Use a raw spinlock to protect TEXT_POKE*
Message-ID: <20210429123007.5144fc0d@gandalf.local.home>
In-Reply-To: <20210429061713.783628-1-palmer@dabbelt.com>
References: <20210429061713.783628-1-palmer@dabbelt.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2021 23:17:13 -0700
Palmer Dabbelt <palmer@dabbelt.com> wrote:

> From: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> We currently use text_mutex to protect the fixmap sections from
> concurrent callers.  This is convienent for kprobes as the generic code
> already holds text_mutex, but ftrace doesn't which triggers a lockdep
> assertion.  We could take text_mutex for ftrace, but the jump label
> implementation (which is currently taking text_mutex) isn't explicitly
> listed as being sleepable and it's called from enough places it seems
> safer to just avoid sleeping.
> 
> arm64 and parisc, the other two TEXT_POKE-style patching
> implemnetations, already use raw spinlocks.  abffa6f3b157 ("arm64:
> convert patch_lock to raw lock") lays out the case for a raw spinlock as
> opposed to a regular spinlock, and while I don't know of anyone using rt
> on RISC-V I'm sure it'll eventually show up and I don't see any reason
> to wait.

On x86 we use text_mutex for jump label and ftrace. I don't understand the
issue here. The arm64 update was already using spin locks in the
insn_write() function itself. riscv just makes sure that text_mutex is held.

It also looks like ftrace on riscv should also have text_mutex held
whenever it modifies the code. Because I see this in
arch/riscv/kernel/ftrace.c:


int ftrace_arch_code_modify_prepare(void) __acquires(&text_mutex)
{
        mutex_lock(&text_mutex);
        return 0;
}

int ftrace_arch_code_modify_post_process(void) __releases(&text_mutex)
{
        mutex_unlock(&text_mutex);
        return 0;
}

Which should be getting called before and after respectively from when
ftrace does its updates.

Can you show me the back trace of that lockdep splat?

-- Steve
