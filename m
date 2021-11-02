Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D52442EFA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 14:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhKBNUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 09:20:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:42208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231265AbhKBNUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 09:20:00 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD69360EBC;
        Tue,  2 Nov 2021 13:17:23 +0000 (UTC)
Date:   Tue, 2 Nov 2021 09:17:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Carles Pey <carles.pey@gmail.com>,
        Changbin Du <changbin.du@intel.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Punit Agrawal <punitagrawal@gmail.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>,
        Song Liu <songliubraving@fb.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Viktor Rosendahl <Viktor.Rosendahl@bmw.de>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        Weizhao Ouyang <o451686892@gmail.com>,
        chongjiapeng <jiapeng.chong@linux.alibaba.com>,
        kernel test robot <lkp@intel.com>,
        =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [GIT PULL] tracing: Updates for 5.16
Message-ID: <20211102091722.5375b885@gandalf.local.home>
In-Reply-To: <CAHk-=wgY1B0Ae+gVNP0e2bZPSBgaDJPwSVXFOx5r-dGgurJuvQ@mail.gmail.com>
References: <20211101175544.00fc0d57@gandalf.local.home>
        <CAHk-=wgY1B0Ae+gVNP0e2bZPSBgaDJPwSVXFOx5r-dGgurJuvQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2021 20:08:30 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Nov 1, 2021 at 2:55 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Also, this pull request will conflict with your tree against a fix I had
> > for trace recursions. I did the conflict resolution and pushed it to my
> > ftrace/conflicts branch if you want to reference it.  
> 
> In the meantime, my tree had grown a few more conflicts elsewhere, but
> it all looked fairly straightforward.
> 
> It might be a good idea if you were to double-check that everything
> looks good, though.
>

I performed the merge and conflict resolution to the same commit you used,
and came up with pretty much the same (sans whitespace differences).

The only thing I would like to bring attention to is the wording for the
comment to kprobe_flush_task() that both Thomas and Masami updated, and I
want to make sure they are both happy with the final result:

Thomas, Masami ?

/*
 * This function is called from delayed_put_task_struct() when a task is
 * dead and cleaned up to recycle any kretprobe instances associated with
 * this task. These left over instances represent probed functions that
 * have been called but will never return.
 */
void kprobe_flush_task(struct task_struct *tk)

You OK with the above wording?


-- Steve
