Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038E3422E44
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 18:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbhJEQsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 12:48:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233896AbhJEQsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 12:48:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11B3C61381;
        Tue,  5 Oct 2021 16:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633452384;
        bh=aCGjlYwlXvH+nAOfI2fEY5kp5ron3AO1hrs4o0ZWp4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=peJYUDhopLM69sOCM6826yBjUh6VB8AIvz8H234df7IbGmJY7UG4Rwp6dSseIDi0z
         vzobrjrWa6qNHzrqt8FP7IB9d7yyLTcXlp+HAVFhavEPP9wpvS5jiQUrzoHiA4Lmve
         tTjMdHRaOxmbp9uOVCZRGDUX+APtcYL0X4thRuYlaaZVwJ9Kc6zqo9t4h0nNnUSOa9
         6ah4oRPKsggzXXjhpQM3eerroKkUaERtjpANmLwy4T/iw93rLgdsnGADOjc3C1TxQ0
         xY8jTtXuhj8WI2Gdvtd+KAt2G54Ok9gOEJ2pqgT55Dp6oUiTjGto+dp8SNTxIxpTDC
         0WKbb1AbPa3hg==
Date:   Tue, 5 Oct 2021 11:50:27 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ftrace: Fix -Wcast-function-type warnings on
 powerpc64
Message-ID: <20211005165027.GA797862@embeddedor>
References: <20211005053922.GA702049@embeddedor>
 <20211005111714.18ebea2b@gandalf.local.home>
 <20211005161812.GA768055@embeddedor>
 <20211005123522.244281e6@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211005123522.244281e6@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 12:35:22PM -0400, Steven Rostedt wrote:
> On Tue, 5 Oct 2021 11:18:12 -0500
> "Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:
> 
> > On Tue, Oct 05, 2021 at 11:17:14AM -0400, Steven Rostedt wrote:
> > > On Tue, 5 Oct 2021 00:39:22 -0500
> > > "Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:
> > >   
> > > > In order to make sure new function cast mismatches are not introduced
> > > > in the kernel (to avoid tripping CFI checking), the kernel should be
> > > > globally built with -Wcast-function-type.
> > > > 
> > > > So, fix the following -Wcast-function-type warnings on powerpc64
> > > > (ppc64_defconfig):  
> > > 
> > > I think I'll go back and add my linker magic.
> > > 
> > >   https://lore.kernel.org/all/20200617165616.52241bde@oasis.local.home/
> > > 
> > > I'll clean it up a bit too. I'll have a patch in a bit.  
> > 
> > Awesome. :)
> > 
> > Thanks
> > --
> 
> Does this fix it for you?

Nop; there are still some warnings (ppc64_defconfig):

kernel/trace/ftrace.c: In function ‘ftrace_ops_get_list_func’:
kernel/trace/ftrace.c:171:10: error: returning ‘void (*)(long unsigned int,  long unsigned int,  struct ftrace_ops *, struct ftrace_regs *)’ from a function with incompatible return type ‘ftrace_func_t’ {aka ‘void (*)(long unsigned int,  long unsigned int)’} [-Werror=incompatible-pointer-types]
  171 |   return ftrace_ops_list_func;
      |          ^~~~~~~~~~~~~~~~~~~~
kernel/trace/ftrace.c: In function ‘update_ftrace_function’:
kernel/trace/ftrace.c:204:8: error: assignment to ‘ftrace_func_t’ {aka ‘void (*)(long unsigned int,  long unsigned int)’} from incompatible pointer type ‘void (*)(long unsigned int,  long unsigned int,  struct ftrace_ops *, struct ftrace_regs *)’ [-Werror=incompatible-pointer-types]
  204 |   func = ftrace_ops_list_func;
      |        ^
kernel/trace/ftrace.c:217:11: warning: comparison of distinct pointer types lacks a cast
  217 |  if (func == ftrace_ops_list_func) {
      |           ^~
kernel/trace/ftrace.c: In function ‘ftrace_modify_all_code’:
kernel/trace/ftrace.c:2695:35: error: passing argument 1 of ‘ftrace_update_ftrace_func’ from incompatible pointer type [-Werror=incompatible-pointer-types]
 2695 |   err = ftrace_update_ftrace_func(ftrace_ops_list_func);
      |                                   ^~~~~~~~~~~~~~~~~~~~
      |                                   |
      |                                   void (*)(long unsigned int,  long unsigned int,  struct ftrace_ops *, struct ftrace_regs *)
In file included from kernel/trace/ftrace.c:29:
./include/linux/ftrace.h:585:52: note: expected ‘ftrace_func_t’ {aka ‘void (*)(long unsigned int,  long unsigned int)’} but argument is of type ‘void (*)(long unsigned int,  long unsigned int,  struct ftrace_ops *, struct ftrace_regs *)’
  585 | extern int ftrace_update_ftrace_func(ftrace_func_t func);
      |                                      ~~~~~~~~~~~~~~^~~~
kernel/trace/ftrace.c:2705:38: warning: comparison of distinct pointer types lacks a cast
 2705 |  if (update && ftrace_trace_function != ftrace_ops_list_func) {
      |                                      ^~

--
Gustavo
