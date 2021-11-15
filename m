Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687EE451C7A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356753AbhKPASj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:18:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51308 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352288AbhKOXnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 18:43:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637019617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7HlFFpHLOnkuYOySwouZ7s09DUlv+hLAMcjMTeeobTQ=;
        b=NSrNpLg4WS+UiU/aoJsu+KJVoi0XarfBCdMXx52+q7uT9tkQ4CjBK3KZUU3POrPjlIFzcC
        s54yjB9qhBDUHhc8LBt6HffevW2CDBNJxKsA6Qr4QcVfCvH1Y7/jGqoG/qDlRCs492oDfs
        0inNyB7OU2Qnqm6PxgyQf9Z5oOLXCFs=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-v4uwbXbBMxmARzyyxxDo_Q-1; Mon, 15 Nov 2021 18:40:15 -0500
X-MC-Unique: v4uwbXbBMxmARzyyxxDo_Q-1
Received: by mail-ot1-f71.google.com with SMTP id a9-20020a056830008900b0056561b8c755so11111715oto.22
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 15:40:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7HlFFpHLOnkuYOySwouZ7s09DUlv+hLAMcjMTeeobTQ=;
        b=58yb4+otjxJOYBRiCpKsqM7r1uPu/6k0acWmbOyxonw6i5fyZwjEetUz340/sG8phR
         xECnJvQn6D6RpFjx4k4bN2BkfI/QHNqV57AcyDpCcDGox4Rx3Vd0ya9KD2QTgZ/7/z1Z
         Jfpn1F/idbZ7A8tybcLmUmXO+Kz7aZTHluMEPloyWudpyHhQEOaPklry4rS+h8zar5hI
         k0CcVBk1p7CP3o/Opf9y/T3jxrP/M3viTMemie3Mxjil31Jx4EG6VoPYUKhsHeNVIqk3
         7nUkjHegYI7HFuayyjkhyfxkhADKqqVLT4typA/1sXuuVPT2DCH7YpICkgMqwyPrFqjS
         Qt5g==
X-Gm-Message-State: AOAM5337qRHiLMC0OjpuQAgF3qMHokLpucVIrdaKIrThfHrP0VA8Tq5G
        8K00MXCwD8wrRXBrxWklUu3KAdK/CgYT+LhX37KHFAIfQQnVINfwwa0b9S+sixEFje7e+d0I0Y2
        7cHfAmxAPPKUVrKi91STj8hlZ
X-Received: by 2002:a05:6808:1802:: with SMTP id bh2mr2439561oib.142.1637019615032;
        Mon, 15 Nov 2021 15:40:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyAnEdzKPq9JP3nnZ3nNYQbcWfDg+gSGSyz459dA3eAqEL3e6U/qm4mcDqoW5PIR90cfpX6dA==
X-Received: by 2002:a05:6808:1802:: with SMTP id bh2mr2439540oib.142.1637019614874;
        Mon, 15 Nov 2021 15:40:14 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id j20sm2289939ota.76.2021.11.15.15.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 15:40:14 -0800 (PST)
Date:   Mon, 15 Nov 2021 15:40:11 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
        live-patching@vger.kernel.org
Subject: Re: [PATCH 20/22] x86,word-at-a-time: Remove .fixup usage
Message-ID: <20211115230327.m3zswzgrshotocju@treble>
References: <CAKwvOdn8yrRopXyfd299=SwZS9TAPfPj4apYgdCnzPb20knhbg@mail.gmail.com>
 <20211109210736.GV174703@worktop.programming.kicks-ass.net>
 <f6dbe42651e84278b44e44ed7d0ed74f@AcuMS.aculab.com>
 <YYuogZ+2Dnjyj1ge@hirez.programming.kicks-ass.net>
 <2734a37ebed2432291345aaa8d9fd47e@AcuMS.aculab.com>
 <20211112015003.pefl656m3zmir6ov@treble>
 <YY408BW0phe9I1/o@hirez.programming.kicks-ass.net>
 <20211113053500.jcnx5airbn7g763a@treble>
 <alpine.LSU.2.21.2111151325390.29981@pobox.suse.cz>
 <68b37450-d4bd-fa46-7bad-08d237e922b1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <68b37450-d4bd-fa46-7bad-08d237e922b1@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 08:01:13AM -0500, Joe Lawrence wrote:
> > This reminded me... one of the things I have on my todo list for a long 
> > time is to add an option for a live patch creator to specify functions 
> > which are not contained in the live patch but their presence on stacks 
> > should be checked for. It could save some space in the final live patch 
> > when one would add functions (callers) just because the consistency 
> > requires it.
> > 
> 
> Yea, I've used this technique once (adding a nop to a function so
> kpatch-build would detect and include in klp_funcs[]) to make a set of
> changes safer with respect to the consistency model.  Making it simpler
> to for the livepatch author to say, "I'm not changing foo(), but I don't
> want it doing anything while patching a task" sounds reasonable.
> 
> > I took as a convenience feature with a low priority and forgot about it. 
> > The problem above changes it. So should we take the opportunity and 
> > implement both in one step? I wanted to include a list of functions in 
> > on a patch level (klp_patch structure) and klp_check_stack() would just 
> > have more to check.
> > 
> 
> As far as I read the original problem, I think it would solve for that,
> too, so I would say go for it.

Sounds good to me.

Miroslav, do I understand correctly that you're volunteering to make
this change? ;-)

-- 
Josh

