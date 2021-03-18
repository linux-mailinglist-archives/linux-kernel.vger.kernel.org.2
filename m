Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5718A340A4B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 17:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbhCRQhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 12:37:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57707 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232081AbhCRQgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 12:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616085409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qX5PWWWF43USLNXVgeToYpkCYDaMY6YQEwK1ZN4gNn0=;
        b=hktsqOc1tafRD4/FryxK5X/49l5BPJFmab1iZDbmfUqzUHuaJW0PmQVeqcAufpJPgs0jJy
        IhRKxS6yM5IJ1JVvL06yJ2kFRikoDwF+wd1NqoiPFa94TJVVqAZoTUHqy4No8kDhY3BQp3
        /LEZl1kpQzWKtuzTzeCNWldX6dhkhFU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-Z-oQx_gRMoiBt1ek90H-wA-1; Thu, 18 Mar 2021 12:36:45 -0400
X-MC-Unique: Z-oQx_gRMoiBt1ek90H-wA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D6EA1922977;
        Thu, 18 Mar 2021 16:36:44 +0000 (UTC)
Received: from treble (ovpn-120-92.rdu2.redhat.com [10.10.120.92])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AB5B260916;
        Thu, 18 Mar 2021 16:36:42 +0000 (UTC)
Date:   Thu, 18 Mar 2021 11:36:40 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suze.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] objtool: Rework rebuild_reloc logic
Message-ID: <20210318163640.5u6rucdk66aodun7@treble>
References: <20210312171613.533405394@infradead.org>
 <20210312171653.649709484@infradead.org>
 <20210317033417.lbwemc2j2cpsdlzd@treble>
 <YFG53wkgw6nDBgIl@hirez.programming.kicks-ass.net>
 <20210318004917.sytcivxy5h2ujttc@treble>
 <YFNOH1m+FrFK8TRN@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YFNOH1m+FrFK8TRN@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 01:57:03PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 17, 2021 at 07:49:17PM -0500, Josh Poimboeuf wrote:
> > On Wed, Mar 17, 2021 at 09:12:15AM +0100, Peter Zijlstra wrote:
> > > On Tue, Mar 16, 2021 at 10:34:17PM -0500, Josh Poimboeuf wrote:
> > > > On Fri, Mar 12, 2021 at 06:16:18PM +0100, Peter Zijlstra wrote:
> > > > > --- a/tools/objtool/elf.c
> > > > > +++ b/tools/objtool/elf.c
> > > > > @@ -479,6 +479,8 @@ void elf_add_reloc(struct elf *elf, stru
> > > > >  
> > > > >  	list_add_tail(&reloc->list, &sec->reloc_list);
> > > > >  	elf_hash_add(elf->reloc_hash, &reloc->hash, reloc_hash(reloc));
> > > > > +
> > > > > +	sec->rereloc = true;
> > > > >  }
> > > > 
> > > > Can we just reuse sec->changed for this?  Something like this on top
> > > > (untested of course):
> > > 
> > > I think my worry was that we'd dirty too much and slow down the write,
> > > but I haven't done any actual performance measurements on this.
> > 
> > Really?  I thought my proposal was purely aesthetic, no functional
> > change, but my brain is toasty this week due to other distractions so
> > who knows.
> 
> I was thinking you could get a section changed without touching
> relocations, but while that is theoretically possible, it is exceedingly
> unlikely (and objtool doesn't do that).

Hm?  This is a *relocation* section, not a normal one.  So by
definition, it only changes when its relocations change.

-- 
Josh

