Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6236332ADE9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360143AbhCBWRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:17:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49746 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1837022AbhCBU3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 15:29:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614716898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G23N6wBORktjng5iuSOoVaLduGa1U0lJXBy/yD7XCyo=;
        b=DaTFWkAzPZqh0y2lIkHomBj6nRZpmlMrCQxGfKs2AIOhWBDHAEQCbuwPum8NmXDDbFp7Y3
        umhkNnvpvOyUEEA5UfeYe+FjGR2Hn67ctMcfkG9qsxnyGh1tDURpvyeTLWrF0GdCiR6mqh
        L1u3yc1aIqA9bacGOrVbV1TutnFIvoc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-Rq-MfXJaNTekeqFEb-e0GA-1; Tue, 02 Mar 2021 15:28:12 -0500
X-MC-Unique: Rq-MfXJaNTekeqFEb-e0GA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6F5D107ACE8;
        Tue,  2 Mar 2021 20:28:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.160])
        by smtp.corp.redhat.com (Postfix) with SMTP id A32676F45E;
        Tue,  2 Mar 2021 20:28:08 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  2 Mar 2021 21:28:10 +0100 (CET)
Date:   Tue, 2 Mar 2021 21:28:07 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: Why do kprobes and uprobes singlestep?
Message-ID: <20210302202806.GB21871@redhat.com>
References: <CALCETrXzXv-V3A3SpN_Pdj_PNG8Gw0AVsZD7+VO-q_xCAu2T2A@mail.gmail.com>
 <20210301165130.GA5351@redhat.com>
 <CALCETrU2Rc4ejSoYyWgbk00U8tSc=aZDaj0mm+Ep62wOirZG7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrU2Rc4ejSoYyWgbk00U8tSc=aZDaj0mm+Ep62wOirZG7g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

forgot to add Srikar, sorry for resend...

On 03/01, Andy Lutomirski wrote:
>
> On Mon, Mar 1, 2021 at 8:51 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > But I guess this has nothing to do with uprobes, they do not single-step
> > in kernel mode, right?
>
> They single-step user code, though, and the code that makes this work
> is quite ugly.  Single-stepping on x86 is a mess.

But this doesn't really differ from, say, gdb doing si ? OK, except uprobes
have to hook DIE_DEBUG. Nevermind...

> > > Uprobes seem to single-step user code for no discernable reason.
> > > (They want to trap after executing an out of line instruction, AFAICT.
> > > Surely INT3 or even CALL after the out-of-line insn would work as well
> > > or better.)
> >
> > Uprobes use single-step from the very beginning, probably because this
> > is the most simple and "standard" way to implement xol.
> >
> > And please note that CALL/JMP/etc emulation was added much later to fix the
> > problems with non-canonical addresses, and this emulation it still incomplete.
>
> Is there something like a uprobe test suite?

Afaik, no.

> How maintained /

Add Srikar who sent the initial implementation. I can only say that I am glad that
./scripts/get_maintainer.pl no longer mentions me ;) I did some changes (including
emulation) but a) this was a long ago and b) only because I was forced^W asked to
fix the numerous bugs in this code.

> actively used is uprobe?

I have no idea, sorry ;)

Oleg.

