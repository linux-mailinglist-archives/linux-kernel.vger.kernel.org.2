Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AFC44DFFA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 02:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbhKLBxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 20:53:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35636 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234255AbhKLBw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 20:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636681809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eZNdJ52+fIq4HkyMiP9mgpiY14IZhLrguZdJAwnQXco=;
        b=S050znDXb7F/v9JTBVKU6Q+MCV9Pg95FHuq+ncqhQxJd8wHwrpZ3Vce1JFV6U1TLBgEOzW
        pVD2ptIiXlDTiEPRoVZsgFf8vHmz6EMK++9LrpedFUXK7dmXk/Ce0DssshCOcnSykOgVts
        VaxPJdY6TeQbRPBTYYnpic13sLuYp7E=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-7_UiJEpzMw--xkPUdlRZww-1; Thu, 11 Nov 2021 20:50:08 -0500
X-MC-Unique: 7_UiJEpzMw--xkPUdlRZww-1
Received: by mail-qt1-f200.google.com with SMTP id n7-20020a05622a11c700b002af8875b1d2so6070243qtk.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 17:50:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eZNdJ52+fIq4HkyMiP9mgpiY14IZhLrguZdJAwnQXco=;
        b=sQR6LNLWLIuw+j1e17GrU0eQQZKONKJxaM+Y/HALFHgzfrqBBL13DFjRWfbuQTPkch
         UHP9HMUJ5WGinASHNZ8q0QRM0VUMgKJZiuYd7t9/BlxgC5j2Arpxprn0gb0YVOTwqnUN
         cYsmUzB+gut+Zklv34WIk/j/bkEHycotiTPVLp9Ja2EuHmRPZwZOfq25+CHMevN5iOdN
         NHHX9GXII5plEAn1NDYjSTaEoFO3gJNDE33LfDvNbw/BGcF//ErmdyHZegArMO1J05BS
         XWmzZW+U/CSJec5p9Zp1s3iKNvloBGmDlpxMtlJM/b/83ZbXgzG+Oe8ajchrFLroBbQg
         hlHA==
X-Gm-Message-State: AOAM531quanlbNQqE/zTRN+dyXEzs1ufIGIKFxlq0IWtQsmknOPu/gKA
        07WRF0lCD+pIyljX8d/91KHkE4KyZpE/QdW7HvRGPXrxiR3V4oQZFHn/ZzfX9o23R/VpSsmd/n6
        kcvLW5nBO8NpmdG1RijzpTOhx
X-Received: by 2002:a0c:fec4:: with SMTP id z4mr11094625qvs.32.1636681807012;
        Thu, 11 Nov 2021 17:50:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2vRjCqTvnMrxcOB/YLyEnka+z0pWjiGa/K3Lw4rZIUmLTo7LhX5jGZ4nj8eAl72xtNIDgwQ==
X-Received: by 2002:a0c:fec4:: with SMTP id z4mr11094593qvs.32.1636681806757;
        Thu, 11 Nov 2021 17:50:06 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id x125sm2012210qkd.8.2021.11.11.17.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 17:50:06 -0800 (PST)
Date:   Thu, 11 Nov 2021 17:50:03 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Peter Zijlstra' <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
        live-patching@vger.kernel.org
Subject: Re: [PATCH 20/22] x86,word-at-a-time: Remove .fixup usage
Message-ID: <20211112015003.pefl656m3zmir6ov@treble>
References: <20211105171821.654356149@infradead.org>
 <20211108164711.mr2cqdcvedin2lvx@treble>
 <YYlshkTmf5zdvf1Q@hirez.programming.kicks-ass.net>
 <CAKwvOdkFZ4PSN0GGmKMmoCrcp7_VVNjau_b0sNRm3MuqVi8yow@mail.gmail.com>
 <YYov8SVHk/ZpFsUn@hirez.programming.kicks-ass.net>
 <CAKwvOdn8yrRopXyfd299=SwZS9TAPfPj4apYgdCnzPb20knhbg@mail.gmail.com>
 <20211109210736.GV174703@worktop.programming.kicks-ass.net>
 <f6dbe42651e84278b44e44ed7d0ed74f@AcuMS.aculab.com>
 <YYuogZ+2Dnjyj1ge@hirez.programming.kicks-ass.net>
 <2734a37ebed2432291345aaa8d9fd47e@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2734a37ebed2432291345aaa8d9fd47e@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 12:20:47PM +0000, David Laight wrote:
> > > Wouldn't moving part of a function to .text.cold (or .text.unlikely)
> > > generate the same problems with the stack backtrace code as the
> > > .text.fixup section you are removing had??
> > 
> > GCC can already split a function into func and func.cold today (or
> > worse: func, func.isra.N, func.cold, func.isra.N.cold etc..).
> > 
> > I'm assuming reliable unwind and livepatch know how to deal with this.
> 
> They'll have 'proper' function labels at the top - so backtrace
> stands a chance.
> Indeed you (probably) want it to output "func.irsa.n.cold" rather
> than just "func" to help show which copy it is in.  > 
> I guess that livepatch will need separate patches for each
> version of the function - which might be 'interesting' if
> all the copies actually need patching at the same time.
> You'd certainly want a warning if there seemed to be multiple
> copies of the function.

Hm, I think there is actually a livepatch problem here.

If the .cold (aka "child") function actually had a fentry hook then we'd
be fine.  Then we could just patch both "parent" and "child" functions
at the same time.  We already have the ability to patch multiple
functions having dependent interface changes.

But there's no fentry hook in the child, so we can only patch the
parent.

If the child schedules out, and then the parent gets patched, things can
go off-script if the child later jumps back to the unpatched version of
the parent, and then for example the old parent tries to call another
patched function with a since-changed ABI.

Granted, it's like three nested edge cases, so it may not be all that
likely to happen.

Some ideas to fix:

a) Add a field to 'klp_func' which allows the patch module to specify a
   function's .cold counterpart?

b) Detect such cold counterparts in klp_enable_patch()?  Presumably it
   would require searching kallsyms for "<func>.cold", which is somewhat
   problematic as there might be duplicates.

c) Update the reliable stacktrace code to mark the stack unreliable if
   it has a function with ".cold" in the name?

d) Don't patch functions with .cold counterparts? (Probably not a viable
   long-term solution, there are a ton of .cold functions because calls
   to printk are marked cold)

e) Disable .cold optimization?

f) Add fentry hooks to .cold functions?


I'm thinking a) seems do-able, and less disruptive / more precise than
most others, but it requires more due diligence on behalf of the patch
creation.  It sounds be pretty easy for kpatch-build to handle at least.

-- 
Josh

