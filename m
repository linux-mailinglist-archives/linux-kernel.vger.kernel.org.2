Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02DED422E68
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 18:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbhJEQx1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Oct 2021 12:53:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233896AbhJEQx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 12:53:26 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CA6261090;
        Tue,  5 Oct 2021 16:51:35 +0000 (UTC)
Date:   Tue, 5 Oct 2021 12:51:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ftrace: Fix -Wcast-function-type warnings on
 powerpc64
Message-ID: <20211005125132.4ae5d128@gandalf.local.home>
In-Reply-To: <20211005165027.GA797862@embeddedor>
References: <20211005053922.GA702049@embeddedor>
        <20211005111714.18ebea2b@gandalf.local.home>
        <20211005161812.GA768055@embeddedor>
        <20211005123522.244281e6@gandalf.local.home>
        <20211005165027.GA797862@embeddedor>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2021 11:50:27 -0500
"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> Nop; there are still some warnings (ppc64_defconfig):

Thanks, I'll take a look, and compile it against ppc64_defconfig.

-- Steve

> 
> kernel/trace/ftrace.c: In function ‘ftrace_ops_get_list_func’:
> kernel/trace/ftrace.c:171:10: error: returning ‘void (*)(long unsigned int,  long unsigned int,  struct ftrace_ops *, struct ftrace_regs *)’ from a function with incompatible return type ‘ftrace_func_t’ {aka ‘void (*)(long unsigned int,  long unsigned int)’} [-Werror=incompatible-pointer-types]
>   171 |   return ftrace_ops_list_func;
>       |          ^~~~~~~~~~~~~~~~~~~~
> kernel/trace/ftrace.c: In function ‘update_ftrace_function’:
> kernel/trace/ftrace.c:204:8: error: assignment to ‘ftrace_func_t’ {aka ‘void (*)(long unsigned int,  long unsigned int)’} from incompatible pointer type ‘void (*)(long unsigned int,  long unsigned int,  struct ftrace_ops *, struct ftrace_regs *)’ [-Werror=incompatible-pointer-types]
>   204 |   func = ftrace_ops_list_func;
>       |        ^
> kernel/trace/ftrace.c:217:11: warning: comparison of distinct pointer types lacks a cast
>   217 |  if (func == ftrace_ops_list_func) {
>       |           ^~
> kernel/trace/ftrace.c: In function ‘ftrace_modify_all_code’:
> kernel/trace/ftrace.c:2695:35: error: passing argument 1 of ‘ftrace_update_ftrace_func’ from incompatible pointer type [-Werror=incompatible-pointer-types]
>  2695 |   err = ftrace_update_ftrace_func(ftrace_ops_list_func);
>       |                                   ^~~~~~~~~~~~~~~~~~~~
>       |                                   |
>       |                                   void (*)(long unsigned int,  long unsigned int,  struct ftrace_ops *, struct ftrace_regs *)
> In file included from kernel/trace/ftrace.c:29:
> ./include/linux/ftrace.h:585:52: note: expected ‘ftrace_func_t’ {aka ‘void (*)(long unsigned int,  long unsigned int)’} but argument is of type ‘void (*)(long unsigned int,  long unsigned int,  struct ftrace_ops *, struct ftrace_regs *)’
>   585 | extern int ftrace_update_ftrace_func(ftrace_func_t func);
>       |                                      ~~~~~~~~~~~~~~^~~~
> kernel/trace/ftrace.c:2705:38: warning: comparison of distinct pointer types lacks a cast
>  2705 |  if (update && ftrace_trace_function != ftrace_ops_list_func) {
>       |                                      ^~
