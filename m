Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72F7320784
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 23:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhBTWdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 17:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhBTWdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 17:33:09 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE5BC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 14:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HMTI1GJYGD0GJRodu4+13cndPWkJlvKX4R4GkQYGjaw=; b=uq7APCrAhHeXdpKZ2TAgEC0VzG
        a+dMX/XgXT/muyHioBjKB4J5wJyxP5eoH4tNyX0FIEGAS+5xJaeRNac7UGh5I4KMWq3aIMnpveTYh
        KyzouLvJg7ekNWw0/VnM39eL4oqhAzyYErDy1NPEFlAHtTI+1rPCSPxA7fB5Jm5c1N3yN2dDdzkE0
        S03DOwO3YpfnddI7NxaOPZ2HI3F5ttZSxJzGLYAqJgm7ozSGUg6w2XeWmdtcBeeZK+Mmc9jlrfXzD
        QCq+hVCSdGEHMTH8mAoOscOUKxnPhpgbz9T2SKiaUgyvdy2ucROEkUkflzo45rdmJhKfy7gIVvQMo
        3QIEh3Zw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lDanX-0002Cx-9Z; Sat, 20 Feb 2021 22:32:23 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A25F9864D6; Sat, 20 Feb 2021 23:32:21 +0100 (CET)
Date:   Sat, 20 Feb 2021 23:32:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        pjt@google.com, mbenes@suze.cz, jgross@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 6/6] objtool,x86: Rewrite retpoline thunk calls
Message-ID: <20210220223221.GB4746@worktop.programming.kicks-ass.net>
References: <20210219204300.749932493@infradead.org>
 <20210219210535.492733466@infradead.org>
 <20210219215530.ivzzv3oavhuip6un@treble>
 <20210219220158.GD59023@worktop.programming.kicks-ass.net>
 <20210220003920.GG26778@zn.tnic>
 <YDE9bmaO4tOZ/HWn@hirez.programming.kicks-ass.net>
 <20210220174101.GA29905@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210220174101.GA29905@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 06:41:01PM +0100, Borislav Petkov wrote:
> >  - if we had negative alternatives objtool doesn't need to actually
> >    rewrite code in this case. It could simply emit alternative entries
> >    and call it a day.
> 
> I don't mind the negative alt per se - I mind the implementation I saw.
> I'm sure we can come up with something nicer, like, for example, struct
> alt_instr.flags to denote that this feature is a NOT feature. 

So you don't like the ~ or - on cpuid? ISTR we talked about
alt_instr::flags before, but Google isn't playing ball today so I can't
seem to find it.

I can certainly look at adding the flags thing.
