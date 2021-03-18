Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CA733FC64
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 01:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhCRAt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 20:49:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31384 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229866AbhCRAtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 20:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616028564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D/3hYuWlD5QWFg+3c5fpFqJUN1HojwmjwAZ3Ne381gE=;
        b=hyVpBnlGkGveXTc6qgsRIK2o2oNLcry4drJjEayfjYbrqMxiTN+aS8eVnFq/66/iioi5Yd
        ngXC55cyW8nSYP7MlywKi0nscv/qX+sV02N7hADGuZ/y9J29p6s5h6+0mbYs39InN38H7a
        HDsYGq+CJakpOomkhYBE9of9kDGM/Xw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-LShe1bX9MEmAJegTipAOJA-1; Wed, 17 Mar 2021 20:49:22 -0400
X-MC-Unique: LShe1bX9MEmAJegTipAOJA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 962EE8189C7;
        Thu, 18 Mar 2021 00:49:21 +0000 (UTC)
Received: from treble (ovpn-112-220.rdu2.redhat.com [10.10.112.220])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 352771A26A;
        Thu, 18 Mar 2021 00:49:20 +0000 (UTC)
Date:   Wed, 17 Mar 2021 19:49:17 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suze.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] objtool: Rework rebuild_reloc logic
Message-ID: <20210318004917.sytcivxy5h2ujttc@treble>
References: <20210312171613.533405394@infradead.org>
 <20210312171653.649709484@infradead.org>
 <20210317033417.lbwemc2j2cpsdlzd@treble>
 <YFG53wkgw6nDBgIl@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YFG53wkgw6nDBgIl@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 09:12:15AM +0100, Peter Zijlstra wrote:
> On Tue, Mar 16, 2021 at 10:34:17PM -0500, Josh Poimboeuf wrote:
> > On Fri, Mar 12, 2021 at 06:16:18PM +0100, Peter Zijlstra wrote:
> > > --- a/tools/objtool/elf.c
> > > +++ b/tools/objtool/elf.c
> > > @@ -479,6 +479,8 @@ void elf_add_reloc(struct elf *elf, stru
> > >  
> > >  	list_add_tail(&reloc->list, &sec->reloc_list);
> > >  	elf_hash_add(elf->reloc_hash, &reloc->hash, reloc_hash(reloc));
> > > +
> > > +	sec->rereloc = true;
> > >  }
> > 
> > Can we just reuse sec->changed for this?  Something like this on top
> > (untested of course):
> 
> I think my worry was that we'd dirty too much and slow down the write,
> but I haven't done any actual performance measurements on this.

Really?  I thought my proposal was purely aesthetic, no functional
change, but my brain is toasty this week due to other distractions so
who knows.

> Let me do a few runs and see if it matters at all.

-- 
Josh

