Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3280844B473
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 22:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244903AbhKIVKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 16:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237576AbhKIVKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 16:10:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F20C061764;
        Tue,  9 Nov 2021 13:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tFaeIRYf4WcX3eLn8IfO976cgyYPtEx7VfB2So48QdA=; b=DxHU78GLXR59U9kZeDDIUeJmWn
        xF/G+XNLMP3qDVaTBHPeajbM65d8DzpAEGOY2r0jB1ayb8NZf8Nn6XRxZUd7DjRWt6iZ54xoeHv/w
        Ec45heQ+JWtpIzyNT4ArcAlbsw5gB5I3QbN4v3oMeAPBAi1+zaNMNvcX1lev0DnOZIuQhSNWct6ez
        UCZoLnCT4tEMNTySiNssJ91zshw7/4BPVUiJytlA9sei693R64BIHqVLSXwvRx2+gl9NfemAJZBfK
        cw6V+R7xGo0mxrZBOwHDjqd8yZbt4dB3VFDTRJ1BtAB1w7xlEPVVW7RxOvMYlpyr0etu6GtW/K6d1
        0p9LBiQA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkYLA-001LQV-Tr; Tue, 09 Nov 2021 21:07:37 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 35546985A2A; Tue,  9 Nov 2021 22:07:36 +0100 (CET)
Date:   Tue, 9 Nov 2021 22:07:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Bill Wendling <morbo@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, seanjc@google.com, pbonzini@redhat.com,
        mbenes@suse.cz, llvm@lists.linux.dev,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH 20/22] x86,word-at-a-time: Remove .fixup usage
Message-ID: <20211109210736.GV174703@worktop.programming.kicks-ass.net>
References: <20211105171023.989862879@infradead.org>
 <20211105171821.654356149@infradead.org>
 <20211108164711.mr2cqdcvedin2lvx@treble>
 <YYlshkTmf5zdvf1Q@hirez.programming.kicks-ass.net>
 <CAKwvOdkFZ4PSN0GGmKMmoCrcp7_VVNjau_b0sNRm3MuqVi8yow@mail.gmail.com>
 <YYov8SVHk/ZpFsUn@hirez.programming.kicks-ass.net>
 <CAKwvOdn8yrRopXyfd299=SwZS9TAPfPj4apYgdCnzPb20knhbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdn8yrRopXyfd299=SwZS9TAPfPj4apYgdCnzPb20knhbg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 11:22:44AM -0800, Nick Desaulniers wrote:

> I think the use of this feature (label-attributes) here isn't
> necessary though; because of the use of outputs, the "fallthrough"
> basic block needs to be placed immediately after the basic block
> terminated by the asm goto, at least in LLVM.  Was different ordering
> of basic blocks observed with GCC without this label attribute?

GCC does the same, but I wanted to have the exception stuff be in
.text.cold, but alas it doesn't do that. I left the attribute because of
it's descriptive value.

>  Unless the cold attribute is helping move
> ("shrink-wrap"?) the basic block to a whole other section
> (.text.cold.)?

I was hoping it would do that, but it doesn't on gcc-11.
