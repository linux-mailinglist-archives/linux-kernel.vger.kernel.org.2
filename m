Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8783FE04D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 18:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344071AbhIAQsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 12:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhIAQse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 12:48:34 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05DBC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 09:47:37 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 7so262524pfl.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 09:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SdndLapjv5LLI+r4ct9MCxqBfsmBR7H3bxUJRnVikqY=;
        b=dOBBBVTa1DZoDUJneDk9k44TNY6OkY16SFNkp4fXbZJ85WgYPVg7JB5Imiv1DWwTV5
         f3dwrtsJ3F6XIqlZNtFLAG1dK0a6COKSA8ybbaVccnwyKgSaYrnlH6AgOWqHLTBQSFyn
         /u+Z+onhgYoUrg+jXBkwHYU10jg2ONbgFunRvSxLd048Wj7ucv4nf7TxY3XOpNN3+o25
         pfR88e7/msu/dJzRE9tHhBCY0jXnmQSm241aEBFRUAVPwB66geVmGNGXL7dGye6jUfJn
         GLtmarHe10RKzFv/pSU2ccZX9GihupbP6W0R0iAUYP9BDWWQNXIJlMc2oDnD8y1FYI32
         4o2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SdndLapjv5LLI+r4ct9MCxqBfsmBR7H3bxUJRnVikqY=;
        b=JeJnhxgDzDCn1pmjaXalWCsx6zvLROe9QJ2Z7umiuIV40VnlD5vEb4miIIFlColHLr
         V64VDO0EX8EA7Ikn+4GRECTq55Qnc+t7bERHbnmL9OujQYlQJI5IYJX7ntdiZkiBQhl/
         sSDBGWi8eNJoh2sY6PqupCUxFU7nluDfPSOJtFAhUHjzaAazokjSA6qA4gqNTfLXuC1U
         GPiyt3EP5Y58m4R6xknokbLqPY3LtJp08PJPmYLiIrGM/oBQLu4HuQKXC4Pb/M+DVtH8
         rjirWCDfJBRwKfZggCWlkt70IHBqZOIXLsDabOePjNiLaN9GQiEae5wIR3cYC97D/GwD
         qEoA==
X-Gm-Message-State: AOAM5304JL1axr6UGJV4nhJz9LqZb4+HNJg8t/9OGJGMlx2W1I+jJjAs
        Bc8pOjS+y/x0JER9pZF9rf0sug==
X-Google-Smtp-Source: ABdhPJzM6h7XNegbyAJ6khqh7exjDCV3dX8Es1EnZyIbn4kWQsszYnMHLy6RuuG0nIZQ3XbYka4LRQ==
X-Received: by 2002:a63:154d:: with SMTP id 13mr40488pgv.404.1630514857136;
        Wed, 01 Sep 2021 09:47:37 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id e5sm77010pjv.44.2021.09.01.09.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 09:47:36 -0700 (PDT)
Date:   Wed, 1 Sep 2021 16:47:32 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [patch 01/10] x86/fpu/signal: Clarify exception handling in
 restore_fpregs_from_user()
Message-ID: <YS+upEmTfpZub3s9@google.com>
References: <20210830154702.247681585@linutronix.de>
 <20210830162545.374070793@linutronix.de>
 <YS0ylo9nTHD9NiAp@zn.tnic>
 <87zgsyg0eg.ffs@tglx>
 <YS1HXyQu2mvMzbL/@zeniv-ca.linux.org.uk>
 <CAHk-=wgbeNyFV3pKh+hvh-ZON3UqQfkCWnfLYAXXA9cX2iqsyg@mail.gmail.com>
 <87r1e8cxp5.ffs@tglx>
 <87o89ccmyu.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o89ccmyu.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021, Thomas Gleixner wrote:
> On Wed, Sep 01 2021 at 14:00, Thomas Gleixner wrote:
> >
> > commit b2f9d678e28c ("x86/mce: Check for faults tagged in
> > EXTABLE_CLASS_FAULT exception table entries") made use of this in MCE to
> > allow in kernel recovery. The only thing it uses is checking the
> > exception handler type.
> >
> > Bah. I'll fix that up to make that less obscure.
> >
> > The remaining two use cases (SGX and FPU) make use of the stored trap
> > number.
> 
> Though while for the FPU use case we really want to handle the #MC case,
> it's not clear to me whether this is actually correct for SGX.
> 
> Jarkko, Sean, Dave?

Are you asking about #MC specifically, or about SGX consuming the trap number in
general?

For #MC, it's probably a moot point because #MC on ENCLS is not recoverable for
current hardware.  If #MC somehow occurs on ENCLS and doesn't kill the platform,
"handling" the #MC in SGX is probably wrong.  Note, Tony is working on a series to
support recoverable #MC on SGX stuff on future hardware[*], but I'm not sure that's
relevant to this discussion.

As for SGX consuming the trap number in general, it's correct.  For non-KVM usage,
it's nice to have but not strictly necessary.  Any fault except #PF on ENCLS is
guaranteed to be a kernel or hardware bug; SGX uses the trap number to WARN on a
!#PF exception, e.g. on #GP or #UD.  Not having the trap number would mean losing
those sanity checks, which have been useful in the past.

For virtualizing SGX, KVM needs the trap number so that it can inject the correct
exception into the guest, e.g. if the guest violates the ENCLS concurrency rules
it should get a #GP, whereas a EPCM violation should #PF.

[*] https://lore.kernel.org/lkml/20210827195543.1667168-1-tony.luck@intel.com
