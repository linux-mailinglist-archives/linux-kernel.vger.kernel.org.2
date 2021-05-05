Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85F6373C3C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 15:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbhEENVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 09:21:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20583 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229606AbhEENVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 09:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620220811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=buwK358EXACur1dtLJkV3OPco7maWEjjFk36E2kFDig=;
        b=J72tJ8AG3ZGzX0Knlhwui0TTPAjACPE7Es75IJD2Aj/Ms/dnaQ9jkEJwCD9RdKk8zABJiK
        oGfK9Ze2lHQ0UFUv/D6SsfbnCdS0XfTGhm/TP2qYtcLTsxK6zrMTlmEWuz04yDyoF3rjL6
        NlWCfaOIAWRBjpP5JTZWv2eSjhYAOek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-mYc0GcoHMeSmsywLbE8jWg-1; Wed, 05 May 2021 09:20:07 -0400
X-MC-Unique: mYc0GcoHMeSmsywLbE8jWg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0B6584A5FD;
        Wed,  5 May 2021 13:19:46 +0000 (UTC)
Received: from treble (ovpn-115-93.rdu2.redhat.com [10.10.115.93])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4B73D5D703;
        Wed,  5 May 2021 13:19:44 +0000 (UTC)
Date:   Wed, 5 May 2021 08:19:43 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 3/4] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Message-ID: <20210505131943.ci2svd6fmb22y7ac@treble>
References: <cover.1620186182.git.jpoimboe@redhat.com>
 <5ba93cdbf35ab40264a9265fc24575a9b2f813b3.1620186182.git.jpoimboe@redhat.com>
 <2f75c496ac774444b75ff808854b8e5f@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f75c496ac774444b75ff808854b8e5f@AcuMS.aculab.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 08:48:48AM +0000, David Laight wrote:
> From: Josh Poimboeuf
> > Sent: 05 May 2021 04:55
> > 
> > The x86 uaccess code uses barrier_nospec() in various places to prevent
> > speculative dereferencing of user-controlled pointers (which might be
> > combined with further gadgets or CPU bugs to leak data).
> ...
> > Remove existing barrier_nospec() usage, and instead do user pointer
> > masking, throughout the x86 uaccess code.  This is similar to what arm64
> > is already doing with uaccess_mask_ptr().
> ...
> > diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> > index fb75657b5e56..ebe9ab46b183 100644
> > --- a/arch/x86/include/asm/uaccess.h
> > +++ b/arch/x86/include/asm/uaccess.h
> > @@ -66,12 +66,35 @@ static inline bool pagefault_disabled(void);
> >   * Return: true (nonzero) if the memory block may be valid, false (zero)
> >   * if it is definitely invalid.
> >   */
> > -#define access_ok(addr, size)					\
> > +#define access_ok(addr, size)						\
> >  ({									\
> >  	WARN_ON_IN_IRQ();						\
> >  	likely(!__range_not_ok(addr, size, TASK_SIZE_MAX));		\
> >  })
> > 
> > +/*
> > + * Sanitize a user pointer such that it becomes NULL if it's not a valid user
> > + * pointer.  This prevents speculatively dereferencing a user-controlled
> > + * pointer to kernel space if access_ok() speculatively returns true.  This
> > + * should be done *after* access_ok(), to avoid affecting error handling
> > + * behavior.
> > + */
> > +#define mask_user_ptr(ptr)						\
> > +({									\
> > +	unsigned long _ptr = (__force unsigned long)ptr;		\
> > +	unsigned long mask;						\
> > +									\
> > +	asm volatile("cmp %[max], %[_ptr]\n\t"				\
> > +		     "sbb %[mask], %[mask]\n\t"				\
> > +		     : [mask] "=r" (mask)				\
> > +		     : [_ptr] "r" (_ptr),				\
> > +		       [max] "r" (TASK_SIZE_MAX)			\
> > +		     : "cc");						\
> > +									\
> > +	mask &= _ptr;							\
> > +	((typeof(ptr)) mask);						\
> > +})
> > +
> 
> access_ok() and mask_user_ptr() are doing much the same check.
> Is there scope for making access_ok() return the masked pointer?
> 
> So the canonical calling code would be:
> 	uptr = access_ok(uptr, size);
> 	if (!uptr)
> 		return -EFAULT;
> 
> This would error requests for address 0 earlier - but I don't
> believe they are ever valid in Linux.
> (Some historic x86 a.out formats did load to address 0.)
> 
> Clearly for a follow up patch.

Yeah.  I mentioned a similar idea in the cover letter.

But I'm thinking we should still rename it to access_ok_mask(), or
otherwise change the API to avoid the masked value getting ignored.

But that'll be a much bigger patch.

-- 
Josh

