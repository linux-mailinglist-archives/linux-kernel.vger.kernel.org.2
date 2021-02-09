Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3E73153B9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 17:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbhBIQXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 11:23:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48264 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231520AbhBIQXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 11:23:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612887740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fnqy1YnymfhhTNjzdgV1GtWpdANUOkHB0zW274Bne5A=;
        b=DUi1BLvZTDEsWtLWd4yI91y/NJ32bkoiaDK3jlYDSiDuiCzFNpmyj4Fbsv6z6VAwjF2HjK
        FZcRb4ULUlhOTsYRNJJQ/hAyz+LptnEiyjCphniUvZ88pVYpjl1BtWz/dXPBJdgJdRmes3
        TtQ3AWQq4NHdNgXwh/h5ioi85Mj+M+0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-7ZuLcs4WOtyZC-GWEToQFA-1; Tue, 09 Feb 2021 11:22:18 -0500
X-MC-Unique: 7ZuLcs4WOtyZC-GWEToQFA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0693835E22;
        Tue,  9 Feb 2021 16:22:16 +0000 (UTC)
Received: from treble (ovpn-120-169.rdu2.redhat.com [10.10.120.169])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4580460861;
        Tue,  9 Feb 2021 16:22:16 +0000 (UTC)
Date:   Tue, 9 Feb 2021 10:22:14 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 05/12] x86/irq: Provide macro for inlining irq stack
 switching
Message-ID: <20210209162214.twr35rrb2qwvlx3f@treble>
References: <20210204204903.350275743@linutronix.de>
 <20210204211154.618389756@linutronix.de>
 <20210208204209.yccd76j7sp2zbv37@treble>
 <87zh0db7ha.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zh0db7ha.fsf@nanos.tec.linutronix.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 04:12:33PM +0100, Thomas Gleixner wrote:
> On Mon, Feb 08 2021 at 14:42, Josh Poimboeuf wrote:
> > On Thu, Feb 04, 2021 at 09:49:08PM +0100, Thomas Gleixner wrote:
> >>  #ifdef CONFIG_X86_64
> >> +
> >> +#ifdef CONFIG_UNWINDER_FRAME_POINTER
> >> +# define IRQSTACK_CALL_CONSTRAINT	, ASM_CALL_CONSTRAINT
> >> +#else
> >> +# define IRQSTACK_CALL_CONSTRAINT
> >> +#endif
> >
> > Is this really needed?  i.e. does ASM_CALL_CONSTRAINT actually affect
> > code generation with !FRAME_POINTER?
> 
> The problem is that if the asm inline is the first operation in a
> function some compilers insert the asm inline before setting up the
> frame pointer.
> 
> That's actualy irrelevant here as the compiler cannot reorder against
> the C code leading to the asm inline. So we can probably replace it with
> a big fat comment.

Actually, I think keeping ASM_CALL_CONSTRAINT is a good idea.

What I meant was, is the #ifdef needed?  My previous understanding was
that ASM_CALL_CONSTRAINT has no effect for !FRAME_POINTER (i.e., ORC).

So is there any reason to *not* have ASM_CALL_CONSTRAINT with ORC?

-- 
Josh

