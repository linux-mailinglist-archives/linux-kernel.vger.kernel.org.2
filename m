Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB564364A1A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 20:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241151AbhDSSvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 14:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhDSSvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 14:51:42 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1B7C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 11:51:12 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id r20so40586090ljk.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 11:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mvwuk72OV8nQxYdIe9d627zTpbWzXnBqVHooi1BCdcI=;
        b=ABIAZh0Yc6gK7Ft1wtnc4ohcPbNT4AIxM87QybtInWLGgYjHUnUzGJQO+0SQtmtF+P
         SJNEk+teRDbaI1T6wAN0fGq5AdHUpbsxHIxuCmNNPS1nc9teY9xfGzk1uG6n4KgcF6pi
         rwTMC5yQwaeCnKmG5juA/gDi6ahV1DltGgDNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mvwuk72OV8nQxYdIe9d627zTpbWzXnBqVHooi1BCdcI=;
        b=ody/gpIwG9p9Jz74llDQhUs5y7DALxtHibm0Ll+hQ1qqPUH43TYFikXNVbHMF7/Oxx
         NQ3hUrgDnc0znOq51MAX9oA8Oc80KCwe2kv7diZfdbggxKIisDA+1hCWRONoU71aVQmS
         DxbBkfU3Kiy/P5ox2xKO6qw5bmdpmfzKAD/l4DK9o16nPiNTSPOjZGTsj5PEbAVc3fqv
         f2mJlC4XzM+udRtssWni8gpcTtQccmhR12Ktmelr/yIhGLAbv5rnp9IiJGCfAxAzx/az
         qCe5i79mS1vzYd11JmytdtHNiUUp/O4HljYozxwNd4Dcp6d03Xqmb7UjZf0SUMcQCCwq
         frKA==
X-Gm-Message-State: AOAM532aVLGFK+I16VnR8CoLiPNZJuAdly+N27HD5qz8KMbe2c6Op6Fl
        QjENfYxM0MkUUme7N/glUxDo0KIGwXO5yMeg
X-Google-Smtp-Source: ABdhPJwXaPrzFiG0W2tdYfp6mItt6TwRTYVo3KCs6oIFaGoHG7YpevOSWTHhtNzIDWhrgEF9yurcVA==
X-Received: by 2002:a2e:7218:: with SMTP id n24mr12500473ljc.162.1618858269389;
        Mon, 19 Apr 2021 11:51:09 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id z2sm1221400ljz.116.2021.04.19.11.51.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 11:51:08 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id r22so29921281ljc.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 11:51:08 -0700 (PDT)
X-Received: by 2002:a05:651c:1117:: with SMTP id d23mr12844637ljo.220.1618858268248;
 Mon, 19 Apr 2021 11:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210414184604.23473-1-ojeda@kernel.org> <YHiMyE4E1ViDcVPi@hirez.programming.kicks-ass.net>
 <YHj02M3jMSweoP4l@google.com> <YHk4DZE1ZWTiBB1f@hirez.programming.kicks-ass.net>
 <aa6e44ab-e223-73aa-279e-8103732460ac@redhat.com> <YH0yCTgL0raKrmYg@hirez.programming.kicks-ass.net>
 <7287eac3-f492-bab1-9ea8-b89ceceed560@redhat.com> <YH0+0VQ1XC8+rv20@hirez.programming.kicks-ass.net>
 <3a874b15-5c21-9ed9-e5c3-995f915cba79@redhat.com> <YH1PGfC1qSjKB6Ho@hirez.programming.kicks-ass.net>
 <CAHk-=wjSrOcA0567rpn1PbYkGEgnw_sOmZ13JX87isrMq1dL-Q@mail.gmail.com> <ae079b78-1c26-ddb9-fb8f-83d27ba0c5a9@redhat.com>
In-Reply-To: <ae079b78-1c26-ddb9-fb8f-83d27ba0c5a9@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 19 Apr 2021 11:50:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiqX=uweoE+4hUTSLRsR87u2WAnYjmQtR1Zw0k0-cMocA@mail.gmail.com>
Message-ID: <CAHk-=wiqX=uweoE+4hUTSLRsR87u2WAnYjmQtR1Zw0k0-cMocA@mail.gmail.com>
Subject: Re: [PATCH 00/13] [RFC] Rust support
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Wedson Almeida Filho <wedsonaf@google.com>, ojeda@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 11:38 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> It changes it for the worse, in that access to fields that are shared
> across threads *must* either use atomic types

Well, we won't be using those broken types in the core kernel, so that
would all be entirely on the Rust side.

And I don't expect the Rust side to do a lot of non-locked accesses,
which presumably shouldn't need any of this anyway.

If Rust code ends up accessing actual real kernel data structures with
memory ordering, then that will be to types that do *not* follow the
useless C++ atomics, and that in turn presumably means that it will be
done as "unsafe" helpers that do what the LKMM does (ie READ_ONCE()
and all the rest of it).

                 Linus
