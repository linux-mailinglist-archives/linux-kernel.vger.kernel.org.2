Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F8A328E62
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 20:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241811AbhCAT3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 14:29:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50067 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235838AbhCAQxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 11:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614617497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UgPyarlr6W1bLi3oYMeukIfXXQreFYTHjI6/bdnuDIM=;
        b=Mcl6V6W+GBThtorJZ+TEzWAIETqTMxviQzJPPuG1Dff63vGL2uPao8Sv3zcCs3KQiMPiV8
        i6cBvyOzXBKiqjgFlpLUrC4VcurctZIqf3Zjoh+UhLlmntODpwudGppn9x5e8r557Am9Do
        YvMfVc7mGZ4yR2Sy/ywMflCagxpAtCg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-p_Wd3qiHPP-YujrgL27ewA-1; Mon, 01 Mar 2021 11:51:36 -0500
X-MC-Unique: p_Wd3qiHPP-YujrgL27ewA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2CE950742;
        Mon,  1 Mar 2021 16:51:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id A0B4D10013C1;
        Mon,  1 Mar 2021 16:51:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  1 Mar 2021 17:51:34 +0100 (CET)
Date:   Mon, 1 Mar 2021 17:51:31 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: Why do kprobes and uprobes singlestep?
Message-ID: <20210301165130.GA5351@redhat.com>
References: <CALCETrXzXv-V3A3SpN_Pdj_PNG8Gw0AVsZD7+VO-q_xCAu2T2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXzXv-V3A3SpN_Pdj_PNG8Gw0AVsZD7+VO-q_xCAu2T2A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

sorry for delay.

On 02/23, Andy Lutomirski wrote:
>
> A while back, I let myself be convinced that kprobes genuinely need to
> single-step the kernel on occasion, and I decided that this sucked but
> I could live with it.  it would, however, be Really Really Nice (tm)
> if we could have a rule that anyone running x86 Linux who single-steps
> the kernel (e.g. kgdb and nothing else) gets to keep all the pieces
> when the system falls apart around them.  Specifically, if we don't
> allow kernel single-stepping and if we suitably limit kernel
> instruction breakpoints (the latter isn't actually a major problem),
> then we don't really really need to use IRET to return to the kernel,
> and that means we can avoid some massive NMI nastiness.

Not sure I understand you correctly, I know almost nothing about low-level
x86  magic.

But I guess this has nothing to do with uprobes, they do not single-step
in kernel mode, right?

> Uprobes seem to single-step user code for no discernable reason.
> (They want to trap after executing an out of line instruction, AFAICT.
> Surely INT3 or even CALL after the out-of-line insn would work as well
> or better.)

Uprobes use single-step from the very beginning, probably because this
is the most simple and "standard" way to implement xol.

And please note that CALL/JMP/etc emulation was added much later to fix the
problems with non-canonical addresses, and this emulation it still incomplete.

Oleg.

