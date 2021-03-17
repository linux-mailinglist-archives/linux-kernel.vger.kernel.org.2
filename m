Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2433333EB20
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhCQIMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:12:55 -0400
Received: from casper.infradead.org ([90.155.50.34]:50526 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCQIMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IehPtnr2c07Eo8n4Xevc6LWmWOtEfSwpKWxcioQnaYs=; b=YKuydSMcvq7+32CZHk4OQAyrEY
        wzEw7pN1EgujwvuZSREK+iGF2hvzySihXft+Sk/r1lBwalnR92Ooy3jXFbzVH/u+4Mk1rzKPzGnh6
        i3bBb+KgGuTC+vpvyFwXicZL+GV956Pl8mnKKRRbvOZPenqJBDiS9+akeUbS5/Q76eQ8/0UxmdkEN
        1aEynOopC0fvD+BnBN0nEokGn7YOnm39NVd1f8gAVe4tBBvkV30o06eutAjaqfPVdOqNa+oiMKww3
        JXPf7TQlmZZwfGO8vsjLLnZBYKwpcAcLr27TVsDOGOV5hYBcJVRw9/qCzodl7CMy3CFSVeGWn1IOR
        th/yS3xQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMRHs-001Fki-8s; Wed, 17 Mar 2021 08:12:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7774A3006E0;
        Wed, 17 Mar 2021 09:12:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 659A62C0B11A5; Wed, 17 Mar 2021 09:12:15 +0100 (CET)
Date:   Wed, 17 Mar 2021 09:12:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suze.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] objtool: Rework rebuild_reloc logic
Message-ID: <YFG53wkgw6nDBgIl@hirez.programming.kicks-ass.net>
References: <20210312171613.533405394@infradead.org>
 <20210312171653.649709484@infradead.org>
 <20210317033417.lbwemc2j2cpsdlzd@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317033417.lbwemc2j2cpsdlzd@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 10:34:17PM -0500, Josh Poimboeuf wrote:
> On Fri, Mar 12, 2021 at 06:16:18PM +0100, Peter Zijlstra wrote:
> > --- a/tools/objtool/elf.c
> > +++ b/tools/objtool/elf.c
> > @@ -479,6 +479,8 @@ void elf_add_reloc(struct elf *elf, stru
> >  
> >  	list_add_tail(&reloc->list, &sec->reloc_list);
> >  	elf_hash_add(elf->reloc_hash, &reloc->hash, reloc_hash(reloc));
> > +
> > +	sec->rereloc = true;
> >  }
> 
> Can we just reuse sec->changed for this?  Something like this on top
> (untested of course):

I think my worry was that we'd dirty too much and slow down the write,
but I haven't done any actual performance measurements on this.

Let me do a few runs and see if it matters at all.
