Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4E934B759
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 14:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhC0NBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 09:01:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:58440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229582AbhC0NBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 09:01:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75A6561971;
        Sat, 27 Mar 2021 13:01:03 +0000 (UTC)
Date:   Sat, 27 Mar 2021 13:01:01 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: Re: [PATCH 1/4] arm64: expose orig_x0 in the user_pt_regs structure
Message-ID: <20210327130100.GA31076@arm.com>
References: <20210322225053.428615-1-avagin@gmail.com>
 <20210322225053.428615-2-avagin@gmail.com>
 <20210326182839.GE5126@arm.com>
 <CANaxB-xTrMkJ2D19wwjSbCfizdRDnNO52fibpaRXP5g3hOcQwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaxB-xTrMkJ2D19wwjSbCfizdRDnNO52fibpaRXP5g3hOcQwQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 05:35:19PM -0700, Andrei Vagin wrote:
> On Fri, Mar 26, 2021 at 11:28 AM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> >
> > On Mon, Mar 22, 2021 at 03:50:50PM -0700, Andrei Vagin wrote:
> > > diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
> > > index 758ae984ff97..3c118c5b0893 100644
> > > --- a/arch/arm64/include/uapi/asm/ptrace.h
> > > +++ b/arch/arm64/include/uapi/asm/ptrace.h
> > > @@ -90,6 +90,7 @@ struct user_pt_regs {
> > >       __u64           sp;
> > >       __u64           pc;
> > >       __u64           pstate;
> > > +     __u64           orig_x0;
> > >  };
> >
> > That's a UAPI change, likely to go wrong. For example, a
> > ptrace(PTRACE_GETREGSET, pid, REGSET_GPR, data) would write past the end
> > of an old struct user_pt_regs in the debugger.
> 
> ptrace(PTRACE_GETREGSET, ...) receives iovec:
> ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov)
> 
> iov contains a pointer to a buffer and its size and the kernel fills
> only the part that fits the buffer.
> I think this interface was invented to allow extending structures
> without breaking backward compatibility.

You are right here, it doesn't write past the end of the iov buffer.
However, it's still an ABI change. An unaware program using a newer
user_pt_regs but running on an older kernel may be surprised that the
updated iov.len is smaller than sizeof (struct user_pt_regs).

Changing this structure also changes the core dump format, see ELF_NGREG
and ELF_CORE_COPY_REGS. Maybe this doesn't matter much either since the
ELF note would have size information but I'd prefer if we didn't modify
this structure.

-- 
Catalin
