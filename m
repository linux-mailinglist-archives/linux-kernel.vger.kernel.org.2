Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6130345CB55
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 18:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349829AbhKXRpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 12:45:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56084 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243479AbhKXRp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 12:45:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637775739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=izYL/FQ2z7YLasw10KZFgXFc7Wmsk5GHBcxx7ULv/IU=;
        b=a8lhy+VtLw+2GnZQ7mw/ecSfRhwGxktu9nwcEFIo9tZ3VR+W3NRmZsvqgRRLzRelvumMmq
        2MRE8j90PTr7ziGEUMFFY1MVZYAuY6sqfnkTTfN2nwDgaInyFm+F4vUf9cBmapnAaqeEzg
        Y90VjBgsn1w/Vo5X902/SQewsoH0Fb0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-344-yro7IeCYOLCIOwihWFcPIQ-1; Wed, 24 Nov 2021 12:42:18 -0500
X-MC-Unique: yro7IeCYOLCIOwihWFcPIQ-1
Received: by mail-qt1-f199.google.com with SMTP id v19-20020ac85793000000b002b19184b2bfso2677419qta.14
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 09:42:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=izYL/FQ2z7YLasw10KZFgXFc7Wmsk5GHBcxx7ULv/IU=;
        b=E9pmWZxz2fpFcZ7WbVk/FJ33BE0dOCNHYghURjd6wCwhQwnS7QsS6VNfDt91FxFBj+
         58YQkQSavT8oOFyUXFVWkmZOPOUywcFceemcYFfZszDH2cbyh7nAAYzfxuE4exwR2lAf
         aetzVc/KZ4/Fq22UcIHjMCXClrCmwGBSKpBt7PUDriy/SqU0Un2+6hthUMNNlXhzmvsh
         tnvJ3QcSOy0TauFpATT9tArPLaKJljpcZaTFeA/GFxVHBgg0hIGE3WC6KYPejR5YT4br
         tI9PENfR0c1dS+Z34/6gT6Wh7jidhSORXN+UpFdqyH10dOzUB59mn2l5IPRoKUCWoJNX
         53xA==
X-Gm-Message-State: AOAM53397u2zzpcGIp87TSUkp3a+8JEITj45QM8qi0WDh1E2nMNNI+kY
        uLIxNy5UYcEGSoSmIWf2Uo50/TAnZvwuxrg5enfRnAZOUk7+3mRLNu2zpjJ/BT4r8vQHoUezi7V
        Xf4D9XHLFETYAHWNKaVEAkV9x
X-Received: by 2002:ac8:5acb:: with SMTP id d11mr9480979qtd.109.1637775737716;
        Wed, 24 Nov 2021 09:42:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwEk1ANv+XdmOXXh7xqRV6RKm7Oa+OWbJGtmCj1kiN5VP0aoRVqfKaRZ2d6egiSWtnPRlOdSw==
X-Received: by 2002:ac8:5acb:: with SMTP id d11mr9480924qtd.109.1637775737447;
        Wed, 24 Nov 2021 09:42:17 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id u18sm198553qki.69.2021.11.24.09.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 09:42:16 -0800 (PST)
Date:   Wed, 24 Nov 2021 09:42:13 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     David Laight <David.Laight@aculab.com>,
        'Peter Zijlstra' <peterz@infradead.org>,
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
Message-ID: <20211124174213.mspehbgomdqarxea@treble>
References: <YYlshkTmf5zdvf1Q@hirez.programming.kicks-ass.net>
 <CAKwvOdkFZ4PSN0GGmKMmoCrcp7_VVNjau_b0sNRm3MuqVi8yow@mail.gmail.com>
 <YYov8SVHk/ZpFsUn@hirez.programming.kicks-ass.net>
 <CAKwvOdn8yrRopXyfd299=SwZS9TAPfPj4apYgdCnzPb20knhbg@mail.gmail.com>
 <20211109210736.GV174703@worktop.programming.kicks-ass.net>
 <f6dbe42651e84278b44e44ed7d0ed74f@AcuMS.aculab.com>
 <YYuogZ+2Dnjyj1ge@hirez.programming.kicks-ass.net>
 <2734a37ebed2432291345aaa8d9fd47e@AcuMS.aculab.com>
 <20211112015003.pefl656m3zmir6ov@treble>
 <YZvXhAYjHrnc3/rv@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YZvXhAYjHrnc3/rv@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 06:46:44PM +0100, Petr Mladek wrote:
> On Thu 2021-11-11 17:50:03, Josh Poimboeuf wrote:
> > On Wed, Nov 10, 2021 at 12:20:47PM +0000, David Laight wrote:
> > > > > Wouldn't moving part of a function to .text.cold (or .text.unlikely)
> > > > > generate the same problems with the stack backtrace code as the
> > > > > .text.fixup section you are removing had??
> > > > 
> > > > GCC can already split a function into func and func.cold today (or
> > > > worse: func, func.isra.N, func.cold, func.isra.N.cold etc..).
> > > > 
> > > > I'm assuming reliable unwind and livepatch know how to deal with this.
> > > 
> > > They'll have 'proper' function labels at the top - so backtrace
> > > stands a chance.
> > > Indeed you (probably) want it to output "func.irsa.n.cold" rather
> > > than just "func" to help show which copy it is in.  > 
> > > I guess that livepatch will need separate patches for each
> > > version of the function - which might be 'interesting' if
> > > all the copies actually need patching at the same time.
> > > You'd certainly want a warning if there seemed to be multiple
> > > copies of the function.
> > 
> > Hm, I think there is actually a livepatch problem here.
> > 
> > If the .cold (aka "child") function actually had a fentry hook then we'd
> > be fine.  Then we could just patch both "parent" and "child" functions
> > at the same time.  We already have the ability to patch multiple
> > functions having dependent interface changes.
> > 
> > But there's no fentry hook in the child, so we can only patch the
> > parent.
> > 
> > If the child schedules out, and then the parent gets patched, things can
> > go off-script if the child later jumps back to the unpatched version of
> > the parent, and then for example the old parent tries to call another
> > patched function with a since-changed ABI.
> 
> This thread seems to be motivation for the patchset
> https://lore.kernel.org/all/20211119090327.12811-1-mbenes@suse.cz/
> I am trying to understand the problem here, first. And I am
> a bit lost.
> 
> How exactly is child called in the above scenario, please?
> How could parent get livepatched when child is sleeping?
> 
> I imagine it the following way:
> 
>     parent_func()
>        fentry
> 
>        /* some parent code */
>        jmp child
> 	   /* child code */
> 	   jmp back_to_parent
>        /* more parent code */
>        ret

Right.

> In the above example, parent_func() would be on stack and could not
> get livepatched even when the process is sleeping in the child code.
> 
> The livepatching is done via ftrace. Only code with fentry could be
> livepatched. And code called via fentry must be visible on stack.

How would parent_func() be on the stack?  If it jumps to the child then
it leaves no trace on the stack.

-- 
Josh

