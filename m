Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557FE3625FD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 18:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbhDPQuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 12:50:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235437AbhDPQuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 12:50:23 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6745261008;
        Fri, 16 Apr 2021 16:49:57 +0000 (UTC)
Date:   Fri, 16 Apr 2021 12:49:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     zhaoxiao <zhaoxiao@uniontech.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        nivedita@alum.mit.edu, clin@suse.com,
        andriy.shevchenko@linux.intel.com, ndesaulniers@google.com,
        dan.j.williams@intel.com, masahiroy@kernel.org,
        linux-kernel@vger.kernel.org, jroedel@suse.de, peterz@infradead.org
Subject: Re: [PATCH v2] X86: Makefile: Replace -pg with CC_FLAGS_FTRACE
Message-ID: <20210416124955.64e824e3@gandalf.local.home>
In-Reply-To: <20210416151258.gjchvi7c5uneiy63@treble>
References: <20210416053928.11576-1-zhaoxiao@uniontech.com>
        <20210416151258.gjchvi7c5uneiy63@treble>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Apr 2021 10:12:58 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> Adding Steven Rostedt (ftrace maintainer).

Thanks.

> 
> On Fri, Apr 16, 2021 at 01:39:28PM +0800, zhaoxiao wrote:
> > In preparation for x86 supporting ftrace built on other compiler
> > options, let's have the x86 Makefiles remove the $(CC_FLAGS_FTRACE)
> > flags, whatever these may be, rather than assuming '-pg'.
> > 
> > There should be no functional change as a result of this patch.
> > 
> > Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
> > ---
> > v2: add the same change for the other Makefile in arch/x86 directory.
> >  arch/x86/entry/vdso/Makefile |  8 ++++----
> >  arch/x86/kernel/Makefile     | 16 ++++++++--------
> >  arch/x86/kernel/cpu/Makefile |  4 ++--
> >  arch/x86/lib/Makefile        |  2 +-
> >  arch/x86/mm/Makefile         |  4 ++--
> >  arch/x86/xen/Makefile        |  6 +++---
> >  6 files changed, 20 insertions(+), 20 deletions(-)
> > 

I'm good with switching "-pg" over to "$(CC_FLAGS_FTRACE)" globally.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
