Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F006340636
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 14:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhCRM73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhCRM7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:59:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C71C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 05:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZT0gy2r7v1/B9vqHI07WV/IgP39yaXGfSrqMZkiTlyA=; b=PBPkQ2c235mVrzeLx0Y5eVfroB
        C0cjNLYJGEMOvK6zMNPXMPEswajM/ieavWO0SqExpKClayWFRUUHER99aVhvFaYLfjrjoReZKMl1C
        unOq/MmpicSC/JIIHzQq6HeCnDd9UBAm4wtmsQSvNyQzRAF7wppEKum8R1Cgp/+wRyya255j/kjpD
        gvVzn1KV+3SRbdiZfGaffCYupW4517w/VIf83uw8ThxwyxGLmtZmZJ7RDuFeZByxC34Iztch9z1GI
        +jsBET8u894QhdcQCpI0cB1JVz+xpy0w/+8BAxQvWeKfful1kP5VfN+D7TXH6zG546lERyP/aSAEm
        70WCRf9g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMsD2-005HIL-Vd; Thu, 18 Mar 2021 12:59:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 00AB13012DF;
        Thu, 18 Mar 2021 13:57:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DA05F21244794; Thu, 18 Mar 2021 13:57:03 +0100 (CET)
Date:   Thu, 18 Mar 2021 13:57:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suze.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] objtool: Rework rebuild_reloc logic
Message-ID: <YFNOH1m+FrFK8TRN@hirez.programming.kicks-ass.net>
References: <20210312171613.533405394@infradead.org>
 <20210312171653.649709484@infradead.org>
 <20210317033417.lbwemc2j2cpsdlzd@treble>
 <YFG53wkgw6nDBgIl@hirez.programming.kicks-ass.net>
 <20210318004917.sytcivxy5h2ujttc@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318004917.sytcivxy5h2ujttc@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 07:49:17PM -0500, Josh Poimboeuf wrote:
> On Wed, Mar 17, 2021 at 09:12:15AM +0100, Peter Zijlstra wrote:
> > On Tue, Mar 16, 2021 at 10:34:17PM -0500, Josh Poimboeuf wrote:
> > > On Fri, Mar 12, 2021 at 06:16:18PM +0100, Peter Zijlstra wrote:
> > > > --- a/tools/objtool/elf.c
> > > > +++ b/tools/objtool/elf.c
> > > > @@ -479,6 +479,8 @@ void elf_add_reloc(struct elf *elf, stru
> > > >  
> > > >  	list_add_tail(&reloc->list, &sec->reloc_list);
> > > >  	elf_hash_add(elf->reloc_hash, &reloc->hash, reloc_hash(reloc));
> > > > +
> > > > +	sec->rereloc = true;
> > > >  }
> > > 
> > > Can we just reuse sec->changed for this?  Something like this on top
> > > (untested of course):
> > 
> > I think my worry was that we'd dirty too much and slow down the write,
> > but I haven't done any actual performance measurements on this.
> 
> Really?  I thought my proposal was purely aesthetic, no functional
> change, but my brain is toasty this week due to other distractions so
> who knows.

I was thinking you could get a section changed without touching
relocations, but while that is theoretically possible, it is exceedingly
unlikely (and objtool doesn't do that).

Because if entries have relocations, then adding an entry will also add
relocations etc..

pre: 79.269 +- 0.104 seconds time elapsed  ( +-  0.13% )
post: 79.0604 +- 0.0441 seconds time elapsed  ( +-  0.06% )
fini: 79.2995 +- 0.0448 seconds time elapsed  ( +-  0.06% )

is what I get for kbuild x86_64-defconfig-ish build times with the
various patches applied. Which is all noise afaict. I'll fold your
thing. Less is more etc..
