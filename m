Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DF53F6ED2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 07:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbhHYFbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 01:31:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36389 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232321AbhHYFbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 01:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629869436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=APi59ojaXZbrr2Z3Z/wcTDIafsmLfmeiwWQFicVEKhk=;
        b=DZa+sc2vDUIJAg+ZYN7EDeqlYkFAA/hvm6/SHp9TFV/FhxLod2Oj4545okFIOZRrg3lzw7
        97jzkQCfFGO1tkH9yebBpQGidm7Gvy6MI61oe0aoOb3xLNePE1P1ik01pJoea5vNtQdle1
        jhm6jJJwekSwlGi+64qsYQlXQ3ALo60=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-l4oj9QpRP-mMs7Yjru9c-A-1; Wed, 25 Aug 2021 01:30:34 -0400
X-MC-Unique: l4oj9QpRP-mMs7Yjru9c-A-1
Received: by mail-qt1-f199.google.com with SMTP id f34-20020a05622a1a2200b0029c338949c1so2636876qtb.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 22:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=APi59ojaXZbrr2Z3Z/wcTDIafsmLfmeiwWQFicVEKhk=;
        b=VD3qXnzxGfvNNHac60yBNLX/lvcTH11qo+4oUV+mbYHUy/xi5eDOaVkxlQMVFj//rP
         vcycCEH+s4a1mBojy9kivtL/aH9JXvoo3tZKRTBM067C6Fl4Pxk55yY0R5q0t9FD1s2L
         nA3k0ySQ0AqKnq/3fI0HBiNvU1gFyTVZDiFiBxO/mAbpQ5GaHPclnVNlEYa83vC8Pl9N
         AczSkbMCugOkQ/1qyZ+u8lGil9M1rwa2aFnSiouDOwFE166KwU/9ZlzPnJxrtTTkWPD5
         auvfKNLUOQmzwzl0s9bYqhDaCpogjvzqVQQxVxK+YUzzz8i/gEzN4HFOdcMQtrga0Ish
         WTEQ==
X-Gm-Message-State: AOAM5319T1tiOpxTFn4YD62cQzUrzzrIdeK1LkcjbwhTdYEXoJm3+QIq
        u2wAAwrT6gYz1wNCvIEQWpClir/J83Cv6EiaIfj5rLmLf+IqRoCoq2//MwZMTsZNtJO7btkAnHJ
        oLCLCdI4WlZeO0hns8lWxbUlR
X-Received: by 2002:a05:620a:165a:: with SMTP id c26mr29211572qko.498.1629869434297;
        Tue, 24 Aug 2021 22:30:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMuMDEk2QlX00jEdPzFjBbSqgfb3KxV4isKSY1FNEWSj9eMIcGgf3PDVZE4GPL/fUUWoHSHA==
X-Received: by 2002:a05:620a:165a:: with SMTP id c26mr29211555qko.498.1629869434007;
        Tue, 24 Aug 2021 22:30:34 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::48])
        by smtp.gmail.com with ESMTPSA id u13sm2264634qki.38.2021.08.24.22.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 22:30:33 -0700 (PDT)
Date:   Tue, 24 Aug 2021 22:30:30 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux@googlegroups.com, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: objtool warning in cfg80211_edmg_chandef_valid() with ThinLTO
Message-ID: <20210825053030.kal3nk3ifaj55vtu@treble>
References: <5913cdf4-9c8e-38f8-8914-d3b8a3565d73@kernel.org>
 <20210824210507.GC17784@worktop.programming.kicks-ass.net>
 <dedde693-bf1d-a35b-e858-dab1f8f65246@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dedde693-bf1d-a35b-e858-dab1f8f65246@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 02:19:07PM -0700, Nathan Chancellor wrote:
> On 8/24/2021 2:05 PM, Peter Zijlstra wrote:
> > On Tue, Aug 24, 2021 at 01:08:58PM -0700, Nathan Chancellor wrote:
> > 
> > > The LLVM developers are under the impression that this is an issue with
> > > objtool; specifically quoting Eli Friedman:
> > > 
> > > "The backend can, in general, create basic blocks that don't contain any
> > > instructions, and don't fall through to another block. A jump table entry
> > > can refer to such a block. I guess certain tools could be confused by this.
> > > 
> > > If that's the issue, it should be possible to work around it using '-mllvm
> > > -trap-unreachable'."
> > 
> > So jump-tables are a weak point; ARM64 was having worse problems than
> > x86 there, they can't even locate them.
> > 
> > As to having a jump-table entry to an empty block and not falling
> > through; how are we supposed to know?
> 
> Fair enough. It does make me wonder why LLVM does that.
> 
> > Emitting them is a waste of space, so I'd say it's a compiler bug :-))
> 
> Isn't it always? :)
> 
> Turns out Nick brought up an issue very similar to this (unreachable
> conditions with switches) on LLVM's issue tracker
> (https://bugs.llvm.org/show_bug.cgi?id=50080) with the same workaround
> suggestion ('-mllvm -trap-unreachable') and there was no follow up after
> that so maybe that is one thing to look into once Nick is back online.
> 
> > It's been brought up before; but perhaps we should look at an 'informal'
> > ABI for jump-tables ?
> Not a bad idea, especially if this has come up before.

This is definitely needed.  Jump tables have always been a major thorn
in objtool's side.  I think I volunteered to write up a proposal for the
linux-toolchains list but I've just been waaay too busy.

-- 
Josh

