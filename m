Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DECB3342115
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 16:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhCSPiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 11:38:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33397 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229926AbhCSPiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 11:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616168283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z6Cxm+FnO6NGH2wG4Y+B2ZMG8+o7Fvc8m3wtM4tYI5g=;
        b=QeTAmfc8irpJU8Pa/dt74ah/M34wEpRbihcoG9K4mgEfc5HoGQJfSs2kmzpthOV51/Ydl+
        8MldwB44XZgTRSLo/4kQIASA/oi4qt92rkDXvar0lmiE90icHBcDQSQo3rrQQKyJAkOnzI
        TydvNem3K3CEJfvYYOcy5sToosIx5JE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-W31_TzUkPcKOqGTRX-m7UQ-1; Fri, 19 Mar 2021 11:37:59 -0400
X-MC-Unique: W31_TzUkPcKOqGTRX-m7UQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B22C107B7C3;
        Fri, 19 Mar 2021 15:37:58 +0000 (UTC)
Received: from treble (ovpn-119-18.rdu2.redhat.com [10.10.119.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B62381C936;
        Fri, 19 Mar 2021 15:37:56 +0000 (UTC)
Date:   Fri, 19 Mar 2021 10:37:53 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/14] objtool: Add elf_create_reloc() helper
Message-ID: <20210319153753.uhobpixww666c6op@treble>
References: <20210318171103.577093939@infradead.org>
 <20210318171919.887152166@infradead.org>
 <20210319014246.c6trc4x3qewro32c@treble>
 <YFRzOFp5/pHaLDti@hirez.programming.kicks-ass.net>
 <20210319151259.6ddhamrh42wbvxav@treble>
 <YFTCOGMfNkPknNDv@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YFTCOGMfNkPknNDv@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 04:24:40PM +0100, Peter Zijlstra wrote:
> On Fri, Mar 19, 2021 at 10:12:59AM -0500, Josh Poimboeuf wrote:
> 
> > > -void elf_add_reloc(struct elf *elf, struct reloc *reloc)
> > > +int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
> > > +		  unsigned int type, struct symbol *sym, int addend)
> > >  {
> > > -	struct section *sec = reloc->sec;
> > > +	struct reloc *reloc;
> > > +
> > > +	reloc = malloc(sizeof(*reloc));
> > > +	if (!reloc) {
> > > +		perror("malloc");
> > > +		return -1;
> > > +	}
> > > +	memset(reloc, 0, sizeof(*reloc));
> > > +
> > > +	reloc->sec = sec->reloc;
> > 
> > Maybe elf_add_reloc() could create the reloc section if it doesn't
> > already exist, that would help remove the multiple calls to
> > elf_create_reloc_section().
> 
> I'll do that as yet another patch ;-)

Ok!

> > > +	reloc->offset = offset;
> > > +	reloc->type = type;
> > > +	reloc->sym = sym;
> > > +	reloc->addend = addend;
> > >  
> > >  	list_add_tail(&reloc->list, &sec->reloc_list);
> > 
> > This should be sec->reloc->reloc_list?
> 
> Absolutely, there were a few other 'funnies' as well that I just fixed
> whilst trying to make the whole new stack work again :-)

I'm sure some of those were my fault, thanks for testing my crap :-)

-- 
Josh

