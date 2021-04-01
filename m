Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB77350F07
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 08:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbhDAG33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 02:29:29 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:59360 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229850AbhDAG25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 02:28:57 -0400
Date:   Thu, 1 Apr 2021 07:28:46 +0100
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        linux-ia64@vger.kernel.org, "Dmitry V . Levin" <ldv@altlinux.org>
Subject: Re: [PATCH] ia64: fix user_stack_pointer() for ptrace()
Message-ID: <20210401072846.0cabee26@sf>
In-Reply-To: <20210331174908.4655f2a41a7b1bbec36fae47@linux-foundation.org>
References: <20210331084447.2561532-1-slyfox@gentoo.org>
        <20210331174908.4655f2a41a7b1bbec36fae47@linux-foundation.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2021 17:49:08 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 31 Mar 2021 09:44:47 +0100 Sergei Trofimovich <slyfox@gentoo.org> wrote:
> 
> > ia64 has two stacks:
> > - memory stack (or stack), pointed at by by r12
> > - register backing store (register stack), pointed at
> >   ar.bsp/ar.bspstore with complications around dirty
> >   register frame on CPU.
> > 
> > In https://bugs.gentoo.org/769614 Dmitry noticed that
> > PTRACE_GET_SYSCALL_INFO returns register stack instead
> > memory stack.
> > 
> > The bug comes from the fact that user_stack_pointer() and
> > current_user_stack_pointer() don't return the same register:
> > 
> >   ulong user_stack_pointer(struct pt_regs *regs) { return regs->ar_bspstore; }
> >   #define current_user_stack_pointer() (current_pt_regs()->r12)
> > 
> > The change gets both back in sync.
> > 
> > I think ptrace(PTRACE_GET_SYSCALL_INFO) is the only affected user
> > by this bug on ia64.
> > 
> > The change fixes 'rt_sigreturn.gen.test' strace test where
> > it was observed initially.
> >   
> 
> I assume a cc:stable is justified here?
> 
> The bug seems to have been there for 10+ years, so there isn't a lot of
> point in looking for the Fixes: reference.

Yes, I think cc:stable is fine.

-- 

  Sergei
