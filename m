Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8CC32A0E5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576785AbhCBEcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:32:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:56948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236658AbhCBCse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 21:48:34 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98D8F61477;
        Tue,  2 Mar 2021 02:47:04 +0000 (UTC)
Date:   Mon, 1 Mar 2021 21:47:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [x86, build] 6dafca9780:
 WARNING:at_arch/x86/kernel/ftrace.c:#ftrace_verify_code
Message-ID: <20210301214702.1119c732@oasis.local.home>
In-Reply-To: <YD2loOkd/AYqKPB6@google.com>
References: <20210301074027.GD12822@xsang-OptiPlex-9020>
        <CABCJKuc8H83b_8_Ccp+Cb7O9x5oEu6sPNq63sjGcAJcgiwy0bw@mail.gmail.com>
        <20210301184524.7aa05ac1@gandalf.local.home>
        <CABCJKudQme=bcNJtNCORUpBnVA_Pkr2Zk_3Nu2EsfnuoE7LJ3g@mail.gmail.com>
        <20210301201526.65ce7f1c@oasis.local.home>
        <YD2loOkd/AYqKPB6@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2021 18:40:32 -0800
Sami Tolvanen <samitolvanen@google.com> wrote:

> On Mon, Mar 01, 2021 at 08:15:26PM -0500, Steven Rostedt wrote:
> > On Mon, 1 Mar 2021 16:03:51 -0800
> > Sami Tolvanen <samitolvanen@google.com> wrote:  
> > >   
> > > >                 ret = ftrace_verify_code(rec->ip, old);
> > > > +
> > > > +               if (__is_defined(CC_USING_NOP_MCOUNT) && ret && old_nop) {
> > > > +                       /* Compiler could have put in P6_NOP5 */
> > > > +                       old = P6_NOP5;
> > > > +                       ret = ftrace_verify_code(rec->ip, old);
> > > > +               }
> > > > +    
> > > 
> > > Wouldn't that still hit WARN(1) in the initial ftrace_verify_code()
> > > call if ideal_nops doesn't match?  
> > 
> > That was too quickly written ;-)
> > 
> > Take 2:
> > 
> > [ with fixes for setting p6_nop ]  
> 
> Thanks, I tested this with the config from the build bot, and I can
> confirm that it fixes the issue for me.
> 
> I also tested a quick patch to disable the __fentry__ conversion in
> objtool, and it seems to work too, but it's probably a good idea to
> fix the issue with CC_USING_NOP_MCOUNT in any case.

Thanks for testing, I'll make this into a proper patch and start
testing it internally. I'm assuming you want this to go into the -rc
release and possibly stable?

-- Steve
