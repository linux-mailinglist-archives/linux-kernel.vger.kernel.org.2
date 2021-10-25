Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4A3439ECE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 20:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbhJYTCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 15:02:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26508 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232144AbhJYTCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 15:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635188390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u4kru4s1e7GAOIDOmUaVKYjqsMWQYSUCOrzEgrrXdhU=;
        b=f2dKBSi95rjO01a5DpQ+9w071WIRB9pEA/lyCbjvkYo+zgwE+SmgF9VS+YVcyj4L2O+u3l
        l3VhoAQR0yEUy54JVFq2K+Vr0MxG0gStHwiWxxCV+A0rBID2a3bPmtWVY5QC5B37n86FW8
        zfzo1TfrtZYM4g6fRdSYrzWTS+g+I04=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-Nce26myTM1Wu38ir7M7Zgw-1; Mon, 25 Oct 2021 14:59:49 -0400
X-MC-Unique: Nce26myTM1Wu38ir7M7Zgw-1
Received: by mail-qk1-f197.google.com with SMTP id bl10-20020a05620a1a8a00b004624f465b6eso7907889qkb.22
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 11:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u4kru4s1e7GAOIDOmUaVKYjqsMWQYSUCOrzEgrrXdhU=;
        b=GHNWu4kxigEddI4KFuOjWbsvGcdxQggNQJEHen5ySVzTPjhLz2lL5q9++MuW1UK9X7
         93XpwU4flbWG3KDHzCwFd/bnD/wevqi2iorez4pV3uxD9vN/68Ocik+up3M4agK5EWZk
         8C2hHwZbwZhK3dB1NB7QT7mUNgiXqisxtNrPkGiFfo8WxL6b5+/PuA++c7iExRpBRxIO
         anyKIfKNh35RcyAaiL4saPouDOddGl/S7aXS0vKSP+LtjYZO8gYLry9ANKrfVqhMeqiS
         E1lncIQnxz36XlTbEjrJfL2uEE3IVaYSSFLU5i82rQFfZp0zN+7g8DwfyUSzRyLYNz2r
         P+aQ==
X-Gm-Message-State: AOAM532BR7G9hs9m2gZMtef8DB9xt7R4IQLRiWbFWV7b6HJ6kuTQd1JR
        5mlj+WdaYXAeN79PGKYGWBn9xXkYqbnstJwcHDCTERAta/6etR8rqI4kLKFEts/1M+6qA3gHmP+
        I1MufDTmeSEEJAt3yZrIwERpL
X-Received: by 2002:a05:622a:4d2:: with SMTP id q18mr19790075qtx.84.1635188388527;
        Mon, 25 Oct 2021 11:59:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKm0YX8u1rcHOL+P2hPWmc3GB11xYrFeECTLbJbQ9a8nAe1QmzFGsQrrMc79aYQ1nLIj++XA==
X-Received: by 2002:a05:622a:4d2:: with SMTP id q18mr19790050qtx.84.1635188388240;
        Mon, 25 Oct 2021 11:59:48 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id b71sm9096789qkg.131.2021.10.25.11.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 11:59:47 -0700 (PDT)
Date:   Mon, 25 Oct 2021 11:59:45 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Rob Landley <rob@landley.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: Commit 0d989ac2c90b broke my x86-64 build.
Message-ID: <20211025185945.ywcvhqypzoaxohyc@treble>
References: <53f767cd-9160-1015-d1b8-0230b5566574@landley.net>
 <CAK7LNAQFEi=4nky4nxRA8s+ODaf89Wa5kwDhe9dppKWX0UiFJA@mail.gmail.com>
 <20211024192742.uo62mbqb6hmhafjs@treble>
 <66ed460c-ac48-2b5a-e8e4-07613cf69ab0@landley.net>
 <YXZzIUqdWW9wwlpr@hirez.programming.kicks-ass.net>
 <20211025144656.fqqneysf72wwxp3m@treble>
 <YXbFpfJwXJXABDup@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YXbFpfJwXJXABDup@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 04:56:37PM +0200, Peter Zijlstra wrote:
> On Mon, Oct 25, 2021 at 07:46:56AM -0700, Josh Poimboeuf wrote:
> > On Mon, Oct 25, 2021 at 11:04:33AM +0200, Peter Zijlstra wrote:
> > > On Sun, Oct 24, 2021 at 09:51:45PM -0500, Rob Landley wrote:
> > > > > Unfortunately I think CONFIG_STACK_VALIDATION is no longer optional on
> > > > > x86-64 these days, because of static calls and retpolines.
> > > > 
> > > > Does it need stack validation, or just a frame unwinder?
> > > 
> > > static_calls rely on objtool to find all "call __SCT*" instructions and
> > > write their location in a .static_call_sites section.
> > > 
> > > The having of static calls is not optional on x86_64, and I have zero
> > > interest in trying to work out what not having static_call() does, or to
> > > maintain that option.
> > 
> > What I meant was, make STATIC_CALL_INLINE optional.  Then it would use
> > out-of-line static calls which should just work, no?
> 
> Yeah, I suppose so... I think we're then missing a STACK_VALIDATION
> dependency for KCOV. We rely on objtool to nop out those
> __sanitizer_cov_* calls.
> 
> I had really hoped to just make objtool an unconditional part of x86_64.

I was hoping the opposite ;-)  Not everybody wants the extra build
overhead, object size, complexity, warnings, etc.  And it should be
pretty easy to make it optional anyway.

Plus it's a good idea to make the dependencies more explicit.  We've
already been looking at modularizing, like creating a new CONFIG_OBJTOOL
option and splitting stack validation out from some of the other
features.  This could be a nice extension of that.

Which reminds me, I'm still thinking we need to make the interface more
easily combinable, like:

objtool run				\
	[--validate]			\
	[--noinstr]			\
	[--retpoline]			\
	[--orc]				\
	[--mcount]			\
	[--static-call]			\
	[--kcov]			\
	[--frame-pointer]		\
	[--vmlinux]			\
	[--uaccess]			\
	[--module]			\
	[--no-unreachable]		\
	[--backup]			\
	[--stats]			\
	[--backtrace]

objtool dump				\
	[--orc]				\
	[--mcount]			\
	[--static-call]			\
	[--alternatives]		\
	[--whatever]

I can hopefully get to it one of these weeks...

-- 
Josh

