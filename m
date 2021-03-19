Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC28E3416F4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 08:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbhCSH4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 03:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbhCSH4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 03:56:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4EBC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 00:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1YJSe22xW2gXr0PbIpfG0YIa0iFckjgJpwwmwQyxXi8=; b=meRwPhi0NLHhuErIEpHSbZBCkp
        lnTY8JsBOHJCkfFN7zN4MumLmcqRS3DKodLcjrY97/YjN2jaG5goHyp3R7+IkXNHXlHYWnMqHSJHG
        Jax6i4VF7EO/Iwln3wLlAscODsG5JMnYwrbH7JZvTOyAgTbKrZMiK7Z3tCnRDz+ROp6quyp4jFfGL
        Om2KgizQDRH3rWf5SvCdmFD7fdhhk3sIYBe60MtAyojcaJs1Yny2IpkZOHkq1xuCgLf1EZcZDNAOz
        pMvQOKHUrfcTTOJXvuv4czF60nqBtQ15HsfshbXinm68egJC1r9O/he6x6z1fnsRg1QWDAux+TGZN
        4D9JOzQQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lN9zt-006pbw-L5; Fri, 19 Mar 2021 07:56:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4EC633003E1;
        Fri, 19 Mar 2021 08:56:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 354982DA83E40; Fri, 19 Mar 2021 08:56:41 +0100 (CET)
Date:   Fri, 19 Mar 2021 08:56:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/14] objtool: Add elf_create_undef_symbol()
Message-ID: <YFRZOZtZrRdsLSwP@hirez.programming.kicks-ass.net>
References: <20210318171103.577093939@infradead.org>
 <20210318171920.068888092@infradead.org>
 <20210319022923.weykw3wtg3jysrm2@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319022923.weykw3wtg3jysrm2@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 09:29:23PM -0500, Josh Poimboeuf wrote:
> On Thu, Mar 18, 2021 at 06:11:14PM +0100, Peter Zijlstra wrote:
> > Allow objtool to create undefined symbols; this allows creating
> > relocations to symbols not currently in the symbol table.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  tools/objtool/elf.c                 |   63 ++++++++++++++++++++++++++++++++++++
> >  tools/objtool/include/objtool/elf.h |    1 
> >  2 files changed, 64 insertions(+)
> > 
> > --- a/tools/objtool/elf.c
> > +++ b/tools/objtool/elf.c
> > @@ -724,6 +724,69 @@ static int elf_strtab_concat(struct elf
> >  	return len;
> >  }
> >  
> > +struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name)
> > +{
> > +	struct section *symtab;
> > +	struct symbol *sym;
> > +	Elf_Data *data;
> > +	Elf_Scn *s;
> > +
> > +	sym = malloc(sizeof(*sym));
> > +	if (!sym) {
> > +		perror("malloc");
> > +		return NULL;
> > +	}
> > +	memset(sym, 0, sizeof(*sym));
> > +
> > +	sym->name = strdup(name);
> > +
> > +	sym->sym.st_name = elf_strtab_concat(elf, sym->name, NULL);
> > +	if (sym->sym.st_name == -1)
> > +		return NULL;
> > +
> > +	sym->sym.st_info = 0x10; /* STB_GLOBAL, STT_NOTYPE */
> 
> There's a generic macro for this:
> 	
> 	sym->sym.st_info = GELF_ST_INFO(STB_GLOBAL, STT_NOTYPE);

Ah, I remember not finding that many moons ago when I wrote that ..

> And sym->bind and sym->type should probably get set.

They are, it's in that elf_add_symbol() thing.
