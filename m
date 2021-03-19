Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E3A3420EC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 16:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhCSPZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 11:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhCSPYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 11:24:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E5DC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 08:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kyJG/kt9os/hxc+Ah7xlHfnz0+4Et6z4fDJycqU1YnI=; b=Pnrp2cpBOkMgk44s/CcBWO2hEu
        i95iAE7crWh13u6lBkIyvitRZEAHK8toke0lBvHZjHzwK1OivivouEs4MWkHZQpgF5fKgQHWN1bEg
        y36htDGOqma7FdYhi1h/Y16s4/ULxAW/cnFBOFp8S9mNj1YJa3k3Yd8sSDtYEHYUiSK3xge1RSrd4
        XFEP5K45lp2YAcHxwJENhLwkuEl7vvNZaWncR+ZYhvVlI+7vKyynXaR4SDO2hdow12sNLW5hbBEN/
        aVYMxceiBXpa6InyfqMnbesz9CoVtbhZPDMghQ014Bi7kmT4hfwWwP1p02mKUOBQGZfrTMV3YjMee
        j3902jwg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lNGzR-007d7u-BO; Fri, 19 Mar 2021 15:24:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8E9513003E1;
        Fri, 19 Mar 2021 16:24:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7A154235E19DF; Fri, 19 Mar 2021 16:24:40 +0100 (CET)
Date:   Fri, 19 Mar 2021 16:24:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/14] objtool: Add elf_create_reloc() helper
Message-ID: <YFTCOGMfNkPknNDv@hirez.programming.kicks-ass.net>
References: <20210318171103.577093939@infradead.org>
 <20210318171919.887152166@infradead.org>
 <20210319014246.c6trc4x3qewro32c@treble>
 <YFRzOFp5/pHaLDti@hirez.programming.kicks-ass.net>
 <20210319151259.6ddhamrh42wbvxav@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319151259.6ddhamrh42wbvxav@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 10:12:59AM -0500, Josh Poimboeuf wrote:

> > -void elf_add_reloc(struct elf *elf, struct reloc *reloc)
> > +int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
> > +		  unsigned int type, struct symbol *sym, int addend)
> >  {
> > -	struct section *sec = reloc->sec;
> > +	struct reloc *reloc;
> > +
> > +	reloc = malloc(sizeof(*reloc));
> > +	if (!reloc) {
> > +		perror("malloc");
> > +		return -1;
> > +	}
> > +	memset(reloc, 0, sizeof(*reloc));
> > +
> > +	reloc->sec = sec->reloc;
> 
> Maybe elf_add_reloc() could create the reloc section if it doesn't
> already exist, that would help remove the multiple calls to
> elf_create_reloc_section().

I'll do that as yet another patch ;-)

> > +	reloc->offset = offset;
> > +	reloc->type = type;
> > +	reloc->sym = sym;
> > +	reloc->addend = addend;
> >  
> >  	list_add_tail(&reloc->list, &sec->reloc_list);
> 
> This should be sec->reloc->reloc_list?

Absolutely, there were a few other 'funnies' as well that I just fixed
whilst trying to make the whole new stack work again :-)
