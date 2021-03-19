Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5D434207C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 16:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhCSPE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 11:04:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46636 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230232AbhCSPEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 11:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616166290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zLqdQIzS2QxcA5cy/lN81+jC3rlHpWNz6jKvsOXt1B8=;
        b=YPYzyUMEoLr5Ry7a4BoGIRXHFHHBelB+Bn8Ml4sT+JnB+s7OvggqdyynyUAx8bsGywAmvp
        5mDmes5Qj2EO+fhkb3nKhKOyjDubZMLECZYtezpNaQncDlWRoPPX9Tpmve1D2S+MFTOynm
        z1Y/QOg7ivzckgMGMenUTvyowZ8ItAs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-D_5mqc-WMh618AQxYqt4lQ-1; Fri, 19 Mar 2021 11:04:46 -0400
X-MC-Unique: D_5mqc-WMh618AQxYqt4lQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61F2E911E4;
        Fri, 19 Mar 2021 15:04:45 +0000 (UTC)
Received: from treble (ovpn-119-18.rdu2.redhat.com [10.10.119.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E4AC360CD7;
        Fri, 19 Mar 2021 15:04:43 +0000 (UTC)
Date:   Fri, 19 Mar 2021 10:04:41 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/14] objtool: Extract elf_symbol_add()
Message-ID: <20210319150441.3sbxb33v2onbndib@treble>
References: <20210318171103.577093939@infradead.org>
 <20210318171920.007925810@infradead.org>
 <20210319021403.idfcvrzuj3ywbxhx@treble>
 <YFR0vesRq5DDFCSE@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YFR0vesRq5DDFCSE@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 10:54:05AM +0100, Peter Zijlstra wrote:
> On Thu, Mar 18, 2021 at 09:14:03PM -0500, Josh Poimboeuf wrote:
> > On Thu, Mar 18, 2021 at 06:11:13PM +0100, Peter Zijlstra wrote:
> > > Create a common helper to add symbols.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  tools/objtool/elf.c |   57 ++++++++++++++++++++++++++++++----------------------
> > >  1 file changed, 33 insertions(+), 24 deletions(-)
> > > 
> > > --- a/tools/objtool/elf.c
> > > +++ b/tools/objtool/elf.c
> > > @@ -290,12 +290,41 @@ static int read_sections(struct elf *elf
> > >  	return 0;
> > >  }
> > >  
> > > +static bool elf_symbol_add(struct elf *elf, struct symbol *sym)
> > 
> > How about "elf_add_symbol()" for consistency with my other suggestions
> > (elf_add_reloc() and elf_add_string()).  And return an int.
> 
> Changed the nane, how about void? This latest incarnation doesn't
> actually have an error path. Still doesn't hurt to have one and not use
> it I suppose...

void would be my preference, just to avoid unnecessary error handling
boilerplate in the caller.

-- 
Josh

