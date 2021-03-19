Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C6A3418D5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 10:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhCSJwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 05:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhCSJwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:52:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EB5C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 02:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3DpuGMduZ7yp16ZcH+M5QIfwva5ao+NexadrXBZppUY=; b=fUgr6ZJYcnp25Vt7WpCSGdbA/i
        6GTwt8fg9bMjhG4fYzabx3YfoKk4matX/6c9I35J6xjDw2d4NsNwaTGdWC3/diQCi6AeNtItnFjSA
        dplhKNhyrtu8DaGGFIirTBfB05XJL+2EqfIfs/C8cCgL6h21iOdeHZgHmeJIeuxW6CfhscQi65X/V
        RQFPx1KKMJ6MfAupXLrVxtmrwu8QqIShKpsVoavyPaKm01lF9wB3A7r1bbRA53geHGrO9X/7t51U2
        mYFflQS0BGmw/2JuGFFE2Bm8HyMFNDspo/r5LjglkP8RjnKBK3qciN6o78Qiy0kt8ciy7q5N/JN81
        S6KBLkEA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lNBnX-006z3u-RP; Fri, 19 Mar 2021 09:52:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7BD103006E0;
        Fri, 19 Mar 2021 10:52:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 678F52B4C3BE2; Fri, 19 Mar 2021 10:52:03 +0100 (CET)
Date:   Fri, 19 Mar 2021 10:52:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/14] objtool: Extract elf_strtab_concat()
Message-ID: <YFR0Q5KdtSnsgRN3@hirez.programming.kicks-ass.net>
References: <20210318171103.577093939@infradead.org>
 <20210318171919.948282703@infradead.org>
 <20210319021038.6mfpnbel67yhyapw@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319021038.6mfpnbel67yhyapw@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 09:10:38PM -0500, Josh Poimboeuf wrote:
> On Thu, Mar 18, 2021 at 06:11:12PM +0100, Peter Zijlstra wrote:
> > Create a common helper to append strings to a strtab.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  tools/objtool/elf.c |   73 +++++++++++++++++++++++++++++-----------------------
> >  1 file changed, 42 insertions(+), 31 deletions(-)
> > 
> > --- a/tools/objtool/elf.c
> > +++ b/tools/objtool/elf.c
> > @@ -676,13 +676,51 @@ struct elf *elf_open_read(const char *na
> >  	return NULL;
> >  }
> >  
> > +static int elf_strtab_concat(struct elf *elf, char *name, const char *strtab_name)
> > +{
> > +	struct section *strtab = NULL;
> > +	Elf_Data *data;
> > +	Elf_Scn *s;
> > +	int len;
> > +
> > +	if (strtab_name)
> > +		strtab = find_section_by_name(elf, strtab_name);
> > +	if (!strtab)
> > +		strtab = find_section_by_name(elf, ".strtab");
> > +	if (!strtab) {
> > +		WARN("can't find %s or .strtab section", strtab_name);
> > +		return -1;
> > +	}
> 
> This part's a bit mysterious (and it loses the Clang comment).  Maybe we
> can leave the section finding logic in elf_create_section()?

Sure, made it compile too ;-)
